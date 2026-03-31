-- -------------------------------------------------------------------------------------------------------------------
-- Small Steps Core Business Schema (PostgreSQL) - Final v1.6 (Tenant Aligned)
-- Author: Antigravity
-- Date: 2026-02-01
-- -------------------------------------------------------------------------------------------------------------------

-- ----------------------------
-- 1. 儿童档案表
-- ----------------------------
DROP TABLE IF EXISTS ss_child;
CREATE TABLE ss_child (
  id            INT8            NOT NULL,
  tenant_id     VARCHAR(20)     DEFAULT '000000',
  parent_id     INT8            NOT NULL, 
  nickname      VARCHAR(64)     NOT NULL,
  avatar_url    VARCHAR(255)    DEFAULT '',
  avatar_config JSONB,
  level         INT             DEFAULT 1,
  daily_config  JSONB,
  gender        CHAR(1)         DEFAULT '0',
  birthday      TIMESTAMP,
  star_balance  INT             DEFAULT 0,
  total_stars   INT             DEFAULT 0,
  challenges    JSONB,
  create_dept   INT8            DEFAULT NULL,
  create_by     INT8            DEFAULT NULL,
  create_time   TIMESTAMP       DEFAULT NULL,
  update_by     INT8            DEFAULT NULL,
  update_time   TIMESTAMP       DEFAULT NULL,
  remark        VARCHAR(500)    DEFAULT NULL,
  del_flag      CHAR(1)         DEFAULT '0',
  PRIMARY KEY (id)
);
COMMENT ON TABLE ss_child IS '儿童档案表';
COMMENT ON COLUMN ss_child.daily_config IS '个性化每日限制配置';


-- ----------------------------
-- 2. 任务配置表
-- ----------------------------
DROP TABLE IF EXISTS ss_task;
CREATE TABLE ss_task (
  id            INT8            NOT NULL,
  tenant_id     VARCHAR(20)     DEFAULT '000000',
  child_id      INT8            NOT NULL,
  title         VARCHAR(128)    NOT NULL,
  icon          VARCHAR(255)    DEFAULT '',
  star_reward   INT             DEFAULT 1,
  difficulty    INT             DEFAULT 1,
  type          CHAR(1)         DEFAULT '1',
  schedule_conf VARCHAR(64)     DEFAULT '',
  sub_tasks     JSONB,
  voice_prompt  VARCHAR(255)    DEFAULT '',
  guide_image   VARCHAR(255)    DEFAULT '',
  status        CHAR(1)         DEFAULT '0',
  create_dept   INT8            DEFAULT NULL,
  create_by     INT8            DEFAULT NULL,
  create_time   TIMESTAMP       DEFAULT NULL,
  update_by     INT8            DEFAULT NULL,
  update_time   TIMESTAMP       DEFAULT NULL,
  del_flag      CHAR(1)         DEFAULT '0',
  PRIMARY KEY (id)
);
COMMENT ON TABLE ss_task IS '任务配置表';


-- ----------------------------
-- 3. 任务执行记录表 (Optimized)
-- ----------------------------
DROP TABLE IF EXISTS ss_task_log;
CREATE TABLE ss_task_log (
  id            INT8            NOT NULL,
  tenant_id     VARCHAR(20)     DEFAULT '000000',
  task_id       INT8            NOT NULL,
  child_id      INT8            NOT NULL,
  finish_time   TIMESTAMP       DEFAULT NULL,
  status        CHAR(1)         DEFAULT '0',
  proof         VARCHAR(500)    DEFAULT '',
  reward_snap   INT             DEFAULT 0,
  title_snap    VARCHAR(128)    DEFAULT '',
  create_time   TIMESTAMP       DEFAULT NULL,
  PRIMARY KEY (id)
);
COMMENT ON TABLE ss_task_log IS '任务执行记录表';
COMMENT ON COLUMN ss_task_log.reward_snap IS '实际奖励星星快照';
COMMENT ON COLUMN ss_task_log.title_snap IS '任务标题快照';


-- ----------------------------
-- 4. 奖励配置表
-- ----------------------------
DROP TABLE IF EXISTS ss_reward;
CREATE TABLE ss_reward (
  id            INT8            NOT NULL,
  tenant_id     VARCHAR(20)     DEFAULT '000000',
  child_id      INT8            NOT NULL,
  name          VARCHAR(128)    NOT NULL,
  icon          VARCHAR(255)    DEFAULT '',
  star_cost     INT             DEFAULT 10,
  stock         INT             DEFAULT -1,
  status        CHAR(1)         DEFAULT '0',
  create_dept   INT8            DEFAULT NULL,
  create_by     INT8            DEFAULT NULL,
  create_time   TIMESTAMP       DEFAULT NULL,
  update_by     INT8            DEFAULT NULL,
  update_time   TIMESTAMP       DEFAULT NULL,
  del_flag      CHAR(1)         DEFAULT '0',
  PRIMARY KEY (id)
);
COMMENT ON TABLE ss_reward IS '实物奖励配置表';


-- ----------------------------
-- 5. 奖励兑换记录表
-- ----------------------------
DROP TABLE IF EXISTS ss_reward_exchange;
CREATE TABLE ss_reward_exchange (
  id            INT8            NOT NULL,
  tenant_id     VARCHAR(20)     DEFAULT '000000',
  reward_id     INT8            NOT NULL,
  child_id      INT8            NOT NULL,
  reward_snap   VARCHAR(500)    DEFAULT '',
  cost          INT             NOT NULL,
  exchange_time TIMESTAMP       DEFAULT NULL,
  status        CHAR(1)         DEFAULT '0',
  update_by     INT8            DEFAULT NULL,
  update_time   TIMESTAMP       DEFAULT NULL,
  PRIMARY KEY (id)
);
COMMENT ON TABLE ss_reward_exchange IS '奖励兑换记录表';


-- ----------------------------
-- 6. 星星流水记录表
-- ----------------------------
DROP TABLE IF EXISTS ss_star_record;
CREATE TABLE ss_star_record (
  id            INT8            NOT NULL,
  tenant_id     VARCHAR(20)     DEFAULT '000000',
  child_id      INT8            NOT NULL,
  amount        INT             NOT NULL,
  reason        VARCHAR(128)    DEFAULT '',
  source_type   CHAR(1)         NOT NULL,
  source_id     INT8            DEFAULT 0,
  create_time   TIMESTAMP       DEFAULT NULL,
  PRIMARY KEY (id)
);
COMMENT ON TABLE ss_star_record IS '星星流水记录表';


-- ----------------------------
-- 7. 硬件设备绑定表 (Optimized)
-- ----------------------------
DROP TABLE IF EXISTS ss_device;
CREATE TABLE ss_device (
  id            INT8            NOT NULL,
  tenant_id     VARCHAR(20)     DEFAULT '000000',
  serial_number VARCHAR(64)     NOT NULL,
  child_id      INT8            DEFAULT NULL,
  status        CHAR(1)         DEFAULT '0',
  settings      JSONB,
  battery_level INT             DEFAULT 0,
  last_active   TIMESTAMP       DEFAULT NULL,
  fw_version    VARCHAR(32)     DEFAULT '',
  create_dept   INT8            DEFAULT NULL,
  create_by     INT8            DEFAULT NULL,
  create_time   TIMESTAMP       DEFAULT NULL,
  update_by     INT8            DEFAULT NULL,
  update_time   TIMESTAMP       DEFAULT NULL,
  remark        VARCHAR(500)    DEFAULT NULL,
  PRIMARY KEY (id)
);
COMMENT ON TABLE ss_device IS '硬件设备表';
COMMENT ON COLUMN ss_device.settings IS '设备配置(JSON)';
COMMENT ON COLUMN ss_device.battery_level IS '当前电量';


-- ----------------------------
-- 8. 情绪记录表
-- ----------------------------
DROP TABLE IF EXISTS ss_emotion_record;
CREATE TABLE ss_emotion_record (
  id            INT8            NOT NULL,
  tenant_id     VARCHAR(20)     DEFAULT '000000',
  child_id      INT8            NOT NULL,
  mood_level    INT             DEFAULT 3,
  mood_type     VARCHAR(32)     DEFAULT '',
  description   VARCHAR(500)    DEFAULT '',
  voice_url     VARCHAR(255)    DEFAULT '',
  parent_feedback VARCHAR(500)  DEFAULT '',
  is_read       CHAR(1)         DEFAULT '0',
  record_time   TIMESTAMP       DEFAULT NULL,
  create_time   TIMESTAMP       DEFAULT NULL,
  PRIMARY KEY (id)
);
COMMENT ON TABLE ss_emotion_record IS '情绪记录表';


-- ----------------------------
-- 9. 知识卡片表
-- ----------------------------
DROP TABLE IF EXISTS ss_knowledge_card;
CREATE TABLE ss_knowledge_card (
  id            INT8            NOT NULL,
  tenant_id     VARCHAR(20)     DEFAULT '000000',
  title         VARCHAR(128)    NOT NULL,
  summary       VARCHAR(255)    DEFAULT '',
  content       TEXT,
  cover_url     VARCHAR(255)    DEFAULT '',
  category      VARCHAR(32)     DEFAULT '',
  tags          JSONB,
  status        CHAR(1)         DEFAULT '0',
  create_dept   INT8            DEFAULT NULL,
  create_by     INT8            DEFAULT NULL,
  create_time   TIMESTAMP       DEFAULT NULL,
  update_by     INT8            DEFAULT NULL,
  update_time   TIMESTAMP       DEFAULT NULL,
  del_flag      CHAR(1)         DEFAULT '0',
  PRIMARY KEY (id)
);
COMMENT ON TABLE ss_knowledge_card IS '父母学堂知识卡片表';


-- ----------------------------
-- 10. 游戏物品表
-- ----------------------------
DROP TABLE IF EXISTS ss_game_item;
CREATE TABLE ss_game_item (
  id            INT8            NOT NULL,
  tenant_id     VARCHAR(20)     DEFAULT '000000',
  name          VARCHAR(64)     NOT NULL,
  icon          VARCHAR(255)    DEFAULT '',
  category      VARCHAR(32)     NOT NULL,
  price         INT             DEFAULT 0,
  unlock_level  INT             DEFAULT 1,
  is_default    CHAR(1)         DEFAULT '0',
  status        CHAR(1)         DEFAULT '0',
  create_by     INT8            DEFAULT NULL,
  create_time   TIMESTAMP       DEFAULT NULL,
  PRIMARY KEY (id)
);
COMMENT ON TABLE ss_game_item IS '游戏物品(Avatar)配置表';

DROP TABLE IF EXISTS ss_child_item;
CREATE TABLE ss_child_item (
  id            INT8            NOT NULL,
  tenant_id     VARCHAR(20)     DEFAULT '000000',
  child_id      INT8            NOT NULL,
  item_id       INT8            NOT NULL,
  is_equipped   CHAR(1)         DEFAULT '0',
  obtain_time   TIMESTAMP       DEFAULT NULL,
  PRIMARY KEY (id)
);
COMMENT ON TABLE ss_child_item IS '儿童已拥有物品表';


-- ----------------------------
-- 11. 成就系统表
-- ----------------------------
DROP TABLE IF EXISTS ss_achievement;
CREATE TABLE ss_achievement (
  id            INT8            NOT NULL,
  tenant_id     VARCHAR(20)     DEFAULT '000000',
  name          VARCHAR(64)     NOT NULL,
  icon_url      VARCHAR(255)    DEFAULT '',
  condition_type VARCHAR(32)    NOT NULL,
  threshold     INT             DEFAULT 0,
  reward_stars  INT             DEFAULT 0,
  status        CHAR(1)         DEFAULT '0',
  create_by     INT8            DEFAULT NULL,
  create_time   TIMESTAMP       DEFAULT NULL,
  PRIMARY KEY (id)
);
COMMENT ON TABLE ss_achievement IS '成就/勋章定义表';

DROP TABLE IF EXISTS ss_child_achievement;
CREATE TABLE ss_child_achievement (
  id            INT8            NOT NULL,
  tenant_id     VARCHAR(20)     DEFAULT '000000',
  child_id      INT8            NOT NULL,
  achievement_id INT8           NOT NULL,
  current_val   INT             DEFAULT 0,
  status        CHAR(1)         DEFAULT '0',
  unlock_time   TIMESTAMP       DEFAULT NULL,
  PRIMARY KEY (id)
);
COMMENT ON TABLE ss_child_achievement IS '儿童成就进度表';


-- ----------------------------
-- 12. 任务预设库
-- ----------------------------
DROP TABLE IF EXISTS ss_task_preset;
CREATE TABLE ss_task_preset (
  id            INT8            NOT NULL,
  tenant_id     VARCHAR(20)     DEFAULT '000000',
  title         VARCHAR(128)    NOT NULL,
  icon          VARCHAR(255)    DEFAULT '',
  category      VARCHAR(32)     DEFAULT '',
  sub_tasks     JSONB,
  difficulty    INT             DEFAULT 1,
  is_system     CHAR(1)         DEFAULT '1',
  create_by     INT8            DEFAULT NULL,
  create_time   TIMESTAMP       DEFAULT NULL,
  status        CHAR(1)         DEFAULT '0',
  PRIMARY KEY (id)
);
COMMENT ON TABLE ss_task_preset IS '场景化任务预设库';


-- ----------------------------
-- 13. 知识互动表
-- ----------------------------
DROP TABLE IF EXISTS ss_knowledge_user_rel;
CREATE TABLE ss_knowledge_user_rel (
  id            INT8            NOT NULL,
  tenant_id     VARCHAR(20)     DEFAULT '000000',
  user_id       INT8            NOT NULL,
  knowledge_id  INT8            NOT NULL,
  is_read       CHAR(1)         DEFAULT '0',
  is_favorite   CHAR(1)         DEFAULT '0',
  read_time     TIMESTAMP       DEFAULT NULL,
  PRIMARY KEY (id)
);
COMMENT ON TABLE ss_knowledge_user_rel IS '家长与知识内容关联表 (收藏/已读)';


-- ----------------------------
-- 14. 等级成长配置表
-- ----------------------------
DROP TABLE IF EXISTS ss_level_config;
CREATE TABLE ss_level_config (
  level         INT             NOT NULL,
  tenant_id     VARCHAR(20)     DEFAULT '000000',
  title         VARCHAR(64)     NOT NULL,
  min_stars     INT             DEFAULT 0,
  unlock_feature JSONB,
  reward_package JSONB,
  create_by     INT8            DEFAULT NULL,
  create_time   TIMESTAMP       DEFAULT NULL,
  update_by     INT8            DEFAULT NULL,
  update_time   TIMESTAMP       DEFAULT NULL,
  PRIMARY KEY (level)
);
COMMENT ON TABLE ss_level_config IS '等级成长配置表';


-- ----------------------------
-- 15. 家庭成员关联表 (New)
-- ----------------------------
DROP TABLE IF EXISTS ss_family_member;
CREATE TABLE ss_family_member (
  id            INT8            NOT NULL,
  tenant_id     VARCHAR(20)     DEFAULT '000000',
  child_id      INT8            NOT NULL,
  user_id       INT8            NOT NULL,
  role          VARCHAR(32)     DEFAULT '', -- 爸爸/妈妈
  permissions   JSONB,                      -- 权限配置
  create_time   TIMESTAMP       DEFAULT NULL,
  PRIMARY KEY (id)
);
COMMENT ON TABLE ss_family_member IS '家庭成员关联表';


-- ----------------------------
-- 16. 设备运维日志表 (New)
-- ----------------------------
DROP TABLE IF EXISTS ss_device_log;
CREATE TABLE ss_device_log (
  id            INT8            NOT NULL,
  tenant_id     VARCHAR(20)     DEFAULT '000000',
  device_id     INT8            NOT NULL,
  event_type    VARCHAR(32)     NOT NULL, -- ERROR, WARN, INFO
  event_data    JSONB,
  create_time   TIMESTAMP       DEFAULT NULL,
  PRIMARY KEY (id)
);
COMMENT ON TABLE ss_device_log IS '设备运维日志表';
