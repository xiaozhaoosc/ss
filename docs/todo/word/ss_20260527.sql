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

 Date: 27/05/2026 23:30:39
*/


-- ----------------------------
-- Sequence structure for ss_child_ai_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."ss_child_ai_id_seq";
CREATE SEQUENCE "public"."ss_child_ai_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for ss_task_step_template_step_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."ss_task_step_template_step_id_seq";
CREATE SEQUENCE "public"."ss_task_step_template_step_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for ss_task_template_template_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."ss_task_template_template_id_seq";
CREATE SEQUENCE "public"."ss_task_template_template_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

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
  "create_time" timestamp(6),
  "create_dept" int8,
  "update_by" int8,
  "update_time" timestamp(6),
  "del_flag" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar
)
;
COMMENT ON COLUMN "public"."ss_achievement"."create_dept" IS '创建部门';
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
INSERT INTO "public"."ss_child" VALUES (1003, 'SS0001', 2035392423676469250, '小红', '/avatar/girl1.png', '{"hair": "long", "clothes": "pink", "accessories": "bow"}', 2, '{"maxScreenTime": 45, "maxTasksPerDay": 4}', '1', '2018-08-20 00:00:00', 80, 220, '["注意力不集中", "情绪波动"]', 200, 1000, '2026-03-14 20:37:08.772333', NULL, NULL, '7岁女孩，ADHD，喜欢画画和跳舞', '0');
INSERT INTO "public"."ss_child" VALUES (2047877554018242562, '000000', 200, 'test12', '', NULL, 1, NULL, '0', '2026-04-08 00:00:00', 0, 0, NULL, 200, 1, '2026-04-25 11:17:11.262', 1, '2026-04-25 11:17:11.262', NULL, '0');
INSERT INTO "public"."ss_child" VALUES (1002, 'SS0001', 2035392423676469250, '小明', 'blob:http://localhost:9090/34e79385-ca9d-42bc-af5f-5989e2204491', '{"hair": "short", "clothes": "blue", "accessories": "glasses"}', 3, '{"maxScreenTime": 60, "maxTasksPerDay": 5}', '0', '2016-05-15 00:00:00', 150, 580, '["注意力不集中", "多动", "冲动"]', 200, 1000, '2026-03-14 20:37:08', 2035392423676469250, '2026-04-25 16:10:10.429', '9岁男孩，ADHD，喜欢恐龙和乐高', '0');
INSERT INTO "public"."ss_child" VALUES (10001, 'SS0001', 2035392423676469250, '小明', '/avatar/boy1.png', NULL, 3, NULL, '0', NULL, 200, 500, NULL, NULL, NULL, '2026-04-25 16:43:46.522317', NULL, NULL, NULL, '0');
INSERT INTO "public"."ss_child" VALUES (10002, 'SS0001', 2035392423676469250, '小红', '/avatar/girl1.png', NULL, 2, NULL, '0', NULL, 150, 300, NULL, NULL, NULL, '2026-04-25 16:43:46.522317', NULL, NULL, NULL, '0');

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
  "remark" varchar(500) COLLATE "pg_catalog"."default",
  "del_flag" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar,
  "create_dept" int8,
  "create_by" int8,
  "create_time" timestamp(6),
  "update_by" int8,
  "update_time" timestamp(6)
)
;
COMMENT ON COLUMN "public"."ss_child_achievement"."type" IS '成就类型 (STAR-星星, FRAGMENT-勇气碎片, BADGE-勋章)';
COMMENT ON COLUMN "public"."ss_child_achievement"."name" IS '名称';
COMMENT ON COLUMN "public"."ss_child_achievement"."count" IS '数量/进度';
COMMENT ON COLUMN "public"."ss_child_achievement"."icon" IS '图标';
COMMENT ON COLUMN "public"."ss_child_achievement"."remark" IS '备注/描述';
COMMENT ON COLUMN "public"."ss_child_achievement"."del_flag" IS '删除标志 (0代表存在 2代表删除)';
COMMENT ON COLUMN "public"."ss_child_achievement"."create_dept" IS '创建部门';
COMMENT ON COLUMN "public"."ss_child_achievement"."create_by" IS '创建者';
COMMENT ON COLUMN "public"."ss_child_achievement"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."ss_child_achievement"."update_by" IS '更新者';
COMMENT ON COLUMN "public"."ss_child_achievement"."update_time" IS '更新时间';
COMMENT ON TABLE "public"."ss_child_achievement" IS '儿童成就进度表';

-- ----------------------------
-- Records of ss_child_achievement
-- ----------------------------

-- ----------------------------
-- Table structure for ss_child_ai
-- ----------------------------
DROP TABLE IF EXISTS "public"."ss_child_ai";
CREATE TABLE "public"."ss_child_ai" (
  "id" int8 NOT NULL DEFAULT nextval('ss_child_ai_id_seq'::regclass),
  "child_id" int8 NOT NULL,
  "user_input" text COLLATE "pg_catalog"."default",
  "ai_response" text COLLATE "pg_catalog"."default",
  "emotion_type" int2,
  "context" text COLLATE "pg_catalog"."default",
  "create_by" int8,
  "create_time" timestamp(6),
  "update_by" int8,
  "update_time" timestamp(6),
  "del_flag" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar,
  "create_dept" int8
)
;
COMMENT ON COLUMN "public"."ss_child_ai"."id" IS '交互ID';
COMMENT ON COLUMN "public"."ss_child_ai"."child_id" IS '孩子ID';
COMMENT ON COLUMN "public"."ss_child_ai"."user_input" IS '用户输入';
COMMENT ON COLUMN "public"."ss_child_ai"."ai_response" IS 'AI回复内容';
COMMENT ON COLUMN "public"."ss_child_ai"."emotion_type" IS '情绪类型 (1-开心, 2-难过, 3-愤怒, 4-焦虑, 5-平静)';
COMMENT ON COLUMN "public"."ss_child_ai"."context" IS '场景上下文';
COMMENT ON COLUMN "public"."ss_child_ai"."create_by" IS '创建者';
COMMENT ON COLUMN "public"."ss_child_ai"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."ss_child_ai"."update_by" IS '更新者';
COMMENT ON COLUMN "public"."ss_child_ai"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."ss_child_ai"."del_flag" IS '删除标志（0代表存在 1/2代表删除）';
COMMENT ON TABLE "public"."ss_child_ai" IS '儿童AI交互记录表';

-- ----------------------------
-- Records of ss_child_ai
-- ----------------------------
INSERT INTO "public"."ss_child_ai" VALUES (2048015414562168833, 1002, 'test1', '嘿，感觉你现在的火气有点大。这很正常，深呼吸，我们可以一起把烦恼都“吹”走。💨', 3, NULL, 1002, '2026-04-25 20:24:59.776', 1002, '2026-04-25 20:24:59.776', '0', 200);
INSERT INTO "public"."ss_child_ai" VALUES (1, 1002, '今天在学校和小明一起玩了搭积木', '哇，听起来非常有趣呢！搭积木可以锻炼动手能力哦。', 1, NULL, 0, '2026-04-01 15:30:00', 0, NULL, '0', NULL);
INSERT INTO "public"."ss_child_ai" VALUES (2, 1002, '老师表扬我数学题都做对了', '太棒了！你的努力得到了认可，继续保持！', 5, NULL, 0, '2026-04-03 16:45:00', 0, NULL, '0', NULL);
INSERT INTO "public"."ss_child_ai" VALUES (3, 1002, '我的玩具小汽车坏了', '别难过，你可以和爸爸一起尝试修理它，这也是个学习的过程。', 2, NULL, 0, '2026-04-05 18:20:00', 0, NULL, '0', NULL);
INSERT INTO "public"."ss_child_ai" VALUES (4, 1002, '我讨厌吃胡萝卜！', '胡萝卜含有丰富的维生素，对眼睛很好哦，试着吃一小口怎么样？', 3, NULL, 0, '2026-04-08 12:10:00', 0, NULL, '0', NULL);
INSERT INTO "public"."ss_child_ai" VALUES (5, 1002, '明天要考试了，我有点担心', '不要紧张，你已经复习得很好了，相信自己一定能行。', 4, NULL, 0, '2026-04-10 19:30:00', 0, NULL, '0', NULL);
INSERT INTO "public"."ss_child_ai" VALUES (6, 1002, '周末要去游乐园啦！', '那一定是非常开心的一天，提前祝你玩得愉快！', 1, NULL, 0, '2026-04-12 14:20:00', 0, NULL, '0', NULL);
INSERT INTO "public"."ss_child_ai" VALUES (7, 1002, '今天画了一幅画', '这幅画真漂亮，你的创造力越来越棒了。', 5, NULL, 0, '2026-04-15 16:00:00', 0, NULL, '0', NULL);
INSERT INTO "public"."ss_child_ai" VALUES (8, 1002, '和小朋友吵架了', '朋友之间难免会有摩擦，试着主动去沟通和好。', 2, NULL, 0, '2026-04-18 17:30:00', 0, NULL, '0', NULL);
INSERT INTO "public"."ss_child_ai" VALUES (9, 1002, '为什么天是蓝色的？', '因为阳光穿过大气层时，蓝光被散射得最多呀。', 5, NULL, 0, '2026-04-20 11:20:00', 0, NULL, '0', NULL);
INSERT INTO "public"."ss_child_ai" VALUES (10, 1002, '我赢了跑步比赛！', '太棒了，你是个小冠军！', 3, NULL, 0, '2026-04-22 10:15:00', 0, NULL, '0', NULL);
INSERT INTO "public"."ss_child_ai" VALUES (11, 1002, '今天学了首新歌', '真好听！音乐能让人心情愉悦。', 1, NULL, 0, '2026-04-24 16:40:00', 0, NULL, '0', NULL);
INSERT INTO "public"."ss_child_ai" VALUES (2048015791193890817, 1002, '你是谁', '谢谢你跟我分享！你做得很好，我们接下来要开始新的任务吗？🦖', 5, NULL, 1002, '2026-04-25 20:26:29.578', 1002, '2026-04-25 20:26:29.578', '0', 200);
INSERT INTO "public"."ss_child_ai" VALUES (2048025599900913666, 1002, 'WhoAreYou', '我现在有点小情绪，等下再来找我玩吧！🌈', 5, NULL, -1, '2026-04-25 21:05:28.152', -1, '2026-04-25 21:05:28.152', '0', -1);
INSERT INTO "public"."ss_child_ai" VALUES (2048039442374991874, 1002, '有些无聊不想睡觉', '<think>

</think>

你好！这是一个模拟场景。针对 ADHD 儿童“有些无聊不想睡觉”的诉求，作为“小步”，我会这样回应：

**“哎呀，小脑袋瓜是不是装满了‘未完成’的任务啦？😅 睡觉有时候就像游戏里的‘存档’，虽然现在不想关游戏，但身体正在悄悄帮你保存进度哦！🧠💾 不如我们和身体玩个‘静悄悄大赛’？🤫 看谁先像小猫咪一样软绵绵～ 晚安魔法正在加载……✨🌙"**

---
**策略解析：**
1.  **共情与正常化**：承认“不想睡”的感觉，不直接对抗，用“游戏存档”比喻，符合 ADHD 儿童对具象化和游戏化思维的偏好。
2.  **温和指令**：将“去睡觉”转化为“玩静悄悄大赛”，转移对睡眠的抗拒感。
3.  **正向期待**：使用“晚安魔法加载”增加趣味性和仪式感。', 4, NULL, 1002, '2026-04-25 22:00:28.457', 1002, '2026-04-25 22:00:28.457', '0', 200);
INSERT INTO "public"."ss_child_ai" VALUES (2048041200660783105, 1002, '有些无聊不想睡觉', '<think>

</think>

<analysis>
用户希望我以“小步”AI伙伴的身份，给一个说“有些无聊不想睡觉”的ADHD儿童一个简短、积极的回应。

让我先理解这个场景：
- 孩子情绪：平静但有些无聊
- 孩子状态：抗拒睡觉
- 我的角色：活泼、温柔、鼓励性、使用表情符号
- 需要：简短、积极

对于ADHD儿童，睡眠困难很常见。他们的大脑容易活跃，无聊时更难平静下来。回应需要：
1. 共情（理解无聊的感觉）
2. 转化（把“不想睡”变成“准备休息”）
3. 游戏化（让睡觉变得有趣）
4. 保持简短（ADHD儿童注意力短）

我可以提供几个不同风格的回应选项，然后选择一个最合适的。
</analysis>

---

## 给家长的参考建议

针对ADHD儿童睡前抗拒，可以考虑：

1. **视觉化倒计时**：用沙漏或计时器，让"还有多久"变得看得见
2. **选择权游戏**："你想先听星星故事，还是云朵故事？"——给控制感
3. **身体放松练习**：简单的渐进式肌肉放松（手-手臂-肩膀-脸）
4. **睡前"关机仪式"**：像给电脑关机一样，告诉大脑"今天的工作完成了"

---

## 给孩子的回应

```
哇～被小步抓到偷懒的小机灵鬼啦！🦊✨

无聊的时候，就是大脑在说："嘿嘿～该充电咯～"🔋

来——闭上眼睛，想象自己是一艘小船，飘进软绵绵的云朵港🌙～每数3个数，就飘远一点点～3、2、1……停泊啦～🛳️💤

明天醒来，你会发现自己偷偷长高了一点点哦！📏✨
```', 5, NULL, 1002, '2026-04-25 22:07:27.664', 1002, '2026-04-25 22:07:27.664', '0', 200);
INSERT INTO "public"."ss_child_ai" VALUES (2048044938578370561, 1002, '有些无聊不想睡觉', '<think>

</think>

你好！我是“小步”。针对孩子“有些无聊不想睡觉”的情况，结合家长建议中关于“固定程序”和“温和鼓励”的策略，我为你设计了以下回应：

***

🌟 **小步说：**

“哎呀，小脑瓜是不是觉得现在的故事讲完啦，身体还没准备好休息呢？🤔

不过呀，小床就像一个软绵绵的魔法城堡，现在城堡的大门要关上啦！🏰✨ 我们试着把身体变成一块小石头，平平静静躺好，闭上眼睛数数星星，好不好？

只要乖乖躺进被窝，小步就会一直陪着你，等你迷迷糊糊睡着的时候，悄悄给你讲一个只有你能听见的梦话故事哦！🌙💤"', 5, NULL, 1002, '2026-04-25 22:22:18.863', 1002, '2026-04-25 22:22:18.863', '0', 200);
INSERT INTO "public"."ss_child_ai" VALUES (2048054139404963841, 1002, '今天好无聊', '<think>

</think>

你好！我是“小步”，很高兴能陪伴你。针对孩子表达“今天好无聊”的情况，以下是一个简短、积极的回应建议：

---

**小步回应：**

“哇，‘无聊’小怪兽来啦！😈 不过它最怕我们动动脑筋啦～ 要不要我们一起变个魔法？🪄 比如：1️⃣ 当个‘家务侦探’找丢失的袜子；2️⃣ 用积木搭个‘秘密基地’；3️⃣ 当个‘故事导演’自编自导动画片！你选哪个？✨”

---

**设计思路说明：**
1. **情绪共情**：用“无聊小怪兽”将抽象情绪具象化，符合儿童认知
2. **行动导向**：提供具体可操作的活动选项，对应建议中的“结构化活动”
3. **自主赋能**：让孩子选择活动，呼应“培养自我管理能力”
4. **游戏化语言**：使用魔法、侦探等角色扮演元素，增强趣味性
5. **视觉化表达**：通过表情符号和编号让建议更清晰易读

这样的回应既认可了孩子的感受，又快速将注意力转向积极行动，同时保持了AI伙伴特有的活泼温暖语气。', 5, NULL, -1, '2026-04-25 22:58:52.499', -1, '2026-04-25 22:58:52.499', '0', -1);
INSERT INTO "public"."ss_child_ai" VALUES (2048275206065221633, 1002, '今天玩些什么呢', '我现在有点小情绪，等下再来找我玩吧！🌈', 5, NULL, -1, '2026-04-26 13:37:18.897', -1, '2026-04-26 13:37:18.897', '0', -1);
INSERT INTO "public"."ss_child_ai" VALUES (2048275659096190978, 1002, '你好，今天可以玩些什么', '我现在有点小情绪，等下再来找我玩吧！🌈', 5, NULL, -1, '2026-04-26 13:39:06.911', -1, '2026-04-26 13:39:06.911', '0', -1);
INSERT INTO "public"."ss_child_ai" VALUES (2048276066283417602, 1002, '你好，今天可以玩些什么', '嗨嗨！我们来玩「外星人找宝藏」游戏呀🪐 找找你身边藏着的蓝色小东东，找到就是赢啦！', 5, NULL, -1, '2026-04-26 13:40:43.988', -1, '2026-04-26 13:40:43.988', '0', -1);
INSERT INTO "public"."ss_child_ai" VALUES (2048020079441911810, 1002, '有哪些任务推荐呢', '谢谢你跟我分享！你做得很好，我们接下来要开始新的任务吗？🦖', 5, NULL, 1000, '2026-04-25 20:43:31.978', 1000, '2026-04-25 20:43:31.978', '0', 200);
INSERT INTO "public"."ss_child_ai" VALUES (2048038094732533762, 1002, '今晚有些睡不着', '<think>

</think>

**给家长的说明：**
由于家长端的"AI 解析响应异常”导致我无法获取对孩子情绪的详细分析，我将基于“孩子说睡不着”这一基本信息，以“小步”的身份提供一个通用但温暖的回应。

---

**给孩子的回应：**

"🌙 哎呀，是不是月亮今天太亮啦，把小眼睛都吸引住咯？

睡不着的时候，我们可以试着像小猫咪一样，轻轻闭上眼睛，想象自己变成一朵软绵绵的云朵，飘啊飘啊……或者数一数窗外的星星，一颗、两颗、三颗⭐️

如果心里有好多想法在乱飞，我们可以把它们写在纸上，告诉大脑‘这些明天再想，现在先休息’～

要不要一起做个‘魔法呼吸’？吸气——呼出——就像吹灭一根小蜡烛🕯️ 慢慢来，不着急，小步会一直陪着你……✨💤"', 4, NULL, 1002, '2026-04-25 21:55:07.162', 1002, '2026-04-25 21:55:07.162', '0', 200);
INSERT INTO "public"."ss_child_ai" VALUES (2048272588064550913, 1002, '你好，今天可以玩些什么', '我现在有点小情绪，等下再来找我玩吧！🌈', 5, NULL, -1, '2026-04-26 13:26:54.723', -1, '2026-04-26 13:26:54.723', '0', -1);
INSERT INTO "public"."ss_child_ai" VALUES (7120354, 10001, '心情记录1', 'AI鼓励1', 1, NULL, 10001, '2026-04-25 19:24:13.045201', NULL, NULL, '0', NULL);
INSERT INTO "public"."ss_child_ai" VALUES (7120355, 10001, '心情记录2', 'AI鼓励2', 1, NULL, 10001, '2026-04-25 18:24:13.045201', NULL, NULL, '0', NULL);
INSERT INTO "public"."ss_child_ai" VALUES (7120454, 10001, '心情记录1', 'AI鼓励1', 5, NULL, 10001, '2026-04-24 19:24:13.045201', NULL, NULL, '0', NULL);
INSERT INTO "public"."ss_child_ai" VALUES (7120455, 10001, '心情记录2', 'AI鼓励2', 1, NULL, 10001, '2026-04-24 18:24:13.045201', NULL, NULL, '0', NULL);
INSERT INTO "public"."ss_child_ai" VALUES (7120554, 10001, '心情记录1', 'AI鼓励1', 3, NULL, 10001, '2026-04-23 19:24:13.045201', NULL, NULL, '0', NULL);
INSERT INTO "public"."ss_child_ai" VALUES (7120555, 10001, '心情记录2', 'AI鼓励2', 5, NULL, 10001, '2026-04-23 18:24:13.045201', NULL, NULL, '0', NULL);
INSERT INTO "public"."ss_child_ai" VALUES (7120654, 10001, '心情记录1', 'AI鼓励1', 5, NULL, 10001, '2026-04-22 19:24:13.045201', NULL, NULL, '0', NULL);
INSERT INTO "public"."ss_child_ai" VALUES (7120655, 10001, '心情记录2', 'AI鼓励2', 3, NULL, 10001, '2026-04-22 18:24:13.045201', NULL, NULL, '0', NULL);
INSERT INTO "public"."ss_child_ai" VALUES (7120754, 10001, '心情记录1', 'AI鼓励1', 5, NULL, 10001, '2026-04-21 19:24:13.045201', NULL, NULL, '0', NULL);
INSERT INTO "public"."ss_child_ai" VALUES (7120755, 10001, '心情记录2', 'AI鼓励2', 3, NULL, 10001, '2026-04-21 18:24:13.045201', NULL, NULL, '0', NULL);
INSERT INTO "public"."ss_child_ai" VALUES (7120854, 10001, '心情记录1', 'AI鼓励1', 5, NULL, 10001, '2026-04-20 19:24:13.045201', NULL, NULL, '0', NULL);
INSERT INTO "public"."ss_child_ai" VALUES (7120855, 10001, '心情记录2', 'AI鼓励2', 5, NULL, 10001, '2026-04-20 18:24:13.045201', NULL, NULL, '0', NULL);
INSERT INTO "public"."ss_child_ai" VALUES (7120954, 10001, '心情记录1', 'AI鼓励1', 3, NULL, 10001, '2026-04-19 19:24:13.045201', NULL, NULL, '0', NULL);
INSERT INTO "public"."ss_child_ai" VALUES (7120955, 10001, '心情记录2', 'AI鼓励2', 5, NULL, 10001, '2026-04-19 18:24:13.045201', NULL, NULL, '0', NULL);
INSERT INTO "public"."ss_child_ai" VALUES (7121054, 10001, '心情记录1', 'AI鼓励1', 1, NULL, 10001, '2026-04-18 19:24:13.045201', NULL, NULL, '0', NULL);
INSERT INTO "public"."ss_child_ai" VALUES (7121055, 10001, '心情记录2', 'AI鼓励2', 5, NULL, 10001, '2026-04-18 18:24:13.045201', NULL, NULL, '0', NULL);
INSERT INTO "public"."ss_child_ai" VALUES (7121154, 10001, '心情记录1', 'AI鼓励1', 5, NULL, 10001, '2026-04-17 19:24:13.045201', NULL, NULL, '0', NULL);
INSERT INTO "public"."ss_child_ai" VALUES (7121155, 10001, '心情记录2', 'AI鼓励2', 4, NULL, 10001, '2026-04-17 18:24:13.045201', NULL, NULL, '0', NULL);
INSERT INTO "public"."ss_child_ai" VALUES (7121254, 10001, '心情记录1', 'AI鼓励1', 1, NULL, 10001, '2026-04-16 19:24:13.045201', NULL, NULL, '0', NULL);
INSERT INTO "public"."ss_child_ai" VALUES (7121255, 10001, '心情记录2', 'AI鼓励2', 5, NULL, 10001, '2026-04-16 18:24:13.045201', NULL, NULL, '0', NULL);
INSERT INTO "public"."ss_child_ai" VALUES (7121354, 10001, '心情记录1', 'AI鼓励1', 2, NULL, 10001, '2026-04-15 19:24:13.045201', NULL, NULL, '0', NULL);
INSERT INTO "public"."ss_child_ai" VALUES (7121355, 10001, '心情记录2', 'AI鼓励2', 5, NULL, 10001, '2026-04-15 18:24:13.045201', NULL, NULL, '0', NULL);
INSERT INTO "public"."ss_child_ai" VALUES (7121454, 10001, '心情记录1', 'AI鼓励1', 1, NULL, 10001, '2026-04-14 19:24:13.045201', NULL, NULL, '0', NULL);
INSERT INTO "public"."ss_child_ai" VALUES (7121455, 10001, '心情记录2', 'AI鼓励2', 1, NULL, 10001, '2026-04-14 18:24:13.045201', NULL, NULL, '0', NULL);
INSERT INTO "public"."ss_child_ai" VALUES (7121554, 10001, '心情记录1', 'AI鼓励1', 1, NULL, 10001, '2026-04-13 19:24:13.045201', NULL, NULL, '0', NULL);
INSERT INTO "public"."ss_child_ai" VALUES (7121555, 10001, '心情记录2', 'AI鼓励2', 1, NULL, 10001, '2026-04-13 18:24:13.045201', NULL, NULL, '0', NULL);
INSERT INTO "public"."ss_child_ai" VALUES (7121654, 10001, '心情记录1', 'AI鼓励1', 3, NULL, 10001, '2026-04-12 19:24:13.045201', NULL, NULL, '0', NULL);
INSERT INTO "public"."ss_child_ai" VALUES (7121655, 10001, '心情记录2', 'AI鼓励2', 3, NULL, 10001, '2026-04-12 18:24:13.045201', NULL, NULL, '0', NULL);
INSERT INTO "public"."ss_child_ai" VALUES (7121754, 10001, '心情记录1', 'AI鼓励1', 5, NULL, 10001, '2026-04-11 19:24:13.045201', NULL, NULL, '0', NULL);
INSERT INTO "public"."ss_child_ai" VALUES (7121755, 10001, '心情记录2', 'AI鼓励2', 1, NULL, 10001, '2026-04-11 18:24:13.045201', NULL, NULL, '0', NULL);
INSERT INTO "public"."ss_child_ai" VALUES (7121854, 10001, '心情记录1', 'AI鼓励1', 3, NULL, 10001, '2026-04-10 19:24:13.045201', NULL, NULL, '0', NULL);
INSERT INTO "public"."ss_child_ai" VALUES (7121855, 10001, '心情记录2', 'AI鼓励2', 3, NULL, 10001, '2026-04-10 18:24:13.045201', NULL, NULL, '0', NULL);
INSERT INTO "public"."ss_child_ai" VALUES (7121954, 10001, '心情记录1', 'AI鼓励1', 1, NULL, 10001, '2026-04-09 19:24:13.045201', NULL, NULL, '0', NULL);
INSERT INTO "public"."ss_child_ai" VALUES (7121955, 10001, '心情记录2', 'AI鼓励2', 5, NULL, 10001, '2026-04-09 18:24:13.045201', NULL, NULL, '0', NULL);
INSERT INTO "public"."ss_child_ai" VALUES (7122054, 10001, '心情记录1', 'AI鼓励1', 1, NULL, 10001, '2026-04-08 19:24:13.045201', NULL, NULL, '0', NULL);
INSERT INTO "public"."ss_child_ai" VALUES (7122055, 10001, '心情记录2', 'AI鼓励2', 3, NULL, 10001, '2026-04-08 18:24:13.045201', NULL, NULL, '0', NULL);
INSERT INTO "public"."ss_child_ai" VALUES (7122154, 10001, '心情记录1', 'AI鼓励1', 1, NULL, 10001, '2026-04-07 19:24:13.045201', NULL, NULL, '0', NULL);
INSERT INTO "public"."ss_child_ai" VALUES (7122155, 10001, '心情记录2', 'AI鼓励2', 3, NULL, 10001, '2026-04-07 18:24:13.045201', NULL, NULL, '0', NULL);
INSERT INTO "public"."ss_child_ai" VALUES (7122254, 10001, '心情记录1', 'AI鼓励1', 5, NULL, 10001, '2026-04-06 19:24:13.045201', NULL, NULL, '0', NULL);
INSERT INTO "public"."ss_child_ai" VALUES (7122255, 10001, '心情记录2', 'AI鼓励2', 3, NULL, 10001, '2026-04-06 18:24:13.045201', NULL, NULL, '0', NULL);
INSERT INTO "public"."ss_child_ai" VALUES (7122354, 10001, '心情记录1', 'AI鼓励1', 5, NULL, 10001, '2026-04-05 19:24:13.045201', NULL, NULL, '0', NULL);
INSERT INTO "public"."ss_child_ai" VALUES (7122355, 10001, '心情记录2', 'AI鼓励2', 4, NULL, 10001, '2026-04-05 18:24:13.045201', NULL, NULL, '0', NULL);
INSERT INTO "public"."ss_child_ai" VALUES (7122454, 10001, '心情记录1', 'AI鼓励1', 4, NULL, 10001, '2026-04-04 19:24:13.045201', NULL, NULL, '0', NULL);
INSERT INTO "public"."ss_child_ai" VALUES (7122455, 10001, '心情记录2', 'AI鼓励2', 3, NULL, 10001, '2026-04-04 18:24:13.045201', NULL, NULL, '0', NULL);
INSERT INTO "public"."ss_child_ai" VALUES (7122554, 10001, '心情记录1', 'AI鼓励1', 4, NULL, 10001, '2026-04-03 19:24:13.045201', NULL, NULL, '0', NULL);
INSERT INTO "public"."ss_child_ai" VALUES (7122555, 10001, '心情记录2', 'AI鼓励2', 1, NULL, 10001, '2026-04-03 18:24:13.045201', NULL, NULL, '0', NULL);
INSERT INTO "public"."ss_child_ai" VALUES (7122654, 10001, '心情记录1', 'AI鼓励1', 5, NULL, 10001, '2026-04-02 19:24:13.045201', NULL, NULL, '0', NULL);
INSERT INTO "public"."ss_child_ai" VALUES (7122655, 10001, '心情记录2', 'AI鼓励2', 5, NULL, 10001, '2026-04-02 18:24:13.045201', NULL, NULL, '0', NULL);
INSERT INTO "public"."ss_child_ai" VALUES (7122754, 10001, '心情记录1', 'AI鼓励1', 5, NULL, 10001, '2026-04-01 19:24:13.045201', NULL, NULL, '0', NULL);
INSERT INTO "public"."ss_child_ai" VALUES (7122755, 10001, '心情记录2', 'AI鼓励2', 3, NULL, 10001, '2026-04-01 18:24:13.045201', NULL, NULL, '0', NULL);
INSERT INTO "public"."ss_child_ai" VALUES (7122854, 10001, '心情记录1', 'AI鼓励1', 5, NULL, 10001, '2026-03-31 19:24:13.045201', NULL, NULL, '0', NULL);
INSERT INTO "public"."ss_child_ai" VALUES (7122855, 10001, '心情记录2', 'AI鼓励2', 3, NULL, 10001, '2026-03-31 18:24:13.045201', NULL, NULL, '0', NULL);
INSERT INTO "public"."ss_child_ai" VALUES (7122954, 10001, '心情记录1', 'AI鼓励1', 3, NULL, 10001, '2026-03-30 19:24:13.045201', NULL, NULL, '0', NULL);
INSERT INTO "public"."ss_child_ai" VALUES (7122955, 10001, '心情记录2', 'AI鼓励2', 5, NULL, 10001, '2026-03-30 18:24:13.045201', NULL, NULL, '0', NULL);
INSERT INTO "public"."ss_child_ai" VALUES (7123054, 10001, '心情记录1', 'AI鼓励1', 1, NULL, 10001, '2026-03-29 19:24:13.045201', NULL, NULL, '0', NULL);
INSERT INTO "public"."ss_child_ai" VALUES (7123055, 10001, '心情记录2', 'AI鼓励2', 3, NULL, 10001, '2026-03-29 18:24:13.045201', NULL, NULL, '0', NULL);
INSERT INTO "public"."ss_child_ai" VALUES (7123154, 10001, '心情记录1', 'AI鼓励1', 3, NULL, 10001, '2026-03-28 19:24:13.045201', NULL, NULL, '0', NULL);
INSERT INTO "public"."ss_child_ai" VALUES (7123155, 10001, '心情记录2', 'AI鼓励2', 3, NULL, 10001, '2026-03-28 18:24:13.045201', NULL, NULL, '0', NULL);
INSERT INTO "public"."ss_child_ai" VALUES (7123254, 10001, '心情记录1', 'AI鼓励1', 3, NULL, 10001, '2026-03-27 19:24:13.045201', NULL, NULL, '0', NULL);
INSERT INTO "public"."ss_child_ai" VALUES (7123255, 10001, '心情记录2', 'AI鼓励2', 4, NULL, 10001, '2026-03-27 18:24:13.045201', NULL, NULL, '0', NULL);
INSERT INTO "public"."ss_child_ai" VALUES (7123354, 10001, '心情记录1', 'AI鼓励1', 5, NULL, 10001, '2026-03-26 19:24:13.045201', NULL, NULL, '0', NULL);
INSERT INTO "public"."ss_child_ai" VALUES (7123355, 10001, '心情记录2', 'AI鼓励2', 3, NULL, 10001, '2026-03-26 18:24:13.045201', NULL, NULL, '0', NULL);
INSERT INTO "public"."ss_child_ai" VALUES (2048055366951915522, 1, '今天好无聊', '<think>

</think>

你好！我是小步 AI，我已经完全理解了你的要求。让我来回应这个ADHD儿童：

---

**小步的回应：**

"哇，''无聊''这个信号出现啦！🚩 这其实是大脑在悄悄说：''嘿，我们需要新的冒险了！'' 🎈

你知道吗？无聊其实是创造力的超级燃料⚡ 历史上好多伟大的发明家、画家、作家都是在''无聊''的时候想出了绝妙的点子呢！

今天我们可以一起：
🎨 用''无聊时间''变成''创作时间''——随便画点什么？
⏰ 或者用计时器玩个''专注挑战''游戏？
🎭 甚至可以是即兴角色扮演——你当导演，我来当演员！

记住哦，无聊不是''没意思''，它是''可能性满满''的信号！✨ 你今天想先尝试哪种冒险呢？🚀"

---

**设计思路说明：**
- 用"冒险"、"信号"、"燃料"等比喻将无聊重构为积极体验
- 提供具体可操作的活动选项（呼应给家长的建议）
- 保持短小精悍，避免让ADHD儿童感到 overwhelmed
- 使用表情符号增加亲和力和视觉锚点
- 以提问结束，给予孩子掌控感', 5, NULL, -1, '2026-04-25 23:03:45.169', -1, '2026-04-25 23:03:45.169', '0', -1);
INSERT INTO "public"."ss_child_ai" VALUES (2048055844016246785, 1, '专注挑战游戏，你可以设计游戏我们玩吗？', '<think>

</think>

<analysis>
让我分析这个任务：

1. **角色定位**：我是"小步"，一个陪伴ADHD儿童的AI伙伴
2. **语气要求**：活泼、温柔、富有鼓励性，多用表情符号
3. **当前情境**：孩子情绪开心，主动提议设计游戏
4. **需要输出**：简短、积极的回应给孩子

根据给定的建议，我需要：
- 肯定孩子的主动性（抓住积极时刻给予表扬）
- 将"挑战"转化为合作框架
- 保持对话的趣味性和参与感

让我构思合适的回应。
</analysis>

---

**小步的回应：**

哇！🌟 小设计师上线啦！"你可以设计游戏我们玩吗？"——这句话太有创意了！🎮

小步最喜欢和你一起玩游戏啦！✨ 你可以想任何规则、任何关卡，小步会超级认真地参与！🎯

那我们要先决定——是冒险闯关模式，还是创意建造模式？或者你想发明一个全新的游戏类型？🚀 快告诉我，游戏马上开始！🎪

---

这个回应体现了：
- ✅ 立即肯定孩子的主动性（"太有创意了"）
- ✅ 使用合作框架（"小步会和你一起"）
- ✅ 提供选择，保持高参与度
- ✅ 活泼的语气和丰富的表情符号
- ✅ 简短但不失温暖鼓励', 1, NULL, -1, '2026-04-25 23:05:38.91', -1, '2026-04-25 23:05:38.91', '0', -1);
INSERT INTO "public"."ss_child_ai" VALUES (2048304394864287746, 1002, '你好', '你好呀👋！我是小步，超开心见到你😊，今天我们一起做点好玩的好不好😜？', 1, NULL, -1, '2026-04-26 15:33:18.051', -1, '2026-04-26 15:33:18.051', '0', -1);
INSERT INTO "public"."ss_child_ai" VALUES (2048306210016456705, 1002, '你好呀小步！', '嗨你好呀😆！太开心见到你啦🥳，今天有没有什么有趣的小事想跟我聊聊呀？', 5, NULL, -1, '2026-04-26 15:40:30.815', -1, '2026-04-26 15:40:30.815', '0', -1);
INSERT INTO "public"."ss_child_ai" VALUES (2048306522773123074, 1002, 'test', '哇！信号我成功收到啦😆👋！你有没有什么好玩的想和我分享呀🥰', 5, NULL, -1, '2026-04-26 15:41:45.386', -1, '2026-04-26 15:41:45.386', '0', -1);
INSERT INTO "public"."ss_child_ai" VALUES (2048307090996449282, 1002, 'Hello', '哈喽哈喽👋！你好呀😆真开心收到你的问候～今天有什么好玩的小事要和我分享吗🥳', 1, NULL, -1, '2026-04-26 15:44:00.857', -1, '2026-04-26 15:44:00.857', '0', -1);
INSERT INTO "public"."ss_child_ai" VALUES (2048307271032754178, 1002, 'Hi', 'Hi你好呀👋！真开心你来找我玩～今天有什么好玩的想分享给我吗🥳', 1, NULL, -1, '2026-04-26 15:44:43.782', -1, '2026-04-26 15:44:43.782', '0', -1);
INSERT INTO "public"."ss_child_ai" VALUES (2049709720138223618, 1002, '我今天很难过，数学作业太难了，我怎么都做不对。', '我现在有点小情绪，等下再来找我玩吧！🌈', 5, NULL, -1, '2026-04-30 12:37:33.709', -1, '2026-04-30 12:37:33.709', '0', -1);
INSERT INTO "public"."ss_child_ai" VALUES (2049710096845443073, 1002, '我今天很难过，数学作业太难了，我怎么都做不对。', '我现在有点小情绪，等下再来找我玩吧！🌈', 5, NULL, -1, '2026-04-30 12:39:03.518', -1, '2026-04-30 12:39:03.518', '0', -1);
INSERT INTO "public"."ss_child_ai" VALUES (2049710320896774146, 1002, '我今天很难过，数学作业太难了，我怎么都做不对。', '我现在有点小情绪，等下再来找我玩吧！🌈', 5, NULL, -1, '2026-04-30 12:39:56.936', -1, '2026-04-30 12:39:56.936', '0', -1);
INSERT INTO "public"."ss_child_ai" VALUES (2049710770563911682, 1002, '我今天很难过，数学作业太难了，我怎么都做不对。', '我现在有点小情绪，等下再来找我玩吧！🌈', 5, NULL, -1, '2026-04-30 12:41:44.145', -1, '2026-04-30 12:41:44.145', '0', -1);
INSERT INTO "public"."ss_child_ai" VALUES (2050521681084141570, 1002, '我今天很难过，数学作业太难了，我怎么都做不对。', '我现在有点小情绪，等下再来找我玩吧！🌈', 5, NULL, -1, '2026-05-02 18:24:00.283', -1, '2026-05-02 18:24:00.283', '0', -1);
INSERT INTO "public"."ss_child_ai" VALUES (2050532813639372802, 1002, '我今天很难过，数学作业太难了，我怎么都做不对。', '我现在有点小情绪，等下再来找我玩吧！🌈', 5, NULL, -1, '2026-05-02 19:08:14.493', -1, '2026-05-02 19:08:14.493', '0', -1);
INSERT INTO "public"."ss_child_ai" VALUES (2050848499972440066, 1002, '今天上课好累 ', '我现在有点小情绪，等下再来找我玩吧！🌈', 5, NULL, -1, '2026-05-03 16:02:39.978', -1, '2026-05-03 16:02:39.978', '0', -1);
INSERT INTO "public"."ss_child_ai" VALUES (2050848648752791553, 1002, '今天上课太累了', '我现在有点小情绪，等下再来找我玩吧！🌈', 5, NULL, -1, '2026-05-03 16:03:15.445', -1, '2026-05-03 16:03:15.445', '0', -1);
INSERT INTO "public"."ss_child_ai" VALUES (2052745151251607554, 2035392423676469250, '[家长模式] 我现在压力很大，孩子总是不听话，我想放弃了。', '你好。听到你说“我想放弃了”，我心里真的非常紧了一下，但我更想隔着屏幕给你一个大大的、长长的拥抱。

请先深呼吸，告诉我，你现在的这种“想放弃”的感觉，并不是因为你不爱孩子，而是因为你**太累了，太需要休息了**，对吗？

作为家长，面对 ADHD 孩子的挑战，这种“想放弃”的念头其实是很多资深家长的“必经之路”。这就像是一个长跑运动员，跑到了极点，双腿灌铅，只想倒在路边。**这不代表你是个失败的父母，这仅仅代表你的能量耗尽了，你需要停一停。**

在我们谈论怎么“管教”孩子之前，我想先和你分享几个视角的转换，希望能给你一点点力量：

### 1. 重新理解“不听话”：这不是态度问题，是能力问题

很多 ADHD 孩子被贴上“叛逆”、“没礼貌”、“故意气人”的标签，这会让家长感到愤怒。但作为专家，我想告诉你一个科学事实：**ADHD 孩子的前额叶（负责控制冲动和执行功能的区域）发育通常比同龄人慢 30% 左右。**

*   **当他不听话时：** 他不是故意想反抗你，而是他的大脑里没有“刹车片”。当你在喊指令时，他可能正处于发呆、兴奋或者被其他琐事吸引的状态，他的大脑根本没有接收到指令，或者接收到指令后无法迅速转化为行动。
*   **这就像：** 你让他去关灯，但他大脑里正在“思考”为什么灯是黄色的，他就动不了。

**请试着把“他在跟我作对”这句话，换成“他的大脑还在努力工作，只是暂时卡住了”。** 这种心态的转变，能帮你从“愤怒的审判官”变成“耐心的工程师”。

### 2. 给你的“急救包”：三个科学、可操作的干预建议

既然我们现在需要调整策略，这里有三条不需要你消耗太多情绪，但能产生效果的“小锦囊”：

*   **策略一：指令“颗粒度”要变小（化整为零）**
    ADHD 孩子很难处理复杂的指令。
    *   ❌ **错误做法：** “你怎么还不去写作业？房间乱成什么样了？快收拾好！”（这像是一团乱麻，他根本不知道从哪里开始）
    *   ✅ **正确做法：** “孩子，现在请你先坐到书桌前。”（只给一个动作，等他做了，再给下一个）“现在，请打开语文书。”

*   **策略二：利用“视觉化”代替“口头唠叨”**
    口头唠叨会不断刺激你焦虑的大脑，也会让孩子产生“听觉屏蔽”。
    *   **建议：** 把任务写在便签纸上，贴在显眼的地方，或者用计时器（沙漏或倒计时器）。让他自己看着时间或纸条行动，而不是你像个监工一样在后面追着喊。

*   **策略三：先连接，后纠正（情感优先）**
    当孩子出现“不听话”的行为时，他的情绪脑是上线的，这时候讲道理是没用的。
    *   **建议：** 试着蹲下来，平视他的眼睛，问一句：“我看到你现在很难过/很兴奋，发生什么事了？” 先接纳他的情绪，建立连接，他的理智脑才会慢慢回来，这时候再谈规则。

### 3. 请一定要关注你自己：你是孩子的“充电宝”

这是最重要的一点。**如果你是一块漏电的电池，你永远无法给手机充电。**

ADHD 孩子的父母，往往背负着巨大的心理压力。当你感到想放弃的时候，请允许自己“暂停”。

*   **给自己设定“暂停时间”：** 如果孩子让你崩溃，深呼吸，告诉他：“妈妈/爸爸现在情绪不好，需要冷静 5 分钟，我们 5 分钟后再谈。”然后离开那个房间，喝杯水，去阳台看看风景。
*   **接受“60 分妈妈”：** 这个世界上没有完美的父母。哪怕今天你只做到了 60 分，只要孩子安全、健康，你就已经很棒了。不要追求 100 分，那样会毁了你。

亲爱的家长，这条路确实很难走，布满荆棘。但请相信，你现在的每一次忍耐、每一次调整，都在为孩子的大脑建立新的神经连接。

**你不需要现在就解决所有问题，你只需要照顾好自己，然后陪孩子慢慢走。**

如果你愿意，可以跟我具体说说，最近哪一件事最让你感到崩溃？我们可以一起拆解它。我在这里听着。', 4, NULL, -1, '2026-05-08 21:39:16.887', -1, '2026-05-08 21:39:16.887', '0', -1);

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
  "obtain_time" timestamp(6),
  "create_dept" int8,
  "create_by" int8,
  "create_time" timestamp(6),
  "update_by" int8,
  "update_time" timestamp(6),
  "del_flag" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar
)
;
COMMENT ON COLUMN "public"."ss_child_item"."create_dept" IS '创建部门';
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
INSERT INTO "public"."ss_child_score" VALUES (1002, 0, 0, '2026-04-25 17:02:17.486');
INSERT INTO "public"."ss_child_score" VALUES (1, 0, 0, '2026-05-08 18:28:20.334');
INSERT INTO "public"."ss_child_score" VALUES (1003, 0, 0, '2026-05-09 00:10:20.042');
INSERT INTO "public"."ss_child_score" VALUES (10001, 0, 0, '2026-05-11 19:41:31.59');
INSERT INTO "public"."ss_child_score" VALUES (10002, 0, 0, '2026-05-11 19:41:32.371');

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
  "create_time" timestamp(6),
  "create_dept" int8,
  "create_by" int8,
  "update_by" int8,
  "update_time" timestamp(6),
  "del_flag" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar
)
;
COMMENT ON COLUMN "public"."ss_device_log"."create_dept" IS '创建部门';
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
INSERT INTO "public"."ss_emotion_record" VALUES (7120854, '000000', 10001, 3, 'type1', '日常记录1', '', '', '0', '2026-04-25 00:00:00', '2026-04-25 20:24:13.045201');
INSERT INTO "public"."ss_emotion_record" VALUES (7120855, '000000', 10001, 3, 'type1', '日常记录2', '', '', '0', '2026-04-25 00:00:00', '2026-04-25 20:24:13.045201');
INSERT INTO "public"."ss_emotion_record" VALUES (7120954, '000000', 10001, 3, 'type5', '日常记录1', '', '', '0', '2026-04-24 00:00:00', '2026-04-24 20:24:13.045201');
INSERT INTO "public"."ss_emotion_record" VALUES (7120955, '000000', 10001, 3, 'type1', '日常记录2', '', '', '0', '2026-04-24 00:00:00', '2026-04-24 20:24:13.045201');
INSERT INTO "public"."ss_emotion_record" VALUES (7121054, '000000', 10001, 3, 'type3', '日常记录1', '', '', '0', '2026-04-23 00:00:00', '2026-04-23 20:24:13.045201');
INSERT INTO "public"."ss_emotion_record" VALUES (7121055, '000000', 10001, 3, 'type5', '日常记录2', '', '', '0', '2026-04-23 00:00:00', '2026-04-23 20:24:13.045201');
INSERT INTO "public"."ss_emotion_record" VALUES (7121154, '000000', 10001, 3, 'type5', '日常记录1', '', '', '0', '2026-04-22 00:00:00', '2026-04-22 20:24:13.045201');
INSERT INTO "public"."ss_emotion_record" VALUES (7121155, '000000', 10001, 3, 'type3', '日常记录2', '', '', '0', '2026-04-22 00:00:00', '2026-04-22 20:24:13.045201');
INSERT INTO "public"."ss_emotion_record" VALUES (7121254, '000000', 10001, 3, 'type5', '日常记录1', '', '', '0', '2026-04-21 00:00:00', '2026-04-21 20:24:13.045201');
INSERT INTO "public"."ss_emotion_record" VALUES (7121255, '000000', 10001, 3, 'type3', '日常记录2', '', '', '0', '2026-04-21 00:00:00', '2026-04-21 20:24:13.045201');
INSERT INTO "public"."ss_emotion_record" VALUES (7121354, '000000', 10001, 3, 'type5', '日常记录1', '', '', '0', '2026-04-20 00:00:00', '2026-04-20 20:24:13.045201');
INSERT INTO "public"."ss_emotion_record" VALUES (7121355, '000000', 10001, 3, 'type5', '日常记录2', '', '', '0', '2026-04-20 00:00:00', '2026-04-20 20:24:13.045201');
INSERT INTO "public"."ss_emotion_record" VALUES (7121454, '000000', 10001, 3, 'type3', '日常记录1', '', '', '0', '2026-04-19 00:00:00', '2026-04-19 20:24:13.045201');
INSERT INTO "public"."ss_emotion_record" VALUES (7121455, '000000', 10001, 3, 'type5', '日常记录2', '', '', '0', '2026-04-19 00:00:00', '2026-04-19 20:24:13.045201');
INSERT INTO "public"."ss_emotion_record" VALUES (7121554, '000000', 10001, 3, 'type1', '日常记录1', '', '', '0', '2026-04-18 00:00:00', '2026-04-18 20:24:13.045201');
INSERT INTO "public"."ss_emotion_record" VALUES (7121555, '000000', 10001, 3, 'type5', '日常记录2', '', '', '0', '2026-04-18 00:00:00', '2026-04-18 20:24:13.045201');
INSERT INTO "public"."ss_emotion_record" VALUES (7121654, '000000', 10001, 3, 'type5', '日常记录1', '', '', '0', '2026-04-17 00:00:00', '2026-04-17 20:24:13.045201');
INSERT INTO "public"."ss_emotion_record" VALUES (7121655, '000000', 10001, 3, 'type4', '日常记录2', '', '', '0', '2026-04-17 00:00:00', '2026-04-17 20:24:13.045201');
INSERT INTO "public"."ss_emotion_record" VALUES (7121754, '000000', 10001, 3, 'type1', '日常记录1', '', '', '0', '2026-04-16 00:00:00', '2026-04-16 20:24:13.045201');
INSERT INTO "public"."ss_emotion_record" VALUES (7121755, '000000', 10001, 3, 'type5', '日常记录2', '', '', '0', '2026-04-16 00:00:00', '2026-04-16 20:24:13.045201');
INSERT INTO "public"."ss_emotion_record" VALUES (7121854, '000000', 10001, 3, 'type2', '日常记录1', '', '', '0', '2026-04-15 00:00:00', '2026-04-15 20:24:13.045201');
INSERT INTO "public"."ss_emotion_record" VALUES (7121855, '000000', 10001, 3, 'type5', '日常记录2', '', '', '0', '2026-04-15 00:00:00', '2026-04-15 20:24:13.045201');
INSERT INTO "public"."ss_emotion_record" VALUES (7121954, '000000', 10001, 3, 'type1', '日常记录1', '', '', '0', '2026-04-14 00:00:00', '2026-04-14 20:24:13.045201');
INSERT INTO "public"."ss_emotion_record" VALUES (7121955, '000000', 10001, 3, 'type1', '日常记录2', '', '', '0', '2026-04-14 00:00:00', '2026-04-14 20:24:13.045201');
INSERT INTO "public"."ss_emotion_record" VALUES (7122054, '000000', 10001, 3, 'type1', '日常记录1', '', '', '0', '2026-04-13 00:00:00', '2026-04-13 20:24:13.045201');
INSERT INTO "public"."ss_emotion_record" VALUES (7122055, '000000', 10001, 3, 'type1', '日常记录2', '', '', '0', '2026-04-13 00:00:00', '2026-04-13 20:24:13.045201');
INSERT INTO "public"."ss_emotion_record" VALUES (7122154, '000000', 10001, 3, 'type3', '日常记录1', '', '', '0', '2026-04-12 00:00:00', '2026-04-12 20:24:13.045201');
INSERT INTO "public"."ss_emotion_record" VALUES (7122155, '000000', 10001, 3, 'type3', '日常记录2', '', '', '0', '2026-04-12 00:00:00', '2026-04-12 20:24:13.045201');
INSERT INTO "public"."ss_emotion_record" VALUES (7122254, '000000', 10001, 3, 'type5', '日常记录1', '', '', '0', '2026-04-11 00:00:00', '2026-04-11 20:24:13.045201');
INSERT INTO "public"."ss_emotion_record" VALUES (7122255, '000000', 10001, 3, 'type1', '日常记录2', '', '', '0', '2026-04-11 00:00:00', '2026-04-11 20:24:13.045201');
INSERT INTO "public"."ss_emotion_record" VALUES (7122354, '000000', 10001, 3, 'type3', '日常记录1', '', '', '0', '2026-04-10 00:00:00', '2026-04-10 20:24:13.045201');
INSERT INTO "public"."ss_emotion_record" VALUES (7122355, '000000', 10001, 3, 'type3', '日常记录2', '', '', '0', '2026-04-10 00:00:00', '2026-04-10 20:24:13.045201');
INSERT INTO "public"."ss_emotion_record" VALUES (7122454, '000000', 10001, 3, 'type1', '日常记录1', '', '', '0', '2026-04-09 00:00:00', '2026-04-09 20:24:13.045201');
INSERT INTO "public"."ss_emotion_record" VALUES (7122455, '000000', 10001, 3, 'type5', '日常记录2', '', '', '0', '2026-04-09 00:00:00', '2026-04-09 20:24:13.045201');
INSERT INTO "public"."ss_emotion_record" VALUES (7122554, '000000', 10001, 3, 'type1', '日常记录1', '', '', '0', '2026-04-08 00:00:00', '2026-04-08 20:24:13.045201');
INSERT INTO "public"."ss_emotion_record" VALUES (7122555, '000000', 10001, 3, 'type3', '日常记录2', '', '', '0', '2026-04-08 00:00:00', '2026-04-08 20:24:13.045201');
INSERT INTO "public"."ss_emotion_record" VALUES (7122654, '000000', 10001, 3, 'type1', '日常记录1', '', '', '0', '2026-04-07 00:00:00', '2026-04-07 20:24:13.045201');
INSERT INTO "public"."ss_emotion_record" VALUES (7122655, '000000', 10001, 3, 'type3', '日常记录2', '', '', '0', '2026-04-07 00:00:00', '2026-04-07 20:24:13.045201');
INSERT INTO "public"."ss_emotion_record" VALUES (7122754, '000000', 10001, 3, 'type5', '日常记录1', '', '', '0', '2026-04-06 00:00:00', '2026-04-06 20:24:13.045201');
INSERT INTO "public"."ss_emotion_record" VALUES (7122755, '000000', 10001, 3, 'type3', '日常记录2', '', '', '0', '2026-04-06 00:00:00', '2026-04-06 20:24:13.045201');
INSERT INTO "public"."ss_emotion_record" VALUES (7122854, '000000', 10001, 3, 'type5', '日常记录1', '', '', '0', '2026-04-05 00:00:00', '2026-04-05 20:24:13.045201');
INSERT INTO "public"."ss_emotion_record" VALUES (7122855, '000000', 10001, 3, 'type4', '日常记录2', '', '', '0', '2026-04-05 00:00:00', '2026-04-05 20:24:13.045201');
INSERT INTO "public"."ss_emotion_record" VALUES (7122954, '000000', 10001, 3, 'type4', '日常记录1', '', '', '0', '2026-04-04 00:00:00', '2026-04-04 20:24:13.045201');
INSERT INTO "public"."ss_emotion_record" VALUES (7122955, '000000', 10001, 3, 'type3', '日常记录2', '', '', '0', '2026-04-04 00:00:00', '2026-04-04 20:24:13.045201');
INSERT INTO "public"."ss_emotion_record" VALUES (7123054, '000000', 10001, 3, 'type4', '日常记录1', '', '', '0', '2026-04-03 00:00:00', '2026-04-03 20:24:13.045201');
INSERT INTO "public"."ss_emotion_record" VALUES (7123055, '000000', 10001, 3, 'type1', '日常记录2', '', '', '0', '2026-04-03 00:00:00', '2026-04-03 20:24:13.045201');
INSERT INTO "public"."ss_emotion_record" VALUES (7123154, '000000', 10001, 3, 'type5', '日常记录1', '', '', '0', '2026-04-02 00:00:00', '2026-04-02 20:24:13.045201');
INSERT INTO "public"."ss_emotion_record" VALUES (7123155, '000000', 10001, 3, 'type5', '日常记录2', '', '', '0', '2026-04-02 00:00:00', '2026-04-02 20:24:13.045201');
INSERT INTO "public"."ss_emotion_record" VALUES (7123254, '000000', 10001, 3, 'type5', '日常记录1', '', '', '0', '2026-04-01 00:00:00', '2026-04-01 20:24:13.045201');
INSERT INTO "public"."ss_emotion_record" VALUES (7123255, '000000', 10001, 3, 'type3', '日常记录2', '', '', '0', '2026-04-01 00:00:00', '2026-04-01 20:24:13.045201');
INSERT INTO "public"."ss_emotion_record" VALUES (7123354, '000000', 10001, 3, 'type5', '日常记录1', '', '', '0', '2026-03-31 00:00:00', '2026-03-31 20:24:13.045201');
INSERT INTO "public"."ss_emotion_record" VALUES (7123355, '000000', 10001, 3, 'type3', '日常记录2', '', '', '0', '2026-03-31 00:00:00', '2026-03-31 20:24:13.045201');
INSERT INTO "public"."ss_emotion_record" VALUES (7123454, '000000', 10001, 3, 'type3', '日常记录1', '', '', '0', '2026-03-30 00:00:00', '2026-03-30 20:24:13.045201');
INSERT INTO "public"."ss_emotion_record" VALUES (7123455, '000000', 10001, 3, 'type5', '日常记录2', '', '', '0', '2026-03-30 00:00:00', '2026-03-30 20:24:13.045201');
INSERT INTO "public"."ss_emotion_record" VALUES (7123554, '000000', 10001, 3, 'type1', '日常记录1', '', '', '0', '2026-03-29 00:00:00', '2026-03-29 20:24:13.045201');
INSERT INTO "public"."ss_emotion_record" VALUES (7123555, '000000', 10001, 3, 'type3', '日常记录2', '', '', '0', '2026-03-29 00:00:00', '2026-03-29 20:24:13.045201');
INSERT INTO "public"."ss_emotion_record" VALUES (7123654, '000000', 10001, 3, 'type3', '日常记录1', '', '', '0', '2026-03-28 00:00:00', '2026-03-28 20:24:13.045201');
INSERT INTO "public"."ss_emotion_record" VALUES (7123655, '000000', 10001, 3, 'type3', '日常记录2', '', '', '0', '2026-03-28 00:00:00', '2026-03-28 20:24:13.045201');
INSERT INTO "public"."ss_emotion_record" VALUES (7123754, '000000', 10001, 3, 'type3', '日常记录1', '', '', '0', '2026-03-27 00:00:00', '2026-03-27 20:24:13.045201');
INSERT INTO "public"."ss_emotion_record" VALUES (7123755, '000000', 10001, 3, 'type4', '日常记录2', '', '', '0', '2026-03-27 00:00:00', '2026-03-27 20:24:13.045201');
INSERT INTO "public"."ss_emotion_record" VALUES (7123854, '000000', 10001, 3, 'type5', '日常记录1', '', '', '0', '2026-03-26 00:00:00', '2026-03-26 20:24:13.045201');
INSERT INTO "public"."ss_emotion_record" VALUES (7123855, '000000', 10001, 3, 'type3', '日常记录2', '', '', '0', '2026-03-26 00:00:00', '2026-03-26 20:24:13.045201');

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
  "create_time" timestamp(6),
  "create_dept" int8,
  "create_by" int8,
  "update_by" int8,
  "update_time" timestamp(6),
  "del_flag" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar
)
;
COMMENT ON COLUMN "public"."ss_family_member"."create_dept" IS '创建部门';
COMMENT ON TABLE "public"."ss_family_member" IS '家庭成员关联表';

-- ----------------------------
-- Records of ss_family_member
-- ----------------------------
INSERT INTO "public"."ss_family_member" VALUES (80001, 'SS0001', 10001, 1000, '爸爸', '{"canEditTask": true, "canViewEmotion": true, "canManageDevice": true}', '2026-03-14 20:37:11.258381', NULL, NULL, NULL, NULL, '0');
INSERT INTO "public"."ss_family_member" VALUES (80002, 'SS0001', 10001, 1001, '妈妈', '{"canEditTask": true, "canViewEmotion": true, "canManageDevice": true}', '2026-03-14 20:37:11.331162', NULL, NULL, NULL, NULL, '0');
INSERT INTO "public"."ss_family_member" VALUES (80003, 'SS0001', 10002, 1000, '爸爸', '{"canEditTask": true, "canViewEmotion": true, "canManageDevice": true}', '2026-03-14 20:37:11.405916', NULL, NULL, NULL, NULL, '0');
INSERT INTO "public"."ss_family_member" VALUES (80004, 'SS0001', 10002, 1001, '妈妈', '{"canEditTask": true, "canViewEmotion": true, "canManageDevice": true}', '2026-03-14 20:37:11.463968', NULL, NULL, NULL, NULL, '0');

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
  "create_time" timestamp(6),
  "create_dept" int8,
  "update_by" int8,
  "update_time" timestamp(6),
  "del_flag" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar
)
;
COMMENT ON COLUMN "public"."ss_game_item"."create_dept" IS '创建部门';
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
  "read_time" timestamp(6),
  "create_dept" int8,
  "create_by" int8,
  "create_time" timestamp(6),
  "update_by" int8,
  "update_time" timestamp(6),
  "del_flag" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar
)
;
COMMENT ON COLUMN "public"."ss_knowledge_user_rel"."create_dept" IS '创建部门';
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
  "update_time" timestamp(6),
  "create_dept" int8,
  "del_flag" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar
)
;
COMMENT ON COLUMN "public"."ss_level_config"."create_dept" IS '创建部门';
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
INSERT INTO "public"."ss_parent_reward" VALUES (93505, 2035392423676469250, '看电视30分钟', 30, -1, '📺', '0', NULL, '2026-04-25 12:15:04.747319', NULL, NULL, '0', NULL);
INSERT INTO "public"."ss_parent_reward" VALUES (2049336552122773506, 2035392423676469250, '看动画片30分钟', 10, -1, '🎬', '0', 2035392423676469250, '2026-04-29 11:54:43.527', 2035392423676469250, '2026-04-29 11:54:43.527', '0', 200);
INSERT INTO "public"."ss_parent_reward" VALUES (2049336566228217857, 2035392423676469250, '吃美味冰淇淋', 20, -1, '🍦', '0', 2035392423676469250, '2026-04-29 11:54:46.887', 2035392423676469250, '2026-04-29 11:54:46.887', '0', 200);
INSERT INTO "public"."ss_parent_reward" VALUES (2049336580170084353, 2035392423676469250, '购买心仪玩具', 100, -1, '🎁', '0', 2035392423676469250, '2026-04-29 11:54:50.216', 2035392423676469250, '2026-04-29 11:54:50.216', '0', 200);
INSERT INTO "public"."ss_parent_reward" VALUES (2049336697920974850, 2035392423676469250, '看动画片30分钟', 10, -1, '🎬', '0', 2035392423676469250, '2026-04-29 11:55:18.281', 2035392423676469250, '2026-04-29 11:55:18.281', '0', 200);
INSERT INTO "public"."ss_parent_reward" VALUES (2049336871326085122, 2035392423676469250, '看动画片30分钟', 10, -1, '🎬', '0', 2035392423676469250, '2026-04-29 11:55:59.62', 2035392423676469250, '2026-04-29 11:55:59.62', '0', 200);
INSERT INTO "public"."ss_parent_reward" VALUES (2049338958541778945, 2035392423676469250, '看动画片30分钟', 10, -1, '🎬', '0', 2035392423676469250, '2026-04-29 12:04:17.257', 2035392423676469250, '2026-04-29 12:04:17.257', '0', 200);
INSERT INTO "public"."ss_parent_reward" VALUES (2049340502980980738, 2035392423676469250, '看动画片30分钟', 10, -1, '🎬', '0', 2035392423676469250, '2026-04-29 12:10:25.48', 2035392423676469250, '2026-04-29 12:10:25.48', '0', 200);
INSERT INTO "public"."ss_parent_reward" VALUES (2049341038828482561, 2035392423676469250, '看动画片30分钟', 10, -1, '🎬', '0', 2035392423676469250, '2026-04-29 12:12:33.231', 2035392423676469250, '2026-04-29 12:12:33.231', '0', 200);
INSERT INTO "public"."ss_parent_reward" VALUES (2049341618443546625, 2035392423676469250, '看动画片30分钟', 10, -1, '🎬', '0', 2035392423676469250, '2026-04-29 12:14:51.42', 2035392423676469250, '2026-04-29 12:14:51.42', '0', 200);
INSERT INTO "public"."ss_parent_reward" VALUES (2049344049248235521, 2035392423676469250, '看动画片30分钟', 10, -1, '🎬', '0', 2035392423676469250, '2026-04-29 12:24:30.971', 2035392423676469250, '2026-04-29 12:24:30.971', '0', 200);
INSERT INTO "public"."ss_parent_reward" VALUES (2049345462971953154, 2035392423676469250, '看动画片30分钟', 10, -1, '🎬', '0', 2035392423676469250, '2026-04-29 12:30:08.035', 2035392423676469250, '2026-04-29 12:30:08.035', '0', 200);
INSERT INTO "public"."ss_parent_reward" VALUES (2049478639585619970, 2035392423676469250, '看动画片30分钟', 10, -1, '🎬', '0', 2035392423676469250, '2026-04-29 21:19:19.812', 2035392423676469250, '2026-04-29 21:19:19.812', '0', 200);
INSERT INTO "public"."ss_parent_reward" VALUES (2049479514584543234, 2035392423676469250, '看动画片30分钟', 10, -1, '🎬', '0', 2035392423676469250, '2026-04-29 21:22:48.432', 2035392423676469250, '2026-04-29 21:22:48.432', '0', 200);
INSERT INTO "public"."ss_parent_reward" VALUES (2049481357616246785, 2035392423676469250, '看动画片30分钟', 10, -1, '🎬', '0', 2035392423676469250, '2026-04-29 21:30:07.848', 2035392423676469250, '2026-04-29 21:30:07.848', '0', 200);
INSERT INTO "public"."ss_parent_reward" VALUES (2049483318868602881, 2035392423676469250, '看动画片30分钟', 10, -1, '🎬', '0', 2035392423676469250, '2026-04-29 21:37:55.436', 2035392423676469250, '2026-04-29 21:37:55.436', '0', 200);
INSERT INTO "public"."ss_parent_reward" VALUES (2049487835110600705, 2035392423676469250, '看动画片30分钟', 10, -1, '🎬', '0', 2035392423676469250, '2026-04-29 21:55:52.191', 2035392423676469250, '2026-04-29 21:55:52.191', '0', 200);
INSERT INTO "public"."ss_parent_reward" VALUES (2049488159477100545, 2035392423676469250, '看动画片30分钟', 10, -1, '🎬', '0', 2035392423676469250, '2026-04-29 21:57:09.533', 2035392423676469250, '2026-04-29 21:57:09.533', '0', 200);
INSERT INTO "public"."ss_parent_reward" VALUES (2049489023474364418, 2035392423676469250, '看动画片30分钟', 10, -1, '🎬', '0', 2035392423676469250, '2026-04-29 22:00:35.529', 2035392423676469250, '2026-04-29 22:00:35.529', '0', 200);
INSERT INTO "public"."ss_parent_reward" VALUES (2049536448608145410, 2035392423676469250, '看动画片30分钟', 10, -1, '🎬', '0', 2035392423676469250, '2026-04-30 01:09:02.552', 2035392423676469250, '2026-04-30 01:09:02.552', '0', 200);
INSERT INTO "public"."ss_parent_reward" VALUES (2049538510402162690, 2035392423676469250, '看动画片30分钟', 10, -1, '🎬', '0', 2035392423676469250, '2026-04-30 01:17:14.125', 2035392423676469250, '2026-04-30 01:17:14.125', '0', 200);
INSERT INTO "public"."ss_parent_reward" VALUES (2049682421498056706, 2035392423676469250, '看动画片30分钟', 10, -1, '🎬', '0', 2035392423676469250, '2026-04-30 10:49:05.204', 2035392423676469250, '2026-04-30 10:49:05.204', '0', 200);
INSERT INTO "public"."ss_parent_reward" VALUES (2049709037922095105, 2035392423676469250, '看动画片30分钟', 10, -1, '🎬', '0', 2035392423676469250, '2026-04-30 12:34:51.057', 2035392423676469250, '2026-04-30 12:34:51.057', '0', 200);
INSERT INTO "public"."ss_parent_reward" VALUES (2049709510418829314, 2035392423676469250, '看动画片30分钟', 10, -1, '🎬', '0', 2035392423676469250, '2026-04-30 12:36:43.706', 2035392423676469250, '2026-04-30 12:36:43.706', '0', 200);
INSERT INTO "public"."ss_parent_reward" VALUES (2049710577026142210, 2035392423676469250, '看动画片30分钟', 10, -1, '🎬', '0', 2035392423676469250, '2026-04-30 12:40:58.009', 2035392423676469250, '2026-04-30 12:40:58.009', '0', 200);
INSERT INTO "public"."ss_parent_reward" VALUES (2049753358524223490, 2035392423676469250, '看动画片30分钟', 10, -1, '🎬', '0', 2035392423676469250, '2026-04-30 15:30:57.908', 2035392423676469250, '2026-04-30 15:30:57.908', '0', 200);
INSERT INTO "public"."ss_parent_reward" VALUES (2049753578574188545, 2035392423676469250, '看动画片30分钟', 10, -1, '🎬', '0', 2035392423676469250, '2026-04-30 15:31:50.378', 2035392423676469250, '2026-04-30 15:31:50.378', '0', 200);
INSERT INTO "public"."ss_parent_reward" VALUES (2049754711912878081, 2035392423676469250, '看动画片30分钟', 10, -1, '🎬', '0', 2035392423676469250, '2026-04-30 15:36:20.583', 2035392423676469250, '2026-04-30 15:36:20.583', '0', 200);
INSERT INTO "public"."ss_parent_reward" VALUES (2049755286360559618, 2035392423676469250, '看动画片30分钟', 10, -1, '🎬', '0', 2035392423676469250, '2026-04-30 15:38:37.538', 2035392423676469250, '2026-04-30 15:38:37.538', '0', 200);
INSERT INTO "public"."ss_parent_reward" VALUES (2050495317220118530, 2035392423676469250, '看动画片30分钟', 10, -1, '🎬', '0', 2035392423676469250, '2026-05-02 16:39:14.647', 2035392423676469250, '2026-05-02 16:39:14.647', '0', 200);
INSERT INTO "public"."ss_parent_reward" VALUES (2050496494800326657, 2035392423676469250, '看动画片30分钟', 10, -1, '🎬', '0', 2035392423676469250, '2026-05-02 16:43:55.409', 2035392423676469250, '2026-05-02 16:43:55.409', '0', 200);
INSERT INTO "public"."ss_parent_reward" VALUES (2050497069780684801, 2035392423676469250, '看动画片30分钟', 10, -1, '🎬', '0', 2035392423676469250, '2026-05-02 16:46:12.491', 2035392423676469250, '2026-05-02 16:46:12.491', '0', 200);
INSERT INTO "public"."ss_parent_reward" VALUES (2050497704882196482, 2035392423676469250, '看动画片30分钟', 10, -1, '🎬', '0', 2035392423676469250, '2026-05-02 16:48:43.906', 2035392423676469250, '2026-05-02 16:48:43.906', '0', 200);
INSERT INTO "public"."ss_parent_reward" VALUES (2050498077843902466, 2035392423676469250, '看动画片30分钟', 10, -1, '🎬', '0', 2035392423676469250, '2026-05-02 16:50:12.841', 2035392423676469250, '2026-05-02 16:50:12.841', '0', 200);
INSERT INTO "public"."ss_parent_reward" VALUES (2050498508116578306, 2035392423676469250, '看动画片30分钟', 10, -1, '🎬', '0', 2035392423676469250, '2026-05-02 16:51:55.421', 2035392423676469250, '2026-05-02 16:51:55.421', '0', 200);
INSERT INTO "public"."ss_parent_reward" VALUES (2050499199409180674, 2035392423676469250, '看动画片30分钟', 10, -1, '🎬', '0', 2035392423676469250, '2026-05-02 16:54:40.239', 2035392423676469250, '2026-05-02 16:54:40.239', '0', 200);
INSERT INTO "public"."ss_parent_reward" VALUES (2050502215029870594, 2035392423676469250, '看动画片30分钟', 10, -1, '🎬', '0', 2035392423676469250, '2026-05-02 17:06:39.209', 2035392423676469250, '2026-05-02 17:06:39.209', '0', 200);
INSERT INTO "public"."ss_parent_reward" VALUES (2050510159104561154, 2035392423676469250, '看动画片30分钟', 10, -1, '🎬', '0', 2035392423676469250, '2026-05-02 17:38:13.24', 2035392423676469250, '2026-05-02 17:38:13.24', '0', 200);
INSERT INTO "public"."ss_parent_reward" VALUES (2052955101533835266, 2035392423676469250, '看动画片30分钟', 10, -1, '🎬', '0', 2035392423676469250, '2026-05-09 11:33:32.935', 2035392423676469250, '2026-05-09 11:33:32.935', '0', 200);

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
  "create_dept" int8,
  "reason" varchar(500) COLLATE "pg_catalog"."default"
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
INSERT INTO "public"."ss_parent_reward_redemption" VALUES (777093629, 777091629, 2035392423676469250, 30, '0', NULL, '2026-04-25 11:43:48.953953', NULL, NULL, NULL, NULL);

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
INSERT INTO "public"."ss_parent_task" VALUES (2047899392123465730, 1, '收敛点做作业', '1. 把桌上的玩具收进盒里: 
2. 把铅笔和橡皮放好: 
3. 打开作业本，翻到第一页: 
4. 试着写下第一个字吧！: ', 'task', 1, 10, '0', 2035392423676469250, '2026-04-25 12:43:57.871', 2035392423676469250, '2026-04-25 12:43:57.871', '0', NULL, NULL, 1, 0, '', '', NULL, 200);
INSERT INTO "public"."ss_parent_task" VALUES (2047903081819140097, 1, 'Pretext', '1. 穿好袜子: 找到一双干净的袜子并穿上
2. 穿好鞋子: 区分左右脚，系好鞋带
3. 拿上书包: 确认作业都在书包里', 'task', 1, 10, '0', 2035392423676469250, '2026-04-25 12:58:37.577', 2035392423676469250, '2026-04-25 12:58:37.577', '0', NULL, NULL, 1, 0, '', '', NULL, 200);
INSERT INTO "public"."ss_parent_task" VALUES (100001, 10001, '早起刷牙', '', '', 1, 10, '0', 2035392423676469250, '2026-04-25 20:24:13.045201', NULL, NULL, '0', NULL, NULL, 1, 0, '', '', NULL, NULL);
INSERT INTO "public"."ss_parent_task" VALUES (100002, 10001, '数学作业', '', '', 1, 10, '0', 2035392423676469250, '2026-04-25 20:24:13.045201', NULL, NULL, '0', NULL, NULL, 1, 0, '', '', NULL, NULL);
INSERT INTO "public"."ss_parent_task" VALUES (100003, 10001, '整理房间', '', '', 1, 10, '0', 2035392423676469250, '2026-04-25 20:24:13.045201', NULL, NULL, '0', NULL, NULL, 1, 0, '', '', NULL, NULL);
INSERT INTO "public"."ss_parent_task" VALUES (100004, 10001, '阅读30分钟', '', '', 1, 10, '0', 2035392423676469250, '2026-04-25 20:24:13.045201', NULL, NULL, '0', NULL, NULL, 1, 0, '', '', NULL, NULL);
INSERT INTO "public"."ss_parent_task" VALUES (2048037611859091458, 1, '想去游泳了', '1. 穿上舒适的泳衣: 
2. 带上喜欢的玩具: 
3. 跟着大人走进更衣室: 
4. 把玩具轻轻放进柜子里: 
5. 在更衣室等爸爸妈妈: ', 'task', 1, 10, '0', 1000, '2026-04-25 21:53:12.023', 1000, '2026-04-25 21:53:12.023', '0', NULL, NULL, 1, 0, '', '', NULL, 200);
INSERT INTO "public"."ss_parent_task" VALUES (2048284722215383042, 1000, '今天做数据作业', '1. 坐到书桌前的椅子上: 
2. 拿出数据作业放桌面: 
3. 轻声读出第一题题目: 
4. 写下第一题的答案: ', 'task', 1, 10, '0', 1000, '2026-04-26 14:15:07.737', 1000, '2026-04-26 14:15:07.737', '0', NULL, NULL, 1, 0, '', '', NULL, 200);
INSERT INTO "public"."ss_parent_task" VALUES (2048296881649471489, 2035392423676469250, '吃早饭并洗碗', '1. 走到餐桌边坐下: 
2. 拿起餐具吃完早饭: 
3. 把脏碗端到水池边: 
4. 冲洗干净自己的饭碗: ', 'task', 1, 10, '0', 2035392423676469250, '2026-04-26 15:03:26.768', 2035392423676469250, '2026-04-26 15:03:26.768', '0', NULL, NULL, 1, 0, '', '', NULL, 200);
INSERT INTO "public"."ss_parent_task" VALUES (2048296996560818177, 1, '测试自动任务', '1. 穿好袜子: 找到一双干净的袜子并穿上
2. 穿好鞋子: 区分左右脚，系好鞋带
3. 拿上书包: 确认作业都在书包里', 'task', 1, 10, '0', 2035392423676469250, '2026-04-26 15:03:54.168', 2035392423676469250, '2026-04-26 15:03:54.168', '0', NULL, NULL, 1, 0, '', '', NULL, 200);
INSERT INTO "public"."ss_parent_task" VALUES (2048297203667161090, 1, '发布测试-手工', '1. 穿好袜子: 找到一双干净的袜子并穿上
2. 穿好鞋子: 区分左右脚，系好鞋带
3. 拿上书包: 确认作业都在书包里', 'task', 1, 10, '0', 2035392423676469250, '2026-04-26 15:04:43.536', 2035392423676469250, '2026-04-26 15:04:43.536', '0', NULL, NULL, 1, 0, '', '', NULL, 200);
INSERT INTO "public"."ss_parent_task" VALUES (2048302271732768769, 1000, '测试任务0426', '1. 穿好袜子: 找到一双干净的袜子并穿上
2. 穿好鞋子: 区分左右脚，系好鞋带
3. 拿上书包: 确认作业都在书包里', 'task', 1, 10, '0', 1000, '2026-04-26 15:24:51.859', 1000, '2026-04-26 15:24:51.859', '0', NULL, NULL, 1, 0, '', '', NULL, 200);
INSERT INTO "public"."ss_parent_task" VALUES (2048302771081437186, 1000, '测试任务0426-v2', '1. 穿好袜子: 找到一双干净的袜子并穿上
2. 穿好鞋子: 区分左右脚，系好鞋带
3. 拿上书包: 确认作业都在书包里', 'task', 1, 10, '0', 1000, '2026-04-26 15:26:50.915', 1000, '2026-04-26 15:26:50.915', '0', NULL, NULL, 1, 0, '', '', NULL, 200);
INSERT INTO "public"."ss_parent_task" VALUES (2048302851201032194, 1000, '测试任务0426-v2', '1. 穿好袜子: 找到一双干净的袜子并穿上
2. 穿好鞋子: 区分左右脚，系好鞋带
3. 拿上书包: 确认作业都在书包里', 'task', 1, 10, '0', 1000, '2026-04-26 15:27:10.014', 1000, '2026-04-26 15:27:10.014', '0', NULL, NULL, 1, 0, '', '', NULL, 200);

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
INSERT INTO "public"."ss_reward" VALUES (777091629, 'SS0001', 10001, '看电视30分钟', '📺', 30, -1, '0', NULL, NULL, '2026-04-25 11:43:48.953953', NULL, NULL, '0');

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
  "create_time" timestamp(6),
  "create_dept" int8,
  "create_by" int8,
  "update_by" int8,
  "update_time" timestamp(6),
  "del_flag" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar
)
;
COMMENT ON COLUMN "public"."ss_star_record"."create_dept" IS '创建部门';
COMMENT ON TABLE "public"."ss_star_record" IS '星星流水记录表';

-- ----------------------------
-- Records of ss_star_record
-- ----------------------------
INSERT INTO "public"."ss_star_record" VALUES (50001, 'SS0001', 10001, 5, '完成早晨刷牙洗脸', '1', 20101, '2026-03-08 20:37:10.263944', NULL, NULL, NULL, NULL, '0');
INSERT INTO "public"."ss_star_record" VALUES (50002, 'SS0001', 10001, 5, '完成早晨刷牙洗脸', '1', 20102, '2026-03-09 20:37:10.330493', NULL, NULL, NULL, NULL, '0');
INSERT INTO "public"."ss_star_record" VALUES (50003, 'SS0001', 10001, 5, '完成早晨刷牙洗脸', '1', 20103, '2026-03-10 20:37:10.397357', NULL, NULL, NULL, NULL, '0');
INSERT INTO "public"."ss_star_record" VALUES (50004, 'SS0001', 10001, 10, '完成今天的作业', '1', 20104, '2026-03-11 20:37:10.473504', NULL, NULL, NULL, NULL, '0');
INSERT INTO "public"."ss_star_record" VALUES (50005, 'SS0001', 10001, -20, '兑换玩游戏奖励', '2', 40001, '2026-03-11 20:37:10.547236', NULL, NULL, NULL, NULL, '0');
INSERT INTO "public"."ss_star_record" VALUES (50006, 'SS0001', 10001, 5, '整理书包', '1', 20105, '2026-03-12 20:37:10.688829', NULL, NULL, NULL, NULL, '0');
INSERT INTO "public"."ss_star_record" VALUES (50007, 'SS0001', 10001, 5, '完成早晨刷牙洗脸', '1', 20106, '2026-03-13 20:37:10.764239', NULL, NULL, NULL, NULL, '0');
INSERT INTO "public"."ss_star_record" VALUES (50008, 'SS0001', 10001, 10, '完成今天的作业', '1', 20107, '2026-03-13 20:37:10.838962', NULL, NULL, NULL, NULL, '0');
INSERT INTO "public"."ss_star_record" VALUES (50009, 'SS0001', 10001, -100, '兑换乐高积木', '2', 40002, '2026-03-13 20:37:10.905901', NULL, NULL, NULL, NULL, '0');

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
INSERT INTO "public"."ss_task" VALUES (777090629, 'SS0001', 10001, '早晨刷牙', '🪥', 5, 1, '1', '', NULL, '', '', '0', NULL, NULL, '2026-04-25 11:43:48.953953', NULL, NULL, '0');
INSERT INTO "public"."ss_task" VALUES (777090630, 'SS0001', 10001, '课后作业', '📚', 10, 3, '1', '', NULL, '', '', '0', NULL, NULL, '2026-04-25 11:43:48.953953', NULL, NULL, '0');

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
  "update_time" timestamp(6),
  "autonomy_score" int2
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
COMMENT ON COLUMN "public"."ss_task_log"."autonomy_score" IS '自主性评分 (1-5)';
COMMENT ON TABLE "public"."ss_task_log" IS '任务执行记录表';

-- ----------------------------
-- Records of ss_task_log
-- ----------------------------
INSERT INTO "public"."ss_task_log" VALUES (2048403104088547330, '000000', 2048302851201032194, 1003, NULL, '1', '', 0, '', '2026-04-26 22:05:32.163', NULL, NULL, 0, NULL, NULL, '0', 200, 1003, 1003, '2026-04-26 22:05:32.163', NULL);
INSERT INTO "public"."ss_task_log" VALUES (2049682430259957761, '000000', 2049682429861498881, 1, NULL, '1', '', 0, '', '2026-04-30 10:49:07.299', 200, '2026-04-30', 0, NULL, NULL, '0', 200, 2035392423676469250, 2035392423676469250, '2026-04-30 10:49:07.299', NULL);
INSERT INTO "public"."ss_task_log" VALUES (2050497082220990466, '000000', 2050497081768005634, 1, NULL, '1', '', 0, '', '2026-05-02 16:46:15.462', 200, '2026-05-02', 0, NULL, NULL, '0', 200, 2035392423676469250, 2035392423676469250, '2026-05-02 16:46:15.462', NULL);
INSERT INTO "public"."ss_task_log" VALUES (2050498520376528898, '000000', 2050498519982264322, 1, NULL, '1', '', 0, '', '2026-05-02 16:51:58.348', 200, '2026-05-02', 0, NULL, NULL, '0', 200, 2035392423676469250, 2035392423676469250, '2026-05-02 16:51:58.348', NULL);
INSERT INTO "public"."ss_task_log" VALUES (2050502226878779393, '000000', 2050502226551623681, 1, NULL, '1', '', 0, '', '2026-05-02 17:06:42.044', 200, '2026-05-02', 0, NULL, NULL, '0', 200, 2035392423676469250, 2035392423676469250, '2026-05-02 17:06:42.044', NULL);
INSERT INTO "public"."ss_task_log" VALUES (7119864, '000000', 100002, 10001, NULL, '2', '', 0, '', '2026-04-24 20:24:13.045201', NULL, '2026-04-24', 28, NULL, NULL, '0', -1, 2035392423676469250, NULL, NULL, 65);
INSERT INTO "public"."ss_task_log" VALUES (7119904, '000000', 100004, 10001, NULL, '2', '', 0, '', '2026-04-20 20:24:13.045201', NULL, '2026-04-20', 22, NULL, NULL, '0', -1, 2035392423676469250, NULL, NULL, 94);
INSERT INTO "public"."ss_task_log" VALUES (7119914, '000000', 100002, 10001, NULL, '2', '', 0, '', '2026-04-19 20:24:13.045201', NULL, '2026-04-19', 27, NULL, NULL, '0', -1, 2035392423676469250, NULL, NULL, 89);
INSERT INTO "public"."ss_task_log" VALUES (7119924, '000000', 100001, 10001, NULL, '2', '', 0, '', '2026-04-18 20:24:13.045201', NULL, '2026-04-18', 32, NULL, NULL, '0', -1, 2035392423676469250, NULL, NULL, 67);
INSERT INTO "public"."ss_task_log" VALUES (7119934, '000000', 100002, 10001, NULL, '2', '', 0, '', '2026-04-17 20:24:13.045201', NULL, '2026-04-17', 26, NULL, NULL, '0', -1, 2035392423676469250, NULL, NULL, 95);
INSERT INTO "public"."ss_task_log" VALUES (7119944, '000000', 100002, 10001, NULL, '2', '', 0, '', '2026-04-16 20:24:13.045201', NULL, '2026-04-16', 18, NULL, NULL, '0', -1, 2035392423676469250, NULL, NULL, 61);
INSERT INTO "public"."ss_task_log" VALUES (7119954, '000000', 100001, 10001, NULL, '2', '', 0, '', '2026-04-15 20:24:13.045201', NULL, '2026-04-15', 28, NULL, NULL, '0', -1, 2035392423676469250, NULL, NULL, 77);
INSERT INTO "public"."ss_task_log" VALUES (7119984, '000000', 100002, 10001, NULL, '2', '', 0, '', '2026-04-12 20:24:13.045201', NULL, '2026-04-12', 27, NULL, NULL, '0', -1, 2035392423676469250, NULL, NULL, 68);
INSERT INTO "public"."ss_task_log" VALUES (2053710889031917569, '000000', 2053710888520212482, 1002, NULL, '2', '', 0, '', '2026-05-11 13:36:46.706', NULL, '2026-05-11', 0, NULL, '2026-05-11 13:58:57.419', '0', 200, 2035392423676469250, 1002, '2026-05-11 13:58:57.42', NULL);
INSERT INTO "public"."ss_task_log" VALUES (2053834667275444226, '000000', 2053834666847625217, 1002, NULL, '1', '', 0, '', '2026-05-11 21:48:37.738', NULL, '2026-05-11', 0, NULL, NULL, '0', 200, 2035392423676469250, 2035392423676469250, '2026-05-11 21:48:37.738', NULL);
INSERT INTO "public"."ss_task_log" VALUES (2049754725947019266, '000000', 2049754725380788226, 1, NULL, '1', '', 0, '', '2026-04-30 15:36:23.94', 200, '2026-04-30', 0, NULL, NULL, '0', 200, 2035392423676469250, 2035392423676469250, '2026-04-30 15:36:23.94', NULL);
INSERT INTO "public"."ss_task_log" VALUES (2050497730794606593, '000000', 2050497730463256577, 1, NULL, '1', '', 0, '', '2026-05-02 16:48:50.086', 200, '2026-05-02', 0, NULL, NULL, '0', 200, 2035392423676469250, 2035392423676469250, '2026-05-02 16:48:50.086', NULL);
INSERT INTO "public"."ss_task_log" VALUES (2050499237027893249, '000000', 2050499236063203330, 1, NULL, '1', '', 0, '', '2026-05-02 16:54:49.205', 200, '2026-05-02', 0, NULL, NULL, '0', 200, 2035392423676469250, 2035392423676469250, '2026-05-02 16:54:49.205', NULL);
INSERT INTO "public"."ss_task_log" VALUES (7119994, '000000', 100002, 10001, NULL, '2', '', 0, '', '2026-04-11 20:24:13.045201', NULL, '2026-04-11', 24, NULL, NULL, '0', -1, 2035392423676469250, NULL, NULL, 92);
INSERT INTO "public"."ss_task_log" VALUES (7120004, '000000', 100001, 10001, NULL, '2', '', 0, '', '2026-04-10 20:24:13.045201', NULL, '2026-04-10', 31, NULL, NULL, '0', -1, 2035392423676469250, NULL, NULL, 75);
INSERT INTO "public"."ss_task_log" VALUES (7120014, '000000', 100002, 10001, NULL, '2', '', 0, '', '2026-04-09 20:24:13.045201', NULL, '2026-04-09', 15, NULL, NULL, '0', -1, 2035392423676469250, NULL, NULL, 82);
INSERT INTO "public"."ss_task_log" VALUES (7120024, '000000', 100001, 10001, NULL, '2', '', 0, '', '2026-04-08 20:24:13.045201', NULL, '2026-04-08', 20, NULL, NULL, '0', -1, 2035392423676469250, NULL, NULL, 79);
INSERT INTO "public"."ss_task_log" VALUES (7120044, '000000', 100003, 10001, NULL, '2', '', 0, '', '2026-04-06 20:24:13.045201', NULL, '2026-04-06', 29, NULL, NULL, '0', -1, 2035392423676469250, NULL, NULL, 74);
INSERT INTO "public"."ss_task_log" VALUES (7120054, '000000', 100003, 10001, NULL, '2', '', 0, '', '2026-04-05 20:24:13.045201', NULL, '2026-04-05', 26, NULL, NULL, '0', -1, 2035392423676469250, NULL, NULL, 85);
INSERT INTO "public"."ss_task_log" VALUES (7120074, '000000', 100002, 10001, NULL, '2', '', 0, '', '2026-04-03 20:24:13.045201', NULL, '2026-04-03', 16, NULL, NULL, '0', -1, 2035392423676469250, NULL, NULL, 79);
INSERT INTO "public"."ss_task_log" VALUES (7120084, '000000', 100002, 10001, NULL, '2', '', 0, '', '2026-04-02 20:24:13.045201', NULL, '2026-04-02', 29, NULL, NULL, '0', -1, 2035392423676469250, NULL, NULL, 70);
INSERT INTO "public"."ss_task_log" VALUES (7120094, '000000', 100002, 10001, NULL, '2', '', 0, '', '2026-04-01 20:24:13.045201', NULL, '2026-04-01', 28, NULL, NULL, '0', -1, 2035392423676469250, NULL, NULL, 97);
INSERT INTO "public"."ss_task_log" VALUES (7120104, '000000', 100001, 10001, NULL, '2', '', 0, '', '2026-03-31 20:24:13.045201', NULL, '2026-03-31', 16, NULL, NULL, '0', -1, 2035392423676469250, NULL, NULL, 61);
INSERT INTO "public"."ss_task_log" VALUES (7120114, '000000', 100004, 10001, NULL, '2', '', 0, '', '2026-03-30 20:24:13.045201', NULL, '2026-03-30', 17, NULL, NULL, '0', -1, 2035392423676469250, NULL, NULL, 79);
INSERT INTO "public"."ss_task_log" VALUES (7120124, '000000', 100004, 10001, NULL, '2', '', 0, '', '2026-03-29 20:24:13.045201', NULL, '2026-03-29', 26, NULL, NULL, '0', -1, 2035392423676469250, NULL, NULL, 66);
INSERT INTO "public"."ss_task_log" VALUES (7120134, '000000', 100001, 10001, NULL, '2', '', 0, '', '2026-03-28 20:24:13.045201', NULL, '2026-03-28', 28, NULL, NULL, '0', -1, 2035392423676469250, NULL, NULL, 75);
INSERT INTO "public"."ss_task_log" VALUES (7120144, '000000', 100002, 10001, NULL, '2', '', 0, '', '2026-03-27 20:24:13.045201', NULL, '2026-03-27', 20, NULL, NULL, '0', -1, 2035392423676469250, NULL, NULL, 75);
INSERT INTO "public"."ss_task_log" VALUES (7120154, '000000', 100001, 10001, NULL, '2', '', 0, '', '2026-03-26 20:24:13.045201', NULL, '2026-03-26', 21, NULL, NULL, '0', -1, 2035392423676469250, NULL, NULL, 70);
INSERT INTO "public"."ss_task_log" VALUES (2052696865496940546, '000000', 2052696864968458242, 1002, NULL, '2', '', 0, '', '2026-05-08 18:27:24.658', 200, '2026-05-08', 0, NULL, '2026-05-11 19:30:45.675', '0', 200, 2035392423676469250, 1002, '2026-05-11 19:30:45.675', NULL);

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
  "status" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar,
  "create_dept" int8,
  "update_by" int8,
  "update_time" timestamp(6),
  "del_flag" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar
)
;
COMMENT ON COLUMN "public"."ss_task_preset"."create_dept" IS '创建部门';
COMMENT ON TABLE "public"."ss_task_preset" IS '场景化任务预设库';

-- ----------------------------
-- Records of ss_task_preset
-- ----------------------------

-- ----------------------------
-- Table structure for ss_task_step_template
-- ----------------------------
DROP TABLE IF EXISTS "public"."ss_task_step_template";
CREATE TABLE "public"."ss_task_step_template" (
  "step_id" int8 NOT NULL DEFAULT nextval('ss_task_step_template_step_id_seq'::regclass),
  "template_id" int8 NOT NULL,
  "step_order" int4 NOT NULL,
  "content" text COLLATE "pg_catalog"."default" NOT NULL,
  "visual_hint" varchar(200) COLLATE "pg_catalog"."default",
  "audio_hint" varchar(200) COLLATE "pg_catalog"."default",
  "expected_duration" int4,
  "create_by" varchar(64) COLLATE "pg_catalog"."default",
  "create_time" timestamp(6),
  "update_by" varchar(64) COLLATE "pg_catalog"."default",
  "update_time" timestamp(6)
)
;

-- ----------------------------
-- Records of ss_task_step_template
-- ----------------------------
INSERT INTO "public"."ss_task_step_template" VALUES (1, 1, 1, '掀开被子坐起来', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."ss_task_step_template" VALUES (2, 1, 2, '走进洗手间', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."ss_task_step_template" VALUES (3, 1, 3, '挤好牙膏并刷牙', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."ss_task_step_template" VALUES (4, 2, 1, '打开课程表并确认科目', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."ss_task_step_template" VALUES (5, 2, 2, '检查每本书是否在包里', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."ss_task_step_template" VALUES (6, 2, 3, '合上拉链，挂好书包', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."ss_task_step_template" VALUES (7, 3, 1, '选择一本你想读的书', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."ss_task_step_template" VALUES (8, 3, 2, '设定15分钟倒计时', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."ss_task_step_template" VALUES (9, 3, 3, '大声朗读一段你喜欢的话', NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for ss_task_template
-- ----------------------------
DROP TABLE IF EXISTS "public"."ss_task_template";
CREATE TABLE "public"."ss_task_template" (
  "template_id" int8 NOT NULL DEFAULT nextval('ss_task_template_template_id_seq'::regclass),
  "title" varchar(200) COLLATE "pg_catalog"."default" NOT NULL,
  "description" text COLLATE "pg_catalog"."default",
  "icon" varchar(100) COLLATE "pg_catalog"."default",
  "category" varchar(50) COLLATE "pg_catalog"."default",
  "target_age_min" int4,
  "target_age_max" int4,
  "default_difficulty" int4 DEFAULT 1,
  "default_prompt_level" int4 DEFAULT 1,
  "light_effect" varchar(100) COLLATE "pg_catalog"."default",
  "audio_effect" varchar(100) COLLATE "pg_catalog"."default",
  "intervention_theory" text COLLATE "pg_catalog"."default",
  "status" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar,
  "del_flag" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar,
  "create_by" varchar(64) COLLATE "pg_catalog"."default",
  "create_time" timestamp(6),
  "update_by" varchar(64) COLLATE "pg_catalog"."default",
  "update_time" timestamp(6),
  "remark" varchar(500) COLLATE "pg_catalog"."default",
  "create_dept" int8
)
;
COMMENT ON COLUMN "public"."ss_task_template"."create_dept" IS '创建部门';

-- ----------------------------
-- Records of ss_task_template
-- ----------------------------
INSERT INTO "public"."ss_task_template" VALUES (1, '早起洗漱 (ADHD版)', '将早起洗漱拆解为微小动作，减少阻力。', 'brush', 'Life', NULL, NULL, 1, 1, NULL, NULL, '动作提示法：将复杂链条拆解为单一指令。', '0', '0', NULL, NULL, NULL, NULL, NULL, -1);
INSERT INTO "public"."ss_task_template" VALUES (2, '书包整理 (防遗漏)', '使用“三步检查法”确保不漏带课本。', 'inventory', 'Study', NULL, NULL, 2, 1, NULL, NULL, '自述法：通过大声朗读清单强化记忆。', '0', '0', NULL, NULL, NULL, NULL, NULL, -1);
INSERT INTO "public"."ss_task_template" VALUES (3, '15分钟专注阅读', '结合番茄钟技术的专注练习。', 'book', 'Study', NULL, NULL, 3, 1, NULL, NULL, '时间知觉训练：通过视觉进度条量化时间。', '0', '0', NULL, NULL, NULL, NULL, NULL, -1);
INSERT INTO "public"."ss_task_template" VALUES (4, '房间“5分钟闪电清理”', '限时清理，只关注地面物品。', 'cleaning_services', 'Life', NULL, NULL, 2, 1, NULL, NULL, '游戏化动力：将家务转化为限时挑战。', '0', '0', NULL, NULL, NULL, NULL, NULL, -1);
INSERT INTO "public"."ss_task_template" VALUES (5, '睡前准备仪式', '平复情绪，建立稳定的睡眠预期。', 'bedtime', 'Life', NULL, NULL, 1, 1, NULL, NULL, '环境暗示：通过灯光与声音降低觉醒水平。', '0', '0', NULL, NULL, NULL, NULL, NULL, -1);
INSERT INTO "public"."ss_task_template" VALUES (6, '自主写作业 (拆解版)', '先做简单的，再做难的，中间休息。', 'edit_note', 'Study', NULL, NULL, 4, 1, NULL, NULL, '成功体验优先：通过早期正反馈提升持久力。', '0', '0', NULL, NULL, NULL, NULL, NULL, -1);
INSERT INTO "public"."ss_task_template" VALUES (7, '穿衣大挑战', '按顺序摆放衣服，一步步穿好。', 'checkroom', 'Life', NULL, NULL, 1, 1, NULL, NULL, '空间导航：通过物理定位减少认知干扰。', '0', '0', NULL, NULL, NULL, NULL, NULL, -1);
INSERT INTO "public"."ss_task_template" VALUES (8, '餐后整理', '送回餐具，擦拭桌面。', 'restaurant', 'Life', NULL, NULL, 2, 1, NULL, NULL, '习惯锚点：将餐后行为与特定信号挂钩。', '0', '0', NULL, NULL, NULL, NULL, NULL, -1);
INSERT INTO "public"."ss_task_template" VALUES (9, '社交技能：打招呼', '练习眼神交流和清晰的问候。', 'groups', 'Social', NULL, NULL, 2, 1, NULL, NULL, '社交故事：模拟真实场景，降低社交焦虑。', '0', '0', NULL, NULL, NULL, NULL, NULL, -1);
INSERT INTO "public"."ss_task_template" VALUES (10, '情绪调节：深呼吸', '当感到愤怒时，练习3次深呼吸。', 'wind', 'Social', NULL, NULL, 1, 1, NULL, NULL, '生理反馈：通过呼吸调整植物神经系统。', '0', '0', NULL, NULL, NULL, NULL, NULL, -1);

-- ----------------------------
-- Table structure for sys_ai_knowledge
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_ai_knowledge";
CREATE TABLE "public"."sys_ai_knowledge" (
  "id" int8 NOT NULL,
  "title" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "content_type" varchar(50) COLLATE "pg_catalog"."default" DEFAULT 'TEXT'::character varying,
  "content" text COLLATE "pg_catalog"."default" NOT NULL,
  "keywords" varchar(500) COLLATE "pg_catalog"."default",
  "status" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar,
  "create_by" varchar(64) COLLATE "pg_catalog"."default",
  "create_time" timestamp(6),
  "update_by" varchar(64) COLLATE "pg_catalog"."default",
  "update_time" timestamp(6),
  "remark" varchar(500) COLLATE "pg_catalog"."default"
)
;
COMMENT ON TABLE "public"."sys_ai_knowledge" IS 'AI Knowledge Base';

-- ----------------------------
-- Records of sys_ai_knowledge
-- ----------------------------
INSERT INTO "public"."sys_ai_knowledge" VALUES (2055674922415538178, '23', 'MARKDOWN', '23', '23', '0', NULL, NULL, NULL, NULL, '23');

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
  "del_flag" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar,
  "create_dept" int8
)
;
COMMENT ON TABLE "public"."sys_ai_model" IS 'AI模型配置表';

-- ----------------------------
-- Records of sys_ai_model
-- ----------------------------
INSERT INTO "public"."sys_ai_model" VALUES (2001, 1001, 'gemma-4-26b', 'Gemma-4-26b 模型', 0.000000, 0.000000, 24576, '1', '0', 1, '2026-04-23 09:29:27.769615', 1, '2026-04-23 09:29:27.769615', NULL, '0', NULL);
INSERT INTO "public"."sys_ai_model" VALUES (2002, 1001, 'qwen3.5-9b-q8_0', 'Qwen3.5-9b 模型', 0.000000, 0.000000, 24576, '1', '0', 1, '2026-04-23 09:29:33.422423', 1, '2026-04-23 09:29:33.422423', NULL, '0', NULL);
INSERT INTO "public"."sys_ai_model" VALUES (2010, 1005, 'Doubao-Pro-32k', 'Doubao-Pro-32k', 0.000800, 0.002000, 32768, '0', '0', 1, '2026-04-26 13:09:40', 1, '2026-04-26 13:21:40.413', '核心场景：任务拆解', '0', NULL);
INSERT INTO "public"."sys_ai_model" VALUES (2007, 1005, 'ep-20260426223431-nwnvn', 'Doubao-Character-32k', 0.000800, 0.002000, 32768, '0', '0', 1, '2026-04-26 13:09:40', 1, '2026-04-26 22:36:56.129', '陪伴场景：树洞聊天伙伴', '0', NULL);
INSERT INTO "public"."sys_ai_model" VALUES (2008, 1005, 'ep-20260426223431-nwnvn', 'Doubao-Pro-128k', 0.005000, 0.015000, 131072, '0', '0', 1, '2026-04-26 13:09:40', 1, '2026-04-26 22:37:06.047', '分析场景：月度行为报告', '0', NULL);
INSERT INTO "public"."sys_ai_model" VALUES (2009, 1005, 'ep-20260426223431-nwnvn', 'Doubao-Vision-Pro', 0.010000, 0.010000, 4096, '0', '0', 1, '2026-04-26 13:09:40', 1, '2026-04-26 22:37:12.122', '视觉场景：作品图片鼓励', '0', NULL);
INSERT INTO "public"."sys_ai_model" VALUES (2005, 1005, 'ep-20260426133338-kx5cr', '豆包-Pro-4k', 0.000800, 0.002000, 4096, '0', '0', 1, '2026-04-26 11:21:00', 1, '2026-04-26 22:38:11.612', NULL, '0', NULL);
INSERT INTO "public"."sys_ai_model" VALUES (2006, 1005, 'ep-20260426223431-nwnvn', 'Doubao-Lite-32k', 0.000300, 0.000600, 32768, '0', '0', 1, '2026-04-26 13:09:40', 1, '2026-04-26 22:38:25.288', '高频场景：习惯打卡反馈', '0', NULL);
INSERT INTO "public"."sys_ai_model" VALUES (2048770343425916930, 2048770187162927105, 'glm-4.5-aic', 'glm-4.5-aic', 0.000000, 0.000000, 0, '0', '0', 1, '2026-04-27 22:24:48', 1, '2026-04-27 22:25:19.761', NULL, '0', 200);
INSERT INTO "public"."sys_ai_model" VALUES (2048770343425916931, 2048770187162927105, 'glm-4.7', 'glm-4.7', 0.000000, 0.000000, 0, '0', '0', 1, '2026-04-27 22:24:48', 1, '2026-04-27 22:25:19.761', NULL, '0', 200);
INSERT INTO "public"."sys_ai_model" VALUES (2048770343425916929, 2048770187162927105, 'glm-4.7-flash', 'glm-4.7-flash', 0.000000, 0.000000, 32768, '0', '0', 1, '2026-04-27 22:24:48', 1, '2026-05-03 16:05:05.722', NULL, '0', 200);

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
INSERT INTO "public"."sys_ai_prompt" VALUES (2, 'PARENT_BEHAVIOR_ANALYSIS', '儿童行为周度分析（家长视角）', '你是一个专业的ADHD儿童心理与行为分析师。请根据以下本周儿童的任务完成情况和情绪数据，为家长生成一份简短的周度报告。
数据：{weeklyData}
要求：
1. 先给出积极的肯定（哪怕是一点点进步）。
2. 指出本周可能存在的难点或执行功能卡点。
3. 给出1-2个针对下周的实操建议。
4. 语气要客观、专业、给予家长支持感。', NULL, '0', '0', NULL, 1, '2026-04-25 23:17:11.12602', NULL, NULL, '家长端周度行为分析模板');
INSERT INTO "public"."sys_ai_prompt" VALUES (3, 'PARENT_REWARD_SUGGESTION', '奖励清单建议（家长视角）', '你是一位经验丰富的ADHD育儿教练。家长想要为孩子设立新的任务奖励。
请基于孩子的年龄：{childAge} 岁，以及最近的兴趣点：{interests}，提供5个非物质或低成本的奖励建议（如：特权、特殊体验）。
要求：奖励必须即时、有趣、且具有足够的吸引力（多巴胺刺激）。', NULL, '0', '0', NULL, 1, '2026-04-25 23:17:11.12602', NULL, NULL, '家长端奖励建议模板');
INSERT INTO "public"."sys_ai_prompt" VALUES (4, 'CHILD_TREEHOLE_CHAT', '小步秘密树洞（儿童视角）', '你是“小步”，一个专为ADHD儿童设计的虚拟外星人伙伴。
当前孩子想跟你聊天，他说：“{userInput}”。
他的情绪状态大概是：{emotionState}。
要求：
1. 语言必须非常活泼、简短、用儿童容易理解的词汇。
2. 表达强烈的共情和理解，不要立刻讲大道理。
3. 如果孩子觉得无聊或抗拒，尝试用游戏化的想象力引导他。
4. 适当使用 1-2 个 Emoji，绝对不要长篇大论。', NULL, '0', '0', NULL, 1, '2026-04-25 23:17:11.190062', NULL, NULL, '儿童端树洞聊天基础模板');
INSERT INTO "public"."sys_ai_prompt" VALUES (5, 'CHILD_TASK_ENCOURAGEMENT', '任务启动鼓励（儿童视角）', '你是小步伙伴。孩子现在有一个任务要开始：{taskName}。但他可能正面临“启动困难”。
要求：
1. 帮他按下大脑里的“启动按钮”。
2. 把任务说得像一个特工行动或冒险挑战。
3. 告诉他只做第一步（{firstStep}）就好，剩下的不管。
4. 语言极短（不超过30个字），带上充满能量的Emoji！', NULL, '0', '0', NULL, 1, '2026-04-25 23:17:11.190062', NULL, NULL, '儿童端任务启动引导模板');
INSERT INTO "public"."sys_ai_prompt" VALUES (6, 'CHILD_EMOTION_COMFORT', '情绪安抚与疏导（儿童视角）', '你是小步伙伴。孩子现在感到非常{emotionState}（比如挫败、生气），他说：“{userInput}”。
要求：
1. 承认他的感觉是完全OK的，说“我懂，这真的很气人/难过”。
2. 引导他做一个简单的深呼吸，或者想象把坏情绪吹成一个大气泡飞走。
3. 不要批评，不要说“你应该怎么做”。
4. 让他知道你就在他身边陪着他。', NULL, '0', '0', NULL, 1, '2026-04-25 23:17:11.190062', NULL, NULL, '儿童端情绪安抚模板');
INSERT INTO "public"."sys_ai_prompt" VALUES (7, 'CHILD_MORNING_GREETING', '元气早安问候（儿童视角）', '你是小步伙伴。现在是早晨，孩子刚醒来。
要求：
1. 用充满活力的声音跟他说早安！
2. 告诉他今天他大脑里的小引擎已经加满油了。
3. 问他今天最想玩的一个游戏或最期待的一件事是什么。
4. 字数控制在40字以内，要有互动感。', NULL, '0', '0', NULL, 1, '2026-04-25 23:17:11.190062', NULL, NULL, '儿童端早安问候模板');
INSERT INTO "public"."sys_ai_prompt" VALUES (8, 'CHILD_SLEEP_GUIDE', '睡前放松引导（儿童视角）', '你是小步伙伴。现在是睡觉时间，但孩子的大脑还在“高速运转”，有些抗拒睡觉或觉得无聊。
要求：
1. 绝对不要催促他“快睡觉”。
2. 邀请他玩一个“关机游戏”：把手和脚想象成小机器，现在要慢慢断电。
3. 告诉他小步也会陪他在梦里抓流星或开飞船。
4. 语言要非常轻柔、缓慢，充满想象力，让人感到平静。', NULL, '0', '0', NULL, 1, '2026-04-25 23:17:11.190062', NULL, NULL, '儿童端睡前抗拒引导模板');

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
  "del_flag" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar,
  "create_dept" int8,
  "provider_code" varchar(50) COLLATE "pg_catalog"."default"
)
;
COMMENT ON COLUMN "public"."sys_ai_provider"."id" IS '主键';
COMMENT ON COLUMN "public"."sys_ai_provider"."name" IS '供应商名称';
COMMENT ON COLUMN "public"."sys_ai_provider"."provider_code" IS '供应商代码 (如 ALIYUN, OPENAI)';
COMMENT ON TABLE "public"."sys_ai_provider" IS 'AI供应商配置表';

-- ----------------------------
-- Records of sys_ai_provider
-- ----------------------------
INSERT INTO "public"."sys_ai_provider" VALUES (1001, 'vllm本地服务', 'openai', 'http://192.168.1.9:8005/v1', 'ken2zhao589612', 10, '0', 1, '2026-04-23 09:29:22', 1, '2026-04-25 23:24:53.999', NULL, '0', NULL, 'VLLM');
INSERT INTO "public"."sys_ai_provider" VALUES (1005, '火山引擎 (Ark)', 'openai_compatible', 'https://ark.cn-beijing.volces.com/api/v3', 'ark-dc0578f1-06d2-4c1e-856d-ec1f8090f058-8af46', 100, '0', 1, '2026-04-26 11:21:00', 1, '2026-04-26 13:20:59.937', NULL, '0', NULL, 'Doubao');
INSERT INTO "public"."sys_ai_provider" VALUES (2048770187162927105, 'glm', 'openai', 'https://open.bigmodel.cn/api/paas/v4', 'f2649c2b4bef47b099bf63a63ce135e4.kpn7Es4gyg3dawQk', 1, '0', 1, '2026-04-27 22:24:11.598', 1, '2026-04-27 22:24:11.598', NULL, '0', 200, 'glm');
INSERT INTO "public"."sys_ai_provider" VALUES (2, 'VLLM-Local', 'vllm', 'http://localhost:8003/v1', 'no-key', 100, '0', 1, '2026-04-23 00:19:34.801257', NULL, NULL, NULL, '0', NULL, 'VLLM0');
INSERT INTO "public"."sys_ai_provider" VALUES (1, 'VLLM-Local', 'vllm', 'http://localhost:8002/v1', 'no-key', 100, '0', 1, '2026-04-22 23:50:38.913811', NULL, NULL, NULL, '0', NULL, 'VLLM1');

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
  "create_time" timestamp(6),
  "create_dept" int8
)
;
COMMENT ON COLUMN "public"."sys_ai_route"."create_by" IS '创建者';
COMMENT ON COLUMN "public"."sys_ai_route"."create_time" IS '创建时间';
COMMENT ON TABLE "public"."sys_ai_route" IS 'AI路由策略表';

-- ----------------------------
-- Records of sys_ai_route
-- ----------------------------
INSERT INTO "public"."sys_ai_route" VALUES ('HABIT_CHECKIN', 'PRIORITY_LEVEL', 2048770343425916929, NULL, 1, '2026-04-27 22:27:27.407', NULL, NULL, NULL);
INSERT INTO "public"."sys_ai_route" VALUES ('BUDDY_CHAT', 'PRIORITY_LEVEL', 2048770343425916929, NULL, 1, '2026-04-27 22:27:33.134', NULL, NULL, NULL);
INSERT INTO "public"."sys_ai_route" VALUES ('VISION_ENCOURAGE', 'PRIORITY_LEVEL', 2048770343425916929, NULL, 1, '2026-04-27 22:27:38.193', NULL, NULL, NULL);
INSERT INTO "public"."sys_ai_route" VALUES ('default_scene', 'PRIORITY_LEVEL', 2048770343425916929, '{"fallback_model_id": 2002}', 1, '2026-04-27 22:27:43.67', 1, '2026-04-23 09:39:24', NULL);
INSERT INTO "public"."sys_ai_route" VALUES ('TASK_BREAKDOWN', 'PRIORITY_LEVEL', 2048770343425916929, NULL, 1, '2026-04-27 22:27:48.277', NULL, NULL, NULL);
INSERT INTO "public"."sys_ai_route" VALUES ('PARENT_REPORT', 'PRIORITY_LEVEL', 2048770343425916929, NULL, 1, '2026-04-27 22:27:54.177', NULL, NULL, NULL);
INSERT INTO "public"."sys_ai_route" VALUES ('emotion_analysis_scene', 'PRIORITY_LEVEL', 2048770343425916929, '{"fallback_model_id": 2002}', 1, '2026-04-27 22:27:59.267', 1, '2026-04-23 09:39:20', NULL);

-- ----------------------------
-- Table structure for sys_ai_usage
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_ai_usage";
CREATE TABLE "public"."sys_ai_usage" (
  "id" int8 NOT NULL,
  "model_id" int8,
  "child_id" int8,
  "scene_key" varchar(100) COLLATE "pg_catalog"."default",
  "input_tokens" int8,
  "output_tokens" int8,
  "total_tokens" int8,
  "cost" numeric(16,10),
  "status" char(1) COLLATE "pg_catalog"."default" DEFAULT '0'::bpchar,
  "create_by" varchar(64) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "create_time" timestamp(6),
  "update_by" varchar(64) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "update_time" timestamp(6),
  "remark" varchar(500) COLLATE "pg_catalog"."default"
)
;
COMMENT ON TABLE "public"."sys_ai_usage" IS 'AI使用记录表';

-- ----------------------------
-- Records of sys_ai_usage
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
INSERT INTO "public"."sys_dept" VALUES (201, '000000', 0, '0', 'parent_test_final的家庭', NULL, 1, NULL, NULL, NULL, '0', '0', -1, -1, '2026-04-30 01:06:20.761', -1, '2026-04-30 01:06:20.761');

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
INSERT INTO "public"."sys_logininfor" VALUES (2046972872819277826, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-22 23:22:18.452');
INSERT INTO "public"."sys_logininfor" VALUES (2046973349183160321, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-22 23:24:12.034');
INSERT INTO "public"."sys_logininfor" VALUES (2046982887214972929, '000000', 'ken2zhao', '', '', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-23 00:02:06.066');
INSERT INTO "public"."sys_logininfor" VALUES (2047289613302673409, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-23 20:20:55.263');
INSERT INTO "public"."sys_logininfor" VALUES (2047353403176140802, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-24 00:34:23.956');
INSERT INTO "public"."sys_logininfor" VALUES (2047353444645224449, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-24 00:34:33.86');
INSERT INTO "public"."sys_logininfor" VALUES (2047354370588164098, '000000', 'child_xiaoming', '', '', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-24 00:38:14.615');
INSERT INTO "public"."sys_logininfor" VALUES (2047647732033703937, '000000', 'child_xiaoming', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-24 20:03:57.423');
INSERT INTO "public"."sys_logininfor" VALUES (2047647781547462657, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-24 20:04:09.244');
INSERT INTO "public"."sys_logininfor" VALUES (2047649340087914497, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-24 20:10:20.828');
INSERT INTO "public"."sys_logininfor" VALUES (2047649485206638594, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-24 20:10:55.42');
INSERT INTO "public"."sys_logininfor" VALUES (2047677108326608897, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-24 22:00:41.278');
INSERT INTO "public"."sys_logininfor" VALUES (2047681318543798274, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-24 22:17:25.085');
INSERT INTO "public"."sys_logininfor" VALUES (2047681401960116226, '000000', 'ken2zhao', '', '', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-24 22:17:44.966');
INSERT INTO "public"."sys_logininfor" VALUES (2047709445898743809, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-25 00:09:11.171');
INSERT INTO "public"."sys_logininfor" VALUES (2047710005230153729, '000000', 'ken2zhao', '', '', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-25 00:11:24.527');
INSERT INTO "public"."sys_logininfor" VALUES (2047713519767498753, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '密码输入错误1次', '2026-04-25 00:25:22.454');
INSERT INTO "public"."sys_logininfor" VALUES (2047713659634954241, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-25 00:25:55.803');
INSERT INTO "public"."sys_logininfor" VALUES (2047714434276765697, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-25 00:29:00.494');
INSERT INTO "public"."sys_logininfor" VALUES (2047714775663751169, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-25 00:30:21.88');
INSERT INTO "public"."sys_logininfor" VALUES (2047716969196662785, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '退出成功', '2026-04-25 00:39:04.858');
INSERT INTO "public"."sys_logininfor" VALUES (2047716976654135298, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-25 00:39:06.638');
INSERT INTO "public"."sys_logininfor" VALUES (2047717463973539841, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-25 00:41:02.823');
INSERT INTO "public"."sys_logininfor" VALUES (2047717473289089026, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '密码输入错误1次', '2026-04-25 00:41:05.05');
INSERT INTO "public"."sys_logininfor" VALUES (2047719852709359618, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '退出成功', '2026-04-25 00:50:32.347');
INSERT INTO "public"."sys_logininfor" VALUES (2047719863539052546, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-25 00:50:34.932');
INSERT INTO "public"."sys_logininfor" VALUES (2047876417588350978, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-25 11:12:40.307');
INSERT INTO "public"."sys_logininfor" VALUES (2047877098789457922, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-25 11:15:22.736');
INSERT INTO "public"."sys_logininfor" VALUES (2047878138288984065, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '密码输入错误1次', '2026-04-25 11:19:30.572');
INSERT INTO "public"."sys_logininfor" VALUES (2047878191745388546, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '密码输入错误2次', '2026-04-25 11:19:43.31');
INSERT INTO "public"."sys_logininfor" VALUES (2047878284078796802, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-25 11:20:05.319');
INSERT INTO "public"."sys_logininfor" VALUES (2047951150551965697, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-25 16:09:38.036');
INSERT INTO "public"."sys_logininfor" VALUES (2047958990377230337, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-25 16:40:47.216');
INSERT INTO "public"."sys_logininfor" VALUES (2047959001714434050, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-25 16:40:49.907');
INSERT INTO "public"."sys_logininfor" VALUES (2047959012997111810, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-25 16:40:52.601');
INSERT INTO "public"."sys_logininfor" VALUES (2047960224278552577, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-25 16:45:41.396');
INSERT INTO "public"."sys_logininfor" VALUES (2047960234474905601, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-25 16:45:43.828');
INSERT INTO "public"."sys_logininfor" VALUES (2047960285779632130, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-25 16:45:56.049');
INSERT INTO "public"."sys_logininfor" VALUES (2047963130742480898, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-25 16:57:14.343');
INSERT INTO "public"."sys_logininfor" VALUES (2047963567193366529, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-25 16:58:58.414');
INSERT INTO "public"."sys_logininfor" VALUES (2047963788132524034, '000000', 'child_xiaoming', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-25 16:59:51.08');
INSERT INTO "public"."sys_logininfor" VALUES (2047964400345718786, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-25 17:02:17.044');
INSERT INTO "public"."sys_logininfor" VALUES (2048015264179593218, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-25 20:24:23.931');
INSERT INTO "public"."sys_logininfor" VALUES (2048018942567424001, '000000', 'parent_zhang', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-25 20:39:00.926');
INSERT INTO "public"."sys_logininfor" VALUES (2048020321239343105, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-25 20:44:29.632');
INSERT INTO "public"."sys_logininfor" VALUES (2048032296757383170, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '退出成功', '2026-04-25 21:32:04.798');
INSERT INTO "public"."sys_logininfor" VALUES (2048032307540938753, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-25 21:32:07.375');
INSERT INTO "public"."sys_logininfor" VALUES (2048032991506092033, '000000', 'parent_zhang', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-25 21:34:50.444');
INSERT INTO "public"."sys_logininfor" VALUES (2048037711805161473, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-25 21:53:35.856');
INSERT INTO "public"."sys_logininfor" VALUES (2048053920558764033, '000000', 'child_xiaoming', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-25 22:58:00.313');
INSERT INTO "public"."sys_logininfor" VALUES (2048057206355546114, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-25 23:11:03.725');
INSERT INTO "public"."sys_logininfor" VALUES (2048078936960704513, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '密码输入错误1次', '2026-04-26 00:37:24.688');
INSERT INTO "public"."sys_logininfor" VALUES (2048079203525500929, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-26 00:38:28.261');
INSERT INTO "public"."sys_logininfor" VALUES (2048079760805896194, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-26 00:40:41.123');
INSERT INTO "public"."sys_logininfor" VALUES (2048080777580683265, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-26 00:44:43.533');
INSERT INTO "public"."sys_logininfor" VALUES (2048082047032926209, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-26 00:49:46.197');
INSERT INTO "public"."sys_logininfor" VALUES (2048085611960639489, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-26 01:03:56.144');
INSERT INTO "public"."sys_logininfor" VALUES (2048267777835380737, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-26 13:07:47.861');
INSERT INTO "public"."sys_logininfor" VALUES (2048269943857758210, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-26 13:16:24.284');
INSERT INTO "public"."sys_logininfor" VALUES (2048272010500501506, '000000', 'child_xiaoming', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-26 13:24:37.01');
INSERT INTO "public"."sys_logininfor" VALUES (2048272107770605569, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-26 13:25:00.21');
INSERT INTO "public"."sys_logininfor" VALUES (2048284533400399873, '000000', 'parent_zhang', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-26 14:14:22.707');
INSERT INTO "public"."sys_logininfor" VALUES (2048293750802862083, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-26 14:51:00.296');
INSERT INTO "public"."sys_logininfor" VALUES (2048293750802862082, '000000', 'child_xiaohong', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-26 14:51:00.296');
INSERT INTO "public"."sys_logininfor" VALUES (2048293751515893762, '000000', 'parent_zhang', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-26 14:51:00.488');
INSERT INTO "public"."sys_logininfor" VALUES (2048293751515893763, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-26 14:51:00.489');
INSERT INTO "public"."sys_logininfor" VALUES (2048293752153427969, '000000', 'child_xiaohong', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-26 14:51:00.639');
INSERT INTO "public"."sys_logininfor" VALUES (2048293752153427970, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-26 14:51:00.639');
INSERT INTO "public"."sys_logininfor" VALUES (2048293752153427971, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-26 14:51:00.643');
INSERT INTO "public"."sys_logininfor" VALUES (2048293752862265346, '000000', 'parent_zhang', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-26 14:51:00.811');
INSERT INTO "public"."sys_logininfor" VALUES (2048293979056885762, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-26 14:51:54.731');
INSERT INTO "public"."sys_logininfor" VALUES (2048293981732851714, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-26 14:51:55.366');
INSERT INTO "public"."sys_logininfor" VALUES (2048293982114533378, '000000', 'child_xiaohong', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-26 14:51:55.464');
INSERT INTO "public"."sys_logininfor" VALUES (2048293982299082754, '000000', 'parent_zhang', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-26 14:51:55.499');
INSERT INTO "public"."sys_logininfor" VALUES (2048293982890479618, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-26 14:51:55.645');
INSERT INTO "public"."sys_logininfor" VALUES (2048294058698330113, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-26 14:52:13.715');
INSERT INTO "public"."sys_logininfor" VALUES (2048294059017097218, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-26 14:52:13.8');
INSERT INTO "public"."sys_logininfor" VALUES (2048294126046269442, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-26 14:52:29.78');
INSERT INTO "public"."sys_logininfor" VALUES (2048294223102464002, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-26 14:52:52.919');
INSERT INTO "public"."sys_logininfor" VALUES (2048294287455670273, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-26 14:53:08.267');
INSERT INTO "public"."sys_logininfor" VALUES (2048297787791101954, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-26 15:07:02.807');
INSERT INTO "public"."sys_logininfor" VALUES (2048301843922149378, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '密码输入错误1次', '2026-04-26 15:23:09.854');
INSERT INTO "public"."sys_logininfor" VALUES (2048302059500986370, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '密码输入错误2次', '2026-04-26 15:24:01.257');
INSERT INTO "public"."sys_logininfor" VALUES (2048302089037275138, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '密码输入错误3次', '2026-04-26 15:24:08.302');
INSERT INTO "public"."sys_logininfor" VALUES (2048302196008804354, '000000', 'parent_zhang', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-26 15:24:33.812');
INSERT INTO "public"."sys_logininfor" VALUES (2048303206164979714, '000000', 'child_xiaoming', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-26 15:28:34.64');
INSERT INTO "public"."sys_logininfor" VALUES (2048389942027026433, '000000', 'parent_zhang', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-26 21:13:14.08');
INSERT INTO "public"."sys_logininfor" VALUES (2048390015632867330, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-26 21:13:31.643');
INSERT INTO "public"."sys_logininfor" VALUES (2048399240610275329, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-26 21:50:11.03');
INSERT INTO "public"."sys_logininfor" VALUES (2048399383027867649, '000000', 'parent_zhang', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-26 21:50:44.997');
INSERT INTO "public"."sys_logininfor" VALUES (2048400106696302594, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-26 21:53:37.531');
INSERT INTO "public"."sys_logininfor" VALUES (2048401029816475649, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-26 21:57:17.629');
INSERT INTO "public"."sys_logininfor" VALUES (2048401819276763137, '000000', 'child_xiaohong', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-26 22:00:25.839');
INSERT INTO "public"."sys_logininfor" VALUES (2048403986804989953, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-26 22:09:02.629');
INSERT INTO "public"."sys_logininfor" VALUES (2048406614368636929, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-26 22:19:29.074');
INSERT INTO "public"."sys_logininfor" VALUES (2048406842765266945, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-26 22:20:23.542');
INSERT INTO "public"."sys_logininfor" VALUES (2048406842891096065, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-26 22:20:23.572');
INSERT INTO "public"."sys_logininfor" VALUES (2048406905679826946, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-26 22:20:38.545');
INSERT INTO "public"."sys_logininfor" VALUES (2048406906199920642, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-26 22:20:38.658');
INSERT INTO "public"."sys_logininfor" VALUES (2048407219120164866, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-26 22:21:53.267');
INSERT INTO "public"."sys_logininfor" VALUES (2048407220311347201, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-26 22:21:53.549');
INSERT INTO "public"."sys_logininfor" VALUES (2048407494912430081, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-26 22:22:59.02');
INSERT INTO "public"."sys_logininfor" VALUES (2048407495235391489, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-26 22:22:59.098');
INSERT INTO "public"."sys_logininfor" VALUES (2048407735887777793, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-26 22:23:56.472');
INSERT INTO "public"."sys_logininfor" VALUES (2048407736407871490, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-26 22:23:56.598');
INSERT INTO "public"."sys_logininfor" VALUES (2048407890548543490, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-26 22:24:33.355');
INSERT INTO "public"."sys_logininfor" VALUES (2048407891530010625, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-26 22:24:33.581');
INSERT INTO "public"."sys_logininfor" VALUES (2048408046408880129, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-26 22:25:10.508');
INSERT INTO "public"."sys_logininfor" VALUES (2048408047050608642, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-26 22:25:10.657');
INSERT INTO "public"."sys_logininfor" VALUES (2048408233273511937, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-26 22:25:55.069');
INSERT INTO "public"."sys_logininfor" VALUES (2048408234573746178, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-26 22:25:55.368');
INSERT INTO "public"."sys_logininfor" VALUES (2048408505416732674, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-26 22:26:59.938');
INSERT INTO "public"."sys_logininfor" VALUES (2048408505416732675, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-26 22:26:59.938');
INSERT INTO "public"."sys_logininfor" VALUES (2048410917959421954, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-26 22:36:35.138');
INSERT INTO "public"."sys_logininfor" VALUES (2048412746051014658, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-26 22:43:50.984');
INSERT INTO "public"."sys_logininfor" VALUES (2048549345162170369, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 07:46:38.744');
INSERT INTO "public"."sys_logininfor" VALUES (2048549355123642370, '000000', 'parent_zhang', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 07:46:41.137');
INSERT INTO "public"."sys_logininfor" VALUES (2048549994285240322, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 07:49:13.511');
INSERT INTO "public"."sys_logininfor" VALUES (2048550296275128321, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 07:50:25.522');
INSERT INTO "public"."sys_logininfor" VALUES (2048550344518012930, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 07:50:37.018');
INSERT INTO "public"."sys_logininfor" VALUES (2048556309082652674, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 08:14:19.073');
INSERT INTO "public"."sys_logininfor" VALUES (2048557623720132609, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 08:19:32.52');
INSERT INTO "public"."sys_logininfor" VALUES (2048557624101814273, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 08:19:32.606');
INSERT INTO "public"."sys_logininfor" VALUES (2048558586149330946, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 08:23:21.966');
INSERT INTO "public"."sys_logininfor" VALUES (2048558586149330947, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 08:23:21.966');
INSERT INTO "public"."sys_logininfor" VALUES (2048558616167964674, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 08:23:29.133');
INSERT INTO "public"."sys_logininfor" VALUES (2048558786687393793, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 08:24:09.787');
INSERT INTO "public"."sys_logininfor" VALUES (2048558786687393794, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 08:24:09.787');
INSERT INTO "public"."sys_logininfor" VALUES (2048558902504710145, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 08:24:37.409');
INSERT INTO "public"."sys_logininfor" VALUES (2048558902504710146, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 08:24:37.41');
INSERT INTO "public"."sys_logininfor" VALUES (2048559097430794241, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 08:25:23.879');
INSERT INTO "public"."sys_logininfor" VALUES (2048559098592616450, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 08:25:24.15');
INSERT INTO "public"."sys_logininfor" VALUES (2048559182717771778, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 08:25:44.212');
INSERT INTO "public"."sys_logininfor" VALUES (2048559183166562305, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 08:25:44.318');
INSERT INTO "public"."sys_logininfor" VALUES (2048559712378675201, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 08:27:50.492');
INSERT INTO "public"."sys_logininfor" VALUES (2048559712764551169, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 08:27:50.584');
INSERT INTO "public"."sys_logininfor" VALUES (2048559746969100289, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 08:27:58.749');
INSERT INTO "public"."sys_logininfor" VALUES (2048559747099123713, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 08:27:58.766');
INSERT INTO "public"."sys_logininfor" VALUES (2048559782343860225, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 08:28:07.173');
INSERT INTO "public"."sys_logininfor" VALUES (2048559782733930497, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 08:28:07.268');
INSERT INTO "public"."sys_logininfor" VALUES (2048561049698951169, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 08:33:09.333');
INSERT INTO "public"."sys_logininfor" VALUES (2048561050021912577, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 08:33:09.41');
INSERT INTO "public"."sys_logininfor" VALUES (2048561397167677441, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 08:34:32.181');
INSERT INTO "public"."sys_logininfor" VALUES (2048561397557747714, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 08:34:32.273');
INSERT INTO "public"."sys_logininfor" VALUES (2048561571667501058, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 08:35:13.788');
INSERT INTO "public"."sys_logininfor" VALUES (2048561571797524481, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 08:35:13.812');
INSERT INTO "public"."sys_logininfor" VALUES (2048561640189845505, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 08:35:30.117');
INSERT INTO "public"."sys_logininfor" VALUES (2048561639803969538, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 08:35:30.032');
INSERT INTO "public"."sys_logininfor" VALUES (2048562202625040385, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 08:37:44.221');
INSERT INTO "public"."sys_logininfor" VALUES (2048562202885087234, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 08:37:44.284');
INSERT INTO "public"."sys_logininfor" VALUES (2048562889857556481, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 08:40:28.063');
INSERT INTO "public"."sys_logininfor" VALUES (2048562900838244353, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 08:40:30.681');
INSERT INTO "public"."sys_logininfor" VALUES (2048712980924735490, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 18:36:52.549');
INSERT INTO "public"."sys_logininfor" VALUES (2048712990122844162, '000000', 'parent_zhang', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 18:36:54.751');
INSERT INTO "public"."sys_logininfor" VALUES (2048714633740558337, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 18:43:26.631');
INSERT INTO "public"."sys_logininfor" VALUES (2048714634059325441, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 18:43:26.7');
INSERT INTO "public"."sys_logininfor" VALUES (2048714662320545793, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 18:43:33.441');
INSERT INTO "public"."sys_logininfor" VALUES (2048714764112109569, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 18:43:57.702');
INSERT INTO "public"."sys_logininfor" VALUES (2048756617033400321, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 21:30:16.204');
INSERT INTO "public"."sys_logininfor" VALUES (2048756617176006658, '000000', 'parent_zhang', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 21:30:16.256');
INSERT INTO "public"."sys_logininfor" VALUES (2048756617176006660, '000000', 'parent_zhang', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 21:30:16.258');
INSERT INTO "public"."sys_logininfor" VALUES (2048756617176006659, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 21:30:16.258');
INSERT INTO "public"."sys_logininfor" VALUES (2048756744137588738, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 21:30:46.521');
INSERT INTO "public"."sys_logininfor" VALUES (2048756744783511553, '000000', 'parent_zhang', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 21:30:46.681');
INSERT INTO "public"."sys_logininfor" VALUES (2048756746016636930, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 21:30:46.973');
INSERT INTO "public"."sys_logininfor" VALUES (2048756746272489474, '000000', 'parent_zhang', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 21:30:47.036');
INSERT INTO "public"."sys_logininfor" VALUES (2048756841151840257, '000000', 'parent_zhang', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 21:31:09.652');
INSERT INTO "public"."sys_logininfor" VALUES (2048756842179444737, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 21:31:09.907');
INSERT INTO "public"."sys_logininfor" VALUES (2048756842695344129, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 21:31:10.021');
INSERT INTO "public"."sys_logininfor" VALUES (2048756923813183490, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 21:31:29.369');
INSERT INTO "public"."sys_logininfor" VALUES (2048756924849176577, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 21:31:29.609');
INSERT INTO "public"."sys_logininfor" VALUES (2048756924916285442, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 21:31:29.628');
INSERT INTO "public"."sys_logininfor" VALUES (2048756925042114562, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 21:31:29.651');
INSERT INTO "public"."sys_logininfor" VALUES (2048756925235052546, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 21:31:29.702');
INSERT INTO "public"."sys_logininfor" VALUES (2048756925562208257, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 21:31:29.781');
INSERT INTO "public"."sys_logininfor" VALUES (2048756928183648257, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 21:31:30.404');
INSERT INTO "public"."sys_logininfor" VALUES (2048756928313671683, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 21:31:30.439');
INSERT INTO "public"."sys_logininfor" VALUES (2048756928313671682, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 21:31:30.437');
INSERT INTO "public"."sys_logininfor" VALUES (2048756928959594498, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 21:31:30.586');
INSERT INTO "public"."sys_logininfor" VALUES (2048756929215447041, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 21:31:30.645');
INSERT INTO "public"."sys_logininfor" VALUES (2048756929601323009, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 21:31:30.749');
INSERT INTO "public"."sys_logininfor" VALUES (2048757298607800321, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 21:32:58.728');
INSERT INTO "public"."sys_logininfor" VALUES (2048757298733629441, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 21:32:58.752');
INSERT INTO "public"."sys_logininfor" VALUES (2048757298867847170, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 21:32:58.785');
INSERT INTO "public"."sys_logininfor" VALUES (2048757299190808578, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 21:32:58.865');
INSERT INTO "public"."sys_logininfor" VALUES (2048757299702513666, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 21:32:58.984');
INSERT INTO "public"."sys_logininfor" VALUES (2048757301438955521, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 21:32:59.393');
INSERT INTO "public"."sys_logininfor" VALUES (2048757301963243522, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 21:32:59.512');
INSERT INTO "public"."sys_logininfor" VALUES (2048757302114238466, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 21:32:59.555');
INSERT INTO "public"."sys_logininfor" VALUES (2048757302210707458, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 21:32:59.577');
INSERT INTO "public"."sys_logininfor" VALUES (2048757302592389121, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 21:32:59.68');
INSERT INTO "public"."sys_logininfor" VALUES (2048757303032791042, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 21:32:59.783');
INSERT INTO "public"."sys_logininfor" VALUES (2048757304056201218, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 21:33:00.016');
INSERT INTO "public"."sys_logininfor" VALUES (2048757567089393665, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 21:34:02.727');
INSERT INTO "public"."sys_logininfor" VALUES (2048757567412355074, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 21:34:02.811');
INSERT INTO "public"."sys_logininfor" VALUES (2048757568515457025, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 21:34:03.072');
INSERT INTO "public"."sys_logininfor" VALUES (2048757569857634306, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 21:34:03.39');
INSERT INTO "public"."sys_logininfor" VALUES (2048757569983463425, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 21:34:03.426');
INSERT INTO "public"."sys_logininfor" VALUES (2048757570818129921, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 21:34:03.624');
INSERT INTO "public"."sys_logininfor" VALUES (2048757570948153346, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 21:34:03.647');
INSERT INTO "public"."sys_logininfor" VALUES (2048757570948153347, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 21:34:03.647');
INSERT INTO "public"."sys_logininfor" VALUES (2048757797729976321, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 21:34:57.727');
INSERT INTO "public"."sys_logininfor" VALUES (2048757798245875713, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 21:34:57.842');
INSERT INTO "public"."sys_logininfor" VALUES (2048757798245875714, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 21:34:57.843');
INSERT INTO "public"."sys_logininfor" VALUES (2048757799986511874, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 21:34:58.257');
INSERT INTO "public"."sys_logininfor" VALUES (2048757801202860034, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 21:34:58.555');
INSERT INTO "public"."sys_logininfor" VALUES (2048757998276427779, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 21:35:45.535');
INSERT INTO "public"."sys_logininfor" VALUES (2048758003162791938, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 21:35:46.705');
INSERT INTO "public"."sys_logininfor" VALUES (2048758004056178690, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 21:35:46.917');
INSERT INTO "public"."sys_logininfor" VALUES (2048757801399992321, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 21:34:58.602');
INSERT INTO "public"."sys_logininfor" VALUES (2048757801911697409, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 21:34:58.713');
INSERT INTO "public"."sys_logininfor" VALUES (2048757999505358849, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 21:35:45.823');
INSERT INTO "public"."sys_logininfor" VALUES (2048757999958343683, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 21:35:45.937');
INSERT INTO "public"."sys_logininfor" VALUES (2048758003225706498, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 21:35:46.721');
INSERT INTO "public"."sys_logininfor" VALUES (2048757801781673986, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 21:34:58.686');
INSERT INTO "public"."sys_logininfor" VALUES (2048757998276427778, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 21:35:45.535');
INSERT INTO "public"."sys_logininfor" VALUES (2048758002969853954, '000000', 'parent_zhang', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 21:35:46.654');
INSERT INTO "public"."sys_logininfor" VALUES (2048757999505358850, '000000', 'parent_zhang', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 21:35:45.823');
INSERT INTO "public"."sys_logininfor" VALUES (2048757999505358851, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 21:35:45.826');
INSERT INTO "public"."sys_logininfor" VALUES (2048758003611582466, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 21:35:46.813');
INSERT INTO "public"."sys_logininfor" VALUES (2048757999828320258, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 21:35:45.91');
INSERT INTO "public"."sys_logininfor" VALUES (2048757999958343682, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 21:35:45.934');
INSERT INTO "public"."sys_logininfor" VALUES (2048758004765016066, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 21:35:47.079');
INSERT INTO "public"."sys_logininfor" VALUES (2048758012599975938, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 21:35:48.949');
INSERT INTO "public"."sys_logininfor" VALUES (2048761610931126273, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 21:50:06.859');
INSERT INTO "public"."sys_logininfor" VALUES (2048761611254087681, '000000', 'parent_zhang', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 21:50:06.934');
INSERT INTO "public"."sys_logininfor" VALUES (2048761611384111105, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 21:50:06.963');
INSERT INTO "public"."sys_logininfor" VALUES (2048761620510916610, '000000', 'parent_zhang', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 21:50:09.141');
INSERT INTO "public"."sys_logininfor" VALUES (2048761625535692801, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 21:50:10.348');
INSERT INTO "public"."sys_logininfor" VALUES (2048761625598607361, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 21:50:10.361');
INSERT INTO "public"."sys_logininfor" VALUES (2048761625921568769, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 21:50:10.44');
INSERT INTO "public"."sys_logininfor" VALUES (2048761625984483330, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 21:50:10.455');
INSERT INTO "public"."sys_logininfor" VALUES (2048761626701709314, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 21:50:10.626');
INSERT INTO "public"."sys_logininfor" VALUES (2048761627209220098, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 21:50:10.738');
INSERT INTO "public"."sys_logininfor" VALUES (2048761627532181505, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 21:50:10.82');
INSERT INTO "public"."sys_logininfor" VALUES (2048761627859337218, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 21:50:10.893');
INSERT INTO "public"."sys_logininfor" VALUES (2048761628563980290, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 21:50:11.058');
INSERT INTO "public"."sys_logininfor" VALUES (2048761628563980289, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 21:50:11.058');
INSERT INTO "public"."sys_logininfor" VALUES (2048761628769501186, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 21:50:11.107');
INSERT INTO "public"."sys_logininfor" VALUES (2048761629532864514, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 21:50:11.298');
INSERT INTO "public"."sys_logininfor" VALUES (2048761629792911361, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 21:50:11.36');
INSERT INTO "public"."sys_logininfor" VALUES (2048761633127383041, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 21:50:12.155');
INSERT INTO "public"."sys_logininfor" VALUES (2048761634465366017, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 21:50:12.469');
INSERT INTO "public"."sys_logininfor" VALUES (2048761634465366018, '000000', 'parent_zhang', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 21:50:12.473');
INSERT INTO "public"."sys_logininfor" VALUES (2048761635362947074, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 21:50:12.691');
INSERT INTO "public"."sys_logininfor" VALUES (2048761635551690754, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 21:50:12.736');
INSERT INTO "public"."sys_logininfor" VALUES (2048761636130504705, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 21:50:12.875');
INSERT INTO "public"."sys_logininfor" VALUES (2048761644355534850, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 21:50:14.831');
INSERT INTO "public"."sys_logininfor" VALUES (2048761662118412289, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 21:50:19.069');
INSERT INTO "public"."sys_logininfor" VALUES (2048761754627981314, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 21:50:41.122');
INSERT INTO "public"."sys_logininfor" VALUES (2048761755076771841, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 21:50:41.232');
INSERT INTO "public"."sys_logininfor" VALUES (2048761757308141569, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 21:50:41.76');
INSERT INTO "public"."sys_logininfor" VALUES (2048761758990057473, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 21:50:42.159');
INSERT INTO "public"."sys_logininfor" VALUES (2048761758990057474, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 21:50:42.162');
INSERT INTO "public"."sys_logininfor" VALUES (2048761764094525442, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 21:50:43.372');
INSERT INTO "public"."sys_logininfor" VALUES (2048761791210700802, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 21:50:49.849');
INSERT INTO "public"."sys_logininfor" VALUES (2048761792309608449, '000000', 'parent_zhang', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 21:50:50.098');
INSERT INTO "public"."sys_logininfor" VALUES (2048761798747865089, '000000', 'parent_zhang', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 21:50:51.639');
INSERT INTO "public"."sys_logininfor" VALUES (2048761799980990466, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 21:50:51.938');
INSERT INTO "public"."sys_logininfor" VALUES (2048761803642617858, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 21:50:52.809');
INSERT INTO "public"."sys_logininfor" VALUES (2048761803709726722, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 21:50:52.827');
INSERT INTO "public"."sys_logininfor" VALUES (2048761803709726723, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 21:50:52.83');
INSERT INTO "public"."sys_logininfor" VALUES (2048761811074924545, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 21:50:54.584');
INSERT INTO "public"."sys_logininfor" VALUES (2048761811074924546, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 21:50:54.584');
INSERT INTO "public"."sys_logininfor" VALUES (2048761813528592385, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 21:50:55.164');
INSERT INTO "public"."sys_logininfor" VALUES (2048761814170320897, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 21:50:55.32');
INSERT INTO "public"."sys_logininfor" VALUES (2048761814233235458, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 21:50:55.328');
INSERT INTO "public"."sys_logininfor" VALUES (2048761817773228033, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 21:50:56.183');
INSERT INTO "public"."sys_logininfor" VALUES (2048761819526447105, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 21:50:56.589');
INSERT INTO "public"."sys_logininfor" VALUES (2048761824144375810, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 21:50:57.692');
INSERT INTO "public"."sys_logininfor" VALUES (2048761824790298625, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 21:50:57.841');
INSERT INTO "public"."sys_logininfor" VALUES (2048761825176174593, '000000', 'parent_zhang', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 21:50:57.943');
INSERT INTO "public"."sys_logininfor" VALUES (2048761825176174594, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 21:50:57.948');
INSERT INTO "public"."sys_logininfor" VALUES (2048761828519034882, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 21:50:58.743');
INSERT INTO "public"."sys_logininfor" VALUES (2048761830058344449, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 21:50:59.098');
INSERT INTO "public"."sys_logininfor" VALUES (2048761832767864833, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 21:50:59.758');
INSERT INTO "public"."sys_logininfor" VALUES (2048761843069075457, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 21:51:02.211');
INSERT INTO "public"."sys_logininfor" VALUES (2048761844235091969, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 21:51:02.484');
INSERT INTO "public"."sys_logininfor" VALUES (2048761851797422081, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 21:51:04.293');
INSERT INTO "public"."sys_logininfor" VALUES (2048761875658817537, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 21:51:09.98');
INSERT INTO "public"."sys_logininfor" VALUES (2048761881073664002, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 21:51:11.263');
INSERT INTO "public"."sys_logininfor" VALUES (2048761938992807938, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 21:51:25.077');
INSERT INTO "public"."sys_logininfor" VALUES (2048763257359024130, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 21:56:39.389');
INSERT INTO "public"."sys_logininfor" VALUES (2048763261259726849, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 21:56:40.332');
INSERT INTO "public"."sys_logininfor" VALUES (2048763262568349698, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 21:56:40.637');
INSERT INTO "public"."sys_logininfor" VALUES (2048763283040747522, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 21:56:45.526');
INSERT INTO "public"."sys_logininfor" VALUES (2048763326728617985, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 21:56:55.941');
INSERT INTO "public"."sys_logininfor" VALUES (2048761944491540482, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 21:51:26.391');
INSERT INTO "public"."sys_logininfor" VALUES (2048761950741053441, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 21:51:27.874');
INSERT INTO "public"."sys_logininfor" VALUES (2048761951558942721, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 21:51:28.065');
INSERT INTO "public"."sys_logininfor" VALUES (2048763256054595585, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 21:56:39.088');
INSERT INTO "public"."sys_logininfor" VALUES (2048763257627459586, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 21:56:39.461');
INSERT INTO "public"."sys_logininfor" VALUES (2048763258055278594, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 21:56:39.56');
INSERT INTO "public"."sys_logininfor" VALUES (2048763258118193154, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 21:56:39.586');
INSERT INTO "public"."sys_logininfor" VALUES (2048763258118193153, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 21:56:39.586');
INSERT INTO "public"."sys_logininfor" VALUES (2048763258181107713, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 21:56:39.596');
INSERT INTO "public"."sys_logininfor" VALUES (2048763258181107714, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 21:56:39.598');
INSERT INTO "public"."sys_logininfor" VALUES (2048763258571177985, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 21:56:39.692');
INSERT INTO "public"."sys_logininfor" VALUES (2048763258634092545, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 21:56:39.701');
INSERT INTO "public"."sys_logininfor" VALUES (2048763260999680002, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 21:56:40.268');
INSERT INTO "public"."sys_logininfor" VALUES (2048763261393944578, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 21:56:40.365');
INSERT INTO "public"."sys_logininfor" VALUES (2048763282847809537, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 21:56:45.483');
INSERT INTO "public"."sys_logininfor" VALUES (2048763295300698114, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 21:56:48.443');
INSERT INTO "public"."sys_logininfor" VALUES (2048763298521923586, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 21:56:49.21');
INSERT INTO "public"."sys_logininfor" VALUES (2048763305220227073, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 21:56:50.817');
INSERT INTO "public"."sys_logininfor" VALUES (2048763745802502146, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 21:58:35.87');
INSERT INTO "public"."sys_logininfor" VALUES (2048763745907359746, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 21:58:35.87');
INSERT INTO "public"."sys_logininfor" VALUES (2048763746200961026, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 21:58:35.956');
INSERT INTO "public"."sys_logininfor" VALUES (2048763746406481921, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 21:58:36.004');
INSERT INTO "public"."sys_logininfor" VALUES (2048763746406481922, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 21:58:36.011');
INSERT INTO "public"."sys_logininfor" VALUES (2048763746779774978, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 21:58:36.085');
INSERT INTO "public"."sys_logininfor" VALUES (2048763747169845249, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 21:58:36.18');
INSERT INTO "public"."sys_logininfor" VALUES (2048763747169845250, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 21:58:36.186');
INSERT INTO "public"."sys_logininfor" VALUES (2048763747236954113, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 21:58:36.188');
INSERT INTO "public"."sys_logininfor" VALUES (2048763747983540225, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 21:58:36.367');
INSERT INTO "public"."sys_logininfor" VALUES (2048763748893704193, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 21:58:36.584');
INSERT INTO "public"."sys_logininfor" VALUES (2048763748960813058, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 21:58:36.608');
INSERT INTO "public"."sys_logininfor" VALUES (2048763749535432706, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 21:58:36.747');
INSERT INTO "public"."sys_logininfor" VALUES (2048763749858394113, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 21:58:36.813');
INSERT INTO "public"."sys_logininfor" VALUES (2048763763867369474, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 21:58:40.168');
INSERT INTO "public"."sys_logininfor" VALUES (2048763764706230273, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 21:58:40.361');
INSERT INTO "public"."sys_logininfor" VALUES (2048768086408019970, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 22:15:50.745');
INSERT INTO "public"."sys_logininfor" VALUES (2048768086726787074, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 22:15:50.809');
INSERT INTO "public"."sys_logininfor" VALUES (2048768086798090241, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 22:15:50.829');
INSERT INTO "public"."sys_logininfor" VALUES (2048768086865199105, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 22:15:50.839');
INSERT INTO "public"."sys_logininfor" VALUES (2048768087045554178, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 22:15:50.891');
INSERT INTO "public"."sys_logininfor" VALUES (2048768087238492161, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 22:15:50.932');
INSERT INTO "public"."sys_logininfor" VALUES (2048768087301406721, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 22:15:50.944');
INSERT INTO "public"."sys_logininfor" VALUES (2048768087301406722, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 22:15:50.948');
INSERT INTO "public"."sys_logininfor" VALUES (2048768087431430146, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 22:15:50.985');
INSERT INTO "public"."sys_logininfor" VALUES (2048768087620173826, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 22:15:51.02');
INSERT INTO "public"."sys_logininfor" VALUES (2048768087620173827, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 22:15:51.02');
INSERT INTO "public"."sys_logininfor" VALUES (2048768088140267522, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 22:15:51.142');
INSERT INTO "public"."sys_logininfor" VALUES (2048768087620173828, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 22:15:51.024');
INSERT INTO "public"."sys_logininfor" VALUES (2048768088526143489, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 22:15:51.24');
INSERT INTO "public"."sys_logininfor" VALUES (2048768097485176834, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 22:15:53.371');
INSERT INTO "public"."sys_logininfor" VALUES (2048768099825598466, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 22:15:53.937');
INSERT INTO "public"."sys_logininfor" VALUES (2048768099955621889, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 22:15:53.96');
INSERT INTO "public"."sys_logininfor" VALUES (2048768100022730753, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 22:15:53.984');
INSERT INTO "public"."sys_logininfor" VALUES (2048768100085645313, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 22:15:53.993');
INSERT INTO "public"."sys_logininfor" VALUES (2048768107266293761, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 22:15:55.713');
INSERT INTO "public"."sys_logininfor" VALUES (2048768119396220929, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 22:15:58.6');
INSERT INTO "public"."sys_logininfor" VALUES (2048768120042143745, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 22:15:58.76');
INSERT INTO "public"."sys_logininfor" VALUES (2048768122177044481, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 22:15:59.262');
INSERT INTO "public"."sys_logininfor" VALUES (2048768122701332481, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 22:15:59.388');
INSERT INTO "public"."sys_logininfor" VALUES (2048768133304532993, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 22:16:01.917');
INSERT INTO "public"."sys_logininfor" VALUES (2048768135716257794, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 22:16:02.494');
INSERT INTO "public"."sys_logininfor" VALUES (2048768136622227457, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 22:16:02.702');
INSERT INTO "public"."sys_logininfor" VALUES (2048768136622227458, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 22:16:02.702');
INSERT INTO "public"."sys_logininfor" VALUES (2048768163469967362, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 22:16:09.103');
INSERT INTO "public"."sys_logininfor" VALUES (2048768189902471169, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 22:16:15.408');
INSERT INTO "public"."sys_logininfor" VALUES (2048768236186615810, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 22:16:26.448');
INSERT INTO "public"."sys_logininfor" VALUES (2048768140380323842, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 22:16:03.609');
INSERT INTO "public"."sys_logininfor" VALUES (2048768163788734465, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 22:16:09.176');
INSERT INTO "public"."sys_logininfor" VALUES (2048768189902471170, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 22:16:15.409');
INSERT INTO "public"."sys_logininfor" VALUES (2048768217073172481, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 22:16:21.885');
INSERT INTO "public"."sys_logininfor" VALUES (2048768146696945666, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 22:16:05.116');
INSERT INTO "public"."sys_logininfor" VALUES (2048768164094918658, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 22:16:09.255');
INSERT INTO "public"."sys_logininfor" VALUES (2048768190611308546, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 22:16:15.584');
INSERT INTO "public"."sys_logininfor" VALUES (2048768236769624066, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 22:16:26.592');
INSERT INTO "public"."sys_logininfor" VALUES (2048768160592674817, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 22:16:08.422');
INSERT INTO "public"."sys_logininfor" VALUES (2048768163050536961, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 22:16:09.005');
INSERT INTO "public"."sys_logininfor" VALUES (2048768170679975938, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 22:16:10.829');
INSERT INTO "public"."sys_logininfor" VALUES (2048768189713727491, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 22:16:15.367');
INSERT INTO "public"."sys_logininfor" VALUES (2048768213549957121, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 22:16:21.053');
INSERT INTO "public"."sys_logininfor" VALUES (2048768215584194562, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 22:16:21.535');
INSERT INTO "public"."sys_logininfor" VALUES (2048768242423545857, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 22:16:27.938');
INSERT INTO "public"."sys_logininfor" VALUES (2048768160592674818, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 22:16:08.423');
INSERT INTO "public"."sys_logininfor" VALUES (2048768162987622402, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 22:16:08.986');
INSERT INTO "public"."sys_logininfor" VALUES (2048768165042831361, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 22:16:09.479');
INSERT INTO "public"."sys_logininfor" VALUES (2048768189713727490, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 22:16:15.366');
INSERT INTO "public"."sys_logininfor" VALUES (2048768199847165954, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 22:16:17.81');
INSERT INTO "public"."sys_logininfor" VALUES (2048768222236360705, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 22:16:23.121');
INSERT INTO "public"."sys_logininfor" VALUES (2048768240515137537, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 22:16:27.478');
INSERT INTO "public"."sys_logininfor" VALUES (2048768161414758401, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 22:16:08.616');
INSERT INTO "public"."sys_logininfor" VALUES (2048768187222310914, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 22:16:14.777');
INSERT INTO "public"."sys_logininfor" VALUES (2048768213780643842, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 22:16:21.098');
INSERT INTO "public"."sys_logininfor" VALUES (2048768246445883394, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-27 22:16:28.894');
INSERT INTO "public"."sys_logininfor" VALUES (2048770046532108290, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-27 22:23:38.07');
INSERT INTO "public"."sys_logininfor" VALUES (2048913024084926466, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 07:51:46.555');
INSERT INTO "public"."sys_logininfor" VALUES (2048913216460873730, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '退出成功', '2026-04-28 07:52:32.442');
INSERT INTO "public"."sys_logininfor" VALUES (2048913246190100481, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 07:52:39.518');
INSERT INTO "public"."sys_logininfor" VALUES (2048920677511106562, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '密码输入错误1次', '2026-04-28 08:22:11.279');
INSERT INTO "public"."sys_logininfor" VALUES (2048920712982335489, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 08:22:19.739');
INSERT INTO "public"."sys_logininfor" VALUES (2048923449266565122, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '密码输入错误1次', '2026-04-28 08:33:12.115');
INSERT INTO "public"."sys_logininfor" VALUES (2048923515209412610, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 08:33:27.848');
INSERT INTO "public"."sys_logininfor" VALUES (2048923985877430274, '000000', 'admin', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 08:35:20.061');
INSERT INTO "public"."sys_logininfor" VALUES (2049042024140673026, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 16:24:22.569');
INSERT INTO "public"."sys_logininfor" VALUES (2049042112904728577, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 16:24:43.736');
INSERT INTO "public"."sys_logininfor" VALUES (2049042378030878722, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 16:25:46.958');
INSERT INTO "public"."sys_logininfor" VALUES (2049042378420948994, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 16:25:47.054');
INSERT INTO "public"."sys_logininfor" VALUES (2049047096648044545, '000000', 'parent_zhang', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 16:44:31.959');
INSERT INTO "public"."sys_logininfor" VALUES (2049047096836788226, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 16:44:31.998');
INSERT INTO "public"."sys_logininfor" VALUES (2049047112544456705, '000000', 'parent_zhang', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 16:44:35.751');
INSERT INTO "public"."sys_logininfor" VALUES (2049047112674480130, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 16:44:35.787');
INSERT INTO "public"."sys_logininfor" VALUES (2049047122711449602, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 16:44:38.171');
INSERT INTO "public"."sys_logininfor" VALUES (2049047131574013953, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 16:44:40.29');
INSERT INTO "public"."sys_logininfor" VALUES (2049047135395024897, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 16:44:41.202');
INSERT INTO "public"."sys_logininfor" VALUES (2049047138716913666, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 16:44:41.994');
INSERT INTO "public"."sys_logininfor" VALUES (2049047145071284226, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 16:44:43.511');
INSERT INTO "public"."sys_logininfor" VALUES (2049047148560945154, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 16:44:44.34');
INSERT INTO "public"."sys_logininfor" VALUES (2049047152319041538, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 16:44:45.237');
INSERT INTO "public"."sys_logininfor" VALUES (2049047155229888513, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 16:44:45.922');
INSERT INTO "public"."sys_logininfor" VALUES (2049047159533244418, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 16:44:46.954');
INSERT INTO "public"."sys_logininfor" VALUES (2049047176562118657, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 16:44:51.018');
INSERT INTO "public"."sys_logininfor" VALUES (2049047196099186690, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 16:44:55.669');
INSERT INTO "public"."sys_logininfor" VALUES (2049047196162101249, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 16:44:55.68');
INSERT INTO "public"."sys_logininfor" VALUES (2049047210447900673, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 16:44:59.088');
INSERT INTO "public"."sys_logininfor" VALUES (2049047218589044737, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 16:45:01.027');
INSERT INTO "public"."sys_logininfor" VALUES (2049047269918937090, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 16:45:13.265');
INSERT INTO "public"."sys_logininfor" VALUES (2049047294526918657, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 16:45:19.131');
INSERT INTO "public"."sys_logininfor" VALUES (2049047304740048897, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 16:45:21.577');
INSERT INTO "public"."sys_logininfor" VALUES (2049047317922746370, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 16:45:24.716');
INSERT INTO "public"."sys_logininfor" VALUES (2049047329348030465, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 16:45:27.444');
INSERT INTO "public"."sys_logininfor" VALUES (2049047344908898305, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 16:45:31.149');
INSERT INTO "public"."sys_logininfor" VALUES (2049047357890269185, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 16:45:34.242');
INSERT INTO "public"."sys_logininfor" VALUES (2049047358280339458, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 16:45:34.333');
INSERT INTO "public"."sys_logininfor" VALUES (2049047366811553794, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 16:45:36.376');
INSERT INTO "public"."sys_logininfor" VALUES (2049047369978253314, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 16:45:37.128');
INSERT INTO "public"."sys_logininfor" VALUES (2049047391285317633, '000000', 'parent_zhang', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 16:45:42.211');
INSERT INTO "public"."sys_logininfor" VALUES (2049047400500203522, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 16:45:44.4');
INSERT INTO "public"."sys_logininfor" VALUES (2049047416023322625, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 16:45:48.11');
INSERT INTO "public"."sys_logininfor" VALUES (2049047418271469570, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 16:45:48.641');
INSERT INTO "public"."sys_logininfor" VALUES (2049047427985477633, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 16:45:50.956');
INSERT INTO "public"."sys_logininfor" VALUES (2049047431651299329, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 16:45:51.835');
INSERT INTO "public"."sys_logininfor" VALUES (2049047440874573825, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 16:45:54.031');
INSERT INTO "public"."sys_logininfor" VALUES (2049047447455436802, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 16:45:55.602');
INSERT INTO "public"."sys_logininfor" VALUES (2049047457232359426, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 16:45:57.931');
INSERT INTO "public"."sys_logininfor" VALUES (2049047461481189377, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 16:45:58.945');
INSERT INTO "public"."sys_logininfor" VALUES (2049047474991042562, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 16:46:02.156');
INSERT INTO "public"."sys_logininfor" VALUES (2049047493336928258, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 16:46:06.537');
INSERT INTO "public"."sys_logininfor" VALUES (2049047494687494145, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 16:46:06.856');
INSERT INTO "public"."sys_logininfor" VALUES (2049047522466369537, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 16:46:13.479');
INSERT INTO "public"."sys_logininfor" VALUES (2049047541839859713, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 16:46:18.108');
INSERT INTO "public"."sys_logininfor" VALUES (2049047570155606017, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 16:46:24.846');
INSERT INTO "public"."sys_logininfor" VALUES (2049047590154047489, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 16:46:29.614');
INSERT INTO "public"."sys_logininfor" VALUES (2049047617907757057, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 16:46:36.233');
INSERT INTO "public"."sys_logininfor" VALUES (2049047523493974017, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 16:46:13.72');
INSERT INTO "public"."sys_logininfor" VALUES (2049047631610548225, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 16:46:39.504');
INSERT INTO "public"."sys_logininfor" VALUES (2049047647926390785, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 16:46:43.39');
INSERT INTO "public"."sys_logininfor" VALUES (2049047648312266753, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 16:46:43.49');
INSERT INTO "public"."sys_logininfor" VALUES (2049047655031541761, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 16:46:45.082');
INSERT INTO "public"."sys_logininfor" VALUES (2049047660681269250, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 16:46:46.435');
INSERT INTO "public"."sys_logininfor" VALUES (2049047687478677505, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 16:46:52.825');
INSERT INTO "public"."sys_logininfor" VALUES (2049047687864553474, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 16:46:52.916');
INSERT INTO "public"."sys_logininfor" VALUES (2049047803245662210, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 16:47:20.432');
INSERT INTO "public"."sys_logininfor" VALUES (2049047830663827458, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 16:47:26.966');
INSERT INTO "public"."sys_logininfor" VALUES (2049047876155248642, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 16:47:37.807');
INSERT INTO "public"."sys_logininfor" VALUES (2049047938235142145, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 16:47:52.612');
INSERT INTO "public"."sys_logininfor" VALUES (2049047941628334082, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 16:47:53.423');
INSERT INTO "public"."sys_logininfor" VALUES (2049047955880579073, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 16:47:56.809');
INSERT INTO "public"."sys_logininfor" VALUES (2049048007877365762, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 16:48:09.22');
INSERT INTO "public"."sys_logininfor" VALUES (2049048013715836929, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 16:48:10.605');
INSERT INTO "public"."sys_logininfor" VALUES (2049048029238956033, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 16:48:14.31');
INSERT INTO "public"."sys_logininfor" VALUES (2049048045265391617, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 16:48:18.12');
INSERT INTO "public"."sys_logininfor" VALUES (2049048067713306626, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 16:48:23.476');
INSERT INTO "public"."sys_logininfor" VALUES (2049048071194578946, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 16:48:24.314');
INSERT INTO "public"."sys_logininfor" VALUES (2049048080048754690, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 16:48:26.417');
INSERT INTO "public"."sys_logininfor" VALUES (2049048099380301826, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 16:48:31.028');
INSERT INTO "public"."sys_logininfor" VALUES (2049048107680829442, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 16:48:33.006');
INSERT INTO "public"."sys_logininfor" VALUES (2049048117654884353, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 16:48:35.389');
INSERT INTO "public"."sys_logininfor" VALUES (2049048128539103234, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 16:48:37.989');
INSERT INTO "public"."sys_logininfor" VALUES (2049048266028388354, '000000', 'parent_zhang', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 16:49:10.761');
INSERT INTO "public"."sys_logininfor" VALUES (2049048326694801409, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 16:49:25.225');
INSERT INTO "public"."sys_logininfor" VALUES (2049048329605648386, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 16:49:25.917');
INSERT INTO "public"."sys_logininfor" VALUES (2049048352191975426, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 16:49:31.305');
INSERT INTO "public"."sys_logininfor" VALUES (2049048393212268545, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 16:49:41.082');
INSERT INTO "public"."sys_logininfor" VALUES (2049048424203980802, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 16:49:48.473');
INSERT INTO "public"."sys_logininfor" VALUES (2049048428146626561, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 16:49:49.411');
INSERT INTO "public"."sys_logininfor" VALUES (2049047803954499585, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 16:47:20.587');
INSERT INTO "public"."sys_logininfor" VALUES (2049047830340866050, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 16:47:26.889');
INSERT INTO "public"."sys_logininfor" VALUES (2049047851727622146, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 16:47:31.985');
INSERT INTO "public"."sys_logininfor" VALUES (2049047872724307969, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 16:47:36.988');
INSERT INTO "public"."sys_logininfor" VALUES (2049048093428584450, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 16:48:29.609');
INSERT INTO "public"."sys_logininfor" VALUES (2049048107949264898, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 16:48:33.067');
INSERT INTO "public"."sys_logininfor" VALUES (2049048117717798913, '000000', 'ken2zhao', 'pc', 'pc', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 16:48:35.4');
INSERT INTO "public"."sys_logininfor" VALUES (2049048122868404225, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 16:48:36.629');
INSERT INTO "public"."sys_logininfor" VALUES (2049048220125925378, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 16:48:59.813');
INSERT INTO "public"."sys_logininfor" VALUES (2049048257048383490, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 16:49:08.625');
INSERT INTO "public"."sys_logininfor" VALUES (2049048281366958081, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 16:49:14.417');
INSERT INTO "public"."sys_logininfor" VALUES (2049048304595013634, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 16:49:19.955');
INSERT INTO "public"."sys_logininfor" VALUES (2049048311570141186, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 16:49:21.625');
INSERT INTO "public"."sys_logininfor" VALUES (2049048311691776001, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 16:49:21.646');
INSERT INTO "public"."sys_logininfor" VALUES (2049048329605648385, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 16:49:25.916');
INSERT INTO "public"."sys_logininfor" VALUES (2049048354117160961, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 16:49:31.763');
INSERT INTO "public"."sys_logininfor" VALUES (2049048394768355329, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 16:49:41.449');
INSERT INTO "public"."sys_logininfor" VALUES (2049048489488322562, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 16:50:04.045');
INSERT INTO "public"."sys_logininfor" VALUES (2049048496916434945, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 16:50:05.816');
INSERT INTO "public"."sys_logininfor" VALUES (2049048510912827394, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 16:50:09.152');
INSERT INTO "public"."sys_logininfor" VALUES (2049048531724963841, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 16:50:14.106');
INSERT INTO "public"."sys_logininfor" VALUES (2049048552826507266, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 16:50:19.134');
INSERT INTO "public"."sys_logininfor" VALUES (2049048562909614082, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 16:50:21.549');
INSERT INTO "public"."sys_logininfor" VALUES (2049048576117477378, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 16:50:24.696');
INSERT INTO "public"."sys_logininfor" VALUES (2049048576763400194, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 16:50:24.84');
INSERT INTO "public"."sys_logininfor" VALUES (2049048594593386498, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 16:50:29.111');
INSERT INTO "public"."sys_logininfor" VALUES (2049048617053884417, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 16:50:34.458');
INSERT INTO "public"."sys_logininfor" VALUES (2049048630882504705, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 16:50:37.75');
INSERT INTO "public"."sys_logininfor" VALUES (2049048663723905026, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 16:50:45.578');
INSERT INTO "public"."sys_logininfor" VALUES (2049048677799989249, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 16:50:48.946');
INSERT INTO "public"."sys_logininfor" VALUES (2049048678475272193, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 16:50:49.092');
INSERT INTO "public"."sys_logininfor" VALUES (2049048689346908162, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 16:50:51.7');
INSERT INTO "public"."sys_logininfor" VALUES (2049048732317552641, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 16:51:01.939');
INSERT INTO "public"."sys_logininfor" VALUES (2049048752039170050, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 16:51:06.634');
INSERT INTO "public"."sys_logininfor" VALUES (2049048759593111554, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 16:51:08.439');
INSERT INTO "public"."sys_logininfor" VALUES (2049048782041026562, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 16:51:13.793');
INSERT INTO "public"."sys_logininfor" VALUES (2049048812256792578, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 16:51:21.001');
INSERT INTO "public"."sys_logininfor" VALUES (2049048844569710593, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 16:51:28.697');
INSERT INTO "public"."sys_logininfor" VALUES (2049048900500754434, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 16:51:42.031');
INSERT INTO "public"."sys_logininfor" VALUES (2049048912441937922, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 16:51:44.875');
INSERT INTO "public"."sys_logininfor" VALUES (2049048941760122882, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 16:51:51.872');
INSERT INTO "public"."sys_logininfor" VALUES (2049048958902243330, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 16:51:55.961');
INSERT INTO "public"."sys_logininfor" VALUES (2049048995212333057, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 16:52:04.616');
INSERT INTO "public"."sys_logininfor" VALUES (2049048998110597122, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 16:52:05.317');
INSERT INTO "public"."sys_logininfor" VALUES (2049049043266473985, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 16:52:16.062');
INSERT INTO "public"."sys_logininfor" VALUES (2049049043098701826, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 16:52:16.032');
INSERT INTO "public"."sys_logininfor" VALUES (2049049043392303106, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 16:52:16.099');
INSERT INTO "public"."sys_logininfor" VALUES (2049049063415910402, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 16:52:20.874');
INSERT INTO "public"."sys_logininfor" VALUES (2049049078909669378, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 16:52:24.574');
INSERT INTO "public"."sys_logininfor" VALUES (2049049105463808002, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 16:52:30.901');
INSERT INTO "public"."sys_logininfor" VALUES (2049049106432692225, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 16:52:31.127');
INSERT INTO "public"."sys_logininfor" VALUES (2049049114905186305, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 16:52:33.147');
INSERT INTO "public"."sys_logininfor" VALUES (2049049192193626113, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 16:52:51.577');
INSERT INTO "public"."sys_logininfor" VALUES (2049049213622325250, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 16:52:56.689');
INSERT INTO "public"."sys_logininfor" VALUES (2049049257482162177, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 16:53:07.164');
INSERT INTO "public"."sys_logininfor" VALUES (2049049258333605889, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 16:53:07.341');
INSERT INTO "public"."sys_logininfor" VALUES (2049049295247675393, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 16:53:16.151');
INSERT INTO "public"."sys_logininfor" VALUES (2049049321420132354, '000000', 'child_xiaoming', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 16:53:22.395');
INSERT INTO "public"."sys_logininfor" VALUES (2049049337396236289, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 16:53:26.195');
INSERT INTO "public"."sys_logininfor" VALUES (2049049337555619842, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 16:53:26.232');
INSERT INTO "public"."sys_logininfor" VALUES (2049049341628289025, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 16:53:27.202');
INSERT INTO "public"."sys_logininfor" VALUES (2049049375119806465, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 16:53:35.182');
INSERT INTO "public"."sys_logininfor" VALUES (2049049399434186754, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 16:53:40.981');
INSERT INTO "public"."sys_logininfor" VALUES (2049049458427072514, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 16:53:55.052');
INSERT INTO "public"."sys_logininfor" VALUES (2049049477485989889, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 16:53:59.589');
INSERT INTO "public"."sys_logininfor" VALUES (2049049514416836609, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 16:54:08.395');
INSERT INTO "public"."sys_logininfor" VALUES (2049049518871187458, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 16:54:09.462');
INSERT INTO "public"."sys_logininfor" VALUES (2049049583434108929, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 16:54:24.859');
INSERT INTO "public"."sys_logininfor" VALUES (2049049596272873474, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 16:54:27.917');
INSERT INTO "public"."sys_logininfor" VALUES (2049049638815698946, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 16:54:38.063');
INSERT INTO "public"."sys_logininfor" VALUES (2049053207086272513, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:08:48.798');
INSERT INTO "public"."sys_logininfor" VALUES (2049053208311009281, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:08:49.091');
INSERT INTO "public"."sys_logininfor" VALUES (2049053212811497474, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:08:50.159');
INSERT INTO "public"."sys_logininfor" VALUES (2049053229643239425, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:08:54.179');
INSERT INTO "public"."sys_logininfor" VALUES (2049053308525514754, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:09:12.99');
INSERT INTO "public"."sys_logininfor" VALUES (2049053325030100993, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:09:16.915');
INSERT INTO "public"."sys_logininfor" VALUES (2049049555718148098, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 16:54:18.251');
INSERT INTO "public"."sys_logininfor" VALUES (2049049625893048321, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 16:54:34.978');
INSERT INTO "public"."sys_logininfor" VALUES (2049053187398209537, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:08:44.113');
INSERT INTO "public"."sys_logininfor" VALUES (2049053243476054017, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:08:57.475');
INSERT INTO "public"."sys_logininfor" VALUES (2049053298266247170, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:09:10.538');
INSERT INTO "public"."sys_logininfor" VALUES (2049053304582868993, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:09:12.048');
INSERT INTO "public"."sys_logininfor" VALUES (2049049555718148097, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 16:54:18.248');
INSERT INTO "public"."sys_logininfor" VALUES (2049049556892553217, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 16:54:18.526');
INSERT INTO "public"."sys_logininfor" VALUES (2049049596914601985, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 16:54:28.082');
INSERT INTO "public"."sys_logininfor" VALUES (2049049625595252738, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 16:54:34.901');
INSERT INTO "public"."sys_logininfor" VALUES (2049049559329443841, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 16:54:19.114');
INSERT INTO "public"."sys_logininfor" VALUES (2049053187612119042, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:08:44.159');
INSERT INTO "public"."sys_logininfor" VALUES (2049053187658256385, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:08:44.171');
INSERT INTO "public"."sys_logininfor" VALUES (2049053187658256386, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:08:44.173');
INSERT INTO "public"."sys_logininfor" VALUES (2049053243920650242, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:08:57.58');
INSERT INTO "public"."sys_logininfor" VALUES (2049053267832377345, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:09:03.291');
INSERT INTO "public"."sys_logininfor" VALUES (2049053274908168194, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:09:04.972');
INSERT INTO "public"."sys_logininfor" VALUES (2049060728668721154, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:38:42.081');
INSERT INTO "public"."sys_logininfor" VALUES (2049061050195677186, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:39:58.737');
INSERT INTO "public"."sys_logininfor" VALUES (2049061050195677185, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:39:58.737');
INSERT INTO "public"."sys_logininfor" VALUES (2049061050875154433, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:39:58.914');
INSERT INTO "public"."sys_logininfor" VALUES (2049061050938068993, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:39:58.915');
INSERT INTO "public"."sys_logininfor" VALUES (2049061093992599553, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:40:09.185');
INSERT INTO "public"."sys_logininfor" VALUES (2049061093992599554, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:40:09.186');
INSERT INTO "public"."sys_logininfor" VALUES (2049061097276739585, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:40:09.966');
INSERT INTO "public"."sys_logininfor" VALUES (2049061099772350465, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:40:10.571');
INSERT INTO "public"."sys_logininfor" VALUES (2049061142558445570, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:40:20.766');
INSERT INTO "public"."sys_logininfor" VALUES (2049061142873018369, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:40:20.838');
INSERT INTO "public"."sys_logininfor" VALUES (2049061175081078786, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:40:28.518');
INSERT INTO "public"."sys_logininfor" VALUES (2049061196593664001, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:40:33.648');
INSERT INTO "public"."sys_logininfor" VALUES (2049061197365415937, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:40:33.836');
INSERT INTO "public"."sys_logininfor" VALUES (2049061226440331266, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:40:40.762');
INSERT INTO "public"."sys_logininfor" VALUES (2049061265027928065, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:40:49.966');
INSERT INTO "public"."sys_logininfor" VALUES (2049061277363376130, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:40:52.898');
INSERT INTO "public"."sys_logininfor" VALUES (2049061339988529154, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:41:07.836');
INSERT INTO "public"."sys_logininfor" VALUES (2049061340055638018, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:41:07.854');
INSERT INTO "public"."sys_logininfor" VALUES (2049061340563148802, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:41:07.969');
INSERT INTO "public"."sys_logininfor" VALUES (2049061342039543810, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:41:08.331');
INSERT INTO "public"."sys_logininfor" VALUES (2049061383726731265, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:41:18.258');
INSERT INTO "public"."sys_logininfor" VALUES (2049061388059447298, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:41:19.295');
INSERT INTO "public"."sys_logininfor" VALUES (2049061389728780290, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:41:19.697');
INSERT INTO "public"."sys_logininfor" VALUES (2049061389728780289, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:41:19.697');
INSERT INTO "public"."sys_logininfor" VALUES (2049061435534774274, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:41:30.616');
INSERT INTO "public"."sys_logininfor" VALUES (2049061442690256898, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:41:32.319');
INSERT INTO "public"."sys_logininfor" VALUES (2049061472117493761, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:41:39.34');
INSERT INTO "public"."sys_logininfor" VALUES (2049061518779125762, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:41:50.466');
INSERT INTO "public"."sys_logininfor" VALUES (2049061570679443457, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:42:02.832');
INSERT INTO "public"."sys_logininfor" VALUES (2049061583711145986, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:42:05.95');
INSERT INTO "public"."sys_logininfor" VALUES (2049061598215049217, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:42:09.397');
INSERT INTO "public"."sys_logininfor" VALUES (2049061624509140994, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:42:15.669');
INSERT INTO "public"."sys_logininfor" VALUES (2049061889945669634, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:43:18.954');
INSERT INTO "public"."sys_logininfor" VALUES (2049061891111686145, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:43:19.232');
INSERT INTO "public"."sys_logininfor" VALUES (2049061891304624129, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:43:19.286');
INSERT INTO "public"."sys_logininfor" VALUES (2049061891304624130, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:43:19.286');
INSERT INTO "public"."sys_logininfor" VALUES (2049061921419726849, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:43:26.457');
INSERT INTO "public"."sys_logininfor" VALUES (2049061926662606850, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:43:27.712');
INSERT INTO "public"."sys_logininfor" VALUES (2049061936036876290, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:43:29.944');
INSERT INTO "public"."sys_logininfor" VALUES (2049061937102229506, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:43:30.196');
INSERT INTO "public"."sys_logininfor" VALUES (2049061974414757890, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:43:39.09');
INSERT INTO "public"."sys_logininfor" VALUES (2049061976797122561, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:43:39.662');
INSERT INTO "public"."sys_logininfor" VALUES (2049061982975332353, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:43:41.13');
INSERT INTO "public"."sys_logininfor" VALUES (2049062020115894273, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:43:49.99');
INSERT INTO "public"."sys_logininfor" VALUES (2049062047911546882, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:43:56.62');
INSERT INTO "public"."sys_logininfor" VALUES (2049062049647988737, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:43:57.028');
INSERT INTO "public"."sys_logininfor" VALUES (2049062071739387906, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:44:02.294');
INSERT INTO "public"."sys_logininfor" VALUES (2049062083064008705, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:44:05.004');
INSERT INTO "public"."sys_logininfor" VALUES (2049062218049294338, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:44:37.177');
INSERT INTO "public"."sys_logininfor" VALUES (2049062218527444994, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:44:37.299');
INSERT INTO "public"."sys_logininfor" VALUES (2049062219391471618, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:44:37.498');
INSERT INTO "public"."sys_logininfor" VALUES (2049062240056807425, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:44:42.433');
INSERT INTO "public"."sys_logininfor" VALUES (2049062263096119298, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:44:47.928');
INSERT INTO "public"."sys_logininfor" VALUES (2049062263096119297, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:44:47.927');
INSERT INTO "public"."sys_logininfor" VALUES (2049062307757068289, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:44:58.572');
INSERT INTO "public"."sys_logininfor" VALUES (2049062324580421633, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:45:02.577');
INSERT INTO "public"."sys_logininfor" VALUES (2049062359166652418, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:45:10.821');
INSERT INTO "public"."sys_logininfor" VALUES (2049062368129880066, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:45:12.967');
INSERT INTO "public"."sys_logininfor" VALUES (2049062370113785858, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:45:13.43');
INSERT INTO "public"."sys_logininfor" VALUES (2049062409892564994, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:45:22.923');
INSERT INTO "public"."sys_logininfor" VALUES (2049062421435289602, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:45:25.667');
INSERT INTO "public"."sys_logininfor" VALUES (2049062446517227522, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:45:31.661');
INSERT INTO "public"."sys_logininfor" VALUES (2049062449155444738, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:45:32.284');
INSERT INTO "public"."sys_logininfor" VALUES (2049062495129210881, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:45:43.236');
INSERT INTO "public"."sys_logininfor" VALUES (2049062508186079233, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:45:46.354');
INSERT INTO "public"."sys_logininfor" VALUES (2049062573596250113, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:46:01.945');
INSERT INTO "public"."sys_logininfor" VALUES (2049062575072645122, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:46:02.297');
INSERT INTO "public"."sys_logininfor" VALUES (2049062604608933890, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:46:09.343');
INSERT INTO "public"."sys_logininfor" VALUES (2049062630563287042, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:46:15.538');
INSERT INTO "public"."sys_logininfor" VALUES (2049062657478135810, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:46:21.954');
INSERT INTO "public"."sys_logininfor" VALUES (2049062704022327298, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:46:33.044');
INSERT INTO "public"."sys_logininfor" VALUES (2049062715451805697, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:46:35.77');
INSERT INTO "public"."sys_logininfor" VALUES (2049062753569640450, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:46:44.867');
INSERT INTO "public"."sys_logininfor" VALUES (2049062785496682497, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:46:52.474');
INSERT INTO "public"."sys_logininfor" VALUES (2049063330764591106, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:49:02.477');
INSERT INTO "public"."sys_logininfor" VALUES (2049063376830631938, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:49:13.46');
INSERT INTO "public"."sys_logininfor" VALUES (2049063382539079682, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:49:14.819');
INSERT INTO "public"."sys_logininfor" VALUES (2049063404177494017, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:49:19.972');
INSERT INTO "public"."sys_logininfor" VALUES (2049063409193881602, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:49:21.169');
INSERT INTO "public"."sys_logininfor" VALUES (2049063451774455809, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:49:31.324');
INSERT INTO "public"."sys_logininfor" VALUES (2049063463329763330, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:49:34.081');
INSERT INTO "public"."sys_logininfor" VALUES (2049063474176233474, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:49:36.668');
INSERT INTO "public"."sys_logininfor" VALUES (2049063495353274370, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:49:41.708');
INSERT INTO "public"."sys_logininfor" VALUES (2049063536876883969, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:49:51.617');
INSERT INTO "public"."sys_logininfor" VALUES (2049063586893959170, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:50:03.539');
INSERT INTO "public"."sys_logininfor" VALUES (2049063600164737025, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:50:06.699');
INSERT INTO "public"."sys_logininfor" VALUES (2049063645807153154, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:50:17.58');
INSERT INTO "public"."sys_logininfor" VALUES (2049063658419425281, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:50:20.597');
INSERT INTO "public"."sys_logininfor" VALUES (2049063704661626881, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:50:31.62');
INSERT INTO "public"."sys_logininfor" VALUES (2049063726954352642, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:50:36.934');
INSERT INTO "public"."sys_logininfor" VALUES (2049063739503710209, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:50:39.922');
INSERT INTO "public"."sys_logininfor" VALUES (2049063805178122241, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:50:55.592');
INSERT INTO "public"."sys_logininfor" VALUES (2049063826413883394, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:51:00.653');
INSERT INTO "public"."sys_logininfor" VALUES (2049063959054553089, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:51:32.273');
INSERT INTO "public"."sys_logininfor" VALUES (2049063968491737090, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:51:34.516');
INSERT INTO "public"."sys_logininfor" VALUES (2049063985151512578, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:51:38.5');
INSERT INTO "public"."sys_logininfor" VALUES (2049064067204681730, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:51:58.06');
INSERT INTO "public"."sys_logininfor" VALUES (2049064069066952706, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:51:58.494');
INSERT INTO "public"."sys_logininfor" VALUES (2049064070623039489, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:51:58.868');
INSERT INTO "public"."sys_logininfor" VALUES (2049064125555838978, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:52:11.96');
INSERT INTO "public"."sys_logininfor" VALUES (2049064187786727425, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:52:26.807');
INSERT INTO "public"."sys_logininfor" VALUES (2049064189518974978, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:52:27.214');
INSERT INTO "public"."sys_logininfor" VALUES (2049064221198553089, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:52:34.771');
INSERT INTO "public"."sys_logininfor" VALUES (2049064250776784898, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:52:41.821');
INSERT INTO "public"."sys_logininfor" VALUES (2049064259651932162, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:52:43.932');
INSERT INTO "public"."sys_logininfor" VALUES (2049064322079952898, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:52:58.821');
INSERT INTO "public"."sys_logininfor" VALUES (2049062283618848770, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:44:52.814');
INSERT INTO "public"."sys_logininfor" VALUES (2049062288517795842, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:44:53.984');
INSERT INTO "public"."sys_logininfor" VALUES (2049062336056037378, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:45:05.329');
INSERT INTO "public"."sys_logininfor" VALUES (2049062393035657217, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:45:18.913');
INSERT INTO "public"."sys_logininfor" VALUES (2049062395812286465, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:45:19.566');
INSERT INTO "public"."sys_logininfor" VALUES (2049062526632628225, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:45:50.753');
INSERT INTO "public"."sys_logininfor" VALUES (2049062534526308353, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:45:52.635');
INSERT INTO "public"."sys_logininfor" VALUES (2049062735597047809, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:46:40.574');
INSERT INTO "public"."sys_logininfor" VALUES (2049062761488486401, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:46:46.747');
INSERT INTO "public"."sys_logininfor" VALUES (2049063330764591107, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:49:02.477');
INSERT INTO "public"."sys_logininfor" VALUES (2049063330764591108, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:49:02.478');
INSERT INTO "public"."sys_logininfor" VALUES (2049063330764591109, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:49:02.479');
INSERT INTO "public"."sys_logininfor" VALUES (2049063375496843266, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:49:13.137');
INSERT INTO "public"."sys_logininfor" VALUES (2049063408224997377, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:49:20.95');
INSERT INTO "public"."sys_logininfor" VALUES (2049063409764306945, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:49:21.307');
INSERT INTO "public"."sys_logininfor" VALUES (2049063442773479426, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:49:29.173');
INSERT INTO "public"."sys_logininfor" VALUES (2049063442710564865, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:49:29.168');
INSERT INTO "public"."sys_logininfor" VALUES (2049063487103078401, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:49:39.749');
INSERT INTO "public"."sys_logininfor" VALUES (2049063495353274371, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:49:41.709');
INSERT INTO "public"."sys_logininfor" VALUES (2049063527804604418, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:49:49.453');
INSERT INTO "public"."sys_logininfor" VALUES (2049063536176435201, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:49:51.459');
INSERT INTO "public"."sys_logininfor" VALUES (2049063615637524481, '000000', 'ken2zhao', 'pc', 'pc', '127.0.0.1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:50:10.399');
INSERT INTO "public"."sys_logininfor" VALUES (2049063650471219202, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:50:18.698');
INSERT INTO "public"."sys_logininfor" VALUES (2049063651184250881, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:50:18.871');
INSERT INTO "public"."sys_logininfor" VALUES (2049063726954352643, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:50:36.935');
INSERT INTO "public"."sys_logininfor" VALUES (2049063739503710211, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:50:39.932');
INSERT INTO "public"."sys_logininfor" VALUES (2049063739503710210, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:50:39.931');
INSERT INTO "public"."sys_logininfor" VALUES (2049063755576283138, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:50:43.75');
INSERT INTO "public"."sys_logininfor" VALUES (2049063972304359425, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:51:35.433');
INSERT INTO "public"."sys_logininfor" VALUES (2049063972556017666, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:51:35.488');
INSERT INTO "public"."sys_logininfor" VALUES (2049064018353623041, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:51:46.408');
INSERT INTO "public"."sys_logininfor" VALUES (2049064018353623042, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:51:46.408');
INSERT INTO "public"."sys_logininfor" VALUES (2049064124209467393, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:52:11.653');
INSERT INTO "public"."sys_logininfor" VALUES (2049064142857342977, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:52:16.092');
INSERT INTO "public"."sys_logininfor" VALUES (2049064143557791746, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:52:16.254');
INSERT INTO "public"."sys_logininfor" VALUES (2049064180396363777, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:52:25.039');
INSERT INTO "public"."sys_logininfor" VALUES (2049064245047365635, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:52:40.459');
INSERT INTO "public"."sys_logininfor" VALUES (2049064245047365634, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:52:40.458');
INSERT INTO "public"."sys_logininfor" VALUES (2049064321375309825, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:52:58.658');
INSERT INTO "public"."sys_logininfor" VALUES (2049064359832883202, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:53:07.837');
INSERT INTO "public"."sys_logininfor" VALUES (2049064362773090306, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:53:08.527');
INSERT INTO "public"."sys_logininfor" VALUES (2049064416078499842, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:53:21.238');
INSERT INTO "public"."sys_logininfor" VALUES (2049064417244516354, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:53:21.517');
INSERT INTO "public"."sys_logininfor" VALUES (2049064443798654977, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:53:27.837');
INSERT INTO "public"."sys_logininfor" VALUES (2049064447577722882, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:53:28.739');
INSERT INTO "public"."sys_logininfor" VALUES (2049064518541152258, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:53:45.675');
INSERT INTO "public"."sys_logininfor" VALUES (2049064518541152259, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:53:45.675');
INSERT INTO "public"."sys_logininfor" VALUES (2049064532780814338, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:53:49.06');
INSERT INTO "public"."sys_logininfor" VALUES (2049064624199864321, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:54:10.858');
INSERT INTO "public"."sys_logininfor" VALUES (2049064624262778883, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:54:10.868');
INSERT INTO "public"."sys_logininfor" VALUES (2049064624262778882, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:54:10.868');
INSERT INTO "public"."sys_logininfor" VALUES (2049064624262778884, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:54:10.869');
INSERT INTO "public"."sys_logininfor" VALUES (2049064893226717185, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:55:14.991');
INSERT INTO "public"."sys_logininfor" VALUES (2049064907021783041, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:55:18.285');
INSERT INTO "public"."sys_logininfor" VALUES (2049064909366398977, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:55:18.836');
INSERT INTO "public"."sys_logininfor" VALUES (2049064916798705665, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:55:20.619');
INSERT INTO "public"."sys_logininfor" VALUES (2049064999967559681, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:55:40.441');
INSERT INTO "public"."sys_logininfor" VALUES (2049065053788868610, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:55:53.273');
INSERT INTO "public"."sys_logininfor" VALUES (2049065054111830018, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:55:53.355');
INSERT INTO "public"."sys_logininfor" VALUES (2049065055139434498, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:55:53.599');
INSERT INTO "public"."sys_logininfor" VALUES (2049065087687233538, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:56:01.357');
INSERT INTO "public"."sys_logininfor" VALUES (2049065137544925185, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:56:13.25');
INSERT INTO "public"."sys_logininfor" VALUES (2049065174878425090, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:56:22.137');
INSERT INTO "public"."sys_logininfor" VALUES (2049065284261679105, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:56:48.221');
INSERT INTO "public"."sys_logininfor" VALUES (2049065359473938433, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:57:06.161');
INSERT INTO "public"."sys_logininfor" VALUES (2049065543041847298, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:57:49.929');
INSERT INTO "public"."sys_logininfor" VALUES (2049065565091303426, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:57:55.178');
INSERT INTO "public"."sys_logininfor" VALUES (2049065087817256961, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:56:01.391');
INSERT INTO "public"."sys_logininfor" VALUES (2049065182847602690, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:56:24.052');
INSERT INTO "public"."sys_logininfor" VALUES (2049065210219630594, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:56:30.568');
INSERT INTO "public"."sys_logininfor" VALUES (2049065288367902722, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:56:49.209');
INSERT INTO "public"."sys_logininfor" VALUES (2049065369959698434, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:57:08.654');
INSERT INTO "public"."sys_logininfor" VALUES (2049065376926437377, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:57:10.318');
INSERT INTO "public"."sys_logininfor" VALUES (2049065427539103746, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:57:22.391');
INSERT INTO "public"."sys_logininfor" VALUES (2049065429338460162, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:57:22.811');
INSERT INTO "public"."sys_logininfor" VALUES (2049065495436496898, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:57:38.575');
INSERT INTO "public"."sys_logininfor" VALUES (2049065509088956418, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:57:41.829');
INSERT INTO "public"."sys_logininfor" VALUES (2049065539308916738, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:57:49.028');
INSERT INTO "public"."sys_logininfor" VALUES (2049065543041847297, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:57:49.921');
INSERT INTO "public"."sys_logininfor" VALUES (2049065091394998274, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:56:02.244');
INSERT INTO "public"."sys_logininfor" VALUES (2049065126425825281, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:56:10.591');
INSERT INTO "public"."sys_logininfor" VALUES (2049065137670754305, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:56:13.276');
INSERT INTO "public"."sys_logininfor" VALUES (2049065167337066497, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:56:20.352');
INSERT INTO "public"."sys_logininfor" VALUES (2049065137800777730, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 17:56:13.304');
INSERT INTO "public"."sys_logininfor" VALUES (2049065284538503169, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:56:48.289');
INSERT INTO "public"."sys_logininfor" VALUES (2049065452696539138, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:57:28.38');
INSERT INTO "public"."sys_logininfor" VALUES (2049065585316237313, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:57:59.995');
INSERT INTO "public"."sys_logininfor" VALUES (2049065284718858241, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:56:48.33');
INSERT INTO "public"."sys_logininfor" VALUES (2049065495436496897, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:57:38.573');
INSERT INTO "public"."sys_logininfor" VALUES (2049065495436496899, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 17:57:38.575');
INSERT INTO "public"."sys_logininfor" VALUES (2049069329407840258, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 18:12:52.663');
INSERT INTO "public"."sys_logininfor" VALUES (2049070677180321794, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '密码输入错误1次', '2026-04-28 18:18:13.996');
INSERT INTO "public"."sys_logininfor" VALUES (2049070784982323202, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '密码输入错误2次', '2026-04-28 18:18:39.704');
INSERT INTO "public"."sys_logininfor" VALUES (2049071026423238658, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '密码输入错误3次', '2026-04-28 18:19:37.257');
INSERT INTO "public"."sys_logininfor" VALUES (2049087236028272641, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '密码输入错误1次', '2026-04-28 19:24:01.941');
INSERT INTO "public"."sys_logininfor" VALUES (2049087286057930754, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '密码输入错误2次', '2026-04-28 19:24:13.868');
INSERT INTO "public"."sys_logininfor" VALUES (2049087710013984769, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '密码输入错误3次', '2026-04-28 19:25:54.935');
INSERT INTO "public"."sys_logininfor" VALUES (2049087771292766209, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '密码输入错误4次', '2026-04-28 19:26:09.547');
INSERT INTO "public"."sys_logininfor" VALUES (2049090140416020481, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 19:35:34.397');
INSERT INTO "public"."sys_logininfor" VALUES (2049091324119912450, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 19:40:16.608');
INSERT INTO "public"."sys_logininfor" VALUES (2049092002699579394, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 19:42:58.399');
INSERT INTO "public"."sys_logininfor" VALUES (2049094099692195842, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 19:51:18.355');
INSERT INTO "public"."sys_logininfor" VALUES (2049101852850556930, '000000', 'parent_zhang', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 20:22:06.855');
INSERT INTO "public"."sys_logininfor" VALUES (2049101853374844929, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 20:22:06.952');
INSERT INTO "public"."sys_logininfor" VALUES (2049101954428211202, '000000', 'parent_zhang', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 20:22:31.072');
INSERT INTO "public"."sys_logininfor" VALUES (2049101954554040322, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 20:22:31.109');
INSERT INTO "public"."sys_logininfor" VALUES (2049101954679869441, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 20:22:31.13');
INSERT INTO "public"."sys_logininfor" VALUES (2049101954679869442, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 20:22:31.13');
INSERT INTO "public"."sys_logininfor" VALUES (2049101975152267266, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 20:22:36.012');
INSERT INTO "public"."sys_logininfor" VALUES (2049101976238592001, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 20:22:36.269');
INSERT INTO "public"."sys_logininfor" VALUES (2049101982014148609, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 20:22:37.658');
INSERT INTO "public"."sys_logininfor" VALUES (2049101985344425985, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 20:22:38.437');
INSERT INTO "public"."sys_logininfor" VALUES (2049102094744457217, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 20:23:04.532');
INSERT INTO "public"."sys_logininfor" VALUES (2049102097508503554, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 20:23:05.189');
INSERT INTO "public"."sys_logininfor" VALUES (2049102097894379521, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 20:23:05.275');
INSERT INTO "public"."sys_logininfor" VALUES (2049102098087317505, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 20:23:05.326');
INSERT INTO "public"."sys_logininfor" VALUES (2049102128298889218, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 20:23:12.525');
INSERT INTO "public"."sys_logininfor" VALUES (2049102128361803778, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 20:23:12.541');
INSERT INTO "public"."sys_logininfor" VALUES (2049102129003532290, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 20:23:12.698');
INSERT INTO "public"."sys_logininfor" VALUES (2049102154936913922, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 20:23:18.879');
INSERT INTO "public"."sys_logininfor" VALUES (2049102157432524802, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 20:23:19.48');
INSERT INTO "public"."sys_logininfor" VALUES (2049102177854590977, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 20:23:24.35');
INSERT INTO "public"."sys_logininfor" VALUES (2049110193228255234, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 20:55:15.355');
INSERT INTO "public"."sys_logininfor" VALUES (2049110194620764162, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 20:55:15.69');
INSERT INTO "public"."sys_logininfor" VALUES (2049110195061166082, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 20:55:15.787');
INSERT INTO "public"."sys_logininfor" VALUES (2049110199997861889, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 20:55:16.972');
INSERT INTO "public"."sys_logininfor" VALUES (2049121425633087490, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 21:39:53.363');
INSERT INTO "public"."sys_logininfor" VALUES (2049121425654059010, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 21:39:53.373');
INSERT INTO "public"."sys_logininfor" VALUES (2049121425704390658, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 21:39:53.381');
INSERT INTO "public"."sys_logininfor" VALUES (2049121425704390659, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 21:39:53.382');
INSERT INTO "public"."sys_logininfor" VALUES (2049133465110093826, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 22:27:43.794');
INSERT INTO "public"."sys_logininfor" VALUES (2049134876573102083, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 22:33:20.312');
INSERT INTO "public"."sys_logininfor" VALUES (2049134876573102082, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 22:33:20.311');
INSERT INTO "public"."sys_logininfor" VALUES (2049134876573102084, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 22:33:20.311');
INSERT INTO "public"."sys_logininfor" VALUES (2049134876573102085, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 22:33:20.312');
INSERT INTO "public"."sys_logininfor" VALUES (2049135065727823873, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 22:34:05.415');
INSERT INTO "public"."sys_logininfor" VALUES (2049135068483481602, '000000', 'parent_zhang', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 22:34:06.085');
INSERT INTO "public"."sys_logininfor" VALUES (2049135438408511490, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 22:35:34.23');
INSERT INTO "public"."sys_logininfor" VALUES (2049135438408511491, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 22:35:34.278');
INSERT INTO "public"."sys_logininfor" VALUES (2049135439490641922, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 22:35:34.529');
INSERT INTO "public"."sys_logininfor" VALUES (2049135439490641923, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 22:35:34.529');
INSERT INTO "public"."sys_logininfor" VALUES (2049135500618428418, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 22:35:49.105');
INSERT INTO "public"."sys_logininfor" VALUES (2049135846111637505, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 22:37:11.481');
INSERT INTO "public"."sys_logininfor" VALUES (2049136308340715522, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 22:39:01.683');
INSERT INTO "public"."sys_logininfor" VALUES (2049136639954972674, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 22:40:20.752');
INSERT INTO "public"."sys_logininfor" VALUES (2049135846111637506, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 22:37:11.482');
INSERT INTO "public"."sys_logininfor" VALUES (2049136308340715523, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 22:39:01.682');
INSERT INTO "public"."sys_logininfor" VALUES (2049135846111637507, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 22:37:11.488');
INSERT INTO "public"."sys_logininfor" VALUES (2049136109497151490, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 22:38:14.27');
INSERT INTO "public"."sys_logininfor" VALUES (2049136110646390785, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 22:38:14.558');
INSERT INTO "public"."sys_logininfor" VALUES (2049136112399609857, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 22:38:14.961');
INSERT INTO "public"."sys_logininfor" VALUES (2049136308269412353, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 22:39:01.664');
INSERT INTO "public"."sys_logininfor" VALUES (2049136308718202882, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 22:39:01.775');
INSERT INTO "public"."sys_logininfor" VALUES (2049136324836913154, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 22:39:05.616');
INSERT INTO "public"."sys_logininfor" VALUES (2049136639627816961, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 22:40:20.667');
INSERT INTO "public"."sys_logininfor" VALUES (2049136639954972673, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 22:40:20.752');
INSERT INTO "public"."sys_logininfor" VALUES (2049146770159628289, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 23:20:35.975');
INSERT INTO "public"."sys_logininfor" VALUES (2049146772344860673, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 23:20:36.49');
INSERT INTO "public"."sys_logininfor" VALUES (2049146773443768321, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 23:20:36.766');
INSERT INTO "public"."sys_logininfor" VALUES (2049146773972250625, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 23:20:36.892');
INSERT INTO "public"."sys_logininfor" VALUES (2049146807421825025, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 23:20:44.86');
INSERT INTO "public"."sys_logininfor" VALUES (2049146808436846593, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 23:20:45.1');
INSERT INTO "public"."sys_logininfor" VALUES (2049146832268881922, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 23:20:50.784');
INSERT INTO "public"."sys_logininfor" VALUES (2049146832331796481, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 23:20:50.801');
INSERT INTO "public"."sys_logininfor" VALUES (2049147160322174978, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 23:22:09.002');
INSERT INTO "public"."sys_logininfor" VALUES (2049147163245604865, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 23:22:09.696');
INSERT INTO "public"."sys_logininfor" VALUES (2049147163245604866, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 23:22:09.698');
INSERT INTO "public"."sys_logininfor" VALUES (2049147165040766978, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 23:22:10.116');
INSERT INTO "public"."sys_logininfor" VALUES (2049147190139482114, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 23:22:16.083');
INSERT INTO "public"."sys_logininfor" VALUES (2049147233110126594, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 23:22:26.347');
INSERT INTO "public"."sys_logininfor" VALUES (2049147233110126593, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 23:22:26.346');
INSERT INTO "public"."sys_logininfor" VALUES (2049147285043998721, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 23:22:38.729');
INSERT INTO "public"."sys_logininfor" VALUES (2049147340324925442, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 23:22:51.914');
INSERT INTO "public"."sys_logininfor" VALUES (2049147396490850306, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 23:23:05.304');
INSERT INTO "public"."sys_logininfor" VALUES (2049147609049788418, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 23:23:55.986');
INSERT INTO "public"."sys_logininfor" VALUES (2049147609821540354, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 23:23:56.163');
INSERT INTO "public"."sys_logininfor" VALUES (2049147610018672641, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 23:23:56.21');
INSERT INTO "public"."sys_logininfor" VALUES (2049147610538766337, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 23:23:56.336');
INSERT INTO "public"."sys_logininfor" VALUES (2049147639013896194, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 23:24:03.128');
INSERT INTO "public"."sys_logininfor" VALUES (2049147671322619905, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 23:24:10.828');
INSERT INTO "public"."sys_logininfor" VALUES (2049147673918894082, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 23:24:11.447');
INSERT INTO "public"."sys_logininfor" VALUES (2049147735566774273, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 23:24:26.156');
INSERT INTO "public"."sys_logininfor" VALUES (2049147738477621249, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 23:24:26.87');
INSERT INTO "public"."sys_logininfor" VALUES (2049147946687066114, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 23:25:16.477');
INSERT INTO "public"."sys_logininfor" VALUES (2049147948146683905, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 23:25:16.833');
INSERT INTO "public"."sys_logininfor" VALUES (2049147950013149186, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 23:25:17.271');
INSERT INTO "public"."sys_logininfor" VALUES (2049147952634589185, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 23:25:17.904');
INSERT INTO "public"."sys_logininfor" VALUES (2049148061183176706, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-28 23:25:43.781');
INSERT INTO "public"."sys_logininfor" VALUES (2049148288535425026, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 23:26:37.988');
INSERT INTO "public"."sys_logininfor" VALUES (2049148451530272770, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 23:27:16.863');
INSERT INTO "public"."sys_logininfor" VALUES (2049148461114257410, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 23:27:19.171');
INSERT INTO "public"."sys_logininfor" VALUES (2049148492546371585, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 23:27:26.619');
INSERT INTO "public"."sys_logininfor" VALUES (2049148513715023873, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-28 23:27:31.669');
INSERT INTO "public"."sys_logininfor" VALUES (2049329064145072130, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 11:24:58.239');
INSERT INTO "public"."sys_logininfor" VALUES (2049329064145072129, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 11:24:58.238');
INSERT INTO "public"."sys_logininfor" VALUES (2049329575770468353, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 11:27:00.227');
INSERT INTO "public"."sys_logininfor" VALUES (2049330103774621698, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 11:29:06.109');
INSERT INTO "public"."sys_logininfor" VALUES (2049330486429364225, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 11:30:37.344');
INSERT INTO "public"."sys_logininfor" VALUES (2049330640700059649, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 11:31:14.126');
INSERT INTO "public"."sys_logininfor" VALUES (2049330702029172738, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 11:31:28.752');
INSERT INTO "public"."sys_logininfor" VALUES (2049331170574872577, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 11:33:20.463');
INSERT INTO "public"."sys_logininfor" VALUES (2049331297758752770, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 11:33:50.783');
INSERT INTO "public"."sys_logininfor" VALUES (2049331686298103809, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 11:35:23.42');
INSERT INTO "public"."sys_logininfor" VALUES (2049332480674144257, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 11:38:32.802');
INSERT INTO "public"."sys_logininfor" VALUES (2049332719850135554, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 11:39:29.83');
INSERT INTO "public"."sys_logininfor" VALUES (2049333449445122050, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 11:42:23.787');
INSERT INTO "public"."sys_logininfor" VALUES (2049333992896897025, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 11:44:33.352');
INSERT INTO "public"."sys_logininfor" VALUES (2049334274930286594, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 11:45:40.59');
INSERT INTO "public"."sys_logininfor" VALUES (2049334736689602561, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '密码输入错误1次', '2026-04-29 11:47:30.692');
INSERT INTO "public"."sys_logininfor" VALUES (2049336150203592705, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 11:53:07.685');
INSERT INTO "public"."sys_logininfor" VALUES (2049482112590966785, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:33:07.848');
INSERT INTO "public"."sys_logininfor" VALUES (2049336416541896706, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 11:54:11.194');
INSERT INTO "public"."sys_logininfor" VALUES (2049336545768402946, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 11:54:42.003');
INSERT INTO "public"."sys_logininfor" VALUES (2049336692317384706, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 11:55:16.946');
INSERT INTO "public"."sys_logininfor" VALUES (2049336865579888641, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 11:55:58.262');
INSERT INTO "public"."sys_logininfor" VALUES (2049336892750589954, '000000', 'child_xiaoming', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 11:56:04.736');
INSERT INTO "public"."sys_logininfor" VALUES (2049338952208379906, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 12:04:15.747');
INSERT INTO "public"."sys_logininfor" VALUES (2049338980519931905, '000000', 'child_xiaoming', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 12:04:22.499');
INSERT INTO "public"."sys_logininfor" VALUES (2049340496886657026, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 12:10:24.026');
INSERT INTO "public"."sys_logininfor" VALUES (2049340524212547586, '000000', 'child_xiaoming', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 12:10:30.546');
INSERT INTO "public"."sys_logininfor" VALUES (2049341032562192386, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 12:12:31.739');
INSERT INTO "public"."sys_logininfor" VALUES (2049341060064243714, '000000', 'child_xiaoming', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 12:12:38.306');
INSERT INTO "public"."sys_logininfor" VALUES (2049341612428914690, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 12:14:49.986');
INSERT INTO "public"."sys_logininfor" VALUES (2049341640006463490, '000000', 'child_xiaoming', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 12:14:56.566');
INSERT INTO "public"."sys_logininfor" VALUES (2049344043241992194, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 12:24:29.543');
INSERT INTO "public"."sys_logininfor" VALUES (2049344071050227714, '000000', 'child_xiaoming', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 12:24:36.169');
INSERT INTO "public"."sys_logininfor" VALUES (2049345456214929409, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 12:30:06.421');
INSERT INTO "public"."sys_logininfor" VALUES (2049345484488732674, '000000', 'child_xiaoming', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 12:30:13.162');
INSERT INTO "public"."sys_logininfor" VALUES (2049471258218754050, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 20:49:59.952');
INSERT INTO "public"."sys_logininfor" VALUES (2049471258218754049, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 20:49:59.952');
INSERT INTO "public"."sys_logininfor" VALUES (2049471486321782786, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 20:50:54.339');
INSERT INTO "public"."sys_logininfor" VALUES (2049471486640549889, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 20:50:54.415');
INSERT INTO "public"."sys_logininfor" VALUES (2049471760134336513, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 20:51:59.617');
INSERT INTO "public"."sys_logininfor" VALUES (2049471760826396674, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 20:51:59.784');
INSERT INTO "public"."sys_logininfor" VALUES (2049471968830320642, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 20:52:49.389');
INSERT INTO "public"."sys_logininfor" VALUES (2049471970965221377, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 20:52:49.898');
INSERT INTO "public"."sys_logininfor" VALUES (2049478636079181825, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:19:18.97');
INSERT INTO "public"."sys_logininfor" VALUES (2049478656442527745, '000000', 'child_xiaoming', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:19:23.839');
INSERT INTO "public"."sys_logininfor" VALUES (2049478687396491266, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:19:31.205');
INSERT INTO "public"."sys_logininfor" VALUES (2049478706589626370, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:19:35.795');
INSERT INTO "public"."sys_logininfor" VALUES (2049478708892299265, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:19:36.344');
INSERT INTO "public"."sys_logininfor" VALUES (2049479511522701313, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:22:47.698');
INSERT INTO "public"."sys_logininfor" VALUES (2049479530917163010, '000000', 'child_xiaoming', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:22:52.32');
INSERT INTO "public"."sys_logininfor" VALUES (2049479561648828417, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:22:59.652');
INSERT INTO "public"."sys_logininfor" VALUES (2049479644276617218, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:23:19.343');
INSERT INTO "public"."sys_logininfor" VALUES (2049479644276617217, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:23:19.343');
INSERT INTO "public"."sys_logininfor" VALUES (2049479648475115522, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:23:20.354');
INSERT INTO "public"."sys_logininfor" VALUES (2049479707384115201, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:23:34.396');
INSERT INTO "public"."sys_logininfor" VALUES (2049479726719856642, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:23:39.016');
INSERT INTO "public"."sys_logininfor" VALUES (2049479727357390849, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:23:39.165');
INSERT INTO "public"."sys_logininfor" VALUES (2049479732096954369, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:23:40.282');
INSERT INTO "public"."sys_logininfor" VALUES (2049479740376510466, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:23:42.263');
INSERT INTO "public"."sys_logininfor" VALUES (2049479756688158722, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:23:46.142');
INSERT INTO "public"."sys_logininfor" VALUES (2049479777118613505, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:23:51.022');
INSERT INTO "public"."sys_logininfor" VALUES (2049479800812236802, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:23:56.676');
INSERT INTO "public"."sys_logininfor" VALUES (2049479803081355266, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:23:57.218');
INSERT INTO "public"."sys_logininfor" VALUES (2049479820185726977, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:24:01.293');
INSERT INTO "public"."sys_logininfor" VALUES (2049479823453089794, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:24:02.071');
INSERT INTO "public"."sys_logininfor" VALUES (2049479840398077954, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:24:06.109');
INSERT INTO "public"."sys_logininfor" VALUES (2049479857032687618, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:24:10.077');
INSERT INTO "public"."sys_logininfor" VALUES (2049479870563512321, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:24:13.294');
INSERT INTO "public"."sys_logininfor" VALUES (2049479872358674434, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:24:13.725');
INSERT INTO "public"."sys_logininfor" VALUES (2049479888603213826, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:24:17.603');
INSERT INTO "public"."sys_logininfor" VALUES (2049479891929296898, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:24:18.389');
INSERT INTO "public"."sys_logininfor" VALUES (2049479944110632962, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:24:30.832');
INSERT INTO "public"."sys_logininfor" VALUES (2049479951119314945, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:24:32.513');
INSERT INTO "public"."sys_logininfor" VALUES (2049479988398288898, '000000', 'parent_zhang', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:24:41.393');
INSERT INTO "public"."sys_logininfor" VALUES (2049479997764169730, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:24:43.626');
INSERT INTO "public"."sys_logininfor" VALUES (2049480017116688385, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:24:48.243');
INSERT INTO "public"."sys_logininfor" VALUES (2049480021424238594, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:24:49.263');
INSERT INTO "public"."sys_logininfor" VALUES (2049480035122835457, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:24:52.542');
INSERT INTO "public"."sys_logininfor" VALUES (2049480068899565569, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:25:00.586');
INSERT INTO "public"."sys_logininfor" VALUES (2049480095961214978, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:25:07.037');
INSERT INTO "public"."sys_logininfor" VALUES (2049480130857824258, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:25:15.363');
INSERT INTO "public"."sys_logininfor" VALUES (2049480181516627970, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:25:27.443');
INSERT INTO "public"."sys_logininfor" VALUES (2049480243105787905, '000000', 'parent_zhang', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:25:42.12');
INSERT INTO "public"."sys_logininfor" VALUES (2049480308348186625, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:25:57.675');
INSERT INTO "public"."sys_logininfor" VALUES (2049480384709685249, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:26:15.889');
INSERT INTO "public"."sys_logininfor" VALUES (2049480489252712449, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:26:40.807');
INSERT INTO "public"."sys_logininfor" VALUES (2049480685625831425, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:27:27.622');
INSERT INTO "public"."sys_logininfor" VALUES (2049480803863261186, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:27:55.811');
INSERT INTO "public"."sys_logininfor" VALUES (2049480826923544578, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:28:01.321');
INSERT INTO "public"."sys_logininfor" VALUES (2049480836364922881, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:28:03.572');
INSERT INTO "public"."sys_logininfor" VALUES (2049480867289526273, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:28:10.937');
INSERT INTO "public"."sys_logininfor" VALUES (2049481091206639618, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:29:04.323');
INSERT INTO "public"."sys_logininfor" VALUES (2049481151109689345, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:29:18.602');
INSERT INTO "public"."sys_logininfor" VALUES (2049479989803380737, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:24:41.725');
INSERT INTO "public"."sys_logininfor" VALUES (2049479990633852929, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:24:41.922');
INSERT INTO "public"."sys_logininfor" VALUES (2049480030211305474, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:24:51.362');
INSERT INTO "public"."sys_logininfor" VALUES (2049480088075923458, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:25:05.16');
INSERT INTO "public"."sys_logininfor" VALUES (2049480106602164226, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:25:09.57');
INSERT INTO "public"."sys_logininfor" VALUES (2049480171630653441, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:25:25.077');
INSERT INTO "public"."sys_logininfor" VALUES (2049480186923085825, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:25:28.72');
INSERT INTO "public"."sys_logininfor" VALUES (2049480252672995330, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:25:44.397');
INSERT INTO "public"."sys_logininfor" VALUES (2049480270658170881, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:25:48.684');
INSERT INTO "public"."sys_logininfor" VALUES (2049480328065609729, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:26:02.371');
INSERT INTO "public"."sys_logininfor" VALUES (2049480372449734657, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:26:12.969');
INSERT INTO "public"."sys_logininfor" VALUES (2049480435276214274, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:26:27.933');
INSERT INTO "public"."sys_logininfor" VALUES (2049480453680820225, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:26:32.322');
INSERT INTO "public"."sys_logininfor" VALUES (2049480006211497985, '000000', 'parent_zhang', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:24:45.647');
INSERT INTO "public"."sys_logininfor" VALUES (2049480036146245633, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:24:52.773');
INSERT INTO "public"."sys_logininfor" VALUES (2049480958733742083, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:28:32.742');
INSERT INTO "public"."sys_logininfor" VALUES (2049481066808373250, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:28:58.51');
INSERT INTO "public"."sys_logininfor" VALUES (2049480008090546178, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:24:46.092');
INSERT INTO "public"."sys_logininfor" VALUES (2049480020384051201, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:24:49.021');
INSERT INTO "public"."sys_logininfor" VALUES (2049480024318308354, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:24:49.957');
INSERT INTO "public"."sys_logininfor" VALUES (2049480039497494529, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:24:53.575');
INSERT INTO "public"."sys_logininfor" VALUES (2049480043763101697, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:24:54.6');
INSERT INTO "public"."sys_logininfor" VALUES (2049480068522078209, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:25:00.499');
INSERT INTO "public"."sys_logininfor" VALUES (2049480069755203585, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:25:00.787');
INSERT INTO "public"."sys_logininfor" VALUES (2049480097643130881, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:25:07.449');
INSERT INTO "public"."sys_logininfor" VALUES (2049480110582558721, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:25:10.531');
INSERT INTO "public"."sys_logininfor" VALUES (2049480119185076226, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:25:12.579');
INSERT INTO "public"."sys_logininfor" VALUES (2049480143574953985, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:25:18.389');
INSERT INTO "public"."sys_logininfor" VALUES (2049480186923085826, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:25:28.72');
INSERT INTO "public"."sys_logininfor" VALUES (2049480196154748929, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:25:30.923');
INSERT INTO "public"."sys_logininfor" VALUES (2049480219596713985, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:25:36.513');
INSERT INTO "public"."sys_logininfor" VALUES (2049480243697184769, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:25:42.267');
INSERT INTO "public"."sys_logininfor" VALUES (2049480256556920834, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:25:45.33');
INSERT INTO "public"."sys_logininfor" VALUES (2049480262164705281, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:25:46.671');
INSERT INTO "public"."sys_logininfor" VALUES (2049480278526685186, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:25:50.559');
INSERT INTO "public"."sys_logininfor" VALUES (2049480292925730818, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:25:54.007');
INSERT INTO "public"."sys_logininfor" VALUES (2049480313804976129, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:25:58.977');
INSERT INTO "public"."sys_logininfor" VALUES (2049480334877159426, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:26:04.001');
INSERT INTO "public"."sys_logininfor" VALUES (2049480357559955458, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:26:09.414');
INSERT INTO "public"."sys_logininfor" VALUES (2049480377831026689, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:26:14.236');
INSERT INTO "public"."sys_logininfor" VALUES (2049480384197980162, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:26:15.757');
INSERT INTO "public"."sys_logininfor" VALUES (2049480392620142594, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:26:17.77');
INSERT INTO "public"."sys_logininfor" VALUES (2049480437994123265, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:26:28.58');
INSERT INTO "public"."sys_logininfor" VALUES (2049480443576741889, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:26:29.922');
INSERT INTO "public"."sys_logininfor" VALUES (2049480457975787521, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:26:33.345');
INSERT INTO "public"."sys_logininfor" VALUES (2049480460681113602, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:26:33.991');
INSERT INTO "public"."sys_logininfor" VALUES (2049480496521441282, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:26:42.541');
INSERT INTO "public"."sys_logininfor" VALUES (2049480596622700546, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:27:06.4');
INSERT INTO "public"."sys_logininfor" VALUES (2049480596622700547, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:27:06.4');
INSERT INTO "public"."sys_logininfor" VALUES (2049480625945079810, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:27:13.395');
INSERT INTO "public"."sys_logininfor" VALUES (2049480636636360706, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:27:15.94');
INSERT INTO "public"."sys_logininfor" VALUES (2049480657310085122, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:27:20.875');
INSERT INTO "public"."sys_logininfor" VALUES (2049480683293798402, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:27:27.073');
INSERT INTO "public"."sys_logininfor" VALUES (2049480705653633025, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:27:32.395');
INSERT INTO "public"."sys_logininfor" VALUES (2049480717125054465, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:27:35.132');
INSERT INTO "public"."sys_logininfor" VALUES (2049480738545364994, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:27:40.251');
INSERT INTO "public"."sys_logininfor" VALUES (2049480739505860609, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:27:40.466');
INSERT INTO "public"."sys_logininfor" VALUES (2049480760108281857, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:27:45.378');
INSERT INTO "public"."sys_logininfor" VALUES (2049480775652372481, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:27:49.097');
INSERT INTO "public"."sys_logininfor" VALUES (2049480793603993601, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:27:53.364');
INSERT INTO "public"."sys_logininfor" VALUES (2049480816798494721, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:27:58.907');
INSERT INTO "public"."sys_logininfor" VALUES (2049480823157059585, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:28:00.418');
INSERT INTO "public"."sys_logininfor" VALUES (2049480852521381890, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:28:07.42');
INSERT INTO "public"."sys_logininfor" VALUES (2049480857789427713, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:28:08.696');
INSERT INTO "public"."sys_logininfor" VALUES (2049480860922572801, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:28:09.416');
INSERT INTO "public"."sys_logininfor" VALUES (2049480873169940481, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:28:12.335');
INSERT INTO "public"."sys_logininfor" VALUES (2049480875346784258, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:28:12.857');
INSERT INTO "public"."sys_logininfor" VALUES (2049480882862977026, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:28:14.658');
INSERT INTO "public"."sys_logininfor" VALUES (2049480909148680194, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:28:20.921');
INSERT INTO "public"."sys_logininfor" VALUES (2049480917608591361, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:28:22.937');
INSERT INTO "public"."sys_logininfor" VALUES (2049480929906290689, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:28:25.869');
INSERT INTO "public"."sys_logininfor" VALUES (2049482123450019841, '000000', 'parent_zhang', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:33:10.43');
INSERT INTO "public"."sys_logininfor" VALUES (2049480930304749570, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:28:25.959');
INSERT INTO "public"."sys_logininfor" VALUES (2049480931974082562, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:28:26.364');
INSERT INTO "public"."sys_logininfor" VALUES (2049480950248665090, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:28:30.717');
INSERT INTO "public"."sys_logininfor" VALUES (2049480958733742082, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:28:32.741');
INSERT INTO "public"."sys_logininfor" VALUES (2049480972205846529, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:28:35.95');
INSERT INTO "public"."sys_logininfor" VALUES (2049480981148102657, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:28:38.082');
INSERT INTO "public"."sys_logininfor" VALUES (2049480999200387074, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:28:42.397');
INSERT INTO "public"."sys_logininfor" VALUES (2049481006519447554, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:28:44.133');
INSERT INTO "public"."sys_logininfor" VALUES (2049481006519447555, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:28:44.134');
INSERT INTO "public"."sys_logininfor" VALUES (2049481021568610305, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:28:47.715');
INSERT INTO "public"."sys_logininfor" VALUES (2049481058050666497, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:28:56.424');
INSERT INTO "public"."sys_logininfor" VALUES (2049481114166259714, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:29:09.796');
INSERT INTO "public"."sys_logininfor" VALUES (2049481134995173377, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:29:14.763');
INSERT INTO "public"."sys_logininfor" VALUES (2049481149620711426, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:29:18.256');
INSERT INTO "public"."sys_logininfor" VALUES (2049481166062383106, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:29:22.165');
INSERT INTO "public"."sys_logininfor" VALUES (2049481171959574529, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:29:23.578');
INSERT INTO "public"."sys_logininfor" VALUES (2049481202049511426, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:29:30.752');
INSERT INTO "public"."sys_logininfor" VALUES (2049481202049511425, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:29:30.752');
INSERT INTO "public"."sys_logininfor" VALUES (2049481219581702145, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:29:34.975');
INSERT INTO "public"."sys_logininfor" VALUES (2049481228112916482, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:29:36.964');
INSERT INTO "public"."sys_logininfor" VALUES (2049481234530201602, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:29:38.49');
INSERT INTO "public"."sys_logininfor" VALUES (2049481343141703682, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:30:04.395');
INSERT INTO "public"."sys_logininfor" VALUES (2049481366524948482, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:30:09.984');
INSERT INTO "public"."sys_logininfor" VALUES (2049481367590301698, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:30:10.239');
INSERT INTO "public"."sys_logininfor" VALUES (2049481367862931458, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:30:10.278');
INSERT INTO "public"."sys_logininfor" VALUES (2049481380433260546, '000000', 'child_xiaoming', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:30:13.276');
INSERT INTO "public"."sys_logininfor" VALUES (2049481412960088066, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:30:21.04');
INSERT INTO "public"."sys_logininfor" VALUES (2049481417343135746, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:30:22.079');
INSERT INTO "public"."sys_logininfor" VALUES (2049481476382158851, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:30:36.163');
INSERT INTO "public"."sys_logininfor" VALUES (2049481476382158850, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:30:36.163');
INSERT INTO "public"."sys_logininfor" VALUES (2049481477405569025, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:30:36.403');
INSERT INTO "public"."sys_logininfor" VALUES (2049481491527790594, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:30:39.766');
INSERT INTO "public"."sys_logininfor" VALUES (2049481536234876929, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:30:50.449');
INSERT INTO "public"."sys_logininfor" VALUES (2049481560230490114, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:30:56.163');
INSERT INTO "public"."sys_logininfor" VALUES (2049481587271168002, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:31:02.61');
INSERT INTO "public"."sys_logininfor" VALUES (2049481587396997121, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:31:02.633');
INSERT INTO "public"."sys_logininfor" VALUES (2049481603570233345, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:31:06.483');
INSERT INTO "public"."sys_logininfor" VALUES (2049481624373981185, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:31:11.435');
INSERT INTO "public"."sys_logininfor" VALUES (2049481660688265217, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:31:20.1');
INSERT INTO "public"."sys_logininfor" VALUES (2049481700555124737, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:31:29.6');
INSERT INTO "public"."sys_logininfor" VALUES (2049481702354481153, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:31:30.044');
INSERT INTO "public"."sys_logininfor" VALUES (2049481704648765441, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:31:30.728');
INSERT INTO "public"."sys_logininfor" VALUES (2049481706880135169, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:31:31.235');
INSERT INTO "public"."sys_logininfor" VALUES (2049481754200272897, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:31:42.392');
INSERT INTO "public"."sys_logininfor" VALUES (2049481756721049601, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:31:42.989');
INSERT INTO "public"."sys_logininfor" VALUES (2049481758222610433, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:31:43.353');
INSERT INTO "public"."sys_logininfor" VALUES (2049481772684570625, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:31:46.798');
INSERT INTO "public"."sys_logininfor" VALUES (2049481780972515330, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:31:48.773');
INSERT INTO "public"."sys_logininfor" VALUES (2049481799796551681, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:31:53.262');
INSERT INTO "public"."sys_logininfor" VALUES (2049481807325327362, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:31:55.074');
INSERT INTO "public"."sys_logininfor" VALUES (2049481832302407682, '000000', 'child_xiaoming', 'pc', 'pc', '127.0.0.1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:32:01.012');
INSERT INTO "public"."sys_logininfor" VALUES (2049481872727109633, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:32:10.648');
INSERT INTO "public"."sys_logininfor" VALUES (2049481878620106754, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:32:12.053');
INSERT INTO "public"."sys_logininfor" VALUES (2049481939173273602, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:32:26.516');
INSERT INTO "public"."sys_logininfor" VALUES (2049481966348169218, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:32:33.058');
INSERT INTO "public"."sys_logininfor" VALUES (2049481974384455681, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:32:34.954');
INSERT INTO "public"."sys_logininfor" VALUES (2049481975567249410, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:32:35.198');
INSERT INTO "public"."sys_logininfor" VALUES (2049482027807305730, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:32:47.638');
INSERT INTO "public"."sys_logininfor" VALUES (2049482081544728577, '000000', 'ken2zhao', 'pc', 'pc', '127.0.0.1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:33:00.442');
INSERT INTO "public"."sys_logininfor" VALUES (2049482123450019842, '000000', 'parent_zhang', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:33:10.43');
INSERT INTO "public"."sys_logininfor" VALUES (2049482228206956545, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:33:35.404');
INSERT INTO "public"."sys_logininfor" VALUES (2049482390975311873, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:34:14.208');
INSERT INTO "public"."sys_logininfor" VALUES (2049482498844422146, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:34:39.952');
INSERT INTO "public"."sys_logininfor" VALUES (2049482593551806465, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:35:02.584');
INSERT INTO "public"."sys_logininfor" VALUES (2049482706516996098, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:35:29.444');
INSERT INTO "public"."sys_logininfor" VALUES (2049483199670677506, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:37:27.027');
INSERT INTO "public"."sys_logininfor" VALUES (2049483280201314306, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:37:46.22');
INSERT INTO "public"."sys_logininfor" VALUES (2049483286333386753, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:37:47.682');
INSERT INTO "public"."sys_logininfor" VALUES (2049483294113820674, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:37:49.552');
INSERT INTO "public"."sys_logininfor" VALUES (2049483338296619010, '000000', 'child_xiaoming', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:38:00.076');
INSERT INTO "public"."sys_logininfor" VALUES (2049483378549354498, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:38:09.672');
INSERT INTO "public"."sys_logininfor" VALUES (2049483423994638338, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:38:20.502');
INSERT INTO "public"."sys_logininfor" VALUES (2049483431821209601, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:38:22.377');
INSERT INTO "public"."sys_logininfor" VALUES (2049483483750887426, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:38:34.762');
INSERT INTO "public"."sys_logininfor" VALUES (2049483548389306369, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:38:50.167');
INSERT INTO "public"."sys_logininfor" VALUES (2049483549114920961, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:38:50.367');
INSERT INTO "public"."sys_logininfor" VALUES (2049483678093963266, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:39:21.105');
INSERT INTO "public"."sys_logininfor" VALUES (2049483688927850498, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:39:23.682');
INSERT INTO "public"."sys_logininfor" VALUES (2049483690110644226, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:39:23.951');
INSERT INTO "public"."sys_logininfor" VALUES (2049482149215629314, '000000', 'ken2zhao', 'pc', 'pc', '127.0.0.1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:33:16.587');
INSERT INTO "public"."sys_logininfor" VALUES (2049482173819416578, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:33:22.44');
INSERT INTO "public"."sys_logininfor" VALUES (2049482208246263810, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:33:30.658');
INSERT INTO "public"."sys_logininfor" VALUES (2049482208246263811, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:33:30.72');
INSERT INTO "public"."sys_logininfor" VALUES (2049482210691543041, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:33:31.227');
INSERT INTO "public"."sys_logininfor" VALUES (2049482263367806978, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:33:43.797');
INSERT INTO "public"."sys_logininfor" VALUES (2049482280639950850, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:33:47.912');
INSERT INTO "public"."sys_logininfor" VALUES (2049482285291433985, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:33:49.014');
INSERT INTO "public"."sys_logininfor" VALUES (2049482293386440706, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:33:50.962');
INSERT INTO "public"."sys_logininfor" VALUES (2049482294296604674, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:33:51.175');
INSERT INTO "public"."sys_logininfor" VALUES (2049482359178293250, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:34:06.644');
INSERT INTO "public"."sys_logininfor" VALUES (2049482390279057410, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:34:14.049');
INSERT INTO "public"."sys_logininfor" VALUES (2049482409568661506, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:34:18.685');
INSERT INTO "public"."sys_logininfor" VALUES (2049482420096364545, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:34:21.158');
INSERT INTO "public"."sys_logininfor" VALUES (2049482440220635138, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:34:25.948');
INSERT INTO "public"."sys_logininfor" VALUES (2049482483887534081, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:34:36.38');
INSERT INTO "public"."sys_logininfor" VALUES (2049482528393293826, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:34:47.004');
INSERT INTO "public"."sys_logininfor" VALUES (2049482579840626690, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:34:59.239');
INSERT INTO "public"."sys_logininfor" VALUES (2049483027351891970, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:36:45.931');
INSERT INTO "public"."sys_logininfor" VALUES (2049483120146673665, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:37:08.064');
INSERT INTO "public"."sys_logininfor" VALUES (2049482210691543042, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:33:31.227');
INSERT INTO "public"."sys_logininfor" VALUES (2049482211299717122, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:33:31.373');
INSERT INTO "public"."sys_logininfor" VALUES (2049482341595770881, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:34:02.437');
INSERT INTO "public"."sys_logininfor" VALUES (2049482342568849409, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:34:02.676');
INSERT INTO "public"."sys_logininfor" VALUES (2049482455466930177, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:34:29.584');
INSERT INTO "public"."sys_logininfor" VALUES (2049482463314472961, '000000', 'ken2zhao', 'pc', 'pc', '127.0.0.1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:34:31.457');
INSERT INTO "public"."sys_logininfor" VALUES (2049482485414260738, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:34:36.816');
INSERT INTO "public"."sys_logininfor" VALUES (2049482543287267329, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:34:50.522');
INSERT INTO "public"."sys_logininfor" VALUES (2049482555584966657, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:34:53.453');
INSERT INTO "public"."sys_logininfor" VALUES (2049482616888913921, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:35:08.074');
INSERT INTO "public"."sys_logininfor" VALUES (2049482653765234690, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:35:16.862');
INSERT INTO "public"."sys_logininfor" VALUES (2049482653782011906, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:35:16.866');
INSERT INTO "public"."sys_logininfor" VALUES (2049482653782011907, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:35:16.87');
INSERT INTO "public"."sys_logininfor" VALUES (2049482678297718786, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:35:22.71');
INSERT INTO "public"."sys_logininfor" VALUES (2049482706420527106, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:35:29.417');
INSERT INTO "public"."sys_logininfor" VALUES (2049482706919649282, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:35:29.537');
INSERT INTO "public"."sys_logininfor" VALUES (2049482750745931777, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:35:39.995');
INSERT INTO "public"."sys_logininfor" VALUES (2049482769469304834, '000000', 'parent_zhang', 'pc', 'pc', '127.0.0.1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:35:44.45');
INSERT INTO "public"."sys_logininfor" VALUES (2049482806874107905, '000000', 'parent_zhang', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:35:53.405');
INSERT INTO "public"."sys_logininfor" VALUES (2049482809944338434, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:35:54.098');
INSERT INTO "public"."sys_logininfor" VALUES (2049482809944338433, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:35:54.097');
INSERT INTO "public"."sys_logininfor" VALUES (2049482810045001729, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:35:54.123');
INSERT INTO "public"."sys_logininfor" VALUES (2049482818945314817, '000000', 'parent_zhang', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:35:56.27');
INSERT INTO "public"."sys_logininfor" VALUES (2049482822590164994, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:35:57.114');
INSERT INTO "public"."sys_logininfor" VALUES (2049482844354408449, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:36:02.304');
INSERT INTO "public"."sys_logininfor" VALUES (2049482852273254401, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:36:04.191');
INSERT INTO "public"."sys_logininfor" VALUES (2049482857407082498, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:36:05.422');
INSERT INTO "public"."sys_logininfor" VALUES (2049482875375480834, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:36:09.697');
INSERT INTO "public"."sys_logininfor" VALUES (2049482879737556993, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:36:10.798');
INSERT INTO "public"."sys_logininfor" VALUES (2049482879737556994, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:36:10.799');
INSERT INTO "public"."sys_logininfor" VALUES (2049482891989118977, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:36:13.662');
INSERT INTO "public"."sys_logininfor" VALUES (2049482926881533954, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:36:22.036');
INSERT INTO "public"."sys_logininfor" VALUES (2049482936423575554, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:36:24.252');
INSERT INTO "public"."sys_logininfor" VALUES (2049482941276385282, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:36:25.409');
INSERT INTO "public"."sys_logininfor" VALUES (2049482945386803202, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:36:26.404');
INSERT INTO "public"."sys_logininfor" VALUES (2049482947223908353, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:36:26.835');
INSERT INTO "public"."sys_logininfor" VALUES (2049482951946694658, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:36:27.971');
INSERT INTO "public"."sys_logininfor" VALUES (2049482969097203713, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:36:32.052');
INSERT INTO "public"."sys_logininfor" VALUES (2049482972653973505, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:36:32.905');
INSERT INTO "public"."sys_logininfor" VALUES (2049483027347697665, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:36:45.931');
INSERT INTO "public"."sys_logininfor" VALUES (2049483028966699009, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:36:46.335');
INSERT INTO "public"."sys_logininfor" VALUES (2049483043667734530, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:36:49.823');
INSERT INTO "public"."sys_logininfor" VALUES (2049483082880282625, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:36:59.185');
INSERT INTO "public"."sys_logininfor" VALUES (2049483083618480130, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:36:59.351');
INSERT INTO "public"."sys_logininfor" VALUES (2049483088366432258, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:37:00.483');
INSERT INTO "public"."sys_logininfor" VALUES (2049483088366432259, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:37:00.483');
INSERT INTO "public"."sys_logininfor" VALUES (2049483119764992002, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:37:07.97');
INSERT INTO "public"."sys_logininfor" VALUES (2049483131441934338, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:37:10.752');
INSERT INTO "public"."sys_logininfor" VALUES (2049483137007775746, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:37:12.111');
INSERT INTO "public"."sys_logininfor" VALUES (2049483148097515522, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:37:14.729');
INSERT INTO "public"."sys_logininfor" VALUES (2049483194612346881, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:37:25.811');
INSERT INTO "public"."sys_logininfor" VALUES (2049483199725203457, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:37:27.028');
INSERT INTO "public"."sys_logininfor" VALUES (2049483199670677507, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:37:27.027');
INSERT INTO "public"."sys_logininfor" VALUES (2049483200056553473, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:37:27.127');
INSERT INTO "public"."sys_logininfor" VALUES (2049483226296119297, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:37:33.365');
INSERT INTO "public"."sys_logininfor" VALUES (2049483280201314305, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:37:46.22');
INSERT INTO "public"."sys_logininfor" VALUES (2049483280616550402, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:37:46.36');
INSERT INTO "public"."sys_logininfor" VALUES (2049483283749695490, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:37:47.064');
INSERT INTO "public"."sys_logininfor" VALUES (2049483284903129089, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:37:47.34');
INSERT INTO "public"."sys_logininfor" VALUES (2049483291425271810, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:37:48.921');
INSERT INTO "public"."sys_logininfor" VALUES (2049483291425271809, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:37:48.921');
INSERT INTO "public"."sys_logininfor" VALUES (2049483378515800066, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:38:09.657');
INSERT INTO "public"."sys_logininfor" VALUES (2049483418097446913, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:38:19.092');
INSERT INTO "public"."sys_logininfor" VALUES (2049483484250009601, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:38:34.871');
INSERT INTO "public"."sys_logininfor" VALUES (2049483505909395457, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:38:40.037');
INSERT INTO "public"."sys_logininfor" VALUES (2049483605335371778, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:39:03.761');
INSERT INTO "public"."sys_logininfor" VALUES (2049483652194136065, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:39:14.907');
INSERT INTO "public"."sys_logininfor" VALUES (2049483323511697410, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:37:56.545');
INSERT INTO "public"."sys_logininfor" VALUES (2049483337336123393, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:37:59.842');
INSERT INTO "public"."sys_logininfor" VALUES (2049483377978929154, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:38:09.535');
INSERT INTO "public"."sys_logininfor" VALUES (2049483407599104002, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:38:16.588');
INSERT INTO "public"."sys_logininfor" VALUES (2049483463412707330, '000000', 'ken2zhao', 'pc', 'pc', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:38:29.914');
INSERT INTO "public"."sys_logininfor" VALUES (2049483489144762369, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:38:36.036');
INSERT INTO "public"."sys_logininfor" VALUES (2049483600306401282, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:39:02.561');
INSERT INTO "public"."sys_logininfor" VALUES (2049483605104685058, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:39:03.712');
INSERT INTO "public"."sys_logininfor" VALUES (2049483650893901826, '000000', 'parent_zhang', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:39:14.617');
INSERT INTO "public"."sys_logininfor" VALUES (2049483386715664385, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:38:11.614');
INSERT INTO "public"."sys_logininfor" VALUES (2049483678093963267, '000000', 'parent_zhang', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:39:21.105');
INSERT INTO "public"."sys_logininfor" VALUES (2049483484250009602, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:38:34.871');
INSERT INTO "public"."sys_logininfor" VALUES (2049483625400922113, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:39:08.524');
INSERT INTO "public"."sys_logininfor" VALUES (2049483715481989121, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:39:30.018');
INSERT INTO "public"."sys_logininfor" VALUES (2049483727079239681, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:39:32.763');
INSERT INTO "public"."sys_logininfor" VALUES (2049483746725359618, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:39:37.444');
INSERT INTO "public"."sys_logininfor" VALUES (2049483761770328066, '000000', 'ken2zhao', 'pc', 'pc', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:39:41.04');
INSERT INTO "public"."sys_logininfor" VALUES (2049483763255111682, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:39:41.385');
INSERT INTO "public"."sys_logininfor" VALUES (2049483793378603010, '000000', 'ken2zhao', 'pc', 'pc', '127.0.0.1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:39:48.614');
INSERT INTO "public"."sys_logininfor" VALUES (2049483803595927553, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:39:51.003');
INSERT INTO "public"."sys_logininfor" VALUES (2049483806221561857, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:39:51.64');
INSERT INTO "public"."sys_logininfor" VALUES (2049483808767504385, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:39:52.244');
INSERT INTO "public"."sys_logininfor" VALUES (2049483814291402754, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:39:53.557');
INSERT INTO "public"."sys_logininfor" VALUES (2049483842410016770, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:40:00.295');
INSERT INTO "public"."sys_logininfor" VALUES (2049483872709668865, '000000', 'ken2zhao', 'pc', 'pc', '127.0.0.1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:40:07.493');
INSERT INTO "public"."sys_logininfor" VALUES (2049483928267419650, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:40:20.751');
INSERT INTO "public"."sys_logininfor" VALUES (2049483928460357634, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:40:20.788');
INSERT INTO "public"."sys_logininfor" VALUES (2049483929253081090, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:40:20.961');
INSERT INTO "public"."sys_logininfor" VALUES (2049483929643151361, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:40:21.054');
INSERT INTO "public"."sys_logininfor" VALUES (2049483956226650113, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:40:27.423');
INSERT INTO "public"."sys_logininfor" VALUES (2049483956440559618, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:40:27.471');
INSERT INTO "public"."sys_logininfor" VALUES (2049483958026006529, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:40:27.834');
INSERT INTO "public"."sys_logininfor" VALUES (2049483976862625794, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:40:32.311');
INSERT INTO "public"."sys_logininfor" VALUES (2049484003211243522, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:40:38.6');
INSERT INTO "public"."sys_logininfor" VALUES (2049484004817661954, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:40:38.978');
INSERT INTO "public"."sys_logininfor" VALUES (2049484013571174402, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:40:41.067');
INSERT INTO "public"."sys_logininfor" VALUES (2049484017463488514, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:40:41.993');
INSERT INTO "public"."sys_logininfor" VALUES (2049484019241873410, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:40:42.421');
INSERT INTO "public"."sys_logininfor" VALUES (2049484032730755073, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:40:45.636');
INSERT INTO "public"."sys_logininfor" VALUES (2049484034110681089, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:40:45.969');
INSERT INTO "public"."sys_logininfor" VALUES (2049484051806449666, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:40:50.188');
INSERT INTO "public"."sys_logininfor" VALUES (2049484069510606850, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:40:54.412');
INSERT INTO "public"."sys_logininfor" VALUES (2049484104113614849, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:41:02.665');
INSERT INTO "public"."sys_logininfor" VALUES (2049484126741884929, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:41:08.053');
INSERT INTO "public"."sys_logininfor" VALUES (2049484129476571138, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:41:08.705');
INSERT INTO "public"."sys_logininfor" VALUES (2049484129476571137, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:41:08.705');
INSERT INTO "public"."sys_logininfor" VALUES (2049484141459697666, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:41:11.609');
INSERT INTO "public"."sys_logininfor" VALUES (2049484151828017154, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:41:14.104');
INSERT INTO "public"."sys_logininfor" VALUES (2049484160824799234, '000000', 'parent_zhang', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:41:16.196');
INSERT INTO "public"."sys_logininfor" VALUES (2049484169850941441, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:41:18.326');
INSERT INTO "public"."sys_logininfor" VALUES (2049484172711456769, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:41:19.022');
INSERT INTO "public"."sys_logininfor" VALUES (2049484230815150081, '000000', 'ken2zhao', 'pc', 'pc', '127.0.0.1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:41:32.867');
INSERT INTO "public"."sys_logininfor" VALUES (2049484237060468737, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:41:34.358');
INSERT INTO "public"."sys_logininfor" VALUES (2049484249161035778, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:41:37.234');
INSERT INTO "public"."sys_logininfor" VALUES (2049484250746482689, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:41:37.611');
INSERT INTO "public"."sys_logininfor" VALUES (2049484251992190978, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:41:37.915');
INSERT INTO "public"."sys_logininfor" VALUES (2049484292043599873, '000000', 'ken2zhao', 'pc', 'pc', '127.0.0.1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:41:47.466');
INSERT INTO "public"."sys_logininfor" VALUES (2049484306216153090, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:41:50.852');
INSERT INTO "public"."sys_logininfor" VALUES (2049484307277312002, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:41:51.089');
INSERT INTO "public"."sys_logininfor" VALUES (2049484311664553986, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:41:52.14');
INSERT INTO "public"."sys_logininfor" VALUES (2049484316739661826, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:41:53.35');
INSERT INTO "public"."sys_logininfor" VALUES (2049484332128563201, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:41:57.015');
INSERT INTO "public"."sys_logininfor" VALUES (2049484343704842241, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:41:59.807');
INSERT INTO "public"."sys_logininfor" VALUES (2049484361258004481, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:42:03.968');
INSERT INTO "public"."sys_logininfor" VALUES (2049484380816044033, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:42:08.622');
INSERT INTO "public"."sys_logininfor" VALUES (2049484383152271361, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:42:09.179');
INSERT INTO "public"."sys_logininfor" VALUES (2049484384033075201, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:42:09.412');
INSERT INTO "public"."sys_logininfor" VALUES (2049484395265421313, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:42:12.07');
INSERT INTO "public"."sys_logininfor" VALUES (2049484421635010561, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:42:18.355');
INSERT INTO "public"."sys_logininfor" VALUES (2049484421635010563, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:42:18.355');
INSERT INTO "public"."sys_logininfor" VALUES (2049484421635010562, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:42:18.355');
INSERT INTO "public"."sys_logininfor" VALUES (2049484431130914818, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:42:20.62');
INSERT INTO "public"."sys_logininfor" VALUES (2049484462151987202, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:42:28.015');
INSERT INTO "public"."sys_logininfor" VALUES (2049484487040987138, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:42:33.954');
INSERT INTO "public"."sys_logininfor" VALUES (2049484524324155394, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:42:42.844');
INSERT INTO "public"."sys_logininfor" VALUES (2049484563427651586, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:42:52.161');
INSERT INTO "public"."sys_logininfor" VALUES (2049484633623523329, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:43:08.897');
INSERT INTO "public"."sys_logininfor" VALUES (2049484674346020866, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:43:18.618');
INSERT INTO "public"."sys_logininfor" VALUES (2049484711369142275, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:43:27.432');
INSERT INTO "public"."sys_logininfor" VALUES (2049484751126949889, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:43:36.923');
INSERT INTO "public"."sys_logininfor" VALUES (2049484779576913922, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:43:43.703');
INSERT INTO "public"."sys_logininfor" VALUES (2049484869150470145, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:44:05.051');
INSERT INTO "public"."sys_logininfor" VALUES (2049484888079364098, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:44:09.57');
INSERT INTO "public"."sys_logininfor" VALUES (2049484901153009665, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:44:12.682');
INSERT INTO "public"."sys_logininfor" VALUES (2049484967490121729, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:44:28.497');
INSERT INTO "public"."sys_logininfor" VALUES (2049485000511877122, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:44:36.38');
INSERT INTO "public"."sys_logininfor" VALUES (2049485011773583361, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:44:39.062');
INSERT INTO "public"."sys_logininfor" VALUES (2049485012574695425, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:44:39.245');
INSERT INTO "public"."sys_logininfor" VALUES (2049485062780514306, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:44:51.224');
INSERT INTO "public"."sys_logininfor" VALUES (2049485100088848386, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:45:00.114');
INSERT INTO "public"."sys_logininfor" VALUES (2049485102328606721, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:45:00.647');
INSERT INTO "public"."sys_logininfor" VALUES (2049485128253599745, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:45:06.836');
INSERT INTO "public"."sys_logininfor" VALUES (2049485165318664194, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:45:15.665');
INSERT INTO "public"."sys_logininfor" VALUES (2049485238131781634, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:45:33.026');
INSERT INTO "public"."sys_logininfor" VALUES (2049485280871739393, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:45:43.213');
INSERT INTO "public"."sys_logininfor" VALUES (2049485295430168577, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:45:46.684');
INSERT INTO "public"."sys_logininfor" VALUES (2049485311649542146, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:45:50.556');
INSERT INTO "public"."sys_logininfor" VALUES (2049485428205056002, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:46:18.34');
INSERT INTO "public"."sys_logininfor" VALUES (2049485452494270465, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:46:24.131');
INSERT INTO "public"."sys_logininfor" VALUES (2049485655402115073, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:47:12.518');
INSERT INTO "public"."sys_logininfor" VALUES (2049485811962900483, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:47:49.835');
INSERT INTO "public"."sys_logininfor" VALUES (2049485905365856258, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:48:12.105');
INSERT INTO "public"."sys_logininfor" VALUES (2049486062375432193, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:48:49.539');
INSERT INTO "public"."sys_logininfor" VALUES (2049486071170887681, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:48:51.637');
INSERT INTO "public"."sys_logininfor" VALUES (2049486181787267073, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:49:18.017');
INSERT INTO "public"."sys_logininfor" VALUES (2049486190674997249, '000000', 'parent_zhang', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:49:20.126');
INSERT INTO "public"."sys_logininfor" VALUES (2049486248338288642, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:49:33.885');
INSERT INTO "public"."sys_logininfor" VALUES (2049486259067318274, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:49:36.444');
INSERT INTO "public"."sys_logininfor" VALUES (2049486338893312002, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:49:55.47');
INSERT INTO "public"."sys_logininfor" VALUES (2049486442819776514, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:50:20.248');
INSERT INTO "public"."sys_logininfor" VALUES (2049484454426079233, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:42:26.174');
INSERT INTO "public"."sys_logininfor" VALUES (2049484459908034561, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:42:27.482');
INSERT INTO "public"."sys_logininfor" VALUES (2049484524844249090, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:42:42.962');
INSERT INTO "public"."sys_logininfor" VALUES (2049484563427651585, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:42:52.161');
INSERT INTO "public"."sys_logininfor" VALUES (2049484589365227522, '000000', 'ken2zhao', 'pc', 'pc', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:42:58.355');
INSERT INTO "public"."sys_logininfor" VALUES (2049484601893613569, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:43:01.332');
INSERT INTO "public"."sys_logininfor" VALUES (2049484646881718273, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:43:12.07');
INSERT INTO "public"."sys_logininfor" VALUES (2049484711369142274, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:43:27.432');
INSERT INTO "public"."sys_logininfor" VALUES (2049484713487265794, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:43:27.951');
INSERT INTO "public"."sys_logininfor" VALUES (2049484773155434498, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:43:42.169');
INSERT INTO "public"."sys_logininfor" VALUES (2049484806747615234, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:43:50.192');
INSERT INTO "public"."sys_logininfor" VALUES (2049484833138176001, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:43:56.493');
INSERT INTO "public"."sys_logininfor" VALUES (2049484868529713154, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:44:04.903');
INSERT INTO "public"."sys_logininfor" VALUES (2049484913937248257, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:44:15.734');
INSERT INTO "public"."sys_logininfor" VALUES (2049484918932664321, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:44:16.945');
INSERT INTO "public"."sys_logininfor" VALUES (2049484954282258433, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:44:25.347');
INSERT INTO "public"."sys_logininfor" VALUES (2049485029876199425, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:44:43.37');
INSERT INTO "public"."sys_logininfor" VALUES (2049485071940874241, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:44:53.401');
INSERT INTO "public"."sys_logininfor" VALUES (2049485159098511361, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:45:14.194');
INSERT INTO "public"."sys_logininfor" VALUES (2049485160029646850, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:45:14.401');
INSERT INTO "public"."sys_logininfor" VALUES (2049485212450058241, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:45:26.905');
INSERT INTO "public"."sys_logininfor" VALUES (2049485337985576962, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:45:56.835');
INSERT INTO "public"."sys_logininfor" VALUES (2049485367869992961, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:46:03.964');
INSERT INTO "public"."sys_logininfor" VALUES (2049485393639796738, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:46:10.101');
INSERT INTO "public"."sys_logininfor" VALUES (2049485413382385666, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:46:14.805');
INSERT INTO "public"."sys_logininfor" VALUES (2049485453916139521, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:46:24.497');
INSERT INTO "public"."sys_logininfor" VALUES (2049485657331494913, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:47:12.969');
INSERT INTO "public"."sys_logininfor" VALUES (2049485688482590721, '000000', 'ken2zhao', 'pc', 'pc', '127.0.0.1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:47:20.397');
INSERT INTO "public"."sys_logininfor" VALUES (2049485732422119426, '000000', 'ken2zhao', 'pc', 'pc', '127.0.0.1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:47:30.893');
INSERT INTO "public"."sys_logininfor" VALUES (2049485811962900482, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:47:49.835');
INSERT INTO "public"."sys_logininfor" VALUES (2049485812961144833, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:47:50.074');
INSERT INTO "public"."sys_logininfor" VALUES (2049485838680616961, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:47:56.205');
INSERT INTO "public"."sys_logininfor" VALUES (2049485906250854402, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:48:12.334');
INSERT INTO "public"."sys_logininfor" VALUES (2049485909698572289, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:48:13.15');
INSERT INTO "public"."sys_logininfor" VALUES (2049485958998421506, '000000', 'ken2zhao', 'pc', 'pc', '127.0.0.1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:48:24.902');
INSERT INTO "public"."sys_logininfor" VALUES (2049486005244817409, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:48:35.922');
INSERT INTO "public"."sys_logininfor" VALUES (2049486006582800385, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:48:36.242');
INSERT INTO "public"."sys_logininfor" VALUES (2049486044457365505, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:48:45.268');
INSERT INTO "public"."sys_logininfor" VALUES (2049486070537547778, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:48:51.492');
INSERT INTO "public"."sys_logininfor" VALUES (2049486099381776386, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:48:58.36');
INSERT INTO "public"."sys_logininfor" VALUES (2049486122043600897, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:49:03.764');
INSERT INTO "public"."sys_logininfor" VALUES (2049486146244734977, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:49:09.542');
INSERT INTO "public"."sys_logininfor" VALUES (2049486175776829441, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:49:16.578');
INSERT INTO "public"."sys_logininfor" VALUES (2049486183364325377, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:49:18.389');
INSERT INTO "public"."sys_logininfor" VALUES (2049486210698604545, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:49:24.901');
INSERT INTO "public"."sys_logininfor" VALUES (2049486212942557185, '000000', 'parent_zhang', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:49:25.436');
INSERT INTO "public"."sys_logininfor" VALUES (2049486218869108737, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:49:26.851');
INSERT INTO "public"."sys_logininfor" VALUES (2049486238934659073, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:49:31.632');
INSERT INTO "public"."sys_logininfor" VALUES (2049486257293127682, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:49:36.012');
INSERT INTO "public"."sys_logininfor" VALUES (2049486268110237698, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:49:38.589');
INSERT INTO "public"."sys_logininfor" VALUES (2049486273382477825, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:49:39.848');
INSERT INTO "public"."sys_logininfor" VALUES (2049486283931152385, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:49:42.363');
INSERT INTO "public"."sys_logininfor" VALUES (2049486285906669569, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:49:42.834');
INSERT INTO "public"."sys_logininfor" VALUES (2049486315833028609, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:49:49.973');
INSERT INTO "public"."sys_logininfor" VALUES (2049486318693543938, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:49:50.659');
INSERT INTO "public"."sys_logininfor" VALUES (2049486322065764353, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:49:51.455');
INSERT INTO "public"."sys_logininfor" VALUES (2049486347030261761, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:49:57.417');
INSERT INTO "public"."sys_logininfor" VALUES (2049486353682427905, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:49:58.991');
INSERT INTO "public"."sys_logininfor" VALUES (2049486369088106497, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:50:02.662');
INSERT INTO "public"."sys_logininfor" VALUES (2049486378714034178, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:50:04.971');
INSERT INTO "public"."sys_logininfor" VALUES (2049484487598829570, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:42:34.093');
INSERT INTO "public"."sys_logininfor" VALUES (2049484500869607425, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:42:37.257');
INSERT INTO "public"."sys_logininfor" VALUES (2049484612555534337, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:43:03.874');
INSERT INTO "public"."sys_logininfor" VALUES (2049484729538867201, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:43:31.817');
INSERT INTO "public"."sys_logininfor" VALUES (2049484837638664193, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:43:57.539');
INSERT INTO "public"."sys_logininfor" VALUES (2049484515092492289, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:42:40.648');
INSERT INTO "public"."sys_logininfor" VALUES (2049484612635226113, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:43:03.893');
INSERT INTO "public"."sys_logininfor" VALUES (2049484750862708738, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:43:36.85');
INSERT INTO "public"."sys_logininfor" VALUES (2049484806915387393, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:43:50.233');
INSERT INTO "public"."sys_logininfor" VALUES (2049484837772881921, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:43:57.57');
INSERT INTO "public"."sys_logininfor" VALUES (2049484911584243713, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:44:15.172');
INSERT INTO "public"."sys_logininfor" VALUES (2049485029825867778, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:44:43.359');
INSERT INTO "public"."sys_logininfor" VALUES (2049485164114898945, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:45:15.376');
INSERT INTO "public"."sys_logininfor" VALUES (2049485338975432705, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:45:57.067');
INSERT INTO "public"."sys_logininfor" VALUES (2049485367869992962, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:46:03.964');
INSERT INTO "public"."sys_logininfor" VALUES (2049486006847041537, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:48:36.302');
INSERT INTO "public"."sys_logininfor" VALUES (2049486153077256194, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:49:11.163');
INSERT INTO "public"."sys_logininfor" VALUES (2049486233091993602, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:49:30.239');
INSERT INTO "public"."sys_logininfor" VALUES (2049486380328841218, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:50:05.352');
INSERT INTO "public"."sys_logininfor" VALUES (2049486399991738369, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:50:10.034');
INSERT INTO "public"."sys_logininfor" VALUES (2049486419205844993, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:50:14.621');
INSERT INTO "public"."sys_logininfor" VALUES (2049486453607526402, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:50:22.819');
INSERT INTO "public"."sys_logininfor" VALUES (2049486464177172481, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:50:25.335');
INSERT INTO "public"."sys_logininfor" VALUES (2049486479335387138, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:50:28.95');
INSERT INTO "public"."sys_logininfor" VALUES (2049486480170053634, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:50:29.152');
INSERT INTO "public"."sys_logininfor" VALUES (2049486507160399873, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:50:35.586');
INSERT INTO "public"."sys_logininfor" VALUES (2049486516631138305, '000000', 'parent_zhang', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:50:37.843');
INSERT INTO "public"."sys_logininfor" VALUES (2049486538965807105, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:50:43.176');
INSERT INTO "public"."sys_logininfor" VALUES (2049486541297840130, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:50:43.73');
INSERT INTO "public"."sys_logininfor" VALUES (2049486554040135682, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:50:46.763');
INSERT INTO "public"."sys_logininfor" VALUES (2049486566555938818, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:50:49.748');
INSERT INTO "public"."sys_logininfor" VALUES (2049486571861733377, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:50:51.01');
INSERT INTO "public"."sys_logininfor" VALUES (2049486577188499458, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:50:52.287');
INSERT INTO "public"."sys_logininfor" VALUES (2049486588890607617, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:50:55.076');
INSERT INTO "public"."sys_logininfor" VALUES (2049486599988736001, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:50:57.715');
INSERT INTO "public"."sys_logininfor" VALUES (2049486600974397442, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:50:57.95');
INSERT INTO "public"."sys_logininfor" VALUES (2049486612173189122, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:51:00.628');
INSERT INTO "public"."sys_logininfor" VALUES (2049486630439383041, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:51:04.975');
INSERT INTO "public"."sys_logininfor" VALUES (2049486645308190722, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:51:08.54');
INSERT INTO "public"."sys_logininfor" VALUES (2049486660382519297, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:51:12.125');
INSERT INTO "public"."sys_logininfor" VALUES (2049486674462797826, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:51:15.479');
INSERT INTO "public"."sys_logininfor" VALUES (2049486680880082945, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:51:17.016');
INSERT INTO "public"."sys_logininfor" VALUES (2049486680846528514, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:51:16.995');
INSERT INTO "public"."sys_logininfor" VALUES (2049486700337459201, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:51:21.651');
INSERT INTO "public"."sys_logininfor" VALUES (2049486741185785857, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:51:31.378');
INSERT INTO "public"."sys_logininfor" VALUES (2049486751189200898, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:51:33.766');
INSERT INTO "public"."sys_logininfor" VALUES (2049486762106974210, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:51:36.369');
INSERT INTO "public"."sys_logininfor" VALUES (2049486768343904257, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:51:37.857');
INSERT INTO "public"."sys_logininfor" VALUES (2049486778187935746, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:51:40.203');
INSERT INTO "public"."sys_logininfor" VALUES (2049486784886239233, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:51:41.805');
INSERT INTO "public"."sys_logininfor" VALUES (2049486819795431426, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:51:50.132');
INSERT INTO "public"."sys_logininfor" VALUES (2049486829094203393, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:51:52.34');
INSERT INTO "public"."sys_logininfor" VALUES (2049486917753401346, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:52:13.485');
INSERT INTO "public"."sys_logininfor" VALUES (2049486931993063426, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:52:16.883');
INSERT INTO "public"."sys_logininfor" VALUES (2049486967908888578, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:52:25.436');
INSERT INTO "public"."sys_logininfor" VALUES (2049486972115775490, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:52:26.441');
INSERT INTO "public"."sys_logininfor" VALUES (2049487003824713729, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:52:33.998');
INSERT INTO "public"."sys_logininfor" VALUES (2049487032949960705, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:52:40.948');
INSERT INTO "public"."sys_logininfor" VALUES (2049487038599688193, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:52:42.311');
INSERT INTO "public"."sys_logininfor" VALUES (2049487066844131330, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:52:49.025');
INSERT INTO "public"."sys_logininfor" VALUES (2049487093473767426, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:52:55.384');
INSERT INTO "public"."sys_logininfor" VALUES (2049487143385985025, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:53:07.274');
INSERT INTO "public"."sys_logininfor" VALUES (2049487152756060162, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:53:09.514');
INSERT INTO "public"."sys_logininfor" VALUES (2049487188042739713, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:53:17.915');
INSERT INTO "public"."sys_logininfor" VALUES (2049487240882581505, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:53:30.531');
INSERT INTO "public"."sys_logininfor" VALUES (2049487241352343554, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:53:30.634');
INSERT INTO "public"."sys_logininfor" VALUES (2049487243822788610, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:53:31.224');
INSERT INTO "public"."sys_logininfor" VALUES (2049487272125952001, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:53:37.975');
INSERT INTO "public"."sys_logininfor" VALUES (2049487272679600129, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:53:38.099');
INSERT INTO "public"."sys_logininfor" VALUES (2049487282309722114, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:53:40.405');
INSERT INTO "public"."sys_logininfor" VALUES (2049487288320159746, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:53:41.835');
INSERT INTO "public"."sys_logininfor" VALUES (2049487306309529601, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:53:46.123');
INSERT INTO "public"."sys_logininfor" VALUES (2049487318116495361, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:53:48.929');
INSERT INTO "public"."sys_logininfor" VALUES (2049487318808555521, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:53:49.106');
INSERT INTO "public"."sys_logininfor" VALUES (2049487338257543170, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:53:53.774');
INSERT INTO "public"."sys_logininfor" VALUES (2049487339943653378, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:53:54.142');
INSERT INTO "public"."sys_logininfor" VALUES (2049487341160001538, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:53:54.423');
INSERT INTO "public"."sys_logininfor" VALUES (2049487362701946881, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:53:59.576');
INSERT INTO "public"."sys_logininfor" VALUES (2049487399985115139, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:54:08.46');
INSERT INTO "public"."sys_logininfor" VALUES (2049487399985115138, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:54:08.46');
INSERT INTO "public"."sys_logininfor" VALUES (2049487401012719618, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:54:08.701');
INSERT INTO "public"."sys_logininfor" VALUES (2049487423712292866, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:54:14.107');
INSERT INTO "public"."sys_logininfor" VALUES (2049487431849242626, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:54:16.052');
INSERT INTO "public"."sys_logininfor" VALUES (2049487436446199809, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:54:17.149');
INSERT INTO "public"."sys_logininfor" VALUES (2049487465013604353, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:54:23.963');
INSERT INTO "public"."sys_logininfor" VALUES (2049487536803311617, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:54:41.075');
INSERT INTO "public"."sys_logininfor" VALUES (2049487543363203073, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:54:42.634');
INSERT INTO "public"."sys_logininfor" VALUES (2049487598572826625, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:54:55.806');
INSERT INTO "public"."sys_logininfor" VALUES (2049487659767721986, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:55:10.386');
INSERT INTO "public"."sys_logininfor" VALUES (2049487672853950465, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:55:13.506');
INSERT INTO "public"."sys_logininfor" VALUES (2049487692655259649, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:55:18.227');
INSERT INTO "public"."sys_logininfor" VALUES (2049487758069624834, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:55:33.823');
INSERT INTO "public"."sys_logininfor" VALUES (2049487830064852993, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:55:50.989');
INSERT INTO "public"."sys_logininfor" VALUES (2049488176032018434, '000000', 'child_xiaoming', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:57:13.474');
INSERT INTO "public"."sys_logininfor" VALUES (2049488207837425665, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:57:21.056');
INSERT INTO "public"."sys_logininfor" VALUES (2049487458839588866, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:54:22.482');
INSERT INTO "public"."sys_logininfor" VALUES (2049487492704399361, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:54:30.557');
INSERT INTO "public"."sys_logininfor" VALUES (2049487555107254274, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:54:45.435');
INSERT INTO "public"."sys_logininfor" VALUES (2049487637575659522, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:55:05.102');
INSERT INTO "public"."sys_logininfor" VALUES (2049487702142775297, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:55:20.502');
INSERT INTO "public"."sys_logininfor" VALUES (2049487740684234753, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:55:29.683');
INSERT INTO "public"."sys_logininfor" VALUES (2049487854215655425, '000000', 'child_xiaoming', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:55:56.747');
INSERT INTO "public"."sys_logininfor" VALUES (2049487490015850497, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:54:29.917');
INSERT INTO "public"."sys_logininfor" VALUES (2049487513822720002, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:54:35.591');
INSERT INTO "public"."sys_logininfor" VALUES (2049487633905643521, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:55:04.225');
INSERT INTO "public"."sys_logininfor" VALUES (2049487671474024449, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:55:13.179');
INSERT INTO "public"."sys_logininfor" VALUES (2049487701404577793, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:55:20.314');
INSERT INTO "public"."sys_logininfor" VALUES (2049487734225006594, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:55:28.14');
INSERT INTO "public"."sys_logininfor" VALUES (2049487761701892097, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:55:34.701');
INSERT INTO "public"."sys_logininfor" VALUES (2049487889619775490, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:56:05.186');
INSERT INTO "public"."sys_logininfor" VALUES (2049488156012605441, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 21:57:08.705');
INSERT INTO "public"."sys_logininfor" VALUES (2049487498224103425, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-29 21:54:31.877');
INSERT INTO "public"."sys_logininfor" VALUES (2049489019963731970, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 22:00:34.691');
INSERT INTO "public"."sys_logininfor" VALUES (2049489039593074689, '000000', 'child_xiaoming', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 22:00:39.364');
INSERT INTO "public"."sys_logininfor" VALUES (2049489070123413505, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 22:00:46.64');
INSERT INTO "public"."sys_logininfor" VALUES (2049496323350097922, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-29 22:29:35.955');
INSERT INTO "public"."sys_logininfor" VALUES (2049535771836223489, '000000', 'parent_test_final', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '注册成功', '2026-04-30 01:06:21.194');
INSERT INTO "public"."sys_logininfor" VALUES (2049536440605413378, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:09:00.645');
INSERT INTO "public"."sys_logininfor" VALUES (2049536469273481218, '000000', 'child_xiaoming', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:09:07.486');
INSERT INTO "public"."sys_logininfor" VALUES (2049536503821963265, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:09:15.711');
INSERT INTO "public"."sys_logininfor" VALUES (2049536742503026689, '000000', 'child_xiaoming', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:10:12.632');
INSERT INTO "public"."sys_logininfor" VALUES (2049536744851836930, '000000', 'child_xiaoming', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:10:13.193');
INSERT INTO "public"."sys_logininfor" VALUES (2049536744923140097, '000000', 'child_xiaoming', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:10:13.196');
INSERT INTO "public"."sys_logininfor" VALUES (2049536786090233858, '000000', 'child_xiaoming', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:10:23.001');
INSERT INTO "public"."sys_logininfor" VALUES (2049536788816531458, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:10:23.67');
INSERT INTO "public"."sys_logininfor" VALUES (2049536907846684673, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:10:52.042');
INSERT INTO "public"."sys_logininfor" VALUES (2049537083164397570, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:11:33.851');
INSERT INTO "public"."sys_logininfor" VALUES (2049537104697954305, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:11:38.986');
INSERT INTO "public"."sys_logininfor" VALUES (2049537125048717314, '000000', 'parent_zhang', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:11:43.874');
INSERT INTO "public"."sys_logininfor" VALUES (2049537147492438018, '000000', 'parent_zhang', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:11:49.178');
INSERT INTO "public"."sys_logininfor" VALUES (2049537187778727938, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:11:58.782');
INSERT INTO "public"."sys_logininfor" VALUES (2049537187854225410, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:11:58.801');
INSERT INTO "public"."sys_logininfor" VALUES (2049537187850031106, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:11:58.8');
INSERT INTO "public"."sys_logininfor" VALUES (2049537370105122818, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:12:42.258');
INSERT INTO "public"."sys_logininfor" VALUES (2049537412564062210, '000000', 'parent_zhang', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:12:52.388');
INSERT INTO "public"."sys_logininfor" VALUES (2049537464003006466, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:13:04.643');
INSERT INTO "public"."sys_logininfor" VALUES (2049537464044949506, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:13:04.662');
INSERT INTO "public"."sys_logininfor" VALUES (2049537485490425857, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:13:09.767');
INSERT INTO "public"."sys_logininfor" VALUES (2049537486316703745, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:13:09.973');
INSERT INTO "public"."sys_logininfor" VALUES (2049538504299450370, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:17:12.673');
INSERT INTO "public"."sys_logininfor" VALUES (2049538538562719745, '000000', 'child_xiaoming', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:17:20.849');
INSERT INTO "public"."sys_logininfor" VALUES (2049538608263663617, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:17:37.459');
INSERT INTO "public"."sys_logininfor" VALUES (2049538781404532738, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:18:18.746');
INSERT INTO "public"."sys_logininfor" VALUES (2049538836421218306, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:18:31.858');
INSERT INTO "public"."sys_logininfor" VALUES (2049538898031349761, '000000', 'child_xiaoming', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 01:18:46.552');
INSERT INTO "public"."sys_logininfor" VALUES (2049538898098458626, '000000', 'child_xiaoming', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 01:18:46.568');
INSERT INTO "public"."sys_logininfor" VALUES (2049538907921518593, '000000', 'child_xiaoming', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 01:18:48.896');
INSERT INTO "public"."sys_logininfor" VALUES (2049538997201473538, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:19:10.197');
INSERT INTO "public"."sys_logininfor" VALUES (2049539155578392577, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 01:19:47.952');
INSERT INTO "public"."sys_logininfor" VALUES (2049539156589219841, '000000', 'child_xiaoming', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 01:19:48.192');
INSERT INTO "public"."sys_logininfor" VALUES (2049539327142203393, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 01:20:28.852');
INSERT INTO "public"."sys_logininfor" VALUES (2049539374110019585, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:20:40.057');
INSERT INTO "public"."sys_logininfor" VALUES (2049539412773113857, '000000', 'child_xiaoming', 'app', 'android', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:20:49.263');
INSERT INTO "public"."sys_logininfor" VALUES (2049539436504485890, '000000', 'child_xiaoming', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:20:54.931');
INSERT INTO "public"."sys_logininfor" VALUES (2049539497535803393, '000000', 'parent_zhang', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 01:21:09.481');
INSERT INTO "public"."sys_logininfor" VALUES (2049539498827649026, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 01:21:09.79');
INSERT INTO "public"."sys_logininfor" VALUES (2049539581757427713, '000000', 'child_xiaoming', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:21:29.562');
INSERT INTO "public"."sys_logininfor" VALUES (2049539606830977026, '000000', 'child_xiaoming', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:21:35.547');
INSERT INTO "public"."sys_logininfor" VALUES (2049539721943650305, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:22:02.957');
INSERT INTO "public"."sys_logininfor" VALUES (2049539761462382593, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:22:12.399');
INSERT INTO "public"."sys_logininfor" VALUES (2049539769964236802, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 01:22:14.442');
INSERT INTO "public"."sys_logininfor" VALUES (2049539783675416578, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 01:22:17.705');
INSERT INTO "public"."sys_logininfor" VALUES (2049539815422103554, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 01:22:25.308');
INSERT INTO "public"."sys_logininfor" VALUES (2049539960603742210, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:22:59.89');
INSERT INTO "public"."sys_logininfor" VALUES (2049540256872599553, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 01:24:10.525');
INSERT INTO "public"."sys_logininfor" VALUES (2049540315903234050, '000000', 'parent_zhang', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 01:24:24.584');
INSERT INTO "public"."sys_logininfor" VALUES (2049540518840438785, '000000', 'ken2zhao', 'app', 'android', '127.0.0.1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 01:25:12.983');
INSERT INTO "public"."sys_logininfor" VALUES (2049542052458336257, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:31:18.618');
INSERT INTO "public"."sys_logininfor" VALUES (2049542518843969537, '000000', 'ken2zhao', 'pc', 'pc', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:33:09.817');
INSERT INTO "public"."sys_logininfor" VALUES (2049542575492239362, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:33:23.324');
INSERT INTO "public"."sys_logininfor" VALUES (2049542576767307778, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:33:23.625');
INSERT INTO "public"."sys_logininfor" VALUES (2049543045761798146, '000000', 'parent_zhang', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:35:15.447');
INSERT INTO "public"."sys_logininfor" VALUES (2049543222971142146, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:35:57.685');
INSERT INTO "public"."sys_logininfor" VALUES (2049543228734115842, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:35:59.06');
INSERT INTO "public"."sys_logininfor" VALUES (2049543730494509057, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:37:58.696');
INSERT INTO "public"."sys_logininfor" VALUES (2049543767295332354, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:38:07.469');
INSERT INTO "public"."sys_logininfor" VALUES (2049543770617221122, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:38:08.26');
INSERT INTO "public"."sys_logininfor" VALUES (2049543809993347074, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:38:17.647');
INSERT INTO "public"."sys_logininfor" VALUES (2049543830226669570, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:38:22.474');
INSERT INTO "public"."sys_logininfor" VALUES (2049543885302075393, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:38:35.598');
INSERT INTO "public"."sys_logininfor" VALUES (2049543905090801666, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:38:40.323');
INSERT INTO "public"."sys_logininfor" VALUES (2049540436959236097, '000000', 'ken2zhao', 'app', 'android', '127.0.0.1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 01:24:53.456');
INSERT INTO "public"."sys_logininfor" VALUES (2049540465887350786, '000000', 'ken2zhao', 'app', 'android', '127.0.0.1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 01:25:00.348');
INSERT INTO "public"."sys_logininfor" VALUES (2049540469234405377, '000000', 'ken2zhao', 'app', 'android', '127.0.0.1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 01:25:01.149');
INSERT INTO "public"."sys_logininfor" VALUES (2049540940380573698, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 01:26:53.476');
INSERT INTO "public"."sys_logininfor" VALUES (2049540940380573699, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 01:26:53.483');
INSERT INTO "public"."sys_logininfor" VALUES (2049540940766449665, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 01:26:53.566');
INSERT INTO "public"."sys_logininfor" VALUES (2049541016939204609, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 01:27:11.733');
INSERT INTO "public"."sys_logininfor" VALUES (2049541017450909698, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 01:27:11.851');
INSERT INTO "public"."sys_logininfor" VALUES (2049541019380289537, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 01:27:12.315');
INSERT INTO "public"."sys_logininfor" VALUES (2049541051567378433, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 01:27:19.988');
INSERT INTO "public"."sys_logininfor" VALUES (2049541052267827201, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 01:27:20.158');
INSERT INTO "public"."sys_logininfor" VALUES (2049541171612553218, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 01:27:48.616');
INSERT INTO "public"."sys_logininfor" VALUES (2049541984992956417, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:31:02.541');
INSERT INTO "public"."sys_logininfor" VALUES (2049541985118785538, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:31:02.57');
INSERT INTO "public"."sys_logininfor" VALUES (2049541985311723522, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:31:02.616');
INSERT INTO "public"."sys_logininfor" VALUES (2049542051875328001, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:31:18.487');
INSERT INTO "public"."sys_logininfor" VALUES (2049542216505954305, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:31:57.729');
INSERT INTO "public"."sys_logininfor" VALUES (2049542299897106434, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:32:17.623');
INSERT INTO "public"."sys_logininfor" VALUES (2049542300668858370, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:32:17.799');
INSERT INTO "public"."sys_logininfor" VALUES (2049542398933012481, '000000', 'parent_zhang', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:32:41.224');
INSERT INTO "public"."sys_logininfor" VALUES (2049542485675413505, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:33:01.915');
INSERT INTO "public"."sys_logininfor" VALUES (2049542537869332482, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:33:14.356');
INSERT INTO "public"."sys_logininfor" VALUES (2049543045375922177, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:35:15.351');
INSERT INTO "public"."sys_logininfor" VALUES (2049543223352823810, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:35:57.778');
INSERT INTO "public"."sys_logininfor" VALUES (2049543223478652929, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:35:57.819');
INSERT INTO "public"."sys_logininfor" VALUES (2049543730494509058, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:37:58.696');
INSERT INTO "public"."sys_logininfor" VALUES (2049543730943299585, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:37:58.807');
INSERT INTO "public"."sys_logininfor" VALUES (2049544781801000961, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 01:42:09.358');
INSERT INTO "public"."sys_logininfor" VALUES (2049544829838364673, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 01:42:20.805');
INSERT INTO "public"."sys_logininfor" VALUES (2049544904660553729, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 01:42:38.642');
INSERT INTO "public"."sys_logininfor" VALUES (2049544904924794882, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 01:42:38.698');
INSERT INTO "public"."sys_logininfor" VALUES (2049544998608769026, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 01:43:01.033');
INSERT INTO "public"."sys_logininfor" VALUES (2049545119316643841, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 01:43:29.821');
INSERT INTO "public"."sys_logininfor" VALUES (2049545120021286914, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 01:43:29.988');
INSERT INTO "public"."sys_logininfor" VALUES (2049545124932816897, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 01:43:31.162');
INSERT INTO "public"."sys_logininfor" VALUES (2049545126727979009, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 01:43:31.585');
INSERT INTO "public"."sys_logininfor" VALUES (2049545229689753602, '000000', 'parent_zhang', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 01:43:56.139');
INSERT INTO "public"."sys_logininfor" VALUES (2049545434623447041, '000000', 'ken2zhao', 'pc', 'pc', '127.0.0.1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 01:44:44.994');
INSERT INTO "public"."sys_logininfor" VALUES (2049545458463870978, '000000', 'ken2zhao', 'pc', 'pc', '127.0.0.1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 01:44:50.67');
INSERT INTO "public"."sys_logininfor" VALUES (2049545499274448897, '000000', 'ken2zhao', 'pc', 'pc', '127.0.0.1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 01:45:00.411');
INSERT INTO "public"."sys_logininfor" VALUES (2049545566832103426, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:45:16.507');
INSERT INTO "public"."sys_logininfor" VALUES (2049545567985537025, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:45:16.787');
INSERT INTO "public"."sys_logininfor" VALUES (2049545639498420225, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:45:33.841');
INSERT INTO "public"."sys_logininfor" VALUES (2049545651427020802, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:45:36.683');
INSERT INTO "public"."sys_logininfor" VALUES (2049545701645422593, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:45:48.649');
INSERT INTO "public"."sys_logininfor" VALUES (2049545719957753858, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:45:53.021');
INSERT INTO "public"."sys_logininfor" VALUES (2049545831253610498, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:46:19.559');
INSERT INTO "public"."sys_logininfor" VALUES (2049545872156463105, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:46:29.305');
INSERT INTO "public"."sys_logininfor" VALUES (2049545934689341441, '000000', 'parent_zhang', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:46:44.216');
INSERT INTO "public"."sys_logininfor" VALUES (2049545951957291010, '000000', 'parent_zhang', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 01:46:48.331');
INSERT INTO "public"."sys_logininfor" VALUES (2049546085906583554, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:47:20.272');
INSERT INTO "public"."sys_logininfor" VALUES (2049546090226716673, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 01:47:21.295');
INSERT INTO "public"."sys_logininfor" VALUES (2049546140885520385, '000000', 'ken2zhao', 'pc', 'pc', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:47:33.378');
INSERT INTO "public"."sys_logininfor" VALUES (2049546146950483970, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:47:34.828');
INSERT INTO "public"."sys_logininfor" VALUES (2049546160145764354, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 01:47:37.972');
INSERT INTO "public"."sys_logininfor" VALUES (2049546161299197954, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 01:47:38.251');
INSERT INTO "public"."sys_logininfor" VALUES (2049546171642351618, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 01:47:40.716');
INSERT INTO "public"."sys_logininfor" VALUES (2049546517454327810, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:49:03.157');
INSERT INTO "public"."sys_logininfor" VALUES (2049546744781410305, '000000', 'ken2zhao', 'pc', 'pc', '127.0.0.1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 01:49:57.353');
INSERT INTO "public"."sys_logininfor" VALUES (2049546522864979970, '000000', 'parent_zhang', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:49:04.455');
INSERT INTO "public"."sys_logininfor" VALUES (2049546773659193345, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 01:50:04.249');
INSERT INTO "public"."sys_logininfor" VALUES (2049546777400512513, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:50:05.134');
INSERT INTO "public"."sys_logininfor" VALUES (2049546791237521409, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 01:50:08.43');
INSERT INTO "public"."sys_logininfor" VALUES (2049546919784550401, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 01:50:39.084');
INSERT INTO "public"."sys_logininfor" VALUES (2049547018631712769, '000000', 'ken2zhao', 'pc', 'pc', '127.0.0.1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 01:51:02.649');
INSERT INTO "public"."sys_logininfor" VALUES (2049547296772788226, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:52:08.961');
INSERT INTO "public"."sys_logininfor" VALUES (2049547338304786434, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:52:18.862');
INSERT INTO "public"."sys_logininfor" VALUES (2049547344654962689, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:52:20.38');
INSERT INTO "public"."sys_logininfor" VALUES (2049547361558007810, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:52:24.413');
INSERT INTO "public"."sys_logininfor" VALUES (2049547433242857474, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:52:41.495');
INSERT INTO "public"."sys_logininfor" VALUES (2049547475567579137, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:52:51.592');
INSERT INTO "public"."sys_logininfor" VALUES (2049547552302370817, '000000', 'ken2zhao', 'pc', 'pc', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:53:09.881');
INSERT INTO "public"."sys_logininfor" VALUES (2049548287228317697, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 01:56:05.099');
INSERT INTO "public"."sys_logininfor" VALUES (2049548312754851842, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 01:56:11.184');
INSERT INTO "public"."sys_logininfor" VALUES (2049548337350250498, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 01:56:17.061');
INSERT INTO "public"."sys_logininfor" VALUES (2049548346527387649, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 01:56:19.249');
INSERT INTO "public"."sys_logininfor" VALUES (2049548391704236034, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 01:56:30.019');
INSERT INTO "public"."sys_logininfor" VALUES (2049548406703067137, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 01:56:33.585');
INSERT INTO "public"."sys_logininfor" VALUES (2049548429360697345, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 01:56:38.998');
INSERT INTO "public"."sys_logininfor" VALUES (2049548459027009538, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 01:56:46.063');
INSERT INTO "public"."sys_logininfor" VALUES (2049548469235945473, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 01:56:48.501');
INSERT INTO "public"."sys_logininfor" VALUES (2049548497853681666, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 01:56:55.319');
INSERT INTO "public"."sys_logininfor" VALUES (2049548523678011393, '000000', 'parent_zhang', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 01:57:01.482');
INSERT INTO "public"."sys_logininfor" VALUES (2049548650228551682, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 01:57:31.648');
INSERT INTO "public"."sys_logininfor" VALUES (2049548657287565313, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 01:57:33.328');
INSERT INTO "public"."sys_logininfor" VALUES (2049548671648862210, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 01:57:36.756');
INSERT INTO "public"."sys_logininfor" VALUES (2049548916793348098, '000000', 'parent_zhang', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 01:58:35.203');
INSERT INTO "public"."sys_logininfor" VALUES (2049548931272085505, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 01:58:38.66');
INSERT INTO "public"."sys_logininfor" VALUES (2049549054983081986, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 01:59:08.156');
INSERT INTO "public"."sys_logininfor" VALUES (2049549068736204801, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 01:59:11.429');
INSERT INTO "public"."sys_logininfor" VALUES (2049549076290146306, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 01:59:13.229');
INSERT INTO "public"."sys_logininfor" VALUES (2049549092748595201, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 01:59:17.161');
INSERT INTO "public"."sys_logininfor" VALUES (2049549500573356034, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 02:00:54.384');
INSERT INTO "public"."sys_logininfor" VALUES (2049549510744543233, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 02:00:56.807');
INSERT INTO "public"."sys_logininfor" VALUES (2049549528637444098, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 02:01:01.082');
INSERT INTO "public"."sys_logininfor" VALUES (2049549535398662145, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 02:01:02.693');
INSERT INTO "public"."sys_logininfor" VALUES (2049549546928803841, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 02:01:05.443');
INSERT INTO "public"."sys_logininfor" VALUES (2049549589857505281, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 02:01:15.678');
INSERT INTO "public"."sys_logininfor" VALUES (2049549616390672385, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 02:01:21.997');
INSERT INTO "public"."sys_logininfor" VALUES (2049549633893502977, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 02:01:26.181');
INSERT INTO "public"."sys_logininfor" VALUES (2049549683176574977, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 02:01:37.918');
INSERT INTO "public"."sys_logininfor" VALUES (2049546750867345410, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:49:58.806');
INSERT INTO "public"."sys_logininfor" VALUES (2049546751106420738, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:49:58.868');
INSERT INTO "public"."sys_logininfor" VALUES (2049546779392806914, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:50:05.613');
INSERT INTO "public"."sys_logininfor" VALUES (2049547028807094273, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 01:51:05.069');
INSERT INTO "public"."sys_logininfor" VALUES (2049547347762941954, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:52:21.119');
INSERT INTO "public"."sys_logininfor" VALUES (2049547552432394241, '000000', 'ken2zhao', 'pc', 'pc', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 01:53:09.916');
INSERT INTO "public"."sys_logininfor" VALUES (2049680538247172099, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 10:41:36.203');
INSERT INTO "public"."sys_logininfor" VALUES (2049680538247172098, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 10:41:36.203');
INSERT INTO "public"."sys_logininfor" VALUES (2049681081795416065, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 10:43:45.79');
INSERT INTO "public"."sys_logininfor" VALUES (2049682409703673858, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 10:49:02.389');
INSERT INTO "public"."sys_logininfor" VALUES (2049682444927438850, '000000', 'child_xiaoming', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 10:49:10.787');
INSERT INTO "public"."sys_logininfor" VALUES (2049682478003720194, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 10:49:18.672');
INSERT INTO "public"."sys_logininfor" VALUES (2049682706538762241, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 10:50:13.159');
INSERT INTO "public"."sys_logininfor" VALUES (2049682711030861826, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 10:50:14.232');
INSERT INTO "public"."sys_logininfor" VALUES (2049682771613388801, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 10:50:28.674');
INSERT INTO "public"."sys_logininfor" VALUES (2049682789795696641, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 10:50:33.013');
INSERT INTO "public"."sys_logininfor" VALUES (2049682835870126081, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 10:50:44.008');
INSERT INTO "public"."sys_logininfor" VALUES (2049682852529901570, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 10:50:47.966');
INSERT INTO "public"."sys_logininfor" VALUES (2049682930854334465, '000000', 'child_xiaoming', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 10:51:06.639');
INSERT INTO "public"."sys_logininfor" VALUES (2049682941201682433, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 10:51:09.107');
INSERT INTO "public"."sys_logininfor" VALUES (2049682946666860546, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 10:51:10.423');
INSERT INTO "public"."sys_logininfor" VALUES (2049682993286549505, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 10:51:21.524');
INSERT INTO "public"."sys_logininfor" VALUES (2049683034562695169, '000000', 'child_xiaoming', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 10:51:31.366');
INSERT INTO "public"."sys_logininfor" VALUES (2049683036588544002, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 10:51:31.851');
INSERT INTO "public"."sys_logininfor" VALUES (2049683117362450433, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 10:51:51.119');
INSERT INTO "public"."sys_logininfor" VALUES (2049683134315827202, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 10:51:55.16');
INSERT INTO "public"."sys_logininfor" VALUES (2049683198878748674, '000000', 'child_xiaoming', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 10:52:10.55');
INSERT INTO "public"."sys_logininfor" VALUES (2049683226246582274, '000000', 'child_xiaoming', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 10:52:17.067');
INSERT INTO "public"."sys_logininfor" VALUES (2049683359940022274, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 10:52:48.949');
INSERT INTO "public"."sys_logininfor" VALUES (2049683395230896129, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 10:52:57.362');
INSERT INTO "public"."sys_logininfor" VALUES (2049683489363660801, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 10:53:19.806');
INSERT INTO "public"."sys_logininfor" VALUES (2049683522393804801, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 10:53:27.674');
INSERT INTO "public"."sys_logininfor" VALUES (2049683539905024002, '000000', 'parent_zhang', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 10:53:31.858');
INSERT INTO "public"."sys_logininfor" VALUES (2049683588181463041, '000000', 'parent_zhang', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 10:53:43.362');
INSERT INTO "public"."sys_logininfor" VALUES (2049683670540816385, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 10:54:03.001');
INSERT INTO "public"."sys_logininfor" VALUES (2049683715239514113, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 10:54:13.653');
INSERT INTO "public"."sys_logininfor" VALUES (2049683746419970049, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 10:54:21.087');
INSERT INTO "public"."sys_logininfor" VALUES (2049684002863910913, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 10:55:22.24');
INSERT INTO "public"."sys_logininfor" VALUES (2049684414463545345, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 10:57:00.363');
INSERT INTO "public"."sys_logininfor" VALUES (2049684436752076801, '000000', 'parent_zhang', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 10:57:05.686');
INSERT INTO "public"."sys_logininfor" VALUES (2049684701244887041, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 10:58:08.736');
INSERT INTO "public"."sys_logininfor" VALUES (2049684713542586369, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 10:58:11.679');
INSERT INTO "public"."sys_logininfor" VALUES (2049684757788299266, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 10:58:22.229');
INSERT INTO "public"."sys_logininfor" VALUES (2049689691585843201, '000000', 'child_xiaoming', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 11:17:58.536');
INSERT INTO "public"."sys_logininfor" VALUES (2049689734304829441, '000000', 'child_xiaoming', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 11:18:08.718');
INSERT INTO "public"."sys_logininfor" VALUES (2049689858493976577, '000000', 'child_xiaoming', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 11:18:38.329');
INSERT INTO "public"."sys_logininfor" VALUES (2049689903083622401, '000000', 'child_xiaoming', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 11:18:48.953');
INSERT INTO "public"."sys_logininfor" VALUES (2049690089210056705, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 11:19:33.333');
INSERT INTO "public"."sys_logininfor" VALUES (2049690139407486977, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 11:19:45.304');
INSERT INTO "public"."sys_logininfor" VALUES (2049690284693983233, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 11:20:19.938');
INSERT INTO "public"."sys_logininfor" VALUES (2049690328830644226, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 11:20:30.456');
INSERT INTO "public"."sys_logininfor" VALUES (2049690362045337601, '000000', 'parent_zhang', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 11:20:38.39');
INSERT INTO "public"."sys_logininfor" VALUES (2049690675796054017, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 11:21:53.182');
INSERT INTO "public"."sys_logininfor" VALUES (2049690725523722241, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 11:22:05.035');
INSERT INTO "public"."sys_logininfor" VALUES (2049690776207691777, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 11:22:17.124');
INSERT INTO "public"."sys_logininfor" VALUES (2049691543756935169, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 11:25:20.127');
INSERT INTO "public"."sys_logininfor" VALUES (2049691583535714306, '000000', 'parent_zhang', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 11:25:29.608');
INSERT INTO "public"."sys_logininfor" VALUES (2049691984716697602, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 11:27:05.26');
INSERT INTO "public"."sys_logininfor" VALUES (2049693483823861762, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 11:33:02.669');
INSERT INTO "public"."sys_logininfor" VALUES (2049693509824352257, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 11:33:08.866');
INSERT INTO "public"."sys_logininfor" VALUES (2049693572696969218, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 11:33:23.862');
INSERT INTO "public"."sys_logininfor" VALUES (2049693606960238593, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 11:33:32.024');
INSERT INTO "public"."sys_logininfor" VALUES (2049693750703230977, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 11:34:06.298');
INSERT INTO "public"."sys_logininfor" VALUES (2049693849638473729, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 11:34:29.889');
INSERT INTO "public"."sys_logininfor" VALUES (2049693930416574466, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 11:34:49.15');
INSERT INTO "public"."sys_logininfor" VALUES (2049693980706279425, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 11:35:01.131');
INSERT INTO "public"."sys_logininfor" VALUES (2049691896678256641, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 11:26:44.264');
INSERT INTO "public"."sys_logininfor" VALUES (2049691922825547777, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 11:26:50.499');
INSERT INTO "public"."sys_logininfor" VALUES (2049691952894513154, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 11:26:57.676');
INSERT INTO "public"."sys_logininfor" VALUES (2049693864469532673, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 11:34:33.429');
INSERT INTO "public"."sys_logininfor" VALUES (2049695770122194945, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 11:42:07.764');
INSERT INTO "public"."sys_logininfor" VALUES (2049695797657800705, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 11:42:14.337');
INSERT INTO "public"."sys_logininfor" VALUES (2049695885419417601, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 11:42:35.251');
INSERT INTO "public"."sys_logininfor" VALUES (2049695898820218882, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 11:42:38.45');
INSERT INTO "public"."sys_logininfor" VALUES (2049696106253717506, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 11:43:27.9');
INSERT INTO "public"."sys_logininfor" VALUES (2049696136905691138, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 11:43:35.216');
INSERT INTO "public"."sys_logininfor" VALUES (2049696206539526145, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 11:43:51.812');
INSERT INTO "public"."sys_logininfor" VALUES (2049696235866099714, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 11:43:58.806');
INSERT INTO "public"."sys_logininfor" VALUES (2049696248574840834, '000000', 'parent_zhang', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 11:44:01.84');
INSERT INTO "public"."sys_logininfor" VALUES (2049696456134168577, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 11:44:51.324');
INSERT INTO "public"."sys_logininfor" VALUES (2049696478691135490, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 11:44:56.702');
INSERT INTO "public"."sys_logininfor" VALUES (2049696505610178562, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 11:45:03.116');
INSERT INTO "public"."sys_logininfor" VALUES (2049697110462369793, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 11:47:27.328');
INSERT INTO "public"."sys_logininfor" VALUES (2049697138316742657, '000000', 'parent_zhang', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 11:47:33.974');
INSERT INTO "public"."sys_logininfor" VALUES (2049697402650169346, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 11:48:36.998');
INSERT INTO "public"."sys_logininfor" VALUES (2049697413890904066, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 11:48:39.678');
INSERT INTO "public"."sys_logininfor" VALUES (2049697454806339585, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 11:48:49.428');
INSERT INTO "public"."sys_logininfor" VALUES (2049697474213384193, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 11:48:54.049');
INSERT INTO "public"."sys_logininfor" VALUES (2049698926537281537, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 11:54:40.321');
INSERT INTO "public"."sys_logininfor" VALUES (2049698990236176385, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 11:54:55.5');
INSERT INTO "public"."sys_logininfor" VALUES (2049699024855961602, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 11:55:03.758');
INSERT INTO "public"."sys_logininfor" VALUES (2049699060075532289, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 11:55:12.147');
INSERT INTO "public"."sys_logininfor" VALUES (2049699207857639426, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 11:55:47.392');
INSERT INTO "public"."sys_logininfor" VALUES (2049699381472464897, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 11:56:28.782');
INSERT INTO "public"."sys_logininfor" VALUES (2049699397566009345, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 11:56:32.622');
INSERT INTO "public"."sys_logininfor" VALUES (2049699495691751426, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 11:56:56.012');
INSERT INTO "public"."sys_logininfor" VALUES (2049699539090214913, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 11:57:06.365');
INSERT INTO "public"."sys_logininfor" VALUES (2049701393257795586, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 12:04:28.425');
INSERT INTO "public"."sys_logininfor" VALUES (2049701425377775617, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 12:04:36.08');
INSERT INTO "public"."sys_logininfor" VALUES (2049701533989277697, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 12:05:01.973');
INSERT INTO "public"."sys_logininfor" VALUES (2049701569078824962, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 12:05:10.34');
INSERT INTO "public"."sys_logininfor" VALUES (2049701814034567169, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 12:06:08.753');
INSERT INTO "public"."sys_logininfor" VALUES (2049701847995846658, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 12:06:16.84');
INSERT INTO "public"."sys_logininfor" VALUES (2049701932972445698, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 12:06:37.099');
INSERT INTO "public"."sys_logininfor" VALUES (2049701965016928258, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 12:06:44.748');
INSERT INTO "public"."sys_logininfor" VALUES (2049702016522981378, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 12:06:57.03');
INSERT INTO "public"."sys_logininfor" VALUES (2049702055962021889, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 12:07:06.421');
INSERT INTO "public"."sys_logininfor" VALUES (2049702074794446850, '000000', 'parent_zhang', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 12:07:10.912');
INSERT INTO "public"."sys_logininfor" VALUES (2049702336250580994, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 12:08:13.248');
INSERT INTO "public"."sys_logininfor" VALUES (2049702370115391490, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 12:08:21.33');
INSERT INTO "public"."sys_logininfor" VALUES (2049702394433966081, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 12:08:27.124');
INSERT INTO "public"."sys_logininfor" VALUES (2049703106786168833, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 12:11:16.957');
INSERT INTO "public"."sys_logininfor" VALUES (2049703135118692353, '000000', 'parent_zhang', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 12:11:23.713');
INSERT INTO "public"."sys_logininfor" VALUES (2049703431249137665, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 12:12:34.319');
INSERT INTO "public"."sys_logininfor" VALUES (2049703453189541889, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 12:12:39.558');
INSERT INTO "public"."sys_logininfor" VALUES (2049703470704955394, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 12:12:43.727');
INSERT INTO "public"."sys_logininfor" VALUES (2049703496541868033, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 12:12:49.883');
INSERT INTO "public"."sys_logininfor" VALUES (2049704886395801601, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 12:18:21.25');
INSERT INTO "public"."sys_logininfor" VALUES (2049704906461351937, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 12:18:26.04');
INSERT INTO "public"."sys_logininfor" VALUES (2049704957191458818, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 12:18:38.131');
INSERT INTO "public"."sys_logininfor" VALUES (2049704983766568962, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 12:18:44.472');
INSERT INTO "public"."sys_logininfor" VALUES (2049705123969568770, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 12:19:17.896');
INSERT INTO "public"."sys_logininfor" VALUES (2049705214168076289, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 12:19:39.4');
INSERT INTO "public"."sys_logininfor" VALUES (2049705233386377218, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 12:19:43.986');
INSERT INTO "public"."sys_logininfor" VALUES (2049705301971636226, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 12:20:00.337');
INSERT INTO "public"."sys_logininfor" VALUES (2049705360289239042, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-04-30 12:20:14.234');
INSERT INTO "public"."sys_logininfor" VALUES (2049707856881586178, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 12:30:09.472');
INSERT INTO "public"."sys_logininfor" VALUES (2049707920362377217, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 12:30:24.609');
INSERT INTO "public"."sys_logininfor" VALUES (2049707979678224386, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 12:30:38.751');
INSERT INTO "public"."sys_logininfor" VALUES (2049708037744168961, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 12:30:52.6');
INSERT INTO "public"."sys_logininfor" VALUES (2049708095482957825, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 12:31:06.37');
INSERT INTO "public"."sys_logininfor" VALUES (2049708163590066178, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 12:31:22.594');
INSERT INTO "public"."sys_logininfor" VALUES (2049708228094267393, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 12:31:37.982');
INSERT INTO "public"."sys_logininfor" VALUES (2049708364241375234, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 12:32:10.435');
INSERT INTO "public"."sys_logininfor" VALUES (2049708415206363138, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 12:32:22.591');
INSERT INTO "public"."sys_logininfor" VALUES (2049708475864387586, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 12:32:37.049');
INSERT INTO "public"."sys_logininfor" VALUES (2049708535771631618, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 12:32:51.329');
INSERT INTO "public"."sys_logininfor" VALUES (2049708596920389633, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 12:33:05.907');
INSERT INTO "public"."sys_logininfor" VALUES (2049708659457462273, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 12:33:20.827');
INSERT INTO "public"."sys_logininfor" VALUES (2049708719708639234, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 12:33:35.184');
INSERT INTO "public"."sys_logininfor" VALUES (2049708780626710529, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 12:33:49.707');
INSERT INTO "public"."sys_logininfor" VALUES (2049708798616080385, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 12:33:54.007');
INSERT INTO "public"."sys_logininfor" VALUES (2049708989163311105, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 12:34:39.425');
INSERT INTO "public"."sys_logininfor" VALUES (2049709032792461313, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 12:34:49.839');
INSERT INTO "public"."sys_logininfor" VALUES (2049709054909026305, '000000', 'child_xiaoming', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 12:34:55.107');
INSERT INTO "public"."sys_logininfor" VALUES (2049709100316561410, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 12:35:05.93');
INSERT INTO "public"."sys_logininfor" VALUES (2049709505708625922, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 12:36:42.582');
INSERT INTO "public"."sys_logininfor" VALUES (2049709534674489345, '000000', 'child_xiaoming', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 12:36:49.495');
INSERT INTO "public"."sys_logininfor" VALUES (2049709585211658242, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 12:37:01.534');
INSERT INTO "public"."sys_logininfor" VALUES (2049709817114726402, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 12:37:56.832');
INSERT INTO "public"."sys_logininfor" VALUES (2049710571447717890, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 12:40:56.672');
INSERT INTO "public"."sys_logininfor" VALUES (2049710599725715458, '000000', 'child_xiaoming', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 12:41:03.442');
INSERT INTO "public"."sys_logininfor" VALUES (2049710647175876609, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 12:41:14.74');
INSERT INTO "public"."sys_logininfor" VALUES (2049753352161464321, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 15:30:56.382');
INSERT INTO "public"."sys_logininfor" VALUES (2049753377130156034, '000000', 'child_xiaoming', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 15:31:02.342');
INSERT INTO "public"."sys_logininfor" VALUES (2049753447846121473, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 15:31:19.209');
INSERT INTO "public"."sys_logininfor" VALUES (2049753571666169857, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 15:31:48.73');
INSERT INTO "public"."sys_logininfor" VALUES (2049753597381447681, '000000', 'child_xiaoming', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 15:31:54.861');
INSERT INTO "public"."sys_logininfor" VALUES (2049753679585611777, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 15:32:14.462');
INSERT INTO "public"."sys_logininfor" VALUES (2049754699258662914, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 15:36:17.574');
INSERT INTO "public"."sys_logininfor" VALUES (2049754737644933121, '000000', 'child_xiaoming', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 15:36:26.74');
INSERT INTO "public"."sys_logininfor" VALUES (2049754824961953793, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 15:36:47.545');
INSERT INTO "public"."sys_logininfor" VALUES (2049755275954491393, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 15:38:35.068');
INSERT INTO "public"."sys_logininfor" VALUES (2049755306249949185, '000000', 'child_xiaoming', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 15:38:42.285');
INSERT INTO "public"."sys_logininfor" VALUES (2049755392442896386, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-04-30 15:39:02.843');
INSERT INTO "public"."sys_logininfor" VALUES (2050415377653026817, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 11:21:35.56');
INSERT INTO "public"."sys_logininfor" VALUES (2050415423463215106, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 11:21:46.485');
INSERT INTO "public"."sys_logininfor" VALUES (2050415477951418370, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 11:21:59.49');
INSERT INTO "public"."sys_logininfor" VALUES (2050415535329497090, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 11:22:13.168');
INSERT INTO "public"."sys_logininfor" VALUES (2050415600332820482, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 11:22:28.662');
INSERT INTO "public"."sys_logininfor" VALUES (2050415666179198978, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 11:22:44.366');
INSERT INTO "public"."sys_logininfor" VALUES (2050415723846684673, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 11:22:58.114');
INSERT INTO "public"."sys_logininfor" VALUES (2050415753798209538, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 11:23:05.246');
INSERT INTO "public"."sys_logininfor" VALUES (2050415802473107458, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 11:23:16.855');
INSERT INTO "public"."sys_logininfor" VALUES (2050415888431173633, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 11:23:37.348');
INSERT INTO "public"."sys_logininfor" VALUES (2050416734388736001, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 11:26:59.039');
INSERT INTO "public"."sys_logininfor" VALUES (2050425489658597377, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 12:01:46.46');
INSERT INTO "public"."sys_logininfor" VALUES (2050473061563617282, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 15:10:48.484');
INSERT INTO "public"."sys_logininfor" VALUES (2050473099773726722, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 15:10:57.604');
INSERT INTO "public"."sys_logininfor" VALUES (2050473195873619969, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 15:11:20.514');
INSERT INTO "public"."sys_logininfor" VALUES (2050473220938780673, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 15:11:26.486');
INSERT INTO "public"."sys_logininfor" VALUES (2050473456117600257, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 15:12:22.566');
INSERT INTO "public"."sys_logininfor" VALUES (2050473502917644290, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 15:12:33.719');
INSERT INTO "public"."sys_logininfor" VALUES (2050473662255058945, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 15:13:11.709');
INSERT INTO "public"."sys_logininfor" VALUES (2050473739199565825, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 15:13:30.043');
INSERT INTO "public"."sys_logininfor" VALUES (2050473765099393025, '000000', 'parent_zhang', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 15:13:36.222');
INSERT INTO "public"."sys_logininfor" VALUES (2050474181069492225, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 15:15:15.404');
INSERT INTO "public"."sys_logininfor" VALUES (2050474224279212034, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 15:15:25.699');
INSERT INTO "public"."sys_logininfor" VALUES (2050474265303699457, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 15:15:35.477');
INSERT INTO "public"."sys_logininfor" VALUES (2050475056420737025, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 15:18:44.097');
INSERT INTO "public"."sys_logininfor" VALUES (2050475084795203586, '000000', 'parent_zhang', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 15:18:50.873');
INSERT INTO "public"."sys_logininfor" VALUES (2050475466099380226, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 15:20:21.776');
INSERT INTO "public"."sys_logininfor" VALUES (2050475508096946177, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 15:20:31.789');
INSERT INTO "public"."sys_logininfor" VALUES (2050475573230292993, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 15:20:47.322');
INSERT INTO "public"."sys_logininfor" VALUES (2050475641505173505, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 15:21:03.592');
INSERT INTO "public"."sys_logininfor" VALUES (2050477242714279938, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 15:27:25.356');
INSERT INTO "public"."sys_logininfor" VALUES (2050477275564068866, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 15:27:33.184');
INSERT INTO "public"."sys_logininfor" VALUES (2050477415121145858, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 15:28:06.453');
INSERT INTO "public"."sys_logininfor" VALUES (2050477439297114114, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 15:28:12.215');
INSERT INTO "public"."sys_logininfor" VALUES (2050477595312640001, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 15:28:49.418');
INSERT INTO "public"."sys_logininfor" VALUES (2050477703060115457, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 15:29:15.102');
INSERT INTO "public"."sys_logininfor" VALUES (2050477730058850305, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 15:29:21.545');
INSERT INTO "public"."sys_logininfor" VALUES (2050477810841145346, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 15:29:40.808');
INSERT INTO "public"."sys_logininfor" VALUES (2050477866424061953, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 15:29:54.057');
INSERT INTO "public"."sys_logininfor" VALUES (2050480454582259713, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-05-02 15:40:11.126');
INSERT INTO "public"."sys_logininfor" VALUES (2050480498165272578, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-05-02 15:40:21.51');
INSERT INTO "public"."sys_logininfor" VALUES (2050480617094762498, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-05-02 15:40:49.869');
INSERT INTO "public"."sys_logininfor" VALUES (2050480658203136002, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-05-02 15:40:59.66');
INSERT INTO "public"."sys_logininfor" VALUES (2050480919374057473, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-05-02 15:42:01.937');
INSERT INTO "public"."sys_logininfor" VALUES (2050481212417495042, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-05-02 15:43:11.803');
INSERT INTO "public"."sys_logininfor" VALUES (2050481270533771265, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-05-02 15:43:25.652');
INSERT INTO "public"."sys_logininfor" VALUES (2050481340398292993, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-05-02 15:43:42.323');
INSERT INTO "public"."sys_logininfor" VALUES (2050481483935764482, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-05-02 15:44:16.543');
INSERT INTO "public"."sys_logininfor" VALUES (2050481534472933378, '000000', 'parent_zhang', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-05-02 15:44:28.59');
INSERT INTO "public"."sys_logininfor" VALUES (2050481975311060994, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-05-02 15:46:13.691');
INSERT INTO "public"."sys_logininfor" VALUES (2050482026359934977, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-05-02 15:46:25.866');
INSERT INTO "public"."sys_logininfor" VALUES (2050482068579799042, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-05-02 15:46:35.934');
INSERT INTO "public"."sys_logininfor" VALUES (2050483059777720322, '000000', 'parent_zhang', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-05-02 15:50:32.241');
INSERT INTO "public"."sys_logininfor" VALUES (2050483561202569217, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-05-02 15:52:31.791');
INSERT INTO "public"."sys_logininfor" VALUES (2050483587094007810, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-05-02 15:52:37.963');
INSERT INTO "public"."sys_logininfor" VALUES (2050483648196628481, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-05-02 15:52:52.534');
INSERT INTO "public"."sys_logininfor" VALUES (2050483682124353538, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-05-02 15:53:00.627');
INSERT INTO "public"."sys_logininfor" VALUES (2050485350836588545, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-05-02 15:59:38.475');
INSERT INTO "public"."sys_logininfor" VALUES (2050485398827814914, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-05-02 15:59:49.922');
INSERT INTO "public"."sys_logininfor" VALUES (2050485470588162049, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-05-02 16:00:07.034');
INSERT INTO "public"."sys_logininfor" VALUES (2050485511872696322, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-05-02 16:00:16.868');
INSERT INTO "public"."sys_logininfor" VALUES (2050485654185431042, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-05-02 16:00:50.808');
INSERT INTO "public"."sys_logininfor" VALUES (2050485790127017985, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-05-02 16:01:23.209');
INSERT INTO "public"."sys_logininfor" VALUES (2050485825803767809, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-05-02 16:01:31.723');
INSERT INTO "public"."sys_logininfor" VALUES (2050485924915171330, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-05-02 16:01:55.357');
INSERT INTO "public"."sys_logininfor" VALUES (2050485994838413314, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-05-02 16:02:12.028');
INSERT INTO "public"."sys_logininfor" VALUES (2050495261398126594, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 16:39:01.336');
INSERT INTO "public"."sys_logininfor" VALUES (2050495354708807681, '000000', 'child_xiaoming', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 16:39:23.585');
INSERT INTO "public"."sys_logininfor" VALUES (2050495477731938305, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 16:39:52.923');
INSERT INTO "public"."sys_logininfor" VALUES (2050496472079781889, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 16:43:49.994');
INSERT INTO "public"."sys_logininfor" VALUES (2050496521736146945, '000000', 'child_xiaoming', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 16:44:01.827');
INSERT INTO "public"."sys_logininfor" VALUES (2050496634130911233, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 16:44:28.626');
INSERT INTO "public"."sys_logininfor" VALUES (2050496684491919361, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 16:44:40.636');
INSERT INTO "public"."sys_logininfor" VALUES (2050497059584331777, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 16:46:10.066');
INSERT INTO "public"."sys_logininfor" VALUES (2050497093990207489, '000000', 'child_xiaoming', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 16:46:18.266');
INSERT INTO "public"."sys_logininfor" VALUES (2050497170490118146, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 16:46:36.5');
INSERT INTO "public"."sys_logininfor" VALUES (2050497694916530177, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 16:48:41.53');
INSERT INTO "public"."sys_logininfor" VALUES (2050497743130054658, '000000', 'child_xiaoming', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 16:48:53.03');
INSERT INTO "public"."sys_logininfor" VALUES (2050497818396839937, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 16:49:10.981');
INSERT INTO "public"."sys_logininfor" VALUES (2050497877775601666, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 16:49:25.135');
INSERT INTO "public"."sys_logininfor" VALUES (2050498023074680833, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 16:49:59.778');
INSERT INTO "public"."sys_logininfor" VALUES (2050498195926142977, '000000', 'child_xiaoming', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 16:50:40.987');
INSERT INTO "public"."sys_logininfor" VALUES (2050498498394181634, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 16:51:53.1');
INSERT INTO "public"."sys_logininfor" VALUES (2050498533425008641, '000000', 'child_xiaoming', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 16:52:01.453');
INSERT INTO "public"."sys_logininfor" VALUES (2050498610180771841, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 16:52:19.757');
INSERT INTO "public"."sys_logininfor" VALUES (2050499159806562305, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 16:54:30.796');
INSERT INTO "public"."sys_logininfor" VALUES (2050499277804916738, '000000', 'child_xiaoming', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 16:54:58.931');
INSERT INTO "public"."sys_logininfor" VALUES (2050499442720755714, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 16:55:38.25');
INSERT INTO "public"."sys_logininfor" VALUES (2050502205882093569, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 17:06:37.032');
INSERT INTO "public"."sys_logininfor" VALUES (2050502237905604609, '000000', 'child_xiaoming', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 17:06:44.665');
INSERT INTO "public"."sys_logininfor" VALUES (2050502312543244290, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 17:07:02.471');
INSERT INTO "public"."sys_logininfor" VALUES (2050502350065487874, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 17:07:11.406');
INSERT INTO "public"."sys_logininfor" VALUES (2050502906376998913, '000000', 'child_xiaoming', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 17:09:24.048');
INSERT INTO "public"."sys_logininfor" VALUES (2050503002170707970, '000000', 'child_xiaoming', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 17:09:46.886');
INSERT INTO "public"."sys_logininfor" VALUES (2050503279850409986, '000000', 'child_xiaoming', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 17:10:53.086');
INSERT INTO "public"."sys_logininfor" VALUES (2050503373815402497, '000000', 'child_xiaoming', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 17:11:15.493');
INSERT INTO "public"."sys_logininfor" VALUES (2050503763529158658, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 17:12:48.406');
INSERT INTO "public"."sys_logininfor" VALUES (2050503879287754753, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 17:13:16.01');
INSERT INTO "public"."sys_logininfor" VALUES (2050504244821348353, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 17:14:43.162');
INSERT INTO "public"."sys_logininfor" VALUES (2050504297749270529, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 17:14:55.781');
INSERT INTO "public"."sys_logininfor" VALUES (2050504343957917697, '000000', 'parent_zhang', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 17:15:06.789');
INSERT INTO "public"."sys_logininfor" VALUES (2050504492255924225, '000000', 'parent_zhang', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 17:15:42.156');
INSERT INTO "public"."sys_logininfor" VALUES (2050504856954851330, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 17:17:09.101');
INSERT INTO "public"."sys_logininfor" VALUES (2050504990702817281, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 17:17:40.991');
INSERT INTO "public"."sys_logininfor" VALUES (2050505309235040257, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 17:18:56.932');
INSERT INTO "public"."sys_logininfor" VALUES (2050506899908055042, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 17:25:16.171');
INSERT INTO "public"."sys_logininfor" VALUES (2050506979155234818, '000000', 'parent_zhang', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 17:25:35.078');
INSERT INTO "public"."sys_logininfor" VALUES (2050507574314389506, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 17:27:56.974');
INSERT INTO "public"."sys_logininfor" VALUES (2050507629821808642, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 17:28:10.209');
INSERT INTO "public"."sys_logininfor" VALUES (2050508341087686658, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 17:30:59.785');
INSERT INTO "public"."sys_logininfor" VALUES (2050509107152146434, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 17:34:02.419');
INSERT INTO "public"."sys_logininfor" VALUES (2050509536351080450, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 17:35:44.75');
INSERT INTO "public"."sys_logininfor" VALUES (2050509747567841281, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 17:36:35.115');
INSERT INTO "public"."sys_logininfor" VALUES (2050510035439702017, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 17:37:43.74');
INSERT INTO "public"."sys_logininfor" VALUES (2050510103001550850, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 17:37:59.848');
INSERT INTO "public"."sys_logininfor" VALUES (2050510107015499777, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 17:38:00.816');
INSERT INTO "public"."sys_logininfor" VALUES (2050510179769896962, '000000', 'child_xiaoming', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 17:38:18.164');
INSERT INTO "public"."sys_logininfor" VALUES (2050510259629445121, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 17:38:37.196');
INSERT INTO "public"."sys_logininfor" VALUES (2050510260929679361, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 17:38:37.51');
INSERT INTO "public"."sys_logininfor" VALUES (2050510337433784322, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 17:38:55.75');
INSERT INTO "public"."sys_logininfor" VALUES (2050510387522162689, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 17:39:07.694');
INSERT INTO "public"."sys_logininfor" VALUES (2050510416366391298, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 17:39:14.565');
INSERT INTO "public"."sys_logininfor" VALUES (2050510473954185217, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 17:39:28.299');
INSERT INTO "public"."sys_logininfor" VALUES (2050510557831876609, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 17:39:48.292');
INSERT INTO "public"."sys_logininfor" VALUES (2050510610763993089, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 17:40:00.919');
INSERT INTO "public"."sys_logininfor" VALUES (2050510645413138434, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 17:40:09.181');
INSERT INTO "public"."sys_logininfor" VALUES (2050510807925641217, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 17:40:47.927');
INSERT INTO "public"."sys_logininfor" VALUES (2050510974619865089, '000000', 'child_xiaoming', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 17:41:27.678');
INSERT INTO "public"."sys_logininfor" VALUES (2050510985659273217, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 17:41:30.291');
INSERT INTO "public"."sys_logininfor" VALUES (2050511097773019138, '000000', 'child_xiaoming', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 17:41:57.032');
INSERT INTO "public"."sys_logininfor" VALUES (2050511136079597569, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 17:42:06.159');
INSERT INTO "public"."sys_logininfor" VALUES (2050511156195479554, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 17:42:10.957');
INSERT INTO "public"."sys_logininfor" VALUES (2050511181252251650, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 17:42:16.931');
INSERT INTO "public"."sys_logininfor" VALUES (2050510685317746690, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 17:40:18.693');
INSERT INTO "public"."sys_logininfor" VALUES (2050510835108925442, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 17:40:54.413');
INSERT INTO "public"."sys_logininfor" VALUES (2050511201913393153, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 17:42:21.853');
INSERT INTO "public"."sys_logininfor" VALUES (2050511235983724546, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 17:42:29.983');
INSERT INTO "public"."sys_logininfor" VALUES (2050511272583221249, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 17:42:38.701');
INSERT INTO "public"."sys_logininfor" VALUES (2050511307622436866, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 17:42:47.052');
INSERT INTO "public"."sys_logininfor" VALUES (2050511337678819330, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 17:42:54.228');
INSERT INTO "public"."sys_logininfor" VALUES (2050511561411383297, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 17:43:47.576');
INSERT INTO "public"."sys_logininfor" VALUES (2050511719599558657, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 17:44:25.289');
INSERT INTO "public"."sys_logininfor" VALUES (2050511720706854913, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 17:44:25.541');
INSERT INTO "public"."sys_logininfor" VALUES (2050511727845560322, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 17:44:27.251');
INSERT INTO "public"."sys_logininfor" VALUES (2050511750712905729, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 17:44:32.7');
INSERT INTO "public"."sys_logininfor" VALUES (2050511809034702849, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 17:44:46.604');
INSERT INTO "public"."sys_logininfor" VALUES (2050511813954621441, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 17:44:47.771');
INSERT INTO "public"."sys_logininfor" VALUES (2050511819843424257, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 17:44:49.189');
INSERT INTO "public"."sys_logininfor" VALUES (2050511861652246530, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 17:44:59.151');
INSERT INTO "public"."sys_logininfor" VALUES (2050511867679461378, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 17:45:00.588');
INSERT INTO "public"."sys_logininfor" VALUES (2050511894778859521, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 17:45:07.055');
INSERT INTO "public"."sys_logininfor" VALUES (2050511907017838593, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 17:45:09.964');
INSERT INTO "public"."sys_logininfor" VALUES (2050512522091548673, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 17:47:36.607');
INSERT INTO "public"."sys_logininfor" VALUES (2050512645110484993, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 17:48:05.939');
INSERT INTO "public"."sys_logininfor" VALUES (2050513536043569153, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 17:51:38.359');
INSERT INTO "public"."sys_logininfor" VALUES (2050513703748620289, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 17:52:18.339');
INSERT INTO "public"."sys_logininfor" VALUES (2050514047429890049, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 17:53:40.287');
INSERT INTO "public"."sys_logininfor" VALUES (2050514081567330306, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 17:53:48.42');
INSERT INTO "public"."sys_logininfor" VALUES (2050514111703404545, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 17:53:55.601');
INSERT INTO "public"."sys_logininfor" VALUES (2050514173741355009, '000000', 'parent_zhang', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 17:54:10.395');
INSERT INTO "public"."sys_logininfor" VALUES (2050514350397050882, '000000', 'parent_zhang', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 17:54:52.513');
INSERT INTO "public"."sys_logininfor" VALUES (2050516179453333505, '000000', 'parent_zhang', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 18:02:08.598');
INSERT INTO "public"."sys_logininfor" VALUES (2050521877046218754, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-05-02 18:24:47.008');
INSERT INTO "public"."sys_logininfor" VALUES (2050522549317652482, '000000', 'child_xiaoming', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-05-02 18:27:27.295');
INSERT INTO "public"."sys_logininfor" VALUES (2050522618167152642, '000000', 'child_xiaoming', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-05-02 18:27:43.699');
INSERT INTO "public"."sys_logininfor" VALUES (2050523095772549121, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-05-02 18:29:37.573');
INSERT INTO "public"."sys_logininfor" VALUES (2050523170175307777, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-05-02 18:29:55.316');
INSERT INTO "public"."sys_logininfor" VALUES (2050523522559758338, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-05-02 18:31:19.326');
INSERT INTO "public"."sys_logininfor" VALUES (2050523594081030145, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-05-02 18:31:36.383');
INSERT INTO "public"."sys_logininfor" VALUES (2050523670090207233, '000000', 'parent_zhang', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-05-02 18:31:54.509');
INSERT INTO "public"."sys_logininfor" VALUES (2050523934616571906, '000000', 'parent_zhang', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-05-02 18:32:57.568');
INSERT INTO "public"."sys_logininfor" VALUES (2050525968363278338, '000000', 'parent_zhang', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-05-02 18:41:02.457');
INSERT INTO "public"."sys_logininfor" VALUES (2050531742367993858, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '密码输入错误1次', '2026-05-02 19:03:59.08');
INSERT INTO "public"."sys_logininfor" VALUES (2050531822026215426, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '密码输入错误2次', '2026-05-02 19:04:18.08');
INSERT INTO "public"."sys_logininfor" VALUES (2050532020005752833, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '密码输入错误3次', '2026-05-02 19:05:05.282');
INSERT INTO "public"."sys_logininfor" VALUES (2050533267148492801, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '密码输入错误4次', '2026-05-02 19:10:02.614');
INSERT INTO "public"."sys_logininfor" VALUES (2050541430912438274, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '密码输入错误1次', '2026-05-02 19:42:29.009');
INSERT INTO "public"."sys_logininfor" VALUES (2050541762040156161, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 19:43:47.96');
INSERT INTO "public"."sys_logininfor" VALUES (2050541780541231105, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 19:43:52.375');
INSERT INTO "public"."sys_logininfor" VALUES (2050541798828396546, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 19:43:56.737');
INSERT INTO "public"."sys_logininfor" VALUES (2050541815542697986, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 19:44:00.713');
INSERT INTO "public"."sys_logininfor" VALUES (2050541831648825346, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 19:44:04.559');
INSERT INTO "public"."sys_logininfor" VALUES (2050541848451207169, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 19:44:08.568');
INSERT INTO "public"."sys_logininfor" VALUES (2050541909377667074, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 19:44:23.093');
INSERT INTO "public"."sys_logininfor" VALUES (2050541928621133826, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 19:44:27.668');
INSERT INTO "public"."sys_logininfor" VALUES (2050541989803446273, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 19:44:42.257');
INSERT INTO "public"."sys_logininfor" VALUES (2050542455069200386, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 19:46:33.191');
INSERT INTO "public"."sys_logininfor" VALUES (2050542559427678209, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 19:46:58.069');
INSERT INTO "public"."sys_logininfor" VALUES (2050542589299511297, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 19:47:05.19');
INSERT INTO "public"."sys_logininfor" VALUES (2050542683247726593, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 19:47:27.592');
INSERT INTO "public"."sys_logininfor" VALUES (2050542617518788609, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 19:47:11.927');
INSERT INTO "public"."sys_logininfor" VALUES (2050542641371795457, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 19:47:17.606');
INSERT INTO "public"."sys_logininfor" VALUES (2050542663538692097, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 19:47:22.889');
INSERT INTO "public"."sys_logininfor" VALUES (2050542851091189762, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 19:48:07.606');
INSERT INTO "public"."sys_logininfor" VALUES (2050542852265594882, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 19:48:07.882');
INSERT INTO "public"."sys_logininfor" VALUES (2050542856925466626, '000000', 'admin', 'pc', 'pc', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 19:48:08.999');
INSERT INTO "public"."sys_logininfor" VALUES (2050542887933956097, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 19:48:16.39');
INSERT INTO "public"."sys_logininfor" VALUES (2050542935166013441, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 19:48:27.657');
INSERT INTO "public"."sys_logininfor" VALUES (2050542935363145729, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 19:48:27.707');
INSERT INTO "public"."sys_logininfor" VALUES (2050542957186109442, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 19:48:32.909');
INSERT INTO "public"."sys_logininfor" VALUES (2050542985535410178, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 19:48:39.667');
INSERT INTO "public"."sys_logininfor" VALUES (2050543026836721666, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 19:48:49.513');
INSERT INTO "public"."sys_logininfor" VALUES (2050543114699001858, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 19:49:10.452');
INSERT INTO "public"."sys_logininfor" VALUES (2050543560427687937, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 19:50:56.729');
INSERT INTO "public"."sys_logininfor" VALUES (2050543677075476482, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 19:51:24.535');
INSERT INTO "public"."sys_logininfor" VALUES (2050544167280562178, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 19:53:21.417');
INSERT INTO "public"."sys_logininfor" VALUES (2050544231931564033, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 19:53:36.828');
INSERT INTO "public"."sys_logininfor" VALUES (2050544282787500033, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 19:53:48.956');
INSERT INTO "public"."sys_logininfor" VALUES (2050544343994978305, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 19:54:03.542');
INSERT INTO "public"."sys_logininfor" VALUES (2050544610647855106, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 19:55:07.125');
INSERT INTO "public"."sys_logininfor" VALUES (2050544652121133058, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 19:55:17.014');
INSERT INTO "public"."sys_logininfor" VALUES (2050544729984192513, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 19:55:35.578');
INSERT INTO "public"."sys_logininfor" VALUES (2050544755166793729, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 19:55:41.582');
INSERT INTO "public"."sys_logininfor" VALUES (2050544779502145537, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 19:55:47.382');
INSERT INTO "public"."sys_logininfor" VALUES (2050544838587305986, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 19:56:01.459');
INSERT INTO "public"."sys_logininfor" VALUES (2050544858992594946, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 19:56:06.326');
INSERT INTO "public"."sys_logininfor" VALUES (2050544870078140417, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 19:56:08.976');
INSERT INTO "public"."sys_logininfor" VALUES (2050544967323078657, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 19:56:32.158');
INSERT INTO "public"."sys_logininfor" VALUES (2050545014718713858, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 19:56:43.451');
INSERT INTO "public"."sys_logininfor" VALUES (2050545039997784065, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 19:56:49.488');
INSERT INTO "public"."sys_logininfor" VALUES (2050545141655130113, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 19:57:13.718');
INSERT INTO "public"."sys_logininfor" VALUES (2050545231966883842, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 19:57:35.246');
INSERT INTO "public"."sys_logininfor" VALUES (2050545518190383105, '000000', 'admin', 'pc', 'pc', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 19:58:43.498');
INSERT INTO "public"."sys_logininfor" VALUES (2050546356145213442, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 20:02:03.273');
INSERT INTO "public"."sys_logininfor" VALUES (2050547045755899905, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '密码输入错误1次', '2026-05-02 20:04:47.693');
INSERT INTO "public"."sys_logininfor" VALUES (2050547326153510914, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '密码输入错误2次', '2026-05-02 20:05:54.542');
INSERT INTO "public"."sys_logininfor" VALUES (2050547400015204354, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-02 20:06:12.163');
INSERT INTO "public"."sys_logininfor" VALUES (2050777725152526337, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-03 11:21:25.938');
INSERT INTO "public"."sys_logininfor" VALUES (2050777742567276545, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-03 11:21:30.095');
INSERT INTO "public"."sys_logininfor" VALUES (2050777756844687361, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-03 11:21:33.507');
INSERT INTO "public"."sys_logininfor" VALUES (2050777770761388033, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-03 11:21:36.82');
INSERT INTO "public"."sys_logininfor" VALUES (2050777785441452033, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-03 11:21:40.322');
INSERT INTO "public"."sys_logininfor" VALUES (2050777799320403970, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-03 11:21:43.63');
INSERT INTO "public"."sys_logininfor" VALUES (2050777853632446466, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-03 11:21:56.586');
INSERT INTO "public"."sys_logininfor" VALUES (2050777871269494785, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-03 11:22:00.782');
INSERT INTO "public"."sys_logininfor" VALUES (2050777903263645697, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-03 11:22:08.407');
INSERT INTO "public"."sys_logininfor" VALUES (2050778057135882241, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-03 11:22:45.106');
INSERT INTO "public"."sys_logininfor" VALUES (2050778084193337346, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-03 11:22:51.552');
INSERT INTO "public"."sys_logininfor" VALUES (2050779577738854401, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-03 11:28:47.637');
INSERT INTO "public"."sys_logininfor" VALUES (2050779656952479745, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-03 11:29:06.528');
INSERT INTO "public"."sys_logininfor" VALUES (2050780815687680001, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-03 11:33:42.788');
INSERT INTO "public"."sys_logininfor" VALUES (2050781021808361473, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-03 11:34:31.927');
INSERT INTO "public"."sys_logininfor" VALUES (2050781896543043585, '000000', 'child_xiaoming', 'app', 'android', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-03 11:38:00.481');
INSERT INTO "public"."sys_logininfor" VALUES (2050781899470667777, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-03 11:38:01.177');
INSERT INTO "public"."sys_logininfor" VALUES (2050781899332255746, '000000', 'child_xiaoming', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-03 11:38:01.147');
INSERT INTO "public"."sys_logininfor" VALUES (2050781899390976002, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-03 11:38:01.169');
INSERT INTO "public"."sys_logininfor" VALUES (2050781907527925761, '000000', 'parent_zhang', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-03 11:38:03.097');
INSERT INTO "public"."sys_logininfor" VALUES (2050781975106551810, '000000', 'parent_zhang', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-03 11:38:19.215');
INSERT INTO "public"."sys_logininfor" VALUES (2050782023139721218, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-03 11:38:30.728');
INSERT INTO "public"."sys_logininfor" VALUES (2050782033281548290, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-03 11:38:33.08');
INSERT INTO "public"."sys_logininfor" VALUES (2050782177418805249, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-03 11:39:07.445');
INSERT INTO "public"."sys_logininfor" VALUES (2050782183861256193, '000000', 'parent_zhang', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-03 11:39:08.986');
INSERT INTO "public"."sys_logininfor" VALUES (2050782221836484610, '000000', 'parent_zhang', 'app', 'android', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-03 11:39:18.037');
INSERT INTO "public"."sys_logininfor" VALUES (2050782304275529730, '000000', 'parent_zhang', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-03 11:39:37.704');
INSERT INTO "public"."sys_logininfor" VALUES (2050782473419227138, '000000', 'parent_zhang', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-03 11:40:18.024');
INSERT INTO "public"."sys_logininfor" VALUES (2050782146938798081, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-03 11:39:00.189');
INSERT INTO "public"."sys_logininfor" VALUES (2050784534240165890, '000000', 'parent_zhang', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-05-03 11:48:29.358');
INSERT INTO "public"."sys_logininfor" VALUES (2050785043072155649, '000000', 'parent_zhang', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-05-03 11:50:30.702');
INSERT INTO "public"."sys_logininfor" VALUES (2050789777975803905, '000000', 'parent_zhang', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-05-03 12:09:19.566');
INSERT INTO "public"."sys_logininfor" VALUES (2050846943751438338, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-03 15:56:28.944');
INSERT INTO "public"."sys_logininfor" VALUES (2050847196097544194, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-03 15:57:29.104');
INSERT INTO "public"."sys_logininfor" VALUES (2050848111173042178, '000000', 'child_xiaoming', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-03 16:01:07.277');
INSERT INTO "public"."sys_logininfor" VALUES (2050849629695639554, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-05-03 16:07:09.322');
INSERT INTO "public"."sys_logininfor" VALUES (2050853726104584194, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '密码输入错误1次', '2026-05-03 16:23:25.992');
INSERT INTO "public"."sys_logininfor" VALUES (2050865672660975617, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '密码输入错误1次', '2026-05-03 17:10:54.269');
INSERT INTO "public"."sys_logininfor" VALUES (2050865783080222721, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '密码输入错误2次', '2026-05-03 17:11:20.603');
INSERT INTO "public"."sys_logininfor" VALUES (2050865848985321474, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '密码输入错误3次', '2026-05-03 17:11:36.312');
INSERT INTO "public"."sys_logininfor" VALUES (2050865922524053506, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '密码输入错误4次', '2026-05-03 17:11:53.834');
INSERT INTO "public"."sys_logininfor" VALUES (2050866025083174914, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '密码输入错误5次，帐户锁定10分钟', '2026-05-03 17:12:18.286');
INSERT INTO "public"."sys_logininfor" VALUES (2052669287730036738, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-08 16:37:49.598');
INSERT INTO "public"."sys_logininfor" VALUES (2052673496466636802, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-08 16:54:33.058');
INSERT INTO "public"."sys_logininfor" VALUES (2052675009754742786, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '密码输入错误1次', '2026-05-08 17:00:33.843');
INSERT INTO "public"."sys_logininfor" VALUES (2052675364630609922, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '密码输入错误2次', '2026-05-08 17:01:58.45');
INSERT INTO "public"."sys_logininfor" VALUES (2052675707238137858, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-08 17:03:20.138');
INSERT INTO "public"."sys_logininfor" VALUES (2052695771786035202, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-05-08 18:23:03.895');
INSERT INTO "public"."sys_logininfor" VALUES (2052739478694522882, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '密码输入错误1次', '2026-05-08 21:16:44.42');
INSERT INTO "public"."sys_logininfor" VALUES (2052739748719620097, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-08 21:17:48.821');
INSERT INTO "public"."sys_logininfor" VALUES (2052740137393188866, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-08 21:19:21.493');
INSERT INTO "public"."sys_logininfor" VALUES (2052740750822731778, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '密码输入错误1次', '2026-05-08 21:21:47.743');
INSERT INTO "public"."sys_logininfor" VALUES (2052741239480119298, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-08 21:23:44.248');
INSERT INTO "public"."sys_logininfor" VALUES (2052741643580338177, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-08 21:25:20.588');
INSERT INTO "public"."sys_logininfor" VALUES (2052741825415999489, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-08 21:26:03.945');
INSERT INTO "public"."sys_logininfor" VALUES (2052742744681607170, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-08 21:29:43.107');
INSERT INTO "public"."sys_logininfor" VALUES (2052742969085259778, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-08 21:30:36.609');
INSERT INTO "public"."sys_logininfor" VALUES (2052781258466926593, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-09 00:02:45.498');
INSERT INTO "public"."sys_logininfor" VALUES (2052781839029903362, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-09 00:05:03.936');
INSERT INTO "public"."sys_logininfor" VALUES (2052782094278467586, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Android', '0', '登录成功', '2026-05-09 00:06:04.787');
INSERT INTO "public"."sys_logininfor" VALUES (2052782807821852674, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-09 00:08:54.904');
INSERT INTO "public"."sys_logininfor" VALUES (2052782986910244865, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-09 00:09:37.6');
INSERT INTO "public"."sys_logininfor" VALUES (2052783139272531969, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-09 00:10:13.926');
INSERT INTO "public"."sys_logininfor" VALUES (2052783392625270786, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-09 00:11:14.342');
INSERT INTO "public"."sys_logininfor" VALUES (2052955076019884034, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-09 11:33:26.822');
INSERT INTO "public"."sys_logininfor" VALUES (2052955076019884033, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-09 11:33:26.823');
INSERT INTO "public"."sys_logininfor" VALUES (2052955205003120642, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-09 11:33:57.606');
INSERT INTO "public"."sys_logininfor" VALUES (2052955238578524162, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '密码输入错误1次', '2026-05-09 11:34:05.613');
INSERT INTO "public"."sys_logininfor" VALUES (2052955342140084225, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-09 11:34:30.292');
INSERT INTO "public"."sys_logininfor" VALUES (2052955342978945025, '000000', 'child_xiaoming', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-09 11:34:30.489');
INSERT INTO "public"."sys_logininfor" VALUES (2052955385077174274, '000000', 'child_xiaoming', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-09 11:34:40.531');
INSERT INTO "public"."sys_logininfor" VALUES (2052955801080827906, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-09 11:36:19.711');
INSERT INTO "public"."sys_logininfor" VALUES (2052955834140332034, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-09 11:36:27.592');
INSERT INTO "public"."sys_logininfor" VALUES (2052955887030505474, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-09 11:36:40.211');
INSERT INTO "public"."sys_logininfor" VALUES (2052955889974906882, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-09 11:36:40.907');
INSERT INTO "public"."sys_logininfor" VALUES (2052956029821390850, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-09 11:37:14.255');
INSERT INTO "public"."sys_logininfor" VALUES (2052956048335048705, '000000', 'ken2zhao', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-09 11:37:18.659');
INSERT INTO "public"."sys_logininfor" VALUES (2052956080039792642, '000000', 'parent_zhang', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-09 11:37:26.226');
INSERT INTO "public"."sys_logininfor" VALUES (2052956141079498754, '000000', 'parent_zhang', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-09 11:37:40.776');
INSERT INTO "public"."sys_logininfor" VALUES (2052957272820158465, '000000', 'parent_zhang', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-09 11:42:10.614');
INSERT INTO "public"."sys_logininfor" VALUES (2052962493071888385, '000000', 'parent_zhang', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-05-09 12:02:55.205');
INSERT INTO "public"."sys_logininfor" VALUES (2052966596464349185, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-09 12:19:13.533');
INSERT INTO "public"."sys_logininfor" VALUES (2052966742463877122, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-09 12:19:48.338');
INSERT INTO "public"."sys_logininfor" VALUES (2052967253929889794, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-09 12:21:50.282');
INSERT INTO "public"."sys_logininfor" VALUES (2052967404178247681, '000000', 'parent_zhang', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-09 12:22:26.117');
INSERT INTO "public"."sys_logininfor" VALUES (2052967451120898049, '000000', 'parent_zhang', 'app', 'android', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-09 12:22:37.306');
INSERT INTO "public"."sys_logininfor" VALUES (2052966801716809730, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-09 12:20:02.471');
INSERT INTO "public"."sys_logininfor" VALUES (2052967224997580801, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-09 12:21:43.388');
INSERT INTO "public"."sys_logininfor" VALUES (2052967363917123586, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-09 12:22:16.508');
INSERT INTO "public"."sys_logininfor" VALUES (2052967376973991938, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-09 12:22:19.625');
INSERT INTO "public"."sys_logininfor" VALUES (2052968125841805314, '000000', 'parent_zhang', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-09 12:25:18.162');
INSERT INTO "public"."sys_logininfor" VALUES (2052971600533262338, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-05-09 12:39:06.606');
INSERT INTO "public"."sys_logininfor" VALUES (2052971935557488641, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-05-09 12:40:26.47');
INSERT INTO "public"."sys_logininfor" VALUES (2052972421702488066, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-05-09 12:42:22.384');
INSERT INTO "public"."sys_logininfor" VALUES (2052972457370849282, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-05-09 12:42:30.883');
INSERT INTO "public"."sys_logininfor" VALUES (2052972641941196802, '000000', 'child_xiaoming', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-05-09 12:43:14.884');
INSERT INTO "public"."sys_logininfor" VALUES (2052972690087612418, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-05-09 12:43:26.374');
INSERT INTO "public"."sys_logininfor" VALUES (2052972709964419073, '000000', 'ken2zhao', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-05-09 12:43:31.102');
INSERT INTO "public"."sys_logininfor" VALUES (2052972746010267649, '000000', 'parent_zhang', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-05-09 12:43:39.695');
INSERT INTO "public"."sys_logininfor" VALUES (2052973648901312513, '000000', 'parent_zhang', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Safari', 'iPhone', '0', '登录成功', '2026-05-09 12:47:14.974');
INSERT INTO "public"."sys_logininfor" VALUES (2053655277413810177, '000000', 'admin', 'pc', 'pc', '180.165.11.155', '中国|上海|上海市|电信', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-11 09:55:47.86');
INSERT INTO "public"."sys_logininfor" VALUES (2053657564574400513, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-11 10:04:53.158');
INSERT INTO "public"."sys_logininfor" VALUES (2053669332615311362, '000000', 'admin', 'pc', 'pc', '180.165.11.155', '中国|上海|上海市|电信', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-11 10:51:38.879');
INSERT INTO "public"."sys_logininfor" VALUES (2053679018143211522, '000000', 'ken2zhao', 'pc', 'pc', '180.165.11.155', '中国|上海|上海市|电信', 'Chrome', 'Windows 10 or Windows Server 2016', '1', 'Password input error 1 times', '2026-05-11 11:30:08.09');
INSERT INTO "public"."sys_logininfor" VALUES (2053679044546355202, '000000', 'ken2zhao', 'pc', 'pc', '180.165.11.155', '中国|上海|上海市|电信', 'Chrome', 'Windows 10 or Windows Server 2016', '0', 'Login successful', '2026-05-11 11:30:14.387');
INSERT INTO "public"."sys_logininfor" VALUES (2053706170540580866, '000000', 'child_xiaoming', 'pc', 'pc', '180.165.11.155', '中国|上海|上海市|电信', 'Chrome', 'Windows 10 or Windows Server 2016', '1', 'Password input error 1 times', '2026-05-11 13:18:01.729');
INSERT INTO "public"."sys_logininfor" VALUES (2053706316267479041, '000000', 'child_xiaoming', 'pc', 'pc', '180.165.11.155', '中国|上海|上海市|电信', 'Chrome', 'Windows 10 or Windows Server 2016', '0', 'Login successful', '2026-05-11 13:18:36.472');
INSERT INTO "public"."sys_logininfor" VALUES (2053710138738040833, '000000', 'ken2zhao', 'pc', 'pc', '180.165.11.155', '中国|上海|上海市|电信', 'Chrome', 'Windows 10 or Windows Server 2016', '0', 'Login successful', '2026-05-11 13:33:47.821');
INSERT INTO "public"."sys_logininfor" VALUES (2053710289393246209, '000000', 'child_xiaoming', 'pc', 'pc', '180.165.11.155', '中国|上海|上海市|电信', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-11 13:34:23.74');
INSERT INTO "public"."sys_logininfor" VALUES (2053710320800194561, '000000', 'child_xiaoming', 'pc', 'pc', '180.165.11.155', '中国|上海|上海市|电信', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '退出成功', '2026-05-11 13:34:31.227');
INSERT INTO "public"."sys_logininfor" VALUES (2053710346498695169, '000000', 'ken2zhao', 'pc', 'pc', '180.165.11.155', '中国|上海|上海市|电信', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-11 13:34:37.355');
INSERT INTO "public"."sys_logininfor" VALUES (2053710548089528322, '000000', 'ken2zhao', 'pc', 'pc', '180.165.11.155', '中国|上海|上海市|电信', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '退出成功', '2026-05-11 13:35:25.418');
INSERT INTO "public"."sys_logininfor" VALUES (2053710572605235201, '000000', 'admin', 'pc', 'pc', '180.165.11.155', '中国|上海|上海市|电信', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-11 13:35:31.263');
INSERT INTO "public"."sys_logininfor" VALUES (2053712123377836033, '000000', 'child_xiaoming', 'app', 'android', '180.165.11.155', '中国|上海|上海市|电信', 'Chrome', 'Windows 10 or Windows Server 2016', '0', 'Login successful', '2026-05-11 13:41:40.996');
INSERT INTO "public"."sys_logininfor" VALUES (2053799959120666626, '000000', 'child_xiaoming', 'pc', 'pc', '180.165.11.155', '中国|上海|上海市|电信', 'Chrome', 'Windows 10 or Windows Server 2016', '0', 'Login successful', '2026-05-11 19:30:42.669');
INSERT INTO "public"."sys_logininfor" VALUES (2053801510060810241, '000000', 'ken2zhao', 'pc', 'pc', '180.165.11.155', '中国|上海|上海市|电信', 'Safari', 'iPhone', '0', 'Login successful', '2026-05-11 19:36:52.44');
INSERT INTO "public"."sys_logininfor" VALUES (2053834386466791426, '000000', 'ken2zhao', 'pc', 'pc', '180.165.11.155', '中国|上海|上海市|电信', 'Safari', 'iPhone', '0', 'Login successful', '2026-05-11 21:47:30.788');
INSERT INTO "public"."sys_logininfor" VALUES (2053851109446246402, '000000', 'ken2zhao', 'pc', 'pc', '180.165.11.155', '中国|上海|上海市|电信', 'Safari', 'iPhone', '0', 'Login successful', '2026-05-11 22:53:57.856');
INSERT INTO "public"."sys_logininfor" VALUES (2053851754194657282, '000000', 'ken2zhao', 'pc', 'pc', '172.20.0.1', '内网IP', 'Safari', 'iPhone', '0', 'Login successful', '2026-05-11 22:56:31.577');
INSERT INTO "public"."sys_logininfor" VALUES (2055658538474258434, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '密码输入错误1次', '2026-05-16 22:36:02.505');
INSERT INTO "public"."sys_logininfor" VALUES (2055658570095116290, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '密码输入错误2次', '2026-05-16 22:36:10.058');
INSERT INTO "public"."sys_logininfor" VALUES (2055658629700370434, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-16 22:36:24.272');
INSERT INTO "public"."sys_logininfor" VALUES (2055674885925093378, '000000', 'admin', 'pc', 'pc', '0:0:0:0:0:0:0:1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-16 23:41:00.057');
INSERT INTO "public"."sys_logininfor" VALUES (2056293847430791169, '000000', 'admin', 'pc', 'pc', '180.165.11.155', '中国|上海|上海市|电信', 'Chrome', 'Windows 10 or Windows Server 2016', '1', '密码输入错误1次', '2026-05-18 16:40:31.972');
INSERT INTO "public"."sys_logininfor" VALUES (2056293868263899138, '000000', 'admin', 'pc', 'pc', '180.165.11.155', '中国|上海|上海市|电信', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-18 16:40:36.943');
INSERT INTO "public"."sys_logininfor" VALUES (2059630415347478530, '000000', 'admin', 'pc', 'pc', '192.168.1.9', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2026-05-27 21:38:51.754');
INSERT INTO "public"."sys_logininfor" VALUES (2059630912636743682, '000000', 'ken2zhao', 'pc', 'pc', '192.168.1.9', '内网IP', 'Safari', 'iPhone', '1', 'Password input error 1 times', '2026-05-27 21:40:50.322');
INSERT INTO "public"."sys_logininfor" VALUES (2059630950305787905, '000000', 'ken2zhao', 'pc', 'pc', '192.168.1.9', '内网IP', 'Safari', 'iPhone', '0', 'Login successful', '2026-05-27 21:40:59.303');
INSERT INTO "public"."sys_logininfor" VALUES (2059631080371154945, '000000', 'ken2zhao', 'pc', 'pc', '192.168.1.9', '内网IP', 'Safari', 'iPhone', '0', 'Login successful', '2026-05-27 21:41:30.313');

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
INSERT INTO "public"."sys_menu" VALUES (118, '文件管理', 1, 10, 'oss', 'system/oss/index', '', '1', '0', 'C', '0', '0', 'system:oss:list', 'upload', 103, 1, '2026-03-14 20:30:27.402915', NULL, NULL, '文件管理菜单');
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
INSERT INTO "public"."sys_menu" VALUES (120, '任务调度中心', 2, 6, 'snailjob', 'monitor/snailjob/index', '', '1', '0', 'C', '1', '0', 'monitor:snailjob:list', 'job', 103, 1, '2026-03-14 20:30:27', 1, '2026-04-25 11:16:31.257', 'SnailJob控制台菜单');
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
INSERT INTO "public"."sys_menu" VALUES (4001, '模型配置', 4000, 1, 'model', 'ai/model/index', NULL, '0', '0', 'C', '0', '0', 'ai:model:list', 'server', NULL, 1, '2026-04-23 20:31:47.408711', NULL, NULL, '模型服务商与参数配置');
INSERT INTO "public"."sys_menu" VALUES (4011, '模型查询', 4001, 1, '', '', NULL, '0', '0', 'F', '0', '0', 'ai:model:query', '#', NULL, 1, '2026-04-23 20:31:47.483629', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (4012, '模型新增', 4001, 2, '', '', NULL, '0', '0', 'F', '0', '0', 'ai:model:add', '#', NULL, 1, '2026-04-23 20:31:47.483629', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (4013, '模型修改', 4001, 3, '', '', NULL, '0', '0', 'F', '0', '0', 'ai:model:edit', '#', NULL, 1, '2026-04-23 20:31:47.483629', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (4014, '模型删除', 4001, 4, '', '', NULL, '0', '0', 'F', '0', '0', 'ai:model:remove', '#', NULL, 1, '2026-04-23 20:31:47.483629', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (4002, '提示词管理', 4000, 2, 'prompt', 'ai/prompt/index', NULL, '0', '0', 'C', '0', '0', 'ai:prompt:list', 'edit', NULL, 1, '2026-04-23 20:31:47.559145', NULL, NULL, 'AI提示词模板(如任务拆解提示词)管理');
INSERT INTO "public"."sys_menu" VALUES (4021, '提示词查询', 4002, 1, '', '', NULL, '0', '0', 'F', '0', '0', 'ai:prompt:query', '#', NULL, 1, '2026-04-23 20:31:47.650521', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (4022, '提示词新增', 4002, 2, '', '', NULL, '0', '0', 'F', '0', '0', 'ai:prompt:add', '#', NULL, 1, '2026-04-23 20:31:47.650521', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (4023, '提示词修改', 4002, 3, '', '', NULL, '0', '0', 'F', '0', '0', 'ai:prompt:edit', '#', NULL, 1, '2026-04-23 20:31:47.650521', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (4024, '提示词删除', 4002, 4, '', '', NULL, '0', '0', 'F', '0', '0', 'ai:prompt:remove', '#', NULL, 1, '2026-04-23 20:31:47.650521', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (4003, 'AI日志', 4000, 3, 'log', 'ai/log/index', NULL, '0', '0', 'C', '0', '0', 'ai:log:list', 'log', NULL, 1, '2026-04-23 20:31:47.726416', NULL, NULL, 'AI接口调用明细与耗时监控');
INSERT INTO "public"."sys_menu" VALUES (4031, '日志查询', 4003, 1, '', '', NULL, '0', '0', 'F', '0', '0', 'ai:log:query', '#', NULL, 1, '2026-04-23 20:31:47.80068', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (4032, '日志导出', 4003, 2, '', '', NULL, '0', '0', 'F', '0', '0', 'ai:log:export', '#', NULL, 1, '2026-04-23 20:31:47.80068', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (4033, '日志删除', 4003, 3, '', '', NULL, '0', '0', 'F', '0', '0', 'ai:log:remove', '#', NULL, 1, '2026-04-23 20:31:47.80068', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (117, 'Admin监控', 2, 5, 'Admin', 'monitor/admin/index', '', '1', '0', 'C', '1', '0', 'monitor:admin:list', 'dashboard', 103, 1, '2026-03-14 20:30:27', 1, '2026-04-25 11:16:13.52', 'Admin监控菜单');
INSERT INTO "public"."sys_menu" VALUES (4040, '供应商查询', 4004, 1, '#', '', '', '1', '0', 'F', '0', '0', 'ai:provider:query', '#', 103, 1, '2026-04-25 22:20:05.386049', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (4041, '供应商新增', 4004, 2, '#', '', '', '1', '0', 'F', '0', '0', 'ai:provider:add', '#', 103, 1, '2026-04-25 22:20:05.461227', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (4042, '供应商修改', 4004, 3, '#', '', '', '1', '0', 'F', '0', '0', 'ai:provider:edit', '#', 103, 1, '2026-04-25 22:20:05.536149', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (4043, '供应商删除', 4004, 4, '#', '', '', '1', '0', 'F', '0', '0', 'ai:provider:remove', '#', 103, 1, '2026-04-25 22:20:05.611077', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (4050, '路由查询', 4005, 1, '#', '', '', '1', '0', 'F', '0', '0', 'ai:route:query', '#', 103, 1, '2026-04-25 22:20:05.686857', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (4051, '路由新增', 4005, 2, '#', '', '', '1', '0', 'F', '0', '0', 'ai:route:add', '#', 103, 1, '2026-04-25 22:20:05.761118', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (4052, '路由修改', 4005, 3, '#', '', '', '1', '0', 'F', '0', '0', 'ai:route:edit', '#', 103, 1, '2026-04-25 22:20:05.836214', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (4053, '路由删除', 4005, 4, '#', '', '', '1', '0', 'F', '0', '0', 'ai:route:remove', '#', 103, 1, '2026-04-25 22:20:05.911414', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (4061, '知识库新增', 4006, 2, '#', '', '', '1', '0', 'F', '0', '0', 'ai:knowledge:add', '#', 103, 1, '2026-05-16 22:55:30.413475', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (4000, 'AI管理', 0, 50, 'ai', NULL, NULL, '1', '0', 'M', '0', '0', NULL, 'international', NULL, 1, '2026-04-23 20:31:47', 1, '2026-05-08 16:41:46.483', 'AI核心管理模块');
INSERT INTO "public"."sys_menu" VALUES (4005, '路由管理', 4000, 3, 'route', 'ai/route/index', '', '1', '0', 'C', '0', '0', 'ai:route:list', 'guide', 103, 1, '2026-04-25 22:20:05', 1, '2026-05-08 16:48:22.02', 'AI路由策略');
INSERT INTO "public"."sys_menu" VALUES (4004, '供应商管理', 4000, 1, 'provider', 'ai/provider/index', '', '1', '0', 'C', '0', '0', 'ai:provider:list', 'international', 103, 1, '2026-04-25 22:20:05', 1, '2026-05-08 16:48:33.864', 'AI供应商配置');
INSERT INTO "public"."sys_menu" VALUES (4062, '知识库修改', 4006, 3, '#', '', '', '1', '0', 'F', '0', '0', 'ai:knowledge:edit', '#', 103, 1, '2026-05-16 22:55:30.52355', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (4006, '知识库管理', 4000, 1, 'knowledge', 'ai/knowledge/index', NULL, '1', '0', 'C', '0', '0', NULL, 'international', 200, 1, '2026-05-16 22:40:08', 1, '2026-05-16 22:50:08.484', '');
INSERT INTO "public"."sys_menu" VALUES (4061, '知识库新增', 4006, 2, '#', '', '', '1', '0', 'F', '0', '0', 'ai:knowledge:add', '#', 103, 1, '2026-05-16 22:54:33.796546', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (4060, '知识库查询', 4006, 1, '#', '', '', '1', '0', 'F', '0', '0', 'ai:knowledge:query', '#', 103, 1, '2026-05-16 22:55:21.82934', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (4060, '知识库查询', 4006, 1, '#', '', '', '1', '0', 'F', '0', '0', 'ai:knowledge:query', '#', 103, 1, '2026-05-16 22:55:26.167293', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (4063, '知识库删除', 4006, 4, '#', '', '', '1', '0', 'F', '0', '0', 'ai:knowledge:remove', '#', 103, 1, '2026-05-16 22:55:30.623262', NULL, NULL, '');
INSERT INTO "public"."sys_menu" VALUES (4064, '知识库同步', 4006, 5, '#', '', '', '1', '0', 'F', '0', '0', 'ai:knowledge:sync', '#', 103, 1, '2026-05-16 22:55:30.723119', NULL, NULL, '');

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
INSERT INTO "public"."sys_notice" VALUES (2047876743536103426, '000000', '小步发布啦', '2', '<p>小步发布啦</p>', '0', 200, 1, '2026-04-25 11:13:58.033', 1, '2026-04-25 11:13:58.033', '');
INSERT INTO "public"."sys_notice" VALUES (2047876647285215234, '000000', '温馨提醒：2026-04-22新版本发布啦', '1', '<p>二</p>', '0', 200, 1, '2026-04-25 11:13:35', 1, '2026-04-25 11:14:22.371', '');
INSERT INTO "public"."sys_notice" VALUES (1, '000000', '温馨提醒：2026-03-31新版本发布啦', '2', '<p>新版本内容</p>', '0', 103, 1, '2026-03-14 20:31:02', 1, '2026-04-25 11:14:43.997', '管理员');

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
INSERT INTO "public"."sys_oper_log" VALUES (2046983069260349441, '000000', '家长任务发布', 1, 'com.kenzhao.smallsteps.parent.controller.ParentTaskController.add()', 'POST', 1, 'ken2zhao', 'Small Steps 家庭', '/ssapi/parent/task', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"taskId":null,"parentId":null,"userId":1,"title":"去学校","description":"1. 准备阶段: 为去学校准备必要的材料\n2. 开始执行: 按照简单的步骤开始去学校\n3. 完成任务: 完成去学校并检查结果","icon":"task","difficulty":1,"promptLevel":null,"cycleType":null,"rewardPoints":10,"lightEffect":null,"audioEffect":null,"deadline":null,"status":"0"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-23 00:02:49.476', 61);
INSERT INTO "public"."sys_oper_log" VALUES (2048037612374990849, '000000', '家长任务发布', 1, 'com.kenzhao.smallsteps.parent.controller.ParentTaskController.add()', 'POST', 1, 'parent_zhang', 'Small Steps 家庭', '/ssapi/parent/task', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"taskId":null,"parentId":null,"userId":1,"title":"想去游泳了","description":"1. 穿上舒适的泳衣: \n2. 带上喜欢的玩具: \n3. 跟着大人走进更衣室: \n4. 把玩具轻轻放进柜子里: \n5. 在更衣室等爸爸妈妈: ","icon":"task","difficulty":1,"promptLevel":null,"cycleType":null,"rewardPoints":10,"lightEffect":null,"audioEffect":null,"deadline":null,"status":"0"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-25 21:53:12.148', 124);
INSERT INTO "public"."sys_oper_log" VALUES (2047658211586134017, '000000', '家长任务发布', 1, 'com.kenzhao.smallsteps.parent.controller.ParentTaskController.add()', 'POST', 1, 'ken2zhao', 'Small Steps 家庭', '/ssapi/parent/task', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"taskId":null,"parentId":null,"userId":1,"title":"今天好好读书，预习；复习","description":"1. 准备阶段: 为今天好好读书，预习；复习准备必要的材料\n2. 开始执行: 按照简单的步骤开始今天好好读书，预习；复习\n3. 完成任务: 完成今天好好读书，预习；复习并检查结果","icon":"task","difficulty":1,"promptLevel":null,"cycleType":null,"rewardPoints":10,"lightEffect":null,"audioEffect":null,"deadline":null,"status":"0"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-24 20:45:35.951', 106);
INSERT INTO "public"."sys_oper_log" VALUES (2047681563751198722, '000000', '家长任务发布', 1, 'com.kenzhao.smallsteps.parent.controller.ParentTaskController.add()', 'POST', 1, 'ken2zhao', 'Small Steps 家庭', '/ssapi/parent/task', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"taskId":null,"parentId":null,"userId":1,"title":"自己穿这衣服","description":"1. 准备阶段: 为自己穿这衣服准备必要的材料\n2. 开始执行: 按照简单的步骤开始自己穿这衣服\n3. 完成任务: 完成自己穿这衣服并检查结果","icon":"task","difficulty":1,"promptLevel":null,"cycleType":null,"rewardPoints":10,"lightEffect":null,"audioEffect":null,"deadline":null,"status":"0"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-24 22:18:23.546', 91);
INSERT INTO "public"."sys_oper_log" VALUES (2047876647738200066, '000000', '通知公告', 1, 'com.kenzhao.smallsteps.system.controller.system.SysNoticeController.add()', 'POST', 1, 'admin', 'Small Steps 家庭', '/ssapi/system/notice', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"noticeId":null,"noticeTitle":"温馨提醒：2018-07-01 新版本发布啦","noticeType":"1","noticeContent":"<p>二</p>","status":"0","remark":"","createByName":""}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-25 11:13:35.192', 111);
INSERT INTO "public"."sys_oper_log" VALUES (2047876743859064833, '000000', '通知公告', 1, 'com.kenzhao.smallsteps.system.controller.system.SysNoticeController.add()', 'POST', 1, 'admin', 'Small Steps 家庭', '/ssapi/system/notice', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"noticeId":null,"noticeTitle":"小步发布啦","noticeType":"2","noticeContent":"<p>小步发布啦</p>","status":"0","remark":"","createByName":""}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-25 11:13:58.103', 68);
INSERT INTO "public"."sys_oper_log" VALUES (2047876845940035586, '000000', '通知公告', 2, 'com.kenzhao.smallsteps.system.controller.system.SysNoticeController.edit()', 'PUT', 1, 'admin', 'Small Steps 家庭', '/ssapi/system/notice', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":1,"createTime":"2026-04-25 11:13:35","updateBy":null,"updateTime":null,"noticeId":"2047876647285215234","noticeTitle":"温馨提醒：2026-04-22新版本发布啦","noticeType":"1","noticeContent":"<p>二</p>","status":"0","remark":"","createByName":"admin"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-25 11:14:22.446', 76);
INSERT INTO "public"."sys_oper_log" VALUES (2047876872011829249, '000000', '通知公告', 3, 'com.kenzhao.smallsteps.system.controller.system.SysNoticeController.remove()', 'DELETE', 1, 'admin', 'Small Steps 家庭', '/ssapi/system/notice/2', '0:0:0:0:0:0:0:1', '内网IP', '[2]', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-25 11:14:28.669', 57);
INSERT INTO "public"."sys_oper_log" VALUES (2047876936692191234, '000000', '通知公告', 2, 'com.kenzhao.smallsteps.system.controller.system.SysNoticeController.edit()', 'PUT', 1, 'admin', 'Small Steps 家庭', '/ssapi/system/notice', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":1,"createTime":"2026-03-14 20:31:02","updateBy":null,"updateTime":null,"noticeId":1,"noticeTitle":"温馨提醒：2026-03-31新版本发布啦","noticeType":"2","noticeContent":"<p>新版本内容</p>","status":"0","remark":"管理员","createByName":"admin"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-25 11:14:44.089', 90);
INSERT INTO "public"."sys_oper_log" VALUES (2047877312086593537, '000000', '菜单管理', 2, 'com.kenzhao.smallsteps.system.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', 'Small Steps 家庭', '/ssapi/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":103,"createBy":null,"createTime":"2026-03-14 20:30:27","updateBy":null,"updateTime":null,"menuId":117,"parentId":2,"menuName":"Admin监控","orderNum":5,"path":"Admin","component":"monitor/admin/index","queryParam":"","isFrame":"1","isCache":"0","menuType":"C","visible":"1","status":"0","perms":"monitor:admin:list","icon":"dashboard","remark":"Admin监控菜单"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-25 11:16:13.579', 70);
INSERT INTO "public"."sys_oper_log" VALUES (2047877386543878146, '000000', '菜单管理', 2, 'com.kenzhao.smallsteps.system.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', 'Small Steps 家庭', '/ssapi/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":103,"createBy":null,"createTime":"2026-03-14 20:30:27","updateBy":null,"updateTime":null,"menuId":120,"parentId":2,"menuName":"任务调度中心","orderNum":6,"path":"snailjob","component":"monitor/snailjob/index","queryParam":"","isFrame":"1","isCache":"0","menuType":"C","visible":"1","status":"0","perms":"monitor:snailjob:list","icon":"job","remark":"SnailJob控制台菜单"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-25 11:16:31.342', 96);
INSERT INTO "public"."sys_oper_log" VALUES (2047899392580644866, '000000', '家长任务发布', 1, 'com.kenzhao.smallsteps.parent.controller.ParentTaskController.add()', 'POST', 1, 'ken2zhao', 'Small Steps 家庭', '/ssapi/parent/task', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"taskId":null,"parentId":null,"userId":1,"title":"收敛点做作业","description":"1. 把桌上的玩具收进盒里: \n2. 把铅笔和橡皮放好: \n3. 打开作业本，翻到第一页: \n4. 试着写下第一个字吧！: ","icon":"task","difficulty":1,"promptLevel":null,"cycleType":null,"rewardPoints":10,"lightEffect":null,"audioEffect":null,"deadline":null,"status":"0"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-25 12:43:57.983', 118);
INSERT INTO "public"."sys_oper_log" VALUES (2047903082276319233, '000000', '家长任务发布', 1, 'com.kenzhao.smallsteps.parent.controller.ParentTaskController.add()', 'POST', 1, 'ken2zhao', 'Small Steps 家庭', '/ssapi/parent/task', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"taskId":null,"parentId":null,"userId":1,"title":"Pretext","description":"1. 穿好袜子: 找到一双干净的袜子并穿上\n2. 穿好鞋子: 区分左右脚，系好鞋带\n3. 拿上书包: 确认作业都在书包里","icon":"task","difficulty":1,"promptLevel":null,"cycleType":null,"rewardPoints":10,"lightEffect":null,"audioEffect":null,"deadline":null,"status":"0"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-25 12:58:37.68', 103);
INSERT INTO "public"."sys_oper_log" VALUES (2047957168228966402, '000000', '家长奖励配置', 1, 'com.kenzhao.smallsteps.parent.controller.ParentRewardController.add()', 'POST', 1, 'ken2zhao', 'Small Steps 家庭', '/ssapi/parent/reward', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"rewardId":null,"userId":"2035392423676469250","name":"玩偶","pointsRequired":10,"stock":-1,"icon":"🧸","status":"0"}', '', 1, 'cannot find converter from ParentRewardBo to ParentReward', '2026-04-25 16:33:32.767', 10);
INSERT INTO "public"."sys_oper_log" VALUES (2048771032776556546, '000000', 'AI路由策略', 2, 'com.kenzhao.smallsteps.system.controller.system.AiRouteController.edit()', 'PUT', 1, 'admin', 'Small Steps 家庭', '/ssapi/system/ai/route', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"sceneKey":"BUDDY_CHAT","strategy":"PRIORITY_LEVEL","defaultModelId":"2048770343425916929","configJson":null}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-27 22:27:33.209', 75);
INSERT INTO "public"."sys_oper_log" VALUES (2048058151420317698, '000000', 'AI路由策略', 2, 'com.kenzhao.smallsteps.system.controller.system.AiRouteController.edit()', 'PUT', 1, 'admin', 'Small Steps 家庭', '/ssapi/system/ai/route', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":"2026-04-23 09:39:20","updateBy":null,"updateTime":null,"sceneKey":"emotion_analysis_scene","strategy":"PRIORITY_LEVEL","defaultModelId":2002,"configJson":"{\"fallback_model_id\": 2002}"}', '', 1, '
### Error updating database.  Cause: org.postgresql.util.PSQLException: ERROR: column "config_json" is of type json but expression is of type character varying
  建议：You will need to rewrite or cast the expression.
  位置：72
### The error may exist in com/kenzhao/smallsteps/common/ai/mapper/AiRouteMapper.java (best guess)
### The error may involve com.kenzhao.smallsteps.common.ai.mapper.AiRouteMapper.updateById-Inline
### The error occurred while setting parameters
### SQL: UPDATE sys_ai_route  SET strategy=?, default_model_id=?, config_json=?,   create_time=?, update_by=?, update_time=?  WHERE scene_key=?
### Cause: org.postgresql.util.PSQLException: ERROR: column "config_json" is of type json but expression is of type character varying
  建议：You will need to rewrite or cast the expression.
  位置：72
; bad SQL grammar []', '2026-04-25 23:14:49.041', 25);
INSERT INTO "public"."sys_oper_log" VALUES (2048060448703520769, '000000', 'AI路由策略', 2, 'com.kenzhao.smallsteps.system.controller.system.AiRouteController.edit()', 'PUT', 1, 'admin', 'Small Steps 家庭', '/ssapi/system/ai/route', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":"2026-04-23 09:39:20","updateBy":null,"updateTime":null,"sceneKey":"emotion_analysis_scene","strategy":"PRIORITY_LEVEL","defaultModelId":2002,"configJson":"{\"fallback_model_id\": 2002}"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-25 23:23:56.747', 113);
INSERT INTO "public"."sys_oper_log" VALUES (2048060481674944514, '000000', 'AI路由策略', 2, 'com.kenzhao.smallsteps.system.controller.system.AiRouteController.edit()', 'PUT', 1, 'admin', 'Small Steps 家庭', '/ssapi/system/ai/route', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":"2026-04-23 09:39:24","updateBy":null,"updateTime":null,"sceneKey":"default_scene","strategy":"PRIORITY_LEVEL","defaultModelId":2002,"configJson":"{\"fallback_model_id\": 2002}"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-25 23:24:04.619', 89);
INSERT INTO "public"."sys_oper_log" VALUES (2048060689095860225, '000000', 'AI供应商配置', 2, 'com.kenzhao.smallsteps.system.controller.system.AiProviderController.edit()', 'PUT', 1, 'admin', 'Small Steps 家庭', '/ssapi/system/ai/provider', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":1,"createTime":"2026-04-23 09:29:22","updateBy":1,"updateTime":"2026-04-25 23:24:53","id":1001,"name":"vllm本地服务","type":"openai","baseUrl":"http://192.168.1.9:8005/v1","apiKey":"ken2zhao589612","weight":10,"status":"0","delFlag":"0"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-25 23:24:54.067', 69);
INSERT INTO "public"."sys_oper_log" VALUES (2048271100441280514, '000000', 'AI供应商配置', 2, 'com.kenzhao.smallsteps.system.controller.system.AiProviderController.edit()', 'PUT', 1, 'admin', 'Small Steps 家庭', '/ssapi/system/ai/provider', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":1,"createTime":"2026-04-26 11:21:00","updateBy":1,"updateTime":"2026-04-26 13:20:59","id":1005,"name":"火山引擎 (Ark)","providerCode":"Doubao","type":"openai_compatible","baseUrl":"https://ark.cn-beijing.volces.com/api/v3","apiKey":"ark-dc0578f1-06d2-4c1e-856d-ec1f8090f058-8af46","weight":100,"status":"0","delFlag":"0"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-26 13:21:00.048', 108);
INSERT INTO "public"."sys_oper_log" VALUES (2048271553673576449, '000000', 'AI路由策略', 2, 'com.kenzhao.smallsteps.system.controller.system.AiRouteController.edit()', 'PUT', 1, 'admin', 'Small Steps 家庭', '/ssapi/system/ai/route', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"sceneKey":"TASK_BREAKDOWN","strategy":"PRIORITY_LEVEL","defaultModelId":2006,"configJson":null}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-26 13:22:48.101', 87);
INSERT INTO "public"."sys_oper_log" VALUES (2048271590541508610, '000000', 'AI路由策略', 2, 'com.kenzhao.smallsteps.system.controller.system.AiRouteController.edit()', 'PUT', 1, 'admin', 'Small Steps 家庭', '/ssapi/system/ai/route', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":"2026-04-23 09:39:24","updateBy":null,"updateTime":null,"sceneKey":"default_scene","strategy":"PRIORITY_LEVEL","defaultModelId":2006,"configJson":"{\"fallback_model_id\": 2002}"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-26 13:22:56.898', 63);
INSERT INTO "public"."sys_oper_log" VALUES (2048271639811997698, '000000', 'AI路由策略', 2, 'com.kenzhao.smallsteps.system.controller.system.AiRouteController.edit()', 'PUT', 1, 'admin', 'Small Steps 家庭', '/ssapi/system/ai/route', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":"2026-04-23 09:39:20","updateBy":null,"updateTime":null,"sceneKey":"emotion_analysis_scene","strategy":"PRIORITY_LEVEL","defaultModelId":2006,"configJson":"{\"fallback_model_id\": 2002}"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-26 13:23:08.634', 82);
INSERT INTO "public"."sys_oper_log" VALUES (2048284722605453314, '000000', '家长任务发布', 1, 'com.kenzhao.smallsteps.parent.controller.ParentTaskController.add()', 'POST', 1, 'parent_zhang', 'Small Steps 家庭', '/ssapi/parent/task', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"taskId":null,"parentId":null,"userId":1000,"title":"今天做数据作业","description":"1. 坐到书桌前的椅子上: \n2. 拿出数据作业放桌面: \n3. 轻声读出第一题题目: \n4. 写下第一题的答案: ","icon":"task","difficulty":1,"promptLevel":null,"cycleType":null,"rewardPoints":10,"lightEffect":null,"audioEffect":null,"deadline":null,"status":"0"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-26 14:15:07.822', 87);
INSERT INTO "public"."sys_oper_log" VALUES (2048296881976627201, '000000', '家长任务发布', 1, 'com.kenzhao.smallsteps.parent.controller.ParentTaskController.add()', 'POST', 1, 'ken2zhao', 'Small Steps 家庭', '/ssapi/parent/task', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"taskId":null,"parentId":null,"userId":"2035392423676469250","title":"吃早饭并洗碗","description":"1. 走到餐桌边坐下: \n2. 拿起餐具吃完早饭: \n3. 把脏碗端到水池边: \n4. 冲洗干净自己的饭碗: ","icon":"task","difficulty":1,"promptLevel":null,"cycleType":null,"rewardPoints":10,"lightEffect":null,"audioEffect":null,"deadline":null,"status":"0"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-26 15:03:26.84', 70);
INSERT INTO "public"."sys_oper_log" VALUES (2048296996825059329, '000000', '家长任务发布', 1, 'com.kenzhao.smallsteps.parent.controller.ParentTaskController.add()', 'POST', 1, 'ken2zhao', 'Small Steps 家庭', '/ssapi/parent/task', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"taskId":null,"parentId":null,"userId":1,"title":"测试自动任务","description":"1. 穿好袜子: 找到一双干净的袜子并穿上\n2. 穿好鞋子: 区分左右脚，系好鞋带\n3. 拿上书包: 确认作业都在书包里","icon":"task","difficulty":1,"promptLevel":null,"cycleType":null,"rewardPoints":10,"lightEffect":null,"audioEffect":null,"deadline":null,"status":"0"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-26 15:03:54.23', 61);
INSERT INTO "public"."sys_oper_log" VALUES (2048771053949403138, '000000', 'AI路由策略', 2, 'com.kenzhao.smallsteps.system.controller.system.AiRouteController.edit()', 'PUT', 1, 'admin', 'Small Steps 家庭', '/ssapi/system/ai/route', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"sceneKey":"VISION_ENCOURAGE","strategy":"PRIORITY_LEVEL","defaultModelId":"2048770343425916929","configJson":null}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-27 22:27:38.245', 50);
INSERT INTO "public"."sys_oper_log" VALUES (2048297203864293378, '000000', '家长任务发布', 1, 'com.kenzhao.smallsteps.parent.controller.ParentTaskController.add()', 'POST', 1, 'ken2zhao', 'Small Steps 家庭', '/ssapi/parent/task', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"taskId":null,"parentId":null,"userId":1,"title":"发布测试-手工","description":"1. 穿好袜子: 找到一双干净的袜子并穿上\n2. 穿好鞋子: 区分左右脚，系好鞋带\n3. 拿上书包: 确认作业都在书包里","icon":"task","difficulty":1,"promptLevel":null,"cycleType":null,"rewardPoints":10,"lightEffect":null,"audioEffect":null,"deadline":null,"status":"0"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-26 15:04:43.592', 55);
INSERT INTO "public"."sys_oper_log" VALUES (2048302271984427010, '000000', '家长任务发布', 1, 'com.kenzhao.smallsteps.parent.controller.ParentTaskController.add()', 'POST', 1, 'parent_zhang', 'Small Steps 家庭', '/ssapi/parent/task', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"taskId":null,"parentId":null,"userId":1000,"title":"测试任务0426","description":"1. 穿好袜子: 找到一双干净的袜子并穿上\n2. 穿好鞋子: 区分左右脚，系好鞋带\n3. 拿上书包: 确认作业都在书包里","icon":"task","difficulty":1,"promptLevel":null,"cycleType":null,"rewardPoints":10,"lightEffect":null,"audioEffect":null,"deadline":null,"status":"0"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-26 15:24:51.92', 60);
INSERT INTO "public"."sys_oper_log" VALUES (2048302771278569473, '000000', '家长任务发布', 1, 'com.kenzhao.smallsteps.parent.controller.ParentTaskController.add()', 'POST', 1, 'parent_zhang', 'Small Steps 家庭', '/ssapi/parent/task', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"taskId":null,"parentId":null,"userId":1000,"title":"测试任务0426-v2","description":"1. 穿好袜子: 找到一双干净的袜子并穿上\n2. 穿好鞋子: 区分左右脚，系好鞋带\n3. 拿上书包: 确认作业都在书包里","icon":"task","difficulty":1,"promptLevel":null,"cycleType":null,"rewardPoints":10,"lightEffect":null,"audioEffect":null,"deadline":null,"status":"0"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-26 15:26:50.961', 45);
INSERT INTO "public"."sys_oper_log" VALUES (2048302851461079041, '000000', '家长任务发布', 1, 'com.kenzhao.smallsteps.parent.controller.ParentTaskController.add()', 'POST', 1, 'parent_zhang', 'Small Steps 家庭', '/ssapi/parent/task', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"taskId":null,"parentId":null,"userId":1000,"title":"测试任务0426-v2","description":"1. 穿好袜子: 找到一双干净的袜子并穿上\n2. 穿好鞋子: 区分左右脚，系好鞋带\n3. 拿上书包: 确认作业都在书包里","icon":"task","difficulty":1,"promptLevel":null,"cycleType":null,"rewardPoints":10,"lightEffect":null,"audioEffect":null,"deadline":null,"status":"0"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-26 15:27:10.076', 62);
INSERT INTO "public"."sys_oper_log" VALUES (2048713094472933378, '000000', 'AI路由策略', 2, 'com.kenzhao.smallsteps.system.controller.system.AiRouteController.edit()', 'PUT', 1, 'admin', 'Small Steps 家庭', '/ssapi/system/ai/route', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"sceneKey":"HABIT_CHECKIN","strategy":"PRIORITY_LEVEL","defaultModelId":2002,"configJson":null}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-27 18:37:19.628', 95);
INSERT INTO "public"."sys_oper_log" VALUES (2048713343165800449, '000000', 'AI路由策略', 2, 'com.kenzhao.smallsteps.system.controller.system.AiRouteController.edit()', 'PUT', 1, 'admin', 'Small Steps 家庭', '/ssapi/system/ai/route', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"sceneKey":"BUDDY_CHAT","strategy":"PRIORITY_LEVEL","defaultModelId":2002,"configJson":null}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-27 18:38:18.925', 66);
INSERT INTO "public"."sys_oper_log" VALUES (2048713368260321282, '000000', 'AI路由策略', 2, 'com.kenzhao.smallsteps.system.controller.system.AiRouteController.edit()', 'PUT', 1, 'admin', 'Small Steps 家庭', '/ssapi/system/ai/route', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"sceneKey":"VISION_ENCOURAGE","strategy":"PRIORITY_LEVEL","defaultModelId":2002,"configJson":null}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-27 18:38:24.904', 81);
INSERT INTO "public"."sys_oper_log" VALUES (2048713401382739970, '000000', 'AI路由策略', 2, 'com.kenzhao.smallsteps.system.controller.system.AiRouteController.edit()', 'PUT', 1, 'admin', 'Small Steps 家庭', '/ssapi/system/ai/route', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":"2026-04-23 09:39:24","updateBy":null,"updateTime":null,"sceneKey":"default_scene","strategy":"PRIORITY_LEVEL","defaultModelId":2002,"configJson":"{\"fallback_model_id\": 2002}"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-27 18:38:32.806', 72);
INSERT INTO "public"."sys_oper_log" VALUES (2048713426158493698, '000000', 'AI路由策略', 2, 'com.kenzhao.smallsteps.system.controller.system.AiRouteController.edit()', 'PUT', 1, 'admin', 'Small Steps 家庭', '/ssapi/system/ai/route', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":"2026-04-23 09:39:20","updateBy":null,"updateTime":null,"sceneKey":"emotion_analysis_scene","strategy":"PRIORITY_LEVEL","defaultModelId":2002,"configJson":"{\"fallback_model_id\": 2002}"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-27 18:38:38.708', 73);
INSERT INTO "public"."sys_oper_log" VALUES (2048713448421859329, '000000', 'AI路由策略', 2, 'com.kenzhao.smallsteps.system.controller.system.AiRouteController.edit()', 'PUT', 1, 'admin', 'Small Steps 家庭', '/ssapi/system/ai/route', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"sceneKey":"TASK_BREAKDOWN","strategy":"PRIORITY_LEVEL","defaultModelId":2002,"configJson":null}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-27 18:38:44.018', 62);
INSERT INTO "public"."sys_oper_log" VALUES (2048713470353874946, '000000', 'AI路由策略', 2, 'com.kenzhao.smallsteps.system.controller.system.AiRouteController.edit()', 'PUT', 1, 'admin', 'Small Steps 家庭', '/ssapi/system/ai/route', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"sceneKey":"PARENT_REPORT","strategy":"PRIORITY_LEVEL","defaultModelId":2002,"configJson":null}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-27 18:38:49.255', 65);
INSERT INTO "public"."sys_oper_log" VALUES (2048770187624300546, '000000', 'AI供应商配置', 1, 'com.kenzhao.smallsteps.system.controller.system.AiProviderController.add()', 'POST', 1, 'admin', 'Small Steps 家庭', '/ssapi/system/ai/provider', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":200,"createBy":1,"createTime":"2026-04-27 22:24:11","updateBy":1,"updateTime":"2026-04-27 22:24:11","id":"2048770187162927105","name":"glm","providerCode":"glm","type":"openai","baseUrl":"https://open.bigmodel.cn/api/paas/v4","apiKey":"f2649c2b4bef47b099bf63a63ce135e4.kpn7Es4gyg3dawQk","weight":1,"status":"0","delFlag":null}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-27 22:24:11.695', 92);
INSERT INTO "public"."sys_oper_log" VALUES (2048771008755777538, '000000', 'AI路由策略', 2, 'com.kenzhao.smallsteps.system.controller.system.AiRouteController.edit()', 'PUT', 1, 'admin', 'Small Steps 家庭', '/ssapi/system/ai/route', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"sceneKey":"HABIT_CHECKIN","strategy":"PRIORITY_LEVEL","defaultModelId":"2048770343425916929","configJson":null}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-27 22:27:27.48', 75);
INSERT INTO "public"."sys_oper_log" VALUES (2048771076976132098, '000000', 'AI路由策略', 2, 'com.kenzhao.smallsteps.system.controller.system.AiRouteController.edit()', 'PUT', 1, 'admin', 'Small Steps 家庭', '/ssapi/system/ai/route', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":"2026-04-23 09:39:24","updateBy":null,"updateTime":null,"sceneKey":"default_scene","strategy":"PRIORITY_LEVEL","defaultModelId":"2048770343425916929","configJson":"{\"fallback_model_id\": 2002}"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-27 22:27:43.748', 75);
INSERT INTO "public"."sys_oper_log" VALUES (2048771096316067841, '000000', 'AI路由策略', 2, 'com.kenzhao.smallsteps.system.controller.system.AiRouteController.edit()', 'PUT', 1, 'admin', 'Small Steps 家庭', '/ssapi/system/ai/route', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"sceneKey":"TASK_BREAKDOWN","strategy":"PRIORITY_LEVEL","defaultModelId":"2048770343425916929","configJson":null}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-27 22:27:48.348', 70);
INSERT INTO "public"."sys_oper_log" VALUES (2048771121016324097, '000000', 'AI路由策略', 2, 'com.kenzhao.smallsteps.system.controller.system.AiRouteController.edit()', 'PUT', 1, 'admin', 'Small Steps 家庭', '/ssapi/system/ai/route', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"sceneKey":"PARENT_REPORT","strategy":"PRIORITY_LEVEL","defaultModelId":"2048770343425916929","configJson":null}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-27 22:27:54.242', 64);
INSERT INTO "public"."sys_oper_log" VALUES (2048771142369525761, '000000', 'AI路由策略', 2, 'com.kenzhao.smallsteps.system.controller.system.AiRouteController.edit()', 'PUT', 1, 'admin', 'Small Steps 家庭', '/ssapi/system/ai/route', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":"2026-04-23 09:39:20","updateBy":null,"updateTime":null,"sceneKey":"emotion_analysis_scene","strategy":"PRIORITY_LEVEL","defaultModelId":"2048770343425916929","configJson":"{\"fallback_model_id\": 2002}"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-27 22:27:59.329', 60);
INSERT INTO "public"."sys_oper_log" VALUES (2049336552626089986, '000000', '家长奖励配置', 1, 'com.kenzhao.smallsteps.parent.controller.ParentRewardController.add()', 'POST', 1, 'ken2zhao', 'Small Steps 家庭', '/ssapi/parent/reward', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"rewardId":"2049336552122773506","userId":"2035392423676469250","name":"看动画片30分钟","pointsRequired":10,"stock":-1,"icon":"🎬","status":"0"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-29 11:54:43.643', 113);
INSERT INTO "public"."sys_oper_log" VALUES (2049336566635065345, '000000', '家长奖励配置', 1, 'com.kenzhao.smallsteps.parent.controller.ParentRewardController.add()', 'POST', 1, 'ken2zhao', 'Small Steps 家庭', '/ssapi/parent/reward', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"rewardId":"2049336566228217857","userId":"2035392423676469250","name":"吃美味冰淇淋","pointsRequired":20,"stock":-1,"icon":"🍦","status":"0"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-29 11:54:46.974', 84);
INSERT INTO "public"."sys_oper_log" VALUES (2049336580631457794, '000000', '家长奖励配置', 1, 'com.kenzhao.smallsteps.parent.controller.ParentRewardController.add()', 'POST', 1, 'ken2zhao', 'Small Steps 家庭', '/ssapi/parent/reward', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"rewardId":"2049336580170084353","userId":"2035392423676469250","name":"购买心仪玩具","pointsRequired":100,"stock":-1,"icon":"🎁","status":"0"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-29 11:54:50.325', 107);
INSERT INTO "public"."sys_oper_log" VALUES (2049336698273296386, '000000', '家长奖励配置', 1, 'com.kenzhao.smallsteps.parent.controller.ParentRewardController.add()', 'POST', 1, 'ken2zhao', 'Small Steps 家庭', '/ssapi/parent/reward', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"rewardId":"2049336697920974850","userId":"2035392423676469250","name":"看动画片30分钟","pointsRequired":10,"stock":-1,"icon":"🎬","status":"0"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-29 11:55:18.368', 86);
INSERT INTO "public"."sys_oper_log" VALUES (2049336710843625473, '000000', '家长任务发布', 1, 'com.kenzhao.smallsteps.parent.controller.ParentTaskController.add()', 'POST', 1, 'ken2zhao', 'Small Steps 家庭', '/ssapi/parent/task', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"taskId":null,"parentId":null,"userId":"2035392423676469250","title":"[系统] 每日能量礼包","description":"1. 穿好袜子: 找到一双干净的袜子并穿上\n2. 穿好鞋子: 区分左右脚，系好鞋带\n3. 拿上书包: 确认作业都在书包里","icon":"task","difficulty":1,"promptLevel":null,"cycleType":null,"rewardPoints":10,"lightEffect":null,"audioEffect":null,"deadline":null,"status":"0"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-29 11:55:21.369', 99);
INSERT INTO "public"."sys_oper_log" VALUES (2049336871577743362, '000000', '家长奖励配置', 1, 'com.kenzhao.smallsteps.parent.controller.ParentRewardController.add()', 'POST', 1, 'ken2zhao', 'Small Steps 家庭', '/ssapi/parent/reward', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"rewardId":"2049336871326085122","userId":"2035392423676469250","name":"看动画片30分钟","pointsRequired":10,"stock":-1,"icon":"🎬","status":"0"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-29 11:55:59.683', 63);
INSERT INTO "public"."sys_oper_log" VALUES (2049336884219375618, '000000', '家长任务发布', 1, 'com.kenzhao.smallsteps.parent.controller.ParentTaskController.add()', 'POST', 1, 'ken2zhao', 'Small Steps 家庭', '/ssapi/parent/task', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"taskId":null,"parentId":null,"userId":"2035392423676469250","title":"[系统] 每日能量礼包","description":"1. 穿好袜子: 找到一双干净的袜子并穿上\n2. 穿好鞋子: 区分左右脚，系好鞋带\n3. 拿上书包: 确认作业都在书包里","icon":"task","difficulty":1,"promptLevel":null,"cycleType":null,"rewardPoints":10,"lightEffect":null,"audioEffect":null,"deadline":null,"status":"0"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-29 11:56:02.701', 97);
INSERT INTO "public"."sys_oper_log" VALUES (2049338958793437186, '000000', '家长奖励配置', 1, 'com.kenzhao.smallsteps.parent.controller.ParentRewardController.add()', 'POST', 1, 'ken2zhao', 'Small Steps 家庭', '/ssapi/parent/reward', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"rewardId":"2049338958541778945","userId":"2035392423676469250","name":"看动画片30分钟","pointsRequired":10,"stock":-1,"icon":"🎬","status":"0"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-29 12:04:17.321', 64);
INSERT INTO "public"."sys_oper_log" VALUES (2049338971690921986, '000000', '家长任务发布', 1, 'com.kenzhao.smallsteps.parent.controller.ParentTaskController.add()', 'POST', 1, 'ken2zhao', 'Small Steps 家庭', '/ssapi/parent/task', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"taskId":null,"parentId":null,"userId":"2035392423676469250","title":"[系统] 每日能量礼包","description":"1. 穿好袜子: 找到一双干净的袜子并穿上\n2. 穿好鞋子: 区分左右脚，系好鞋带\n3. 拿上书包: 确认作业都在书包里","icon":"task","difficulty":1,"promptLevel":null,"cycleType":null,"rewardPoints":10,"lightEffect":null,"audioEffect":null,"deadline":null,"status":"0"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-29 12:04:20.397', 141);
INSERT INTO "public"."sys_oper_log" VALUES (2049340503471714306, '000000', '家长奖励配置', 1, 'com.kenzhao.smallsteps.parent.controller.ParentRewardController.add()', 'POST', 1, 'ken2zhao', 'Small Steps 家庭', '/ssapi/parent/reward', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"rewardId":"2049340502980980738","userId":"2035392423676469250","name":"看动画片30分钟","pointsRequired":10,"stock":-1,"icon":"🎬","status":"0"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-29 12:10:25.59', 105);
INSERT INTO "public"."sys_oper_log" VALUES (2049340515870076930, '000000', '家长任务发布', 1, 'com.kenzhao.smallsteps.parent.controller.ParentTaskController.add()', 'POST', 1, 'ken2zhao', 'Small Steps 家庭', '/ssapi/parent/task', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"taskId":null,"parentId":null,"userId":"2035392423676469250","title":"[系统] 每日能量礼包","description":"1. 穿好袜子: 找到一双干净的袜子并穿上\n2. 穿好鞋子: 区分左右脚，系好鞋带\n3. 拿上书包: 确认作业都在书包里","icon":"task","difficulty":1,"promptLevel":null,"cycleType":null,"rewardPoints":10,"lightEffect":null,"audioEffect":null,"deadline":null,"status":"0"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-29 12:10:28.558', 89);
INSERT INTO "public"."sys_oper_log" VALUES (2049341039147249665, '000000', '家长奖励配置', 1, 'com.kenzhao.smallsteps.parent.controller.ParentRewardController.add()', 'POST', 1, 'ken2zhao', 'Small Steps 家庭', '/ssapi/parent/reward', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"rewardId":"2049341038828482561","userId":"2035392423676469250","name":"看动画片30分钟","pointsRequired":10,"stock":-1,"icon":"🎬","status":"0"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-29 12:12:33.318', 86);
INSERT INTO "public"."sys_oper_log" VALUES (2049341051679830018, '000000', '家长任务发布', 1, 'com.kenzhao.smallsteps.parent.controller.ParentTaskController.add()', 'POST', 1, 'ken2zhao', 'Small Steps 家庭', '/ssapi/parent/task', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"taskId":null,"parentId":null,"userId":"2035392423676469250","title":"[系统] 每日能量礼包","description":"1. 穿好袜子: 找到一双干净的袜子并穿上\n2. 穿好鞋子: 区分左右脚，系好鞋带\n3. 拿上书包: 确认作业都在书包里","icon":"task","difficulty":1,"promptLevel":null,"cycleType":null,"rewardPoints":10,"lightEffect":null,"audioEffect":null,"deadline":null,"status":"0"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-29 12:12:36.301', 98);
INSERT INTO "public"."sys_oper_log" VALUES (2049341618976223234, '000000', '家长奖励配置', 1, 'com.kenzhao.smallsteps.parent.controller.ParentRewardController.add()', 'POST', 1, 'ken2zhao', 'Small Steps 家庭', '/ssapi/parent/reward', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"rewardId":"2049341618443546625","userId":"2035392423676469250","name":"看动画片30分钟","pointsRequired":10,"stock":-1,"icon":"🎬","status":"0"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-29 12:14:51.561', 140);
INSERT INTO "public"."sys_oper_log" VALUES (2049341631764656129, '000000', '家长任务发布', 1, 'com.kenzhao.smallsteps.parent.controller.ParentTaskController.add()', 'POST', 1, 'ken2zhao', 'Small Steps 家庭', '/ssapi/parent/task', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"taskId":null,"parentId":null,"userId":"2035392423676469250","title":"[系统] 每日能量礼包","description":"1. 穿好袜子: 找到一双干净的袜子并穿上\n2. 穿好鞋子: 区分左右脚，系好鞋带\n3. 拿上书包: 确认作业都在书包里","icon":"task","difficulty":1,"promptLevel":null,"cycleType":null,"rewardPoints":10,"lightEffect":null,"audioEffect":null,"deadline":null,"status":"0"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-29 12:14:54.597', 88);
INSERT INTO "public"."sys_oper_log" VALUES (2049344049629917186, '000000', '家长奖励配置', 1, 'com.kenzhao.smallsteps.parent.controller.ParentRewardController.add()', 'POST', 1, 'ken2zhao', 'Small Steps 家庭', '/ssapi/parent/reward', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"rewardId":"2049344049248235521","userId":"2035392423676469250","name":"看动画片30分钟","pointsRequired":10,"stock":-1,"icon":"🎬","status":"0"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-29 12:24:31.062', 90);
INSERT INTO "public"."sys_oper_log" VALUES (2049344061906644993, '000000', '家长任务发布', 1, 'com.kenzhao.smallsteps.parent.controller.ParentTaskController.add()', 'POST', 1, 'ken2zhao', 'Small Steps 家庭', '/ssapi/parent/task', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"taskId":null,"parentId":null,"userId":"2035392423676469250","title":"[系统] 每日能量礼包","description":"1. 穿好袜子: 找到一双干净的袜子并穿上\n2. 穿好鞋子: 区分左右脚，系好鞋带\n3. 拿上书包: 确认作业都在书包里","icon":"task","difficulty":1,"promptLevel":null,"cycleType":null,"rewardPoints":10,"lightEffect":null,"audioEffect":null,"deadline":null,"status":"0"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-29 12:24:33.998', 103);
INSERT INTO "public"."sys_oper_log" VALUES (2049345463357829121, '000000', '家长奖励配置', 1, 'com.kenzhao.smallsteps.parent.controller.ParentRewardController.add()', 'POST', 1, 'ken2zhao', 'Small Steps 家庭', '/ssapi/parent/reward', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"rewardId":"2049345462971953154","userId":"2035392423676469250","name":"看动画片30分钟","pointsRequired":10,"stock":-1,"icon":"🎬","status":"0"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-29 12:30:08.12', 84);
INSERT INTO "public"."sys_oper_log" VALUES (2049345475882020865, '000000', '家长任务发布', 1, 'com.kenzhao.smallsteps.parent.controller.ParentTaskController.add()', 'POST', 1, 'ken2zhao', 'Small Steps 家庭', '/ssapi/parent/task', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"taskId":null,"parentId":null,"userId":"2035392423676469250","title":"[系统] 每日能量礼包","description":"1. 穿好袜子: 找到一双干净的袜子并穿上\n2. 穿好鞋子: 区分左右脚，系好鞋带\n3. 拿上书包: 确认作业都在书包里","icon":"task","difficulty":1,"promptLevel":null,"cycleType":null,"rewardPoints":10,"lightEffect":null,"audioEffect":null,"deadline":null,"status":"0"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-29 12:30:11.113', 100);
INSERT INTO "public"."sys_oper_log" VALUES (2049478639841472514, '000000', '家长奖励配置', 1, 'com.kenzhao.smallsteps.parent.controller.ParentRewardController.add()', 'POST', 1, 'ken2zhao', 'Small Steps 家庭', '/ssapi/parent/reward', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"rewardId":"2049478639585619970","userId":"2035392423676469250","name":"看动画片30分钟","pointsRequired":10,"stock":-1,"icon":"🎬","status":"0"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-29 21:19:19.876', 63);
INSERT INTO "public"."sys_oper_log" VALUES (2049478648121028610, '000000', '家长任务发布', 1, 'com.kenzhao.smallsteps.parent.controller.ParentTaskController.add()', 'POST', 1, 'ken2zhao', 'Small Steps 家庭', '/ssapi/parent/task', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"taskId":null,"parentId":null,"userId":"2035392423676469250","title":"[系统] 每日能量礼包","description":"1. 穿好袜子: 找到一双干净的袜子并穿上\n2. 穿好鞋子: 区分左右脚，系好鞋带\n3. 拿上书包: 确认作业都在书包里","icon":"task","difficulty":1,"promptLevel":null,"cycleType":null,"rewardPoints":10,"lightEffect":null,"audioEffect":null,"deadline":null,"status":"0"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-29 21:19:21.848', 79);
INSERT INTO "public"."sys_oper_log" VALUES (2049479514932670466, '000000', '家长奖励配置', 1, 'com.kenzhao.smallsteps.parent.controller.ParentRewardController.add()', 'POST', 1, 'ken2zhao', 'Small Steps 家庭', '/ssapi/parent/reward', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"rewardId":"2049479514584543234","userId":"2035392423676469250","name":"看动画片30分钟","pointsRequired":10,"stock":-1,"icon":"🎬","status":"0"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-29 21:22:48.511', 79);
INSERT INTO "public"."sys_oper_log" VALUES (2049479522528555010, '000000', '家长任务发布', 1, 'com.kenzhao.smallsteps.parent.controller.ParentTaskController.add()', 'POST', 1, 'ken2zhao', 'Small Steps 家庭', '/ssapi/parent/task', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"taskId":null,"parentId":null,"userId":"2035392423676469250","title":"[系统] 每日能量礼包","description":"1. 穿好袜子: 找到一双干净的袜子并穿上\n2. 穿好鞋子: 区分左右脚，系好鞋带\n3. 拿上书包: 确认作业都在书包里","icon":"task","difficulty":1,"promptLevel":null,"cycleType":null,"rewardPoints":10,"lightEffect":null,"audioEffect":null,"deadline":null,"status":"0"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-29 21:22:50.319', 75);
INSERT INTO "public"."sys_oper_log" VALUES (2049481358127951874, '000000', '家长奖励配置', 1, 'com.kenzhao.smallsteps.parent.controller.ParentRewardController.add()', 'POST', 1, 'ken2zhao', 'Small Steps 家庭', '/ssapi/parent/reward', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"rewardId":"2049481357616246785","userId":"2035392423676469250","name":"看动画片30分钟","pointsRequired":10,"stock":-1,"icon":"🎬","status":"0"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-29 21:30:07.958', 114);
INSERT INTO "public"."sys_oper_log" VALUES (2049481368471105537, '000000', '家长任务发布', 1, 'com.kenzhao.smallsteps.parent.controller.ParentTaskController.add()', 'POST', 1, 'ken2zhao', 'Small Steps 家庭', '/ssapi/parent/task', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"taskId":null,"parentId":null,"userId":"2035392423676469250","title":"[系统] 每日能量礼包","description":"1. 穿好袜子: 找到一双干净的袜子并穿上\n2. 穿好鞋子: 区分左右脚，系好鞋带\n3. 拿上书包: 确认作业都在书包里","icon":"task","difficulty":1,"promptLevel":null,"cycleType":null,"rewardPoints":10,"lightEffect":null,"audioEffect":null,"deadline":null,"status":"0"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-29 21:30:10.423', 128);
INSERT INTO "public"."sys_oper_log" VALUES (2049483319724240897, '000000', '家长奖励配置', 1, 'com.kenzhao.smallsteps.parent.controller.ParentRewardController.add()', 'POST', 1, 'ken2zhao', 'Small Steps 家庭', '/ssapi/parent/reward', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"rewardId":"2049483318868602881","userId":"2035392423676469250","name":"看动画片30分钟","pointsRequired":10,"stock":-1,"icon":"🎬","status":"0"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-29 21:37:55.696', 255);
INSERT INTO "public"."sys_oper_log" VALUES (2049483329723461634, '000000', '家长任务发布', 1, 'com.kenzhao.smallsteps.parent.controller.ParentTaskController.add()', 'POST', 1, 'ken2zhao', 'Small Steps 家庭', '/ssapi/parent/task', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"taskId":null,"parentId":null,"userId":"2035392423676469250","title":"[系统] 每日能量礼包","description":"1. 穿好袜子: 找到一双干净的袜子并穿上\n2. 穿好鞋子: 区分左右脚，系好鞋带\n3. 拿上书包: 确认作业都在书包里","icon":"task","difficulty":1,"promptLevel":null,"cycleType":null,"rewardPoints":10,"lightEffect":null,"audioEffect":null,"deadline":null,"status":"0"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-29 21:37:58.021', 100);
INSERT INTO "public"."sys_oper_log" VALUES (2049487835551002626, '000000', '家长奖励配置', 1, 'com.kenzhao.smallsteps.parent.controller.ParentRewardController.add()', 'POST', 1, 'ken2zhao', 'Small Steps 家庭', '/ssapi/parent/reward', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"rewardId":"2049487835110600705","userId":"2035392423676469250","name":"看动画片30分钟","pointsRequired":10,"stock":-1,"icon":"🎬","status":"0"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-29 21:55:52.296', 105);
INSERT INTO "public"."sys_oper_log" VALUES (2049487843687952385, '000000', '家长任务发布', 1, 'com.kenzhao.smallsteps.parent.controller.ParentTaskController.add()', 'POST', 1, 'ken2zhao', 'Small Steps 家庭', '/ssapi/parent/task', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"taskId":null,"parentId":null,"userId":"2035392423676469250","title":"[系统] 每日能量礼包","description":"1. 穿好袜子: 找到一双干净的袜子并穿上\n2. 穿好鞋子: 区分左右脚，系好鞋带\n3. 拿上书包: 确认作业都在书包里","icon":"task","difficulty":1,"promptLevel":null,"cycleType":null,"rewardPoints":10,"lightEffect":null,"audioEffect":null,"deadline":null,"status":"0"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-29 21:55:54.25', 68);
INSERT INTO "public"."sys_oper_log" VALUES (2049488159917502465, '000000', '家长奖励配置', 1, 'com.kenzhao.smallsteps.parent.controller.ParentRewardController.add()', 'POST', 1, 'ken2zhao', 'Small Steps 家庭', '/ssapi/parent/reward', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"rewardId":"2049488159477100545","userId":"2035392423676469250","name":"看动画片30分钟","pointsRequired":10,"stock":-1,"icon":"🎬","status":"0"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-29 21:57:09.638', 104);
INSERT INTO "public"."sys_oper_log" VALUES (2049488167878291457, '000000', '家长任务发布', 1, 'com.kenzhao.smallsteps.parent.controller.ParentTaskController.add()', 'POST', 1, 'ken2zhao', 'Small Steps 家庭', '/ssapi/parent/task', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"taskId":null,"parentId":null,"userId":"2035392423676469250","title":"[系统] 每日能量礼包","description":"1. 穿好袜子: 找到一双干净的袜子并穿上\n2. 穿好鞋子: 区分左右脚，系好鞋带\n3. 拿上书包: 确认作业都在书包里","icon":"task","difficulty":1,"promptLevel":null,"cycleType":null,"rewardPoints":10,"lightEffect":null,"audioEffect":null,"deadline":null,"status":"0"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-29 21:57:11.533', 69);
INSERT INTO "public"."sys_oper_log" VALUES (2049489023797325825, '000000', '家长奖励配置', 1, 'com.kenzhao.smallsteps.parent.controller.ParentRewardController.add()', 'POST', 1, 'ken2zhao', 'Small Steps 家庭', '/ssapi/parent/reward', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"rewardId":"2049489023474364418","userId":"2035392423676469250","name":"看动画片30分钟","pointsRequired":10,"stock":-1,"icon":"🎬","status":"0"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-29 22:00:35.605', 75);
INSERT INTO "public"."sys_oper_log" VALUES (2049489031535816705, '000000', '家长任务发布', 1, 'com.kenzhao.smallsteps.parent.controller.ParentTaskController.add()', 'POST', 1, 'ken2zhao', 'Small Steps 家庭', '/ssapi/parent/task', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"taskId":null,"parentId":null,"userId":"2035392423676469250","title":"[系统] 每日能量礼包","description":"1. 穿好袜子: 找到一双干净的袜子并穿上\n2. 穿好鞋子: 区分左右脚，系好鞋带\n3. 拿上书包: 确认作业都在书包里","icon":"task","difficulty":1,"promptLevel":null,"cycleType":null,"rewardPoints":10,"lightEffect":null,"audioEffect":null,"deadline":null,"status":"0"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-29 22:00:37.441', 70);
INSERT INTO "public"."sys_oper_log" VALUES (2049536449216319490, '000000', '家长奖励配置', 1, 'com.kenzhao.smallsteps.parent.controller.ParentRewardController.add()', 'POST', 1, 'ken2zhao', 'Small Steps 家庭', '/ssapi/parent/reward', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"rewardId":"2049536448608145410","userId":"2035392423676469250","name":"看动画片30分钟","pointsRequired":10,"stock":-1,"icon":"🎬","status":"0"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-30 01:09:02.689', 123);
INSERT INTO "public"."sys_oper_log" VALUES (2049536458422816770, '000000', '家长任务发布', 1, 'com.kenzhao.smallsteps.parent.controller.ParentTaskController.add()', 'POST', 1, 'ken2zhao', 'Small Steps 家庭', '/ssapi/parent/task', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"taskId":"2049536457751728129","parentId":null,"userId":"2035392423676469250","title":"[系统] 每日能量礼包","description":"1. 穿好袜子: 找到一双干净的袜子并穿上\n2. 穿好鞋子: 区分左右脚，系好鞋带\n3. 拿上书包: 确认作业都在书包里","icon":"task","difficulty":1,"promptLevel":null,"cycleType":null,"rewardPoints":10,"lightEffect":null,"audioEffect":null,"deadline":null,"status":"0","childId":null}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-30 01:09:04.891', 159);
INSERT INTO "public"."sys_oper_log" VALUES (2049538510918062081, '000000', '家长奖励配置', 1, 'com.kenzhao.smallsteps.parent.controller.ParentRewardController.add()', 'POST', 1, 'ken2zhao', 'Small Steps 家庭', '/ssapi/parent/reward', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"rewardId":"2049538510402162690","userId":"2035392423676469250","name":"看动画片30分钟","pointsRequired":10,"stock":-1,"icon":"🎬","status":"0"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-30 01:17:14.249', 124);
INSERT INTO "public"."sys_oper_log" VALUES (2049538527766581250, '000000', '家长任务发布', 1, 'com.kenzhao.smallsteps.parent.controller.ParentTaskController.add()', 'POST', 1, 'ken2zhao', 'Small Steps 家庭', '/ssapi/parent/task', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"taskId":"2049538526814474242","parentId":null,"userId":"2035392423676469250","title":"[系统] 每日能量礼包","description":"1. 穿好袜子: 找到一双干净的袜子并穿上\n2. 穿好鞋子: 区分左右脚，系好鞋带\n3. 拿上书包: 确认作业都在书包里","icon":"task","difficulty":1,"promptLevel":null,"cycleType":null,"rewardPoints":10,"lightEffect":null,"audioEffect":null,"deadline":null,"status":"0","childId":null}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-30 01:17:18.228', 198);
INSERT INTO "public"."sys_oper_log" VALUES (2049682421930070017, '000000', '家长奖励配置', 1, 'com.kenzhao.smallsteps.parent.controller.ParentRewardController.add()', 'POST', 1, 'ken2zhao', 'Small Steps 家庭', '/ssapi/parent/reward', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"rewardId":"2049682421498056706","userId":"2035392423676469250","name":"看动画片30分钟","pointsRequired":10,"stock":-1,"icon":"🎬","status":"0"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-30 10:49:05.303', 91);
INSERT INTO "public"."sys_oper_log" VALUES (2049682431035904001, '000000', '家长任务发布', 1, 'com.kenzhao.smallsteps.parent.controller.ParentTaskController.add()', 'POST', 1, 'ken2zhao', 'Small Steps 家庭', '/ssapi/parent/task', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"taskId":"2049682429861498881","parentId":null,"userId":"2035392423676469250","title":"[系统] 每日能量礼包","description":"1. 穿好袜子: 找到一双干净的袜子并穿上\n2. 穿好鞋子: 区分左右脚，系好鞋带\n3. 拿上书包: 确认作业都在书包里","icon":"task","difficulty":1,"promptLevel":null,"cycleType":null,"rewardPoints":10,"lightEffect":null,"audioEffect":null,"deadline":null,"status":"0","childId":1}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-30 10:49:07.474', 268);
INSERT INTO "public"."sys_oper_log" VALUES (2049709038358302722, '000000', '家长奖励配置', 1, 'com.kenzhao.smallsteps.parent.controller.ParentRewardController.add()', 'POST', 1, 'ken2zhao', 'Small Steps 家庭', '/ssapi/parent/reward', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"rewardId":"2049709037922095105","userId":"2035392423676469250","name":"看动画片30分钟","pointsRequired":10,"stock":-1,"icon":"🎬","status":"0"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-30 12:34:51.154', 87);
INSERT INTO "public"."sys_oper_log" VALUES (2049709046348451842, '000000', '家长任务发布', 1, 'com.kenzhao.smallsteps.parent.controller.ParentTaskController.add()', 'POST', 1, 'ken2zhao', 'Small Steps 家庭', '/ssapi/parent/task', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"taskId":"2049709045903855617","parentId":null,"userId":"2035392423676469250","title":"[系统] 每日能量礼包","description":"1. 穿好袜子: 找到一双干净的袜子并穿上\n2. 穿好鞋子: 区分左右脚，系好鞋带\n3. 拿上书包: 确认作业都在书包里","icon":"task","difficulty":1,"promptLevel":null,"cycleType":null,"rewardPoints":10,"lightEffect":null,"audioEffect":null,"deadline":null,"status":"0","childId":null}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-30 12:34:53.065', 109);
INSERT INTO "public"."sys_oper_log" VALUES (2049709510817288194, '000000', '家长奖励配置', 1, 'com.kenzhao.smallsteps.parent.controller.ParentRewardController.add()', 'POST', 1, 'ken2zhao', 'Small Steps 家庭', '/ssapi/parent/reward', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"rewardId":"2049709510418829314","userId":"2035392423676469250","name":"看动画片30分钟","pointsRequired":10,"stock":-1,"icon":"🎬","status":"0"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-30 12:36:43.808', 98);
INSERT INTO "public"."sys_oper_log" VALUES (2049709525858062338, '000000', '家长任务发布', 1, 'com.kenzhao.smallsteps.parent.controller.ParentTaskController.add()', 'POST', 1, 'ken2zhao', 'Small Steps 家庭', '/ssapi/parent/task', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"taskId":"2049709524830457857","parentId":null,"userId":"2035392423676469250","title":"[系统] 每日能量礼包","description":"1. 穿好袜子: 找到一双干净的袜子并穿上\n2. 穿好鞋子: 区分左右脚，系好鞋带\n3. 拿上书包: 确认作业都在书包里","icon":"task","difficulty":1,"promptLevel":null,"cycleType":null,"rewardPoints":10,"lightEffect":null,"audioEffect":null,"deadline":null,"status":"0","childId":null}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-30 12:36:47.388', 240);
INSERT INTO "public"."sys_oper_log" VALUES (2049710577537847297, '000000', '家长奖励配置', 1, 'com.kenzhao.smallsteps.parent.controller.ParentRewardController.add()', 'POST', 1, 'ken2zhao', 'Small Steps 家庭', '/ssapi/parent/reward', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"rewardId":"2049710577026142210","userId":"2035392423676469250","name":"看动画片30分钟","pointsRequired":10,"stock":-1,"icon":"🎬","status":"0"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-30 12:40:58.127', 118);
INSERT INTO "public"."sys_oper_log" VALUES (2050496495253311490, '000000', '家长奖励配置', 1, 'com.kenzhao.smallsteps.parent.controller.ParentRewardController.add()', 'POST', 1, 'ken2zhao', 'Small Steps 家庭', '/ssapi/parent/reward', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"rewardId":"2050496494800326657","userId":"2035392423676469250","name":"看动画片30分钟","pointsRequired":10,"stock":-1,"icon":"🎬","status":"0"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-05-02 16:43:55.517', 105);
INSERT INTO "public"."sys_oper_log" VALUES (2049710586257805314, '000000', '家长任务发布', 1, 'com.kenzhao.smallsteps.parent.controller.ParentTaskController.add()', 'POST', 1, 'ken2zhao', 'Small Steps 家庭', '/ssapi/parent/task', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"taskId":"2049710585871929346","parentId":null,"userId":"2035392423676469250","title":"[系统] 每日能量礼包","description":"1. 穿好袜子: 找到一双干净的袜子并穿上\n2. 穿好鞋子: 区分左右脚，系好鞋带\n3. 拿上书包: 确认作业都在书包里","icon":"task","difficulty":1,"promptLevel":null,"cycleType":null,"rewardPoints":10,"lightEffect":null,"audioEffect":null,"deadline":null,"status":"0","childId":null}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-30 12:41:00.211', 89);
INSERT INTO "public"."sys_oper_log" VALUES (2049753359170146305, '000000', '家长奖励配置', 1, 'com.kenzhao.smallsteps.parent.controller.ParentRewardController.add()', 'POST', 1, 'ken2zhao', 'Small Steps 家庭', '/ssapi/parent/reward', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"rewardId":"2049753358524223490","userId":"2035392423676469250","name":"看动画片30分钟","pointsRequired":10,"stock":-1,"icon":"🎬","status":"0"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-30 15:30:58.054', 136);
INSERT INTO "public"."sys_oper_log" VALUES (2049753368045293570, '000000', '家长任务发布', 1, 'com.kenzhao.smallsteps.parent.controller.ParentTaskController.add()', 'POST', 1, 'ken2zhao', 'Small Steps 家庭', '/ssapi/parent/task', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"taskId":"2049753367713943553","parentId":null,"userId":"2035392423676469250","title":"[系统] 每日能量礼包","description":"1. 穿好袜子: 找到一双干净的袜子并穿上\n2. 穿好鞋子: 区分左右脚，系好鞋带\n3. 拿上书包: 确认作业都在书包里","icon":"task","difficulty":1,"promptLevel":null,"cycleType":null,"rewardPoints":10,"lightEffect":null,"audioEffect":null,"deadline":null,"status":"0","childId":null}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-30 15:31:00.18', 84);
INSERT INTO "public"."sys_oper_log" VALUES (2049753579245277185, '000000', '家长奖励配置', 1, 'com.kenzhao.smallsteps.parent.controller.ParentRewardController.add()', 'POST', 1, 'ken2zhao', 'Small Steps 家庭', '/ssapi/parent/reward', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"rewardId":"2049753578574188545","userId":"2035392423676469250","name":"看动画片30分钟","pointsRequired":10,"stock":-1,"icon":"🎬","status":"0"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-30 15:31:50.536', 153);
INSERT INTO "public"."sys_oper_log" VALUES (2049753588359499777, '000000', '家长任务发布', 1, 'com.kenzhao.smallsteps.parent.controller.ParentTaskController.add()', 'POST', 1, 'ken2zhao', 'Small Steps 家庭', '/ssapi/parent/task', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"taskId":"2049753588040732673","parentId":null,"userId":"2035392423676469250","title":"[系统] 每日能量礼包","description":"1. 穿好袜子: 找到一双干净的袜子并穿上\n2. 穿好鞋子: 区分左右脚，系好鞋带\n3. 拿上书包: 确认作业都在书包里","icon":"task","difficulty":1,"promptLevel":null,"cycleType":null,"rewardPoints":10,"lightEffect":null,"audioEffect":null,"deadline":null,"status":"0","childId":null}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-30 15:31:52.713', 83);
INSERT INTO "public"."sys_oper_log" VALUES (2049754712466526209, '000000', '家长奖励配置', 1, 'com.kenzhao.smallsteps.parent.controller.ParentRewardController.add()', 'POST', 1, 'ken2zhao', 'Small Steps 家庭', '/ssapi/parent/reward', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"rewardId":"2049754711912878081","userId":"2035392423676469250","name":"看动画片30分钟","pointsRequired":10,"stock":-1,"icon":"🎬","status":"0"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-30 15:36:20.71', 121);
INSERT INTO "public"."sys_oper_log" VALUES (2049754726664245250, '000000', '家长任务发布', 1, 'com.kenzhao.smallsteps.parent.controller.ParentTaskController.add()', 'POST', 1, 'ken2zhao', 'Small Steps 家庭', '/ssapi/parent/task', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"taskId":"2049754725380788226","parentId":null,"userId":"2035392423676469250","title":"[系统] 每日能量礼包","description":"1. 穿好袜子: 找到一双干净的袜子并穿上\n2. 穿好鞋子: 区分左右脚，系好鞋带\n3. 拿上书包: 确认作业都在书包里","icon":"task","difficulty":1,"promptLevel":null,"cycleType":null,"rewardPoints":10,"lightEffect":null,"audioEffect":null,"deadline":null,"status":"0","childId":1}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-30 15:36:24.108', 288);
INSERT INTO "public"."sys_oper_log" VALUES (2049755286981316610, '000000', '家长奖励配置', 1, 'com.kenzhao.smallsteps.parent.controller.ParentRewardController.add()', 'POST', 1, 'ken2zhao', 'Small Steps 家庭', '/ssapi/parent/reward', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"rewardId":"2049755286360559618","userId":"2035392423676469250","name":"看动画片30分钟","pointsRequired":10,"stock":-1,"icon":"🎬","status":"0"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-30 15:38:37.69', 130);
INSERT INTO "public"."sys_oper_log" VALUES (2049755296183619585, '000000', '家长任务发布', 1, 'com.kenzhao.smallsteps.parent.controller.ParentTaskController.add()', 'POST', 1, 'ken2zhao', 'Small Steps 家庭', '/ssapi/parent/task', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"taskId":"2049755295596417025","parentId":null,"userId":"2035392423676469250","title":"[系统] 每日能量礼包","description":"1. 穿好袜子: 找到一双干净的袜子并穿上\n2. 穿好鞋子: 区分左右脚，系好鞋带\n3. 拿上书包: 确认作业都在书包里","icon":"task","difficulty":1,"promptLevel":null,"cycleType":null,"rewardPoints":10,"lightEffect":null,"audioEffect":null,"deadline":null,"status":"0","childId":null}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-04-30 15:38:39.883', 125);
INSERT INTO "public"."sys_oper_log" VALUES (2050495318386135042, '000000', '家长奖励配置', 1, 'com.kenzhao.smallsteps.parent.controller.ParentRewardController.add()', 'POST', 1, 'ken2zhao', 'Small Steps 家庭', '/ssapi/parent/reward', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"rewardId":"2050495317220118530","userId":"2035392423676469250","name":"看动画片30分钟","pointsRequired":10,"stock":-1,"icon":"🎬","status":"0"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-05-02 16:39:14.924', 223);
INSERT INTO "public"."sys_oper_log" VALUES (2050495339110191106, '000000', '家长任务发布', 1, 'com.kenzhao.smallsteps.parent.controller.ParentTaskController.add()', 'POST', 1, 'ken2zhao', 'Small Steps 家庭', '/ssapi/parent/task', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"taskId":"2050495338204221441","parentId":null,"userId":"2035392423676469250","title":"[系统] 每日能量礼包","description":"1. 穿好袜子: 找到一双干净的袜子并穿上\n2. 穿好鞋子: 区分左右脚，系好鞋带\n3. 拿上书包: 确认作业都在书包里","icon":"task","difficulty":1,"promptLevel":null,"cycleType":null,"rewardPoints":10,"lightEffect":null,"audioEffect":null,"deadline":null,"status":"0","childId":null}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-05-02 16:39:19.863', 189);
INSERT INTO "public"."sys_oper_log" VALUES (2050496508645724161, '000000', '家长任务发布', 1, 'com.kenzhao.smallsteps.parent.controller.ParentTaskController.add()', 'POST', 1, 'ken2zhao', 'Small Steps 家庭', '/ssapi/parent/task', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"taskId":"2050496508184350722","parentId":null,"userId":"2035392423676469250","title":"[系统] 每日能量礼包","description":"1. 穿好袜子: 找到一双干净的袜子并穿上\n2. 穿好鞋子: 区分左右脚，系好鞋带\n3. 拿上书包: 确认作业都在书包里","icon":"task","difficulty":1,"promptLevel":null,"cycleType":null,"rewardPoints":10,"lightEffect":null,"audioEffect":null,"deadline":null,"status":"0","childId":null}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-05-02 16:43:58.711', 95);
INSERT INTO "public"."sys_oper_log" VALUES (2050497070359498754, '000000', '家长奖励配置', 1, 'com.kenzhao.smallsteps.parent.controller.ParentRewardController.add()', 'POST', 1, 'ken2zhao', 'Small Steps 家庭', '/ssapi/parent/reward', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"rewardId":"2050497069780684801","userId":"2035392423676469250","name":"看动画片30分钟","pointsRequired":10,"stock":-1,"icon":"🎬","status":"0"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-05-02 16:46:12.626', 122);
INSERT INTO "public"."sys_oper_log" VALUES (2050497082925633537, '000000', '家长任务发布', 1, 'com.kenzhao.smallsteps.parent.controller.ParentTaskController.add()', 'POST', 1, 'ken2zhao', 'Small Steps 家庭', '/ssapi/parent/task', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"taskId":"2050497081768005634","parentId":null,"userId":"2035392423676469250","title":"[系统] 每日能量礼包","description":"1. 穿好袜子: 找到一双干净的袜子并穿上\n2. 穿好鞋子: 区分左右脚，系好鞋带\n3. 拿上书包: 确认作业都在书包里","icon":"task","difficulty":1,"promptLevel":null,"cycleType":null,"rewardPoints":10,"lightEffect":null,"audioEffect":null,"deadline":null,"status":"0","childId":1}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-05-02 16:46:15.621', 226);
INSERT INTO "public"."sys_oper_log" VALUES (2050497705272266754, '000000', '家长奖励配置', 1, 'com.kenzhao.smallsteps.parent.controller.ParentRewardController.add()', 'POST', 1, 'ken2zhao', 'Small Steps 家庭', '/ssapi/parent/reward', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"rewardId":"2050497704882196482","userId":"2035392423676469250","name":"看动画片30分钟","pointsRequired":10,"stock":-1,"icon":"🎬","status":"0"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-05-02 16:48:44.012', 110);
INSERT INTO "public"."sys_oper_log" VALUES (2050497731235008513, '000000', '家长任务发布', 1, 'com.kenzhao.smallsteps.parent.controller.ParentTaskController.add()', 'POST', 1, 'ken2zhao', 'Small Steps 家庭', '/ssapi/parent/task', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"taskId":"2050497730463256577","parentId":null,"userId":"2035392423676469250","title":"[系统] 每日能量礼包","description":"1. 穿好袜子: 找到一双干净的袜子并穿上\n2. 穿好鞋子: 区分左右脚，系好鞋带\n3. 拿上书包: 确认作业都在书包里","icon":"task","difficulty":1,"promptLevel":null,"cycleType":null,"rewardPoints":10,"lightEffect":null,"audioEffect":null,"deadline":null,"status":"0","childId":1}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-05-02 16:48:50.2', 180);
INSERT INTO "public"."sys_oper_log" VALUES (2050498078372384770, '000000', '家长奖励配置', 1, 'com.kenzhao.smallsteps.parent.controller.ParentRewardController.add()', 'POST', 1, 'ken2zhao', 'Small Steps 家庭', '/ssapi/parent/reward', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"rewardId":"2050498077843902466","userId":"2035392423676469250","name":"看动画片30分钟","pointsRequired":10,"stock":-1,"icon":"🎬","status":"0"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-05-02 16:50:12.962', 103);
INSERT INTO "public"."sys_oper_log" VALUES (2050498134911602689, '000000', '家长任务发布', 1, 'com.kenzhao.smallsteps.parent.controller.ParentTaskController.add()', 'POST', 1, 'ken2zhao', 'Small Steps 家庭', '/ssapi/parent/task', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"taskId":"2050498134328594433","parentId":null,"userId":"2035392423676469250","title":"[系统] 每日能量礼包","description":"1. 穿好袜子: 找到一双干净的袜子并穿上\n2. 穿好鞋子: 区分左右脚，系好鞋带\n3. 拿上书包: 确认作业都在书包里","icon":"task","difficulty":1,"promptLevel":null,"cycleType":null,"rewardPoints":10,"lightEffect":null,"audioEffect":null,"deadline":null,"status":"0","childId":null}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-05-02 16:50:26.437', 127);
INSERT INTO "public"."sys_oper_log" VALUES (2050498508569563138, '000000', '家长奖励配置', 1, 'com.kenzhao.smallsteps.parent.controller.ParentRewardController.add()', 'POST', 1, 'ken2zhao', 'Small Steps 家庭', '/ssapi/parent/reward', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"rewardId":"2050498508116578306","userId":"2035392423676469250","name":"看动画片30分钟","pointsRequired":10,"stock":-1,"icon":"🎬","status":"0"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-05-02 16:51:55.525', 86);
INSERT INTO "public"."sys_oper_log" VALUES (2050498520959537153, '000000', '家长任务发布', 1, 'com.kenzhao.smallsteps.parent.controller.ParentTaskController.add()', 'POST', 1, 'ken2zhao', 'Small Steps 家庭', '/ssapi/parent/task', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"taskId":"2050498519982264322","parentId":null,"userId":"2035392423676469250","title":"[系统] 每日能量礼包","description":"1. 穿好袜子: 找到一双干净的袜子并穿上\n2. 穿好鞋子: 区分左右脚，系好鞋带\n3. 拿上书包: 确认作业都在书包里","icon":"task","difficulty":1,"promptLevel":null,"cycleType":null,"rewardPoints":10,"lightEffect":null,"audioEffect":null,"deadline":null,"status":"0","childId":1}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-05-02 16:51:58.489', 199);
INSERT INTO "public"."sys_oper_log" VALUES (2050499199979606017, '000000', '家长奖励配置', 1, 'com.kenzhao.smallsteps.parent.controller.ParentRewardController.add()', 'POST', 1, 'ken2zhao', 'Small Steps 家庭', '/ssapi/parent/reward', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"rewardId":"2050499199409180674","userId":"2035392423676469250","name":"看动画片30分钟","pointsRequired":10,"stock":-1,"icon":"🎬","status":"0"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-05-02 16:54:40.366', 112);
INSERT INTO "public"."sys_oper_log" VALUES (2050499237749313537, '000000', '家长任务发布', 1, 'com.kenzhao.smallsteps.parent.controller.ParentTaskController.add()', 'POST', 1, 'ken2zhao', 'Small Steps 家庭', '/ssapi/parent/task', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"taskId":"2050499236063203330","parentId":null,"userId":"2035392423676469250","title":"[系统] 每日能量礼包","description":"1. 穿好袜子: 找到一双干净的袜子并穿上\n2. 穿好鞋子: 区分左右脚，系好鞋带\n3. 拿上书包: 确认作业都在书包里","icon":"task","difficulty":1,"promptLevel":null,"cycleType":null,"rewardPoints":10,"lightEffect":null,"audioEffect":null,"deadline":null,"status":"0","childId":1}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-05-02 16:54:49.378', 385);
INSERT INTO "public"."sys_oper_log" VALUES (2050502215549964290, '000000', '家长奖励配置', 1, 'com.kenzhao.smallsteps.parent.controller.ParentRewardController.add()', 'POST', 1, 'ken2zhao', 'Small Steps 家庭', '/ssapi/parent/reward', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"rewardId":"2050502215029870594","userId":"2035392423676469250","name":"看动画片30分钟","pointsRequired":10,"stock":-1,"icon":"🎬","status":"0"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-05-02 17:06:39.347', 134);
INSERT INTO "public"."sys_oper_log" VALUES (2050502227335958529, '000000', '家长任务发布', 1, 'com.kenzhao.smallsteps.parent.controller.ParentTaskController.add()', 'POST', 1, 'ken2zhao', 'Small Steps 家庭', '/ssapi/parent/task', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"taskId":"2050502226551623681","parentId":null,"userId":"2035392423676469250","title":"[系统] 每日能量礼包","description":"1. 穿好袜子: 找到一双干净的袜子并穿上\n2. 穿好鞋子: 区分左右脚，系好鞋带\n3. 拿上书包: 确认作业都在书包里","icon":"task","difficulty":1,"promptLevel":null,"cycleType":null,"rewardPoints":10,"lightEffect":null,"audioEffect":null,"deadline":null,"status":"0","childId":1}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-05-02 17:06:42.149', 175);
INSERT INTO "public"."sys_oper_log" VALUES (2050510159544963073, '000000', '家长奖励配置', 1, 'com.kenzhao.smallsteps.parent.controller.ParentRewardController.add()', 'POST', 1, 'ken2zhao', 'Small Steps 家庭', '/ssapi/parent/reward', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"rewardId":"2050510159104561154","userId":"2035392423676469250","name":"看动画片30分钟","pointsRequired":10,"stock":-1,"icon":"🎬","status":"0"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-05-02 17:38:13.34', 95);
INSERT INTO "public"."sys_oper_log" VALUES (2050510168726294530, '000000', '家长任务发布', 1, 'com.kenzhao.smallsteps.parent.controller.ParentTaskController.add()', 'POST', 1, 'ken2zhao', 'Small Steps 家庭', '/ssapi/parent/task', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"taskId":"2050510168210395137","parentId":null,"userId":"2035392423676469250","title":"[系统] 每日能量礼包","description":"1. 穿好袜子: 找到一双干净的袜子并穿上\n2. 穿好鞋子: 区分左右脚，系好鞋带\n3. 拿上书包: 确认作业都在书包里","icon":"task","difficulty":1,"promptLevel":null,"cycleType":null,"rewardPoints":10,"lightEffect":null,"audioEffect":null,"deadline":null,"status":"0","childId":null}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-05-02 17:38:15.526', 118);
INSERT INTO "public"."sys_oper_log" VALUES (2052670131288457217, '000000', '菜单管理', 2, 'com.kenzhao.smallsteps.system.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', 'Small Steps 家庭', '/ssapi/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":"2026-04-23 20:31:47","updateBy":null,"updateTime":null,"menuId":4000,"parentId":0,"menuName":"AI管理","orderNum":50,"path":"ai","component":null,"queryParam":null,"isFrame":"1","isCache":"0","menuType":"M","visible":"0","status":"0","icon":"cpu","remark":"AI核心管理模块"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-05-08 16:41:10.735', 150);
INSERT INTO "public"."sys_oper_log" VALUES (2052670281553592321, '000000', '菜单管理', 2, 'com.kenzhao.smallsteps.system.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', 'Small Steps 家庭', '/ssapi/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":"2026-04-23 20:31:47","updateBy":null,"updateTime":null,"menuId":4000,"parentId":0,"menuName":"AI管理","orderNum":50,"path":"ai","component":null,"queryParam":null,"isFrame":"1","isCache":"0","menuType":"M","visible":"0","status":"0","icon":"international","remark":"AI核心管理模块"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-05-08 16:41:46.557', 144);
INSERT INTO "public"."sys_oper_log" VALUES (2052671941424234498, '000000', '菜单管理', 2, 'com.kenzhao.smallsteps.system.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', 'Small Steps 家庭', '/ssapi/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":103,"createBy":null,"createTime":"2026-04-25 22:20:05","updateBy":null,"updateTime":null,"menuId":4005,"parentId":4000,"menuName":"路由管理","orderNum":3,"path":"route","component":"ai/route/index","queryParam":"","isFrame":"1","isCache":"0","menuType":"C","visible":"0","status":"0","perms":"ai:route:list","icon":"guide","remark":"AI路由策略"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-05-08 16:48:22.295', 337);
INSERT INTO "public"."sys_oper_log" VALUES (2052671990212378625, '000000', '菜单管理', 2, 'com.kenzhao.smallsteps.system.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', 'Small Steps 家庭', '/ssapi/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":103,"createBy":null,"createTime":"2026-04-25 22:20:05","updateBy":null,"updateTime":null,"menuId":4004,"parentId":4000,"menuName":"供应商管理","orderNum":1,"path":"provider","component":"ai/provider/index","queryParam":"","isFrame":"1","isCache":"0","menuType":"C","visible":"0","status":"0","perms":"ai:provider:list","icon":"international","remark":"AI供应商配置"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-05-08 16:48:33.931', 125);
INSERT INTO "public"."sys_oper_log" VALUES (2052696865819901953, '000000', '家长任务发布', 1, 'com.kenzhao.smallsteps.parent.controller.ParentTaskController.add()', 'POST', 1, 'ken2zhao', 'Small Steps 家庭', '/ssapi/parent/task', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"taskId":"2052696864968458242","parentId":null,"userId":"2035392423676469250","title":"写作业复习预习","description":"1. 深呼吸，坐端正: \n2. 翻开课本看一看: \n3. 指读新课，圈重点: \n4. 拿起笔，写第一题: ","icon":"task","difficulty":1,"promptLevel":null,"cycleType":null,"rewardPoints":10,"lightEffect":null,"audioEffect":null,"deadline":null,"status":"0","childId":1002}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-05-08 18:27:24.742', 205);
INSERT INTO "public"."sys_oper_log" VALUES (2052955103400300545, '000000', '家长奖励配置', 1, 'com.kenzhao.smallsteps.parent.controller.ParentRewardController.add()', 'POST', 1, 'ken2zhao', 'Small Steps 家庭', '/ssapi/parent/reward', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"rewardId":"2052955101533835266","userId":"2035392423676469250","name":"看动画片30分钟","pointsRequired":10,"stock":-1,"icon":"🎬","status":"0"}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-05-09 11:33:33.363', 368);
INSERT INTO "public"."sys_oper_log" VALUES (2053710889572982785, '000000', '家长任务发布', 1, 'com.kenzhao.smallsteps.parent.controller.ParentTaskController.add()', 'POST', 1, 'ken2zhao', 'Small Steps 家庭', '/ssapi/parent/task', '180.165.11.155', '中国|上海|上海市|电信', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"taskId":"2053710888520212482","parentId":null,"userId":"2035392423676469250","title":"收拾书包上学","description":"1. 准备阶段: 为收拾书包上学准备必要的材料\n2. 开始执行: 按照简单的步骤开始收拾书包上学\n3. 完成任务: 完成收拾书包上学并检查结果","icon":"task","difficulty":1,"promptLevel":null,"cycleType":null,"rewardPoints":10,"lightEffect":null,"audioEffect":null,"deadline":null,"status":"0","childId":1002}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-05-11 13:36:46.829', 236);
INSERT INTO "public"."sys_oper_log" VALUES (2053834667636154369, '000000', '家长任务发布', 1, 'com.kenzhao.smallsteps.parent.controller.ParentTaskController.add()', 'POST', 1, 'ken2zhao', 'Small Steps 家庭', '/ssapi/parent/task', '180.165.11.155', '中国|上海|上海市|电信', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"taskId":"2053834666847625217","parentId":null,"userId":"2035392423676469250","title":"今天的语文作业要完成","description":"1. 拿出语文书: \n2. 翻开作业本: \n3. 拿起笔写一题: \n4. 检查字迹对不对: ","icon":"task","difficulty":1,"promptLevel":null,"cycleType":null,"rewardPoints":10,"lightEffect":null,"audioEffect":null,"deadline":null,"status":"0","childId":1002}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-05-11 21:48:37.822', 182);
INSERT INTO "public"."sys_oper_log" VALUES (2055659571330007041, '000000', '菜单管理', 1, 'com.kenzhao.smallsteps.system.controller.system.SysMenuController.add()', 'POST', 1, 'admin', 'Small Steps 家庭', '/ssapi/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"menuId":null,"parentId":4000,"menuName":"知识库管理","orderNum":1,"path":"knowledge","component":"system/ai/knowledge/index.vue","queryParam":null,"isFrame":"1","isCache":"0","menuType":"C","visible":"0","status":"0","icon":"international","remark":null}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-05-16 22:40:08.767', 193);
INSERT INTO "public"."sys_oper_log" VALUES (2055662087128072193, '000000', '菜单管理', 2, 'com.kenzhao.smallsteps.system.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', 'Small Steps 家庭', '/ssapi/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{"createDept":200,"createBy":null,"createTime":"2026-05-16 22:40:08","updateBy":null,"updateTime":null,"menuId":"2055659570751193090","parentId":4000,"menuName":"知识库管理","orderNum":1,"path":"knowledge","component":"ai/knowledge/index","queryParam":null,"isFrame":"1","isCache":"0","menuType":"C","visible":"0","status":"0","icon":"international","remark":""}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-05-16 22:50:08.584', 211);
INSERT INTO "public"."sys_oper_log" VALUES (2059631014528970753, '000000', '用户管理', 2, 'com.kenzhao.smallsteps.system.controller.system.SysUserController.resetPwd()', 'PUT', 1, 'admin', 'Small Steps 家庭', '/ssapi/system/user/resetPwd', '192.168.1.9', '内网IP', '{"createDept":null,"createBy":null,"createTime":null,"updateBy":null,"updateTime":null,"userId":"2035392423676469250","deptId":null,"userName":null,"nickName":null,"userType":null,"email":null,"phonenumber":null,"sex":null,"status":null,"remark":null,"roleIds":null,"postIds":null,"roleId":null,"userIds":null,"excludeUserIds":null,"superAdmin":false}', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-05-27 21:41:14.613', 127);
INSERT INTO "public"."sys_oper_log" VALUES (2059631367152496641, '000000', '用户管理', 3, 'com.kenzhao.smallsteps.system.controller.system.SysUserController.remove()', 'DELETE', 1, 'admin', 'Small Steps 家庭', '/ssapi/system/user/10002', '192.168.1.9', '内网IP', '[10002]', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-05-27 21:42:38.686', 80);
INSERT INTO "public"."sys_oper_log" VALUES (2059631378498088961, '000000', '用户管理', 3, 'com.kenzhao.smallsteps.system.controller.system.SysUserController.remove()', 'DELETE', 1, 'admin', 'Small Steps 家庭', '/ssapi/system/user/10001', '192.168.1.9', '内网IP', '[10001]', '{"code":200,"msg":"操作成功","data":null}', 0, '', '2026-05-27 21:42:41.391', 67);

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
INSERT INTO "public"."sys_user" VALUES (1000, '000000', 200, 'parent_zhang', '张伟', '1', 'zhangwei@example.com', '13800138001', '0', NULL, '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '0:0:0:0:0:0:0:1', '2026-05-09 12:47:14.969', 200, 1, '2026-03-14 20:37:07.963832', -1, '2026-05-09 12:47:14.969', '家长测试账号 - 密码: admin123');
INSERT INTO "public"."sys_user" VALUES (1001, '000000', 200, 'parent_li', '李娜', '1', 'lina@example.com', '13800138002', '1', NULL, '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2026-03-14 20:37:08.038754', 200, 1, '2026-03-14 20:37:08.038754', NULL, NULL, '家长测试账号 - 密码: admin123');
INSERT INTO "public"."sys_user" VALUES (1003, '000000', 200, 'child_xiaohong', '张小红', '2', '', '', '1', NULL, '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '0:0:0:0:0:0:0:1', '2026-04-26 22:00:25.839', 200, 1, '2026-03-14 20:37:08.180468', 2035392423676469250, '2026-04-26 22:00:25.839', '儿童测试账号 - 密码: admin123');
INSERT INTO "public"."sys_user" VALUES (2049535770204639234, '000000', 201, 'parent_test_final', 'parent_test_final', '1', '', '', '0', NULL, '$2a$10$RysIHD5ADDRmapY7dqLT6uAOFJAgh3929we0hyfzzOybSNZkOY4rS', '0', '0', '', NULL, NULL, 0, '2026-04-30 01:06:20.809', 0, '2026-04-30 01:06:20.809', NULL);
INSERT INTO "public"."sys_user" VALUES (1002, '000000', 200, 'child_xiaoming', '张小明', '2', '', '', '0', NULL, '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '180.165.11.155', '2026-05-11 19:30:42.668', 200, 1, '2026-03-14 20:37:08.105589', -1, '2026-05-11 19:30:42.669', '儿童测试账号 - 密码: admin123');
INSERT INTO "public"."sys_user" VALUES (1, '000000', 200, 'admin', '系统管理员', 'sys_user', '1130473608@qq.com', '18516108779', '1', NULL, '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '192.168.1.9', '2026-05-27 21:38:51.747', 103, 1, '2026-03-14 20:30:19.891442', -1, '2026-05-27 21:38:51.758', '管理员');
INSERT INTO "public"."sys_user" VALUES (10002, '000000', 200, 'child_10002', '小红', '2', '', '', '0', NULL, '', '0', '1', '', NULL, NULL, NULL, '2026-04-25 16:43:46.522317', 1, '2026-05-27 21:42:38.618', NULL);
INSERT INTO "public"."sys_user" VALUES (10001, '000000', 200, 'child_10001', '小明', '2', '', '', '0', NULL, '', '0', '1', '', NULL, NULL, NULL, '2026-04-25 16:43:46.522317', 1, '2026-05-27 21:42:41.33', NULL);
INSERT INTO "public"."sys_user" VALUES (2035392423676469250, '000000', 200, 'ken2zhao', 'ken2zhao', '1', '', '', '0', NULL, '$2a$10$LX082DxZ2HiqrMYgQOwBg.oYFWtoLZBMhp2FjhzmNg1QyqqXBYAki', '0', '0', '192.168.1.9', '2026-05-27 21:41:30.311', NULL, 0, '2026-03-22 00:25:44.224', -1, '2026-05-27 21:41:30.312', NULL);

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
INSERT INTO "public"."sys_user_role" VALUES (2049535770204639234, 10);

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
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."ss_child_ai_id_seq"
OWNED BY "public"."ss_child_ai"."id";
SELECT setval('"public"."ss_child_ai_id_seq"', 12, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."ss_task_step_template_step_id_seq"
OWNED BY "public"."ss_task_step_template"."step_id";
SELECT setval('"public"."ss_task_step_template_step_id_seq"', 9, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."ss_task_template_template_id_seq"
OWNED BY "public"."ss_task_template"."template_id";
SELECT setval('"public"."ss_task_template_template_id_seq"', 1, false);

-- ----------------------------
-- Primary Key structure for table ss_child_ai
-- ----------------------------
ALTER TABLE "public"."ss_child_ai" ADD CONSTRAINT "ss_child_ai_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table ss_task_step_template
-- ----------------------------
ALTER TABLE "public"."ss_task_step_template" ADD CONSTRAINT "ss_task_step_template_pkey" PRIMARY KEY ("step_id");

-- ----------------------------
-- Primary Key structure for table ss_task_template
-- ----------------------------
ALTER TABLE "public"."ss_task_template" ADD CONSTRAINT "ss_task_template_pkey" PRIMARY KEY ("template_id");

-- ----------------------------
-- Primary Key structure for table sys_ai_knowledge
-- ----------------------------
ALTER TABLE "public"."sys_ai_knowledge" ADD CONSTRAINT "sys_ai_knowledge_pkey" PRIMARY KEY ("id");

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

-- ----------------------------
-- Primary Key structure for table sys_ai_usage
-- ----------------------------
ALTER TABLE "public"."sys_ai_usage" ADD CONSTRAINT "sys_ai_usage_pkey" PRIMARY KEY ("id");

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
