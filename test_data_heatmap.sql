-- 创建 ss_child_ai 表
CREATE TABLE IF NOT EXISTS ss_child_ai (
    id BIGSERIAL PRIMARY KEY,
    child_id BIGINT NOT NULL,
    user_input TEXT,
    ai_response TEXT,
    emotion_type SMALLINT,
    context TEXT,
    create_by VARCHAR(64) DEFAULT '',
    create_time TIMESTAMP,
    update_by VARCHAR(64) DEFAULT '',
    update_time TIMESTAMP,
    del_flag CHAR(1) DEFAULT '0'
);

COMMENT ON TABLE ss_child_ai IS '儿童AI交互记录表';
COMMENT ON COLUMN ss_child_ai.id IS '交互ID';
COMMENT ON COLUMN ss_child_ai.child_id IS '孩子ID';
COMMENT ON COLUMN ss_child_ai.user_input IS '用户输入';
COMMENT ON COLUMN ss_child_ai.ai_response IS 'AI回复内容';
COMMENT ON COLUMN ss_child_ai.emotion_type IS '情绪类型 (1-开心, 2-难过, 3-愤怒, 4-焦虑, 5-平静)';
COMMENT ON COLUMN ss_child_ai.context IS '场景上下文';
COMMENT ON COLUMN ss_child_ai.create_by IS '创建者';
COMMENT ON COLUMN ss_child_ai.create_time IS '创建时间';
COMMENT ON COLUMN ss_child_ai.update_by IS '更新者';
COMMENT ON COLUMN ss_child_ai.update_time IS '更新时间';
COMMENT ON COLUMN ss_child_ai.del_flag IS '删除标志（0代表存在 1/2代表删除）';

-- 生成2026年4月的儿童AI交互及情绪测试数据
-- 情绪类型 emotion_type: 1-开心, 2-难过, 3-愤怒, 4-焦虑, 5-平静
-- 已将 child_id 替换为了 1002，适用于 PostgreSQL 执行

INSERT INTO ss_child_ai (child_id, user_input, ai_response, emotion_type, create_time, create_by, del_flag) VALUES
(1002, '今天在学校和小明一起玩了搭积木', '哇，听起来非常有趣呢！搭积木可以锻炼动手能力哦。', 1, '2026-04-01 15:30:00', 'admin', '0'),
(1002, '老师表扬我数学题都做对了', '太棒了！你的努力得到了认可，继续保持！', 5, '2026-04-03 16:45:00', 'admin', '0'),
(1002, '我的玩具小汽车坏了', '别难过，你可以和爸爸一起尝试修理它，这也是个学习的过程。', 2, '2026-04-05 18:20:00', 'admin', '0'),
(1002, '我讨厌吃胡萝卜！', '胡萝卜含有丰富的维生素，对眼睛很好哦，试着吃一小口怎么样？', 3, '2026-04-08 12:10:00', 'admin', '0'),
(1002, '明天要考试了，我有点担心', '不要紧张，你已经复习得很好了，相信自己一定能行。', 4, '2026-04-10 19:30:00', 'admin', '0'),
(1002, '周末要去游乐园啦！', '那一定是非常开心的一天，提前祝你玩得愉快！', 1, '2026-04-12 14:20:00', 'admin', '0'),
(1002, '今天画了一幅画', '这幅画真漂亮，你的创造力越来越棒了。', 5, '2026-04-15 16:00:00', 'admin', '0'),
(1002, '和小朋友吵架了', '朋友之间难免会有摩擦，试着主动去沟通和好。', 2, '2026-04-18 17:30:00', 'admin', '0'),
(1002, '为什么天是蓝色的？', '因为阳光穿过大气层时，蓝光被散射得最多呀。', 5, '2026-04-20 11:20:00', 'admin', '0'),
(1002, '我赢了跑步比赛！', '太棒了，你是个小冠军！', 3, '2026-04-22 10:15:00', 'admin', '0'),
(1002, '今天学了首新歌', '真好听！音乐能让人心情愉悦。', 1, '2026-04-24 16:40:00', 'admin', '0');
