-- -------------------------------------------------------------------------------------------------------------------
-- Small Steps 租户与测试数据初始化脚本 (PostgreSQL)
-- Author: Antigravity
-- Date: 2026-02-06
-- Description: 创建 Small Steps 租户、测试用户、角色关联和完整的业务测试数据
-- -------------------------------------------------------------------------------------------------------------------

-- ========================================
-- 1. 创建 Small Steps 租户
-- ========================================

-- 租户基本信息
INSERT INTO sys_tenant VALUES(
  2,                          -- id
  'SS0001',                   -- tenant_id (租户编号)
  '张伟',                     -- contact_user_name (联系人)
  '13800138001',              -- contact_phone
  'Small Steps 家庭',         -- company_name
  null,                       -- license_number
  '北京市朝阳区',             -- address
  'Small Steps ADHD 儿童行为习惯辅助系统测试租户', -- intro
  null,                       -- domain
  '测试租户',                 -- remark
  null,                       -- package_id
  '2027-12-31 23:59:59',      -- expire_time
  -1,                         -- account_count (-1 不限制)
  '0',                        -- status (0正常)
  '0',                        -- del_flag
  103,                        -- create_dept
  1,                          -- create_by
  now(),                      -- create_time
  null,                       -- update_by
  null                        -- update_time
) ON CONFLICT (id) DO UPDATE SET
  company_name = EXCLUDED.company_name,
  intro = EXCLUDED.intro,
  update_time = now();


-- ========================================
-- 2. 创建测试部门
-- ========================================

-- Small Steps 家庭部门
INSERT INTO sys_dept VALUES(
  200,                        -- dept_id
  'SS0001',                   -- tenant_id
  0,                          -- parent_id (顶级部门)
  '0',                        -- ancestors
  'Small Steps 家庭',         -- dept_name
  null,                       -- dept_category
  1,                          -- order_num
  null,                       -- leader
  '13800138001',              -- phone
  'smallsteps@example.com',   -- email
  '0',                        -- status (0正常)
  '0',                        -- del_flag
  103,                        -- create_dept
  1,                          -- create_by
  now(),                      -- create_time
  null,                       -- update_by
  null                        -- update_time
) ON CONFLICT (dept_id) DO UPDATE SET
  dept_name = EXCLUDED.dept_name,
  update_time = now();


-- ========================================
-- 3. 创建测试用户
-- ========================================

-- 3.1 家长用户 - 张伟 (父亲)
INSERT INTO sys_user VALUES(
  1000,                       -- user_id
  'SS0001',                   -- tenant_id
  200,                        -- dept_id
  'parent_zhang',             -- user_name
  '张伟',                     -- nick_name
  'sys_user',                 -- user_type
  'zhangwei@example.com',     -- email
  '13800138001',              -- phonenumber
  '0',                        -- sex (0男)
  null,                       -- avatar
  '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', -- password (admin123)
  '0',                        -- status (0正常)
  '0',                        -- del_flag
  '127.0.0.1',                -- login_ip
  now(),                      -- login_date
  200,                        -- create_dept
  1,                          -- create_by
  now(),                      -- create_time
  null,                       -- update_by
  null,                       -- update_time
  '家长测试账号 - 密码: admin123'  -- remark
) ON CONFLICT (user_id) DO UPDATE SET
  nick_name = EXCLUDED.nick_name,
  update_time = now();

-- 3.2 家长用户 - 李娜 (母亲)
INSERT INTO sys_user VALUES(
  1001,                       -- user_id
  'SS0001',                   -- tenant_id
  200,                        -- dept_id
  'parent_li',                -- user_name
  '李娜',                     -- nick_name
  'sys_user',                 -- user_type
  'lina@example.com',         -- email
  '13800138002',              -- phonenumber
  '1',                        -- sex (1女)
  null,                       -- avatar
  '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', -- password (admin123)
  '0',                        -- status (0正常)
  '0',                        -- del_flag
  '127.0.0.1',                -- login_ip
  now(),                      -- login_date
  200,                        -- create_dept
  1,                          -- create_by
  now(),                      -- create_time
  null,                       -- update_by
  null,                       -- update_time
  '家长测试账号 - 密码: admin123'  -- remark
) ON CONFLICT (user_id) DO UPDATE SET
  nick_name = EXCLUDED.nick_name,
  update_time = now();

-- 3.3 儿童用户 - 张小明
INSERT INTO sys_user VALUES(
  1002,                       -- user_id
  'SS0001',                   -- tenant_id
  200,                        -- dept_id
  'child_xiaoming',           -- user_name
  '张小明',                   -- nick_name
  'sys_user',                 -- user_type
  '',                         -- email
  '',                         -- phonenumber
  '0',                        -- sex (0男)
  null,                       -- avatar
  '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', -- password (admin123)
  '0',                        -- status (0正常)
  '0',                        -- del_flag
  '127.0.0.1',                -- login_ip
  now(),                      -- login_date
  200,                        -- create_dept
  1,                          -- create_by
  now(),                      -- create_time
  null,                       -- update_by
  null,                       -- update_time
  '儿童测试账号 - 密码: admin123'  -- remark
) ON CONFLICT (user_id) DO UPDATE SET
  nick_name = EXCLUDED.nick_name,
  update_time = now();

-- 3.4 儿童用户 - 张小红
INSERT INTO sys_user VALUES(
  1003,                       -- user_id
  'SS0001',                   -- tenant_id
  200,                        -- dept_id
  'child_xiaohong',           -- user_name
  '张小红',                   -- nick_name
  'sys_user',                 -- user_type
  '',                         -- email
  '',                         -- phonenumber
  '1',                        -- sex (1女)
  null,                       -- avatar
  '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', -- password (admin123)
  '0',                        -- status (0正常)
  '0',                        -- del_flag
  '127.0.0.1',                -- login_ip
  now(),                      -- login_date
  200,                        -- create_dept
  1,                          -- create_by
  now(),                      -- create_time
  null,                       -- update_by
  null,                       -- update_time
  '儿童测试账号 - 密码: admin123'  -- remark
) ON CONFLICT (user_id) DO UPDATE SET
  nick_name = EXCLUDED.nick_name,
  update_time = now();


-- ========================================
-- 4. 用户角色关联
-- ========================================

-- 张伟 -> 家长角色
INSERT INTO sys_user_role VALUES (1000, 10) ON CONFLICT DO NOTHING;

-- 李娜 -> 家长角色
INSERT INTO sys_user_role VALUES (1001, 10) ON CONFLICT DO NOTHING;

-- 张小明 -> 儿童角色
INSERT INTO sys_user_role VALUES (1002, 11) ON CONFLICT DO NOTHING;

-- 张小红 -> 儿童角色
INSERT INTO sys_user_role VALUES (1003, 11) ON CONFLICT DO NOTHING;


-- ========================================
-- 5. 创建儿童档案
-- ========================================

-- 5.1 张小明的档案
INSERT INTO ss_child VALUES(
  10001,                      -- id
  'SS0001',                   -- tenant_id
  1000,                       -- parent_id (张伟)
  '小明',                     -- nickname
  '/avatar/boy1.png',         -- avatar_url
  '{"hair":"short","clothes":"blue","accessories":"glasses"}'::jsonb, -- avatar_config
  3,                          -- level
  '{"maxTasksPerDay":5,"maxScreenTime":60}'::jsonb, -- daily_config
  '0',                        -- gender (0男)
  '2016-05-15 00:00:00',      -- birthday
  150,                        -- star_balance (当前星星余额)
  580,                        -- total_stars (累计获得星星)
  '["注意力不集中","多动","冲动"]'::jsonb, -- challenges
  200,                        -- create_dept
  1000,                       -- create_by
  now(),                      -- create_time
  null,                       -- update_by
  null,                       -- update_time
  '9岁男孩，ADHD，喜欢恐龙和乐高', -- remark
  '0'                         -- del_flag
) ON CONFLICT (id) DO UPDATE SET
  nickname = EXCLUDED.nickname,
  level = EXCLUDED.level,
  star_balance = EXCLUDED.star_balance,
  total_stars = EXCLUDED.total_stars,
  update_time = now();

-- 5.2 张小红的档案
INSERT INTO ss_child VALUES(
  10002,                      -- id
  'SS0001',                   -- tenant_id
  1000,                       -- parent_id (张伟)
  '小红',                     -- nickname
  '/avatar/girl1.png',        -- avatar_url
  '{"hair":"long","clothes":"pink","accessories":"bow"}'::jsonb, -- avatar_config
  2,                          -- level
  '{"maxTasksPerDay":4,"maxScreenTime":45}'::jsonb, -- daily_config
  '1',                        -- gender (1女)
  '2018-08-20 00:00:00',      -- birthday
  80,                         -- star_balance
  220,                        -- total_stars
  '["注意力不集中","情绪波动"]'::jsonb, -- challenges
  200,                        -- create_dept
  1000,                       -- create_by
  now(),                      -- create_time
  null,                       -- update_by
  null,                       -- update_time
  '7岁女孩，ADHD，喜欢画画和跳舞', -- remark
  '0'                         -- del_flag
) ON CONFLICT (id) DO UPDATE SET
  nickname = EXCLUDED.nickname,
  level = EXCLUDED.level,
  star_balance = EXCLUDED.star_balance,
  total_stars = EXCLUDED.total_stars,
  update_time = now();


-- ========================================
-- 6. 创建任务配置
-- ========================================

-- 6.1 早晨任务 - 刷牙洗脸
INSERT INTO ss_task VALUES(
  20001,                      -- id
  'SS0001',                   -- tenant_id
  10001,                      -- child_id (张小明)
  '早晨刷牙洗脸',             -- title
  '🪥',                       -- icon
  5,                          -- star_reward
  1,                          -- difficulty
  '1',                        -- type (1日常任务)
  '0 7 * * *',                -- schedule_conf (每天7点)
  '[{"step":"拿起牙刷","done":false},{"step":"挤牙膏","done":false},{"step":"刷牙2分钟","done":false},{"step":"洗脸","done":false}]'::jsonb, -- sub_tasks
  '/audio/morning_routine.mp3', -- voice_prompt
  '/guide/brush_teeth.png',   -- guide_image
  '0',                        -- status (0启用)
  200,                        -- create_dept
  1000,                       -- create_by
  now(),                      -- create_time
  null,                       -- update_by
  null,                       -- update_time
  '0'                         -- del_flag
) ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  update_time = now();

-- 6.2 作业任务
INSERT INTO ss_task VALUES(
  20002,                      -- id
  'SS0001',                   -- tenant_id
  10001,                      -- child_id
  '完成今天的作业',           -- title
  '📚',                       -- icon
  10,                         -- star_reward
  3,                          -- difficulty
  '1',                        -- type
  '0 16 * * 1-5',             -- schedule_conf (周一到周五16点)
  '[{"step":"拿出作业本","done":false},{"step":"写数学作业","done":false},{"step":"写语文作业","done":false},{"step":"检查作业","done":false}]'::jsonb,
  '/audio/homework_time.mp3',
  '/guide/homework.png',
  '0',                        -- status
  200,
  1000,
  now(),
  null,
  null,
  '0'
) ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  update_time = now();

-- 6.3 整理书包
INSERT INTO ss_task VALUES(
  20003,
  'SS0001',
  10001,
  '整理书包',
  '🎒',
  5,
  2,
  '1',
  '0 20 * * 0-4',             -- 周日到周四晚上8点
  '[{"step":"拿出所有东西","done":false},{"step":"检查明天课表","done":false},{"step":"放入需要的书本","done":false},{"step":"检查文具","done":false}]'::jsonb,
  '/audio/pack_bag.mp3',
  '/guide/pack_bag.png',
  '0',
  200,
  1000,
  now(),
  null,
  null,
  '0'
) ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  update_time = now();

-- 6.4 小红的任务 - 早晨刷牙
INSERT INTO ss_task VALUES(
  20004,
  'SS0001',
  10002,                      -- child_id (张小红)
  '早晨刷牙洗脸',
  '🪥',
  5,
  1,
  '1',
  '0 7 * * *',
  '[{"step":"拿起牙刷","done":false},{"step":"挤牙膏","done":false},{"step":"刷牙2分钟","done":false}]'::jsonb,
  '/audio/morning_routine.mp3',
  '/guide/brush_teeth.png',
  '0',
  200,
  1000,
  now(),
  null,
  null,
  '0'
) ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  update_time = now();


-- ========================================
-- 7. 创建任务执行记录
-- ========================================

-- 小明最近7天的任务记录
INSERT INTO ss_task_log VALUES(20101, 'SS0001', 20001, 10001, now() - interval '6 days', '1', '/proof/photo1.jpg', 5, '早晨刷牙洗脸', now() - interval '6 days') ON CONFLICT (id) DO NOTHING;
INSERT INTO ss_task_log VALUES(20102, 'SS0001', 20001, 10001, now() - interval '5 days', '1', '/proof/photo2.jpg', 5, '早晨刷牙洗脸', now() - interval '5 days') ON CONFLICT (id) DO NOTHING;
INSERT INTO ss_task_log VALUES(20103, 'SS0001', 20001, 10001, now() - interval '4 days', '1', '/proof/photo3.jpg', 5, '早晨刷牙洗脸', now() - interval '4 days') ON CONFLICT (id) DO NOTHING;
INSERT INTO ss_task_log VALUES(20104, 'SS0001', 20002, 10001, now() - interval '3 days', '1', '/proof/homework1.jpg', 10, '完成今天的作业', now() - interval '3 days') ON CONFLICT (id) DO NOTHING;
INSERT INTO ss_task_log VALUES(20105, 'SS0001', 20003, 10001, now() - interval '2 days', '1', '', 5, '整理书包', now() - interval '2 days') ON CONFLICT (id) DO NOTHING;
INSERT INTO ss_task_log VALUES(20106, 'SS0001', 20001, 10001, now() - interval '1 day', '1', '/proof/photo4.jpg', 5, '早晨刷牙洗脸', now() - interval '1 day') ON CONFLICT (id) DO NOTHING;
INSERT INTO ss_task_log VALUES(20107, 'SS0001', 20002, 10001, now() - interval '1 day', '1', '/proof/homework2.jpg', 10, '完成今天的作业', now() - interval '1 day') ON CONFLICT (id) DO NOTHING;


-- ========================================
-- 8. 创建奖励配置
-- ========================================

-- 8.1 小明的奖励
INSERT INTO ss_reward VALUES(
  30001,
  'SS0001',
  10001,                      -- child_id (张小明)
  '玩30分钟游戏',
  '🎮',
  20,                         -- star_cost
  -1,                         -- stock (-1无限)
  '0',                        -- status (0上架)
  200,
  1000,
  now(),
  null,
  null,
  '0'
) ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  update_time = now();

INSERT INTO ss_reward VALUES(
  30002,
  'SS0001',
  10001,
  '乐高积木一套',
  '🧱',
  100,
  3,                          -- stock (库存3个)
  '0',
  200,
  1000,
  now(),
  null,
  null,
  '0'
) ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  update_time = now();

INSERT INTO ss_reward VALUES(
  30003,
  'SS0001',
  10001,
  '去动物园',
  '🦁',
  150,
  1,
  '0',
  200,
  1000,
  now(),
  null,
  null,
  '0'
) ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  update_time = now();

-- 8.2 小红的奖励
INSERT INTO ss_reward VALUES(
  30004,
  'SS0001',
  10002,                      -- child_id (张小红)
  '看动画片30分钟',
  '📺',
  15,
  -1,
  '0',
  200,
  1000,
  now(),
  null,
  null,
  '0'
) ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  update_time = now();

INSERT INTO ss_reward VALUES(
  30005,
  'SS0001',
  10002,
  '新的画笔套装',
  '🎨',
  80,
  2,
  '0',
  200,
  1000,
  now(),
  null,
  null,
  '0'
) ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  update_time = now();


-- ========================================
-- 9. 创建奖励兑换记录
-- ========================================

INSERT INTO ss_reward_exchange VALUES(
  40001,
  'SS0001',
  30001,                      -- reward_id (玩游戏)
  10001,                      -- child_id (张小明)
  '{"name":"玩30分钟游戏","icon":"🎮"}',
  20,                         -- cost
  now() - interval '3 days', -- exchange_time
  '1',                        -- status (1已发放)
  1000,
  now() - interval '3 days'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO ss_reward_exchange VALUES(
  40002,
  'SS0001',
  30002,                      -- reward_id (乐高)
  10001,
  '{"name":"乐高积木一套","icon":"🧱"}',
  100,
  now() - interval '1 day',
  '1',
  1000,
  now() - interval '1 day'
) ON CONFLICT (id) DO NOTHING;


-- ========================================
-- 10. 创建星星流水记录
-- ========================================

-- 小明的星星流水
INSERT INTO ss_star_record VALUES(50001, 'SS0001', 10001, 5, '完成早晨刷牙洗脸', '1', 20101, now() - interval '6 days') ON CONFLICT (id) DO NOTHING;
INSERT INTO ss_star_record VALUES(50002, 'SS0001', 10001, 5, '完成早晨刷牙洗脸', '1', 20102, now() - interval '5 days') ON CONFLICT (id) DO NOTHING;
INSERT INTO ss_star_record VALUES(50003, 'SS0001', 10001, 5, '完成早晨刷牙洗脸', '1', 20103, now() - interval '4 days') ON CONFLICT (id) DO NOTHING;
INSERT INTO ss_star_record VALUES(50004, 'SS0001', 10001, 10, '完成今天的作业', '1', 20104, now() - interval '3 days') ON CONFLICT (id) DO NOTHING;
INSERT INTO ss_star_record VALUES(50005, 'SS0001', 10001, -20, '兑换玩游戏奖励', '2', 40001, now() - interval '3 days') ON CONFLICT (id) DO NOTHING;
INSERT INTO ss_star_record VALUES(50006, 'SS0001', 10001, 5, '整理书包', '1', 20105, now() - interval '2 days') ON CONFLICT (id) DO NOTHING;
INSERT INTO ss_star_record VALUES(50007, 'SS0001', 10001, 5, '完成早晨刷牙洗脸', '1', 20106, now() - interval '1 day') ON CONFLICT (id) DO NOTHING;
INSERT INTO ss_star_record VALUES(50008, 'SS0001', 10001, 10, '完成今天的作业', '1', 20107, now() - interval '1 day') ON CONFLICT (id) DO NOTHING;
INSERT INTO ss_star_record VALUES(50009, 'SS0001', 10001, -100, '兑换乐高积木', '2', 40002, now() - interval '1 day') ON CONFLICT (id) DO NOTHING;


-- ========================================
-- 11. 创建情绪记录
-- ========================================

INSERT INTO ss_emotion_record VALUES(
  60001,
  'SS0001',
  10001,                      -- child_id (张小明)
  4,                          -- mood_level (1-5, 4表示开心)
  'happy',                    -- mood_type
  '今天完成了作业，爸爸表扬我了！',
  '/audio/emotion1.mp3',
  '做得很棒！继续保持！',  -- parent_feedback
  '1',                        -- is_read
  now() - interval '2 days',
  now() - interval '2 days'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO ss_emotion_record VALUES(
  60002,
  'SS0001',
  10001,
  2,                          -- mood_level (2表示有点难过)
  'sad',
  '今天数学题太难了，我做不出来',
  '/audio/emotion2.mp3',
  '没关系，我们一起慢慢来，你可以的！',
  '1',
  now() - interval '1 day',
  now() - interval '1 day'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO ss_emotion_record VALUES(
  60003,
  'SS0001',
  10001,
  5,                          -- mood_level (5表示非常开心)
  'excited',
  '我今天用星星换了乐高！',
  '/audio/emotion3.mp3',
  '',                         -- parent_feedback (未读)
  '0',                        -- is_read
  now(),
  now()
) ON CONFLICT (id) DO NOTHING;


-- ========================================
-- 12. 创建设备绑定
-- ========================================

INSERT INTO ss_device VALUES(
  70001,
  'SS0001',
  'SS-ESP32-00001',           -- serial_number
  10001,                      -- child_id (张小明)
  '0',                        -- status (0在线)
  '{"brightness":80,"volume":60,"language":"zh-CN"}'::jsonb, -- settings
  85,                         -- battery_level
  now(),                      -- last_active
  'v1.0.2',                   -- fw_version
  200,
  1000,
  now(),
  null,
  null,
  '小明的小步设备'
) ON CONFLICT (id) DO UPDATE SET
  child_id = EXCLUDED.child_id,
  battery_level = EXCLUDED.battery_level,
  last_active = EXCLUDED.last_active,
  update_time = now();


-- ========================================
-- 13. 创建家庭成员关联
-- ========================================

-- 张伟 - 小明的爸爸
INSERT INTO ss_family_member VALUES(
  80001,
  'SS0001',
  10001,                      -- child_id (张小明)
  1000,                       -- user_id (张伟)
  '爸爸',                     -- role
  '{"canEditTask":true,"canViewEmotion":true,"canManageDevice":true}'::jsonb, -- permissions
  now()
) ON CONFLICT (id) DO NOTHING;

-- 李娜 - 小明的妈妈
INSERT INTO ss_family_member VALUES(
  80002,
  'SS0001',
  10001,
  1001,                       -- user_id (李娜)
  '妈妈',
  '{"canEditTask":true,"canViewEmotion":true,"canManageDevice":true}'::jsonb,
  now()
) ON CONFLICT (id) DO NOTHING;

-- 张伟 - 小红的爸爸
INSERT INTO ss_family_member VALUES(
  80003,
  'SS0001',
  10002,                      -- child_id (张小红)
  1000,
  '爸爸',
  '{"canEditTask":true,"canViewEmotion":true,"canManageDevice":true}'::jsonb,
  now()
) ON CONFLICT (id) DO NOTHING;

-- 李娜 - 小红的妈妈
INSERT INTO ss_family_member VALUES(
  80004,
  'SS0001',
  10002,
  1001,
  '妈妈',
  '{"canEditTask":true,"canViewEmotion":true,"canManageDevice":true}'::jsonb,
  now()
) ON CONFLICT (id) DO NOTHING;


-- ========================================
-- 14. 测试账号信息汇总
-- ========================================

/*
租户信息：
  租户编号: SS0001
  租户名称: Small Steps 家庭
  联系人: 张伟
  电话: 13800138001

测试账号（密码统一为: admin123）：

家长端账号：
  1. 用户名: parent_zhang
     姓名: 张伟 (父亲)
     角色: 家长 (parent)
     权限: parent:*
     
  2. 用户名: parent_li
     姓名: 李娜 (母亲)
     角色: 家长 (parent)
     权限: parent:*

儿童端账号：
  1. 用户名: child_xiaoming
     姓名: 张小明 (9岁男孩)
     角色: 儿童 (child)
     权限: child:*
     星星余额: 150
     累计星星: 580
     
  2. 用户名: child_xiaohong
     姓名: 张小红 (7岁女孩)
     角色: 儿童 (child)
     权限: child:*
     星星余额: 80
     累计星星: 220

业务数据：
  - 4个任务配置
  - 7条任务完成记录
  - 5个奖励配置
  - 2条兑换记录
  - 9条星星流水
  - 3条情绪记录
  - 1个设备绑定
  - 4条家庭成员关联

使用说明：
  1. 家长可以使用 parent_zhang 或 parent_li 登录家长端
  2. 儿童可以使用 child_xiaoming 或 child_xiaohong 登录儿童端
  3. 所有账号密码均为: admin123
  4. 家长可以查看和管理两个孩子的所有数据
  5. 儿童只能查看自己的任务、奖励和成就
*/
