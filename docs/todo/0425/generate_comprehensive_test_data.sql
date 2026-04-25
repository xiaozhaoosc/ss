-- 04-25 完整测试数据生成脚本 (能力雷达/情绪热力图/周报) - V3 (兼容多种主键列名)
-- 目标家长: 2035392423676469250
-- 目标儿童: 10001 (小明), 10002 (小红)

DO $$
DECLARE
    p_id int8 := 2035392423676469250;
    c1_id int8 := 10001;
    c2_id int8 := 10002;
    current_ts timestamp := now();
    today date := current_date;
    i int;
    j int;
    task_id_base int8;
    mood_type int;
    autonomy int;
    seed int8 := (extract(epoch from now())::bigint % 10000000);
BEGIN
    -- 0. 表结构加固 (方案 B)
    -- 先将脏数据转为 '0'，然后修改类型为 int8 (BIGINT)，对齐 Java BaseEntity
    UPDATE ss_child_ai SET create_by = '0' WHERE create_by = '' OR create_by ~ '\n' OR create_by IS NULL;
    ALTER TABLE ss_child_ai ALTER COLUMN create_by TYPE int8 USING (create_by::int8);
    ALTER TABLE ss_child_ai ALTER COLUMN update_by TYPE int8 USING (update_by::int8);
    
    -- 同步修复相关表，防止后续报错
    UPDATE ss_emotion_record SET create_by = '0' WHERE create_by = '' OR create_by ~ '\n' OR create_by IS NULL;
    ALTER TABLE ss_emotion_record ALTER COLUMN create_by TYPE int8 USING (create_by::int8);

    -- 1. 清理数据
    DELETE FROM "ss_task_log" WHERE child_id IN (c1_id, c2_id);
    DELETE FROM "ss_parent_task" WHERE user_id IN (c1_id, c2_id);
    DELETE FROM "ss_emotion_record" WHERE child_id IN (c1_id, c2_id);
    DELETE FROM "ss_child_ai" WHERE child_id IN (c1_id, c2_id);
    DELETE FROM "ss_child_achievement" WHERE child_id IN (c1_id, c2_id);
    DELETE FROM "ss_child" WHERE id IN (c1_id, c2_id);
    DELETE FROM "sys_user" WHERE user_id IN (c1_id, c2_id);

    -- 2. 插入儿童基础数据
    INSERT INTO "sys_user" ("user_id", "tenant_id", "dept_id", "user_name", "nick_name", "user_type", "status", "del_flag", "create_time")
    VALUES (c1_id, '000000', 200, 'child_10001', '小明', '3', '0', '0', current_ts),
           (c2_id, '000000', 200, 'child_10002', '小红', '3', '0', '0', current_ts);

    INSERT INTO "ss_child" ("id", "tenant_id", "parent_id", "nickname", "avatar_url", "level", "star_balance", "total_stars", "create_time", "del_flag") 
    VALUES (c1_id, 'SS0001', p_id, '小明', '/avatar/boy1.png', 3, 200, 500, current_ts, '0'),
           (c2_id, 'SS0001', p_id, '小红', '/avatar/girl1.png', 2, 150, 300, current_ts, '0');

    -- 3. 插入任务模版
    task_id_base := 100000;
    INSERT INTO "ss_parent_task" ("task_id", "user_id", "title", "status", "create_time", "del_flag")
    VALUES (task_id_base + 1, c1_id, '早起刷牙', '0', current_ts, '0'),
           (task_id_base + 2, c1_id, '数学作业', '0', current_ts, '0'),
           (task_id_base + 3, c1_id, '整理房间', '0', current_ts, '0'),
           (task_id_base + 4, c1_id, '阅读30分钟', '0', current_ts, '0');

    -- 4. 生成过去 30 天的任务日志和情绪记录
    FOR i IN 0..30 LOOP
        IF random() < 0.8 THEN
            autonomy := 70 + floor(random() * 30);
            INSERT INTO "ss_task_log" ("id", "task_id", "child_id", "status", "autonomy_score", "create_time", "target_date", "actual_duration", "del_flag")
            VALUES (seed + i * 10 + 1, task_id_base + 1 + floor(random()*4), c1_id, '2', autonomy, current_ts - (i || ' days')::interval, today - i, 15 + floor(random()*20), '0');
        END IF;

        FOR j IN 1..2 LOOP
            IF random() < 0.6 THEN
                mood_type := (ARRAY[1, 5])[floor(random()*2)+1];
            ELSIF random() < 0.8 THEN
                mood_type := 3;
            ELSE
                mood_type := (ARRAY[2, 4])[floor(random()*2)+1];
            END IF;

            INSERT INTO "ss_child_ai" ("id", "child_id", "user_input", "ai_response", "emotion_type", "create_time")
            VALUES (seed + i * 100 + j + 500, c1_id, '心情记录' || j, 'AI鼓励' || j, mood_type, current_ts - (i || ' days')::interval - (j || ' hours')::interval);
            
            INSERT INTO "ss_emotion_record" ("id", "tenant_id", "child_id", "mood_level", "mood_type", "description", "record_time", "create_time")
            VALUES (seed + i * 100 + j + 1000, '000000', c1_id, 3, 'type' || mood_type, '描述' || j, today - i, current_ts - (i || ' days')::interval);
        END LOOP;
    END LOOP;

    -- 5. 插入成就数据
    INSERT INTO "ss_child_achievement" ("id", "achievement_id", "child_id", "type", "name", "count", "create_time")
    VALUES (seed + 9991, seed + 9991, c1_id, 'STAR', '我的星星', 500, current_ts),
           (seed + 9992, seed + 9992, c1_id, 'FRAGMENT', '勇气碎片', 12, current_ts),
           (seed + 9993, seed + 9993, c1_id, 'BADGE', '恒心大师', 1, current_ts);

    RAISE NOTICE '30天全量测试数据生成成功！';
END $$;
