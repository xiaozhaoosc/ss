-- ============================================================
-- Small Steps 演示数据补充 SQL
-- 生成时间: 2026-05-30
-- 说明: 为自动化测试和演示补充缺失数据
-- 执行方式: docker exec -i ss-postgres psql -U smallsteps -d smallsteps_db < demo-data.sql
-- ============================================================

-- ============================================================
-- 1. 亲子契约 (ss_parent_contract) - 当前 0 条
-- ============================================================
INSERT INTO ss_parent_contract (contract_id, ss_parent_id, child_id, content, status, create_by, create_time, del_flag)
VALUES
  (2060300000000000001, 1001, 1002,
   '每日动力契约：连续 7 天完成"整理书包"，即可兑换"周末游乐园之旅"。当前已坚持 4 天，目标 7 天。',
   '0', 1001, NOW(), '0'),
  (2060300000000000002, 1001, 1003,
   '阅读小达人：连续 5 天完成"阅读绘本20分钟"，即可兑换"买一本新绘本"。当前已坚持 2 天，目标 5 天。',
   '0', 1001, NOW(), '0'),
  (2060300000000000003, 1001, 1002,
   '运动之星：连续 10 天完成"跳绳100下"，即可兑换"吃美味冰淇淋"。当前已坚持 7 天，目标 10 天。',
   '0', 1001, NOW(), '0');

-- ============================================================
-- 2. 情绪急救包 (ss_parent_emotion_kit) - emotion_type 为整数
-- ============================================================
INSERT INTO ss_parent_emotion_kit (child_id, kit_name, emotion_type, content, status, create_by, create_time)
VALUES
  (1002, '深呼吸放松法', 1, '当感到焦虑时：1. 找一个安静的地方坐下 2. 闭上眼睛 3. 慢慢吸气数到4 4. 屏住呼吸数到4 5. 慢慢呼气数到6 6. 重复3-5次', 0, '1001', NOW()),
  (1002, '情绪颜色画', 2, '当生气时：1. 拿出画笔和纸 2. 用红色画出你的愤怒 3. 慢慢换成蓝色画平静的大海 4. 深呼吸，感受平静', 0, '1001', NOW()),
  (1003, '拥抱充电站', 3, '当难过时：1. 找一个毛绒玩具 2. 给它一个大大的拥抱 3. 告诉它你的感受 4. 想象它在安慰你', 0, '1001', NOW()),
  (1003, '快乐歌单', 4, '当情绪低落时：1. 播放你喜欢的歌 2. 跟着节奏轻轻摇摆 3. 大声唱出来 4. 跳一段自创舞蹈', 0, '1001', NOW());

-- ============================================================
-- 3. 成就/勋章 (ss_achievement)
-- ============================================================
INSERT INTO ss_achievement (id, tenant_id, name, icon_url, condition_type, threshold, reward_stars, status, create_by, create_time, del_flag)
VALUES
  (2060300000000000021, 100, '专注小达人', '/images/achievements/focus.png', 'task_complete', 10, 20, '0', 1001, NOW(), '0'),
  (2060300000000000022, 100, '早起先锋', '/images/achievements/early-bird.png', 'task_complete', 5, 15, '0', 1001, NOW(), '0'),
  (2060300000000000023, 100, '作业克星', '/images/achievements/homework.png', 'task_complete', 20, 30, '0', 1001, NOW(), '0'),
  (2060300000000000024, 100, '情绪小天使', '/images/achievements/emotion.png', 'emotion_record', 15, 25, '0', 1001, NOW(), '0'),
  (2060300000000000025, 100, '运动健将', '/images/achievements/sports.png', 'task_complete', 30, 50, '0', 1001, NOW(), '0'),
  (2060300000000000026, 100, '阅读之星', '/images/achievements/reading.png', 'task_complete', 15, 25, '0', 1001, NOW(), '0'),
  (2060300000000000027, 100, '整理小能手', '/images/achievements/tidy.png', 'task_complete', 10, 15, '0', 1001, NOW(), '0'),
  (2060300000000000028, 100, '坚持之星', '/images/achievements/persistence.png', 'streak_days', 7, 30, '0', 1001, NOW(), '0');

-- ============================================================
-- 4. 儿童已解锁成就 (ss_child_achievement)
-- ============================================================
INSERT INTO ss_child_achievement (id, child_id, achievement_id)
VALUES
  (2060300000000000031, 1002, 2060300000000000021),
  (2060300000000000032, 1002, 2060300000000000022),
  (2060300000000000033, 1002, 2060300000000000023),
  (2060300000000000034, 1003, 2060300000000000024),
  (2060300000000000035, 1003, 2060300000000000022);

-- ============================================================
-- 5. 补充积分数据
-- ============================================================
UPDATE ss_child_score SET balance = 180, total_earned = 580 WHERE user_id = 1002;
UPDATE ss_child_score SET balance = 45, total_earned = 220 WHERE user_id = 1003;

-- ============================================================
-- 6. 补充积分流水 (ss_score_history) - id 需要手动指定
-- ============================================================
INSERT INTO ss_score_history (id, user_id, amount, type, reason, create_time)
VALUES
  (2060300000000000051, 1002, 10, '1', '完成任务：整理书包', NOW() - INTERVAL '2 days'),
  (2060300000000000052, 1002, 15, '1', '完成任务：做数学作业', NOW() - INTERVAL '2 days'),
  (2060300000000000053, 1002, 20, '1', '完成任务：跳绳100下', NOW() - INTERVAL '1 day'),
  (2060300000000000054, 1002, 10, '1', '完成任务：阅读绘本', NOW() - INTERVAL '1 day'),
  (2060300000000000055, 1002, -30, '2', '兑换奖励：看动画片30分钟', NOW() - INTERVAL '12 hours'),
  (2060300000000000056, 1003, 10, '1', '完成任务：帮忙摆碗筷', NOW() - INTERVAL '3 days'),
  (2060300000000000057, 1003, 10, '1', '完成任务：收拾玩具', NOW() - INTERVAL '2 days'),
  (2060300000000000058, 1003, 15, '1', '完成任务：浇花', NOW() - INTERVAL '1 day'),
  (2060300000000000059, 1003, 10, '1', '完成任务：穿衣服', NOW() - INTERVAL '12 hours');

-- ============================================================
-- 7. 补充设备数据 (无 del_flag 列)
-- ============================================================
INSERT INTO ss_device (id, tenant_id, serial_number, child_id, status, battery_level, last_active, fw_version, create_by, create_time)
VALUES
  (70002, '000000', 'SS-ESP32-00002', 1002, '1', 85, NOW() - INTERVAL '30 minutes', 'v2.1.0', 1001, NOW()),
  (70003, '000000', 'SS-ESP32-00003', 1003, '1', 62, NOW() - INTERVAL '2 hours', 'v2.1.0', 1001, NOW());

-- ============================================================
-- 8. 补充兑换请求 - 待处理状态 (status=0)
-- ============================================================
INSERT INTO ss_parent_reward_redemption (redemption_id, reward_id, user_id, points_cost, status, create_by, create_time)
VALUES
  (2060300000000000041, 2060233080080416769, 1003, 5, 0, 1003, NOW() - INTERVAL '2 hours');

-- ============================================================
-- 验证
-- ============================================================
SELECT 'ss_parent_contract' as 表名, COUNT(*) as 记录数 FROM ss_parent_contract
UNION ALL SELECT 'ss_parent_emotion_kit', COUNT(*) FROM ss_parent_emotion_kit
UNION ALL SELECT 'ss_achievement', COUNT(*) FROM ss_achievement
UNION ALL SELECT 'ss_child_achievement', COUNT(*) FROM ss_child_achievement
UNION ALL SELECT 'ss_device', COUNT(*) FROM ss_device
UNION ALL SELECT 'ss_parent_reward_redemption', COUNT(*) FROM ss_parent_reward_redemption
UNION ALL SELECT 'ss_score_history', COUNT(*) FROM ss_score_history
ORDER BY 表名;
