-- 创建 ss_parent_task 表 (如果不存在)
CREATE TABLE IF NOT EXISTS ss_parent_task (
    task_id BIGSERIAL PRIMARY KEY,
    dept_id BIGINT,
    parent_id BIGINT,
    user_id BIGINT,
    title VARCHAR(255),
    description VARCHAR(500),
    icon VARCHAR(64),
    difficulty SMALLINT,
    prompt_level SMALLINT,
    cycle_type SMALLINT,
    reward_points INTEGER,
    light_effect VARCHAR(64),
    audio_effect VARCHAR(64),
    deadline TIMESTAMP,
    status CHAR(1),
    create_by VARCHAR(64) DEFAULT '',
    create_time TIMESTAMP,
    update_by VARCHAR(64) DEFAULT '',
    update_time TIMESTAMP,
    del_flag CHAR(1) DEFAULT '0'
);

-- 创建 ss_task_log 表 (如果不存在)
CREATE TABLE IF NOT EXISTS ss_task_log (
    id BIGSERIAL PRIMARY KEY,
    dept_id BIGINT,
    task_id BIGINT,
    child_id BIGINT,
    target_date DATE,
    actual_duration INTEGER,
    status CHAR(1),
    start_time TIMESTAMP,
    end_time TIMESTAMP,
    proof VARCHAR(500),
    autonomy_score SMALLINT,
    create_by VARCHAR(64) DEFAULT '',
    create_time TIMESTAMP,
    update_by VARCHAR(64) DEFAULT '',
    update_time TIMESTAMP,
    del_flag CHAR(1) DEFAULT '0'
);

-- 插入 ss_parent_task 测试数据
INSERT INTO ss_parent_task (task_id, dept_id, user_id, title, description, icon, difficulty, reward_points, status, create_time, del_flag)
VALUES 
(10001, 100, 1, '早晨洗漱', '自己独立完成刷牙洗脸', 'water_drop', 2, 10, '0', '2026-04-01 08:00:00', '0'),
(10002, 100, 1, '阅读绘本', '专心阅读绘本15分钟', 'menu_book', 3, 20, '0', '2026-04-02 08:00:00', '0'),
(10003, 100, 1, '整理玩具', '把玩过的玩具放回收纳箱', 'toys', 2, 15, '0', '2026-04-03 08:00:00', '0')
ON CONFLICT (task_id) DO NOTHING;

-- 插入 ss_task_log (执行记录) 测试数据，使用 child_id = 1002
INSERT INTO ss_task_log (id, dept_id, task_id, child_id, target_date, actual_duration, status, start_time, end_time, create_time, del_flag)
VALUES 
(20001, 100, 10001, 1002, CURRENT_DATE, 300, '2', CURRENT_TIMESTAMP - INTERVAL '2 hours', CURRENT_TIMESTAMP - INTERVAL '1 hour 55 minutes', CURRENT_TIMESTAMP - INTERVAL '2 hours', '0'),
(20002, 100, 10002, 1002, CURRENT_DATE, 900, '2', CURRENT_TIMESTAMP - INTERVAL '4 hours', CURRENT_TIMESTAMP - INTERVAL '3 hours 45 minutes', CURRENT_TIMESTAMP - INTERVAL '4 hours', '0'),
(20003, 100, 10003, 1002, CURRENT_DATE, 0, '1', CURRENT_TIMESTAMP - INTERVAL '10 minutes', NULL, CURRENT_TIMESTAMP - INTERVAL '10 minutes', '0')
ON CONFLICT (id) DO NOTHING;
