# ADR-013: ADHD 友好型新手引导系统设计 [[ADR-013-Onboarding-System-Design]]

## 上下文 (Context)
ADHD 儿童对复杂的 UI 容易产生认知过载。需要一种能够“强力吸引注意力”且“逐步引导”的方案。

## 决策 (Decision)
1. **聚光灯遮罩 (Spotlight)**: 使用 CSS `clip-path` 动态计算目标组件的位置，将屏幕其他部分变暗，强制视觉聚焦。
2. **AI 伙伴陪伴**: 在引导过程中引入 AI 角色对话框，以“伙伴”而非“监工”的口吻提供指导。
3. **即时成就感**: 引导结束时触发 `Confetti`（五彩纸屑）动画，建立正向反馈。
4. **状态持久化**: 在 LocalStorage 记录 `hasFinishedOnboarding`，确保仅在首次进入时触发。

## 影响 (Consequences)
- **正面**: 显著提升了新用户的激活率，降低了初次使用的焦虑感。
- **技术点**: 需要处理 `clip-path` 在响应式布局下的动态 resize 监听。
