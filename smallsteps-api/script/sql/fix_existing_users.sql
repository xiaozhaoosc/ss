-- -------------------------------------------------------------------------------------------------------------------
-- Fix Existing Users without Roles (Small Steps)
-- Author: Antigravity
-- Date: 2026-03-21
-- -------------------------------------------------------------------------------------------------------------------

-- 为所有已注册但尚未分配角色的用户（排除 admin）批量分配“家长”角色 (Role ID: 10)
-- 这将修复由于 SysUserServiceImpl.java 中的 Bug 导致的历史遗留数据问题。

INSERT INTO sys_user_role (user_id, role_id)
SELECT u.user_id, 10
FROM sys_user u
LEFT JOIN sys_user_role ur ON u.user_id = ur.user_id
WHERE ur.user_id IS NULL 
  AND u.user_name NOT IN ('admin', 'ry');

-- 补齐缺失的部门ID为 200
UPDATE sys_user SET dept_id = 200 
WHERE (dept_id IS NULL OR dept_id = 0)
  AND user_name NOT IN ('admin', 'ry');

-- 验证更新结果
SELECT u.user_name, r.role_name 
FROM sys_user u
JOIN sys_user_role ur ON u.user_id = ur.user_id
JOIN sys_role r ON ur.role_id = r.role_id
WHERE r.role_id = 10;
