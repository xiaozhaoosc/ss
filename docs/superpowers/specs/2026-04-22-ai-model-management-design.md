# AI 模型管理后台 V1 设计文档 (Spec)

**日期**: 2026-04-22
**状态**: 脑暴完成 / 设计评审中
**主题**: 实现系统管理员维度的 AI 供应商与模型管理 Dashboard。

---

## 1. 业务目标
为系统管理员提供一个统一的入口，用于配置 AI 供应商（API Key、Endpoint）、控制模型开关，并监控 AI 调用的计费支出。

---

## 2. 核心架构设计

### 2.1 设计模式
采用 **“以供应商为核心”** 的分层管理模式。
- **Level 1**: AI 供应商 (AiProvider) - 承载 API 密钥、接口地址等物理配置。
- **Level 2**: AI 模型 (AiModel) - 归属于供应商，定义具体模型代码、单价及可用状态。
- **Level 3**: 监控维度 (Stats) - 实时展示 Token 消耗与费用趋势。

### 2.2 数据模型对齐
- **后端模块**: `smallsteps-common-ai`
- **对应表**: 
    - `sys_ai_provider`: 存储供应商配置（apiKey, endpoint, type）。
    - `sys_ai_model`: 存储模型详情（model_code, cost_input, cost_output, status）。
    - `sys_ai_usage_log` (预期新增或聚合): 用于统计费用。

---

## 3. UI/UX 设计方案 (方案 A: 经典侧导模式)

### 3.1 页面布局
- **左侧列表 (Supplier Sidebar)**: 
    - 垂直卡片流，展示供应商名称、图标及实时状态。
    - 底部固定【+ 新增供应商】按钮。
- **右侧工作区 (Main Workspace)**:
    - **Header**: 当前供应商的汇总数据看板（昨日费用、今日 Token、API 连通性测试）。
    - **Body Section 1 (Config)**: 表单视图，展示/编辑当前供应商的 API 配置。
    - **Body Section 2 (Model List)**: 嵌入式表格，管理该供应商下的所有模型。

### 3.2 交互逻辑
- **异步切换**: 点击左侧供应商，右侧区域进入 Skeleton 加载状态并异步拉取详情。
- **内联编辑**: 模型单价和开关支持在表格内直接操作，无需跳转。
- **监控集成**: 费用折线图支持按“供应商”过滤和“全局”汇总切换。

---

## 4. 技术栈
- **前端**: Vue 3 + Element Plus + Pinia (Ruoyi-Vue3 体系)。
- **图表**: ECharts (用于计费趋势图)。
- **后端 API**: 
    - `/ai/provider/**` (CRUD)
    - `/ai/model/**` (CRUD)
    - `/ai/stats/billing` (聚合接口)

---

## 5. 待办与约束
- [ ] 补全 `sys_ai_usage_log` 的聚合统计 API。
- [ ] 设计模型开关的后端缓存刷新机制。
- [ ] 考虑敏感字段（API Key）的前端脱敏展示。

---

## 6. 验证准则 (Acceptance Criteria)
1. 管理员能成功新增供应商并配置 API Key。
2. 切换模型开关后，业务端调用该模型应立即响应（403 或 正常请求）。
3. 仪表盘能够正确计算并展示 Token 计费转换后的金额。
