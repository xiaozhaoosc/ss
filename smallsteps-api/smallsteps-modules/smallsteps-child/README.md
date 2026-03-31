# SmallSteps Child Module (儿童端业务)

## 1. 模块简介
本模块 (`smallsteps-child`) 承载所有面向孩子的业务逻辑，设计原则为“认知卸载”与“正向激励”。

**核心功能**:
- **任务执行**: NFC 刷卡签到、语音反馈、灯光互动。
- **成就系统**: 收集勇气碎片、查看星星余额、兑换奖励。
- **AI 伴侣**: 与 "小步" (AI) 进行语音互动。

## 2. 包结构说明
```
com.kenzhao.smallsteps.child
├── controller      // Web API 接口
├── domain          // 实体类
├── mapper          // MyBatis Mapper 接口
├── service         // 业务逻辑层
└── remote          // 远程调用 (Feign Client)
```

## 3. 变更日志 (Changelog)

### [2026-02-01] 初始化
- 创建模块基础结构。
- 添加 `ChildHealthController` 健康检查接口。
