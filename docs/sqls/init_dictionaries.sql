-- -------------------------------------------------------------------------------------------------------------------
-- Small Steps Data Dictionary Initialization (Fixed for RuoYi-Vue-Plus Schema)
-- Author: Antigravity
-- Date: 2026-02-01
-- -------------------------------------------------------------------------------------------------------------------

-- 1. 任务类型 (ss_task_type)
INSERT INTO sys_dict_type (dict_id, dict_name, dict_type, create_by, create_time, remark, tenant_id) 
VALUES (100, 'Small Steps 任务类型', 'ss_task_type', 1, NOW(), '任务类型定义', '000000');

INSERT INTO sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, create_by, create_time, remark, tenant_id) VALUES 
(100, 1, '日常任务', '1', 'ss_task_type', '', 'primary', 'Y', 1, NOW(), 'Daily Task', '000000'),
(101, 2, '挑战任务', '2', 'ss_task_type', '', 'warning', 'N', 1, NOW(), 'Challenge Task', '000000'),
(102, 3, '临时任务', '3', 'ss_task_type', '', 'info',    'N', 1, NOW(), 'Ad-hoc Task', '000000');

-- 2. 任务分类 (ss_task_category)
INSERT INTO sys_dict_type (dict_id, dict_name, dict_type, create_by, create_time, remark, tenant_id) 
VALUES (101, 'Small Steps 任务分类', 'ss_task_category', 1, NOW(), '任务所属分类', '000000');

INSERT INTO sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, create_by, create_time, remark, tenant_id) VALUES 
(103, 1, '生活习惯', 'life',  'ss_task_category', '', 'default', 'Y', 1, NOW(), '', '000000'),
(104, 2, '学习成长', 'study', 'ss_task_category', '', 'default', 'N', 1, NOW(), '', '000000'),
(105, 3, '运动健康', 'sport', 'ss_task_category', '', 'default', 'N', 1, NOW(), '', '000000'),
(106, 4, '社交礼仪', 'social','ss_task_category', '', 'default', 'N', 1, NOW(), '', '000000');

-- 3. 难度等级 (ss_difficulty)
INSERT INTO sys_dict_type (dict_id, dict_name, dict_type, create_by, create_time, remark, tenant_id) 
VALUES (102, 'Small Steps 难度等级', 'ss_difficulty', 1, NOW(), '任务难度1-5', '000000');

INSERT INTO sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, create_by, create_time, remark, tenant_id) VALUES 
(107, 1, '简单', '1', 'ss_difficulty', '', 'success', 'Y', 1, NOW(), '', '000000'),
(108, 2, '普通', '2', 'ss_difficulty', '', 'info',    'N', 1, NOW(), '', '000000'),
(109, 3, '中等', '3', 'ss_difficulty', '', 'primary', 'N', 1, NOW(), '', '000000'),
(110, 4, '困难', '4', 'ss_difficulty', '', 'warning', 'N', 1, NOW(), '', '000000'),
(111, 5, '噩梦', '5', 'ss_difficulty', '', 'danger',  'N', 1, NOW(), '', '000000');

-- 4. 物品分类 (ss_item_category)
INSERT INTO sys_dict_type (dict_id, dict_name, dict_type, create_by, create_time, remark, tenant_id) 
VALUES (103, 'Small Steps 物品分类', 'ss_item_category', 1, NOW(), 'Avatar物品部位', '000000');

INSERT INTO sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, create_by, create_time, remark, tenant_id) VALUES 
(112, 1, '头部', 'head', 'ss_item_category', '', 'default', 'N', 1, NOW(), '', '000000'),
(113, 2, '身体', 'body', 'ss_item_category', '', 'default', 'N', 1, NOW(), '', '000000'),
(114, 3, '手持', 'hand', 'ss_item_category', '', 'default', 'N', 1, NOW(), '', '000000'),
(115, 4, '肤色', 'color','ss_item_category', '', 'default', 'N', 1, NOW(), '', '000000');

-- 5. 情绪标签 (ss_mood_type)
INSERT INTO sys_dict_type (dict_id, dict_name, dict_type, create_by, create_time, remark, tenant_id) 
VALUES (104, 'Small Steps 情绪标签', 'ss_mood_type', 1, NOW(), '情绪记录标签', '000000');

INSERT INTO sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, create_by, create_time, remark, tenant_id) VALUES 
(116, 1, '开心', 'happy',   'ss_mood_type', '', 'success', 'N', 1, NOW(), '', '000000'),
(117, 2, '难过', 'sad',     'ss_mood_type', '', 'primary', 'N', 1, NOW(), '', '000000'),
(118, 3, '生气', 'angry',   'ss_mood_type', '', 'danger',  'N', 1, NOW(), '', '000000'),
(119, 4, '焦虑', 'anxious', 'ss_mood_type', '', 'warning', 'N', 1, NOW(), '', '000000'),
(120, 5, '平静', 'calm',    'ss_mood_type', '', 'info',    'Y', 1, NOW(), '', '000000');

-- 6. 商品状态 (ss_reward_status)
INSERT INTO sys_dict_type (dict_id, dict_name, dict_type, create_by, create_time, remark, tenant_id) 
VALUES (105, 'Small Steps 商品状态', 'ss_reward_status', 1, NOW(), '奖励上架状态', '000000');

INSERT INTO sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, create_by, create_time, remark, tenant_id) VALUES 
(121, 1, '上架', '0', 'ss_reward_status', '', 'primary', 'Y', 1, NOW(), '', '000000'),
(122, 2, '下架', '1', 'ss_reward_status', '', 'danger',  'N', 1, NOW(), '', '000000');

-- 7. 兑换状态 (ss_exchange_status)
INSERT INTO sys_dict_type (dict_id, dict_name, dict_type, create_by, create_time, remark, tenant_id) 
VALUES (106, 'Small Steps 兑换状态', 'ss_exchange_status', 1, NOW(), '奖励兑换审批状态', '000000');

INSERT INTO sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, create_by, create_time, remark, tenant_id) VALUES 
(123, 1, '待批准', '0', 'ss_exchange_status', '', 'warning', 'Y', 1, NOW(), '', '000000'),
(124, 2, '已批准', '1', 'ss_exchange_status', '', 'success', 'N', 1, NOW(), '', '000000'),
(125, 3, '已拒绝', '2', 'ss_exchange_status', '', 'danger',  'N', 1, NOW(), '', '000000');

-- 8. 系统参数 (System Config)
-- 每日星星上限
INSERT INTO sys_config (config_id, config_name, config_key, config_value, config_type, create_by, create_time, remark, tenant_id)
VALUES (100, '每日星星获取上限', 'ss.star.daily_limit', '50', 'Y', 1, NOW(), 'Small Steps 每日获取星星限制', '000000');

-- 每日任务上限
INSERT INTO sys_config (config_id, config_name, config_key, config_value, config_type, create_by, create_time, remark, tenant_id)
VALUES (101, '每日任务数量上限', 'ss.task.max_count', '20', 'Y', 1, NOW(), 'Small Steps 每日最多创建任务数', '000000');

-- 硬件同步间隔
INSERT INTO sys_config (config_id, config_name, config_key, config_value, config_type, create_by, create_time, remark, tenant_id)
VALUES (102, '硬件同步间隔(秒)', 'ss.hw.sync_interval', '300', 'Y', 1, NOW(), 'Small Steps 硬件同步心跳间隔', '000000');
