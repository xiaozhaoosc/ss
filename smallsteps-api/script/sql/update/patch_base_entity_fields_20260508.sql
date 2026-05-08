-- 2026-05-08 补全所有核心业务表的 BaseEntity 审计字段
-- 解决 create_dept 不存在导致的 SQL 报错 (image.png)

-- 1. ss_task_template
ALTER TABLE ss_task_template ADD COLUMN IF NOT EXISTS create_dept int8 DEFAULT NULL;
ALTER TABLE ss_task_template ADD COLUMN IF NOT EXISTS create_by int8 DEFAULT NULL;
ALTER TABLE ss_task_template ADD COLUMN IF NOT EXISTS create_time timestamp DEFAULT NULL;
ALTER TABLE ss_task_template ADD COLUMN IF NOT EXISTS update_by int8 DEFAULT NULL;
ALTER TABLE ss_task_template ADD COLUMN IF NOT EXISTS update_time timestamp DEFAULT NULL;

-- 2. ss_task_log
ALTER TABLE ss_task_log ADD COLUMN IF NOT EXISTS create_dept int8 DEFAULT NULL;
ALTER TABLE ss_task_log ADD COLUMN IF NOT EXISTS create_by int8 DEFAULT NULL;
ALTER TABLE ss_task_log ADD COLUMN IF NOT EXISTS update_by int8 DEFAULT NULL;
ALTER TABLE ss_task_log ADD COLUMN IF NOT EXISTS update_time timestamp DEFAULT NULL;
ALTER TABLE ss_task_log ADD COLUMN IF NOT EXISTS del_flag char(1) DEFAULT '0';

-- 3. ss_star_record
ALTER TABLE ss_star_record ADD COLUMN IF NOT EXISTS create_dept int8 DEFAULT NULL;
ALTER TABLE ss_star_record ADD COLUMN IF NOT EXISTS create_by int8 DEFAULT NULL;
ALTER TABLE ss_star_record ADD COLUMN IF NOT EXISTS update_by int8 DEFAULT NULL;
ALTER TABLE ss_star_record ADD COLUMN IF NOT EXISTS update_time timestamp DEFAULT NULL;
ALTER TABLE ss_star_record ADD COLUMN IF NOT EXISTS del_flag char(1) DEFAULT '0';

-- 4. ss_game_item
ALTER TABLE ss_game_item ADD COLUMN IF NOT EXISTS create_dept int8 DEFAULT NULL;
ALTER TABLE ss_game_item ADD COLUMN IF NOT EXISTS update_by int8 DEFAULT NULL;
ALTER TABLE ss_game_item ADD COLUMN IF NOT EXISTS update_time timestamp DEFAULT NULL;
ALTER TABLE ss_game_item ADD COLUMN IF NOT EXISTS del_flag char(1) DEFAULT '0';

-- 5. ss_child_item
ALTER TABLE ss_child_item ADD COLUMN IF NOT EXISTS create_dept int8 DEFAULT NULL;
ALTER TABLE ss_child_item ADD COLUMN IF NOT EXISTS create_by int8 DEFAULT NULL;
ALTER TABLE ss_child_item ADD COLUMN IF NOT EXISTS create_time timestamp DEFAULT NULL;
ALTER TABLE ss_child_item ADD COLUMN IF NOT EXISTS update_by int8 DEFAULT NULL;
ALTER TABLE ss_child_item ADD COLUMN IF NOT EXISTS update_time timestamp DEFAULT NULL;
ALTER TABLE ss_child_item ADD COLUMN IF NOT EXISTS del_flag char(1) DEFAULT '0';

-- 6. ss_achievement
ALTER TABLE ss_achievement ADD COLUMN IF NOT EXISTS create_dept int8 DEFAULT NULL;
ALTER TABLE ss_achievement ADD COLUMN IF NOT EXISTS update_by int8 DEFAULT NULL;
ALTER TABLE ss_achievement ADD COLUMN IF NOT EXISTS update_time timestamp DEFAULT NULL;
ALTER TABLE ss_achievement ADD COLUMN IF NOT EXISTS del_flag char(1) DEFAULT '0';

-- 7. ss_task_preset
ALTER TABLE ss_task_preset ADD COLUMN IF NOT EXISTS create_dept int8 DEFAULT NULL;
ALTER TABLE ss_task_preset ADD COLUMN IF NOT EXISTS update_by int8 DEFAULT NULL;
ALTER TABLE ss_task_preset ADD COLUMN IF NOT EXISTS update_time timestamp DEFAULT NULL;
ALTER TABLE ss_task_preset ADD COLUMN IF NOT EXISTS del_flag char(1) DEFAULT '0';

-- 8. ss_knowledge_user_rel
ALTER TABLE ss_knowledge_user_rel ADD COLUMN IF NOT EXISTS create_dept int8 DEFAULT NULL;
ALTER TABLE ss_knowledge_user_rel ADD COLUMN IF NOT EXISTS create_by int8 DEFAULT NULL;
ALTER TABLE ss_knowledge_user_rel ADD COLUMN IF NOT EXISTS create_time timestamp DEFAULT NULL;
ALTER TABLE ss_knowledge_user_rel ADD COLUMN IF NOT EXISTS update_by int8 DEFAULT NULL;
ALTER TABLE ss_knowledge_user_rel ADD COLUMN IF NOT EXISTS update_time timestamp DEFAULT NULL;
ALTER TABLE ss_knowledge_user_rel ADD COLUMN IF NOT EXISTS del_flag char(1) DEFAULT '0';

-- 9. ss_level_config
ALTER TABLE ss_level_config ADD COLUMN IF NOT EXISTS create_dept int8 DEFAULT NULL;
ALTER TABLE ss_level_config ADD COLUMN IF NOT EXISTS update_by int8 DEFAULT NULL;
ALTER TABLE ss_level_config ADD COLUMN IF NOT EXISTS update_time timestamp DEFAULT NULL;
ALTER TABLE ss_level_config ADD COLUMN IF NOT EXISTS del_flag char(1) DEFAULT '0';

-- 10. ss_family_member
ALTER TABLE ss_family_member ADD COLUMN IF NOT EXISTS create_dept int8 DEFAULT NULL;
ALTER TABLE ss_family_member ADD COLUMN IF NOT EXISTS create_by int8 DEFAULT NULL;
ALTER TABLE ss_family_member ADD COLUMN IF NOT EXISTS update_by int8 DEFAULT NULL;
ALTER TABLE ss_family_member ADD COLUMN IF NOT EXISTS update_time timestamp DEFAULT NULL;
ALTER TABLE ss_family_member ADD COLUMN IF NOT EXISTS del_flag char(1) DEFAULT '0';

-- 11. ss_device_log
ALTER TABLE ss_device_log ADD COLUMN IF NOT EXISTS create_dept int8 DEFAULT NULL;
ALTER TABLE ss_device_log ADD COLUMN IF NOT EXISTS create_by int8 DEFAULT NULL;
ALTER TABLE ss_device_log ADD COLUMN IF NOT EXISTS update_by int8 DEFAULT NULL;
ALTER TABLE ss_device_log ADD COLUMN IF NOT EXISTS update_time timestamp DEFAULT NULL;
ALTER TABLE ss_device_log ADD COLUMN IF NOT EXISTS del_flag char(1) DEFAULT '0';

COMMENT ON COLUMN ss_task_template.create_dept IS '创建部门';
COMMENT ON COLUMN ss_task_log.create_dept IS '创建部门';
COMMENT ON COLUMN ss_star_record.create_dept IS '创建部门';
COMMENT ON COLUMN ss_game_item.create_dept IS '创建部门';
COMMENT ON COLUMN ss_child_item.create_dept IS '创建部门';
COMMENT ON COLUMN ss_achievement.create_dept IS '创建部门';
COMMENT ON COLUMN ss_task_preset.create_dept IS '创建部门';
COMMENT ON COLUMN ss_knowledge_user_rel.create_dept IS '创建部门';
COMMENT ON COLUMN ss_level_config.create_dept IS '创建部门';
COMMENT ON COLUMN ss_family_member.create_dept IS '创建部门';
COMMENT ON COLUMN ss_device_log.create_dept IS '创建部门';
