# System Architecture (小步系统架构与生态)

> "A tripartite ecosystem for cognitive scaffolding."

"小步 (Small Steps)" 系统不仅是一个孤立的硬件或 App，而是一个包含三个闭环子系统的 **家庭干预网络**。

## 核心三引擎架构 (The Tripartite Engine)

### 1. The Anchor (硬件终端引擎)
- **定位**: 孩子的线下物理“锚点”。最核心的高频交互媒介。
- **技术栈**: ESP32-S3 微型设备 (模块 `smallsteps-esp32`)。
- **硬件约束**: 1.8寸非触摸屏 (128x160 RGB565)，4个物理按键，NFC读卡器，WS2812B 环形灯带，音频扬声器。
- **功能**: 执行 [[Device-Interaction-Flow]]，专注倒计时、物理反馈。

### 2. The Companion (移动端双模引擎)
- **定位**: 激励承载体（儿童）与配置流（家长）。
- **组件**: `smallsteps-app` / `smallsteps-ui`。
- **设计**: 双面设计 (Dual-UI Architecture)。
  - **儿童端**: 大按钮、高对比度、即时奖励，配合实体系统的成就感反馈。
  - **家长端**: 冷静的数据图表与配置中心，实现“教练式观察”。

### 3. The Brain (云端管理与数据大盘)
- **定位**: 管理、大数据监控、心理学提示词工程存储。
- **组件**: `smallsteps-api` 及配套 Admin 界面。
- **功能**:
  - 全局统计与状态追踪
  - ADHD 专属模型/提示词配置
  - **业务分离**: 在学术 V6 演示版本中，为了工程纯粹度，优先保证该 API/UI 层的高内聚，硬件端做脱钩或Mock处理。

## 近期架构决策 (ADR)
- **V6 学术剥离**: 在长篇学术论文写作期间，为确保聚焦点，已决定在系统设计章节重点突出纯软件侧实现（App、API 和 UI），而硬件传感器和 AI 模型部署则独立切分（或降级展示）。
- **容器化部署**: 采用 Docker Compose 编排 `docs/dockers/docker-compose.yml` 确立应用层一键拉起的基础架构。
