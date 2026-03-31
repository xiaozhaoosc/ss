# SmallSteps Parent Module (家长端业务)

## 1. 模块简介
本模块 (`smallsteps-parent`) 承载所有面向家长的业务逻辑，旨在帮助家长从“监督者”转型为“观察者”和“支持者”。

**核心功能**:
- **任务管理**: 发布任务、设定奖励、调整难度。
- **成长观察**: 查看孩子的情绪日报、能力雷达图。
- **辅助工具**: 亲子契约、情绪急救包配置。

## 2. 包结构说明
```
com.kenzhao.smallsteps.parent
├── controller      // Web API 接口
├── domain          // 实体类
├── mapper          // MyBatis Mapper 接口
├── service         // 业务逻辑层
└── remote          // 远程调用 (Feign Client)
```

## 3. 变更日志 (Changelog)

### [2026-02-01] 初始化
- 创建模块基础结构。
- 添加 `ParentHealthController` 健康检查接口。
