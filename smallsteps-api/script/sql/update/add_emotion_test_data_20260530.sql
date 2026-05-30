-- ============================================================
-- 情绪记录测试数据 (影子观察者 + 情绪热力图演示用)
-- 儿童ID: 10001(张小明), 10002(张小红)
-- 覆盖近14天，每天1-3条记录，模拟真实ADHD儿童情绪波动
-- ============================================================

-- 先清除旧的测试数据（仅清除演示用的ID范围）
DELETE FROM ss_emotion_record WHERE id BETWEEN 60001 AND 60100;

-- ===== 张小明 (child_id=10001) 近14天情绪记录 =====

-- 14天前
INSERT INTO ss_emotion_record VALUES(60001, '000000', 10001, 4, 'happy', '今天语文课被老师表扬了，开心！', '', '真棒！妈妈为你骄傲！', '1', now() - interval '14 days', now() - interval '14 days');
INSERT INTO ss_emotion_record VALUES(60002, '000000', 10001, 3, 'calm', '今天没什么特别的，正常的一天', '', '', '1', now() - interval '14 days' + interval '6 hours', now() - interval '14 days' + interval '6 hours');

-- 13天前
INSERT INTO ss_emotion_record VALUES(60003, '000000', 10001, 2, 'frustrated', '数学题太难了，做了好久都做不出来，好烦', '', '没关系，慢慢来，我们一起想办法', '1', now() - interval '13 days', now() - interval '13 days');

-- 12天前
INSERT INTO ss_emotion_record VALUES(60004, '000000', 10001, 5, 'excited', '今天和小伙伴踢球了，进了两个球！', '', '太厉害了！运动让你变得更棒！', '1', now() - interval '12 days', now() - interval '12 days');
INSERT INTO ss_emotion_record VALUES(60005, '000000', 10001, 4, 'happy', '晚上吃了最爱的红烧肉', '', '', '1', now() - interval '12 days' + interval '5 hours', now() - interval '12 days' + interval '5 hours');

-- 11天前
INSERT INTO ss_emotion_record VALUES(60006, '000000', 10001, 1, 'sad', '今天被同学嘲笑了，说我跑步慢，好难过', '', '每个人都有自己的节奏，你已经很努力了', '1', now() - interval '11 days', now() - interval '11 days');
INSERT INTO ss_emotion_record VALUES(60007, '000000', 10001, 2, 'anxious', '明天要考试了，好紧张，怕考不好', '', '尽力就好，不管结果怎样爸爸妈妈都爱你', '1', now() - interval '11 days' + interval '4 hours', now() - interval '11 days' + interval '4 hours');

-- 10天前
INSERT INTO ss_emotion_record VALUES(60008, '000000', 10001, 3, 'calm', '考试感觉还行，没有想象中那么难', '', '看吧，你比自己想的更厉害！', '1', now() - interval '10 days', now() - interval '10 days');

-- 9天前
INSERT INTO ss_emotion_record VALUES(60009, '000000', 10001, 5, 'excited', '考试得了95分！全班第五名！', '', '太棒了！你的努力有了回报！', '1', now() - interval '9 days', now() - interval '9 days');
INSERT INTO ss_emotion_record VALUES(60010, '000000', 10001, 4, 'happy', '爸爸说周末带我去游乐园', '', '', '1', now() - interval '9 days' + interval '3 hours', now() - interval '9 days' + interval '3 hours');

-- 8天前
INSERT INTO ss_emotion_record VALUES(60011, '000000', 10001, 3, 'calm', '今天上课有点走神，但后来集中注意力了', '', '能自己调整回来就很棒！', '1', now() - interval '8 days', now() - interval '8 days');

-- 7天前 (上周)
INSERT INTO ss_emotion_record VALUES(60012, '000000', 10001, 4, 'happy', '游乐园玩了一整天，过山车太刺激了！', '', '开心就好！', '1', now() - interval '7 days', now() - interval '7 days');
INSERT INTO ss_emotion_record VALUES(60013, '000000', 10001, 5, 'excited', '在游乐园赢了一个大玩偶！', '', '', '1', now() - interval '7 days' + interval '4 hours', now() - interval '7 days' + interval '4 hours');

-- 6天前
INSERT INTO ss_emotion_record VALUES(60014, '000000', 10001, 2, 'frustrated', '作业好多，写了一个小时还没写完', '', '先休息一下，喝杯水再继续', '1', now() - interval '6 days', now() - interval '6 days');

-- 5天前
INSERT INTO ss_emotion_record VALUES(60015, '000000', 10001, 3, 'calm', '今天帮妈妈做了家务，感觉还不错', '', '你真是个懂事的好孩子！', '1', now() - interval '5 days', now() - interval '5 days');

-- 4天前
INSERT INTO ss_emotion_record VALUES(60016, '000000', 10001, 1, 'sad', '好朋友转学了，以后不能一起玩了', '', '虽然不能天天见面，但你们还可以打电话呀', '1', now() - interval '4 days', now() - interval '4 days');
INSERT INTO ss_emotion_record VALUES(60017, '000000', 10001, 2, 'anxious', '新来的同学都不认识，有点不自在', '', '慢慢来，交新朋友需要时间', '1', now() - interval '4 days' + interval '3 hours', now() - interval '4 days' + interval '3 hours');

-- 3天前
INSERT INTO ss_emotion_record VALUES(60018, '000000', 10001, 3, 'calm', '和新同桌聊了几句，他人还不错', '', '看吧，迈出第一步就好了！', '1', now() - interval '3 days', now() - interval '3 days');

-- 2天前
INSERT INTO ss_emotion_record VALUES(60019, '000000', 10001, 4, 'happy', '今天体育课跑了第一名！', '', '你越来越棒了！', '1', now() - interval '2 days', now() - interval '2 days');
INSERT INTO ss_emotion_record VALUES(60020, '000000', 10001, 5, 'excited', '用星星换了期待已久的变形金刚！', '', '', '0', now() - interval '2 days' + interval '5 hours', now() - interval '2 days' + interval '5 hours');

-- 昨天
INSERT INTO ss_emotion_record VALUES(60021, '000000', 10001, 3, 'calm', '正常的一天，作业写得挺快', '', '', '0', now() - interval '1 day', now() - interval '1 day');

-- 今天
INSERT INTO ss_emotion_record VALUES(60022, '000000', 10001, 4, 'happy', '今天和新同桌一起打了篮球，很开心', '', '', '0', now(), now());


-- ===== 张小红 (child_id=10002) 近14天情绪记录 =====

-- 14天前
INSERT INTO ss_emotion_record VALUES(60030, '000000', 10002, 3, 'calm', '今天画画课画了一只小猫，老师说很好', '', '画得真好看！', '1', now() - interval '14 days', now() - interval '14 days');

-- 13天前
INSERT INTO ss_emotion_record VALUES(60031, '000000', 10002, 5, 'excited', '收到了最喜欢的公主裙！', '', '穿上一定很漂亮！', '1', now() - interval '13 days', now() - interval '13 days');
INSERT INTO ss_emotion_record VALUES(60032, '000000', 10002, 4, 'happy', '穿着新裙子去幼儿园被夸好看了', '', '', '1', now() - interval '13 days' + interval '4 hours', now() - interval '13 days' + interval '4 hours');

-- 12天前
INSERT INTO ss_emotion_record VALUES(60033, '000000', 10002, 2, 'sad', '搭的积木倒了，搭了好久呢', '', '没关系，我们可以重新搭一个更漂亮的', '1', now() - interval '12 days', now() - interval '12 days');

-- 11天前
INSERT INTO ss_emotion_record VALUES(60034, '000000', 10002, 4, 'happy', '重新搭了一个更大的城堡！', '', '真厉害！不放弃就能做到！', '1', now() - interval '11 days', now() - interval '11 days');

-- 10天前
INSERT INTO ss_emotion_record VALUES(60035, '000000', 10002, 3, 'calm', '今天看了一本关于蝴蝶的绘本', '', '', '1', now() - interval '10 days', now() - interval '10 days');

-- 9天前
INSERT INTO ss_emotion_record VALUES(60036, '000000', 10002, 1, 'sad', '肚子疼，不想吃东西', '', '多喝温水，妈妈给你揉揉肚子', '1', now() - interval '9 days', now() - interval '9 days');

-- 8天前
INSERT INTO ss_emotion_record VALUES(60037, '000000', 10002, 3, 'calm', '肚子不疼了，今天精神好多了', '', '太好了！', '1', now() - interval '8 days', now() - interval '8 days');

-- 7天前
INSERT INTO ss_emotion_record VALUES(60038, '000000', 10002, 5, 'excited', '周末去看了动画电影，太好看了！', '', '', '1', now() - interval '7 days', now() - interval '7 days');

-- 6天前
INSERT INTO ss_emotion_record VALUES(60039, '000000', 10002, 4, 'happy', '画了一幅电影里的公主，妈妈说很像', '', '', '1', now() - interval '6 days', now() - interval '6 days');

-- 5天前
INSERT INTO ss_emotion_record VALUES(60040, '000000', 10002, 2, 'frustrated', '拼音总是写反，b和d分不清', '', '这很正常，多练习就好了，你已经进步很大了', '1', now() - interval '5 days', now() - interval '5 days');
INSERT INTO ss_emotion_record VALUES(60041, '000000', 10002, 3, 'calm', '妈妈教了我一个分辨b和d的方法', '', '', '1', now() - interval '5 days' + interval '3 hours', now() - interval '5 days' + interval '3 hours');

-- 4天前
INSERT INTO ss_emotion_record VALUES(60042, '000000', 10002, 4, 'happy', '今天拼音全写对了！', '', '看吧，你做到了！', '1', now() - interval '4 days', now() - interval '4 days');

-- 3天前
INSERT INTO ss_emotion_record VALUES(60043, '000000', 10002, 3, 'calm', '今天和小朋友玩了过家家', '', '', '1', now() - interval '3 days', now() - interval '3 days');

-- 2天前
INSERT INTO ss_emotion_record VALUES(60044, '000000', 10002, 5, 'excited', '画的画被贴在教室墙上了！', '', '太棒了！你是个小画家！', '0', now() - interval '2 days', now() - interval '2 days');

-- 昨天
INSERT INTO ss_emotion_record VALUES(60045, '000000', 10002, 4, 'happy', '用星星换了贴纸本，好开心', '', '', '0', now() - interval '1 day', now() - interval '1 day');

-- 今天
INSERT INTO ss_emotion_record VALUES(60046, '000000', 10002, 3, 'calm', '正常的一天，中午吃了好吃的蛋炒饭', '', '', '0', now(), now());
