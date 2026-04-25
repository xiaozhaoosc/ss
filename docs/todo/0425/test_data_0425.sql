-- 04-25 动态测试数据生成脚本
-- 使用当前时间戳生成 ID 和日期，确保每次运行生成的数据都是唯一的且日期为当天

DO $$
DECLARE
    -- 基础时间戳作为 ID 种子
    seed_id int8 := (extract(epoch from now())::bigint % 1000000000);
    
    -- 定义 ID (确保关联性)
    p_id int8 := 2035392423676469250; -- 家长 ID 保持固定以便登录
    c_id int8 := seed_id + 1000;      -- 孩子 ID
    t1_id int8 := seed_id + 2000;     -- 任务 1 ID
    t2_id int8 := seed_id + 2001;     -- 任务 2 ID
    l1_id int8 := seed_id + 4000;     -- 日志 1 ID
    l2_id int8 := seed_id + 4001;     -- 日志 2 ID
    r1_id int8 := seed_id + 3000;     -- 奖励 1 ID
    redem_id int8 := seed_id + 5000;  -- 兑换 ID
    
    current_ts timestamp := now();
    today date := current_date;
BEGIN
    -- 1. 家长信息 (由于是固定 ID，使用 ON CONFLICT 兼容)
    INSERT INTO "public"."sys_user" ("user_id", "tenant_id", "dept_id", "user_name", "nick_name", "user_type", "password", "status", "del_flag", "create_time") 
    VALUES (p_id, '000000', 200, 'ken2zhao', 'ken2zhao', 'sys_user', '$2a$10$BBY6uvIsgU3484/nFDJzx.z5wbSQHkY3kdKLqQGcJ.Vh7HZAEn5KO', '0', '0', current_ts)
    ON CONFLICT (user_id) DO NOTHING;

    -- 2. 孩子信息
    INSERT INTO "public"."ss_child" ("id", "tenant_id", "parent_id", "nickname", "avatar_url", "level", "star_balance", "total_stars", "create_time", "del_flag") 
    VALUES (c_id, 'SS0001', p_id, '小明(动态)', '/avatar/boy1.png', 3, 200, 500, current_ts, '0');

    -- 3. 任务定义
    INSERT INTO "public"."ss_task" ("id", "tenant_id", "child_id", "title", "icon", "star_reward", "difficulty", "type", "status", "create_time", "del_flag")
    VALUES (t1_id, 'SS0001', c_id, '早晨刷牙', '🪥', 5, 1, '1', '0', current_ts, '0'),
           (t2_id, 'SS0001', c_id, '课后作业', '📚', 10, 3, '1', '0', current_ts, '0');

    -- 4. 任务执行记录 (Timeline)
    -- 记录 1：今天早晨已完成
    INSERT INTO "public"."ss_task_log" ("id", "tenant_id", "task_id", "child_id", "status", "title_snap", "start_time", "end_time", "create_time", "target_date")
    VALUES (l1_id, 'SS0001', t1_id, c_id, '2', '早晨刷牙', current_ts - interval '4 hours', current_ts - interval '3.8 hours', current_ts, today);
    
    -- 记录 2：目前正在进行中
    INSERT INTO "public"."ss_task_log" ("id", "tenant_id", "task_id", "child_id", "status", "title_snap", "start_time", "create_time", "target_date")
    VALUES (l2_id, 'SS0001', t2_id, c_id, '1', '课后作业', current_ts - interval '1 hour', current_ts, today);

    -- 5. 奖励定义
    INSERT INTO "public"."ss_reward" ("id", "tenant_id", "child_id", "name", "icon", "star_cost", "stock", "status", "create_time", "del_flag")
    VALUES (r1_id, 'SS0001', c_id, '看电视30分钟', '📺', 30, -1, '0', current_ts, '0');

    -- 6. 奖励兑换记录 (Notifications)
    INSERT INTO "public"."ss_parent_reward_redemption" ("redemption_id", "reward_id", "user_id", "points_cost", "status", "create_time")
    VALUES (redem_id, r1_id, p_id, 30, '0', current_ts);

    RAISE NOTICE '数据生成成功！孩子 ID: %, 任务 ID: %', c_id, t1_id;
END $$;
