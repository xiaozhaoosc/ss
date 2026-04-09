-- 为家长任务表添加家庭ID(部门ID)
ALTER TABLE ss_parent_task ADD COLUMN IF NOT EXISTS dept_id int8;
COMMENT ON COLUMN ss_parent_task.dept_id IS '家庭ID(部门ID)';

-- 为儿童任务执行日志表添加家庭ID(部门ID)
ALTER TABLE ss_task_log ADD COLUMN IF NOT EXISTS dept_id int8;
COMMENT ON COLUMN ss_task_log.dept_id IS '家庭ID(部门ID)';

-- 更新现有数据（可选，假设当前测试数据都归属于 ID 为 100 的根家庭）
-- UPDATE ss_parent_task SET dept_id = 100 WHERE dept_id IS NULL;
-- UPDATE ss_task_log SET dept_id = 100 WHERE dept_id IS NULL;
