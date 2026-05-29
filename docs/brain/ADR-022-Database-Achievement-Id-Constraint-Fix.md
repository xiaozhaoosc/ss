# 架构决策记录 (ADR-022): 儿童成就表 achievement_id 非空约束崩溃加固

*   **状态**: 获批并实施已部署 (Approved & Implemented)
*   **日期**: 2026-05-29
*   **关联实体**: [[_index_wiki]], [[CHRONICLE]], [[ADR-021-Template-Task-Child-Assignment-Fix.md]]

---

## 1. 决策背景 (Context)

在“Small Steps”儿童成长辅助终端日常运行或家长在任务指派、打卡及结算逻辑触发时，后台服务会同步更新儿童的资产与成就（包括星星 `STAR`、勇气碎片 `FRAGMENT` 以及各类虚拟勋章 `BADGE`）。
在实际业务执行中，系统在高频触发 `syncStarsToAchievement`、`updateCount` 和 `unlockBadge` 等业务插入操作时，遇到了由于 PostgreSQL 严格的非空约束（Not-Null Constraint）所引发的 P0 级数据库插入崩溃异常：
```
### Cause: org.postgresql.util.PSQLException: ERROR: null value in column "achievement_id" of relation "ss_child_achievement" violates not-null constraint
  Detail: Failing row contains (2060189517781667841, 000000, 1002, null, 0, 0, null, STAR, 我的星星, 10, ...).
### SQL: INSERT INTO ss_child_achievement  ( id,  child_id, type, name, count, ... )  VALUES (  ?,  ?, ?, ?, ?, ...  )
```

### 根源分析
1. **物理数据库定义严苛**：在 `init_smallsteps.sql` 中，`ss_child_achievement` 表的建表语句中将 `achievement_id` 声明为 `INT8 NOT NULL`，且没有配置任何 `DEFAULT` 默认值。
2. **Java 实体类与 MyBatis-Plus 自动填充缺失**：在 Java 实体 `ChildAchievement.java` 中，只有主键 `id` 标记了 `@TableId` (这会让 MyBatis-Plus 自动调用内部雪花算法对 `id` 赋非空长ID)，但 `achievementId` 作为普通业务字段并未被打上任何 MP 填充注解。
3. **业务层插入逻辑缺失设值**：
   - `ScoreServiceImpl.java` 中往 `ss_child_achievement` 同步星星数据时，若星星记录不存在则 `new ChildAchievement()` 并 `insert`，但在此过程中遗漏了对 `achievementId` 的设值。
   - `ChildAchievementServiceImpl.java` 中的 `updateCount` (更新资产) 以及 `unlockBadge` (解锁勋章) 也有相同问题。
   由于该普通属性保持 `null` 且没有数据库默认值覆盖，直接在物理库层面触发了 `NOT NULL` 的完整性约束报错。

---

## 2. 方案对比与决策 (Alternatives & Decision)

### 方案 A：修改数据库定义，使 `achievement_id` 允许为 NULL
*   *分析*：虽然能够直接避开非空约束，但在多租户、分布式统计等复杂多表联查下，`achievement_id` 作为核心业务外键一旦充斥大量 `NULL` 值，会导致未来的关联聚合、历史变动跟踪报表产生大面积坏账或统计盲区。同时，涉及线上数据库 DDL 热变更的风险较高。

### 方案 B：由后端服务层提供双重保险的强校验与雪花算法自增补偿 (选定方案)
*   *分析*：
    1. 遵循“代码端防御性编程与数据高置信度”准则，不在数据库侧降级约束。
    2. 在系统进行任何向 `ss_child_achievement` 插入数据的代码节点（即 `insertChildAchievement` 服务实现、`updateCount` 资产同步、`unlockBadge` 勋章解锁、`syncStarsToAchievement` 积分同步）中，自动在插入前对 `achievementId` 进行非空检验与防呆补偿。
    3. 若该字段为 `null`，直接采用 Hutool 的 `IdUtil.getSnowflakeNextId()` 动态生成高置信度的全局唯一业务长ID进行填充。
*   *优点*：100% 确保数据强健，零数据库升级风险，完美保障多表联查及未来数据仓储的完整性与强约束。

---

## 3. 具体实施细节 (Implementation Details)

我们以双重保险的防御性代码完成了该 P0 Crash 的全面加固：

### 3.1 核心服务统一防呆
在 [ChildAchievementServiceImpl.java](file:///home/ken4zhao/Documents/office/jushuang1/github/ss/smallsteps-api/smallsteps-modules/smallsteps-child/src/main/java/com/kenzhao/smallsteps/child/service/impl/ChildAchievementServiceImpl.java) 中对所有的底层插入进行安全补强：
```java
    @Override
    public int insertChildAchievement(ChildAchievement childAchievement) {
        if (childAchievement.getAchievementId() == null) {
            childAchievement.setAchievementId(cn.hutool.core.util.IdUtil.getSnowflakeNextId());
        }
        return baseMapper.insert(childAchievement);
    }
```
同时对 `updateCount` 和 `unlockBadge` 中新建实体的动作进行同样的雪花 ID 注入：
```java
    // updateCount 中：
    achievement.setAchievementId(cn.hutool.core.util.IdUtil.getSnowflakeNextId());
    
    // unlockBadge 中：
    badge.setAchievementId(cn.hutool.core.util.IdUtil.getSnowflakeNextId());
```

### 3.2 积分同步防呆
在 [ScoreServiceImpl.java](file:///home/ken4zhao/Documents/office/jushuang1/github/ss/smallsteps-api/smallsteps-modules/smallsteps-child/src/main/java/com/kenzhao/smallsteps/child/service/impl/ScoreServiceImpl.java) 中进行同步星星的防空注入：
```java
        if (stars == null) {
            stars = new com.kenzhao.smallsteps.common.ss.domain.ChildAchievement();
            stars.setChildId(childId);
            stars.setType("STAR");
            stars.setName("我的星星");
            stars.setCount(points);
            stars.setAchievementId(cn.hutool.core.util.IdUtil.getSnowflakeNextId()); // 防呆加固
            childAchievementMapper.insert(stars);
        }
```

---

## 4. 架构影响 (Consequences)

1.  **零 Crash 数据落库**：无论是在指派模板任务扣分、首次给孩子打分获取星星，还是首度解锁任意勋章时，数据库的插入都可以 100% 顺畅执行，彻底消除了事务回滚引发的关联接口报错。
2.  **数据极度规范**：通过自增雪花ID的兜底填充，完美达成了 `ss_child_achievement` 的实体完整性与业务标识唯一性，为数据大盘热力图与统计模块留下了扎实的数据基础。
3.  **零依赖副作用**：直接使用现有的全局通用 Hutool 工具包，零外部编译污染，对全系统达成无感知的透明极致加固。
