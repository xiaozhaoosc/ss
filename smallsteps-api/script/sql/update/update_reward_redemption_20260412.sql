-- 奖励兑换记录表 (PostgreSQL)
-- 对应 Java 实体: ParentRewardRedemption
-- 日期: 2026-04-12

CREATE TABLE IF NOT EXISTS ss_parent_reward_redemption (
  redemption_id     bigint          NOT NULL,
  reward_id         bigint          NOT NULL,
  user_id           bigint          NOT NULL,
  points_cost       integer         DEFAULT 0,
  status            char(1)         DEFAULT '0', -- 0:待审批 1:已批准 2:已拒绝
  reason            varchar(500)    DEFAULT NULL, -- 拒绝理由
  create_dept       bigint          DEFAULT NULL, -- 创建部门
  create_by         bigint          DEFAULT NULL,
  create_time       timestamp       DEFAULT NULL,
  update_by         bigint          DEFAULT NULL,
  update_time       timestamp       DEFAULT NULL,
  PRIMARY KEY (redemption_id)
);

COMMENT ON TABLE ss_parent_reward_redemption IS '奖励兑换记录表';
COMMENT ON COLUMN ss_parent_reward_redemption.redemption_id IS '兑换ID';
COMMENT ON COLUMN ss_parent_reward_redemption.reward_id IS '奖励ID';
COMMENT ON COLUMN ss_parent_reward_redemption.user_id IS '用户ID';
COMMENT ON COLUMN ss_parent_reward_redemption.points_cost IS '消耗积分';
COMMENT ON COLUMN ss_parent_reward_redemption.status IS '状态(0:待审批 1:已批准 2:已拒绝)';
COMMENT ON COLUMN ss_parent_reward_redemption.reason IS '拒绝理由';
COMMENT ON COLUMN ss_parent_reward_redemption.create_dept IS '创建部门';
