-- ----------------------------
-- 1. 儿童基本信息表 (PostgreSQL)
-- ----------------------------
DROP TABLE IF EXISTS "ss_child";
CREATE TABLE "ss_child" (
  "child_id"      bigserial       NOT NULL,
  "dept_id"       bigint          NOT NULL,
  "child_name"    varchar(30)     NOT NULL,
  "nick_name"     varchar(30)     DEFAULT '',
  "birthday"      date            DEFAULT NULL,
  "sex"           char(1)         DEFAULT '0',
  "avatar"        varchar(100)    DEFAULT '',
  "status"        char(1)         DEFAULT '0',
  "del_flag"      char(1)         DEFAULT '0',
  "create_by"     varchar(64)     DEFAULT '',
  "create_time"   timestamp       DEFAULT NULL,
  "update_by"     varchar(64)     DEFAULT '',
  "update_time"   timestamp       DEFAULT NULL,
  "remark"        varchar(500)    DEFAULT NULL,
  PRIMARY KEY ("child_id")
);

COMMENT ON TABLE "ss_child" IS '儿童信息表';
COMMENT ON COLUMN "ss_child"."child_id" IS '儿童ID';
COMMENT ON COLUMN "ss_child"."dept_id" IS '家庭ID (对应sys_dept_id)';
COMMENT ON COLUMN "ss_child"."child_name" IS '姓名';
COMMENT ON COLUMN "ss_child"."nick_name" IS '昵称';
COMMENT ON COLUMN "ss_child"."birthday" IS '出生日期';
COMMENT ON COLUMN "ss_child"."sex" IS '性别 (0男 1女 2未知)';
COMMENT ON COLUMN "ss_child"."avatar" IS '头像地址';
COMMENT ON COLUMN "ss_child"."status" IS '帐号状态 (0正常 1停用)';
COMMENT ON COLUMN "ss_child"."del_flag" IS '删除标志 (0代表存在 2代表删除)';
COMMENT ON COLUMN "ss_child"."create_by" IS '创建者';
COMMENT ON COLUMN "ss_child"."create_time" IS '创建时间';
COMMENT ON COLUMN "ss_child"."update_by" IS '更新者';
COMMENT ON COLUMN "ss_child"."update_time" IS '更新时间';
COMMENT ON COLUMN "ss_child"."remark" IS '备注';

-- ----------------------------
-- 2. 初始化一些示例数据
-- ----------------------------
INSERT INTO "ss_child" (dept_id, child_name, nick_name, birthday, sex, create_time, remark)
VALUES (100, '张小明', '明明', '2018-05-20', '0', current_timestamp, '示例儿童1');
INSERT INTO "ss_child" (dept_id, child_name, nick_name, birthday, sex, create_time, remark)
VALUES (100, '李小红', '红红', '2019-03-15', '1', current_timestamp, '示例儿童2');
