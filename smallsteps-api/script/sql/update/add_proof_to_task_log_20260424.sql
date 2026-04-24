-- Add proof column to ss_task_log table to store task completion evidence (images/data)
-- Date: 2026-04-24
-- Author: Antigravity

ALTER TABLE ss_task_log ADD COLUMN IF NOT EXISTS proof VARCHAR(500);

COMMENT ON COLUMN ss_task_log.proof IS '任务证明图片/资料';
