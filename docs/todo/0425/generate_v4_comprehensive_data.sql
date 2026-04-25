-- Small Steps 完整测试数据生成脚本 - V4 (最终加固版)
-- 日期: 04-25
-- 目标: 修复 Long 转换异常 + 生成 30 天看板数据 (雷达图/热力图/趋势图)

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
    -- 0. 数据库结构加固 (方案 B)
    -- ======================================================
    RAISE NOTICE '正在执行方案 B：修复表结构与脏数据...';
    
    -- 修复 ss_child_ai
    UPDATE ss_child_ai SET create_by = '0' WHERE create_by = '' OR create_by ~ '\n' OR create_by IS NULL;
    UPDATE ss_child_ai SET update_by = '0' WHERE update_by = '' OR update_by ~ '\n' OR update_by IS NULL;
    ALTER TABLE ss_child_ai ALTER COLUMN create_by TYPE int8 USING (create_by::int8);
    ALTER TABLE ss_child_ai ALTER COLUMN update_by TYPE int8 USING (update_by::int8);
    
    -- 修复 ss_emotion_record
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
        -- A. 任务日志 (用于雷达图中的完成率与自主得分)
        IF random() < 0.8 THEN
            autonomy := 60 + floor(random() * 40);
            INSERT INTO "ss_task_log" ("id", "task_id", "child_id", "status", "autonomy_score", "create_time", "target_date", "actual_duration", "del_flag", "create_by")
            VALUES (seed + i * 10 + 1, task_id_base + 1 + floor(random()*4), c1_id, '2', autonomy, current_ts - (i || ' days')::interval, today - i, 15 + floor(random()*20), '0', p_id);
        END IF;

        -- B. AI 交互与情绪趋势 (用于趋势图)
        FOR j IN 1..2 LOOP
            -- 模拟情绪波动：开心和平衡占多数，偶尔有难过
            IF random() < 0.6 THEN
                mood_type := (ARRAY[1, 5])[floor(random()*2)+1]; -- 开心或平静
            ELSIF random() < 0.8 THEN
                mood_type := 3; -- 愤怒
            ELSE
                mood_type := (ARRAY[2, 4])[floor(random()*2)+1]; -- 难过或焦虑
            END IF;

            -- 插入 AI 记录
            INSERT INTO "ss_child_ai" ("id", "child_id", "user_input", "ai_response", "emotion_type", "create_time", "create_by")
            VALUES (seed + i * 100 + j + 500, c1_id, '我今天的心情是' || j, '小步会一直陪着你的！', mood_type, current_ts - (i || ' days')::interval - (j || ' hours')::interval, c1_id);
            
            -- 插入情绪热力图记录
            INSERT INTO "ss_emotion_record" ("id", "tenant_id", "child_id", "mood_level", "mood_type", "description", "record_time", "create_time", "create_by")
            VALUES (seed + i * 100 + j + 1000, '000000', c1_id, 3, 'type' || mood_type, '日常记录' || j, today - i, current_ts - (i || ' days')::interval, c1_id);
        END LOOP;
    END LOOP;

    -- ======================================================
    -- 4. 插入成就/勇气碎片 (用于统计卡片)
    -- ======================================================
    INSERT INTO "ss_child_achievement" ("id", "achievement_id", "child_id", "type", "name", "count", "create_time", "create_by")
    VALUES (seed + 9991, seed + 9991, c1_id, 'STAR', '我的星星', 500, current_ts, p_id),
           (seed + 9992, seed + 9992, c1_id, 'FRAGMENT', '勇气碎片', 12, current_ts, p_id),
           (seed + 9993, seed + 9993, c1_id, 'BADGE', '恒心大师', 1, current_ts, p_id);

    RAISE NOTICE 'V4 增强版数据生成成功！表结构已修复，30天测试数据已就绪。';
END $$;
