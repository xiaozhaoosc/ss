# ADHD行为习惯辅助系统 (小步) - 核心业务表 E-R 图

该 E-R 图基于论文中第三章的数据库设计（3.3.2 关键数据表结构设计）以及项目中实际的 PostgreSQL 表结构综合生成。

```mermaid
erDiagram
    %% 实体与关系
    sys_user ||--o{ sys_dept : "属于(dept_id)"
    sys_user ||--o{ ss_parent_child : "家长/儿童(parent_id/child_id)"
    sys_user ||--o{ ss_task : "创建(creator_id)"
    sys_user ||--o{ ss_task_log : "执行(child_id)"
    sys_user ||--o{ ss_emotion_log : "记录(child_id)"
    ss_task ||--o{ ss_task_log : "包含打卡日志(task_id)"
    ss_task ||--o{ ss_emotion_log : "关联情绪分析(task_id)"

    %% 表结构定义
    sys_user {
        BIGINT user_id PK "主键(雪花算法)"
        BIGINT dept_id FK "所属家庭/机构 ID"
        VARCHAR user_name "登录账号/用户名"
        VARCHAR password "Bcrypt加密Hash"
        TINYINT user_type "1:管理员, 2:家长, 3:儿童"
        VARCHAR nickname "显示简称或儿童名"
        INT coin_balance "账户代币余额"
        TINYINT status "0:正常, 1:停用"
    }

    sys_dept {
        BIGINT dept_id PK "部门/家庭 ID"
        BIGINT parent_id "父部门 ID"
        VARCHAR dept_name "家庭名称 (如: Leo的家)"
        VARCHAR leader "家庭管理员 (家长)"
    }

    ss_parent_child {
        BIGINT id PK "主键"
        BIGINT parent_id FK "家长用户 ID"
        BIGINT child_id FK "儿童用户 ID"
        DATETIME bind_time "绑定时间"
    }

    ss_task {
        BIGINT task_id PK "主键"
        BIGINT parent_id "父任务 ID(用于任务拆解)"
        BIGINT creator_id FK "创建者 ID"
        VARCHAR title "任务名称"
        TEXT content "任务指导语"
        INT prompt_level "辅助强度(1:全视频/图文, 5:自主)"
        INT reward_amount "激励金币值"
        TINYINT cycle_type "循环类型(0:单次, 1:每日, 2:每周)"
        CHAR status "状态(0:草稿, 1:启用, 2:废弃)"
    }

    ss_task_log {
        BIGINT log_id PK "主键"
        BIGINT task_id FK "关联任务定义 ID"
        BIGINT child_id FK "执行儿童 ID"
        DATE target_date "预定执行日期"
        INT actual_duration "实际专注时长(秒)"
        TINYINT status "0:待办, 1:进行中, 2:已完成, 3:放弃"
        DATETIME end_time "提交打卡时间"
    }

    ss_emotion_log {
        BIGINT log_id PK "主键"
        BIGINT task_id FK "关联任务定义 ID"
        BIGINT child_id FK "执行儿童 ID"
        DATE target_date "预定执行日期"
        INT actual_duration "实际专注时长(秒)"
        TINYINT status "0:待办, 1:进行中, 2:已完成, 3:放弃"
        DATETIME end_time "提交打卡时间"
    }
```

> **注：** 此 ER 图中的 `ss_emotion_log` 字段严格按照您论文中 **表 3.3.2.6** 的设计所绘制（其字段与任务执行日志一致）。但在实际项目工程的 PostgreSQL 脚本中（如 `ss_emotion_record` 表），通常会包含专门针对情绪评价的字段（如 `mood_level`, `mood_type`, `description` 等）。如果您需要在论文中修正此表的设计，建议将该表字段更新为针对情绪维度的度量。