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
| id | bigint | 主键 ID |
| scenario | varchar | 适用情绪场景 |
| strategies | text | 心理辅导策略 |
| status | char(1) | 状态 (0正常 1停用) |
| del_flag | char(1) | 删除标志 (0代表存在 2代表删除) |
| create_by | varchar | 创建者 |
| create_time | timestamp | 创建时间 |
| update_by | varchar | 更新者 |
| update_time | timestamp | 更新时间 |
| remark | varchar | 备注 |

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
