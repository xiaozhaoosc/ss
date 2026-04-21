/*
 Navicat Premium Dump SQL

 Source Server         : smallsteps-localhost
 Source Server Type    : PostgreSQL
 Source Server Version : 150015 (150015)
 Source Host           : 192.168.1.21:15432
 Source Catalog        : smallsteps_db
 Source Schema         : public

 Target Server Type    : PostgreSQL
 Target Server Version : 150015 (150015)
 File Encoding         : 65001

 Date: 20/04/2026 02:08:23
*/


-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS "public"."gen_table";
CREATE TABLE "public"."gen_table" (
  "table_id" int8 NOT NULL,
  "data_name" varchar(200) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "table_name" varchar(200) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "table_comment" varchar(500) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "sub_table_name" varchar(64) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "sub_table_fk_name" varchar(64) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "class_name" varchar(100) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "tpl_category" varchar(200) COLLATE "pg_catalog"."default" DEFAULT 'crud'::character varying,
  "package_name" varchar(100) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "module_name" varchar(30) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "business_name" varchar(30) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "function_name" varchar(50) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "function_author" varchar(50) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "gen_type" char(1) COLLATE "pg_catalog"."default" NOT NULL DEFAULT '0'::bpchar,
  "gen_path" varchar(200) COLLATE "pg_catalog"."default" DEFAULT '/'::character varying,
  "options" varchar(1000) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "create_dept" int8,
  "create_by" int8,
  "create_time" timestamp(6),
  "update_by" int8,
  "update_time" timestamp(6),
  "remark" varchar(500) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying
)
;
COMMENT ON COLUMN "public"."gen_table"."table_id" IS '编号';
COMMENT ON COLUMN "public"."gen_table"."data_name" IS '数据源名称';
COMMENT ON COLUMN "public"."gen_table"."table_name" IS '表名称';
COMMENT ON COLUMN "public"."gen_table"."table_comment" IS '表描述';
COMMENT ON COLUMN "public"."gen_table"."sub_table_name" IS '关联子表的表名';
COMMENT ON COLUMN "public"."gen_table"."sub_table_fk_name" IS '子表关联的外键名';
COMMENT ON COLUMN "public"."gen_table"."class_name" IS '实体类名称';
COMMENT ON COLUMN "public"."gen_table"."tpl_category" IS '使用的模板（CRUD单表操作 TREE树表操作）';
COMMENT ON COLUMN "public"."gen_table"."package_name" IS '生成包路径';
COMMENT ON COLUMN "public"."gen_table"."module_name" IS '生成模块名';
COMMENT ON COLUMN "public"."gen_table"."business_name" IS '生成业务名';
COMMENT ON COLUMN "public"."gen_table"."function_name" IS '生成功能名';
COMMENT ON COLUMN "public"."gen_table"."function_author" IS '生成功能作者';
COMMENT ON COLUMN "public"."gen_table"."gen_type" IS '生成代码方式（0zip压缩包 1自定义路径）';
COMMENT ON COLUMN "public"."gen_table"."gen_path" IS '生成路径（不填默认项目路径）';
COMMENT ON COLUMN "public"."gen_table"."options" IS '其它生成选项';
COMMENT ON COLUMN "public"."gen_table"."create_dept" IS '创建部门';
COMMENT ON COLUMN "public"."gen_table"."create_by" IS '创建者';
COMMENT ON COLUMN "public"."gen_table"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."gen_table"."update_by" IS '更新者';
COMMENT ON COLUMN "public"."gen_table"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."gen_table"."remark" IS '备注';
COMMENT ON TABLE "public"."gen_table" IS '代码生成业务表';

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS "public"."gen_table_column";
CREATE TABLE "public"."gen_table_column" (
  "column_id" int8 NOT NULL,
  "table_id" int8,
  "column_name" varchar(200) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "column_comment" varchar(500) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "column_type" varchar(100) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "java_type" varchar(500) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "java_field" varchar(200) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "is_pk" char(1) COLLATE "pg_catalog"."default" DEFAULT NULL::bpchar,
  "is_increment" char(1) COLLATE "pg_catalog"."default" DEFAULT NULL::bpchar,
  "is_required" char(1) COLLATE "pg_catalog"."default" DEFAULT NULL::bpchar,
  "is_insert" char(1) COLLATE "pg_catalog"."default" DEFAULT NULL::bpchar,
  "is_edit" char(1) COLLATE "pg_catalog"."default" DEFAULT NULL::bpchar,
  "is_list" char(1) COLLATE "pg_catalog"."default" DEFAULT NULL::bpchar,
  "is_query" char(1) COLLATE "pg_catalog"."default" DEFAULT NULL::bpchar,
  "query_type" varchar(200) COLLATE "pg_catalog"."default" DEFAULT 'EQ'::character varying,
  "html_type" varchar(200) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "dict_type" varchar(200) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "sort" int4,
  "create_dept" int8,
  "create_by" int8,
  "create_time" timestamp(6),
  "update_by" int8,
  "update_time" timestamp(6)
)
;
COMMENT ON COLUMN "public"."gen_table_column"."column_id" IS '编号';
COMMENT ON COLUMN "public"."gen_table_column"."table_id" IS '归属表编号';
COMMENT ON COLUMN "public"."gen_table_column"."column_name" IS '列名称';
COMMENT ON COLUMN "public"."gen_table_column"."column_comment" IS '列描述';
COMMENT ON COLUMN "public"."gen_table_column"."column_type" IS '列类型';
COMMENT ON COLUMN "public"."gen_table_column"."java_type" IS 'JAVA类型';
COMMENT ON COLUMN "public"."gen_table_column"."java_field" IS 'JAVA字段名';
COMMENT ON COLUMN "public"."gen_table_column"."is_pk" IS '是否主键（1是）';
COMMENT ON COLUMN "public"."gen_table_column"."is_increment" IS '是否自增（1是）';
COMMENT ON COLUMN "public"."gen_table_column"."is_required" IS '是否必填（1是）';
COMMENT ON COLUMN "public"."gen_table_column"."is_insert" IS '是否为插入字段（1是）';
COMMENT ON COLUMN "public"."gen_table_column"."is_edit" IS '是否编辑字段（1是）';
COMMENT ON COLUMN "public"."gen_table_column"."is_list" IS '是否列表字段（1是）';
COMMENT ON COLUMN "public"."gen_table_column"."is_query" IS '是否查询字段（1是）';
COMMENT ON COLUMN "public"."gen_table_column"."query_type" IS '查询方式（等于、不等于、大于、小于、范围）';
COMMENT ON COLUMN "public"."gen_table_column"."html_type" IS '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）';
COMMENT ON COLUMN "public"."gen_table_column"."dict_type" IS '字典类型';
COMMENT ON COLUMN "public"."gen_table_column"."sort" IS '排序';
COMMENT ON COLUMN "public"."gen_table_column"."create_dept" IS '创建部门';
COMMENT ON COLUMN "public"."gen_table_column"."create_by" IS '创建者';
COMMENT ON COLUMN "public"."gen_table_column"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."gen_table_column"."update_by" IS '更新者';
COMMENT ON COLUMN "public"."gen_table_column"."update_time" IS '更新时间';
COMMENT ON TABLE "public"."gen_table_column" IS '代码生成业务表字段';

-- ----------------------------
-- Table structure for ss_achievement
-- ----------------------------
DROP TABLE IF EXISTS "public"."ss_achievement";
CREATE TABLE "public"."ss_achievement" (
  "id" int8 NOT NULL,
  "tenant_id" varchar(20) COLLATE "pg_catalog"."default" DEFAULT '000000'::character varying,
  "name" varchar(64) COLLATE "pg_catalog"."default" NOT NULL,
  "icon_url" varchar(255) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "condition_type" varchar(32) COLLATE "pg_catalog"."default" NOT NULL,
  "threshold" int4 DEFAULT 0,
  "reward_stars" int4 DEFAULT 0,
  "status" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar,
  "create_by" int8,
  "create_time" timestamp(6)
)
;
COMMENT ON TABLE "public"."ss_achievement" IS '成就/勋章定义表';

-- ----------------------------
-- Table structure for ss_child
-- ----------------------------
DROP TABLE IF EXISTS "public"."ss_child";
CREATE TABLE "public"."ss_child" (
  "id" int8 NOT NULL,
  "tenant_id" varchar(20) COLLATE "pg_catalog"."default" DEFAULT '000000'::character varying,
  "parent_id" int8 NOT NULL,
  "nickname" varchar(64) COLLATE "pg_catalog"."default" NOT NULL,
  "avatar_url" varchar(255) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "avatar_config" jsonb,
  "level" int4 DEFAULT 1,
  "daily_config" jsonb,
  "gender" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar,
  "birthday" timestamp(6),
  "star_balance" int4 DEFAULT 0,
  "total_stars" int4 DEFAULT 0,
  "challenges" jsonb,
  "create_dept" int8,
  "create_by" int8,
  "create_time" timestamp(6),
  "update_by" int8,
  "update_time" timestamp(6),
  "remark" varchar(500) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "del_flag" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar
)
;
COMMENT ON COLUMN "public"."ss_child"."daily_config" IS '个性化每日限制配置';
COMMENT ON TABLE "public"."ss_child" IS '儿童档案表';

-- ----------------------------
-- Table structure for ss_child_achievement
-- ----------------------------
DROP TABLE IF EXISTS "public"."ss_child_achievement";
CREATE TABLE "public"."ss_child_achievement" (
  "id" int8 NOT NULL,
  "tenant_id" varchar(20) COLLATE "pg_catalog"."default" DEFAULT '000000'::character varying,
  "child_id" int8 NOT NULL,
  "achievement_id" int8 NOT NULL,
  "current_val" int4 DEFAULT 0,
  "status" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar,
  "unlock_time" timestamp(6)
)
;
COMMENT ON TABLE "public"."ss_child_achievement" IS '儿童成就进度表';

-- ----------------------------
-- Table structure for ss_child_item
-- ----------------------------
DROP TABLE IF EXISTS "public"."ss_child_item";
CREATE TABLE "public"."ss_child_item" (
  "id" int8 NOT NULL,
  "tenant_id" varchar(20) COLLATE "pg_catalog"."default" DEFAULT '000000'::character varying,
  "child_id" int8 NOT NULL,
  "item_id" int8 NOT NULL,
  "is_equipped" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar,
  "obtain_time" timestamp(6)
)
;
COMMENT ON TABLE "public"."ss_child_item" IS '儿童已拥有物品表';

-- ----------------------------
-- Table structure for ss_child_score
-- ----------------------------
DROP TABLE IF EXISTS "public"."ss_child_score";
CREATE TABLE "public"."ss_child_score" (
  "user_id" int8 NOT NULL,
  "balance" int4 DEFAULT 0,
  "total_earned" int4 DEFAULT 0,
  "update_time" timestamp(6)
)
;
COMMENT ON COLUMN "public"."ss_child_score"."user_id" IS '用户ID';
COMMENT ON COLUMN "public"."ss_child_score"."balance" IS '当前余额';
COMMENT ON COLUMN "public"."ss_child_score"."total_earned" IS '累计获得';
COMMENT ON COLUMN "public"."ss_child_score"."update_time" IS '更新时间';
COMMENT ON TABLE "public"."ss_child_score" IS '儿童积分余额表';

-- ----------------------------
-- Table structure for ss_device
-- ----------------------------
DROP TABLE IF EXISTS "public"."ss_device";
CREATE TABLE "public"."ss_device" (
  "id" int8 NOT NULL,
  "tenant_id" varchar(20) COLLATE "pg_catalog"."default" DEFAULT '000000'::character varying,
  "serial_number" varchar(64) COLLATE "pg_catalog"."default" NOT NULL,
  "child_id" int8,
  "status" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar,
  "settings" jsonb,
  "battery_level" int4 DEFAULT 0,
  "last_active" timestamp(6),
  "fw_version" varchar(32) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "create_dept" int8,
  "create_by" int8,
  "create_time" timestamp(6),
  "update_by" int8,
  "update_time" timestamp(6),
  "remark" varchar(500) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying
)
;
COMMENT ON COLUMN "public"."ss_device"."settings" IS '设备配置(JSON)';
COMMENT ON COLUMN "public"."ss_device"."battery_level" IS '当前电量';
COMMENT ON TABLE "public"."ss_device" IS '硬件设备表';

-- ----------------------------
-- Table structure for ss_device_log
-- ----------------------------
DROP TABLE IF EXISTS "public"."ss_device_log";
CREATE TABLE "public"."ss_device_log" (
  "id" int8 NOT NULL,
  "tenant_id" varchar(20) COLLATE "pg_catalog"."default" DEFAULT '000000'::character varying,
  "device_id" int8 NOT NULL,
  "event_type" varchar(32) COLLATE "pg_catalog"."default" NOT NULL,
  "event_data" jsonb,
  "create_time" timestamp(6)
)
;
COMMENT ON TABLE "public"."ss_device_log" IS '设备运维日志表';

-- ----------------------------
-- Table structure for ss_emotion_record
-- ----------------------------
DROP TABLE IF EXISTS "public"."ss_emotion_record";
CREATE TABLE "public"."ss_emotion_record" (
  "id" int8 NOT NULL,
  "tenant_id" varchar(20) COLLATE "pg_catalog"."default" DEFAULT '000000'::character varying,
  "child_id" int8 NOT NULL,
  "mood_level" int4 DEFAULT 3,
  "mood_type" varchar(32) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "description" varchar(500) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "voice_url" varchar(255) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "parent_feedback" varchar(500) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "is_read" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar,
  "record_time" timestamp(6),
  "create_time" timestamp(6)
)
;
COMMENT ON TABLE "public"."ss_emotion_record" IS '情绪记录表';

-- ----------------------------
-- Table structure for ss_family_member
-- ----------------------------
DROP TABLE IF EXISTS "public"."ss_family_member";
CREATE TABLE "public"."ss_family_member" (
  "id" int8 NOT NULL,
  "tenant_id" varchar(20) COLLATE "pg_catalog"."default" DEFAULT '000000'::character varying,
  "child_id" int8 NOT NULL,
  "user_id" int8 NOT NULL,
  "role" varchar(32) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "permissions" jsonb,
  "create_time" timestamp(6)
)
;
COMMENT ON TABLE "public"."ss_family_member" IS '家庭成员关联表';

-- ----------------------------
-- Table structure for ss_game_item
-- ----------------------------
DROP TABLE IF EXISTS "public"."ss_game_item";
CREATE TABLE "public"."ss_game_item" (
  "id" int8 NOT NULL,
  "tenant_id" varchar(20) COLLATE "pg_catalog"."default" DEFAULT '000000'::character varying,
  "name" varchar(64) COLLATE "pg_catalog"."default" NOT NULL,
  "icon" varchar(255) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "category" varchar(32) COLLATE "pg_catalog"."default" NOT NULL,
  "price" int4 DEFAULT 0,
  "unlock_level" int4 DEFAULT 1,
  "is_default" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar,
  "status" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar,
  "create_by" int8,
  "create_time" timestamp(6)
)
;
COMMENT ON TABLE "public"."ss_game_item" IS '游戏物品(Avatar)配置表';

-- ----------------------------
-- Table structure for ss_knowledge_card
-- ----------------------------
DROP TABLE IF EXISTS "public"."ss_knowledge_card";
CREATE TABLE "public"."ss_knowledge_card" (
  "id" int8 NOT NULL,
  "tenant_id" varchar(20) COLLATE "pg_catalog"."default" DEFAULT '000000'::character varying,
  "title" varchar(128) COLLATE "pg_catalog"."default" NOT NULL,
  "summary" varchar(255) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "content" text COLLATE "pg_catalog"."default",
  "cover_url" varchar(255) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "category" varchar(32) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "tags" jsonb,
  "status" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar,
  "create_dept" int8,
  "create_by" int8,
  "create_time" timestamp(6),
  "update_by" int8,
  "update_time" timestamp(6),
  "del_flag" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar
)
;
COMMENT ON TABLE "public"."ss_knowledge_card" IS '父母学堂知识卡片表';

-- ----------------------------
-- Table structure for ss_knowledge_user_rel
-- ----------------------------
DROP TABLE IF EXISTS "public"."ss_knowledge_user_rel";
CREATE TABLE "public"."ss_knowledge_user_rel" (
  "id" int8 NOT NULL,
  "tenant_id" varchar(20) COLLATE "pg_catalog"."default" DEFAULT '000000'::character varying,
  "user_id" int8 NOT NULL,
  "knowledge_id" int8 NOT NULL,
  "is_read" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar,
  "is_favorite" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar,
  "read_time" timestamp(6)
)
;
COMMENT ON TABLE "public"."ss_knowledge_user_rel" IS '家长与知识内容关联表 (收藏/已读)';

-- ----------------------------
-- Table structure for ss_level_config
-- ----------------------------
DROP TABLE IF EXISTS "public"."ss_level_config";
CREATE TABLE "public"."ss_level_config" (
  "level" int4 NOT NULL,
  "tenant_id" varchar(20) COLLATE "pg_catalog"."default" DEFAULT '000000'::character varying,
  "title" varchar(64) COLLATE "pg_catalog"."default" NOT NULL,
  "min_stars" int4 DEFAULT 0,
  "unlock_feature" jsonb,
  "reward_package" jsonb,
  "create_by" int8,
  "create_time" timestamp(6),
  "update_by" int8,
  "update_time" timestamp(6)
)
;
COMMENT ON TABLE "public"."ss_level_config" IS '等级成长配置表';

-- ----------------------------
-- Table structure for ss_parent_contract
-- ----------------------------
DROP TABLE IF EXISTS "public"."ss_parent_contract";
CREATE TABLE "public"."ss_parent_contract" (
  "contract_id" int8 NOT NULL,
  "ss_parent_id" int8 NOT NULL,
  "child_id" int8 NOT NULL,
  "content" text COLLATE "pg_catalog"."default",
  "signature_img" varchar(500) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "status" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar,
  "create_by" int8,
  "create_time" timestamp(6),
  "update_by" int8,
  "update_time" timestamp(6),
  "del_flag" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar,
  "create_dept" int8
)
;
COMMENT ON COLUMN "public"."ss_parent_contract"."contract_id" IS '契约ID';
COMMENT ON COLUMN "public"."ss_parent_contract"."ss_parent_id" IS '家长ID';
COMMENT ON COLUMN "public"."ss_parent_contract"."child_id" IS '孩子ID';
COMMENT ON COLUMN "public"."ss_parent_contract"."content" IS '契约内容';
COMMENT ON COLUMN "public"."ss_parent_contract"."signature_img" IS '签名图片';
COMMENT ON COLUMN "public"."ss_parent_contract"."status" IS '状态(0生效中 1已失效)';
COMMENT ON COLUMN "public"."ss_parent_contract"."create_by" IS '创建者';
COMMENT ON COLUMN "public"."ss_parent_contract"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."ss_parent_contract"."update_by" IS '更新者';
COMMENT ON COLUMN "public"."ss_parent_contract"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."ss_parent_contract"."del_flag" IS '删除标志(0代表存在 2代表删除)';
COMMENT ON COLUMN "public"."ss_parent_contract"."create_dept" IS '创建部门';
COMMENT ON TABLE "public"."ss_parent_contract" IS '亲子契约表';

-- ----------------------------
-- Table structure for ss_parent_reward
-- ----------------------------
DROP TABLE IF EXISTS "public"."ss_parent_reward";
CREATE TABLE "public"."ss_parent_reward" (
  "reward_id" int8 NOT NULL,
  "user_id" int8,
  "name" varchar(100) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "points_required" int4 DEFAULT 100,
  "stock" int4 DEFAULT '-1'::integer,
  "icon" varchar(100) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "status" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar,
  "create_by" int8,
  "create_time" timestamp(6),
  "update_by" int8,
  "update_time" timestamp(6),
  "del_flag" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar,
  "create_dept" int8
)
;
COMMENT ON COLUMN "public"."ss_parent_reward"."reward_id" IS '奖励ID';
COMMENT ON COLUMN "public"."ss_parent_reward"."user_id" IS '所属用户ID';
COMMENT ON COLUMN "public"."ss_parent_reward"."name" IS '奖励名称';
COMMENT ON COLUMN "public"."ss_parent_reward"."points_required" IS '所需积分';
COMMENT ON COLUMN "public"."ss_parent_reward"."stock" IS '库存(-1无限)';
COMMENT ON COLUMN "public"."ss_parent_reward"."icon" IS '图标';
COMMENT ON COLUMN "public"."ss_parent_reward"."status" IS '状态(0上架 1下架)';
COMMENT ON COLUMN "public"."ss_parent_reward"."create_by" IS '创建者';
COMMENT ON COLUMN "public"."ss_parent_reward"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."ss_parent_reward"."update_by" IS '更新者';
COMMENT ON COLUMN "public"."ss_parent_reward"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."ss_parent_reward"."del_flag" IS '删除标志(0代表存在 2代表删除)';
COMMENT ON COLUMN "public"."ss_parent_reward"."create_dept" IS '创建部门';
COMMENT ON TABLE "public"."ss_parent_reward" IS '家长奖励配置表';

-- ----------------------------
-- Table structure for ss_parent_reward_redemption
-- ----------------------------
DROP TABLE IF EXISTS "public"."ss_parent_reward_redemption";
CREATE TABLE "public"."ss_parent_reward_redemption" (
  "redemption_id" int8 NOT NULL,
  "reward_id" int8 NOT NULL,
  "user_id" int8 NOT NULL,
  "points_cost" int4 DEFAULT 0,
  "status" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar,
  "create_by" int8,
  "create_time" timestamp(6),
  "update_by" int8,
  "update_time" timestamp(6),
  "create_dept" int8
)
;
COMMENT ON COLUMN "public"."ss_parent_reward_redemption"."redemption_id" IS '兑换ID';
COMMENT ON COLUMN "public"."ss_parent_reward_redemption"."reward_id" IS '奖励ID';
COMMENT ON COLUMN "public"."ss_parent_reward_redemption"."user_id" IS '用户ID';
COMMENT ON COLUMN "public"."ss_parent_reward_redemption"."points_cost" IS '消耗积分';
COMMENT ON COLUMN "public"."ss_parent_reward_redemption"."status" IS '状态(0:待审批 1:已批准 2:已拒绝)';
COMMENT ON COLUMN "public"."ss_parent_reward_redemption"."create_dept" IS '创建部门';
COMMENT ON TABLE "public"."ss_parent_reward_redemption" IS '奖励兑换记录表';

-- ----------------------------
-- Table structure for ss_parent_task
-- ----------------------------
DROP TABLE IF EXISTS "public"."ss_parent_task";
CREATE TABLE "public"."ss_parent_task" (
  "task_id" int8 NOT NULL,
  "user_id" int8,
  "title" varchar(100) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "description" varchar(500) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "icon" varchar(100) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "difficulty" int4 DEFAULT 1,
  "reward_points" int4 DEFAULT 10,
  "status" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar,
  "create_by" int8,
  "create_time" timestamp(6),
  "update_by" int8,
  "update_time" timestamp(6),
  "del_flag" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar,
  "dept_id" int8,
  "parent_id" int8,
  "prompt_level" int4 DEFAULT 1,
  "cycle_type" int4 DEFAULT 0,
  "light_effect" varchar(100) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "audio_effect" varchar(100) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "deadline" timestamp(6),
  "create_dept" int8
)
;
COMMENT ON COLUMN "public"."ss_parent_task"."task_id" IS '任务ID';
COMMENT ON COLUMN "public"."ss_parent_task"."user_id" IS '所属用户ID';
COMMENT ON COLUMN "public"."ss_parent_task"."title" IS '任务标题';
COMMENT ON COLUMN "public"."ss_parent_task"."description" IS '任务描述';
COMMENT ON COLUMN "public"."ss_parent_task"."icon" IS '图标';
COMMENT ON COLUMN "public"."ss_parent_task"."difficulty" IS '难度等级(1-5)';
COMMENT ON COLUMN "public"."ss_parent_task"."reward_points" IS '奖励积分';
COMMENT ON COLUMN "public"."ss_parent_task"."status" IS '状态(0进行中 1已完成 2已过期)';
COMMENT ON COLUMN "public"."ss_parent_task"."create_by" IS '创建者';
COMMENT ON COLUMN "public"."ss_parent_task"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."ss_parent_task"."update_by" IS '更新者';
COMMENT ON COLUMN "public"."ss_parent_task"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."ss_parent_task"."del_flag" IS '删除标志(0代表存在 2代表删除)';
COMMENT ON COLUMN "public"."ss_parent_task"."dept_id" IS '家庭ID(部门ID)';
COMMENT ON COLUMN "public"."ss_parent_task"."parent_id" IS '父任务ID(用于任务拆解)';
COMMENT ON COLUMN "public"."ss_parent_task"."prompt_level" IS '支架强度/辅助强度(1-5)';
COMMENT ON COLUMN "public"."ss_parent_task"."cycle_type" IS '循环类型(0单次 1每日 2每周)';
COMMENT ON COLUMN "public"."ss_parent_task"."light_effect" IS '灯光效果代码';
COMMENT ON COLUMN "public"."ss_parent_task"."audio_effect" IS '音频索引代码';
COMMENT ON COLUMN "public"."ss_parent_task"."deadline" IS '截止时间';
COMMENT ON COLUMN "public"."ss_parent_task"."create_dept" IS '创建部门';
COMMENT ON TABLE "public"."ss_parent_task" IS '家长任务发布表';

-- ----------------------------
-- Table structure for ss_reward
-- ----------------------------
DROP TABLE IF EXISTS "public"."ss_reward";
CREATE TABLE "public"."ss_reward" (
  "id" int8 NOT NULL,
  "tenant_id" varchar(20) COLLATE "pg_catalog"."default" DEFAULT '000000'::character varying,
  "child_id" int8 NOT NULL,
  "name" varchar(128) COLLATE "pg_catalog"."default" NOT NULL,
  "icon" varchar(255) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "star_cost" int4 DEFAULT 10,
  "stock" int4 DEFAULT '-1'::integer,
  "status" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar,
  "create_dept" int8,
  "create_by" int8,
  "create_time" timestamp(6),
  "update_by" int8,
  "update_time" timestamp(6),
  "del_flag" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar
)
;
COMMENT ON TABLE "public"."ss_reward" IS '实物奖励配置表';

-- ----------------------------
-- Table structure for ss_reward_exchange
-- ----------------------------
DROP TABLE IF EXISTS "public"."ss_reward_exchange";
CREATE TABLE "public"."ss_reward_exchange" (
  "id" int8 NOT NULL,
  "tenant_id" varchar(20) COLLATE "pg_catalog"."default" DEFAULT '000000'::character varying,
  "reward_id" int8 NOT NULL,
  "child_id" int8 NOT NULL,
  "reward_snap" varchar(500) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "cost" int4 NOT NULL,
  "exchange_time" timestamp(6),
  "status" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar,
  "update_by" int8,
  "update_time" timestamp(6)
)
;
COMMENT ON TABLE "public"."ss_reward_exchange" IS '奖励兑换记录表';

-- ----------------------------
-- Table structure for ss_score_history
-- ----------------------------
DROP TABLE IF EXISTS "public"."ss_score_history";
CREATE TABLE "public"."ss_score_history" (
  "id" int8 NOT NULL,
  "user_id" int8 NOT NULL,
  "amount" int4 NOT NULL,
  "type" char(1) COLLATE "pg_catalog"."default" DEFAULT '1'::bpchar,
  "source_id" int8,
  "reason" varchar(255) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "create_time" timestamp(6) DEFAULT CURRENT_TIMESTAMP
)
;
COMMENT ON COLUMN "public"."ss_score_history"."type" IS '类型(1:获取 2:消费)';
COMMENT ON TABLE "public"."ss_score_history" IS '积分流水表';

-- ----------------------------
-- Table structure for ss_star_record
-- ----------------------------
DROP TABLE IF EXISTS "public"."ss_star_record";
CREATE TABLE "public"."ss_star_record" (
  "id" int8 NOT NULL,
  "tenant_id" varchar(20) COLLATE "pg_catalog"."default" DEFAULT '000000'::character varying,
  "child_id" int8 NOT NULL,
  "amount" int4 NOT NULL,
  "reason" varchar(128) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "source_type" char(1) COLLATE "pg_catalog"."default" NOT NULL,
  "source_id" int8 DEFAULT 0,
  "create_time" timestamp(6)
)
;
COMMENT ON TABLE "public"."ss_star_record" IS '星星流水记录表';

-- ----------------------------
-- Table structure for ss_task
-- ----------------------------
DROP TABLE IF EXISTS "public"."ss_task";
CREATE TABLE "public"."ss_task" (
  "id" int8 NOT NULL,
  "tenant_id" varchar(20) COLLATE "pg_catalog"."default" DEFAULT '000000'::character varying,
  "child_id" int8 NOT NULL,
  "title" varchar(128) COLLATE "pg_catalog"."default" NOT NULL,
  "icon" varchar(255) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "star_reward" int4 DEFAULT 1,
  "difficulty" int4 DEFAULT 1,
  "type" char(1) COLLATE "pg_catalog"."default" DEFAULT '1'::bpchar,
  "schedule_conf" varchar(64) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "sub_tasks" jsonb,
  "voice_prompt" varchar(255) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "guide_image" varchar(255) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "status" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar,
  "create_dept" int8,
  "create_by" int8,
  "create_time" timestamp(6),
  "update_by" int8,
  "update_time" timestamp(6),
  "del_flag" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar
)
;
COMMENT ON TABLE "public"."ss_task" IS '任务配置表';

-- ----------------------------
-- Table structure for ss_task_log
-- ----------------------------
DROP TABLE IF EXISTS "public"."ss_task_log";
CREATE TABLE "public"."ss_task_log" (
  "id" int8 NOT NULL,
  "tenant_id" varchar(20) COLLATE "pg_catalog"."default" DEFAULT '000000'::character varying,
  "task_id" int8 NOT NULL,
  "child_id" int8 NOT NULL,
  "finish_time" timestamp(6),
  "status" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar,
  "proof" varchar(500) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "reward_snap" int4 DEFAULT 0,
  "title_snap" varchar(128) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "create_time" timestamp(6),
  "dept_id" int8,
  "target_date" date,
  "actual_duration" int4 DEFAULT 0,
  "start_time" timestamp(6),
  "end_time" timestamp(6),
  "del_flag" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar,
  "create_dept" int8,
  "create_by" int8,
  "update_by" int8,
  "update_time" timestamp(6)
)
;
COMMENT ON COLUMN "public"."ss_task_log"."reward_snap" IS '实际奖励星星快照';
COMMENT ON COLUMN "public"."ss_task_log"."title_snap" IS '任务标题快照';
COMMENT ON COLUMN "public"."ss_task_log"."dept_id" IS '家庭ID(部门ID)';
COMMENT ON COLUMN "public"."ss_task_log"."target_date" IS '预定执行日期';
COMMENT ON COLUMN "public"."ss_task_log"."actual_duration" IS '实际专注时长(秒)';
COMMENT ON COLUMN "public"."ss_task_log"."start_time" IS '开始时间';
COMMENT ON COLUMN "public"."ss_task_log"."end_time" IS '完成时间';
COMMENT ON COLUMN "public"."ss_task_log"."del_flag" IS '删除标志(0代表存在 2代表删除)';
COMMENT ON COLUMN "public"."ss_task_log"."create_dept" IS '创建部门';
COMMENT ON TABLE "public"."ss_task_log" IS '任务执行记录表';

-- ----------------------------
-- Table structure for ss_task_preset
-- ----------------------------
DROP TABLE IF EXISTS "public"."ss_task_preset";
CREATE TABLE "public"."ss_task_preset" (
  "id" int8 NOT NULL,
  "tenant_id" varchar(20) COLLATE "pg_catalog"."default" DEFAULT '000000'::character varying,
  "title" varchar(128) COLLATE "pg_catalog"."default" NOT NULL,
  "icon" varchar(255) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "category" varchar(32) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "sub_tasks" jsonb,
  "difficulty" int4 DEFAULT 1,
  "is_system" char(1) COLLATE "pg_catalog"."default" DEFAULT '1'::bpchar,
  "create_by" int8,
  "create_time" timestamp(6),
  "status" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar
)
;
COMMENT ON TABLE "public"."ss_task_preset" IS '场景化任务预设库';

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
-- Table structure for sys_ai_route
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_ai_route";
CREATE TABLE "public"."sys_ai_route" (
  "scene_key" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "strategy" varchar(50) COLLATE "pg_catalog"."default" NOT NULL DEFAULT 'PRIORITY_LEVEL'::character varying,
  "default_model_id" int8,
  "config_json" json,
  "update_by" int8,
  "update_time" timestamp(6)
)
;
COMMENT ON TABLE "public"."sys_ai_route" IS 'AI路由策略表';

-- ----------------------------
-- Table structure for sys_client
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_client";
CREATE TABLE "public"."sys_client" (
  "id" int8 NOT NULL,
  "client_id" varchar(64) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "client_key" varchar(32) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "client_secret" varchar(255) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "grant_type" varchar(255) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "device_type" varchar(32) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "active_timeout" int4 DEFAULT 1800,
  "timeout" int4 DEFAULT 604800,
  "status" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar,
  "del_flag" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar,
  "create_dept" int8,
  "create_by" int8,
  "create_time" timestamp(6),
  "update_by" int8,
  "update_time" timestamp(6)
)
;
COMMENT ON COLUMN "public"."sys_client"."id" IS '主键';
COMMENT ON COLUMN "public"."sys_client"."client_id" IS '客户端id';
COMMENT ON COLUMN "public"."sys_client"."client_key" IS '客户端key';
COMMENT ON COLUMN "public"."sys_client"."client_secret" IS '客户端秘钥';
COMMENT ON COLUMN "public"."sys_client"."grant_type" IS '授权类型';
COMMENT ON COLUMN "public"."sys_client"."device_type" IS '设备类型';
COMMENT ON COLUMN "public"."sys_client"."active_timeout" IS 'token活跃超时时间';
COMMENT ON COLUMN "public"."sys_client"."timeout" IS 'token固定超时';
COMMENT ON COLUMN "public"."sys_client"."status" IS '状态（0正常 1停用）';
COMMENT ON COLUMN "public"."sys_client"."del_flag" IS '删除标志（0代表存在 1代表删除）';
COMMENT ON COLUMN "public"."sys_client"."create_dept" IS '创建部门';
COMMENT ON COLUMN "public"."sys_client"."create_by" IS '创建者';
COMMENT ON COLUMN "public"."sys_client"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."sys_client"."update_by" IS '更新者';
COMMENT ON COLUMN "public"."sys_client"."update_time" IS '更新时间';
COMMENT ON TABLE "public"."sys_client" IS '系统授权表';

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_config";
CREATE TABLE "public"."sys_config" (
  "config_id" int8 NOT NULL,
  "tenant_id" varchar(20) COLLATE "pg_catalog"."default" DEFAULT '000000'::character varying,
  "config_name" varchar(100) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "config_key" varchar(100) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "config_value" varchar(500) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "config_type" char(1) COLLATE "pg_catalog"."default" DEFAULT 'N'::bpchar,
  "create_dept" int8,
  "create_by" int8,
  "create_time" timestamp(6),
  "update_by" int8,
  "update_time" timestamp(6),
  "remark" varchar(500) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying
)
;
COMMENT ON COLUMN "public"."sys_config"."config_id" IS '参数主键';
COMMENT ON COLUMN "public"."sys_config"."tenant_id" IS '租户编号';
COMMENT ON COLUMN "public"."sys_config"."config_name" IS '参数名称';
COMMENT ON COLUMN "public"."sys_config"."config_key" IS '参数键名';
COMMENT ON COLUMN "public"."sys_config"."config_value" IS '参数键值';
COMMENT ON COLUMN "public"."sys_config"."config_type" IS '系统内置（Y是 N否）';
COMMENT ON COLUMN "public"."sys_config"."create_dept" IS '创建部门';
COMMENT ON COLUMN "public"."sys_config"."create_by" IS '创建者';
COMMENT ON COLUMN "public"."sys_config"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."sys_config"."update_by" IS '更新者';
COMMENT ON COLUMN "public"."sys_config"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."sys_config"."remark" IS '备注';
COMMENT ON TABLE "public"."sys_config" IS '参数配置表';

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_dept";
CREATE TABLE "public"."sys_dept" (
  "dept_id" int8 NOT NULL,
  "tenant_id" varchar(20) COLLATE "pg_catalog"."default" DEFAULT '000000'::character varying,
  "parent_id" int8 DEFAULT 0,
  "ancestors" varchar(500) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "dept_name" varchar(30) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "dept_category" varchar(100) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "order_num" int4 DEFAULT 0,
  "leader" int8,
  "phone" varchar(11) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "email" varchar(50) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "status" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar,
  "del_flag" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar,
  "create_dept" int8,
  "create_by" int8,
  "create_time" timestamp(6),
  "update_by" int8,
  "update_time" timestamp(6)
)
;
COMMENT ON COLUMN "public"."sys_dept"."dept_id" IS '部门ID';
COMMENT ON COLUMN "public"."sys_dept"."tenant_id" IS '租户编号';
COMMENT ON COLUMN "public"."sys_dept"."parent_id" IS '父部门ID';
COMMENT ON COLUMN "public"."sys_dept"."ancestors" IS '祖级列表';
COMMENT ON COLUMN "public"."sys_dept"."dept_name" IS '部门名称';
COMMENT ON COLUMN "public"."sys_dept"."dept_category" IS '部门类别编码';
COMMENT ON COLUMN "public"."sys_dept"."order_num" IS '显示顺序';
COMMENT ON COLUMN "public"."sys_dept"."leader" IS '负责人';
COMMENT ON COLUMN "public"."sys_dept"."phone" IS '联系电话';
COMMENT ON COLUMN "public"."sys_dept"."email" IS '邮箱';
COMMENT ON COLUMN "public"."sys_dept"."status" IS '部门状态（0正常 1停用）';
COMMENT ON COLUMN "public"."sys_dept"."del_flag" IS '删除标志（0代表存在 1代表删除）';
COMMENT ON COLUMN "public"."sys_dept"."create_dept" IS '创建部门';
COMMENT ON COLUMN "public"."sys_dept"."create_by" IS '创建者';
COMMENT ON COLUMN "public"."sys_dept"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."sys_dept"."update_by" IS '更新者';
COMMENT ON COLUMN "public"."sys_dept"."update_time" IS '更新时间';
COMMENT ON TABLE "public"."sys_dept" IS '部门表';

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_dict_data";
CREATE TABLE "public"."sys_dict_data" (
  "dict_code" int8 NOT NULL,
  "tenant_id" varchar(20) COLLATE "pg_catalog"."default" DEFAULT '000000'::character varying,
  "dict_sort" int4 DEFAULT 0,
  "dict_label" varchar(100) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "dict_value" varchar(100) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "dict_type" varchar(100) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "css_class" varchar(100) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "list_class" varchar(100) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "is_default" char(1) COLLATE "pg_catalog"."default" DEFAULT 'N'::bpchar,
  "create_dept" int8,
  "create_by" int8,
  "create_time" timestamp(6),
  "update_by" int8,
  "update_time" timestamp(6),
  "remark" varchar(500) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying
)
;
COMMENT ON COLUMN "public"."sys_dict_data"."dict_code" IS '字典编码';
COMMENT ON COLUMN "public"."sys_dict_data"."dict_sort" IS '字典排序';
COMMENT ON COLUMN "public"."sys_dict_data"."dict_label" IS '字典标签';
COMMENT ON COLUMN "public"."sys_dict_data"."dict_value" IS '字典键值';
COMMENT ON COLUMN "public"."sys_dict_data"."dict_type" IS '字典类型';
COMMENT ON COLUMN "public"."sys_dict_data"."css_class" IS '样式属性（其他样式扩展）';
COMMENT ON COLUMN "public"."sys_dict_data"."list_class" IS '表格回显样式';
COMMENT ON COLUMN "public"."sys_dict_data"."is_default" IS '是否默认（Y是 N否）';
COMMENT ON COLUMN "public"."sys_dict_data"."create_dept" IS '创建部门';
COMMENT ON COLUMN "public"."sys_dict_data"."create_by" IS '创建者';
COMMENT ON COLUMN "public"."sys_dict_data"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."sys_dict_data"."update_by" IS '更新者';
COMMENT ON COLUMN "public"."sys_dict_data"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."sys_dict_data"."remark" IS '备注';
COMMENT ON TABLE "public"."sys_dict_data" IS '字典数据表';

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_dict_type";
CREATE TABLE "public"."sys_dict_type" (
  "dict_id" int8 NOT NULL,
  "tenant_id" varchar(20) COLLATE "pg_catalog"."default" DEFAULT '000000'::character varying,
  "dict_name" varchar(100) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "dict_type" varchar(100) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "create_dept" int8,
  "create_by" int8,
  "create_time" timestamp(6),
  "update_by" int8,
  "update_time" timestamp(6),
  "remark" varchar(500) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying
)
;
COMMENT ON COLUMN "public"."sys_dict_type"."dict_id" IS '字典主键';
COMMENT ON COLUMN "public"."sys_dict_type"."tenant_id" IS '租户编号';
COMMENT ON COLUMN "public"."sys_dict_type"."dict_name" IS '字典名称';
COMMENT ON COLUMN "public"."sys_dict_type"."dict_type" IS '字典类型';
COMMENT ON COLUMN "public"."sys_dict_type"."create_dept" IS '创建部门';
COMMENT ON COLUMN "public"."sys_dict_type"."create_by" IS '创建者';
COMMENT ON COLUMN "public"."sys_dict_type"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."sys_dict_type"."update_by" IS '更新者';
COMMENT ON COLUMN "public"."sys_dict_type"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."sys_dict_type"."remark" IS '备注';
COMMENT ON TABLE "public"."sys_dict_type" IS '字典类型表';

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_logininfor";
CREATE TABLE "public"."sys_logininfor" (
  "info_id" int8 NOT NULL,
  "tenant_id" varchar(20) COLLATE "pg_catalog"."default" DEFAULT '000000'::character varying,
  "user_name" varchar(50) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "client_key" varchar(32) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "device_type" varchar(32) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "ipaddr" varchar(128) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "login_location" varchar(255) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "browser" varchar(50) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "os" varchar(50) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "status" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar,
  "msg" varchar(255) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "login_time" timestamp(6)
)
;
COMMENT ON COLUMN "public"."sys_logininfor"."info_id" IS '访问ID';
COMMENT ON COLUMN "public"."sys_logininfor"."tenant_id" IS '租户编号';
COMMENT ON COLUMN "public"."sys_logininfor"."user_name" IS '用户账号';
COMMENT ON COLUMN "public"."sys_logininfor"."client_key" IS '客户端';
COMMENT ON COLUMN "public"."sys_logininfor"."device_type" IS '设备类型';
COMMENT ON COLUMN "public"."sys_logininfor"."ipaddr" IS '登录IP地址';
COMMENT ON COLUMN "public"."sys_logininfor"."login_location" IS '登录地点';
COMMENT ON COLUMN "public"."sys_logininfor"."browser" IS '浏览器类型';
COMMENT ON COLUMN "public"."sys_logininfor"."os" IS '操作系统';
COMMENT ON COLUMN "public"."sys_logininfor"."status" IS '登录状态（0成功 1失败）';
COMMENT ON COLUMN "public"."sys_logininfor"."msg" IS '提示消息';
COMMENT ON COLUMN "public"."sys_logininfor"."login_time" IS '访问时间';
COMMENT ON TABLE "public"."sys_logininfor" IS '系统访问记录';

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_menu";
CREATE TABLE "public"."sys_menu" (
  "menu_id" int8 NOT NULL,
  "menu_name" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "parent_id" int8 DEFAULT 0,
  "order_num" int4 DEFAULT 0,
  "path" varchar(200) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "component" varchar(255) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "query_param" varchar(255) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "is_frame" char(1) COLLATE "pg_catalog"."default" DEFAULT '1'::bpchar,
  "is_cache" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar,
  "menu_type" char(1) COLLATE "pg_catalog"."default" DEFAULT ''::bpchar,
  "visible" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar,
  "status" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar,
  "perms" varchar(100) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "icon" varchar(100) COLLATE "pg_catalog"."default" DEFAULT '#'::character varying,
  "create_dept" int8,
  "create_by" int8,
  "create_time" timestamp(6),
  "update_by" int8,
  "update_time" timestamp(6),
  "remark" varchar(500) COLLATE "pg_catalog"."default" DEFAULT ''::character varying
)
;
COMMENT ON COLUMN "public"."sys_menu"."menu_id" IS '菜单ID';
COMMENT ON COLUMN "public"."sys_menu"."menu_name" IS '菜单名称';
COMMENT ON COLUMN "public"."sys_menu"."parent_id" IS '父菜单ID';
COMMENT ON COLUMN "public"."sys_menu"."order_num" IS '显示顺序';
COMMENT ON COLUMN "public"."sys_menu"."path" IS '路由地址';
COMMENT ON COLUMN "public"."sys_menu"."component" IS '组件路径';
COMMENT ON COLUMN "public"."sys_menu"."query_param" IS '路由参数';
COMMENT ON COLUMN "public"."sys_menu"."is_frame" IS '是否为外链（0是 1否）';
COMMENT ON COLUMN "public"."sys_menu"."is_cache" IS '是否缓存（0缓存 1不缓存）';
COMMENT ON COLUMN "public"."sys_menu"."menu_type" IS '菜单类型（M目录 C菜单 F按钮）';
COMMENT ON COLUMN "public"."sys_menu"."visible" IS '显示状态（0显示 1隐藏）';
COMMENT ON COLUMN "public"."sys_menu"."status" IS '菜单状态（0正常 1停用）';
COMMENT ON COLUMN "public"."sys_menu"."perms" IS '权限标识';
COMMENT ON COLUMN "public"."sys_menu"."icon" IS '菜单图标';
COMMENT ON COLUMN "public"."sys_menu"."create_dept" IS '创建部门';
COMMENT ON COLUMN "public"."sys_menu"."create_by" IS '创建者';
COMMENT ON COLUMN "public"."sys_menu"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."sys_menu"."update_by" IS '更新者';
COMMENT ON COLUMN "public"."sys_menu"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."sys_menu"."remark" IS '备注';
COMMENT ON TABLE "public"."sys_menu" IS '菜单权限表';

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_notice";
CREATE TABLE "public"."sys_notice" (
  "notice_id" int8 NOT NULL,
  "tenant_id" varchar(20) COLLATE "pg_catalog"."default" DEFAULT '000000'::character varying,
  "notice_title" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "notice_type" char(1) COLLATE "pg_catalog"."default" NOT NULL,
  "notice_content" text COLLATE "pg_catalog"."default",
  "status" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar,
  "create_dept" int8,
  "create_by" int8,
  "create_time" timestamp(6),
  "update_by" int8,
  "update_time" timestamp(6),
  "remark" varchar(255) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying
)
;
COMMENT ON COLUMN "public"."sys_notice"."notice_id" IS '公告ID';
COMMENT ON COLUMN "public"."sys_notice"."tenant_id" IS '租户编号';
COMMENT ON COLUMN "public"."sys_notice"."notice_title" IS '公告标题';
COMMENT ON COLUMN "public"."sys_notice"."notice_type" IS '公告类型（1通知 2公告）';
COMMENT ON COLUMN "public"."sys_notice"."notice_content" IS '公告内容';
COMMENT ON COLUMN "public"."sys_notice"."status" IS '公告状态（0正常 1关闭）';
COMMENT ON COLUMN "public"."sys_notice"."create_dept" IS '创建部门';
COMMENT ON COLUMN "public"."sys_notice"."create_by" IS '创建者';
COMMENT ON COLUMN "public"."sys_notice"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."sys_notice"."update_by" IS '更新者';
COMMENT ON COLUMN "public"."sys_notice"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."sys_notice"."remark" IS '备注';
COMMENT ON TABLE "public"."sys_notice" IS '通知公告表';

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_oper_log";
CREATE TABLE "public"."sys_oper_log" (
  "oper_id" int8 NOT NULL,
  "tenant_id" varchar(20) COLLATE "pg_catalog"."default" DEFAULT '000000'::character varying,
  "title" varchar(50) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "business_type" int4 DEFAULT 0,
  "method" varchar(100) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "request_method" varchar(10) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "operator_type" int4 DEFAULT 0,
  "oper_name" varchar(50) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "dept_name" varchar(50) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "oper_url" varchar(255) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "oper_ip" varchar(128) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "oper_location" varchar(255) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "oper_param" varchar(4000) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "json_result" varchar(4000) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "status" int4 DEFAULT 0,
  "error_msg" varchar(4000) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "oper_time" timestamp(6),
  "cost_time" int8 DEFAULT 0
)
;
COMMENT ON COLUMN "public"."sys_oper_log"."oper_id" IS '日志主键';
COMMENT ON COLUMN "public"."sys_oper_log"."tenant_id" IS '租户编号';
COMMENT ON COLUMN "public"."sys_oper_log"."title" IS '模块标题';
COMMENT ON COLUMN "public"."sys_oper_log"."business_type" IS '业务类型（0其它 1新增 2修改 3删除）';
COMMENT ON COLUMN "public"."sys_oper_log"."method" IS '方法名称';
COMMENT ON COLUMN "public"."sys_oper_log"."request_method" IS '请求方式';
COMMENT ON COLUMN "public"."sys_oper_log"."operator_type" IS '操作类别（0其它 1后台用户 2手机端用户）';
COMMENT ON COLUMN "public"."sys_oper_log"."oper_name" IS '操作人员';
COMMENT ON COLUMN "public"."sys_oper_log"."dept_name" IS '部门名称';
COMMENT ON COLUMN "public"."sys_oper_log"."oper_url" IS '请求URL';
COMMENT ON COLUMN "public"."sys_oper_log"."oper_ip" IS '主机地址';
COMMENT ON COLUMN "public"."sys_oper_log"."oper_location" IS '操作地点';
COMMENT ON COLUMN "public"."sys_oper_log"."oper_param" IS '请求参数';
COMMENT ON COLUMN "public"."sys_oper_log"."json_result" IS '返回参数';
COMMENT ON COLUMN "public"."sys_oper_log"."status" IS '操作状态（0正常 1异常）';
COMMENT ON COLUMN "public"."sys_oper_log"."error_msg" IS '错误消息';
COMMENT ON COLUMN "public"."sys_oper_log"."oper_time" IS '操作时间';
COMMENT ON COLUMN "public"."sys_oper_log"."cost_time" IS '消耗时间';
COMMENT ON TABLE "public"."sys_oper_log" IS '操作日志记录';

-- ----------------------------
-- Table structure for sys_oss
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_oss";
CREATE TABLE "public"."sys_oss" (
  "oss_id" int8 NOT NULL,
  "tenant_id" varchar(20) COLLATE "pg_catalog"."default" DEFAULT '000000'::character varying,
  "file_name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "original_name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "file_suffix" varchar(10) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "url" varchar(500) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "ext1" varchar(500) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "create_dept" int8,
  "create_by" int8,
  "create_time" timestamp(6),
  "update_by" int8,
  "update_time" timestamp(6),
  "service" varchar(20) COLLATE "pg_catalog"."default" DEFAULT 'minio'::character varying
)
;
COMMENT ON COLUMN "public"."sys_oss"."oss_id" IS '对象存储主键';
COMMENT ON COLUMN "public"."sys_oss"."tenant_id" IS '租户编码';
COMMENT ON COLUMN "public"."sys_oss"."file_name" IS '文件名';
COMMENT ON COLUMN "public"."sys_oss"."original_name" IS '原名';
COMMENT ON COLUMN "public"."sys_oss"."file_suffix" IS '文件后缀名';
COMMENT ON COLUMN "public"."sys_oss"."url" IS 'URL地址';
COMMENT ON COLUMN "public"."sys_oss"."ext1" IS '扩展字段';
COMMENT ON COLUMN "public"."sys_oss"."create_dept" IS '创建部门';
COMMENT ON COLUMN "public"."sys_oss"."create_by" IS '上传人';
COMMENT ON COLUMN "public"."sys_oss"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."sys_oss"."update_by" IS '更新者';
COMMENT ON COLUMN "public"."sys_oss"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."sys_oss"."service" IS '服务商';
COMMENT ON TABLE "public"."sys_oss" IS 'OSS对象存储表';

-- ----------------------------
-- Table structure for sys_oss_config
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_oss_config";
CREATE TABLE "public"."sys_oss_config" (
  "oss_config_id" int8 NOT NULL,
  "tenant_id" varchar(20) COLLATE "pg_catalog"."default" DEFAULT '000000'::character varying,
  "config_key" varchar(20) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "access_key" varchar(255) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "secret_key" varchar(255) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "bucket_name" varchar(255) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "prefix" varchar(255) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "endpoint" varchar(255) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "domain" varchar(255) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "is_https" char(1) COLLATE "pg_catalog"."default" DEFAULT 'N'::bpchar,
  "region" varchar(255) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "access_policy" char(1) COLLATE "pg_catalog"."default" NOT NULL DEFAULT '1'::bpchar,
  "status" char(1) COLLATE "pg_catalog"."default" DEFAULT '1'::bpchar,
  "ext1" varchar(255) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "create_dept" int8,
  "create_by" int8,
  "create_time" timestamp(6),
  "update_by" int8,
  "update_time" timestamp(6),
  "remark" varchar(500) COLLATE "pg_catalog"."default" DEFAULT ''::character varying
)
;
COMMENT ON COLUMN "public"."sys_oss_config"."oss_config_id" IS '主键';
COMMENT ON COLUMN "public"."sys_oss_config"."tenant_id" IS '租户编码';
COMMENT ON COLUMN "public"."sys_oss_config"."config_key" IS '配置key';
COMMENT ON COLUMN "public"."sys_oss_config"."access_key" IS 'accessKey';
COMMENT ON COLUMN "public"."sys_oss_config"."secret_key" IS '秘钥';
COMMENT ON COLUMN "public"."sys_oss_config"."bucket_name" IS '桶名称';
COMMENT ON COLUMN "public"."sys_oss_config"."prefix" IS '前缀';
COMMENT ON COLUMN "public"."sys_oss_config"."endpoint" IS '访问站点';
COMMENT ON COLUMN "public"."sys_oss_config"."domain" IS '自定义域名';
COMMENT ON COLUMN "public"."sys_oss_config"."is_https" IS '是否https（Y=是,N=否）';
COMMENT ON COLUMN "public"."sys_oss_config"."region" IS '域';
COMMENT ON COLUMN "public"."sys_oss_config"."access_policy" IS '桶权限类型(0=private 1=public 2=custom)';
COMMENT ON COLUMN "public"."sys_oss_config"."status" IS '是否默认（0=是,1=否）';
COMMENT ON COLUMN "public"."sys_oss_config"."ext1" IS '扩展字段';
COMMENT ON COLUMN "public"."sys_oss_config"."create_dept" IS '创建部门';
COMMENT ON COLUMN "public"."sys_oss_config"."create_by" IS '创建者';
COMMENT ON COLUMN "public"."sys_oss_config"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."sys_oss_config"."update_by" IS '更新者';
COMMENT ON COLUMN "public"."sys_oss_config"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."sys_oss_config"."remark" IS '备注';
COMMENT ON TABLE "public"."sys_oss_config" IS '对象存储配置表';

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_post";
CREATE TABLE "public"."sys_post" (
  "post_id" int8 NOT NULL,
  "tenant_id" varchar(20) COLLATE "pg_catalog"."default" DEFAULT '000000'::character varying,
  "dept_id" int8,
  "post_code" varchar(64) COLLATE "pg_catalog"."default" NOT NULL,
  "post_category" varchar(100) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "post_name" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "post_sort" int4 NOT NULL,
  "status" char(1) COLLATE "pg_catalog"."default" NOT NULL,
  "create_dept" int8,
  "create_by" int8,
  "create_time" timestamp(6),
  "update_by" int8,
  "update_time" timestamp(6),
  "remark" varchar(500) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying
)
;
COMMENT ON COLUMN "public"."sys_post"."post_id" IS '岗位ID';
COMMENT ON COLUMN "public"."sys_post"."tenant_id" IS '租户编号';
COMMENT ON COLUMN "public"."sys_post"."dept_id" IS '部门id';
COMMENT ON COLUMN "public"."sys_post"."post_code" IS '岗位编码';
COMMENT ON COLUMN "public"."sys_post"."post_category" IS '岗位类别编码';
COMMENT ON COLUMN "public"."sys_post"."post_name" IS '岗位名称';
COMMENT ON COLUMN "public"."sys_post"."post_sort" IS '显示顺序';
COMMENT ON COLUMN "public"."sys_post"."status" IS '状态（0正常 1停用）';
COMMENT ON COLUMN "public"."sys_post"."create_dept" IS '创建部门';
COMMENT ON COLUMN "public"."sys_post"."create_by" IS '创建者';
COMMENT ON COLUMN "public"."sys_post"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."sys_post"."update_by" IS '更新者';
COMMENT ON COLUMN "public"."sys_post"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."sys_post"."remark" IS '备注';
COMMENT ON TABLE "public"."sys_post" IS '岗位信息表';

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_role";
CREATE TABLE "public"."sys_role" (
  "role_id" int8 NOT NULL,
  "tenant_id" varchar(20) COLLATE "pg_catalog"."default" DEFAULT '000000'::character varying,
  "role_name" varchar(30) COLLATE "pg_catalog"."default" NOT NULL,
  "role_key" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "role_sort" int4 NOT NULL,
  "data_scope" char(1) COLLATE "pg_catalog"."default" DEFAULT '1'::bpchar,
  "menu_check_strictly" bool DEFAULT true,
  "dept_check_strictly" bool DEFAULT true,
  "status" char(1) COLLATE "pg_catalog"."default" NOT NULL,
  "del_flag" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar,
  "create_dept" int8,
  "create_by" int8,
  "create_time" timestamp(6),
  "update_by" int8,
  "update_time" timestamp(6),
  "remark" varchar(500) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying
)
;
COMMENT ON COLUMN "public"."sys_role"."role_id" IS '角色ID';
COMMENT ON COLUMN "public"."sys_role"."tenant_id" IS '租户编号';
COMMENT ON COLUMN "public"."sys_role"."role_name" IS '角色名称';
COMMENT ON COLUMN "public"."sys_role"."role_key" IS '角色权限字符串';
COMMENT ON COLUMN "public"."sys_role"."role_sort" IS '显示顺序';
COMMENT ON COLUMN "public"."sys_role"."data_scope" IS '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限 5：仅本人数据权限 6：部门及以下或本人数据权限）';
COMMENT ON COLUMN "public"."sys_role"."menu_check_strictly" IS '菜单树选择项是否关联显示';
COMMENT ON COLUMN "public"."sys_role"."dept_check_strictly" IS '部门树选择项是否关联显示';
COMMENT ON COLUMN "public"."sys_role"."status" IS '角色状态（0正常 1停用）';
COMMENT ON COLUMN "public"."sys_role"."del_flag" IS '删除标志（0代表存在 1代表删除）';
COMMENT ON COLUMN "public"."sys_role"."create_dept" IS '创建部门';
COMMENT ON COLUMN "public"."sys_role"."create_by" IS '创建者';
COMMENT ON COLUMN "public"."sys_role"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."sys_role"."update_by" IS '更新者';
COMMENT ON COLUMN "public"."sys_role"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."sys_role"."remark" IS '备注';
COMMENT ON TABLE "public"."sys_role" IS '角色信息表';

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_role_dept";
CREATE TABLE "public"."sys_role_dept" (
  "role_id" int8 NOT NULL,
  "dept_id" int8 NOT NULL
)
;
COMMENT ON COLUMN "public"."sys_role_dept"."role_id" IS '角色ID';
COMMENT ON COLUMN "public"."sys_role_dept"."dept_id" IS '部门ID';
COMMENT ON TABLE "public"."sys_role_dept" IS '角色和部门关联表';

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_role_menu";
CREATE TABLE "public"."sys_role_menu" (
  "role_id" int8 NOT NULL,
  "menu_id" int8 NOT NULL
)
;
COMMENT ON COLUMN "public"."sys_role_menu"."role_id" IS '角色ID';
COMMENT ON COLUMN "public"."sys_role_menu"."menu_id" IS '菜单ID';
COMMENT ON TABLE "public"."sys_role_menu" IS '角色和菜单关联表';

-- ----------------------------
-- Table structure for sys_social
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_social";
CREATE TABLE "public"."sys_social" (
  "id" int8 NOT NULL,
  "user_id" int8 NOT NULL,
  "tenant_id" varchar(20) COLLATE "pg_catalog"."default" DEFAULT '000000'::character varying,
  "auth_id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "source" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "open_id" varchar(255) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "user_name" varchar(30) COLLATE "pg_catalog"."default" NOT NULL,
  "nick_name" varchar(30) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "email" varchar(255) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "avatar" varchar(500) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "access_token" varchar(2000) COLLATE "pg_catalog"."default" NOT NULL,
  "expire_in" int8,
  "refresh_token" varchar(2000) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "access_code" varchar(255) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "union_id" varchar(255) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "scope" varchar(255) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "token_type" varchar(255) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "id_token" varchar(2000) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "mac_algorithm" varchar(255) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "mac_key" varchar(255) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "code" varchar(255) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "oauth_token" varchar(255) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "oauth_token_secret" varchar(255) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "create_dept" int8,
  "create_by" int8,
  "create_time" timestamp(6),
  "update_by" int8,
  "update_time" timestamp(6),
  "del_flag" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar
)
;
COMMENT ON COLUMN "public"."sys_social"."id" IS '主键';
COMMENT ON COLUMN "public"."sys_social"."user_id" IS '用户ID';
COMMENT ON COLUMN "public"."sys_social"."tenant_id" IS '租户id';
COMMENT ON COLUMN "public"."sys_social"."auth_id" IS '平台+平台唯一id';
COMMENT ON COLUMN "public"."sys_social"."source" IS '用户来源';
COMMENT ON COLUMN "public"."sys_social"."open_id" IS '平台编号唯一id';
COMMENT ON COLUMN "public"."sys_social"."user_name" IS '登录账号';
COMMENT ON COLUMN "public"."sys_social"."nick_name" IS '用户昵称';
COMMENT ON COLUMN "public"."sys_social"."email" IS '用户邮箱';
COMMENT ON COLUMN "public"."sys_social"."avatar" IS '头像地址';
COMMENT ON COLUMN "public"."sys_social"."access_token" IS '用户的授权令牌';
COMMENT ON COLUMN "public"."sys_social"."expire_in" IS '用户的授权令牌的有效期，部分平台可能没有';
COMMENT ON COLUMN "public"."sys_social"."refresh_token" IS '刷新令牌，部分平台可能没有';
COMMENT ON COLUMN "public"."sys_social"."access_code" IS '平台的授权信息，部分平台可能没有';
COMMENT ON COLUMN "public"."sys_social"."union_id" IS '用户的 unionid';
COMMENT ON COLUMN "public"."sys_social"."scope" IS '授予的权限，部分平台可能没有';
COMMENT ON COLUMN "public"."sys_social"."token_type" IS '个别平台的授权信息，部分平台可能没有';
COMMENT ON COLUMN "public"."sys_social"."id_token" IS 'id token，部分平台可能没有';
COMMENT ON COLUMN "public"."sys_social"."mac_algorithm" IS '小米平台用户的附带属性，部分平台可能没有';
COMMENT ON COLUMN "public"."sys_social"."mac_key" IS '小米平台用户的附带属性，部分平台可能没有';
COMMENT ON COLUMN "public"."sys_social"."code" IS '用户的授权code，部分平台可能没有';
COMMENT ON COLUMN "public"."sys_social"."oauth_token" IS 'Twitter平台用户的附带属性，部分平台可能没有';
COMMENT ON COLUMN "public"."sys_social"."oauth_token_secret" IS 'Twitter平台用户的附带属性，部分平台可能没有';
COMMENT ON COLUMN "public"."sys_social"."create_dept" IS '创建部门';
COMMENT ON COLUMN "public"."sys_social"."create_by" IS '创建者';
COMMENT ON COLUMN "public"."sys_social"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."sys_social"."update_by" IS '更新者';
COMMENT ON COLUMN "public"."sys_social"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."sys_social"."del_flag" IS '删除标志（0代表存在 1代表删除）';
COMMENT ON TABLE "public"."sys_social" IS '社会化关系表';

-- ----------------------------
-- Table structure for sys_tenant
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_tenant";
CREATE TABLE "public"."sys_tenant" (
  "id" int8 NOT NULL,
  "tenant_id" varchar(20) COLLATE "pg_catalog"."default" NOT NULL,
  "contact_user_name" varchar(20) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "contact_phone" varchar(20) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "company_name" varchar(30) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "license_number" varchar(30) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "address" varchar(200) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "intro" varchar(200) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "domain" varchar(200) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "remark" varchar(200) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "package_id" int8,
  "expire_time" timestamp(6),
  "account_count" int4 DEFAULT '-1'::integer,
  "status" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar,
  "del_flag" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar,
  "create_dept" int8,
  "create_by" int8,
  "create_time" timestamp(6),
  "update_by" int8,
  "update_time" timestamp(6)
)
;
COMMENT ON COLUMN "public"."sys_tenant"."tenant_id" IS '租户编号';
COMMENT ON COLUMN "public"."sys_tenant"."contact_phone" IS '联系电话';
COMMENT ON COLUMN "public"."sys_tenant"."company_name" IS '联系人';
COMMENT ON COLUMN "public"."sys_tenant"."license_number" IS '统一社会信用代码';
COMMENT ON COLUMN "public"."sys_tenant"."address" IS '地址';
COMMENT ON COLUMN "public"."sys_tenant"."intro" IS '企业简介';
COMMENT ON COLUMN "public"."sys_tenant"."domain" IS '域名';
COMMENT ON COLUMN "public"."sys_tenant"."remark" IS '备注';
COMMENT ON COLUMN "public"."sys_tenant"."package_id" IS '租户套餐编号';
COMMENT ON COLUMN "public"."sys_tenant"."expire_time" IS '过期时间';
COMMENT ON COLUMN "public"."sys_tenant"."account_count" IS '用户数量（-1不限制）';
COMMENT ON COLUMN "public"."sys_tenant"."status" IS '租户状态（0正常 1停用）';
COMMENT ON COLUMN "public"."sys_tenant"."del_flag" IS '删除标志（0代表存在 1代表删除）';
COMMENT ON COLUMN "public"."sys_tenant"."create_dept" IS '创建部门';
COMMENT ON COLUMN "public"."sys_tenant"."create_by" IS '创建者';
COMMENT ON COLUMN "public"."sys_tenant"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."sys_tenant"."update_by" IS '更新者';
COMMENT ON COLUMN "public"."sys_tenant"."update_time" IS '更新时间';
COMMENT ON TABLE "public"."sys_tenant" IS '租户表';

-- ----------------------------
-- Table structure for sys_tenant_package
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_tenant_package";
CREATE TABLE "public"."sys_tenant_package" (
  "package_id" int8 NOT NULL,
  "package_name" varchar(20) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "menu_ids" varchar(3000) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "remark" varchar(200) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "menu_check_strictly" bool DEFAULT true,
  "status" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar,
  "del_flag" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar,
  "create_dept" int8,
  "create_by" int8,
  "create_time" timestamp(6),
  "update_by" int8,
  "update_time" timestamp(6)
)
;
COMMENT ON COLUMN "public"."sys_tenant_package"."package_id" IS '租户套餐id';
COMMENT ON COLUMN "public"."sys_tenant_package"."package_name" IS '套餐名称';
COMMENT ON COLUMN "public"."sys_tenant_package"."menu_ids" IS '关联菜单id';
COMMENT ON COLUMN "public"."sys_tenant_package"."remark" IS '备注';
COMMENT ON COLUMN "public"."sys_tenant_package"."status" IS '状态（0正常 1停用）';
COMMENT ON COLUMN "public"."sys_tenant_package"."del_flag" IS '删除标志（0代表存在 1代表删除）';
COMMENT ON COLUMN "public"."sys_tenant_package"."create_dept" IS '创建部门';
COMMENT ON COLUMN "public"."sys_tenant_package"."create_by" IS '创建者';
COMMENT ON COLUMN "public"."sys_tenant_package"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."sys_tenant_package"."update_by" IS '更新者';
COMMENT ON COLUMN "public"."sys_tenant_package"."update_time" IS '更新时间';
COMMENT ON TABLE "public"."sys_tenant_package" IS '租户套餐表';

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_user";
CREATE TABLE "public"."sys_user" (
  "user_id" int8 NOT NULL,
  "tenant_id" varchar(20) COLLATE "pg_catalog"."default" DEFAULT '000000'::character varying,
  "dept_id" int8,
  "user_name" varchar(30) COLLATE "pg_catalog"."default" NOT NULL,
  "nick_name" varchar(30) COLLATE "pg_catalog"."default" NOT NULL,
  "user_type" varchar(10) COLLATE "pg_catalog"."default" DEFAULT 'sys_user'::character varying,
  "email" varchar(50) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "phonenumber" varchar(11) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "sex" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar,
  "avatar" int8,
  "password" varchar(100) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "status" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar,
  "del_flag" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar,
  "login_ip" varchar(128) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "login_date" timestamp(6),
  "create_dept" int8,
  "create_by" int8,
  "create_time" timestamp(6),
  "update_by" int8,
  "update_time" timestamp(6),
  "remark" varchar(500) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying
)
;
COMMENT ON COLUMN "public"."sys_user"."user_id" IS '用户ID';
COMMENT ON COLUMN "public"."sys_user"."tenant_id" IS '租户编号';
COMMENT ON COLUMN "public"."sys_user"."dept_id" IS '部门ID';
COMMENT ON COLUMN "public"."sys_user"."user_name" IS '用户账号';
COMMENT ON COLUMN "public"."sys_user"."nick_name" IS '用户昵称';
COMMENT ON COLUMN "public"."sys_user"."user_type" IS '用户类型（sys_user系统用户）';
COMMENT ON COLUMN "public"."sys_user"."email" IS '用户邮箱';
COMMENT ON COLUMN "public"."sys_user"."phonenumber" IS '手机号码';
COMMENT ON COLUMN "public"."sys_user"."sex" IS '用户性别（0男 1女 2未知）';
COMMENT ON COLUMN "public"."sys_user"."avatar" IS '头像地址';
COMMENT ON COLUMN "public"."sys_user"."password" IS '密码';
COMMENT ON COLUMN "public"."sys_user"."status" IS '帐号状态（0正常 1停用）';
COMMENT ON COLUMN "public"."sys_user"."del_flag" IS '删除标志（0代表存在 1代表删除）';
COMMENT ON COLUMN "public"."sys_user"."login_ip" IS '最后登陆IP';
COMMENT ON COLUMN "public"."sys_user"."login_date" IS '最后登陆时间';
COMMENT ON COLUMN "public"."sys_user"."create_dept" IS '创建部门';
COMMENT ON COLUMN "public"."sys_user"."create_by" IS '创建者';
COMMENT ON COLUMN "public"."sys_user"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."sys_user"."update_by" IS '更新者';
COMMENT ON COLUMN "public"."sys_user"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."sys_user"."remark" IS '备注';
COMMENT ON TABLE "public"."sys_user" IS '用户信息表';

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_user_post";
CREATE TABLE "public"."sys_user_post" (
  "user_id" int8 NOT NULL,
  "post_id" int8 NOT NULL
)
;
COMMENT ON COLUMN "public"."sys_user_post"."user_id" IS '用户ID';
COMMENT ON COLUMN "public"."sys_user_post"."post_id" IS '岗位ID';
COMMENT ON TABLE "public"."sys_user_post" IS '用户与岗位关联表';

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_user_role";
CREATE TABLE "public"."sys_user_role" (
  "user_id" int8 NOT NULL,
  "role_id" int8 NOT NULL
)
;
COMMENT ON COLUMN "public"."sys_user_role"."user_id" IS '用户ID';
COMMENT ON COLUMN "public"."sys_user_role"."role_id" IS '角色ID';
COMMENT ON TABLE "public"."sys_user_role" IS '用户和角色关联表';

-- ----------------------------
-- Table structure for test_demo
-- ----------------------------
DROP TABLE IF EXISTS "public"."test_demo";
CREATE TABLE "public"."test_demo" (
  "id" int8,
  "tenant_id" varchar(20) COLLATE "pg_catalog"."default" DEFAULT '000000'::character varying,
  "dept_id" int8,
  "user_id" int8,
  "order_num" int4 DEFAULT 0,
  "test_key" varchar(255) COLLATE "pg_catalog"."default",
  "value" varchar(255) COLLATE "pg_catalog"."default",
  "version" int4 DEFAULT 0,
  "create_dept" int8,
  "create_time" timestamp(6),
  "create_by" int8,
  "update_time" timestamp(6),
  "update_by" int8,
  "del_flag" int4 DEFAULT 0
)
;
COMMENT ON COLUMN "public"."test_demo"."id" IS '主键';
COMMENT ON COLUMN "public"."test_demo"."tenant_id" IS '租户编号';
COMMENT ON COLUMN "public"."test_demo"."dept_id" IS '部门id';
COMMENT ON COLUMN "public"."test_demo"."user_id" IS '用户id';
COMMENT ON COLUMN "public"."test_demo"."order_num" IS '排序号';
COMMENT ON COLUMN "public"."test_demo"."test_key" IS 'key键';
COMMENT ON COLUMN "public"."test_demo"."value" IS '值';
COMMENT ON COLUMN "public"."test_demo"."version" IS '版本';
COMMENT ON COLUMN "public"."test_demo"."create_dept" IS '创建部门';
COMMENT ON COLUMN "public"."test_demo"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."test_demo"."create_by" IS '创建人';
COMMENT ON COLUMN "public"."test_demo"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."test_demo"."update_by" IS '更新人';
COMMENT ON COLUMN "public"."test_demo"."del_flag" IS '删除标志';
COMMENT ON TABLE "public"."test_demo" IS '测试单表';

-- ----------------------------
-- Table structure for test_tree
-- ----------------------------
DROP TABLE IF EXISTS "public"."test_tree";
CREATE TABLE "public"."test_tree" (
  "id" int8,
  "tenant_id" varchar(20) COLLATE "pg_catalog"."default" DEFAULT '000000'::character varying,
  "parent_id" int8 DEFAULT 0,
  "dept_id" int8,
  "user_id" int8,
  "tree_name" varchar(255) COLLATE "pg_catalog"."default",
  "version" int4 DEFAULT 0,
  "create_dept" int8,
  "create_time" timestamp(6),
  "create_by" int8,
  "update_time" timestamp(6),
  "update_by" int8,
  "del_flag" int4 DEFAULT 0
)
;
COMMENT ON COLUMN "public"."test_tree"."id" IS '主键';
COMMENT ON COLUMN "public"."test_tree"."tenant_id" IS '租户编号';
COMMENT ON COLUMN "public"."test_tree"."parent_id" IS '父id';
COMMENT ON COLUMN "public"."test_tree"."dept_id" IS '部门id';
COMMENT ON COLUMN "public"."test_tree"."user_id" IS '用户id';
COMMENT ON COLUMN "public"."test_tree"."tree_name" IS '值';
COMMENT ON COLUMN "public"."test_tree"."version" IS '版本';
COMMENT ON COLUMN "public"."test_tree"."create_dept" IS '创建部门';
COMMENT ON COLUMN "public"."test_tree"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."test_tree"."create_by" IS '创建人';
COMMENT ON COLUMN "public"."test_tree"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."test_tree"."update_by" IS '更新人';
COMMENT ON COLUMN "public"."test_tree"."del_flag" IS '删除标志';
COMMENT ON TABLE "public"."test_tree" IS '测试树表';

-- ----------------------------
-- Function structure for cast_varchar_to_timestamp
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."cast_varchar_to_timestamp"(varchar);
CREATE OR REPLACE FUNCTION "public"."cast_varchar_to_timestamp"(varchar)
  RETURNS "pg_catalog"."timestamptz" AS $BODY$
select to_timestamp($1, 'yyyy-mm-dd hh24:mi:ss');
$BODY$
  LANGUAGE sql VOLATILE STRICT
  COST 100;

-- ----------------------------
-- Primary Key structure for table gen_table
-- ----------------------------
ALTER TABLE "public"."gen_table" ADD CONSTRAINT "gen_table_pk" PRIMARY KEY ("table_id");

-- ----------------------------
-- Primary Key structure for table gen_table_column
-- ----------------------------
ALTER TABLE "public"."gen_table_column" ADD CONSTRAINT "gen_table_column_pk" PRIMARY KEY ("column_id");

-- ----------------------------
-- Primary Key structure for table ss_achievement
-- ----------------------------
ALTER TABLE "public"."ss_achievement" ADD CONSTRAINT "ss_achievement_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table ss_child
-- ----------------------------
ALTER TABLE "public"."ss_child" ADD CONSTRAINT "ss_child_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table ss_child_achievement
-- ----------------------------
ALTER TABLE "public"."ss_child_achievement" ADD CONSTRAINT "ss_child_achievement_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table ss_child_item
-- ----------------------------
ALTER TABLE "public"."ss_child_item" ADD CONSTRAINT "ss_child_item_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table ss_child_score
-- ----------------------------
ALTER TABLE "public"."ss_child_score" ADD CONSTRAINT "ss_child_score_pkey" PRIMARY KEY ("user_id");

-- ----------------------------
-- Primary Key structure for table ss_device
-- ----------------------------
ALTER TABLE "public"."ss_device" ADD CONSTRAINT "ss_device_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table ss_device_log
-- ----------------------------
ALTER TABLE "public"."ss_device_log" ADD CONSTRAINT "ss_device_log_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table ss_emotion_record
-- ----------------------------
ALTER TABLE "public"."ss_emotion_record" ADD CONSTRAINT "ss_emotion_record_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table ss_family_member
-- ----------------------------
ALTER TABLE "public"."ss_family_member" ADD CONSTRAINT "ss_family_member_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table ss_game_item
-- ----------------------------
ALTER TABLE "public"."ss_game_item" ADD CONSTRAINT "ss_game_item_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table ss_knowledge_card
-- ----------------------------
ALTER TABLE "public"."ss_knowledge_card" ADD CONSTRAINT "ss_knowledge_card_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table ss_knowledge_user_rel
-- ----------------------------
ALTER TABLE "public"."ss_knowledge_user_rel" ADD CONSTRAINT "ss_knowledge_user_rel_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table ss_level_config
-- ----------------------------
ALTER TABLE "public"."ss_level_config" ADD CONSTRAINT "ss_level_config_pkey" PRIMARY KEY ("level");

-- ----------------------------
-- Primary Key structure for table ss_parent_contract
-- ----------------------------
ALTER TABLE "public"."ss_parent_contract" ADD CONSTRAINT "ss_parent_contract_pkey" PRIMARY KEY ("contract_id");

-- ----------------------------
-- Primary Key structure for table ss_parent_reward
-- ----------------------------
ALTER TABLE "public"."ss_parent_reward" ADD CONSTRAINT "ss_parent_reward_pkey" PRIMARY KEY ("reward_id");

-- ----------------------------
-- Primary Key structure for table ss_parent_reward_redemption
-- ----------------------------
ALTER TABLE "public"."ss_parent_reward_redemption" ADD CONSTRAINT "ss_parent_reward_redemption_pkey" PRIMARY KEY ("redemption_id");

-- ----------------------------
-- Primary Key structure for table ss_parent_task
-- ----------------------------
ALTER TABLE "public"."ss_parent_task" ADD CONSTRAINT "ss_parent_task_pkey" PRIMARY KEY ("task_id");

-- ----------------------------
-- Primary Key structure for table ss_reward
-- ----------------------------
ALTER TABLE "public"."ss_reward" ADD CONSTRAINT "ss_reward_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table ss_reward_exchange
-- ----------------------------
ALTER TABLE "public"."ss_reward_exchange" ADD CONSTRAINT "ss_reward_exchange_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table ss_score_history
-- ----------------------------
ALTER TABLE "public"."ss_score_history" ADD CONSTRAINT "ss_score_history_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table ss_star_record
-- ----------------------------
ALTER TABLE "public"."ss_star_record" ADD CONSTRAINT "ss_star_record_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table ss_task
-- ----------------------------
ALTER TABLE "public"."ss_task" ADD CONSTRAINT "ss_task_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table ss_task_log
-- ----------------------------
ALTER TABLE "public"."ss_task_log" ADD CONSTRAINT "ss_task_log_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table ss_task_preset
-- ----------------------------
ALTER TABLE "public"."ss_task_preset" ADD CONSTRAINT "ss_task_preset_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table sys_ai_model
-- ----------------------------
ALTER TABLE "public"."sys_ai_model" ADD CONSTRAINT "sys_ai_model_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table sys_ai_provider
-- ----------------------------
ALTER TABLE "public"."sys_ai_provider" ADD CONSTRAINT "sys_ai_provider_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table sys_ai_route
-- ----------------------------
ALTER TABLE "public"."sys_ai_route" ADD CONSTRAINT "sys_ai_route_pkey" PRIMARY KEY ("scene_key");

-- ----------------------------
-- Primary Key structure for table sys_client
-- ----------------------------
ALTER TABLE "public"."sys_client" ADD CONSTRAINT "sys_client_pk" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table sys_config
-- ----------------------------
ALTER TABLE "public"."sys_config" ADD CONSTRAINT "sys_config_pk" PRIMARY KEY ("config_id");

-- ----------------------------
-- Primary Key structure for table sys_dept
-- ----------------------------
ALTER TABLE "public"."sys_dept" ADD CONSTRAINT "sys_dept_pk" PRIMARY KEY ("dept_id");

-- ----------------------------
-- Primary Key structure for table sys_dict_data
-- ----------------------------
ALTER TABLE "public"."sys_dict_data" ADD CONSTRAINT "sys_dict_data_pk" PRIMARY KEY ("dict_code");

-- ----------------------------
-- Indexes structure for table sys_dict_type
-- ----------------------------
CREATE UNIQUE INDEX "sys_dict_type_index1" ON "public"."sys_dict_type" USING btree (
  "tenant_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
  "dict_type" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table sys_dict_type
-- ----------------------------
ALTER TABLE "public"."sys_dict_type" ADD CONSTRAINT "sys_dict_type_pk" PRIMARY KEY ("dict_id");

-- ----------------------------
-- Indexes structure for table sys_logininfor
-- ----------------------------
CREATE INDEX "idx_sys_logininfor_lt" ON "public"."sys_logininfor" USING btree (
  "login_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST
);
CREATE INDEX "idx_sys_logininfor_s" ON "public"."sys_logininfor" USING btree (
  "status" COLLATE "pg_catalog"."default" "pg_catalog"."bpchar_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table sys_logininfor
-- ----------------------------
ALTER TABLE "public"."sys_logininfor" ADD CONSTRAINT "sys_logininfor_pk" PRIMARY KEY ("info_id");

-- ----------------------------
-- Primary Key structure for table sys_menu
-- ----------------------------
ALTER TABLE "public"."sys_menu" ADD CONSTRAINT "sys_menu_pk" PRIMARY KEY ("menu_id");

-- ----------------------------
-- Primary Key structure for table sys_notice
-- ----------------------------
ALTER TABLE "public"."sys_notice" ADD CONSTRAINT "sys_notice_pk" PRIMARY KEY ("notice_id");

-- ----------------------------
-- Indexes structure for table sys_oper_log
-- ----------------------------
CREATE INDEX "idx_sys_oper_log_bt" ON "public"."sys_oper_log" USING btree (
  "business_type" "pg_catalog"."int4_ops" ASC NULLS LAST
);
CREATE INDEX "idx_sys_oper_log_ot" ON "public"."sys_oper_log" USING btree (
  "oper_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST
);
CREATE INDEX "idx_sys_oper_log_s" ON "public"."sys_oper_log" USING btree (
  "status" "pg_catalog"."int4_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table sys_oper_log
-- ----------------------------
ALTER TABLE "public"."sys_oper_log" ADD CONSTRAINT "sys_oper_log_pk" PRIMARY KEY ("oper_id");

-- ----------------------------
-- Primary Key structure for table sys_oss
-- ----------------------------
ALTER TABLE "public"."sys_oss" ADD CONSTRAINT "sys_oss_pk" PRIMARY KEY ("oss_id");

-- ----------------------------
-- Primary Key structure for table sys_oss_config
-- ----------------------------
ALTER TABLE "public"."sys_oss_config" ADD CONSTRAINT "sys_oss_config_pk" PRIMARY KEY ("oss_config_id");

-- ----------------------------
-- Primary Key structure for table sys_post
-- ----------------------------
ALTER TABLE "public"."sys_post" ADD CONSTRAINT "sys_post_pk" PRIMARY KEY ("post_id");

-- ----------------------------
-- Primary Key structure for table sys_role
-- ----------------------------
ALTER TABLE "public"."sys_role" ADD CONSTRAINT "sys_role_pk" PRIMARY KEY ("role_id");

-- ----------------------------
-- Primary Key structure for table sys_role_dept
-- ----------------------------
ALTER TABLE "public"."sys_role_dept" ADD CONSTRAINT "sys_role_dept_pk" PRIMARY KEY ("role_id", "dept_id");

-- ----------------------------
-- Primary Key structure for table sys_role_menu
-- ----------------------------
ALTER TABLE "public"."sys_role_menu" ADD CONSTRAINT "sys_role_menu_pk" PRIMARY KEY ("role_id", "menu_id");

-- ----------------------------
-- Primary Key structure for table sys_social
-- ----------------------------
ALTER TABLE "public"."sys_social" ADD CONSTRAINT "pk_sys_social" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table sys_tenant
-- ----------------------------
ALTER TABLE "public"."sys_tenant" ADD CONSTRAINT "pk_sys_tenant" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table sys_tenant_package
-- ----------------------------
ALTER TABLE "public"."sys_tenant_package" ADD CONSTRAINT "pk_sys_tenant_package" PRIMARY KEY ("package_id");

-- ----------------------------
-- Primary Key structure for table sys_user
-- ----------------------------
ALTER TABLE "public"."sys_user" ADD CONSTRAINT "sys_user_pk" PRIMARY KEY ("user_id");

-- ----------------------------
-- Primary Key structure for table sys_user_post
-- ----------------------------
ALTER TABLE "public"."sys_user_post" ADD CONSTRAINT "sys_user_post_pk" PRIMARY KEY ("user_id", "post_id");

-- ----------------------------
-- Primary Key structure for table sys_user_role
-- ----------------------------
ALTER TABLE "public"."sys_user_role" ADD CONSTRAINT "sys_user_role_pk" PRIMARY KEY ("user_id", "role_id");
