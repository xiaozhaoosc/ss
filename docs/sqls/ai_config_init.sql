-- 1. 插入 AI 供应商 (vllm)
INSERT INTO sys_ai_provider (id, name, type, base_url, api_key, weight, status, del_flag, create_by, create_time, update_by, update_time)
VALUES (1001, 'vllm本地服务', 'openai', 'http://192.168.1.9:8002/v1', 'ken2zhao589612', 10, '0', '0', 1, NOW(), 1, NOW())
ON CONFLICT (id) DO NOTHING;

-- 2. 插入 AI 模型
-- 优先使用的 gemma-4-26b
INSERT INTO sys_ai_model (id, provider_id, model_code, name, cost_input, cost_output, context_window, is_free_tier, status, del_flag, create_by, create_time, update_by, update_time)
VALUES (2001, 1001, 'gemma-4-26b', 'Gemma-4-26b 模型', 0.00, 0.00, 24576, '1', '0', '0', 1, NOW(), 1, NOW())
ON CONFLICT (id) DO NOTHING;

-- qwen3.5-9b-q8_0
INSERT INTO sys_ai_model (id, provider_id, model_code, name, cost_input, cost_output, context_window, is_free_tier, status, del_flag, create_by, create_time, update_by, update_time)
VALUES (2002, 1001, 'qwen3.5-9b-q8_0', 'Qwen3.5-9b 模型', 0.00, 0.00, 24576, '1', '0', '0', 1, NOW(), 1, NOW())
ON CONFLICT (id) DO NOTHING;

-- 3. 插入或更新路由策略配置
-- 设定系统内各项主要场景的默认模型为 gemma-4-26b (ID: 2001)
-- 通用场景配置
INSERT INTO sys_ai_route (scene_key, strategy, default_model_id, config_json, create_by, create_time, update_by, update_time)
VALUES ('default_scene', 'PRIORITY_LEVEL', 2001, '{"fallback_model_id": 2002}', 1, NOW(), 1, NOW())
ON CONFLICT (scene_key) DO UPDATE SET default_model_id = 2001, config_json = '{"fallback_model_id": 2002}';

-- 情绪分析场景配置 (对应最新开发的情绪分析 Job)
INSERT INTO sys_ai_route (scene_key, strategy, default_model_id, config_json, create_by, create_time, update_by, update_time)
VALUES ('emotion_analysis_scene', 'PRIORITY_LEVEL', 2001, '{"fallback_model_id": 2002}', 1, NOW(), 1, NOW())
ON CONFLICT (scene_key) DO UPDATE SET default_model_id = 2001, config_json = '{"fallback_model_id": 2002}';
