# 技术债账本 (Technical Debt Ledger)

## 1. 权限风险
- [OSS-01] `/common/upload` 接口跳过了 `system:oss:upload` 权限校验，仅通过 `@SaCheckLogin` 鉴权。这是为了兼容儿童端（Child Role）上传任务凭证，但若未来该接口被滥用可能导致 OSS 资源被非预期填充。建议后期根据角色细化存储桶策略。

| 日期 | 模块 | 问题描述 | 优先级 | 影响 |
| :--- | :--- | :--- | :--- | :--- |
| 2026-04-30 | API / AI | `GET /ssapi/ai/log/list` 接口返回 404 | 高 | 已修复 (Mock实现以支持测试) |
| 2026-05-30 | App / Child | 儿童端角色装扮图片 (`lh3.googleusercontent.com`) 强依赖境外域名，国内常规测试与运行大概率超时加载失败 | 高 | 🟢 已修复 (装扮切图已本地化并以 `@keyframes hatBounce` 加载) |
