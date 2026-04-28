-- -------------------------------------------------------------------------------------------------------------------
-- Small Steps E2E 测试数据稳定化脚本 (PostgreSQL)
-- 目的: 强制同步测试账号 ID、星星余额与奖励数据，确保 Playwright 测试 100% 通过
-- -------------------------------------------------------------------------------------------------------------------

BEGIN;

-- 1. 定义常量 ID (与 tests/fixtures/test-data.ts 保持一致)
-- 家长账号: ken2zhao
-- 儿童账号: child_xiaoming
DO $$
DECLARE
    p_id BIGINT := 2035392423676469250;
    c_id BIGINT := 10001;
    family_id BIGINT := 80001;
BEGIN

    -- 2. 同步 sys_user 表 (确保账号存在且 ID 固定)
    -- 处理 child_xiaoming
    DELETE FROM sys_user WHERE user_name = 'child_xiaoming' AND user_id <> c_id;
    INSERT INTO sys_user (user_id, tenant_id, dept_id, user_name, nick_name, user_type, password, status, del_flag, create_time)
    VALUES (c_id, '000000', 200, 'child_xiaoming', '张小明', 'sys_user', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', NOW())
    ON CONFLICT (user_id) DO UPDATE SET status = '0', del_flag = '0';

    -- 处理 ken2zhao (家长)
    DELETE FROM sys_user WHERE user_name = 'ken2zhao' AND user_id <> p_id;
    INSERT INTO sys_user (user_id, tenant_id, dept_id, user_name, nick_name, user_type, password, status, del_flag, create_time)
    VALUES (p_id, '000000', 200, 'ken2zhao', '家长管理员', 'sys_user', '$2a$10$BBY6uvIsgU3484/nFDJzx.z5wbSQHkY3kdKLqQGcJ.Vh7HZAEn5KO', '0', '0', NOW())
    ON CONFLICT (user_id) DO UPDATE SET status = '0', del_flag = '0';


    -- 3. 创建/更新儿童档案 (ss_child)
    -- 强制设置 star_balance = 200 用于测试兑换
    INSERT INTO ss_child (id, tenant_id, parent_id, nickname, avatar_url, level, star_balance, total_stars, create_time, del_flag)
    VALUES (c_id, 'SS0001', p_id, '小明', '/avatar/boy1.png', 3, 200, 500, NOW(), '0')
    ON CONFLICT (id) DO UPDATE SET 
        star_balance = 200, 
        parent_id = p_id,
        del_flag = '0';


    -- 4. 建立家庭绑定关系 (ss_family_member)
    INSERT INTO ss_family_member (id, tenant_id, child_id, user_id, role, create_time)
    VALUES (family_id, 'SS0001', c_id, p_id, '爸爸', NOW())
    ON CONFLICT (id) DO UPDATE SET child_id = c_id, user_id = p_id;


    -- 5. 清理并重新注入奖励数据 (确保奖励商店不为空)
    DELETE FROM ss_parent_reward WHERE user_id = p_id;
    
    INSERT INTO ss_parent_reward (name, points_required, stock, icon, status, user_id, create_time)
    VALUES 
    ('玩30分钟游戏', 20, -1, '🎮', '0', p_id, NOW()),
    ('乐高积木一套', 100, 3, '🧱', '0', p_id, NOW()),
    ('看一集奥特曼', 15, -1, '🦸', '0', p_id, NOW());

    RAISE NOTICE 'E2E Test Data Stabilized Successfully!';
END $$;

COMMIT;
