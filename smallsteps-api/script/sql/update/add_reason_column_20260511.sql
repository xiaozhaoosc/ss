-- Add 'reason' column to reward redemption table
-- Date: 2026-05-11
-- Author: Antigravity

ALTER TABLE ss_parent_reward_redemption ADD COLUMN reason VARCHAR(500);
ALTER TABLE ss_parent_reward_redemption ADD COLUMN create_dept BIGINT;
COMMENT ON COLUMN ss_parent_reward_redemption.reason IS '拒绝理由';
COMMENT ON COLUMN ss_parent_reward_redemption.create_dept IS '创建部门';
