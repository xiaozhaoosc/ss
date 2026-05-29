# 架构决策记录 (ADR-020): 全系统雪花长 ID 统一无损字符串化架构方案

*   **状态**: 获批并实施已部署 (Approved & Implemented)
*   **日期**: 2026-05-29
*   **关联实体**: [[_index_wiki]], [[CHRONICLE]], [[DEBT_LEADGER]]

---

## 1. 决策背景 (Context)

在 Small Steps ADHD 生态系统中，后台使用 Twitter Snowflake 算法生成 19 位的全局唯一大整数 ID 作为主外键。这些 ID 在 Java 实体层体现为 `Long` 类型。
在进行家长端和儿童端数据联调时，出现两大灾难性 Bug：
1.  **创建儿童档案列表为空**：调用 `/ss/child/list?parentId=...` 接口查不出刚创建的孩子，导致家长中心列表显示“暂无孩子档案”。
2.  **雷达图 & 资料编辑报错 500**：点击雷达图渲染时报错 `500` `"msg": "无权访问该儿童数据"`。

### 根源分析
由于 JavaScript 的原生 `Number` 类型遵循 IEEE 754 双精度浮点规范，仅能保证在 `9007199254740991`（16位）以内的大整数精确度（即 `Number.MAX_SAFE_INTEGER`）。
当 19 位的雪花 ID（如 `2059933262075191297`）下发给浏览器前端后，在 JSON 自动解析时，被强制截断四舍五入为 `2059933262075191300`。
*   这导致前端调用 `/list` 接口时把错误且丢失精度的 `parentId` 发给后端，后端在 SQL 比对时无法匹配到原先正确绑定的记录，造成“列表为空”。
*   前端在列表为空时，触发了不良的 Fallback 降级，错误地将精度丢失的家长 ID 缓存并传递给雷达图等接口，被后端的 `checkChildAccess` 安全鉴权过滤器拦截并抛出越权报错 `500`。

---

## 2. 方案对比与决策 (Alternatives & Decision)

针对在 API、APP 和 Web 端彻底统一处理该问题的需求，我们进行了以下技术方案对比：

| 方案 | 修改成本 | 数据库与模型影响 | 安全性与鲁棒性 | 统一性评级 |
| :--- | :--- | :--- | :--- | :--- |
| **方案 A: 局部实体类注解** | 极低 | 零影响，只修改几个 VO 字段 | 极低，易漏掉其它模块 API，留下死角 | ❌ 不推荐 |
| **方案 B: 业务模型全量 Long 改 String** | 极高 (灾难性) | 数据库索引恶化，存储翻倍，成百上千个类需改写 | 中，虽然安全但破坏性极大 | ❌ 不推荐 |
| **方案 C: 全局数据交换边界 Jackson 拦截** | **极低 (优雅防卫)** | **零影响，维持原生 Long 最佳性能** | **极高，全系统 100% 自动覆盖，无任何死角** | **🏆 终极推荐 (方案C)** |

### 架构决策
我们最终选定并实施了 **方案 C：出参全局字符串化，入参智能类型自动还原**。
我们将隐患完美锁死在“前后端数据交换的 JSON 边界处”，实现了前端把 ID 当成普通的 String 任意流通，后端维持 100% 正统 Long 快速运算与索引，对业务代码具有零侵入性。

---

## 3. 具体实施细节 (Implementation Details)

### 3.1 出参序列化控制 (API -> Front)
在 `smallsteps-common-json` 基础包的 `JacksonConfig.java` 顶层配置中，我们在全局 Customizer 中显式绑定了大数值序列化处理器：
```java
    @Bean
    public Jackson2ObjectMapperBuilderCustomizer customizer() {
        return builder -> {
            builder.timeZone(TimeZone.getDefault());
            builder.serializerByType(Long.class, BigNumberSerializer.INSTANCE);
            builder.serializerByType(Long.TYPE, BigNumberSerializer.INSTANCE);
            builder.serializerByType(BigInteger.class, BigNumberSerializer.INSTANCE);
            builder.serializerByType(BigDecimal.class, ToStringSerializer.instance);
            log.info("初始化 jackson 配置");
        };
    }
```
这保证了 API 响应中所有 Long / BigInteger 的主外键，只要数值超出 JS 安全整数限额，就会自动在 JSON 文本中包裹双引号（例如 `"userId": "2059933262075191297"`）。

### 3.2 入参反序列化绑定 (Front -> API)
*   **JSON 提交 (RequestBody)**: 当提交 `{"id": "2059933262075191297"}` 字符串时，Jackson 会自动将其智能反序列化并映射绑定为 Java 的 `Long id`。
*   **PathVariable & Param**: 所有的路径参数（如 `/ss/child/2059933262075191297`）和 Query 表单参数，Spring MVC 会在底层自动转型为 `Long` 字段接收。

### 3.3 核心业务层防卫 (Security Reinforce)
在 `ChildServiceImpl.java` 中，对儿童列表查询的 `parentId` 进行了防御式重写：
对于普通已登录家长（非超级管理员），无论前端传递的 `parentId` 出现任何丢失或越权污染，业务层一律**强制覆盖并重置**为当前登录人的真实 ID（`LoginHelper.getUserId()`），确保了全系统底层数据隔离机制的安全。

---

## 4. 架构影响 (Consequences)

1.  **极度整洁**：由于全局 Jackson 构建器拥有 100% 覆盖率，**我们完全移除了之前在 `SysUserVo.java` 与 `Child.java` 上临时手动添加的 `@JsonSerialize` 注解**，代码回归极简正统。
2.  **透明兼容**：APP、Web 和 API 实现了完全一致的 String ID 流通，无需在前端编写任何多余的特殊数字转型逻辑。
3.  **零侵入无感治理**：以最小的改动和成本，一站式解决并拦截了雪花 ID 在全系统的所有潜在隐患。
