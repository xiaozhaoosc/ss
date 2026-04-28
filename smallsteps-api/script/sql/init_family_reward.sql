-- -------------------------------------------------------------------------------------------------------------------
-- 家庭绑定关系建立与奖励数据注入脚本
-- 用于 Small Steps 项目的测试数据初始化
-- -------------------------------------------------------------------------------------------------------------------

-- ============================================
-- 第一步：建立家庭绑定关系
-- ============================================

-- 创建测试家庭部门（如果不存在）
INSERT INTO sys_dept (dept_id, parent_id, ancestors, dept_name, order_num, leader, phone, email, status, del_flag, create_time, update_time)
SELECT 200, 0, '0', '测试家庭', 1, '测试家长', '13800138000', 'test@example.com', '0', '0', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM sys_dept WHERE dept_id = 200);

-- 确保家长1 (ken2zhao) 关联到家庭部门
UPDATE sys_user 
SET dept_id = 200 
WHERE user_name = 'ken2zhao';

-- 确保家长2 (parent_zhang) 关联到家庭部门
UPDATE sys_user 
SET dept_id = 200 
WHERE user_name = 'parent_zhang';

-- 确保孩子1 (child_xiaoming) 关联到家庭部门
UPDATE sys_user 
SET dept_id = 200 
WHERE user_name = 'child_xiaoming';

-- 确保孩子2 (child_xiaohong) 关联到家庭部门
UPDATE sys_user 
SET dept_id = 200 
WHERE user_name = 'child_xiaohong';

-- 为家长用户分配家长角色 (role_id = 10)
INSERT INTO sys_user_role (user_id, role_id)
SELECT u.user_id, 10
FROM sys_user u
LEFT JOIN sys_user_role ur ON u.user_id = ur.user_id
WHERE ur.user_id IS NULL 
  AND u.user_name IN ('ken2zhao', 'parent_zhang');

-- 为孩子用户分配孩子角色 (role_id = 11)
INSERT INTO sys_user_role (user_id, role_id)
SELECT u.user_id, 11
FROM sys_user u
LEFT JOIN sys_user_role ur ON u.user_id = ur.user_id
WHERE ur.user_id IS NULL 
  AND u.user_name IN ('child_xiaoming', 'child_xiaohong');

-- ============================================
-- 第二步：注入奖励数据（确保奖励商店不为空）
-- ============================================

-- 获取家长用户ID
-- 家长1: ken2zhao
-- 家长2: parent_zhang

-- 先删除已存在的奖励数据（避免重复）
DELETE FROM ss_parent_reward 
WHERE user_id IN (
    SELECT user_id FROM sys_user WHERE user_name IN ('ken2zhao', 'parent_zhang')
);

-- 为家长1 (ken2zhao) 注入奖励数据
INSERT INTO ss_parent_reward (user_id, name, points_required, stock, icon, status, del_flag, create_time, update_time)
SELECT 
    u.user_id,
    reward.name,
    reward.points_required,
    reward.stock,
    reward.icon,
    '0',
    '0',
    NOW(),
    NOW()
FROM sys_user u
CROSS JOIN (
    VALUES 
        ('玩30分钟游戏', 20, -1, '🎮'),
        ('乐高积木一套', 100, 3, '🧱'),
        ('看一集奥特曼', 15, -1, '🦸'),
        ('额外半小时玩耍', 25, -1, '🏃'),
        ('冰淇淋一个', 10, 10, '🍦'),
        ('绘本一本', 50, 5, '📚'),
        ('周末游乐园', 200, 1, '🎡'),
        ('新玩具', 150, 2, '🚗')
) AS reward(name, points_required, stock, icon)
WHERE u.user_name = 'ken2zhao';

-- 为家长2 (parent_zhang) 注入奖励数据
INSERT INTO ss_parent_reward (user_id, name, points_required, stock, icon, status, del_flag, create_time, update_time)
SELECT 
    u.user_id,
    reward.name,
    reward.points_required,
    reward.stock,
    reward.icon,
    '0',
    '0',
    NOW(),
    NOW()
FROM sys_user u
CROSS JOIN (
    VALUES 
        ('看动画片', 15, -1, '📺'),
        ('糖果一颗', 5, 20, '🍬'),
        ('玩具汽车', 80, 2, '🚙'),
        ('故事书一本', 40, 5, '📖'),
        ('户外游玩', 60, -1, '🌳'),
        ('生日蛋糕', 300, 1, '🎂')
) AS reward(name, points_required, stock, icon)
WHERE u.user_name = 'parent_zhang';

-- ============================================
-- 验证数据
-- ============================================

-- 验证家庭绑定关系
SELECT 
    u.user_name, 
    d.dept_name, 
    r.role_name 
FROM sys_user u
JOIN sys_dept d ON u.dept_id = d.dept_id
JOIN sys_user_role ur ON u.user_id = ur.user_id
JOIN sys_role r ON ur.role_id = r.role_id
WHERE u.user_name IN ('ken2zhao', 'parent_zhang', 'child_xiaoming', 'child_xiaohong');

-- 验证奖励数据
SELECT 
    u.user_name, 
    r.name AS reward_name, 
    r.points_required, 
    r.stock, 
    r.icon 
FROM ss_parent_reward r
JOIN sys_user u ON r.user_id = u.user_id
WHERE u.user_name IN ('ken2zhao', 'parent_zhang');

-- ============================================
-- 输出结果
-- ============================================
SELECT '家庭绑定关系建立完成' AS result;
SELECT '奖励数据注入完成' AS result;