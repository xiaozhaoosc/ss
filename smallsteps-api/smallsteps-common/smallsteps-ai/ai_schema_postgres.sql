-- AI 供应商表
CREATE TABLE IF NOT EXISTS sys_ai_provider (
  id bigint NOT NULL PRIMARY KEY,
  name varchar(100) NOT NULL,
  type varchar(50) NOT NULL,
  base_url varchar(255) DEFAULT NULL,
  api_key varchar(500) DEFAULT NULL,
  weight int DEFAULT 100,
  status char(1) DEFAULT '0',
  create_by bigint DEFAULT NULL,
  create_time timestamp DEFAULT NULL,
  update_by bigint DEFAULT NULL,
  update_time timestamp DEFAULT NULL,
  remark varchar(500) DEFAULT NULL,
  del_flag char(1) DEFAULT '0'
);

COMMENT ON TABLE sys_ai_provider IS 'AI供应商配置表';
COMMENT ON COLUMN sys_ai_provider.id IS '主键';
COMMENT ON COLUMN sys_ai_provider.name IS '供应商名称';

-- AI 模型表
CREATE TABLE IF NOT EXISTS sys_ai_model (
  id bigint NOT NULL PRIMARY KEY,
  provider_id bigint NOT NULL,
  model_code varchar(100) NOT NULL,
  name varchar(100) NOT NULL,
  cost_input decimal(10,6) DEFAULT 0.000000,
  cost_output decimal(10,6) DEFAULT 0.000000,
  context_window int DEFAULT 0,
  is_free_tier char(1) DEFAULT '0',
  status char(1) DEFAULT '0',
  create_by bigint DEFAULT NULL,
  create_time timestamp DEFAULT NULL,
  update_by bigint DEFAULT NULL,
  update_time timestamp DEFAULT NULL,
  remark varchar(500) DEFAULT NULL,
  del_flag char(1) DEFAULT '0'
);
COMMENT ON TABLE sys_ai_model IS 'AI模型配置表';

-- AI 路由策略表
CREATE TABLE IF NOT EXISTS sys_ai_route (
  scene_key varchar(50) NOT NULL PRIMARY KEY,
  strategy varchar(50) NOT NULL DEFAULT 'PRIORITY_LEVEL',
  default_model_id bigint DEFAULT NULL,
  config_json json DEFAULT NULL,
  update_by bigint DEFAULT NULL,
  update_time timestamp DEFAULT NULL
);
COMMENT ON TABLE sys_ai_route IS 'AI路由策略表';
