-- 为 ss_parent_task 表添加缺失的字段
ALTER TABLE ss_parent_task ADD COLUMN IF NOT EXISTS dept_id int8;
ALTER TABLE ss_parent_task ADD COLUMN IF NOT EXISTS parent_id int8;
ALTER TABLE ss_parent_task ADD COLUMN IF NOT EXISTS prompt_level int4 DEFAULT 1;
ALTER TABLE ss_parent_task ADD COLUMN IF NOT EXISTS cycle_type int4 DEFAULT 0;
ALTER TABLE ss_parent_task ADD COLUMN IF NOT EXISTS light_effect varchar(100) DEFAULT '';
ALTER TABLE ss_parent_task ADD COLUMN IF NOT EXISTS audio_effect varchar(100) DEFAULT '';
ALTER TABLE ss_parent_task ADD COLUMN IF NOT EXISTS deadline timestamp DEFAULT NULL;
ALTER TABLE ss_parent_task ADD COLUMN IF NOT EXISTS create_dept int8 DEFAULT NULL;

COMMENT ON COLUMN ss_parent_task.dept_id IS '家庭ID(部门ID)';
COMMENT ON COLUMN ss_parent_task.parent_id IS '父任务ID(用于任务拆解)';
COMMENT ON COLUMN ss_parent_task.prompt_level IS '支架强度/辅助强度(1-5)';
COMMENT ON COLUMN ss_parent_task.cycle_type IS '循环类型(0单次 1每日 2每周)';
COMMENT ON COLUMN ss_parent_task.light_effect IS '灯光效果代码';
COMMENT ON COLUMN ss_parent_task.audio_effect IS '音频索引代码';
COMMENT ON COLUMN ss_parent_task.deadline IS '截止时间';
COMMENT ON COLUMN ss_parent_task.create_dept IS '创建部门';
/common/upload 接口401，这个是公共接口不需要权限验证
-- 为其他继承 BaseEntity 的表添加 create_dept 字段
ALTER TABLE ss_parent_reward ADD COLUMN IF NOT EXISTS create_dept int8 DEFAULT NULL;
COMMENT ON COLUMN ss_parent_reward.create_dept IS '创建部门';

ALTER TABLE ss_parent_contract ADD COLUMN IF NOT EXISTS create_dept int8 DEFAULT NULL;
COMMENT ON COLUMN ss_parent_contract.create_dept IS '创建部门';

ALTER TABLE ss_parent_reward_redemption ADD COLUMN IF NOT EXISTS create_dept int8 DEFAULT NULL;
COMMENT ON COLUMN ss_parent_reward_redemption.create_dept IS '创建部门';

-- 为 ss_task_log (ChildTask) 添加缺失字段
ALTER TABLE ss_task_log ADD COLUMN IF NOT EXISTS dept_id int8 DEFAULT NULL;
ALTER TABLE ss_task_log ADD COLUMN IF NOT EXISTS target_date date DEFAULT NULL;
ALTER TABLE ss_task_log ADD COLUMN IF NOT EXISTS actual_duration int4 DEFAULT 0;
ALTER TABLE ss_task_log ADD COLUMN IF NOT EXISTS start_time timestamp DEFAULT NULL;
ALTER TABLE ss_task_log ADD COLUMN IF NOT EXISTS end_time timestamp DEFAULT NULL;
ALTER TABLE ss_task_log ADD COLUMN IF NOT EXISTS del_flag char(1) DEFAULT '0';
ALTER TABLE ss_task_log ADD COLUMN IF NOT EXISTS create_dept int8 DEFAULT NULL;
ALTER TABLE ss_task_log ADD COLUMN IF NOT EXISTS create_by int8 DEFAULT NULL;
ALTER TABLE ss_task_log ADD COLUMN IF NOT EXISTS update_by int8 DEFAULT NULL;
ALTER TABLE ss_task_log ADD COLUMN IF NOT EXISTS update_time timestamp DEFAULT NULL;

COMMENT ON COLUMN ss_task_log.dept_id IS '家庭ID(部门ID)';
COMMENT ON COLUMN ss_task_log.target_date IS '预定执行日期';
COMMENT ON COLUMN ss_task_log.actual_duration IS '实际专注时长(秒)';
COMMENT ON COLUMN ss_task_log.start_time IS '开始时间';
COMMENT ON COLUMN ss_task_log.end_time IS '完成时间';
COMMENT ON COLUMN ss_task_log.del_flag IS '删除标志(0代表存在 2代表删除)';
COMMENT ON COLUMN ss_task_log.create_dept IS '创建部门';
