# 数据库设计文档

## 1. 概述

### 1.1 文档目的
本文档详细描述 Small Steps 系统的数据库设计，包括数据库表结构、索引设计、数据迁移策略等，为开发人员提供明确的数据库实现指导。

### 1.2 数据库选型
- **数据库**：PostgreSQL
- **版本**：14.0+
- **存储引擎**：默认存储引擎
- **字符集**：UTF-8

## 2. 数据库表结构

### 2.1 用户相关表

#### 2.1.1 用户表 (`user`)
| 字段名 | 数据类型 | 约束 | 描述 |
|--------|----------|------|------|
| `id` | `BIGINT` | `PRIMARY KEY` | 用户 ID |
| `username` | `VARCHAR(50)` | `UNIQUE NOT NULL` | 用户名 |
| `password` | `VARCHAR(100)` | `NOT NULL` | 密码（加密存储） |
| `role` | `VARCHAR(20)` | `NOT NULL` | 角色 (parent/child/admin) |
| `nickname` | `VARCHAR(50)` | | 昵称 |
| `avatar` | `VARCHAR(255)` | | 头像 URL |
| `gender` | `VARCHAR(10)` | | 性别 |
| `age` | `INT` | | 年龄 |
| `email` | `VARCHAR(100)` | | 邮箱 |
| `phone` | `VARCHAR(20)` | | 电话 |
| `created_at` | `TIMESTAMP` | `DEFAULT CURRENT_TIMESTAMP` | 创建时间 |
| `updated_at` | `TIMESTAMP` | `DEFAULT CURRENT_TIMESTAMP` | 更新时间 |
| `last_login_at` | `TIMESTAMP` | | 最后登录时间 |

#### 2.1.2 家长-儿童关联表 (`parent_child`)
| 字段名 | 数据类型 | 约束 | 描述 |
|--------|----------|------|------|
| `id` | `BIGINT` | `PRIMARY KEY` | 关联 ID |
| `parent_id` | `BIGINT` | `REFERENCES user(id) ON DELETE CASCADE` | 家长 ID |
| `child_id` | `BIGINT` | `REFERENCES user(id) ON DELETE CASCADE` | 儿童 ID |
| `relationship` | `VARCHAR(50)` | | 关系（如：父亲、母亲） |
| `created_at` | `TIMESTAMP` | `DEFAULT CURRENT_TIMESTAMP` | 创建时间 |

### 2.2 任务相关表

#### 2.2.1 任务表 (`task`)
| 字段名 | 数据类型 | 约束 | 描述 |
|--------|----------|------|------|
| `id` | `BIGINT` | `PRIMARY KEY` | 任务 ID |
| `title` | `VARCHAR(100)` | `NOT NULL` | 任务标题 |
| `description` | `TEXT` | | 任务描述 |
| `creator_id` | `BIGINT` | `REFERENCES user(id)` | 创建者 ID |
| `child_id` | `BIGINT` | `REFERENCES user(id)` | 儿童 ID |
| `status` | `VARCHAR(20)` | `DEFAULT 'pending'` | 任务状态 (pending/in_progress/completed/failed) |
| `difficulty` | `INT` | `DEFAULT 1` | 任务难度 (1-5) |
| `reward_points` | `INT` | `DEFAULT 0` | 奖励积分 |
| `start_time` | `TIMESTAMP` | | 开始时间 |
| `end_time` | `TIMESTAMP` | | 结束时间 |
| `estimated_duration` | `INT` | | 预计时长（分钟） |
| `actual_duration` | `INT` | | 实际时长（分钟） |
| `created_at` | `TIMESTAMP` | `DEFAULT CURRENT_TIMESTAMP` | 创建时间 |
| `updated_at` | `TIMESTAMP` | `DEFAULT CURRENT_TIMESTAMP` | 更新时间 |

#### 2.2.2 任务步骤表 (`task_step`)
| 字段名 | 数据类型 | 约束 | 描述 |
|--------|----------|------|------|
| `id` | `BIGINT` | `PRIMARY KEY` | 步骤 ID |
| `task_id` | `BIGINT` | `REFERENCES task(id) ON DELETE CASCADE` | 任务 ID |
| `content` | `TEXT` | `NOT NULL` | 步骤内容 |
| `order` | `INT` | `NOT NULL` | 步骤顺序 |
| `duration` | `INT` | | 预计时长（分钟） |
| `status` | `VARCHAR(20)` | `DEFAULT 'pending'` | 步骤状态 (pending/completed) |
| `completed_at` | `TIMESTAMP` | | 完成时间 |
| `created_at` | `TIMESTAMP` | `DEFAULT CURRENT_TIMESTAMP` | 创建时间 |

#### 2.2.3 任务提醒表 (`task_reminder`)
| 字段名 | 数据类型 | 约束 | 描述 |
|--------|----------|------|------|
| `id` | `BIGINT` | `PRIMARY KEY` | 提醒 ID |
| `task_id` | `BIGINT` | `REFERENCES task(id) ON DELETE CASCADE` | 任务 ID |
| `reminder_time` | `TIMESTAMP` | `NOT NULL` | 提醒时间 |
| `status` | `VARCHAR(20)` | `DEFAULT 'pending'` | 提醒状态 (pending/sent) |
| `created_at` | `TIMESTAMP` | `DEFAULT CURRENT_TIMESTAMP` | 创建时间 |

### 2.3 奖励相关表

#### 2.3.1 奖励表 (`reward`)
| 字段名 | 数据类型 | 约束 | 描述 |
|--------|----------|------|------|
| `id` | `BIGINT` | `PRIMARY KEY` | 奖励 ID |
| `name` | `VARCHAR(100)` | `NOT NULL` | 奖励名称 |
| `description` | `TEXT` | | 奖励描述 |
| `points` | `INT` | `NOT NULL` | 所需积分 |
| `type` | `VARCHAR(20)` | `NOT NULL` | 奖励类型 (physical/virtual) |
| `icon` | `VARCHAR(255)` | | 奖励图标 URL |
| `stock` | `INT` | `DEFAULT -1` | 库存（-1 表示无限制） |
| `created_at` | `TIMESTAMP` | `DEFAULT CURRENT_TIMESTAMP` | 创建时间 |
| `updated_at` | `TIMESTAMP` | `DEFAULT CURRENT_TIMESTAMP` | 更新时间 |

#### 2.3.2 奖励兑换记录表 (`reward_exchange`)
| 字段名 | 数据类型 | 约束 | 描述 |
|--------|----------|------|------|
| `id` | `BIGINT` | `PRIMARY KEY` | 兑换记录 ID |
| `child_id` | `BIGINT` | `REFERENCES user(id)` | 儿童 ID |
| `reward_id` | `BIGINT` | `REFERENCES reward(id)` | 奖励 ID |
| `status` | `VARCHAR(20)` | `DEFAULT 'pending'` | 兑换状态 (pending/approved/completed/canceled) |
| `exchange_time` | `TIMESTAMP` | `DEFAULT CURRENT_TIMESTAMP` | 兑换时间 |
| `approved_at` | `TIMESTAMP` | | 批准时间 |
| `completed_at` | `TIMESTAMP` | | 完成时间 |
| `created_at` | `TIMESTAMP` | `DEFAULT CURRENT_TIMESTAMP` | 创建时间 |
| `updated_at` | `TIMESTAMP` | `DEFAULT CURRENT_TIMESTAMP` | 更新时间 |

#### 2.3.3 积分记录表 (`point_record`)
| 字段名 | 数据类型 | 约束 | 描述 |
|--------|----------|------|------|
| `id` | `BIGINT` | `PRIMARY KEY` | 记录 ID |
| `child_id` | `BIGINT` | `REFERENCES user(id)` | 儿童 ID |
| `type` | `VARCHAR(20)` | `NOT NULL` | 类型 (earn/spend) |
| `points` | `INT` | `NOT NULL` | 积分数量 |
| `reason` | `TEXT` | | 原因 |
| `related_id` | `BIGINT` | | 相关 ID（如任务 ID 或奖励 ID） |
| `created_at` | `TIMESTAMP` | `DEFAULT CURRENT_TIMESTAMP` | 创建时间 |

### 2.4 设备相关表

#### 2.4.1 设备表 (`device`)
| 字段名 | 数据类型 | 约束 | 描述 |
|--------|----------|------|------|
| `id` | `BIGINT` | `PRIMARY KEY` | 设备 ID |
| `device_id` | `VARCHAR(100)` | `UNIQUE NOT NULL` | 设备唯一标识 |
| `name` | `VARCHAR(100)` | `NOT NULL` | 设备名称 |
| `child_id` | `BIGINT` | `REFERENCES user(id)` | 绑定的儿童 ID |
| `status` | `VARCHAR(20)` | `DEFAULT 'offline'` | 设备状态 (online/offline) |
| `battery` | `INT` | `DEFAULT 100` | 电池电量 |
| `firmware_version` | `VARCHAR(20)` | | 固件版本 |
| `last_heartbeat` | `TIMESTAMP` | | 最后心跳时间 |
| `created_at` | `TIMESTAMP` | `DEFAULT CURRENT_TIMESTAMP` | 创建时间 |
| `updated_at` | `TIMESTAMP` | `DEFAULT CURRENT_TIMESTAMP` | 更新时间 |

#### 2.4.2 设备配置表 (`device_config`)
| 字段名 | 数据类型 | 约束 | 描述 |
|--------|----------|------|------|
| `id` | `BIGINT` | `PRIMARY KEY` | 配置 ID |
| `device_id` | `BIGINT` | `REFERENCES device(id) ON DELETE CASCADE` | 设备 ID |
| `key` | `VARCHAR(50)` | `NOT NULL` | 配置键 |
| `value` | `TEXT` | `NOT NULL` | 配置值 |
| `created_at` | `TIMESTAMP` | `DEFAULT CURRENT_TIMESTAMP` | 创建时间 |
| `updated_at` | `TIMESTAMP` | `DEFAULT CURRENT_TIMESTAMP` | 更新时间 |

### 2.5 情绪相关表

#### 2.5.1 情绪记录表 (`emotion_record`)
| 字段名 | 数据类型 | 约束 | 描述 |
|--------|----------|------|------|
| `id` | `BIGINT` | `PRIMARY KEY` | 记录 ID |
| `child_id` | `BIGINT` | `REFERENCES user(id)` | 儿童 ID |
| `emotion` | `VARCHAR(20)` | `NOT NULL` | 情绪类型 (happy/sad/angry/anxious/calm) |
| `intensity` | `INT` | `DEFAULT 1` | 情绪强度 (1-5) |
| `timestamp` | `TIMESTAMP` | `DEFAULT CURRENT_TIMESTAMP` | 记录时间 |
| `suggestion` | `TEXT` | | 干预建议 |
| `created_at` | `TIMESTAMP` | `DEFAULT CURRENT_TIMESTAMP` | 创建时间 |

#### 2.5.2 情绪分析表 (`emotion_analysis`)
| 字段名 | 数据类型 | 约束 | 描述 |
|--------|----------|------|------|
| `id` | `BIGINT` | `PRIMARY KEY` | 分析 ID |
| `child_id` | `BIGINT` | `REFERENCES user(id)` | 儿童 ID |
| `period` | `VARCHAR(20)` | `NOT NULL` | 分析周期 (day/week/month) |
| `start_date` | `DATE` | `NOT NULL` | 开始日期 |
| `end_date` | `DATE` | `NOT NULL` | 结束日期 |
| `emotion_distribution` | `JSONB` | | 情绪分布 |
| `average_intensity` | `NUMERIC(3,2)` | | 平均情绪强度 |
| `trend` | `VARCHAR(20)` | | 情绪趋势 (improving/stable/worsening) |
| `recommendations` | `TEXT` | | 建议 |
| `created_at` | `TIMESTAMP` | `DEFAULT CURRENT_TIMESTAMP` | 创建时间 |

### 2.6 成就相关表

#### 2.6.1 成就表 (`achievement`)
| 字段名 | 数据类型 | 约束 | 描述 |
|--------|----------|------|------|
| `id` | `BIGINT` | `PRIMARY KEY` | 成就 ID |
| `name` | `VARCHAR(100)` | `NOT NULL` | 成就名称 |
| `description` | `TEXT` | | 成就描述 |
| `icon` | `VARCHAR(255)` | | 成就图标 URL |
| `condition` | `TEXT` | `NOT NULL` | 解锁条件 |
| `points` | `INT` | `DEFAULT 0` | 奖励积分 |
| `created_at` | `TIMESTAMP` | `DEFAULT CURRENT_TIMESTAMP` | 创建时间 |

#### 2.6.2 儿童成就表 (`child_achievement`)
| 字段名 | 数据类型 | 约束 | 描述 |
|--------|----------|------|------|
| `id` | `BIGINT` | `PRIMARY KEY` | 记录 ID |
| `child_id` | `BIGINT` | `REFERENCES user(id) ON DELETE CASCADE` | 儿童 ID |
| `achievement_id` | `BIGINT` | `REFERENCES achievement(id) ON DELETE CASCADE` | 成就 ID |
| `unlocked_at` | `TIMESTAMP` | `DEFAULT CURRENT_TIMESTAMP` | 解锁时间 |
| `created_at` | `TIMESTAMP` | `DEFAULT CURRENT_TIMESTAMP` | 创建时间 |

### 2.7 系统相关表

#### 2.7.1 系统配置表 (`system_config`)
| 字段名 | 数据类型 | 约束 | 描述 |
|--------|----------|------|------|
| `id` | `BIGINT` | `PRIMARY KEY` | 配置 ID |
| `key` | `VARCHAR(50)` | `UNIQUE NOT NULL` | 配置键 |
| `value` | `TEXT` | `NOT NULL` | 配置值 |
| `description` | `TEXT` | | 配置描述 |
| `created_at` | `TIMESTAMP` | `DEFAULT CURRENT_TIMESTAMP` | 创建时间 |
| `updated_at` | `TIMESTAMP` | `DEFAULT CURRENT_TIMESTAMP` | 更新时间 |

#### 2.7.2 日志表 (`log`)
| 字段名 | 数据类型 | 约束 | 描述 |
|--------|----------|------|------|
| `id` | `BIGINT` | `PRIMARY KEY` | 日志 ID |
| `user_id` | `BIGINT` | `REFERENCES user(id)` | 用户 ID |
| `action` | `VARCHAR(100)` | `NOT NULL` | 操作 |
| `target_type` | `VARCHAR(50)` | | 目标类型 |
| `target_id` | `BIGINT` | | 目标 ID |
| `ip` | `VARCHAR(50)` | | IP 地址 |
| `user_agent` | `TEXT` | | 用户代理 |
| `details` | `JSONB` | | 详细信息 |
| `created_at` | `TIMESTAMP` | `DEFAULT CURRENT_TIMESTAMP` | 创建时间 |

## 3. 索引设计

### 3.1 用户表索引
- `idx_user_username`：`username` 唯一索引
- `idx_user_role`：`role` 索引
- `idx_user_last_login`：`last_login_at` 索引

### 3.2 任务表索引
- `idx_task_child_id`：`child_id` 索引
- `idx_task_status`：`status` 索引
- `idx_task_created_at`：`created_at` 索引
- `idx_task_start_end_time`：`start_time`, `end_time` 联合索引

### 3.3 任务步骤表索引
- `idx_task_step_task_id`：`task_id` 索引
- `idx_task_step_order`：`order` 索引
- `idx_task_step_status`：`status` 索引

### 3.4 奖励表索引
- `idx_reward_points`：`points` 索引
- `idx_reward_type`：`type` 索引

### 3.5 奖励兑换记录表索引
- `idx_reward_exchange_child_id`：`child_id` 索引
- `idx_reward_exchange_status`：`status` 索引
- `idx_reward_exchange_exchange_time`：`exchange_time` 索引

### 3.6 积分记录表索引
- `idx_point_record_child_id`：`child_id` 索引
- `idx_point_record_type`：`type` 索引
- `idx_point_record_created_at`：`created_at` 索引

### 3.7 设备表索引
- `idx_device_device_id`：`device_id` 唯一索引
- `idx_device_child_id`：`child_id` 索引
- `idx_device_status`：`status` 索引
- `idx_device_last_heartbeat`：`last_heartbeat` 索引

### 3.8 情绪记录表索引
- `idx_emotion_record_child_id`：`child_id` 索引
- `idx_emotion_record_timestamp`：`timestamp` 索引
- `idx_emotion_record_emotion`：`emotion` 索引

### 3.9 情绪分析表索引
- `idx_emotion_analysis_child_id`：`child_id` 索引
- `idx_emotion_analysis_period`：`period` 索引
- `idx_emotion_analysis_date_range`：`start_date`, `end_date` 联合索引

### 3.10 儿童成就表索引
- `idx_child_achievement_child_id`：`child_id` 索引
- `idx_child_achievement_unlocked_at`：`unlocked_at` 索引

## 4. 数据迁移策略

### 4.1 初始数据
- **用户数据**：初始化管理员账号
- **系统配置**：初始化系统默认配置
- **成就数据**：初始化默认成就
- **奖励数据**：初始化默认奖励

### 4.2 数据迁移工具
- **Flyway**：用于数据库版本管理和迁移
- **SQL 脚本**：用于初始数据导入

### 4.3 迁移步骤
1. 创建数据库和用户
2. 执行初始化 SQL 脚本
3. 执行 Flyway 迁移脚本
4. 导入初始数据

### 4.4 数据备份策略
- **定期备份**：每天自动备份数据库
- **增量备份**：每小时增量备份
- **灾难恢复**：定期测试备份恢复

## 5. 性能优化

### 5.1 查询优化
- **合理使用索引**：为常用查询字段创建索引
- **避免全表扫描**：使用 WHERE 子句限制查询范围
- **优化 JOIN 操作**：合理使用 JOIN 类型，避免笛卡尔积
- **使用分页**：对大数据集使用分页查询

### 5.2 存储优化
- **数据分区**：按时间对历史数据进行分区
- **表空间管理**：合理规划表空间
- **定期清理**：清理过期数据和无效数据

### 5.3 连接池优化
- **使用连接池**：配置合理的连接池大小
- **连接管理**：及时释放连接，避免连接泄露

## 6. 安全设计

### 6.1 数据安全
- **密码加密**：使用 BCrypt 加密存储密码
- **敏感数据加密**：对敏感数据进行加密存储
- **数据脱敏**：在查询结果中对敏感数据进行脱敏

### 6.2 访问控制
- **最小权限原则**：只授予必要的权限
- **角色权限管理**：基于角色的权限控制
- **数据行级权限**：确保用户只能访问自己的数据

### 6.3 防 SQL 注入
- **使用参数化查询**：避免直接拼接 SQL 语句
- **输入验证**：对用户输入进行验证和过滤
- **使用 ORM 框架**：使用 MyBatis 等 ORM 框架

## 7. 总结

本数据库设计文档详细描述了 Small Steps 系统的数据库表结构、索引设计、数据迁移策略、性能优化和安全设计。

通过合理的数据库设计，系统实现了以下功能：
- 用户管理和认证
- 任务管理和执行
- 奖励系统和积分管理
- 设备管理和通信
- 情绪分析和干预
- 成就系统

本设计文档为开发人员提供了明确的数据库实现指导，确保了系统的一致性和可靠性。同时，通过优化的索引设计和性能优化策略，系统具有良好的查询性能和可扩展性。

总之，本数据库设计文档为 Small Steps 系统的实现奠定了坚实的基础，确保了系统的数据完整性和安全性，为 ADHD 儿童的行为习惯养成提供了有力的数据支持。