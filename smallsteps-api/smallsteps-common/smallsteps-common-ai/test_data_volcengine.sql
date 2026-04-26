-- 火山引擎（豆包/Ark）测试数据初始化
-- 注意：由于数据库使用了应用级 ID 生成（如 Snowflake），手动插入时必须指定 ID。
-- 这里我们指定 Provider ID 为 1005，Model ID 为 2005，以避免与现有的小 ID 冲突。

-- 1. 添加供应商 (火山方舟)
INSERT INTO sys_ai_provider (id, name, type, base_url, api_key, status, create_by, create_time, remark)
VALUES (1005, '火山引擎 (Doubao/Ark)', 'openai_compatible', 'https://ark.cn-beijing.volces.com/api/v3', 'YOUR_API_KEY', '0', '1', NOW(), '火山引擎方舟大模型服务')
ON CONFLICT (id) DO UPDATE SET api_key = EXCLUDED.api_key;

-- 2. 添加模型配置 (以 Doubao-pro-4k 为例)
INSERT INTO sys_ai_model (id, provider_id, model_code, name, cost_input, cost_output, context_window, is_free_tier, create_by, create_time, remark)
VALUES (2005, 1005, 'ep-xxxxxx-xxxx', 'Doubao-pro-4k', 0.8, 2.0, 4096, '0', '1', NOW(), '豆包 Pro 4k 接入点')
ON CONFLICT (id) DO UPDATE SET model_code = EXCLUDED.model_code;

-- 3. 切换路由 (可选：将任务拆解场景默认切换到豆包)
UPDATE sys_ai_route SET default_model_id = 2005 WHERE scene_key = 'TASK_BREAKDOWN';
