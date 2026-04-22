-- 1. 插入 AI 供应商 (Provider)
INSERT INTO sys_ai_provider (id, name, type, base_url, api_key, weight, status, del_flag, create_time)
VALUES (1, 'VLLM-Local', 'vllm', 'http://localhost:8000/v1', 'no-key', 100, '0', '0', NOW());

-- 2. 插入 AI 模型 (Model)
INSERT INTO sys_ai_model (id, provider_id, model_code, name, cost_input, cost_output, context_window, is_free_tier, status, del_flag, create_time)
VALUES (1, 1, 'qwen-plus', '通义千问-Plus', 0, 0, 32768, '1', '0', '0', NOW());

-- 3. 插入 路由规则 (Route)
INSERT INTO sys_ai_route (scene_key, strategy, default_model_id, config_json, update_time)
VALUES ('task_breakdown', 'DEFAULT', 1, '{}'::json, NOW());
INSERT INTO sys_ai_route (scene_key, strategy, default_model_id, config_json, update_time)
VALUES ('emotion_analysis', 'DEFAULT', 1, '{}'::json, NOW());
