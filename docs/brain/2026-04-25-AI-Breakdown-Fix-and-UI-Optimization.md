# AI 拆解链路修复与 Pretext 布局优化 (2026-04-25)

## 1. 核心决策与问题解决 (Decisions & Fixes)

### 1.1 移动端 AI 拆解超时瓶颈 (Timeout Bottleneck)
- **现象**: 前端点击“AI 拆解”后 10s 准时报错 `request:fail timeout`。
- **定位**: 
    - `smallsteps-app/src/utils/request.js` 中硬编码了 `let timeout = 10000`。
    - `manifest.json` 缺少全局网络配置。
- **修复**:
    - **App 端**: 将超时提升至 60s，并在 `manifest.json` 中配置 `networkTimeout.request = 120000`。
    - **后端**: `SmartAiClient` 的 `ConnectTimeout` 设为 60s，`ReadTimeout` 设为 300s，确保高负载下不掉线。

### 1.2 Pretext 风格布局重构 (UI Optimization)
- **理念**: 遵循 [[Pretext-Layout-Engine]] 的“呼吸感”与“气泡化”逻辑。
- **实施**:
    - **气泡化组件**: `task-step` 升级为 20px 大圆角气泡，带 135deg 轻微渐变，增强 ADHD 友好度。
    - **消除重叠**: 解决底部按钮与自定义 TabBar 的 `fixed` 冲突，改用滚动容器内的 `footer-in-scroll` 布局。
    - **文案精简**: 将“发送给 StarBuddy”简化为“发布”，回归极简主义。

## 2. 关联笔记 (Related Notes)
- [[SmallSteps-AI-Architecture]] : 记录了 AI 服务链路的整体架构。
- [[System-Architecture]] : 整体系统说明。

## 3. 下一步行动 (Next Steps)
- [ ] 验证 `sys_ai_route` 在生产环境的指向稳定性。
- [ ] 观察家长对“发布”按钮点击率的反馈。
