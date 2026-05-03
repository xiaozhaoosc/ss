-- 2026-05-03 修复 create_dept 及其他 BaseEntity 字段缺失问题
-- 针对 ss_task_template 表
ALTER TABLE ss_task_template ADD COLUMN IF NOT EXISTS create_dept int8 DEFAULT NULL;
ALTER TABLE ss_task_template ADD COLUMN IF NOT EXISTS create_by int8 DEFAULT NULL;
ALTER TABLE ss_task_template ADD COLUMN IF NOT EXISTS create_time timestamp DEFAULT NULL;
ALTER TABLE ss_task_template ADD COLUMN IF NOT EXISTS update_by int8 DEFAULT NULL;
ALTER TABLE ss_task_template ADD COLUMN IF NOT EXISTS update_time timestamp DEFAULT NULL;

COMMENT ON COLUMN ss_task_template.create_dept IS '创建部门';
COMMENT ON COLUMN ss_task_template.create_by IS '创建者';
COMMENT ON COLUMN ss_task_template.create_time IS '创建时间';
COMMENT ON COLUMN ss_task_template.update_by IS '更新者';
COMMENT ON COLUMN ss_task_template.update_time IS '更新时间';

-- 审计其他 Small Steps 核心表
-- ss_game_item
ALTER TABLE ss_game_item ADD COLUMN IF NOT EXISTS create_dept int8 DEFAULT NULL;
ALTER TABLE ss_game_item ADD COLUMN IF NOT EXISTS update_by int8 DEFAULT NULL;
ALTER TABLE ss_game_item ADD COLUMN IF NOT EXISTS update_time timestamp DEFAULT NULL;
ALTER TABLE ss_game_item ADD COLUMN IF NOT EXISTS del_flag char(1) DEFAULT '0';

-- ss_achievement
ALTER TABLE ss_achievement ADD COLUMN IF NOT EXISTS create_dept int8 DEFAULT NULL;
ALTER TABLE ss_achievement ADD COLUMN IF NOT EXISTS update_by int8 DEFAULT NULL;
ALTER TABLE ss_achievement ADD COLUMN IF NOT EXISTS update_time timestamp DEFAULT NULL;
ALTER TABLE ss_achievement ADD COLUMN IF NOT EXISTS del_flag char(1) DEFAULT '0';

-- ss_task_preset
ALTER TABLE ss_task_preset ADD COLUMN IF NOT EXISTS create_dept int8 DEFAULT NULL;
ALTER TABLE ss_task_preset ADD COLUMN IF NOT EXISTS update_by int8 DEFAULT NULL;
ALTER TABLE ss_task_preset ADD COLUMN IF NOT EXISTS update_time timestamp DEFAULT NULL;
ALTER TABLE ss_task_preset ADD COLUMN IF NOT EXISTS del_flag char(1) DEFAULT '0';

-- ss_child_achievement
ALTER TABLE ss_child_achievement ADD COLUMN IF NOT EXISTS update_by int8 DEFAULT NULL;
ALTER TABLE ss_child_achievement ADD COLUMN IF NOT EXISTS update_time timestamp DEFAULT NULL;

-- ss_reward_exchange
ALTER TABLE ss_reward_exchange ADD COLUMN IF NOT EXISTS create_dept int8 DEFAULT NULL;
ALTER TABLE ss_reward_exchange ADD COLUMN IF NOT EXISTS create_by int8 DEFAULT NULL;
ALTER TABLE ss_reward_exchange ADD COLUMN IF NOT EXISTS create_time timestamp DEFAULT NULL;
ALTER TABLE ss_reward_exchange ADD COLUMN IF NOT EXISTS del_flag char(1) DEFAULT '0';

-- ss_star_record
ALTER TABLE ss_star_record ADD COLUMN IF NOT EXISTS create_dept int8 DEFAULT NULL;
ALTER TABLE ss_star_record ADD COLUMN IF NOT EXISTS create_by int8 DEFAULT NULL;
ALTER TABLE ss_star_record ADD COLUMN IF NOT EXISTS update_by int8 DEFAULT NULL;
ALTER TABLE ss_star_record ADD COLUMN IF NOT EXISTS update_time timestamp DEFAULT NULL;
ALTER TABLE ss_star_record ADD COLUMN IF NOT EXISTS del_flag char(1) DEFAULT '0';
