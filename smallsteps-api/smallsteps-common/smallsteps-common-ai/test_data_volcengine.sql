-- Small Steps 火山引擎 (Doubao/Ark) 核心配置脚本
-- 本脚本包含：1个供应商、5个高性价比核心模型、5个业务场景路由配置

-- 1. 确保供应商存在
-- 注意：如果 ID 冲突，请根据实际情况调整。1005 为预留给火山引擎的 ID。
INSERT INTO sys_ai_provider (id, name, type, base_url, api_key, status, create_by, create_time, remark)
VALUES (1005, '火山引擎 (Doubao/Ark)', 'openai_compatible', 'https://ark.cn-beijing.volces.com/api/v3', 'YOUR_API_KEY_HERE', '0', '1', NOW(), '火山引擎方舟服务');

-- 2. 配置 5 个性价比核心模型 (针对不同业务场景)
INSERT INTO sys_ai_model (id, provider_id, model_code, name, cost_input, cost_output, context_window, is_free_tier, status, create_by, create_time, remark)
VALUES 
(2005, 1005, 'ep-xxxx-pro-32k', 'Doubao-Pro-32k', 0.0008, 0.002, 32768, '0', '0', 1, NOW(), '核心场景：任务拆解'),
(2006, 1005, 'ep-xxxx-lite-32k', 'Doubao-Lite-32k', 0.0003, 0.0006, 32768, '0', '0', 1, NOW(), '高频场景：习惯打卡反馈'),
(2007, 1005, 'ep-xxxx-char-32k', 'Doubao-Character-32k', 0.0008, 0.002, 32768, '0', '0', 1, NOW(), '陪伴场景：树洞聊天伙伴'),
(2008, 1005, 'ep-xxxx-pro-128k', 'Doubao-Pro-128k', 0.005, 0.015, 131072, '0', '0', 1, NOW(), '分析场景：月度行为报告'),
(2009, 1005, 'ep-xxxx-vision', 'Doubao-Vision-Pro', 0.01, 0.01, 4096, '0', '0', 1, NOW(), '视觉场景：作品图片鼓励');

-- 3. 配置场景路由策略 (将业务场景映射到对应模型)
-- 如果记录已存在，请执行 UPDATE
INSERT INTO sys_ai_route (scene_key, strategy, default_model_id, update_by, update_time)
VALUES 
('TASK_BREAKDOWN', 'PRIORITY_LEVEL', 2005, 1, NOW()),
('HABIT_CHECKIN', 'PRIORITY_LEVEL', 2006, 1, NOW()),
('BUDDY_CHAT', 'PRIORITY_LEVEL', 2007, 1, NOW()),
('PARENT_REPORT', 'PRIORITY_LEVEL', 2008, 1, NOW()),
('VISION_ENCOURAGE', 'PRIORITY_LEVEL', 2009, 1, NOW());

-- 4. 如果是更新现有场景，可以使用以下语句：
-- UPDATE sys_ai_route SET default_model_id = 2005 WHERE scene_key = 'TASK_BREAKDOWN';
-- UPDATE sys_ai_route SET default_model_id = 2006 WHERE scene_key = 'HABIT_CHECKIN';
-- UPDATE sys_ai_route SET default_model_id = 2007 WHERE scene_key = 'BUDDY_CHAT';
-- UPDATE sys_ai_route SET default_model_id = 2008 WHERE scene_key = 'PARENT_REPORT';
-- UPDATE sys_ai_route SET default_model_id = 2009 WHERE scene_key = 'VISION_ENCOURAGE';
