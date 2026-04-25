-- 04-25 增强型测试数据生成脚本 (V4)
-- 添加了 autonomy_score 和 ss_emotion_record 数据，用于验证“家长洞察”页面的真实性

DO $$
DECLARE
    -- 基础时间戳作为 ID 种子
    seed_id int8 := (extract(epoch from now())::bigint % 1000000);
    
    -- 定义 ID
    p_id int8 := 2035392423676469250; -- 家长 ID
    c1_id int8 := 10001;               -- 儿童 1
    c2_id int8 := 10002;               -- 儿童 2
    
    current_ts timestamp := now();
    today date := current_date;
BEGIN
    -- 1. 清理旧数据 (扩展范围)
    DELETE FROM "public"."ss_child" WHERE id IN (c1_id, c2_id, 1);
    DELETE FROM "public"."ss_parent_task" WHERE user_id IN (c1_id, c2_id, 1);
    DELETE FROM "public"."ss_task_log" WHERE child_id IN (c1_id, c2_id, 1);
    DELETE FROM "public"."sys_user" WHERE user_id IN (c1_id, c2_id);
    DELETE FROM "public"."ss_emotion_record" WHERE child_id IN (c1_id, c2_id);

    -- 2. 家长信息
    INSERT INTO "public"."sys_user" ("user_id", "tenant_id", "dept_id", "user_name", "nick_name", "user_type", "password", "status", "del_flag", "create_time") 
    VALUES (p_id, '000000', 200, 'ken2zhao', '家长', 'sys_user', '$2a$10$BBY6uvIsgU3484/nFDJzx.z5wbSQHkY3kdKLqQGcJ.Vh7HZAEn5KO', '0', '0', current_ts)
    ON CONFLICT (user_id) DO NOTHING;

    -- 3. 儿童基础信息
    INSERT INTO "public"."sys_user" ("user_id", "tenant_id", "dept_id", "user_name", "nick_name", "user_type", "status", "del_flag", "create_time")
    VALUES (c1_id, '000000', 200, 'child_10001', '小明', '3', '0', '0', current_ts),
           (c2_id, '000000', 200, 'child_10002', '小红', '3', '0', '0', current_ts);

    INSERT INTO "public"."ss_child" ("id", "tenant_id", "parent_id", "nickname", "avatar_url", "level", "star_balance", "total_stars", "create_time", "del_flag") 
    VALUES (c1_id, 'SS0001', p_id, '小明', '/avatar/boy1.png', 3, 200, 500, current_ts, '0'),
           (c2_id, 'SS0001', p_id, '小红', '/avatar/girl1.png', 2, 150, 300, current_ts, '0');

    -- 4. 任务与日志 (带分数)
    INSERT INTO "public"."ss_parent_task" ("task_id", "dept_id", "user_id", "title", "icon", "reward_points", "status", "create_time", "del_flag")
    VALUES (seed_id+1, 200, c1_id, '早晨刷牙', '🪥', 5, '0', current_ts, '0'),
           (seed_id+2, 200, c1_id, '课后作业', '📚', 10, '0', current_ts, '0'),
           (seed_id+3, 200, c1_id, '整理书包', '🎒', 8, '0', current_ts, '0');

    -- 已完成任务，带自主得分
    INSERT INTO "public"."ss_task_log" ("id", "task_id", "child_id", "status", "autonomy_score", "create_time", "target_date", "del_flag")
    VALUES (seed_id+10, seed_id+1, c1_id, '2', 85, current_ts - interval '5 hours', today, '0'),
           (seed_id+11, seed_id+2, c1_id, '2', 70, current_ts - interval '2 hours', today, '0');

    -- 5. 情绪记录 (模拟过去 7 天)
    INSERT INTO "public"."ss_emotion_record" ("id", "child_id", "mood_level", "mood_type", "description", "record_time", "create_time")
    VALUES (seed_id+100, c1_id, 4, 'happy', '今天很开心', today - 6, current_ts - interval '6 days'),
           (seed_id+101, c1_id, 5, 'excited', '拼图完成了！', today - 5, current_ts - interval '5 days'),
           (seed_id+102, c1_id, 3, 'calm', '和平常一样', today - 4, current_ts - interval '4 days'),
           (seed_id+103, c1_id, 2, 'sad', '被老师批评了', today - 3, current_ts - interval '3 days'),
           (seed_id+104, c1_id, 4, 'happy', '吃了冰淇淋', today - 2, current_ts - interval '2 days'),
           (seed_id+105, c1_id, 3, 'neutral', '在写作业', today - 1, current_ts - interval '1 day'),
           (seed_id+106, c1_id, 4, 'happy', '现在状态不错', today, current_ts);

    RAISE NOTICE '增强型数据生成成功！已准备好雷达图和热力图数据。';
END $$;
