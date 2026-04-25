-- Small Steps 完整测试数据生成脚本 - V7 (最终验证版)
-- 日期: 04-25
-- 修复: 仅针对确实存在的 ss_child_ai.create_by 进行类型转换

DO $$
DECLARE
    p_id int8 := 2035392423676469250; -- 家长ID
    c1_id int8 := 10001;              -- 小明 ID
    c2_id int8 := 10002;              -- 小红 ID
    current_ts timestamp := now();
    today date := current_date;
    i int;
    j int;
    task_id_base int8 := 100000;
    mood_type int;
    autonomy int;
    seed int8 := (extract(epoch from now())::bigint % 10000000);
BEGIN
    -- ======================================================
    -- 0. 数据库结构加固 (仅针对 ss_child_ai)
    -- ======================================================
    RAISE NOTICE '正在精准修复 ss_child_ai 的字段类型...';
    
    -- 1. 移除可能存在的默认值
    ALTER TABLE ss_child_ai ALTER COLUMN create_by DROP DEFAULT;
    ALTER TABLE ss_child_ai ALTER COLUMN update_by DROP DEFAULT;

    -- 2. 强力清洗脏数据 (如 "admin" 或空字符串全部重置为 '0')
    UPDATE ss_child_ai SET create_by = '0' WHERE create_by !~ '^[0-9]+$' OR create_by IS NULL;
    UPDATE ss_child_ai SET update_by = '0' WHERE update_by !~ '^[0-9]+$' OR update_by IS NULL;

    -- 3. 转换类型为 BIGINT (int8)
    ALTER TABLE ss_child_ai ALTER COLUMN create_by TYPE int8 USING (create_by::int8);
    ALTER TABLE ss_child_ai ALTER COLUMN update_by TYPE int8 USING (update_by::int8);

    -- ======================================================
    -- 1. 清理旧测试数据
    -- ======================================================
    DELETE FROM "ss_task_log" WHERE child_id IN (c1_id, c2_id);
    DELETE FROM "ss_parent_task" WHERE user_id IN (c1_id, c2_id);
    DELETE FROM "ss_child_ai" WHERE child_id IN (c1_id, c2_id);
    DELETE FROM "ss_emotion_record" WHERE child_id IN (c1_id, c2_id);
    DELETE FROM "ss_child_achievement" WHERE child_id IN (c1_id, c2_id);

    -- ======================================================
    -- 2. 插入任务模版
    -- ======================================================
    INSERT INTO "ss_parent_task" ("task_id", "user_id", "title", "status", "create_time", "del_flag", "create_by")
    VALUES (task_id_base + 1, c1_id, '早起刷牙', '0', current_ts, '0', p_id),
           (task_id_base + 2, c1_id, '数学作业', '0', current_ts, '0', p_id),
           (task_id_base + 3, c1_id, '整理房间', '0', current_ts, '0', p_id),
           (task_id_base + 4, c1_id, '阅读30分钟', '0', current_ts, '0', p_id);

    -- ======================================================
    -- 3. 循环生成过去 30 天的动态数据
    -- ======================================================
    FOR i IN 0..30 LOOP
        -- A. 任务日志
        IF random() < 0.8 THEN
            autonomy := 60 + floor(random() * 40);
            INSERT INTO "ss_task_log" ("id", "task_id", "child_id", "status", "autonomy_score", "create_time", "target_date", "actual_duration", "del_flag", "create_by")
            VALUES (seed + i * 10 + 1, task_id_base + 1 + floor(random()*4), c1_id, '2', autonomy, current_ts - (i || ' days')::interval, today - i, 15 + floor(random()*20), '0', p_id);
        END IF;

        -- B. AI 交互与情绪趋势
        FOR j IN 1..2 LOOP
            IF random() < 0.6 THEN
                mood_type := (ARRAY[1, 5])[floor(random()*2)+1];
            ELSIF random() < 0.8 THEN
                mood_type := 3;
            ELSE
                mood_type := (ARRAY[2, 4])[floor(random()*2)+1];
            END IF;

            -- 插入 AI 记录 (已修复 create_by)
            INSERT INTO "ss_child_ai" ("id", "child_id", "user_input", "ai_response", "emotion_type", "create_time", "create_by")
            VALUES (seed + i * 100 + j + 500, c1_id, '心情记录' || j, 'AI鼓励' || j, mood_type, current_ts - (i || ' days')::interval - (j || ' hours')::interval, c1_id);
            
            -- 插入情绪记录 (注意：此表无 create_by，我们不传它)
            INSERT INTO "ss_emotion_record" ("id", "tenant_id", "child_id", "mood_level", "mood_type", "description", "record_time", "create_time")
            VALUES (seed + i * 100 + j + 1000, '000000', c1_id, 3, 'type' || mood_type, '日常记录' || j, today - i, current_ts - (i || ' days')::interval);
        END LOOP;
    END LOOP;

    RAISE NOTICE 'V7 脚本执行成功！已根据真实表结构完成修复。';
END $$;
