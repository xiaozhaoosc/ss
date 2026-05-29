# 数据库 Schema (Small Steps)

## 1. 情绪与影子观察 (Emotion & Shadow Observer)

### ss_emotion_record (情绪记录表)
| 字段名 | 类型 | 描述 |
| :--- | :--- | :--- |
| id | bigint | 主键 |
| child_id | bigint | 孩子 ID |
| mood_level | int | 情绪等级 (1-5) |
| mood_type | varchar | 情绪类型 (frustrated, calm, happy, etc.) |
| description | varchar | 描述/备注 |
| is_read | char(1) | 家长是否已读 (0/1) |
| record_time | timestamp | 记录发生时间 |
| create_time | timestamp | 创建时间 |

### ss_parent_emotion_kit (家长端情绪急救包表)
| 字段名 | 类型 | 描述 |
| :--- | :--- | :--- |
| kit_id | bigint | 急救包主键 ID |
| child_id | bigint | 关联的孩子 ID |
| kit_name | varchar | 急救包名称 (对应场景描述 scenario) |
| emotion_type | int | 情绪类型 (1-开心, 2-难过, 3-愤怒, 4-焦虑, 5-平静) |
| content | text | 辅导策略内容 (对应策略 strategies) |
| status | int | 启用状态 (0-禁用, 1-启用) |
| create_by | varchar | 创建者 |
| create_time | timestamp | 创建时间 |
| update_by | varchar | 更新者 |
| update_time | timestamp | 更新时间 |

## 2. ADHD 任务模板 (Task Templates)

### ss_task_template (任务模板表)
| 字段名 | 类型 | 描述 |
| :--- | :--- | :--- |
| id | bigint | 主键 |
| title | varchar | 模板标题 (如：刷牙) |
| description | varchar | 模板描述 |
| category | varchar | 分类 (life, study, emotion) |
| difficulty | int | 难度系数 |
| prompt_level | int | 初始提示强度 |

### ss_task_step_template (任务步骤模板表)
| 字段名 | 类型 | 描述 |
| :--- | :--- | :--- |
| id | bigint | 主键 |
| template_id | bigint | 所属模板 ID |
| step_order | int | 步骤顺序 |
| content | varchar | 步骤内容 (动作描述) |
| visual_hint | varchar | 视觉提示图片 URL/图标 |

## 3. 帮助与反馈 (System Feedback)

### ss_system_feedback (系统反馈表)
| 字段名 | 类型 | 描述 |
| :--- | :--- | :--- |
| id | bigint | 主键 ID |
| user_id | bigint | 提交反馈的用户 ID |
| content | text | 反馈具体文本内容 |
| pics | text | 反馈图片路径，多图以逗号分隔 |
| contact | varchar | 用户填写的联系方式 |
| status | int | 处理状态 (0-未处理, 1-已处理) |
| handler_id | bigint | 处理管理员的用户 ID |
| remark | varchar | 处理备注信息 |
| handle_time | timestamp | 处理完成时间 |
| create_by | varchar | 创建者 |
| create_time | timestamp | 反馈创建时间 |
| update_by | varchar | 更新者 |
| update_time | timestamp | 状态更新时间 |

