-- Small Steps 完整测试数据生成脚本 - V5 (全自动兼容版)
-- 日期: 04-25
-- 修复: "default cannot be cast to bigint" 报错

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
    -- 0. 数据库结构加固 (处理默认值冲突)
    -- ======================================================
    RAISE NOTICE '正在解除默认值冲突并修复类型...';
    
    -- 修复 ss_child_ai
    ALTER TABLE ss_child_ai ALTER COLUMN create_by DROP DEFAULT;
    UPDATE ss_child_ai SET create_by = '0' WHERE create_by = '' OR create_by ~ '\n' OR create_by IS NULL;
    ALTER TABLE ss_child_ai ALTER COLUMN create_by TYPE int8 USING (create_by::int8);
    
    ALTER TABLE ss_child_ai ALTER COLUMN update_by DROP DEFAULT;
    UPDATE ss_child_ai SET update_by = '0' WHERE update_by = '' OR update_by ~ '\n' OR update_by IS NULL;
    ALTER TABLE ss_child_ai ALTER COLUMN update_by TYPE int8 USING (update_by::int8);
    
    -- 修复 ss_emotion_record
    ALTER TABLE ss_emotion_record ALTER COLUMN create_by DROP DEFAULT;
    UPDATE ss_emotion_record SET create_by = '0' WHERE create_by = '' OR create_by ~ '\n' OR create_by IS NULL;
    ALTER TABLE ss_emotion_record ALTER COLUMN create_by TYPE int8 USING (create_by::int8);

    -- ======================================================
    -- 1. 清理旧测试数据
    -- ======================================================
    DELETE FROM "ss_task_log" WHERE child_id IN (c1_id, c2_id);
    DELETE FROM "ss_parent_task" WHERE user_id IN (c1_id, c2_id);
    DELETE FROM "ss_child_ai" WHERE child_id IN (c1_id, c2_id);
    DELETE FROM "ss_emotion_record" WHERE child_id IN (c1_id, c2_id);
    DELETE FROM "ss_child_achievement" WHERE child_id IN (c1_id, c2_id);

    -- ======================================================
    -- 2. 插入任务模版 (针对小明)
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

            INSERT INTO "ss_child_ai" ("id", "child_id", "user_input", "ai_response", "emotion_type", "create_time", "create_by")
            VALUES (seed + i * 100 + j + 500, c1_id, '记录' || j, '鼓励' || j, mood_type, current_ts - (i || ' days')::interval - (j || ' hours')::interval, c1_id);
            
            INSERT INTO "ss_emotion_record" ("id", "tenant_id", "child_id", "mood_level", "mood_type", "description", "record_time", "create_time", "create_by")
            VALUES (seed + i * 100 + j + 1000, '000000', c1_id, 3, 'type' || mood_type, '记录' || j, today - i, current_ts - (i || ' days')::interval, c1_id);
        END LOOP;
    END LOOP;

    -- ======================================================
    -- 4. 插入成就/勇气碎片
    -- ======================================================
    INSERT INTO "ss_child_achievement" ("id", "achievement_id", "child_id", "type", "name", "count", "create_time", "create_by")
    VALUES (seed + 9991, seed + 9991, c1_id, 'STAR', '我的星星', 500, current_ts, p_id),
           (seed + 9992, seed + 9992, c1_id, 'FRAGMENT', '勇气碎片', 12, current_ts, p_id),
           (seed + 9993, seed + 9993, c1_id, 'BADGE', '恒心大师', 1, current_ts, p_id);

    RAISE NOTICE 'V5 自动化修复脚本执行成功！所有类型障碍已清除。';
END $$;
