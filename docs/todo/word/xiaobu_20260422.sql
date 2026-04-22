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

 Date: 22/04/2026 20:53:23
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
-- Records of gen_table
-- ----------------------------

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
-- Records of gen_table_column
-- ----------------------------

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
-- Records of ss_achievement
-- ----------------------------

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
-- Records of ss_child
-- ----------------------------
INSERT INTO "public"."ss_child" VALUES (10001, 'SS0001', 1000, '小明', '/avatar/boy1.png', '{"hair": "short", "clothes": "blue", "accessories": "glasses"}', 3, '{"maxScreenTime": 60, "maxTasksPerDay": 5}', '0', '2016-05-15 00:00:00', 150, 580, '["注意力不集中", "多动", "冲动"]', 200, 1000, '2026-03-14 20:37:08.630644', NULL, NULL, '9岁男孩，ADHD，喜欢恐龙和乐高', '0');
INSERT INTO "public"."ss_child" VALUES (10002, 'SS0001', 1000, '小红', '/avatar/girl1.png', '{"hair": "long", "clothes": "pink", "accessories": "bow"}', 2, '{"maxScreenTime": 45, "maxTasksPerDay": 4}', '1', '2018-08-20 00:00:00', 80, 220, '["注意力不集中", "情绪波动"]', 200, 1000, '2026-03-14 20:37:08.772333', NULL, NULL, '7岁女孩，ADHD，喜欢画画和跳舞', '0');

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
  "unlock_time" timestamp(6),
  "type" varchar(20) COLLATE "pg_catalog"."default",
  "name" varchar(64) COLLATE "pg_catalog"."default",
  "count" int4 DEFAULT 0,
  "icon" varchar(255) COLLATE "pg_catalog"."default",
  "remark" varchar(500) COLLATE "pg_catalog"."default"
)
;
COMMENT ON COLUMN "public"."ss_child_achievement"."type" IS '成就类型 (STAR-星星, FRAGMENT-勇气碎片, BADGE-勋章)';
COMMENT ON COLUMN "public"."ss_child_achievement"."name" IS '名称';
COMMENT ON COLUMN "public"."ss_child_achievement"."count" IS '数量/进度';
COMMENT ON COLUMN "public"."ss_child_achievement"."icon" IS '图标';
COMMENT ON COLUMN "public"."ss_child_achievement"."remark" IS '备注/描述';
COMMENT ON TABLE "public"."ss_child_achievement" IS '儿童成就进度表';

-- ----------------------------
-- Records of ss_child_achievement
-- ----------------------------

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
-- Records of ss_child_item
-- ----------------------------

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
-- Records of ss_child_score
-- ----------------------------

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
-- Records of ss_device
-- ----------------------------
INSERT INTO "public"."ss_device" VALUES (70001, 'SS0001', 'SS-ESP32-00001', 10001, '0', '{"volume": 60, "language": "zh-CN", "brightness": 80}', 85, '2026-03-14 20:37:11.189151', 'v1.0.2', 200, 1000, '2026-03-14 20:37:11.189151', NULL, NULL, '小明的小步设备');

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
-- Records of ss_device_log
-- ----------------------------

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
-- Records of ss_emotion_record
-- ----------------------------
INSERT INTO "public"."ss_emotion_record" VALUES (60001, 'SS0001', 10001, 4, 'happy', '今天完成了作业，爸爸表扬我了！', '/audio/emotion1.mp3', '做得很棒！继续保持！', '1', '2026-03-12 20:37:10.972691', '2026-03-12 20:37:10.972691');
INSERT INTO "public"."ss_emotion_record" VALUES (60002, 'SS0001', 10001, 2, 'sad', '今天数学题太难了，我做不出来', '/audio/emotion2.mp3', '没关系，我们一起慢慢来，你可以的！', '1', '2026-03-13 20:37:11.047387', '2026-03-13 20:37:11.047387');
INSERT INTO "public"."ss_emotion_record" VALUES (60003, 'SS0001', 10001, 5, 'excited', '我今天用星星换了乐高！', '/audio/emotion3.mp3', '', '0', '2026-03-14 20:37:11.12231', '2026-03-14 20:37:11.12231');

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
-- Records of ss_family_member
-- ----------------------------
INSERT INTO "public"."ss_family_member" VALUES (80001, 'SS0001', 10001, 1000, '爸爸', '{"canEditTask": true, "canViewEmotion": true, "canManageDevice": true}', '2026-03-14 20:37:11.258381');
INSERT INTO "public"."ss_family_member" VALUES (80002, 'SS0001', 10001, 1001, '妈妈', '{"canEditTask": true, "canViewEmotion": true, "canManageDevice": true}', '2026-03-14 20:37:11.331162');
INSERT INTO "public"."ss_family_member" VALUES (80003, 'SS0001', 10002, 1000, '爸爸', '{"canEditTask": true, "canViewEmotion": true, "canManageDevice": true}', '2026-03-14 20:37:11.405916');
INSERT INTO "public"."ss_family_member" VALUES (80004, 'SS0001', 10002, 1001, '妈妈', '{"canEditTask": true, "canViewEmotion": true, "canManageDevice": true}', '2026-03-14 20:37:11.463968');

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
-- Records of ss_game_item
-- ----------------------------

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
-- Records of ss_knowledge_card
-- ----------------------------

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
-- Records of ss_knowledge_user_rel
-- ----------------------------

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
-- Records of ss_level_config
-- ----------------------------

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
-- Records of ss_parent_contract
-- ----------------------------

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
-- Records of ss_parent_reward
-- ----------------------------

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
-- Records of ss_parent_reward_redemption
-- ----------------------------

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
-- Records of ss_parent_task
-- ----------------------------

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
-- Records of ss_reward
-- ----------------------------
INSERT INTO "public"."ss_reward" VALUES (30001, 'SS0001', 10001, '玩30分钟游戏', '🎮', 20, -1, '0', 200, 1000, '2026-03-14 20:37:09.705856', NULL, NULL, '0');
INSERT INTO "public"."ss_reward" VALUES (30002, 'SS0001', 10001, '乐高积木一套', '🧱', 100, 3, '0', 200, 1000, '2026-03-14 20:37:09.788803', NULL, NULL, '0');
INSERT INTO "public"."ss_reward" VALUES (30003, 'SS0001', 10001, '去动物园', '🦁', 150, 1, '0', 200, 1000, '2026-03-14 20:37:09.872179', NULL, NULL, '0');
INSERT INTO "public"."ss_reward" VALUES (30004, 'SS0001', 10002, '看动画片30分钟', '📺', 15, -1, '0', 200, 1000, '2026-03-14 20:37:09.972497', NULL, NULL, '0');
INSERT INTO "public"."ss_reward" VALUES (30005, 'SS0001', 10002, '新的画笔套装', '🎨', 80, 2, '0', 200, 1000, '2026-03-14 20:37:10.055858', NULL, NULL, '0');

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
-- Records of ss_reward_exchange
-- ----------------------------
INSERT INTO "public"."ss_reward_exchange" VALUES (40001, 'SS0001', 30001, 10001, '{"name":"玩30分钟游戏","icon":"🎮"}', 20, '2026-03-11 20:37:10.130774', '1', 1000, '2026-03-11 20:37:10.130774');
INSERT INTO "public"."ss_reward_exchange" VALUES (40002, 'SS0001', 30002, 10001, '{"name":"乐高积木一套","icon":"🧱"}', 100, '2026-03-13 20:37:10.197526', '1', 1000, '2026-03-13 20:37:10.197526');

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
-- Records of ss_score_history
-- ----------------------------

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
-- Records of ss_star_record
-- ----------------------------
INSERT INTO "public"."ss_star_record" VALUES (50001, 'SS0001', 10001, 5, '完成早晨刷牙洗脸', '1', 20101, '2026-03-08 20:37:10.263944');
INSERT INTO "public"."ss_star_record" VALUES (50002, 'SS0001', 10001, 5, '完成早晨刷牙洗脸', '1', 20102, '2026-03-09 20:37:10.330493');
INSERT INTO "public"."ss_star_record" VALUES (50003, 'SS0001', 10001, 5, '完成早晨刷牙洗脸', '1', 20103, '2026-03-10 20:37:10.397357');
INSERT INTO "public"."ss_star_record" VALUES (50004, 'SS0001', 10001, 10, '完成今天的作业', '1', 20104, '2026-03-11 20:37:10.473504');
INSERT INTO "public"."ss_star_record" VALUES (50005, 'SS0001', 10001, -20, '兑换玩游戏奖励', '2', 40001, '2026-03-11 20:37:10.547236');
INSERT INTO "public"."ss_star_record" VALUES (50006, 'SS0001', 10001, 5, '整理书包', '1', 20105, '2026-03-12 20:37:10.688829');
INSERT INTO "public"."ss_star_record" VALUES (50007, 'SS0001', 10001, 5, '完成早晨刷牙洗脸', '1', 20106, '2026-03-13 20:37:10.764239');
INSERT INTO "public"."ss_star_record" VALUES (50008, 'SS0001', 10001, 10, '完成今天的作业', '1', 20107, '2026-03-13 20:37:10.838962');
INSERT INTO "public"."ss_star_record" VALUES (50009, 'SS0001', 10001, -100, '兑换乐高积木', '2', 40002, '2026-03-13 20:37:10.905901');

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
-- Records of ss_task
-- ----------------------------
INSERT INTO "public"."ss_task" VALUES (20001, 'SS0001', 10001, '早晨刷牙洗脸', '🪥', 5, 1, '1', '0 7 * * *', '[{"done": false, "step": "拿起牙刷"}, {"done": false, "step": "挤牙膏"}, {"done": false, "step": "刷牙2分钟"}, {"done": false, "step": "洗脸"}]', '/audio/morning_routine.mp3', '/guide/brush_teeth.png', '0', 200, 1000, '2026-03-14 20:37:08.847255', NULL, NULL, '0');
INSERT INTO "public"."ss_task" VALUES (20002, 'SS0001', 10001, '完成今天的作业', '📚', 10, 3, '1', '0 16 * * 1-5', '[{"done": false, "step": "拿出作业本"}, {"done": false, "step": "写数学作业"}, {"done": false, "step": "写语文作业"}, {"done": false, "step": "检查作业"}]', '/audio/homework_time.mp3', '/guide/homework.png', '0', 200, 1000, '2026-03-14 20:37:08.922135', NULL, NULL, '0');
INSERT INTO "public"."ss_task" VALUES (20003, 'SS0001', 10001, '整理书包', '🎒', 5, 2, '1', '0 20 * * 0-4', '[{"done": false, "step": "拿出所有东西"}, {"done": false, "step": "检查明天课表"}, {"done": false, "step": "放入需要的书本"}, {"done": false, "step": "检查文具"}]', '/audio/pack_bag.mp3', '/guide/pack_bag.png', '0', 200, 1000, '2026-03-14 20:37:08.997053', NULL, NULL, '0');
INSERT INTO "public"."ss_task" VALUES (20004, 'SS0001', 10002, '早晨刷牙洗脸', '🪥', 5, 1, '1', '0 7 * * *', '[{"done": false, "step": "拿起牙刷"}, {"done": false, "step": "挤牙膏"}, {"done": false, "step": "刷牙2分钟"}]', '/audio/morning_routine.mp3', '/guide/brush_teeth.png', '0', 200, 1000, '2026-03-14 20:37:09.072605', NULL, NULL, '0');

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
-- Records of ss_task_log
-- ----------------------------
INSERT INTO "public"."ss_task_log" VALUES (20101, 'SS0001', 20001, 10001, '2026-03-08 20:37:09.146922', '1', '/proof/photo1.jpg', 5, '早晨刷牙洗脸', '2026-03-08 20:37:09.146922', NULL, NULL, 0, NULL, NULL, '0', NULL, NULL, NULL, NULL);
INSERT INTO "public"."ss_task_log" VALUES (20102, 'SS0001', 20001, 10001, '2026-03-09 20:37:09.225646', '1', '/proof/photo2.jpg', 5, '早晨刷牙洗脸', '2026-03-09 20:37:09.225646', NULL, NULL, 0, NULL, NULL, '0', NULL, NULL, NULL, NULL);
INSERT INTO "public"."ss_task_log" VALUES (20103, 'SS0001', 20001, 10001, '2026-03-10 20:37:09.324535', '1', '/proof/photo3.jpg', 5, '早晨刷牙洗脸', '2026-03-10 20:37:09.324535', NULL, NULL, 0, NULL, NULL, '0', NULL, NULL, NULL, NULL);
INSERT INTO "public"."ss_task_log" VALUES (20104, 'SS0001', 20002, 10001, '2026-03-11 20:37:09.396666', '1', '/proof/homework1.jpg', 10, '完成今天的作业', '2026-03-11 20:37:09.396666', NULL, NULL, 0, NULL, NULL, '0', NULL, NULL, NULL, NULL);
INSERT INTO "public"."ss_task_log" VALUES (20105, 'SS0001', 20003, 10001, '2026-03-12 20:37:09.471928', '1', '', 5, '整理书包', '2026-03-12 20:37:09.471928', NULL, NULL, 0, NULL, NULL, '0', NULL, NULL, NULL, NULL);
INSERT INTO "public"."ss_task_log" VALUES (20106, 'SS0001', 20001, 10001, '2026-03-13 20:37:09.546826', '1', '/proof/photo4.jpg', 5, '早晨刷牙洗脸', '2026-03-13 20:37:09.546826', NULL, NULL, 0, NULL, NULL, '0', NULL, NULL, NULL, NULL);
INSERT INTO "public"."ss_task_log" VALUES (20107, 'SS0001', 20002, 10001, '2026-03-13 20:37:09.621837', '1', '/proof/homework2.jpg', 10, '完成今天的作业', '2026-03-13 20:37:09.621837', NULL, NULL, 0, NULL, NULL, '0', NULL, NULL, NULL, NULL);

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
-- Records of ss_task_preset
-- ----------------------------

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
-- Records of sys_ai_route
-- ----------------------------

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
-- Records of sys_client
-- ----------------------------
INSERT INTO "public"."sys_client" VALUES (1, 'e5cd7e4891bf95d1d19206ce24a7b32e', 'pc', 'pc123', 'password,social', 'pc', 1800, 604800, '0', '0', 103, 1, '2026-03-14 20:31:12.778996', 1, '2026-03-14 20:31:12.778996');
INSERT INTO "public"."sys_client" VALUES (2, '428a8310cd442757ae699df5d894f051', 'app', 'app123', 'password,sms,social', 'android', 1800, 604800, '0', '0', 103, 1, '2026-03-14 20:31:12.895782', 1, '2026-03-14 20:31:12.895782');

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
-- Records of sys_config
-- ----------------------------
INSERT INTO "public"."sys_config" VALUES (1, '000000', '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 103, 1, '2026-03-14 20:30:58.49016', NULL, NULL, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO "public"."sys_config" VALUES (2, '000000', '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 103, 1, '2026-03-14 20:30:58.574126', NULL, NULL, '初始化密码 123456');
INSERT INTO "public"."sys_config" VALUES (3, '000000', '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', 103, 1, '2026-03-14 20:30:58.656888', NULL, NULL, '深色主题theme-dark，浅色主题theme-light');
INSERT INTO "public"."sys_config" VALUES (11, '000000', 'OSS预览列表资源开关', 'sys.oss.previewListResource', 'true', 'Y', 103, 1, '2026-03-14 20:30:58.840302', NULL, NULL, 'true:开启, false:关闭');
INSERT INTO "public"."sys_config" VALUES (100, '000000', '每日星星获取上限', 'ss.star.daily_limit', '50', 'Y', NULL, 1, '2026-03-14 20:32:47.701448', NULL, NULL, 'Small Steps 每日获取星星限制');
INSERT INTO "public"."sys_config" VALUES (101, '000000', '每日任务数量上限', 'ss.task.max_count', '20', 'Y', NULL, 1, '2026-03-14 20:32:47.701448', NULL, NULL, 'Small Steps 每日最多创建任务数');
INSERT INTO "public"."sys_config" VALUES (102, '000000', '硬件同步间隔(秒)', 'ss.hw.sync_interval', '300', 'Y', NULL, 1, '2026-03-14 20:32:47.701448', NULL, NULL, 'Small Steps 硬件同步心跳间隔');
INSERT INTO "public"."sys_config" VALUES (5, '000000', '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'true', 'Y', 103, 1, '2026-03-14 20:30:58', 1, '2026-03-14 22:50:39.007', '是否开启注册用户功能（true开启，false关闭）');
INSERT INTO "public"."sys_config" VALUES (2032845555851337729, '000000', '家长角色', 'ss.parent.role', '10', 'Y', 103, 1, '2026-03-14 23:45:23.624', 1, '2026-03-14 23:45:23.624', '家长角色id');

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
-- Records of sys_dept
-- ----------------------------
INSERT INTO "public"."sys_dept" VALUES (200, 'SS0001', 0, '0', 'Small Steps 家庭', NULL, 1, NULL, '13800138001', 'smallsteps@example.com', '0', '0', 103, 1, '2026-03-14 20:37:07.888527', NULL, NULL);

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
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO "public"."sys_dict_data" VALUES (1, '000000', 1, '男', '0', 'sys_user_sex', '', '', 'Y', 103, 1, '2026-03-14 20:30:53.788171', NULL, NULL, '性别男');
INSERT INTO "public"."sys_dict_data" VALUES (2, '000000', 2, '女', '1', 'sys_user_sex', '', '', 'N', 103, 1, '2026-03-14 20:30:53.863245', NULL, NULL, '性别女');
INSERT INTO "public"."sys_dict_data" VALUES (3, '000000', 3, '未知', '2', 'sys_user_sex', '', '', 'N', 103, 1, '2026-03-14 20:30:53.980022', NULL, NULL, '性别未知');
INSERT INTO "public"."sys_dict_data" VALUES (4, '000000', 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', 103, 1, '2026-03-14 20:30:54.097321', NULL, NULL, '显示菜单');
INSERT INTO "public"."sys_dict_data" VALUES (5, '000000', 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', 103, 1, '2026-03-14 20:30:54.171735', NULL, NULL, '隐藏菜单');
INSERT INTO "public"."sys_dict_data" VALUES (6, '000000', 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', 103, 1, '2026-03-14 20:30:54.271734', NULL, NULL, '正常状态');
INSERT INTO "public"."sys_dict_data" VALUES (7, '000000', 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', 103, 1, '2026-03-14 20:30:54.347258', NULL, NULL, '停用状态');
INSERT INTO "public"."sys_dict_data" VALUES (12, '000000', 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', 103, 1, '2026-03-14 20:30:54.446821', NULL, NULL, '系统默认是');
INSERT INTO "public"."sys_dict_data" VALUES (13, '000000', 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', 103, 1, '2026-03-14 20:30:54.521819', NULL, NULL, '系统默认否');
INSERT INTO "public"."sys_dict_data" VALUES (14, '000000', 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', 103, 1, '2026-03-14 20:30:54.596837', NULL, NULL, '通知');
INSERT INTO "public"."sys_dict_data" VALUES (15, '000000', 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', 103, 1, '2026-03-14 20:30:54.671925', NULL, NULL, '公告');
INSERT INTO "public"."sys_dict_data" VALUES (16, '000000', 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', 103, 1, '2026-03-14 20:30:54.788672', NULL, NULL, '正常状态');
INSERT INTO "public"."sys_dict_data" VALUES (17, '000000', 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', 103, 1, '2026-03-14 20:30:54.855356', NULL, NULL, '关闭状态');
INSERT INTO "public"."sys_dict_data" VALUES (29, '000000', 99, '其他', '0', 'sys_oper_type', '', 'info', 'N', 103, 1, '2026-03-14 20:30:54.930688', NULL, NULL, '其他操作');
INSERT INTO "public"."sys_dict_data" VALUES (18, '000000', 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', 103, 1, '2026-03-14 20:30:54.997285', NULL, NULL, '新增操作');
INSERT INTO "public"."sys_dict_data" VALUES (19, '000000', 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', 103, 1, '2026-03-14 20:30:55.063743', NULL, NULL, '修改操作');
INSERT INTO "public"."sys_dict_data" VALUES (20, '000000', 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', 103, 1, '2026-03-14 20:30:55.130668', NULL, NULL, '删除操作');
INSERT INTO "public"."sys_dict_data" VALUES (21, '000000', 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', 103, 1, '2026-03-14 20:30:55.222084', NULL, NULL, '授权操作');
INSERT INTO "public"."sys_dict_data" VALUES (22, '000000', 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', 103, 1, '2026-03-14 20:30:55.380701', NULL, NULL, '导出操作');
INSERT INTO "public"."sys_dict_data" VALUES (23, '000000', 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', 103, 1, '2026-03-14 20:30:55.548343', NULL, NULL, '导入操作');
INSERT INTO "public"."sys_dict_data" VALUES (24, '000000', 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', 103, 1, '2026-03-14 20:30:55.797315', NULL, NULL, '强退操作');
INSERT INTO "public"."sys_dict_data" VALUES (25, '000000', 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', 103, 1, '2026-03-14 20:30:55.947304', NULL, NULL, '生成操作');
INSERT INTO "public"."sys_dict_data" VALUES (26, '000000', 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', 103, 1, '2026-03-14 20:30:56.022377', NULL, NULL, '清空操作');
INSERT INTO "public"."sys_dict_data" VALUES (27, '000000', 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', 103, 1, '2026-03-14 20:30:56.164103', NULL, NULL, '正常状态');
INSERT INTO "public"."sys_dict_data" VALUES (28, '000000', 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', 103, 1, '2026-03-14 20:30:56.239218', NULL, NULL, '停用状态');
INSERT INTO "public"."sys_dict_data" VALUES (30, '000000', 0, '密码认证', 'password', 'sys_grant_type', '', 'default', 'N', 103, 1, '2026-03-14 20:30:56.34753', NULL, NULL, '密码认证');
INSERT INTO "public"."sys_dict_data" VALUES (31, '000000', 0, '短信认证', 'sms', 'sys_grant_type', '', 'default', 'N', 103, 1, '2026-03-14 20:30:56.422583', NULL, NULL, '短信认证');
INSERT INTO "public"."sys_dict_data" VALUES (32, '000000', 0, '邮件认证', 'email', 'sys_grant_type', '', 'default', 'N', 103, 1, '2026-03-14 20:30:56.497521', NULL, NULL, '邮件认证');
INSERT INTO "public"."sys_dict_data" VALUES (33, '000000', 0, '小程序认证', 'xcx', 'sys_grant_type', '', 'default', 'N', 103, 1, '2026-03-14 20:30:56.572619', NULL, NULL, '小程序认证');
INSERT INTO "public"."sys_dict_data" VALUES (34, '000000', 0, '三方登录认证', 'social', 'sys_grant_type', '', 'default', 'N', 103, 1, '2026-03-14 20:30:56.647605', NULL, NULL, '三方登录认证');
INSERT INTO "public"."sys_dict_data" VALUES (35, '000000', 0, 'PC', 'pc', 'sys_device_type', '', 'default', 'N', 103, 1, '2026-03-14 20:30:56.722789', NULL, NULL, 'PC');
INSERT INTO "public"."sys_dict_data" VALUES (36, '000000', 0, '安卓', 'android', 'sys_device_type', '', 'default', 'N', 103, 1, '2026-03-14 20:30:56.797814', NULL, NULL, '安卓');
INSERT INTO "public"."sys_dict_data" VALUES (37, '000000', 0, 'iOS', 'ios', 'sys_device_type', '', 'default', 'N', 103, 1, '2026-03-14 20:30:56.881182', NULL, NULL, 'iOS');
INSERT INTO "public"."sys_dict_data" VALUES (38, '000000', 0, '小程序', 'xcx', 'sys_device_type', '', 'default', 'N', 103, 1, '2026-03-14 20:30:56.956125', NULL, NULL, '小程序');
INSERT INTO "public"."sys_dict_data" VALUES (100, '000000', 1, '日常任务', '1', 'ss_task_type', '', 'primary', 'Y', NULL, 1, '2026-03-14 20:32:47.701448', NULL, NULL, 'Daily Task');
INSERT INTO "public"."sys_dict_data" VALUES (101, '000000', 2, '挑战任务', '2', 'ss_task_type', '', 'warning', 'N', NULL, 1, '2026-03-14 20:32:47.701448', NULL, NULL, 'Challenge Task');
INSERT INTO "public"."sys_dict_data" VALUES (102, '000000', 3, '临时任务', '3', 'ss_task_type', '', 'info', 'N', NULL, 1, '2026-03-14 20:32:47.701448', NULL, NULL, 'Ad-hoc Task');
INSERT INTO "public"."sys_dict_data" VALUES (103, '000000', 1, '生活习惯', 'life', 'ss_task_category', '', 'default', 'Y', NULL, 1, '2026-03-14 20:32:47.701448', NULL, NULL, '');
INSERT INTO "public"."sys_dict_data" VALUES (104, '000000', 2, '学习成长', 'study', 'ss_task_category', '', 'default', 'N', NULL, 1, '2026-03-14 20:32:47.701448', NULL, NULL, '');
INSERT INTO "public"."sys_dict_data" VALUES (105, '000000', 3, '运动健康', 'sport', 'ss_task_category', '', 'default', 'N', NULL, 1, '2026-03-14 20:32:47.701448', NULL, NULL, '');
INSERT INTO "public"."sys_dict_data" VALUES (106, '000000', 4, '社交礼仪', 'social', 'ss_task_category', '', 'default', 'N', NULL, 1, '2026-03-14 20:32:47.701448', NULL, NULL, '');
INSERT INTO "public"."sys_dict_data" VALUES (107, '000000', 1, '简单', '1', 'ss_difficulty', '', 'success', 'Y', NULL, 1, '2026-03-14 20:32:47.701448', NULL, NULL, '');
INSERT INTO "public"."sys_dict_data" VALUES (108, '000000', 2, '普通', '2', 'ss_difficulty', '', 'info', 'N', NULL, 1, '2026-03-14 20:32:47.701448', NULL, NULL, '');
INSERT INTO "public"."sys_dict_data" VALUES (109, '000000', 3, '中等', '3', 'ss_difficulty', '', 'primary', 'N', NULL, 1, '2026-03-14 20:32:47.701448', NULL, NULL, '');
INSERT INTO "public"."sys_dict_data" VALUES (110, '000000', 4, '困难', '4', 'ss_difficulty', '', 'warning', 'N', NULL, 1, '2026-03-14 20:32:47.701448', NULL, NULL, '');
INSERT INTO "public"."sys_dict_data" VALUES (111, '000000', 5, '噩梦', '5', 'ss_difficulty', '', 'danger', 'N', NULL, 1, '2026-03-14 20:32:47.701448', NULL, NULL, '');
INSERT INTO "public"."sys_dict_data" VALUES (112, '000000', 1, '头部', 'head', 'ss_item_category', '', 'default', 'N', NULL, 1, '2026-03-14 20:32:47.701448', NULL, NULL, '');
INSERT INTO "public"."sys_dict_data" VALUES (113, '000000', 2, '身体', 'body', 'ss_item_category', '', 'default', 'N', NULL, 1, '2026-03-14 20:32:47.701448', NULL, NULL, '');
INSERT INTO "public"."sys_dict_data" VALUES (114, '000000', 3, '手持', 'hand', 'ss_item_category', '', 'default', 'N', NULL, 1, '2026-03-14 20:32:47.701448', NULL, NULL, '');
INSERT INTO "public"."sys_dict_data" VALUES (115, '000000', 4, '肤色', 'color', 'ss_item_category', '', 'default', 'N', NULL, 1, '2026-03-14 20:32:47.701448', NULL, NULL, '');
INSERT INTO "public"."sys_dict_data" VALUES (116, '000000', 1, '开心', 'happy', 'ss_mood_type', '', 'success', 'N', NULL, 1, '2026-03-14 20:32:47.701448', NULL, NULL, '');
INSERT INTO "public"."sys_dict_data" VALUES (117, '000000', 2, '难过', 'sad', 'ss_mood_type', '', 'primary', 'N', NULL, 1, '2026-03-14 20:32:47.701448', NULL, NULL, '');
INSERT INTO "public"."sys_dict_data" VALUES (118, '000000', 3, '生气', 'angry', 'ss_mood_type', '', 'danger', 'N', NULL, 1, '2026-03-14 20:32:47.701448', NULL, NULL, '');
INSERT INTO "public"."sys_dict_data" VALUES (119, '000000', 4, '焦虑', 'anxious', 'ss_mood_type', '', 'warning', 'N', NULL, 1, '2026-03-14 20:32:47.701448', NULL, NULL, '');
INSERT INTO "public"."sys_dict_data" VALUES (120, '000000', 5, '平静', 'calm', 'ss_mood_type', '', 'info', 'Y', NULL, 1, '2026-03-14 20:32:47.701448', NULL, NULL, '');
INSERT INTO "public"."sys_dict_data" VALUES (121, '000000', 1, '上架', '0', 'ss_reward_status', '', 'primary', 'Y', NULL, 1, '2026-03-14 20:32:47.701448', NULL, NULL, '');
INSERT INTO "public"."sys_dict_data" VALUES (122, '000000', 2, '下架', '1', 'ss_reward_status', '', 'danger', 'N', NULL, 1, '2026-03-14 20:32:47.701448', NULL, NULL, '');
INSERT INTO "public"."sys_dict_data" VALUES (123, '000000', 1, '待批准', '0', 'ss_exchange_status', '', 'warning', 'Y', NULL, 1, '2026-03-14 20:32:47.701448', NULL, NULL, '');
INSERT INTO "public"."sys_dict_data" VALUES (124, '000000', 2, '已批准', '1', 'ss_exchange_status', '', 'success', 'N', NULL, 1, '2026-03-14 20:32:47.701448', NULL, NULL, '');
INSERT INTO "public"."sys_dict_data" VALUES (125, '000000', 3, '已拒绝', '2', 'ss_exchange_status', '', 'danger', 'N', NULL, 1, '2026-03-14 20:32:47.701448', NULL, NULL, '');

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
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO "public"."sys_dict_type" VALUES (1, '000000', '用户性别', 'sys_user_sex', 103, 1, '2026-03-14 20:30:51.428868', NULL, NULL, '用户性别列表');
INSERT INTO "public"."sys_dict_type" VALUES (2, '000000', '菜单状态', 'sys_show_hide', 103, 1, '2026-03-14 20:30:51.52062', NULL, NULL, '菜单状态列表');
INSERT INTO "public"."sys_dict_type" VALUES (3, '000000', '系统开关', 'sys_normal_disable', 103, 1, '2026-03-14 20:30:51.587309', NULL, NULL, '系统开关列表');
INSERT INTO "public"."sys_dict_type" VALUES (6, '000000', '系统是否', 'sys_yes_no', 103, 1, '2026-03-14 20:30:51.662303', NULL, NULL, '系统是否列表');
INSERT INTO "public"."sys_dict_type" VALUES (7, '000000', '通知类型', 'sys_notice_type', 103, 1, '2026-03-14 20:30:51.737328', NULL, NULL, '通知类型列表');
INSERT INTO "public"."sys_dict_type" VALUES (8, '000000', '通知状态', 'sys_notice_status', 103, 1, '2026-03-14 20:30:51.845803', NULL, NULL, '通知状态列表');
INSERT INTO "public"."sys_dict_type" VALUES (9, '000000', '操作类型', 'sys_oper_type', 103, 1, '2026-03-14 20:30:51.920845', NULL, NULL, '操作类型列表');
INSERT INTO "public"."sys_dict_type" VALUES (10, '000000', '系统状态', 'sys_common_status', 103, 1, '2026-03-14 20:30:51.99588', NULL, NULL, '登录状态列表');
INSERT INTO "public"."sys_dict_type" VALUES (11, '000000', '授权类型', 'sys_grant_type', 103, 1, '2026-03-14 20:30:52.070829', NULL, NULL, '认证授权类型');
INSERT INTO "public"."sys_dict_type" VALUES (12, '000000', '设备类型', 'sys_device_type', 103, 1, '2026-03-14 20:30:52.187543', NULL, NULL, '客户端设备类型');
INSERT INTO "public"."sys_dict_type" VALUES (100, '000000', 'Small Steps 任务类型', 'ss_task_type', NULL, 1, '2026-03-14 20:32:47.701448', NULL, NULL, '任务类型定义');
INSERT INTO "public"."sys_dict_type" VALUES (101, '000000', 'Small Steps 任务分类', 'ss_task_category', NULL, 1, '2026-03-14 20:32:47.701448', NULL, NULL, '任务所属分类');
INSERT INTO "public"."sys_dict_type" VALUES (102, '000000', 'Small Steps 难度等级', 'ss_difficulty', NULL, 1, '2026-03-14 20:32:47.701448', NULL, NULL, '任务难度1-5');
INSERT INTO "public"."sys_dict_type" VALUES (103, '000000', 'Small Steps 物品分类', 'ss_item_category', NULL, 1, '2026-03-14 20:32:47.701448', NULL, NULL, 'Avatar物品部位');
INSERT INTO "public"."sys_dict_type" VALUES (104, '000000', 'Small Steps 情绪标签', 'ss_mood_type', NULL, 1, '2026-03-14 20:32:47.701448', NULL, NULL, '情绪记录标签');
INSERT INTO "public"."sys_dict_type" VALUES (105, '000000', 'Small Steps 商品状态', 'ss_reward_status', NULL, 1, '2026-03-14 20:32:47.701448', NULL, NULL, '奖励上架状态');
INSERT INTO "public"."sys_dict_type" VALUES (106, '000000', 'Small Steps 兑换状态', 'ss_exchange_status', NULL, 1, '2026-03-14 20:32:47.701448', NULL, NULL, '奖励兑换审批状态');

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
-- Records of sys_logininfor
-- ----------------------------
INSERT INTO "public"."sys_logininfor" VALUES (2032817181080129537, '000000', 'admin', 'pc', 'pc', '192.168.1.9', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-03-14 21:52:38.541');
INSERT INTO "public"."sys_logininfor" VALUES (2032817727420243970, '000000', 'admin', '', '', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-03-14 21:54:48.793');
INSERT INTO "public"."sys_logininfor" VALUES (2032826546766487554, '000000', 'admin', '', '', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-03-14 22:29:51.5');
INSERT INTO "public"."sys_logininfor" VALUES (2032827817825148929, '000000', 'admin', '', '', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-03-14 22:34:54.545');
INSERT INTO "public"."sys_logininfor" VALUES (2032829973185699842, '000000', 'admin', '', '', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-03-14 22:43:28.425');
INSERT INTO "public"."sys_logininfor" VALUES (2032830640591740929, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-03-14 22:46:07.55');
INSERT INTO "public"."sys_logininfor" VALUES (2032841651382132738, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-03-14 23:29:52.721');
INSERT INTO "public"."sys_logininfor" VALUES (2032843069186908162, '000000', 'kenzhao', '', '', '192.168.1.9', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '注册成功', '2026-03-14 23:35:30.749');
INSERT INTO "public"."sys_logininfor" VALUES (2032843487803613186, '000000', 'kenzhao', '', '', '192.168.1.9', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-03-14 23:37:10.568');
INSERT INTO "public"."sys_logininfor" VALUES (2032849178870177794, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-03-14 23:59:47.408');
INSERT INTO "public"."sys_logininfor" VALUES (2032854074566664194, '000000', 'kenzhao', '', '', '192.168.1.9', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-03-15 00:19:14.647');
INSERT INTO "public"."sys_logininfor" VALUES (2032854114840371202, '000000', 'kenzhao', 'app', 'android', '192.168.1.9', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-03-15 00:19:24.245');
INSERT INTO "public"."sys_logininfor" VALUES (2032854618223960066, '000000', 'kenzhao', 'app', 'android', '192.168.1.9', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-03-15 00:21:24.264');
INSERT INTO "public"."sys_logininfor" VALUES (2032862638345580545, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-03-15 00:53:16.395');
INSERT INTO "public"."sys_logininfor" VALUES (2035367910351958017, '000000', 'kenzhao', '', '', '192.168.1.9', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-03-21 22:48:19.788');
INSERT INTO "public"."sys_logininfor" VALUES (2035368651036684290, '000000', 'ken2zhao', '', '', '192.168.1.9', '内网IP', 'Safari', 'iPhone', '0', '注册成功', '2026-03-21 22:51:16.384');
INSERT INTO "public"."sys_logininfor" VALUES (2035368703746502658, '000000', 'ken2zhao', '', '', '192.168.1.9', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-03-21 22:51:28.952');
INSERT INTO "public"."sys_logininfor" VALUES (2035373090262872065, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-03-21 23:08:54.779');
INSERT INTO "public"."sys_logininfor" VALUES (2035378795267014658, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-03-21 23:31:34.965');
INSERT INTO "public"."sys_logininfor" VALUES (2035379051983585281, '000000', 'parent_zhang', '', '', '192.168.1.9', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-03-21 23:32:36.172');
INSERT INTO "public"."sys_logininfor" VALUES (2035388776230019073, '000000', 'parent_zhang', '', '', '192.168.1.9', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-03-22 00:11:14.601');
INSERT INTO "public"."sys_logininfor" VALUES (2035389230838046722, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-03-22 00:13:02.992');
INSERT INTO "public"."sys_logininfor" VALUES (2035391831528824834, '000000', 'parent_zhang', '', '', '192.168.1.9', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-03-22 00:23:23.042');
INSERT INTO "public"."sys_logininfor" VALUES (2035392424053956609, '000000', 'ken2zhao', '', '', '192.168.1.9', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '注册成功', '2026-03-22 00:25:44.315');
INSERT INTO "public"."sys_logininfor" VALUES (2035392445432324098, '000000', 'ken2zhao', '', '', '192.168.1.9', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-03-22 00:25:49.411');

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
-- Records of sys_menu
-- ----------------------------
INSERT INTO "public"."sys_menu" VALUES (1, '系统管理', 0, 1, 'system', NULL, '', '1', '0', 'M', '0', '0', '', 'system', 103, 1, '2026-03-14 20:30:25.393647', NULL, NULL, '系统管理目录');
INSERT INTO "public"."sys_menu" VALUES (2, '系统监控', 0, 3, 'monitor', NULL, '', '1', '0', 'M', '0', '0', '', 'monitor', 103, 1, '2026-03-14 20:30:25.543731', NULL, NULL, '系统监控目录');
INSERT INTO "public"."sys_menu" VALUES (100, '用户管理', 1, 1, 'user', 'system/user/index', '', '1', '0', 'C', '0', '0', 'system:user:list', 'user', 103, 1, '2026-03-14 20:30:25.843866', NULL, NULL, '用户管理菜单');
INSERT INTO "public"."sys_menu" VALUES (101, '角色管理', 1, 2, 'role', 'system/role/index', '', '1', '0', 'C', '0', '0', 'system:role:list', 'peoples', 103, 1, '2026-03-14 20:30:25.918828', NULL, NULL, '角色管理菜单');
INSERT INTO "public"."sys_menu" VALUES (102, '菜单管理', 1, 3, 'menu', 'system/menu/index', '', '1', '0', 'C', '0', '0', 'system:menu:list', 'tree-table', 103, 1, '2026-03-14 20:30:26.043947', NULL, NULL, '菜单管理菜单');
INSERT INTO "public"."sys_menu" VALUES (105, '字典管理', 1, 6, 'dict', 'system/dict/index', '', '1', '0', 'C', '0', '0', 'system:dict:list', 'dict', 103, 1, '2026-03-14 20:30:26.252412', NULL, NULL, '字典管理菜单');
INSERT INTO "public"."sys_menu" VALUES (106, '参数设置', 1, 7, 'config', 'system/config/index', '', '1', '0', 'C', '0', '0', 'system:config:list', 'edit', 103, 1, '2026-03-14 20:30:26.319034', NULL, NULL, '参数设置菜单');
INSERT INTO "public"."sys_menu" VALUES (107, '通知公告', 1, 8, 'notice', 'system/notice/index', '', '1', '0', 'C', '0', '0', 'system:notice:list', 'message', 103, 1, '2026-03-14 20:30:26.385797', NULL, NULL, '通知公告菜单');
INSERT INTO "public"."sys_menu" VALUES (108, '日志管理', 1, 9, 'log', '', '', '1', '0', 'M', '0', '0', '', 'log', 103, 1, '2026-03-14 20:30:26.452525', NULL, NULL, '日志管理菜单');
INSERT INTO "public"."sys_menu" VALUES (109, '在线用户', 2, 1, 'online', 'monitor/online/index', '', '1', '0', 'C', '0', '0', 'monitor:online:list', 'online', 103, 1, '2026-03-14 20:30:26.51916', NULL, NULL, '在线用户菜单');
INSERT INTO "public"."sys_menu" VALUES (113, '缓存监控', 2, 5, 'cache', 'monitor/cache/index', '', '1', '0', 'C', '0', '0', 'monitor:cache:list', 'redis', 103, 1, '2026-03-14 20:30:26.585929', NULL, NULL, '缓存监控菜单');
INSERT INTO "public"."sys_menu" VALUES (115, '代码生成', 3, 2, 'gen', 'tool/gen/index', '', '1', '0', 'C', '0', '0', 'tool:gen:list', 'code', 103, 1, '2026-03-14 20:30:26.660832', NULL, NULL, '代码生成菜单');
INSERT INTO "public"."sys_menu" VALUES (121, '租户管理', 6, 1, 'tenant', 'system/tenant/index', '', '1', '0', 'C', '0', '0', 'system:tenant:list', 'list', 103, 1, '2026-03-14 20:30:26.727539', NULL, NULL, '租户管理菜单');
INSERT INTO "public"."sys_menu" VALUES (122, '租户套餐管理', 6, 2, 'tenantPackage', 'system/tenantPackage/index', '', '1', '0', 'C', '0', '0', 'system:tenantPackage:list', 'form', 103, 1, '2026-03-14 20:30:26.79428', NULL, NULL, '租户套餐管理菜单');
INSERT INTO "public"."sys_menu" VALUES (123, '客户端管理', 1, 11, 'client', 'system/client/index', '', '1', '0', 'C', '0', '0', 'system:client:list', 'international', 103, 1, '2026-03-14 20:30:26.869291', NULL, NULL, '客户端管理菜单');
INSERT INTO "public"."sys_menu" VALUES (116, '修改生成配置', 3, 2, 'gen-edit/index/:tableId', 'tool/gen/editTable', '', '1', '1', 'C', '1', '0', 'tool:gen:edit', '#', 103, 1, '2026-03-14 20:30:26.944271', NULL, NULL, '/tool/gen');
INSERT INTO "public"."sys_menu" VALUES (130, '分配用户', 1, 2, 'role-auth/user/:roleId', 'system/role/authUser', '', '1', '1', 'C', '1', '0', 'system:role:edit', '#', 103, 1, '2026-03-14 20:30:27.019429', NULL, NULL, '/system/role');
INSERT INTO "public"."sys_menu" VALUES (131, '分配角色', 1, 1, 'user-auth/role/:userId', 'system/user/authRole', '', '1', '1', 'C', '1', '0', 'system:user:edit', '#', 103, 1, '2026-03-14 20:30:27.086002', NULL, NULL, '/system/user');
INSERT INTO "public"."sys_menu" VALUES (132, '字典数据', 1, 6, 'dict-data/index/:dictId', 'system/dict/data', '', '1', '1', 'C', '1', '0', 'system:dict:list', '#', 103, 1, '2026-03-14 20:30:27.152758', NULL, NULL, '/system/dict');
INSERT INTO "public"."sys_menu" VALUES (133, '文件配置管理', 1, 10, 'oss-config/index', 'system/oss/config', '', '1', '1', 'C', '1', '0', 'system:ossConfig:list', '#', 103, 1, '2026-03-14 20:30:27.227806', NULL, NULL, '/system/oss');
INSERT INTO "public"."sys_menu" VALUES (117, 'Admin监控', 2, 5, 'Admin', 'monitor/admin/index', '', '1', '0', 'C', '0', '0', 'monitor:admin:list', 'dashboard', 103, 1, '2026-03-14 20:30:27.327888', NULL, NULL, 'Admin监控菜单');
INSERT INTO "public"."sys_menu" VALUES (118, '文件管理', 1, 10, 'oss', 'system/oss/index', '', '1', '0', 'C', '0', '0', 'system:oss:list', 'upload', 103, 1, '2026-03-14 20:30:27.402915', NULL, NULL, '文件管理菜单');
INSERT INTO "public"."sys_menu" VALUES (120, '任务调度中心', 2, 6, 'snailjob', 'monitor/snailjob/index', '', '1', '0', 'C', '0', '0', 'monitor:snailjob:list', 'job', 103, 1, '2026-03-14 20:30:27.527905', NULL, NULL, 'SnailJob控制台菜单');
INSERT INTO "public"."sys_menu" VALUES (500, '操作日志', 108, 1, 'operlog', 'monitor/operlog/index', '', '1', '0', 'C', '0', '0', 'monitor:operlog:list', 'form', 103, 1, '2026-03-14 20:30:27.602866', NULL, NULL, '操作日志菜单');
INSERT INTO "public"."sys_menu" VALUES (501, '登录日志', 108, 2, 'logininfor', 'monitor/logininfor/index', '', '1', '0', 'C', '0', '0', 'monitor:logininfor:list', 'logininfor', 103, 1, '2026-03-14 20:30:27.677949', NULL, NULL, '登录日志菜单');
INSERT INTO "public"."sys_menu" VALUES (1001, '用户查询', 100, 1, '', '', '', '1', '0', 'F', '0', '0', 'system:user:query', '#', 103, 1, '2026-03-14 20:30:27.752968', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1002, '用户新增', 100, 2, '', '', '', '1', '0', 'F', '0', '0', 'system:user:add', '#', 103, 1, '2026-03-14 20:30:27.82806', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1003, '用户修改', 100, 3, '', '', '', '1', '0', 'F', '0', '0', 'system:user:edit', '#', 103, 1, '2026-03-14 20:30:27.903095', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1004, '用户删除', 100, 4, '', '', '', '1', '0', 'F', '0', '0', 'system:user:remove', '#', 103, 1, '2026-03-14 20:30:27.979112', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1005, '用户导出', 100, 5, '', '', '', '1', '0', 'F', '0', '0', 'system:user:export', '#', 103, 1, '2026-03-14 20:30:28.061381', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1006, '用户导入', 100, 6, '', '', '', '1', '0', 'F', '0', '0', 'system:user:import', '#', 103, 1, '2026-03-14 20:30:28.236467', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1007, '重置密码', 100, 7, '', '', '', '1', '0', 'F', '0', '0', 'system:user:resetPwd', '#', 103, 1, '2026-03-14 20:30:28.349332', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1008, '角色查询', 101, 1, '', '', '', '1', '0', 'F', '0', '0', 'system:role:query', '#', 103, 1, '2026-03-14 20:30:28.411617', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1009, '角色新增', 101, 2, '', '', '', '1', '0', 'F', '0', '0', 'system:role:add', '#', 103, 1, '2026-03-14 20:30:28.578437', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1010, '角色修改', 101, 3, '', '', '', '1', '0', 'F', '0', '0', 'system:role:edit', '#', 103, 1, '2026-03-14 20:30:28.64501', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1011, '角色删除', 101, 4, '', '', '', '1', '0', 'F', '0', '0', 'system:role:remove', '#', 103, 1, '2026-03-14 20:30:28.736798', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1012, '角色导出', 101, 5, '', '', '', '1', '0', 'F', '0', '0', 'system:role:export', '#', 103, 1, '2026-03-14 20:30:28.811761', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1013, '菜单查询', 102, 1, '', '', '', '1', '0', 'F', '0', '0', 'system:menu:query', '#', 103, 1, '2026-03-14 20:30:28.936753', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1014, '菜单新增', 102, 2, '', '', '', '1', '0', 'F', '0', '0', 'system:menu:add', '#', 103, 1, '2026-03-14 20:30:29.011712', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1015, '菜单修改', 102, 3, '', '', '', '1', '0', 'F', '0', '0', 'system:menu:edit', '#', 103, 1, '2026-03-14 20:30:29.103437', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1016, '菜单删除', 102, 4, '', '', '', '1', '0', 'F', '0', '0', 'system:menu:remove', '#', 103, 1, '2026-03-14 20:30:29.178548', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1017, '部门查询', 103, 1, '', '', '', '1', '0', 'F', '0', '0', 'system:dept:query', '#', 103, 1, '2026-03-14 20:30:29.253472', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1018, '部门新增', 103, 2, '', '', '', '1', '0', 'F', '0', '0', 'system:dept:add', '#', 103, 1, '2026-03-14 20:30:29.328477', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (5, '测试菜单', 0, 5, 'demo', NULL, '', '1', '0', 'M', '1', '1', NULL, 'star', 103, 1, '2026-03-14 20:30:25', 1, '2026-03-15 01:11:11.074', '测试菜单');
INSERT INTO "public"."sys_menu" VALUES (3, '系统工具', 0, 4, 'tool', NULL, '', '1', '0', 'M', '1', '1', '', 'tool', 103, 1, '2026-03-14 20:30:25', 1, '2026-03-15 01:11:33.121', '系统工具目录');
INSERT INTO "public"."sys_menu" VALUES (103, '部门管理', 1, 4, 'dept', 'system/dept/index', '', '1', '0', 'C', '1', '1', 'system:dept:list', 'tree', 103, 1, '2026-03-14 20:30:26', 1, '2026-03-15 01:12:14.832', '部门管理菜单');
INSERT INTO "public"."sys_menu" VALUES (104, '岗位管理', 1, 5, 'post', 'system/post/index', '', '1', '0', 'C', '1', '1', 'system:post:list', 'post', 103, 1, '2026-03-14 20:30:26', 1, '2026-03-15 01:12:23.1', '岗位管理菜单');
INSERT INTO "public"."sys_menu" VALUES (1019, '部门修改', 103, 3, '', '', '', '1', '0', 'F', '0', '0', 'system:dept:edit', '#', 103, 1, '2026-03-14 20:30:29.403626', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1020, '部门删除', 103, 4, '', '', '', '1', '0', 'F', '0', '0', 'system:dept:remove', '#', 103, 1, '2026-03-14 20:30:29.478892', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1021, '岗位查询', 104, 1, '', '', '', '1', '0', 'F', '0', '0', 'system:post:query', '#', 103, 1, '2026-03-14 20:30:29.553695', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1022, '岗位新增', 104, 2, '', '', '', '1', '0', 'F', '0', '0', 'system:post:add', '#', 103, 1, '2026-03-14 20:30:29.628637', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1023, '岗位修改', 104, 3, '', '', '', '1', '0', 'F', '0', '0', 'system:post:edit', '#', 103, 1, '2026-03-14 20:30:29.703678', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1024, '岗位删除', 104, 4, '', '', '', '1', '0', 'F', '0', '0', 'system:post:remove', '#', 103, 1, '2026-03-14 20:30:29.778793', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1025, '岗位导出', 104, 5, '', '', '', '1', '0', 'F', '0', '0', 'system:post:export', '#', 103, 1, '2026-03-14 20:30:29.853716', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1026, '字典查询', 105, 1, '#', '', '', '1', '0', 'F', '0', '0', 'system:dict:query', '#', 103, 1, '2026-03-14 20:30:29.928795', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1027, '字典新增', 105, 2, '#', '', '', '1', '0', 'F', '0', '0', 'system:dict:add', '#', 103, 1, '2026-03-14 20:30:30.003877', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1028, '字典修改', 105, 3, '#', '', '', '1', '0', 'F', '0', '0', 'system:dict:edit', '#', 103, 1, '2026-03-14 20:30:30.078954', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1029, '字典删除', 105, 4, '#', '', '', '1', '0', 'F', '0', '0', 'system:dict:remove', '#', 103, 1, '2026-03-14 20:30:30.153838', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1030, '字典导出', 105, 5, '#', '', '', '1', '0', 'F', '0', '0', 'system:dict:export', '#', 103, 1, '2026-03-14 20:30:30.228888', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1031, '参数查询', 106, 1, '#', '', '', '1', '0', 'F', '0', '0', 'system:config:query', '#', 103, 1, '2026-03-14 20:30:30.312294', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1032, '参数新增', 106, 2, '#', '', '', '1', '0', 'F', '0', '0', 'system:config:add', '#', 103, 1, '2026-03-14 20:30:30.395651', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1033, '参数修改', 106, 3, '#', '', '', '1', '0', 'F', '0', '0', 'system:config:edit', '#', 103, 1, '2026-03-14 20:30:30.488964', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1034, '参数删除', 106, 4, '#', '', '', '1', '0', 'F', '0', '0', 'system:config:remove', '#', 103, 1, '2026-03-14 20:30:30.57086', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1035, '参数导出', 106, 5, '#', '', '', '1', '0', 'F', '0', '0', 'system:config:export', '#', 103, 1, '2026-03-14 20:30:30.654086', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1036, '公告查询', 107, 1, '#', '', '', '1', '0', 'F', '0', '0', 'system:notice:query', '#', 103, 1, '2026-03-14 20:30:30.720767', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1037, '公告新增', 107, 2, '#', '', '', '1', '0', 'F', '0', '0', 'system:notice:add', '#', 103, 1, '2026-03-14 20:30:30.787473', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1038, '公告修改', 107, 3, '#', '', '', '1', '0', 'F', '0', '0', 'system:notice:edit', '#', 103, 1, '2026-03-14 20:30:30.862614', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1039, '公告删除', 107, 4, '#', '', '', '1', '0', 'F', '0', '0', 'system:notice:remove', '#', 103, 1, '2026-03-14 20:30:30.969476', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1040, '操作查询', 500, 1, '#', '', '', '1', '0', 'F', '0', '0', 'monitor:operlog:query', '#', 103, 1, '2026-03-14 20:30:31.037533', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1041, '操作删除', 500, 2, '#', '', '', '1', '0', 'F', '0', '0', 'monitor:operlog:remove', '#', 103, 1, '2026-03-14 20:30:31.129212', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1042, '日志导出', 500, 4, '#', '', '', '1', '0', 'F', '0', '0', 'monitor:operlog:export', '#', 103, 1, '2026-03-14 20:30:31.195976', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1043, '登录查询', 501, 1, '#', '', '', '1', '0', 'F', '0', '0', 'monitor:logininfor:query', '#', 103, 1, '2026-03-14 20:30:31.262819', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1044, '登录删除', 501, 2, '#', '', '', '1', '0', 'F', '0', '0', 'monitor:logininfor:remove', '#', 103, 1, '2026-03-14 20:30:31.337613', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1045, '日志导出', 501, 3, '#', '', '', '1', '0', 'F', '0', '0', 'monitor:logininfor:export', '#', 103, 1, '2026-03-14 20:30:31.404374', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1050, '账户解锁', 501, 4, '#', '', '', '1', '0', 'F', '0', '0', 'monitor:logininfor:unlock', '#', 103, 1, '2026-03-14 20:30:31.47119', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1046, '在线查询', 109, 1, '#', '', '', '1', '0', 'F', '0', '0', 'monitor:online:query', '#', 103, 1, '2026-03-14 20:30:31.546219', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1047, '批量强退', 109, 2, '#', '', '', '1', '0', 'F', '0', '0', 'monitor:online:batchLogout', '#', 103, 1, '2026-03-14 20:30:31.612793', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1048, '单条强退', 109, 3, '#', '', '', '1', '0', 'F', '0', '0', 'monitor:online:forceLogout', '#', 103, 1, '2026-03-14 20:30:31.679717', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1055, '生成查询', 115, 1, '#', '', '', '1', '0', 'F', '0', '0', 'tool:gen:query', '#', 103, 1, '2026-03-14 20:30:31.746153', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1056, '生成修改', 115, 2, '#', '', '', '1', '0', 'F', '0', '0', 'tool:gen:edit', '#', 103, 1, '2026-03-14 20:30:31.812845', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1057, '生成删除', 115, 3, '#', '', '', '1', '0', 'F', '0', '0', 'tool:gen:remove', '#', 103, 1, '2026-03-14 20:30:31.879646', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1058, '导入代码', 115, 2, '#', '', '', '1', '0', 'F', '0', '0', 'tool:gen:import', '#', 103, 1, '2026-03-14 20:30:31.946272', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1059, '预览代码', 115, 4, '#', '', '', '1', '0', 'F', '0', '0', 'tool:gen:preview', '#', 103, 1, '2026-03-14 20:30:32.012887', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1060, '生成代码', 115, 5, '#', '', '', '1', '0', 'F', '0', '0', 'tool:gen:code', '#', 103, 1, '2026-03-14 20:30:32.079612', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1600, '文件查询', 118, 1, '#', '', '', '1', '0', 'F', '0', '0', 'system:oss:query', '#', 103, 1, '2026-03-14 20:30:32.146291', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1601, '文件上传', 118, 2, '#', '', '', '1', '0', 'F', '0', '0', 'system:oss:upload', '#', 103, 1, '2026-03-14 20:30:32.213009', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1602, '文件下载', 118, 3, '#', '', '', '1', '0', 'F', '0', '0', 'system:oss:download', '#', 103, 1, '2026-03-14 20:30:32.288129', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1603, '文件删除', 118, 4, '#', '', '', '1', '0', 'F', '0', '0', 'system:oss:remove', '#', 103, 1, '2026-03-14 20:30:32.363082', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1620, '配置列表', 118, 5, '#', '', '', '1', '0', 'F', '0', '0', 'system:ossConfig:list', '#', 103, 1, '2026-03-14 20:30:32.488157', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1621, '配置添加', 118, 6, '#', '', '', '1', '0', 'F', '0', '0', 'system:ossConfig:add', '#', 103, 1, '2026-03-14 20:30:32.576754', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1622, '配置编辑', 118, 6, '#', '', '', '1', '0', 'F', '0', '0', 'system:ossConfig:edit', '#', 103, 1, '2026-03-14 20:30:32.679903', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1623, '配置删除', 118, 6, '#', '', '', '1', '0', 'F', '0', '0', 'system:ossConfig:remove', '#', 103, 1, '2026-03-14 20:30:32.813919', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1606, '租户查询', 121, 1, '#', '', '', '1', '0', 'F', '0', '0', 'system:tenant:query', '#', 103, 1, '2026-03-14 20:30:32.881511', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1607, '租户新增', 121, 2, '#', '', '', '1', '0', 'F', '0', '0', 'system:tenant:add', '#', 103, 1, '2026-03-14 20:30:32.988294', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1608, '租户修改', 121, 3, '#', '', '', '1', '0', 'F', '0', '0', 'system:tenant:edit', '#', 103, 1, '2026-03-14 20:30:33.105099', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1609, '租户删除', 121, 4, '#', '', '', '1', '0', 'F', '0', '0', 'system:tenant:remove', '#', 103, 1, '2026-03-14 20:30:33.171777', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1610, '租户导出', 121, 5, '#', '', '', '1', '0', 'F', '0', '0', 'system:tenant:export', '#', 103, 1, '2026-03-14 20:30:33.288477', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1611, '租户套餐查询', 122, 1, '#', '', '', '1', '0', 'F', '0', '0', 'system:tenantPackage:query', '#', 103, 1, '2026-03-14 20:30:33.381074', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1612, '租户套餐新增', 122, 2, '#', '', '', '1', '0', 'F', '0', '0', 'system:tenantPackage:add', '#', 103, 1, '2026-03-14 20:30:33.446853', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1613, '租户套餐修改', 122, 3, '#', '', '', '1', '0', 'F', '0', '0', 'system:tenantPackage:edit', '#', 103, 1, '2026-03-14 20:30:33.538673', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1614, '租户套餐删除', 122, 4, '#', '', '', '1', '0', 'F', '0', '0', 'system:tenantPackage:remove', '#', 103, 1, '2026-03-14 20:30:33.605739', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1615, '租户套餐导出', 122, 5, '#', '', '', '1', '0', 'F', '0', '0', 'system:tenantPackage:export', '#', 103, 1, '2026-03-14 20:30:33.70561', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1061, '客户端管理查询', 123, 1, '#', '', '', '1', '0', 'F', '0', '0', 'system:client:query', '#', 103, 1, '2026-03-14 20:30:33.772228', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1062, '客户端管理新增', 123, 2, '#', '', '', '1', '0', 'F', '0', '0', 'system:client:add', '#', 103, 1, '2026-03-14 20:30:33.864097', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1063, '客户端管理修改', 123, 3, '#', '', '', '1', '0', 'F', '0', '0', 'system:client:edit', '#', 103, 1, '2026-03-14 20:30:33.930638', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1064, '客户端管理删除', 123, 4, '#', '', '', '1', '0', 'F', '0', '0', 'system:client:remove', '#', 103, 1, '2026-03-14 20:30:34.022405', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1065, '客户端管理导出', 123, 5, '#', '', '', '1', '0', 'F', '0', '0', 'system:client:export', '#', 103, 1, '2026-03-14 20:30:34.15568', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1500, '测试单表', 5, 1, 'demo', 'demo/demo/index', '', '1', '0', 'C', '0', '0', 'demo:demo:list', '#', 103, 1, '2026-03-14 20:30:34.231132', NULL, NULL, '测试单表菜单');
INSERT INTO "public"."sys_menu" VALUES (1501, '测试单表查询', 1500, 1, '#', '', '', '1', '0', 'F', '0', '0', 'demo:demo:query', '#', 103, 1, '2026-03-14 20:30:34.330573', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1502, '测试单表新增', 1500, 2, '#', '', '', '1', '0', 'F', '0', '0', 'demo:demo:add', '#', 103, 1, '2026-03-14 20:30:34.405572', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1503, '测试单表修改', 1500, 3, '#', '', '', '1', '0', 'F', '0', '0', 'demo:demo:edit', '#', 103, 1, '2026-03-14 20:30:34.529158', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1504, '测试单表删除', 1500, 4, '#', '', '', '1', '0', 'F', '0', '0', 'demo:demo:remove', '#', 103, 1, '2026-03-14 20:30:34.631452', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1505, '测试单表导出', 1500, 5, '#', '', '', '1', '0', 'F', '0', '0', 'demo:demo:export', '#', 103, 1, '2026-03-14 20:30:34.705924', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1506, '测试树表', 5, 1, 'tree', 'demo/tree/index', '', '1', '0', 'C', '0', '0', 'demo:tree:list', '#', 103, 1, '2026-03-14 20:30:34.822485', NULL, NULL, '测试树表菜单');
INSERT INTO "public"."sys_menu" VALUES (1507, '测试树表查询', 1506, 1, '#', '', '', '1', '0', 'F', '0', '0', 'demo:tree:query', '#', 103, 1, '2026-03-14 20:30:34.897676', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1508, '测试树表新增', 1506, 2, '#', '', '', '1', '0', 'F', '0', '0', 'demo:tree:add', '#', 103, 1, '2026-03-14 20:30:34.997673', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1509, '测试树表修改', 1506, 3, '#', '', '', '1', '0', 'F', '0', '0', 'demo:tree:edit', '#', 103, 1, '2026-03-14 20:30:35.072487', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1510, '测试树表删除', 1506, 4, '#', '', '', '1', '0', 'F', '0', '0', 'demo:tree:remove', '#', 103, 1, '2026-03-14 20:30:35.173472', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (1511, '测试树表导出', 1506, 5, '#', '', '', '1', '0', 'F', '0', '0', 'demo:tree:export', '#', 103, 1, '2026-03-14 20:30:35.239213', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (2000, 'Small Steps', 0, 10, 'smallsteps', NULL, '', '1', '0', 'M', '0', '0', '', 'star', 103, 1, '2026-03-14 20:34:33.877156', NULL, NULL, 'Small Steps 管理目录');
INSERT INTO "public"."sys_menu" VALUES (2100, '儿童管理', 2000, 1, 'child', 'smallsteps/child/index', '', '1', '0', 'C', '0', '0', 'parent:child:list', 'user', 103, 1, '2026-03-14 20:34:33.952264', NULL, NULL, '儿童档案管理菜单');
INSERT INTO "public"."sys_menu" VALUES (2200, '任务管理', 2000, 2, 'task', 'smallsteps/task/index', '', '1', '0', 'C', '0', '0', 'parent:task:list', 'list', 103, 1, '2026-03-14 20:34:34.027119', NULL, NULL, '任务配置管理菜单');
INSERT INTO "public"."sys_menu" VALUES (2300, '奖励管理', 2000, 3, 'reward', 'smallsteps/reward/index', '', '1', '0', 'C', '0', '0', 'parent:reward:list', 'gift', 103, 1, '2026-03-14 20:34:34.102296', NULL, NULL, '奖励配置管理菜单');
INSERT INTO "public"."sys_menu" VALUES (2400, '情绪记录', 2000, 4, 'emotion', 'smallsteps/emotion/index', '', '1', '0', 'C', '0', '0', 'parent:emotion:list', 'smile', 103, 1, '2026-03-14 20:34:34.177769', NULL, NULL, '情绪记录查看菜单');
INSERT INTO "public"."sys_menu" VALUES (2500, '设备管理', 2000, 5, 'device', 'smallsteps/device/index', '', '1', '0', 'C', '0', '0', 'parent:device:list', 'phone', 103, 1, '2026-03-14 20:34:34.252525', NULL, NULL, '硬件设备管理菜单');
INSERT INTO "public"."sys_menu" VALUES (2600, '知识学堂', 2000, 6, 'knowledge', 'smallsteps/knowledge/index', '', '1', '0', 'C', '0', '0', 'parent:knowledge:list', 'education', 103, 1, '2026-03-14 20:34:34.327296', NULL, NULL, '父母学堂知识库菜单');
INSERT INTO "public"."sys_menu" VALUES (2700, '亲子契约', 2000, 7, 'contract', 'smallsteps/contract/index', '', '1', '0', 'C', '0', '0', 'parent:contract:list', 'documentation', 103, 1, '2026-03-14 20:34:34.402372', NULL, NULL, '亲子契约管理菜单');
INSERT INTO "public"."sys_menu" VALUES (2101, '儿童查询', 2100, 1, '#', '', '', '1', '0', 'F', '0', '0', 'parent:child:query', '#', 103, 1, '2026-03-14 20:34:34.477401', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (2102, '儿童新增', 2100, 2, '#', '', '', '1', '0', 'F', '0', '0', 'parent:child:add', '#', 103, 1, '2026-03-14 20:34:34.560605', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (2103, '儿童修改', 2100, 3, '#', '', '', '1', '0', 'F', '0', '0', 'parent:child:edit', '#', 103, 1, '2026-03-14 20:34:34.635732', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (2104, '儿童删除', 2100, 4, '#', '', '', '1', '0', 'F', '0', '0', 'parent:child:remove', '#', 103, 1, '2026-03-14 20:34:34.702162', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (2105, '儿童导出', 2100, 5, '#', '', '', '1', '0', 'F', '0', '0', 'parent:child:export', '#', 103, 1, '2026-03-14 20:34:34.777032', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (2201, '任务查询', 2200, 1, '#', '', '', '1', '0', 'F', '0', '0', 'parent:task:query', '#', 103, 1, '2026-03-14 20:34:34.852366', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (2202, '任务新增', 2200, 2, '#', '', '', '1', '0', 'F', '0', '0', 'parent:task:add', '#', 103, 1, '2026-03-14 20:34:34.979281', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (2203, '任务修改', 2200, 3, '#', '', '', '1', '0', 'F', '0', '0', 'parent:task:edit', '#', 103, 1, '2026-03-14 20:34:35.05268', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (2204, '任务删除', 2200, 4, '#', '', '', '1', '0', 'F', '0', '0', 'parent:task:remove', '#', 103, 1, '2026-03-14 20:34:35.127575', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (2205, '任务导出', 2200, 5, '#', '', '', '1', '0', 'F', '0', '0', 'parent:task:export', '#', 103, 1, '2026-03-14 20:34:35.202405', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (2301, '奖励查询', 2300, 1, '#', '', '', '1', '0', 'F', '0', '0', 'parent:reward:query', '#', 103, 1, '2026-03-14 20:34:35.278128', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (2302, '奖励新增', 2300, 2, '#', '', '', '1', '0', 'F', '0', '0', 'parent:reward:add', '#', 103, 1, '2026-03-14 20:34:35.352583', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (2303, '奖励修改', 2300, 3, '#', '', '', '1', '0', 'F', '0', '0', 'parent:reward:edit', '#', 103, 1, '2026-03-14 20:34:35.427814', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (2304, '奖励删除', 2300, 4, '#', '', '', '1', '0', 'F', '0', '0', 'parent:reward:remove', '#', 103, 1, '2026-03-14 20:34:35.502705', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (2305, '奖励导出', 2300, 5, '#', '', '', '1', '0', 'F', '0', '0', 'parent:reward:export', '#', 103, 1, '2026-03-14 20:34:35.569143', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (2401, '情绪查询', 2400, 1, '#', '', '', '1', '0', 'F', '0', '0', 'parent:emotion:query', '#', 103, 1, '2026-03-14 20:34:35.644559', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (2402, '情绪反馈', 2400, 2, '#', '', '', '1', '0', 'F', '0', '0', 'parent:emotion:feedback', '#', 103, 1, '2026-03-14 20:34:35.719176', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (2403, '情绪导出', 2400, 3, '#', '', '', '1', '0', 'F', '0', '0', 'parent:emotion:export', '#', 103, 1, '2026-03-14 20:34:35.794675', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (2501, '设备查询', 2500, 1, '#', '', '', '1', '0', 'F', '0', '0', 'parent:device:query', '#', 103, 1, '2026-03-14 20:34:35.8694', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (2502, '设备绑定', 2500, 2, '#', '', '', '1', '0', 'F', '0', '0', 'parent:device:bind', '#', 103, 1, '2026-03-14 20:34:35.944339', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (2503, '设备解绑', 2500, 3, '#', '', '', '1', '0', 'F', '0', '0', 'parent:device:unbind', '#', 103, 1, '2026-03-14 20:34:36.019128', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (2504, '设备配置', 2500, 4, '#', '', '', '1', '0', 'F', '0', '0', 'parent:device:config', '#', 103, 1, '2026-03-14 20:34:36.094795', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (2601, '知识查询', 2600, 1, '#', '', '', '1', '0', 'F', '0', '0', 'parent:knowledge:query', '#', 103, 1, '2026-03-14 20:34:36.169984', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (2602, '知识收藏', 2600, 2, '#', '', '', '1', '0', 'F', '0', '0', 'parent:knowledge:favorite', '#', 103, 1, '2026-03-14 20:34:36.236148', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (2701, '契约查询', 2700, 1, '#', '', '', '1', '0', 'F', '0', '0', 'parent:contract:query', '#', 103, 1, '2026-03-14 20:34:36.303133', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (2702, '契约新增', 2700, 2, '#', '', '', '1', '0', 'F', '0', '0', 'parent:contract:add', '#', 103, 1, '2026-03-14 20:34:36.370106', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (2703, '契约修改', 2700, 3, '#', '', '', '1', '0', 'F', '0', '0', 'parent:contract:edit', '#', 103, 1, '2026-03-14 20:34:36.436636', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (2704, '契约删除', 2700, 4, '#', '', '', '1', '0', 'F', '0', '0', 'parent:contract:remove', '#', 103, 1, '2026-03-14 20:34:36.502961', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (3000, '我的小步', 0, 20, 'mysteps', NULL, '', '1', '0', 'M', '0', '0', '', 'star', 103, 1, '2026-03-14 20:34:36.569986', NULL, NULL, '儿童端主菜单');
INSERT INTO "public"."sys_menu" VALUES (3100, '我的任务', 3000, 1, 'mytask', 'child/task/index', '', '1', '0', 'C', '0', '0', 'child:task:list', 'list', 103, 1, '2026-03-14 20:34:36.636494', NULL, NULL, '儿童任务查看菜单');
INSERT INTO "public"."sys_menu" VALUES (3200, '我的奖励', 3000, 2, 'myreward', 'child/reward/index', '', '1', '0', 'C', '0', '0', 'child:reward:list', 'gift', 103, 1, '2026-03-14 20:34:36.703252', NULL, NULL, '儿童奖励查看菜单');
INSERT INTO "public"."sys_menu" VALUES (3300, '我的成就', 3000, 3, 'achievement', 'child/achievement/index', '', '1', '0', 'C', '0', '0', 'child:achievement:list', 'trophy', 103, 1, '2026-03-14 20:34:36.771255', NULL, NULL, '儿童成就查看菜单');
INSERT INTO "public"."sys_menu" VALUES (3400, '我的心情', 3000, 4, 'myemotion', 'child/emotion/index', '', '1', '0', 'C', '0', '0', 'child:emotion:list', 'smile', 103, 1, '2026-03-14 20:34:36.836581', NULL, NULL, '儿童情绪记录菜单');
INSERT INTO "public"."sys_menu" VALUES (3101, '任务查询', 3100, 1, '#', '', '', '1', '0', 'F', '0', '0', 'child:task:query', '#', 103, 1, '2026-03-14 20:34:36.903561', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (3102, '任务完成', 3100, 2, '#', '', '', '1', '0', 'F', '0', '0', 'child:task:finish', '#', 103, 1, '2026-03-14 20:34:37.044862', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (3103, '上传证明', 3100, 3, '#', '', '', '1', '0', 'F', '0', '0', 'child:task:proof', '#', 103, 1, '2026-03-14 20:34:37.119858', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (3201, '奖励查询', 3200, 1, '#', '', '', '1', '0', 'F', '0', '0', 'child:reward:query', '#', 103, 1, '2026-03-14 20:34:37.194959', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (3202, '奖励兑换', 3200, 2, '#', '', '', '1', '0', 'F', '0', '0', 'child:reward:exchange', '#', 103, 1, '2026-03-14 20:34:37.269897', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (3301, '成就查询', 3300, 1, '#', '', '', '1', '0', 'F', '0', '0', 'child:achievement:query', '#', 103, 1, '2026-03-14 20:34:37.344921', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (3401, '心情查询', 3400, 1, '#', '', '', '1', '0', 'F', '0', '0', 'child:emotion:query', '#', 103, 1, '2026-03-14 20:34:37.420033', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (3402, '心情记录', 3400, 2, '#', '', '', '1', '0', 'F', '0', '0', 'child:emotion:add', '#', 103, 1, '2026-03-14 20:34:37.495259', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (6, '租户管理', 0, 2, 'tenant', NULL, '', '1', '0', 'M', '1', '1', '', 'chart', 103, 1, '2026-03-14 20:30:25', 1, '2026-03-15 01:10:49.925', '租户管理目录');

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
-- Records of sys_notice
-- ----------------------------
INSERT INTO "public"."sys_notice" VALUES (1, '000000', '温馨提醒：2018-07-01 新版本发布啦', '2', '新版本内容', '0', 103, 1, '2026-03-14 20:31:02.183183', NULL, NULL, '管理员');
INSERT INTO "public"."sys_notice" VALUES (2, '000000', '维护通知：2018-07-01 系统凌晨维护', '1', '维护内容', '0', 103, 1, '2026-03-14 20:31:02.249938', NULL, NULL, '管理员');

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
-- Records of sys_oper_log
-- ----------------------------
INSERT INTO "public"."sys_oper_log" VALUES (2032831779534020610, '000000', '参数管理', 2, 'com.kenzhao.smallsteps.system.controller.system.SysConfigController.edit()', 'PUT', 1, 'admin', '研发部门', '/ssapi/system/config', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":"2026-03-14 20:30:58","updateBy":null,"updateTime":null,"configId":5,"configName":"账号自助-是否开启用户注册功能","configKey":"sys.account.registerUser","configValue":"true","configType":"Y","remark":"是否开启注册用户功能（true开启，false关闭）"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-03-14 22:50:39.091', 102);
INSERT INTO "public"."sys_oper_log" VALUES (2032841700291911682, '000000', '租户管理', 2, 'com.kenzhao.smallsteps.system.controller.system.SysTenantController.changeStatus()', 'PUT', 1, 'admin', '研发部门', '/ssapi/system/tenant/changeStatus', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"id":1,"tenantId":"000000","contactUserName":null,"contactPhone":null,"companyName":null,"username":null,"licenseNumber":null,"address":null,"domain":null,"intro":null,"remark":null,"packageId":null,"expireTime":null,"accountCount":null,"status":"1"}', '', 1, '不允许操作管理租户', '2026-03-14 23:30:04.381', 2);
INSERT INTO "public"."sys_oper_log" VALUES (2032841819603083266, '000000', '租户管理', 2, 'com.kenzhao.smallsteps.system.controller.system.SysTenantController.edit()', 'PUT', 1, 'admin', '研发部门', '/ssapi/system/tenant', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"id":1,"tenantId":"000000","contactUserName":"管理组","contactPhone":"18516108779","companyName":"Small Steps","username":"","licenseNumber":null,"address":null,"domain":null,"intro":"Small Steps","remark":null,"packageId":null,"expireTime":null,"accountCount":-1,"status":"0"}', '', 1, '不允许操作管理租户', '2026-03-14 23:30:32.834', 0);
INSERT INTO "public"."sys_oper_log" VALUES (2032841925618311170, '000000', '租户管理', 2, 'com.kenzhao.smallsteps.system.controller.system.SysTenantController.edit()', 'PUT', 1, 'admin', '研发部门', '/ssapi/system/tenant', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"id":2,"tenantId":"SS0001","contactUserName":"kenzhao","contactPhone":"18516108779","companyName":"Small Steps 家庭","username":"","licenseNumber":null,"address":"北京市朝阳区","domain":null,"intro":"Small Steps ADHD 儿童行为习惯辅助系统测试租户","remark":"测试租户","packageId":null,"expireTime":"2027-12-31 23:59:59","accountCount":-1,"status":"0"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-03-14 23:30:58.112', 101);
INSERT INTO "public"."sys_oper_log" VALUES (2032844720610222081, '000000', '用户管理', 2, 'com.kenzhao.smallsteps.system.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', '研发部门', '/ssapi/system/user', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":"2026-03-14 23:35:30","updateBy":null,"updateTime":null,"userId":"2032843068889112577","deptId":null,"userName":"kenzhao","nickName":"kenzhao","userType":"sys_user","email":"","phonenumber":"","sex":"0","status":"0","remark":null,"roleIds":[10],"postIds":null,"roleId":null,"userIds":null,"excludeUserIds":null,"superAdmin":false}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-03-14 23:42:04.491', 140);
INSERT INTO "public"."sys_oper_log" VALUES (2032844766466547713, '000000', '部门管理', 3, 'com.kenzhao.smallsteps.system.controller.system.SysDeptController.remove()', 'DELETE', 1, 'admin', '研发部门', '/ssapi/system/dept/109', '0:0:0:0:0:0:0:1', '内网IP', '109', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-03-14 23:42:15.415', 105);
INSERT INTO "public"."sys_oper_log" VALUES (2032844775878565890, '000000', '部门管理', 3, 'com.kenzhao.smallsteps.system.controller.system.SysDeptController.remove()', 'DELETE', 1, 'admin', '研发部门', '/ssapi/system/dept/108', '0:0:0:0:0:0:0:1', '内网IP', '108', '{"code":601,"msg":"部门存在用户,不允许删除","data":null}', 0, '', '2026-03-14 23:42:17.656', 14);
INSERT INTO "public"."sys_oper_log" VALUES (2032844797361790977, '000000', '部门管理', 3, 'com.kenzhao.smallsteps.system.controller.system.SysDeptController.remove()', 'DELETE', 1, 'admin', '研发部门', '/ssapi/system/dept/102', '0:0:0:0:0:0:0:1', '内网IP', '102', '{"code":601,"msg":"存在下级部门,不允许删除","data":null}', 0, '', '2026-03-14 23:42:22.784', 7);
INSERT INTO "public"."sys_oper_log" VALUES (2032844807931437057, '000000', '部门管理', 3, 'com.kenzhao.smallsteps.system.controller.system.SysDeptController.remove()', 'DELETE', 1, 'admin', '研发部门', '/ssapi/system/dept/107', '0:0:0:0:0:0:0:1', '内网IP', '107', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-03-14 23:42:25.31', 112);
INSERT INTO "public"."sys_oper_log" VALUES (2032844818643689474, '000000', '部门管理', 3, 'com.kenzhao.smallsteps.system.controller.system.SysDeptController.remove()', 'DELETE', 1, 'admin', '研发部门', '/ssapi/system/dept/106', '0:0:0:0:0:0:0:1', '内网IP', '106', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-03-14 23:42:27.861', 109);
INSERT INTO "public"."sys_oper_log" VALUES (2032844828680658946, '000000', '部门管理', 3, 'com.kenzhao.smallsteps.system.controller.system.SysDeptController.remove()', 'DELETE', 1, 'admin', '研发部门', '/ssapi/system/dept/105', '0:0:0:0:0:0:0:1', '内网IP', '105', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-03-14 23:42:30.253', 90);
INSERT INTO "public"."sys_oper_log" VALUES (2032844838411444225, '000000', '部门管理', 3, 'com.kenzhao.smallsteps.system.controller.system.SysDeptController.remove()', 'DELETE', 1, 'admin', '研发部门', '/ssapi/system/dept/104', '0:0:0:0:0:0:0:1', '内网IP', '104', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-03-14 23:42:32.578', 94);
INSERT INTO "public"."sys_oper_log" VALUES (2032844849618624513, '000000', '部门管理', 3, 'com.kenzhao.smallsteps.system.controller.system.SysDeptController.remove()', 'DELETE', 1, 'admin', '研发部门', '/ssapi/system/dept/103', '0:0:0:0:0:0:0:1', '内网IP', '103', '{"code":601,"msg":"部门存在用户,不允许删除","data":null}', 0, '', '2026-03-14 23:42:35.243', 11);
INSERT INTO "public"."sys_oper_log" VALUES (2032844965712764930, '000000', '角色管理', 2, 'com.kenzhao.smallsteps.system.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '研发部门', '/ssapi/system/role', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":"2026-03-14 20:34:33","updateBy":null,"updateTime":null,"roleId":10,"roleName":"家长","roleKey":"parent","roleSort":10,"dataScope":"5","menuCheckStrictly":true,"deptCheckStrictly":true,"status":"0","remark":"家长角色，可管理自己的孩子和任务","menuIds":[2000,2100,2101,2102,2103,2104,2105,2200,2201,2202,2203,2204,2205,2300,2301,2302,2303,2304,2305,2400,2401,2402,2403,2500,2501,2502,2503,2504,2600,2601,2602,2700,2701,2702,2703,2704],"deptIds":[],"superAdmin":false}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-03-14 23:43:02.922', 214);
INSERT INTO "public"."sys_oper_log" VALUES (2032845042791489537, '000000', '角色管理', 2, 'com.kenzhao.smallsteps.system.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '研发部门', '/ssapi/system/role', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":"2026-03-14 20:34:33","updateBy":null,"updateTime":null,"roleId":10,"roleName":"家长","roleKey":"parent","roleSort":10,"dataScope":"5","menuCheckStrictly":true,"deptCheckStrictly":true,"status":"0","remark":"家长角色，可管理自己的孩子和任务","menuIds":[2000,2100,2101,2102,2103,2104,2105,2200,2201,2202,2203,2204,2205,2300,2301,2302,2303,2304,2305,2400,2401,2402,2403,2500,2501,2502,2503,2504,2600,2601,2602,2700,2701,2702,2703,2704,3000,3100,3101,3102,3103,3200,3201,3202,3300,3301,3400,3401,3402],"deptIds":[],"superAdmin":false}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-03-14 23:43:21.297', 124);
INSERT INTO "public"."sys_oper_log" VALUES (2032845556237213697, '000000', '参数管理', 1, 'com.kenzhao.smallsteps.system.controller.system.SysConfigController.add()', 'POST', 1, 'admin', '研发部门', '/ssapi/system/config', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"configId":null,"configName":"家长角色","configKey":"ss.parent.role","configValue":"10","configType":"Y","remark":"家长角色id"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-03-14 23:45:23.712', 96);
INSERT INTO "public"."sys_oper_log" VALUES (2032849244796248066, '000000', '租户管理', 2, 'com.kenzhao.smallsteps.system.controller.system.SysTenantController.changeStatus()', 'PUT', 1, 'admin', '研发部门', '/ssapi/system/tenant/changeStatus', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"id":2,"tenantId":"SS0001","contactUserName":null,"contactPhone":null,"companyName":null,"username":null,"licenseNumber":null,"address":null,"domain":null,"intro":null,"remark":null,"packageId":null,"expireTime":null,"accountCount":null,"status":"1"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-03-15 00:00:03.126', 108);
INSERT INTO "public"."sys_oper_log" VALUES (2032849404372738050, '000000', '租户管理', 3, 'com.kenzhao.smallsteps.system.controller.system.SysTenantController.remove()', 'DELETE', 1, 'admin', '研发部门', '/ssapi/system/tenant/2', '0:0:0:0:0:0:0:1', '内网IP', '[2]', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-03-15 00:00:41.184', 87);
INSERT INTO "public"."sys_oper_log" VALUES (2032867057556643842, '000000', '菜单管理', 2, 'com.kenzhao.smallsteps.system.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/ssapi/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":103,"createBy":null,"createTime":"2026-03-14 20:30:25","updateBy":null,"updateTime":null,"menuId":6,"parentId":0,"menuName":"租户管理","orderNum":2,"path":"tenant","component":null,"queryParam":"","isFrame":"1","isCache":"0","menuType":"M","visible":"1","status":"1","perms":"","icon":"chart","remark":"租户管理目录"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-03-15 01:10:50.016', 107);
INSERT INTO "public"."sys_oper_log" VALUES (2032867085301964802, '000000', '菜单管理', 3, 'com.kenzhao.smallsteps.system.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/ssapi/system/menu/4', '0:0:0:0:0:0:0:1', '内网IP', '4', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-03-15 01:10:56.648', 72);
INSERT INTO "public"."sys_oper_log" VALUES (2032867146215841793, '000000', '菜单管理', 2, 'com.kenzhao.smallsteps.system.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/ssapi/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":103,"createBy":null,"createTime":"2026-03-14 20:30:25","updateBy":null,"updateTime":null,"menuId":5,"parentId":0,"menuName":"测试菜单","orderNum":5,"path":"demo","component":null,"queryParam":"","isFrame":"1","isCache":"0","menuType":"M","visible":"1","status":"1","icon":"star","remark":"测试菜单"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-03-15 01:11:11.162', 94);
INSERT INTO "public"."sys_oper_log" VALUES (2032867238612164610, '000000', '菜单管理', 2, 'com.kenzhao.smallsteps.system.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/ssapi/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":103,"createBy":null,"createTime":"2026-03-14 20:30:25","updateBy":null,"updateTime":null,"menuId":3,"parentId":0,"menuName":"系统工具","orderNum":4,"path":"tool","component":null,"queryParam":"","isFrame":"1","isCache":"0","menuType":"M","visible":"1","status":"1","perms":"","icon":"tool","remark":"系统工具目录"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-03-15 01:11:33.198', 86);
INSERT INTO "public"."sys_oper_log" VALUES (2032867413577555969, '000000', '菜单管理', 2, 'com.kenzhao.smallsteps.system.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/ssapi/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":103,"createBy":null,"createTime":"2026-03-14 20:30:26","updateBy":null,"updateTime":null,"menuId":103,"parentId":1,"menuName":"部门管理","orderNum":4,"path":"dept","component":"system/dept/index","queryParam":"","isFrame":"1","isCache":"0","menuType":"C","visible":"1","status":"1","perms":"system:dept:list","icon":"tree","remark":"部门管理菜单"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-03-15 01:12:14.913', 87);
INSERT INTO "public"."sys_oper_log" VALUES (2032867448188952578, '000000', '菜单管理', 2, 'com.kenzhao.smallsteps.system.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/ssapi/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":103,"createBy":null,"createTime":"2026-03-14 20:30:26","updateBy":null,"updateTime":null,"menuId":104,"parentId":1,"menuName":"岗位管理","orderNum":5,"path":"post","component":"system/post/index","queryParam":"","isFrame":"1","isCache":"0","menuType":"C","visible":"1","status":"1","perms":"system:post:list","icon":"post","remark":"岗位管理菜单"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-03-15 01:12:23.166', 71);
INSERT INTO "public"."sys_oper_log" VALUES (2035373272023035906, '000000', '用户管理', 3, 'com.kenzhao.smallsteps.system.controller.system.SysUserController.remove()', 'DELETE', 1, 'admin', '研发部门', '/ssapi/system/user/4', '0:0:0:0:0:0:0:1', '内网IP', '[4]', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-03-21 23:09:38.11', 104);
INSERT INTO "public"."sys_oper_log" VALUES (2035373283393794049, '000000', '用户管理', 3, 'com.kenzhao.smallsteps.system.controller.system.SysUserController.remove()', 'DELETE', 1, 'admin', '研发部门', '/ssapi/system/user/3', '0:0:0:0:0:0:0:1', '内网IP', '[3]', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-03-21 23:09:40.825', 94);
INSERT INTO "public"."sys_oper_log" VALUES (2035373810336788481, '000000', '用户管理', 3, 'com.kenzhao.smallsteps.system.controller.system.SysUserController.remove()', 'DELETE', 1, 'admin', '研发部门', '/ssapi/system/user/2035368650755665922', '0:0:0:0:0:0:0:1', '内网IP', '["2035368650755665922"]', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-03-21 23:11:46.458', 89);
INSERT INTO "public"."sys_oper_log" VALUES (2035373817639071746, '000000', '用户管理', 3, 'com.kenzhao.smallsteps.system.controller.system.SysUserController.remove()', 'DELETE', 1, 'admin', '研发部门', '/ssapi/system/user/2032843068889112577', '0:0:0:0:0:0:0:1', '内网IP', '["2032843068889112577"]', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-03-21 23:11:48.2', 85);
INSERT INTO "public"."sys_oper_log" VALUES (2035389511638310914, '000000', '角色管理', 2, 'com.kenzhao.smallsteps.system.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', 'Small Steps 家庭', '/ssapi/system/role', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":"2026-03-14 20:34:33","updateBy":null,"updateTime":null,"roleId":10,"roleName":"家长","roleKey":"parent","roleSort":10,"dataScope":"5","menuCheckStrictly":true,"deptCheckStrictly":true,"status":"0","remark":"家长角色，可管理自己的孩子和任务","menuIds":[2000,2100,2101,2102,2103,2104,2105,2200,2201,2202,2203,2204,2205,2300,2301,2302,2303,2304,2305,2400,2401,2402,2403,2500,2501,2502,2503,2504,2600,2601,2602,2700,2701,2702,2703,2704,3000,3100,3101,3102,3103,3200,3201,3202,3300,3301,3400,3401,3402],"deptIds":[],"superAdmin":false}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-03-22 00:14:09.94', 160);

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
-- Records of sys_oss
-- ----------------------------

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
-- Records of sys_oss_config
-- ----------------------------
INSERT INTO "public"."sys_oss_config" VALUES (1, '000000', 'minio', 'smallsteps', 'smallsteps123', 'smallsteps', '', '127.0.0.1:9000', '', 'N', '', '1', '0', '', 103, 1, '2026-03-14 20:31:10.403105', 1, '2026-03-14 20:31:10.403105', NULL);
INSERT INTO "public"."sys_oss_config" VALUES (2, '000000', 'qiniu', 'XXXXXXXXXXXXXXX', 'XXXXXXXXXXXXXXX', 'smallsteps', '', 's3-cn-north-1.qiniucs.com', '', 'N', '', '1', '1', '', 103, 1, '2026-03-14 20:31:10.478205', 1, '2026-03-14 20:31:10.478205', NULL);
INSERT INTO "public"."sys_oss_config" VALUES (3, '000000', 'aliyun', 'XXXXXXXXXXXXXXX', 'XXXXXXXXXXXXXXX', 'smallsteps', '', 'oss-cn-beijing.aliyuncs.com', '', 'N', '', '1', '1', '', 103, 1, '2026-03-14 20:31:10.553222', 1, '2026-03-14 20:31:10.553222', NULL);
INSERT INTO "public"."sys_oss_config" VALUES (4, '000000', 'qcloud', 'XXXXXXXXXXXXXXX', 'XXXXXXXXXXXXXXX', 'smallsteps-1240000000', '', 'cos.ap-beijing.myqcloud.com', '', 'N', 'ap-beijing', '1', '1', '', 103, 1, '2026-03-14 20:31:10.619935', 1, '2026-03-14 20:31:10.619935', NULL);
INSERT INTO "public"."sys_oss_config" VALUES (5, '000000', 'image', 'smallsteps', 'smallsteps123', 'smallsteps', 'image', '127.0.0.1:9000', '', 'N', '', '1', '1', '', 103, 1, '2026-03-14 20:31:10.730435', 1, '2026-03-14 20:31:10.730435', NULL);

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
-- Records of sys_post
-- ----------------------------
INSERT INTO "public"."sys_post" VALUES (1, '000000', 103, 'ceo', NULL, '董事长', 1, '0', 103, 1, '2026-03-14 20:30:21.433668', NULL, NULL, '');
INSERT INTO "public"."sys_post" VALUES (2, '000000', 100, 'se', NULL, '项目经理', 2, '0', 103, 1, '2026-03-14 20:30:21.500522', NULL, NULL, '');
INSERT INTO "public"."sys_post" VALUES (3, '000000', 100, 'hr', NULL, '人力资源', 3, '0', 103, 1, '2026-03-14 20:30:21.567092', NULL, NULL, '');
INSERT INTO "public"."sys_post" VALUES (4, '000000', 100, 'user', NULL, '普通员工', 4, '0', 103, 1, '2026-03-14 20:30:21.633824', NULL, NULL, '');

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
-- Records of sys_role
-- ----------------------------
INSERT INTO "public"."sys_role" VALUES (1, '000000', '超级管理员', 'superadmin', 1, '1', 't', 't', '0', '0', 200, 1, '2026-03-14 20:30:23.234795', NULL, NULL, '超级管理员');
INSERT INTO "public"."sys_role" VALUES (11, '000000', '儿童', 'child', 11, '5', 't', 't', '0', '0', 200, 1, '2026-03-14 20:34:33.804032', NULL, NULL, '儿童角色，可查看任务和奖励');
INSERT INTO "public"."sys_role" VALUES (10, '000000', '家长', 'parent', 10, '5', 't', 't', '0', '0', 200, 1, '2026-03-14 20:34:33', 1, '2026-03-22 00:14:09.794', '家长角色，可管理自己的孩子和任务');

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
-- Records of sys_role_dept
-- ----------------------------

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
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO "public"."sys_role_menu" VALUES (3, 1);
INSERT INTO "public"."sys_role_menu" VALUES (3, 5);
INSERT INTO "public"."sys_role_menu" VALUES (3, 100);
INSERT INTO "public"."sys_role_menu" VALUES (3, 101);
INSERT INTO "public"."sys_role_menu" VALUES (3, 102);
INSERT INTO "public"."sys_role_menu" VALUES (3, 103);
INSERT INTO "public"."sys_role_menu" VALUES (3, 104);
INSERT INTO "public"."sys_role_menu" VALUES (3, 105);
INSERT INTO "public"."sys_role_menu" VALUES (3, 106);
INSERT INTO "public"."sys_role_menu" VALUES (3, 107);
INSERT INTO "public"."sys_role_menu" VALUES (3, 108);
INSERT INTO "public"."sys_role_menu" VALUES (3, 118);
INSERT INTO "public"."sys_role_menu" VALUES (3, 123);
INSERT INTO "public"."sys_role_menu" VALUES (3, 130);
INSERT INTO "public"."sys_role_menu" VALUES (3, 131);
INSERT INTO "public"."sys_role_menu" VALUES (3, 132);
INSERT INTO "public"."sys_role_menu" VALUES (3, 133);
INSERT INTO "public"."sys_role_menu" VALUES (3, 500);
INSERT INTO "public"."sys_role_menu" VALUES (3, 501);
INSERT INTO "public"."sys_role_menu" VALUES (3, 1001);
INSERT INTO "public"."sys_role_menu" VALUES (3, 1002);
INSERT INTO "public"."sys_role_menu" VALUES (3, 1003);
INSERT INTO "public"."sys_role_menu" VALUES (3, 1004);
INSERT INTO "public"."sys_role_menu" VALUES (3, 1005);
INSERT INTO "public"."sys_role_menu" VALUES (3, 1006);
INSERT INTO "public"."sys_role_menu" VALUES (3, 1007);
INSERT INTO "public"."sys_role_menu" VALUES (3, 1008);
INSERT INTO "public"."sys_role_menu" VALUES (3, 1009);
INSERT INTO "public"."sys_role_menu" VALUES (3, 1010);
INSERT INTO "public"."sys_role_menu" VALUES (3, 1011);
INSERT INTO "public"."sys_role_menu" VALUES (3, 1012);
INSERT INTO "public"."sys_role_menu" VALUES (3, 1013);
INSERT INTO "public"."sys_role_menu" VALUES (3, 1014);
INSERT INTO "public"."sys_role_menu" VALUES (3, 1015);
INSERT INTO "public"."sys_role_menu" VALUES (3, 1016);
INSERT INTO "public"."sys_role_menu" VALUES (3, 1017);
INSERT INTO "public"."sys_role_menu" VALUES (3, 1018);
INSERT INTO "public"."sys_role_menu" VALUES (3, 1019);
INSERT INTO "public"."sys_role_menu" VALUES (3, 1020);
INSERT INTO "public"."sys_role_menu" VALUES (3, 1021);
INSERT INTO "public"."sys_role_menu" VALUES (3, 1022);
INSERT INTO "public"."sys_role_menu" VALUES (3, 1023);
INSERT INTO "public"."sys_role_menu" VALUES (3, 1024);
INSERT INTO "public"."sys_role_menu" VALUES (3, 1025);
INSERT INTO "public"."sys_role_menu" VALUES (3, 1026);
INSERT INTO "public"."sys_role_menu" VALUES (3, 1027);
INSERT INTO "public"."sys_role_menu" VALUES (3, 1028);
INSERT INTO "public"."sys_role_menu" VALUES (3, 1029);
INSERT INTO "public"."sys_role_menu" VALUES (3, 1030);
INSERT INTO "public"."sys_role_menu" VALUES (3, 1031);
INSERT INTO "public"."sys_role_menu" VALUES (3, 1032);
INSERT INTO "public"."sys_role_menu" VALUES (3, 1033);
INSERT INTO "public"."sys_role_menu" VALUES (3, 1034);
INSERT INTO "public"."sys_role_menu" VALUES (3, 1035);
INSERT INTO "public"."sys_role_menu" VALUES (3, 1036);
INSERT INTO "public"."sys_role_menu" VALUES (3, 1037);
INSERT INTO "public"."sys_role_menu" VALUES (3, 1038);
INSERT INTO "public"."sys_role_menu" VALUES (3, 1039);
INSERT INTO "public"."sys_role_menu" VALUES (3, 1040);
INSERT INTO "public"."sys_role_menu" VALUES (3, 1041);
INSERT INTO "public"."sys_role_menu" VALUES (3, 1042);
INSERT INTO "public"."sys_role_menu" VALUES (3, 1043);
INSERT INTO "public"."sys_role_menu" VALUES (3, 1044);
INSERT INTO "public"."sys_role_menu" VALUES (3, 1045);
INSERT INTO "public"."sys_role_menu" VALUES (3, 1050);
INSERT INTO "public"."sys_role_menu" VALUES (3, 1061);
INSERT INTO "public"."sys_role_menu" VALUES (3, 1062);
INSERT INTO "public"."sys_role_menu" VALUES (3, 1063);
INSERT INTO "public"."sys_role_menu" VALUES (3, 1064);
INSERT INTO "public"."sys_role_menu" VALUES (3, 1065);
INSERT INTO "public"."sys_role_menu" VALUES (3, 1500);
INSERT INTO "public"."sys_role_menu" VALUES (3, 1501);
INSERT INTO "public"."sys_role_menu" VALUES (3, 1502);
INSERT INTO "public"."sys_role_menu" VALUES (3, 1503);
INSERT INTO "public"."sys_role_menu" VALUES (3, 1504);
INSERT INTO "public"."sys_role_menu" VALUES (3, 1505);
INSERT INTO "public"."sys_role_menu" VALUES (3, 1506);
INSERT INTO "public"."sys_role_menu" VALUES (3, 1507);
INSERT INTO "public"."sys_role_menu" VALUES (3, 1508);
INSERT INTO "public"."sys_role_menu" VALUES (3, 1509);
INSERT INTO "public"."sys_role_menu" VALUES (3, 1510);
INSERT INTO "public"."sys_role_menu" VALUES (3, 1511);
INSERT INTO "public"."sys_role_menu" VALUES (3, 1600);
INSERT INTO "public"."sys_role_menu" VALUES (3, 1601);
INSERT INTO "public"."sys_role_menu" VALUES (3, 1602);
INSERT INTO "public"."sys_role_menu" VALUES (3, 1603);
INSERT INTO "public"."sys_role_menu" VALUES (3, 1620);
INSERT INTO "public"."sys_role_menu" VALUES (3, 1621);
INSERT INTO "public"."sys_role_menu" VALUES (3, 1622);
INSERT INTO "public"."sys_role_menu" VALUES (3, 1623);
INSERT INTO "public"."sys_role_menu" VALUES (3, 11616);
INSERT INTO "public"."sys_role_menu" VALUES (3, 11618);
INSERT INTO "public"."sys_role_menu" VALUES (3, 11619);
INSERT INTO "public"."sys_role_menu" VALUES (3, 11622);
INSERT INTO "public"."sys_role_menu" VALUES (3, 11623);
INSERT INTO "public"."sys_role_menu" VALUES (3, 11629);
INSERT INTO "public"."sys_role_menu" VALUES (3, 11632);
INSERT INTO "public"."sys_role_menu" VALUES (3, 11633);
INSERT INTO "public"."sys_role_menu" VALUES (3, 11638);
INSERT INTO "public"."sys_role_menu" VALUES (3, 11639);
INSERT INTO "public"."sys_role_menu" VALUES (3, 11640);
INSERT INTO "public"."sys_role_menu" VALUES (3, 11641);
INSERT INTO "public"."sys_role_menu" VALUES (3, 11642);
INSERT INTO "public"."sys_role_menu" VALUES (3, 11643);
INSERT INTO "public"."sys_role_menu" VALUES (3, 11701);
INSERT INTO "public"."sys_role_menu" VALUES (4, 5);
INSERT INTO "public"."sys_role_menu" VALUES (4, 1500);
INSERT INTO "public"."sys_role_menu" VALUES (4, 1501);
INSERT INTO "public"."sys_role_menu" VALUES (4, 1502);
INSERT INTO "public"."sys_role_menu" VALUES (4, 1503);
INSERT INTO "public"."sys_role_menu" VALUES (4, 1504);
INSERT INTO "public"."sys_role_menu" VALUES (4, 1505);
INSERT INTO "public"."sys_role_menu" VALUES (4, 1506);
INSERT INTO "public"."sys_role_menu" VALUES (4, 1507);
INSERT INTO "public"."sys_role_menu" VALUES (4, 1508);
INSERT INTO "public"."sys_role_menu" VALUES (4, 1509);
INSERT INTO "public"."sys_role_menu" VALUES (4, 1510);
INSERT INTO "public"."sys_role_menu" VALUES (4, 1511);
INSERT INTO "public"."sys_role_menu" VALUES (11, 3000);
INSERT INTO "public"."sys_role_menu" VALUES (11, 3100);
INSERT INTO "public"."sys_role_menu" VALUES (11, 3101);
INSERT INTO "public"."sys_role_menu" VALUES (11, 3102);
INSERT INTO "public"."sys_role_menu" VALUES (11, 3103);
INSERT INTO "public"."sys_role_menu" VALUES (11, 3200);
INSERT INTO "public"."sys_role_menu" VALUES (11, 3201);
INSERT INTO "public"."sys_role_menu" VALUES (11, 3202);
INSERT INTO "public"."sys_role_menu" VALUES (11, 3300);
INSERT INTO "public"."sys_role_menu" VALUES (11, 3301);
INSERT INTO "public"."sys_role_menu" VALUES (11, 3400);
INSERT INTO "public"."sys_role_menu" VALUES (11, 3401);
INSERT INTO "public"."sys_role_menu" VALUES (11, 3402);
INSERT INTO "public"."sys_role_menu" VALUES (10, 2000);
INSERT INTO "public"."sys_role_menu" VALUES (10, 2100);
INSERT INTO "public"."sys_role_menu" VALUES (10, 2101);
INSERT INTO "public"."sys_role_menu" VALUES (10, 2102);
INSERT INTO "public"."sys_role_menu" VALUES (10, 2103);
INSERT INTO "public"."sys_role_menu" VALUES (10, 2104);
INSERT INTO "public"."sys_role_menu" VALUES (10, 2105);
INSERT INTO "public"."sys_role_menu" VALUES (10, 2200);
INSERT INTO "public"."sys_role_menu" VALUES (10, 2201);
INSERT INTO "public"."sys_role_menu" VALUES (10, 2202);
INSERT INTO "public"."sys_role_menu" VALUES (10, 2203);
INSERT INTO "public"."sys_role_menu" VALUES (10, 2204);
INSERT INTO "public"."sys_role_menu" VALUES (10, 2205);
INSERT INTO "public"."sys_role_menu" VALUES (10, 2300);
INSERT INTO "public"."sys_role_menu" VALUES (10, 2301);
INSERT INTO "public"."sys_role_menu" VALUES (10, 2302);
INSERT INTO "public"."sys_role_menu" VALUES (10, 2303);
INSERT INTO "public"."sys_role_menu" VALUES (10, 2304);
INSERT INTO "public"."sys_role_menu" VALUES (10, 2305);
INSERT INTO "public"."sys_role_menu" VALUES (10, 2400);
INSERT INTO "public"."sys_role_menu" VALUES (10, 2401);
INSERT INTO "public"."sys_role_menu" VALUES (10, 2402);
INSERT INTO "public"."sys_role_menu" VALUES (10, 2403);
INSERT INTO "public"."sys_role_menu" VALUES (10, 2500);
INSERT INTO "public"."sys_role_menu" VALUES (10, 2501);
INSERT INTO "public"."sys_role_menu" VALUES (10, 2502);
INSERT INTO "public"."sys_role_menu" VALUES (10, 2503);
INSERT INTO "public"."sys_role_menu" VALUES (10, 2504);
INSERT INTO "public"."sys_role_menu" VALUES (10, 2600);
INSERT INTO "public"."sys_role_menu" VALUES (10, 2601);
INSERT INTO "public"."sys_role_menu" VALUES (10, 2602);
INSERT INTO "public"."sys_role_menu" VALUES (10, 2700);
INSERT INTO "public"."sys_role_menu" VALUES (10, 2701);
INSERT INTO "public"."sys_role_menu" VALUES (10, 2702);
INSERT INTO "public"."sys_role_menu" VALUES (10, 2703);
INSERT INTO "public"."sys_role_menu" VALUES (10, 2704);
INSERT INTO "public"."sys_role_menu" VALUES (10, 3000);
INSERT INTO "public"."sys_role_menu" VALUES (10, 3100);
INSERT INTO "public"."sys_role_menu" VALUES (10, 3101);
INSERT INTO "public"."sys_role_menu" VALUES (10, 3102);
INSERT INTO "public"."sys_role_menu" VALUES (10, 3103);
INSERT INTO "public"."sys_role_menu" VALUES (10, 3200);
INSERT INTO "public"."sys_role_menu" VALUES (10, 3201);
INSERT INTO "public"."sys_role_menu" VALUES (10, 3202);
INSERT INTO "public"."sys_role_menu" VALUES (10, 3300);
INSERT INTO "public"."sys_role_menu" VALUES (10, 3301);
INSERT INTO "public"."sys_role_menu" VALUES (10, 3400);
INSERT INTO "public"."sys_role_menu" VALUES (10, 3401);
INSERT INTO "public"."sys_role_menu" VALUES (10, 3402);

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
-- Records of sys_social
-- ----------------------------

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
-- Records of sys_tenant
-- ----------------------------
INSERT INTO "public"."sys_tenant" VALUES (1, '000000', 'kenzhao', '18516108779', 'Small Steps 家庭', NULL, NULL, 'Small Steps ADHD 儿童行为习惯辅助系统测试租户', NULL, NULL, NULL, NULL, -1, '0', '0', 103, 1, '2026-03-14 20:30:14.264191', NULL, NULL);

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
-- Records of sys_tenant_package
-- ----------------------------

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
-- Records of sys_user
-- ----------------------------
INSERT INTO "public"."sys_user" VALUES (1001, '000000', 200, 'parent_li', '李娜', 'sys_user', 'lina@example.com', '13800138002', '1', NULL, '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2026-03-14 20:37:08.038754', 200, 1, '2026-03-14 20:37:08.038754', NULL, NULL, '家长测试账号 - 密码: admin123');
INSERT INTO "public"."sys_user" VALUES (1002, '000000', 200, 'child_xiaoming', '张小明', 'sys_user', '', '', '0', NULL, '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2026-03-14 20:37:08.105589', 200, 1, '2026-03-14 20:37:08.105589', NULL, NULL, '儿童测试账号 - 密码: admin123');
INSERT INTO "public"."sys_user" VALUES (1003, '000000', 200, 'child_xiaohong', '张小红', 'sys_user', '', '', '1', NULL, '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2026-03-14 20:37:08.180468', 200, 1, '2026-03-14 20:37:08.180468', NULL, NULL, '儿童测试账号 - 密码: admin123');
INSERT INTO "public"."sys_user" VALUES (1, '000000', 200, 'admin', '系统管理员', 'sys_user', '1130473608@qq.com', '18516108779', '1', NULL, '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '0:0:0:0:0:0:0:1', '2026-03-22 00:13:02.992', 103, 1, '2026-03-14 20:30:19.891442', -1, '2026-03-22 00:13:02.992', '管理员');
INSERT INTO "public"."sys_user" VALUES (1000, '000000', 200, 'parent_zhang', '张伟', 'sys_user', 'zhangwei@example.com', '13800138001', '0', NULL, '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '192.168.1.9', '2026-03-22 00:23:23.042', 200, 1, '2026-03-14 20:37:07.963832', -1, '2026-03-22 00:23:23.048', '家长测试账号 - 密码: admin123');
INSERT INTO "public"."sys_user" VALUES (2035392423676469250, '000000', 200, 'ken2zhao', 'ken2zhao', 'sys_user', '', '', '0', NULL, '$2a$10$BBY6uvIsgU3484/nFDJzx.z5wbSQHkY3kdKLqQGcJ.Vh7HZAEn5KO', '0', '0', '192.168.1.9', '2026-03-22 00:25:49.411', NULL, 0, '2026-03-22 00:25:44.224', -1, '2026-03-22 00:25:49.411', NULL);

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
-- Records of sys_user_post
-- ----------------------------
INSERT INTO "public"."sys_user_post" VALUES (1, 1);

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
-- Records of sys_user_role
-- ----------------------------
INSERT INTO "public"."sys_user_role" VALUES (1, 1);
INSERT INTO "public"."sys_user_role" VALUES (1000, 10);
INSERT INTO "public"."sys_user_role" VALUES (1001, 10);
INSERT INTO "public"."sys_user_role" VALUES (1002, 11);
INSERT INTO "public"."sys_user_role" VALUES (1003, 11);
INSERT INTO "public"."sys_user_role" VALUES (2035392423676469250, 10);

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
-- Records of test_demo
-- ----------------------------
INSERT INTO "public"."test_demo" VALUES (1, '000000', 102, 4, 1, '测试数据权限', '测试', 0, 103, '2026-03-14 20:31:15.789135', 1, NULL, NULL, 0);
INSERT INTO "public"."test_demo" VALUES (2, '000000', 102, 3, 2, '子节点1', '111', 0, 103, '2026-03-14 20:31:15.913836', 1, NULL, NULL, 0);
INSERT INTO "public"."test_demo" VALUES (3, '000000', 102, 3, 3, '子节点2', '222', 0, 103, '2026-03-14 20:31:15.989261', 1, NULL, NULL, 0);
INSERT INTO "public"."test_demo" VALUES (4, '000000', 108, 4, 4, '测试数据', 'demo', 0, 103, '2026-03-14 20:31:16.080731', 1, NULL, NULL, 0);
INSERT INTO "public"."test_demo" VALUES (5, '000000', 108, 3, 13, '子节点11', '1111', 0, 103, '2026-03-14 20:31:16.172263', 1, NULL, NULL, 0);
INSERT INTO "public"."test_demo" VALUES (6, '000000', 108, 3, 12, '子节点22', '2222', 0, 103, '2026-03-14 20:31:16.24767', 1, NULL, NULL, 0);
INSERT INTO "public"."test_demo" VALUES (7, '000000', 108, 3, 11, '子节点33', '3333', 0, 103, '2026-03-14 20:31:16.339106', 1, NULL, NULL, 0);
INSERT INTO "public"."test_demo" VALUES (8, '000000', 108, 3, 10, '子节点44', '4444', 0, 103, '2026-03-14 20:31:16.405819', 1, NULL, NULL, 0);
INSERT INTO "public"."test_demo" VALUES (9, '000000', 108, 3, 9, '子节点55', '5555', 0, 103, '2026-03-14 20:31:16.497852', 1, NULL, NULL, 0);
INSERT INTO "public"."test_demo" VALUES (10, '000000', 108, 3, 8, '子节点66', '6666', 0, 103, '2026-03-14 20:31:16.597572', 1, NULL, NULL, 0);
INSERT INTO "public"."test_demo" VALUES (11, '000000', 108, 3, 7, '子节点77', '7777', 0, 103, '2026-03-14 20:31:16.672743', 1, NULL, NULL, 0);
INSERT INTO "public"."test_demo" VALUES (12, '000000', 108, 3, 6, '子节点88', '8888', 0, 103, '2026-03-14 20:31:16.781133', 1, NULL, NULL, 0);
INSERT INTO "public"."test_demo" VALUES (13, '000000', 108, 3, 5, '子节点99', '9999', 0, 103, '2026-03-14 20:31:16.864517', 1, NULL, NULL, 0);
INSERT INTO "public"."test_demo" VALUES (1, '000000', 102, 4, 1, '测试数据权限', '测试', 0, 103, '2026-03-14 20:32:01.414959', 1, NULL, NULL, 0);
INSERT INTO "public"."test_demo" VALUES (2, '000000', 102, 3, 2, '子节点1', '111', 0, 103, '2026-03-14 20:32:01.48203', 1, NULL, NULL, 0);
INSERT INTO "public"."test_demo" VALUES (3, '000000', 102, 3, 3, '子节点2', '222', 0, 103, '2026-03-14 20:32:01.548717', 1, NULL, NULL, 0);
INSERT INTO "public"."test_demo" VALUES (4, '000000', 108, 4, 4, '测试数据', 'demo', 0, 103, '2026-03-14 20:32:01.615461', 1, NULL, NULL, 0);
INSERT INTO "public"."test_demo" VALUES (5, '000000', 108, 3, 13, '子节点11', '1111', 0, 103, '2026-03-14 20:32:01.682293', 1, NULL, NULL, 0);
INSERT INTO "public"."test_demo" VALUES (6, '000000', 108, 3, 12, '子节点22', '2222', 0, 103, '2026-03-14 20:32:01.765698', 1, NULL, NULL, 0);
INSERT INTO "public"."test_demo" VALUES (7, '000000', 108, 3, 11, '子节点33', '3333', 0, 103, '2026-03-14 20:32:01.840608', 1, NULL, NULL, 0);
INSERT INTO "public"."test_demo" VALUES (8, '000000', 108, 3, 10, '子节点44', '4444', 0, 103, '2026-03-14 20:32:01.915387', 1, NULL, NULL, 0);
INSERT INTO "public"."test_demo" VALUES (9, '000000', 108, 3, 9, '子节点55', '5555', 0, 103, '2026-03-14 20:32:01.990654', 1, NULL, NULL, 0);
INSERT INTO "public"."test_demo" VALUES (10, '000000', 108, 3, 8, '子节点66', '6666', 0, 103, '2026-03-14 20:32:02.065638', 1, NULL, NULL, 0);
INSERT INTO "public"."test_demo" VALUES (11, '000000', 108, 3, 7, '子节点77', '7777', 0, 103, '2026-03-14 20:32:02.132485', 1, NULL, NULL, 0);
INSERT INTO "public"."test_demo" VALUES (12, '000000', 108, 3, 6, '子节点88', '8888', 0, 103, '2026-03-14 20:32:02.199036', 1, NULL, NULL, 0);
INSERT INTO "public"."test_demo" VALUES (13, '000000', 108, 3, 5, '子节点99', '9999', 0, 103, '2026-03-14 20:32:02.273992', 1, NULL, NULL, 0);

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
-- Records of test_tree
-- ----------------------------
INSERT INTO "public"."test_tree" VALUES (1, '000000', 0, 102, 4, '测试数据权限', 0, 103, '2026-03-14 20:31:16.94902', 1, NULL, NULL, 0);
INSERT INTO "public"."test_tree" VALUES (2, '000000', 1, 102, 3, '子节点1', 0, 103, '2026-03-14 20:31:17.023083', 1, NULL, NULL, 0);
INSERT INTO "public"."test_tree" VALUES (3, '000000', 2, 102, 3, '子节点2', 0, 103, '2026-03-14 20:31:17.10613', 1, NULL, NULL, 0);
INSERT INTO "public"."test_tree" VALUES (4, '000000', 0, 108, 4, '测试树1', 0, 103, '2026-03-14 20:31:17.180841', 1, NULL, NULL, 0);
INSERT INTO "public"."test_tree" VALUES (5, '000000', 4, 108, 3, '子节点11', 0, 103, '2026-03-14 20:31:17.28929', 1, NULL, NULL, 0);
INSERT INTO "public"."test_tree" VALUES (6, '000000', 4, 108, 3, '子节点22', 0, 103, '2026-03-14 20:31:17.364636', 1, NULL, NULL, 0);
INSERT INTO "public"."test_tree" VALUES (7, '000000', 4, 108, 3, '子节点33', 0, 103, '2026-03-14 20:31:17.439586', 1, NULL, NULL, 0);
INSERT INTO "public"."test_tree" VALUES (8, '000000', 5, 108, 3, '子节点44', 0, 103, '2026-03-14 20:31:17.539572', 1, NULL, NULL, 0);
INSERT INTO "public"."test_tree" VALUES (9, '000000', 6, 108, 3, '子节点55', 0, 103, '2026-03-14 20:31:17.614515', 1, NULL, NULL, 0);
INSERT INTO "public"."test_tree" VALUES (10, '000000', 7, 108, 3, '子节点66', 0, 103, '2026-03-14 20:31:17.715877', 1, NULL, NULL, 0);
INSERT INTO "public"."test_tree" VALUES (11, '000000', 7, 108, 3, '子节点77', 0, 103, '2026-03-14 20:31:17.789715', 1, NULL, NULL, 0);
INSERT INTO "public"."test_tree" VALUES (12, '000000', 10, 108, 3, '子节点88', 0, 103, '2026-03-14 20:31:17.931311', 1, NULL, NULL, 0);
INSERT INTO "public"."test_tree" VALUES (13, '000000', 10, 108, 3, '子节点99', 0, 103, '2026-03-14 20:31:18.006208', 1, NULL, NULL, 0);
INSERT INTO "public"."test_tree" VALUES (1, '000000', 0, 102, 4, '测试数据权限', 0, 103, '2026-03-14 20:32:02.348895', 1, NULL, NULL, 0);
INSERT INTO "public"."test_tree" VALUES (2, '000000', 1, 102, 3, '子节点1', 0, 103, '2026-03-14 20:32:02.424032', 1, NULL, NULL, 0);
INSERT INTO "public"."test_tree" VALUES (3, '000000', 2, 102, 3, '子节点2', 0, 103, '2026-03-14 20:32:02.499328', 1, NULL, NULL, 0);
INSERT INTO "public"."test_tree" VALUES (4, '000000', 0, 108, 4, '测试树1', 0, 103, '2026-03-14 20:32:02.574062', 1, NULL, NULL, 0);
INSERT INTO "public"."test_tree" VALUES (5, '000000', 4, 108, 3, '子节点11', 0, 103, '2026-03-14 20:32:02.691082', 1, NULL, NULL, 0);
INSERT INTO "public"."test_tree" VALUES (6, '000000', 4, 108, 3, '子节点22', 0, 103, '2026-03-14 20:32:02.765838', 1, NULL, NULL, 0);
INSERT INTO "public"."test_tree" VALUES (7, '000000', 4, 108, 3, '子节点33', 0, 103, '2026-03-14 20:32:02.840883', 1, NULL, NULL, 0);
INSERT INTO "public"."test_tree" VALUES (8, '000000', 5, 108, 3, '子节点44', 0, 103, '2026-03-14 20:32:02.916362', 1, NULL, NULL, 0);
INSERT INTO "public"."test_tree" VALUES (9, '000000', 6, 108, 3, '子节点55', 0, 103, '2026-03-14 20:32:02.991069', 1, NULL, NULL, 0);
INSERT INTO "public"."test_tree" VALUES (10, '000000', 7, 108, 3, '子节点66', 0, 103, '2026-03-14 20:32:03.066177', 1, NULL, NULL, 0);
INSERT INTO "public"."test_tree" VALUES (11, '000000', 7, 108, 3, '子节点77', 0, 103, '2026-03-14 20:32:03.141159', 1, NULL, NULL, 0);
INSERT INTO "public"."test_tree" VALUES (12, '000000', 10, 108, 3, '子节点88', 0, 103, '2026-03-14 20:32:03.257948', 1, NULL, NULL, 0);
INSERT INTO "public"."test_tree" VALUES (13, '000000', 10, 108, 3, '子节点99', 0, 103, '2026-03-14 20:32:03.341108', 1, NULL, NULL, 0);

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
