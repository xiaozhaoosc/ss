-- 1. 插入供应商 Zhipu (智谱AI)
INSERT INTO `sys_ai_provider` (`id`, `name`, `type`, `base_url`, `api_key`, `weight`, `status`) 
VALUES (1001, 'ZhipuBigModel', 'zhipu', 'https://open.bigmodel.cn/api/paas/v4/', 'encrypt_api_key_here', 10, '0');

-- 2. 插入模型
-- GLM-4-Flash (免费, 速度快)
INSERT INTO `sys_ai_model` (`id`, `provider_id`, `model_code`, `name`, `cost_input`, `cost_output`, `context_window`, `is_free_tier`, `status`) 
VALUES (2001, 1001, 'glm-4-flash', 'GLM-4 Flash (Free)', 0.00, 0.00, 128000, '1', '0');

-- GLM-4 (付费)
INSERT INTO `sys_ai_model` (`id`, `provider_id`, `model_code`, `name`, `cost_input`, `cost_output`, `context_window`, `is_free_tier`, `status`) 
VALUES (2002, 1001, 'glm-4', 'GLM-4 Pro', 10.00, 10.00, 128000, '0', '0');

-- 3. 配置默认路由策略 (Smart Chat)
INSERT INTO `sys_ai_route` (`scene_key`, `strategy`, `default_model_id`, `config_json`) 
VALUES ('smart_chat', 'PRIORITY_LEVEL', 2002, '{"priority_levels": ["FREE", "LOW_COST"]}');
