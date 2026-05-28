-- 迁移 ss_task_log 表结构，添加 ChildTask 域所需的字段
-- 执行前请备份数据库

-- 添加缺失的列
ALTER TABLE ss_task_log ADD COLUMN IF NOT EXISTS dept_id INT8;
ALTER TABLE ss_task_log ADD COLUMN IF NOT EXISTS target_date DATE;
ALTER TABLE ss_task_log ADD COLUMN IF NOT EXISTS actual_duration INT4 DEFAULT 0;
ALTER TABLE ss_task_log ADD COLUMN IF NOT EXISTS start_time TIMESTAMP;
ALTER TABLE ss_task_log ADD COLUMN IF NOT EXISTS end_time TIMESTAMP;
ALTER TABLE ss_task_log ADD COLUMN IF NOT EXISTS del_flag CHAR(1) DEFAULT '0';
ALTER TABLE ss_task_log ADD COLUMN IF NOT EXISTS create_dept INT8;
ALTER TABLE ss_task_log ADD COLUMN IF NOT EXISTS create_by INT8;
ALTER TABLE ss_task_log ADD COLUMN IF NOT EXISTS update_by INT8;
ALTER TABLE ss_task_log ADD COLUMN IF NOT EXISTS update_time TIMESTAMP;

-- 添加字段注释
COMMENT ON COLUMN ss_task_log.dept_id IS '家庭ID(部门ID)';
COMMENT ON COLUMN ss_task_log.target_date IS '预定执行日期';
COMMENT ON COLUMN ss_task_log.actual_duration IS '实际专注时长(秒)';
COMMENT ON COLUMN ss_task_log.start_time IS '开始时间';
COMMENT ON COLUMN ss_task_log.end_time IS '完成时间';
COMMENT ON COLUMN ss_task_log.del_flag IS '删除标志(0代表存在 2代表删除)';
COMMENT ON COLUMN ss_task_log.create_dept IS '创建部门';

-- 将旧的 finish_time 数据迁移到 end_time
UPDATE ss_task_log SET end_time = finish_time WHERE end_time IS NULL AND finish_time IS NOT NULL;

-- 确保 del_flag 有默认值（现有记录）
UPDATE ss_task_log SET del_flag = '0' WHERE del_flag IS NULL;
