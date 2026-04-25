-- 04-25 修正版动态测试数据生成脚本 (V3)
-- 修复了 ss_parent_task 表中不存在 child_id 列的问题（该表使用 user_id 关联儿童）
-- 明确了 ss_task_log 使用 child_id，ss_parent_reward 使用 user_id (家长)

DO $$
DECLARE
    -- 基础时间戳作为 ID 种子
    seed_id int8 := (extract(epoch from now())::bigint % 1000000);
    
    -- 定义 ID
    p_id int8 := 2035392423676469250; -- 家长 ID
    c1_id int8 := 10001;               -- 儿童 1
    c2_id int8 := 10002;               -- 儿童 2
    
    t1_id int8 := seed_id + 2000;     -- 任务 1 ID
    t2_id int8 := seed_id + 2001;     -- 任务 2 ID
    l1_id int8 := seed_id + 4000;     -- 日志 1 ID
    l2_id int8 := seed_id + 4001;     -- 日志 2 ID
    r1_id int8 := seed_id + 3000;     -- 奖励 1 ID
    redem_id int8 := seed_id + 5000;  -- 兑换 ID
    
    current_ts timestamp := now();
    today date := current_date;
BEGIN
    -- 1. 清理旧数据
    DELETE FROM "public"."ss_child" WHERE id IN (c1_id, c2_id, 1);
    DELETE FROM "public"."ss_parent_task" WHERE user_id IN (c1_id, c2_id, 1); -- 注意这里是 user_id
    DELETE FROM "public"."ss_task_log" WHERE child_id IN (c1_id, c2_id, 1);
    DELETE FROM "public"."sys_user" WHERE user_id IN (c1_id, c2_id);

    -- 2. 家长信息
    INSERT INTO "public"."sys_user" ("user_id", "tenant_id", "dept_id", "user_name", "nick_name", "user_type", "password", "status", "del_flag", "create_time") 
    VALUES (p_id, '000000', 200, 'ken2zhao', '家长', 'sys_user', '$2a$10$BBY6uvIsgU3484/nFDJzx.z5wbSQHkY3kdKLqQGcJ.Vh7HZAEn5KO', '0', '0', current_ts)
    ON CONFLICT (user_id) DO NOTHING;

    -- 3. 儿童信息 (sys_user 表)
    INSERT INTO "public"."sys_user" ("user_id", "tenant_id", "dept_id", "user_name", "nick_name", "user_type", "status", "del_flag", "create_time")
    VALUES (c1_id, '000000', 200, 'child_10001', '小明', '3', '0', '0', current_ts),
           (c2_id, '000000', 200, 'child_10002', '小红', '3', '0', '0', current_ts);

    -- 4. 儿童业务信息 (ss_child 表)
    INSERT INTO "public"."ss_child" ("id", "tenant_id", "parent_id", "nickname", "avatar_url", "level", "star_balance", "total_stars", "create_time", "del_flag") 
    VALUES (c1_id, 'SS0001', p_id, '小明', '/avatar/boy1.png', 3, 200, 500, current_ts, '0'),
           (c2_id, 'SS0001', p_id, '小红', '/avatar/girl1.png', 2, 150, 300, current_ts, '0');

    -- 5. 任务定义 (ss_parent_task 使用 user_id 关联儿童)
    INSERT INTO "public"."ss_parent_task" ("task_id", "dept_id", "user_id", "title", "icon", "reward_points", "status", "create_time", "del_flag")
    VALUES (t1_id, 200, c1_id, '早晨刷牙', '🪥', 5, '0', current_ts, '0'),
           (t2_id, 200, c1_id, '课后作业', '📚', 10, '0', current_ts, '0');

    -- 6. 任务执行记录 (ss_task_log 使用 child_id)
    INSERT INTO "public"."ss_task_log" ("id", "task_id", "child_id", "status", "start_time", "end_time", "create_time", "target_date", "del_flag")
    VALUES (l1_id, t1_id, c1_id, '2', current_ts - interval '4 hours', current_ts - interval '3.8 hours', current_ts, today, '0');
    
    INSERT INTO "public"."ss_task_log" ("id", "task_id", "child_id", "status", "start_time", "create_time", "target_date", "del_flag")
    VALUES (l2_id, t2_id, c1_id, '1', current_ts - interval '1 hour', current_ts, today, '0');

    -- 7. 奖励定义 (ss_parent_reward 使用 user_id 关联家长)
    INSERT INTO "public"."ss_parent_reward" ("reward_id", "user_id", "name", "icon", "points_required", "stock", "status", "create_time", "del_flag")
    VALUES (r1_id, p_id, '看电视30分钟', '📺', 30, -1, '0', current_ts, '0');

    RAISE NOTICE '数据生成成功！已关联儿童 10001 和 10002';
END $$;
