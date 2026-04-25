-- 为家长 ken2zhao 添加更多测试儿童数据
-- 家长ID: 2035392423676469250

-- 1. 确保家长存在（如果不存在则报错，或者我们可以手动确认）
-- SELECT * FROM sys_user WHERE user_id = 2035392423676469250;

-- 2. 插入儿童数据
INSERT INTO ss_child (
    id, tenant_id, parent_id, nickname, avatar_url, level, 
    gender, birthday, star_balance, total_stars, remark, create_time, del_flag
) VALUES (
    2047877554018242570, 'SS0001', 2035392423676469250, '小华', '/avatar/boy2.png', 1, 
    '0', '2020-06-15 00:00:00', 50, 100, '5岁 · 幼儿园大班', CURRENT_TIMESTAMP, '0'
) ON CONFLICT (id) DO UPDATE SET 
    nickname = EXCLUDED.nickname,
    remark = EXCLUDED.remark,
    birthday = EXCLUDED.birthday;

-- 3. 关联家庭成员表（如果业务逻辑需要）
INSERT INTO ss_family_member (id, child_id, user_id, role, create_time)
VALUES (2047877554018242571, 2047877554018242570, 2035392423676469250, 'father', CURRENT_TIMESTAMP)
ON CONFLICT (id) DO NOTHING;

-- 4. 验证数据
SELECT * FROM ss_child WHERE parent_id = 2035392423676469250;
