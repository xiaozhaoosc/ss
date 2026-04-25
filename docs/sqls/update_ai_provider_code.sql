-- 1. 为 sys_ai_provider 表增加 provider_code 字段
ALTER TABLE sys_ai_provider ADD COLUMN provider_code VARCHAR(50);
COMMENT ON COLUMN sys_ai_provider.provider_code IS '供应商代码 (如 ALIYUN, OPENAI)';

-- 2. 初始化现有数据的供应商代码
-- 假设 1001 是之前的 vllm 本地服务
UPDATE sys_ai_provider SET provider_code = 'VLLM' WHERE id = 1001;

-- 3. (可选) 如果你希望强制要求 provider_code 不能为空，可以在初始化后添加约束
-- ALTER TABLE sys_ai_provider ALTER COLUMN provider_code SET NOT NULL;
