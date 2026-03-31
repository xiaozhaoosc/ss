-- 积分余额表
CREATE TABLE IF NOT EXISTS ss_child_score (
  user_id           bigint          NOT NULL,
  balance           integer         DEFAULT 0,
  total_earned      integer         DEFAULT 0,
  update_time       timestamp       DEFAULT NULL,
  PRIMARY KEY (user_id)
);
COMMENT ON TABLE ss_child_score IS '儿童积分余额表';
COMMENT ON COLUMN ss_child_score.user_id IS '用户ID';
COMMENT ON COLUMN ss_child_score.balance IS '当前余额';
COMMENT ON COLUMN ss_child_score.total_earned IS '累计获得';
COMMENT ON COLUMN ss_child_score.update_time IS '更新时间';

-- 积分流水表
CREATE TABLE IF NOT EXISTS ss_score_history (
  id                bigint          NOT NULL ,
  user_id           bigint          NOT NULL,
  amount            integer         NOT NULL,
  type              char(1)         DEFAULT '1', -- 1: Earn, 2: Spend
  source_id         bigint          DEFAULT NULL, -- TaskId or RewardId
  reason            varchar(255)    DEFAULT '',
  create_time       timestamp       DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id)
);
COMMENT ON TABLE ss_score_history IS '积分流水表';
COMMENT ON COLUMN ss_score_history.type IS '类型(1:获取 2:消费)';
