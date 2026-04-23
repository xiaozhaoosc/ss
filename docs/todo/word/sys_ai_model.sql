/*
 Navicat Premium Dump SQL

 Source Server         : ss
 Source Server Type    : PostgreSQL
 Source Server Version : 150015 (150015)
 Source Host           : 192.168.1.21:15432
 Source Catalog        : smallsteps_db
 Source Schema         : public

 Target Server Type    : PostgreSQL
 Target Server Version : 150015 (150015)
 File Encoding         : 65001

 Date: 23/04/2026 20:53:01
*/


-- ----------------------------
-- Table structure for sys_ai_model
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_ai_model";
CREATE TABLE "public"."sys_ai_model" (
  "id" int8 NOT NULL,
  "provider_id" int8 NOT NULL,
  "model_code" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "name" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "cost_input" numeric(10,6) DEFAULT 0.000000,
  "cost_output" numeric(10,6) DEFAULT 0.000000,
  "context_window" int4 DEFAULT 0,
  "is_free_tier" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar,
  "status" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar,
  "create_by" int8,
  "create_time" timestamp(6),
  "update_by" int8,
  "update_time" timestamp(6),
  "remark" varchar(500) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "del_flag" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar
)
;
COMMENT ON TABLE "public"."sys_ai_model" IS 'AI模型配置表';

-- ----------------------------
-- Records of sys_ai_model
-- ----------------------------
INSERT INTO "public"."sys_ai_model" VALUES (2001, 1001, 'gemma-4-26b', 'Gemma-4-26b 模型', 0.000000, 0.000000, 24576, '1', '0', 1, '2026-04-23 09:29:27.769615', 1, '2026-04-23 09:29:27.769615', NULL, '0');
INSERT INTO "public"."sys_ai_model" VALUES (2002, 1001, 'qwen3.5-9b-q8_0', 'Qwen3.5-9b 模型', 0.000000, 0.000000, 24576, '1', '0', 1, '2026-04-23 09:29:33.422423', 1, '2026-04-23 09:29:33.422423', NULL, '0');

-- ----------------------------
-- Table structure for sys_ai_prompt
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_ai_prompt";
CREATE TABLE "public"."sys_ai_prompt" (
  "id" int8 NOT NULL,
  "prompt_key" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "title" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "content" text COLLATE "pg_catalog"."default" NOT NULL,
  "model_id" int8,
  "status" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar,
  "del_flag" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar,
  "create_dept" int8,
  "create_by" int8,
  "create_time" timestamp(6),
  "update_by" int8,
  "update_time" timestamp(6),
  "remark" varchar(500) COLLATE "pg_catalog"."default"
)
;
COMMENT ON COLUMN "public"."sys_ai_prompt"."id" IS '主键ID';
COMMENT ON COLUMN "public"."sys_ai_prompt"."prompt_key" IS '业务标识 (如 TASK_BREAKDOWN)';
COMMENT ON COLUMN "public"."sys_ai_prompt"."title" IS '模板标题';
COMMENT ON COLUMN "public"."sys_ai_prompt"."content" IS '提示词内容';
COMMENT ON COLUMN "public"."sys_ai_prompt"."model_id" IS '关联模型ID';
COMMENT ON COLUMN "public"."sys_ai_prompt"."status" IS '状态 (0正常 1停用)';
COMMENT ON COLUMN "public"."sys_ai_prompt"."del_flag" IS '删除标志 (0代表存在 2代表删除)';
COMMENT ON TABLE "public"."sys_ai_prompt" IS 'AI提示词模板表';

-- ----------------------------
-- Records of sys_ai_prompt
-- ----------------------------
INSERT INTO "public"."sys_ai_prompt" VALUES (1, 'TASK_BREAKDOWN', 'ADHD任务拆解模板', '你是一个资深的 ADHD 儿童行为干预专家。
现在的任务是：{taskName}
任务描述：{taskDesc}
孩子年龄：{childAge} 岁

请将该任务拆解为 3-5 个具体的、可立即执行的“微小步骤”。
要求：
1. 使用“动作”导向的语言（例如：“拿起笔”而不是“准备写作业”）。
2. 每一步不超过 15 个字。
3. 语气柔和、鼓励。
请以 JSON 格式返回：[{"step": "步骤内容", "order": 1}]', NULL, '0', '0', NULL, 1, '2026-04-23 20:33:17.803189', NULL, NULL, '初始任务拆解模板');

-- ----------------------------
-- Table structure for sys_ai_provider
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_ai_provider";
CREATE TABLE "public"."sys_ai_provider" (
  "id" int8 NOT NULL,
  "name" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "type" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "base_url" varchar(255) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "api_key" varchar(500) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "weight" int4 DEFAULT 100,
  "status" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar,
  "create_by" int8,
  "create_time" timestamp(6),
  "update_by" int8,
  "update_time" timestamp(6),
  "remark" varchar(500) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "del_flag" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar
)
;
COMMENT ON COLUMN "public"."sys_ai_provider"."id" IS '主键';
COMMENT ON COLUMN "public"."sys_ai_provider"."name" IS '供应商名称';
COMMENT ON TABLE "public"."sys_ai_provider" IS 'AI供应商配置表';

-- ----------------------------
-- Records of sys_ai_provider
-- ----------------------------
INSERT INTO "public"."sys_ai_provider" VALUES (2, 'VLLM-Local', 'vllm', 'http://localhost:8003/v1', 'no-key', 100, '0', NULL, '2026-04-23 00:19:34.801257', NULL, NULL, NULL, '0');
INSERT INTO "public"."sys_ai_provider" VALUES (1, 'VLLM-Local', 'vllm', 'http://localhost:8002/v1', 'no-key', 100, '0', NULL, '2026-04-22 23:50:38.913811', NULL, NULL, NULL, '0');
INSERT INTO "public"."sys_ai_provider" VALUES (1001, 'vllm本地服务', 'openai', 'http://192.168.1.9:8002/v1', 'ken2zhao589612', 10, '0', 1, '2026-04-23 09:29:22.432987', 1, '2026-04-23 09:29:22.432987', NULL, '0');

-- ----------------------------
-- Table structure for sys_ai_route
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_ai_route";
CREATE TABLE "public"."sys_ai_route" (
  "scene_key" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "strategy" varchar(50) COLLATE "pg_catalog"."default" NOT NULL DEFAULT 'PRIORITY_LEVEL'::character varying,
  "default_model_id" int8,
  "config_json" json,
  "update_by" int8,
  "update_time" timestamp(6),
  "create_by" int8,
  "create_time" timestamp(6)
)
;
COMMENT ON COLUMN "public"."sys_ai_route"."create_by" IS '创建者';
COMMENT ON COLUMN "public"."sys_ai_route"."create_time" IS '创建时间';
COMMENT ON TABLE "public"."sys_ai_route" IS 'AI路由策略表';

-- ----------------------------
-- Records of sys_ai_route
-- ----------------------------
INSERT INTO "public"."sys_ai_route" VALUES ('emotion_analysis_scene', 'PRIORITY_LEVEL', 2001, '{"fallback_model_id": 2002}', 1, '2026-04-23 09:39:20.282997', 1, '2026-04-23 09:39:20.282997');
INSERT INTO "public"."sys_ai_route" VALUES ('default_scene', 'PRIORITY_LEVEL', 2001, '{"fallback_model_id": 2002}', 1, '2026-04-23 09:39:24.579749', 1, '2026-04-23 09:39:24.579749');

-- ----------------------------
-- Indexes structure for table sys_ai_prompt
-- ----------------------------
CREATE UNIQUE INDEX "idx_sys_ai_prompt_key" ON "public"."sys_ai_prompt" USING btree (
  "prompt_key" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE del_flag = '0'::bpchar;

-- ----------------------------
-- Primary Key structure for table sys_ai_prompt
-- ----------------------------
ALTER TABLE "public"."sys_ai_prompt" ADD CONSTRAINT "sys_ai_prompt_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table sys_ai_route
-- ----------------------------
ALTER TABLE "public"."sys_ai_route" ADD CONSTRAINT "sys_ai_route_pkey" PRIMARY KEY ("scene_key");
