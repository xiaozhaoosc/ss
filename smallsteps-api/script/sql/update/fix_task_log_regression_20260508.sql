-- 修复 ss_task_log 状态回归问题
UPDATE ss_task_log SET status = '1' WHERE status = '0';

-- 修复所有业务表的 del_flag 和审计字段，防止查询被拦截
UPDATE ss_task_log SET del_flag = '0' WHERE del_flag IS NULL;
UPDATE ss_task_log SET create_dept = -1 WHERE create_dept IS NULL;

-- 确保任务定义表也有正确的审计字段
UPDATE ss_task_template SET del_flag = '0' WHERE del_flag IS NULL;
UPDATE ss_task_template SET create_dept = -1 WHERE create_dept IS NULL;

-- 针对已有的任务记录，如果 child_id 对应的用户不存在部门，也要确保数据可见性
-- (在 RuoYi 的数据权限拦截器中，NULL 通常意味着不可见，除非特殊配置)
