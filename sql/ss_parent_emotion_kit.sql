-- ==========================================
-- Table structure for ss_parent_emotion_kit
-- ==========================================
CREATE TABLE IF NOT EXISTS ss_parent_emotion_kit (
    id            BIGSERIAL PRIMARY KEY,           -- 主键ID (递增BIGINT)
    scenario      VARCHAR(255) NOT NULL,          -- 适用情绪场景
    strategies    TEXT NOT NULL,                  -- 心理辅导策略
    
    -- 公共审计/状态字段 (同若依/Ruoyi标准)
    status        CHAR(1)       DEFAULT '0',       -- 状态 (0正常 1停用)
    del_flag      CHAR(1)       DEFAULT '0',       -- 删除标志 (0代表存在 2代表删除)
    create_by     VARCHAR(64)   DEFAULT NULL,      -- 创建者
    create_time   TIMESTAMP     DEFAULT NULL,      -- 创建时间
    update_by     VARCHAR(64)   DEFAULT NULL,      -- 更新者
    update_time   TIMESTAMP     DEFAULT NULL,      -- 更新时间
    remark        VARCHAR(500)  DEFAULT NULL       -- 备注
);

-- ==========================================
-- Table and Column Comments (PostgreSQL 规范)
-- ==========================================
COMMENT ON TABLE ss_parent_emotion_kit IS '家长端情绪急救包手册';
COMMENT ON COLUMN ss_parent_emotion_kit.id IS '主键';
COMMENT ON COLUMN ss_parent_emotion_kit.scenario IS '适用情绪场景';
COMMENT ON COLUMN ss_parent_emotion_kit.strategies IS '心理辅导策略';
COMMENT ON COLUMN ss_parent_emotion_kit.status IS '状态 (0正常 1停用)';
COMMENT ON COLUMN ss_parent_emotion_kit.del_flag IS '删除标志 (0代表存在 2代表删除)';
COMMENT ON COLUMN ss_parent_emotion_kit.create_by IS '创建者';
COMMENT ON COLUMN ss_parent_emotion_kit.create_time IS '创建时间';
COMMENT ON COLUMN ss_parent_emotion_kit.update_by IS '更新者';
COMMENT ON COLUMN ss_parent_emotion_kit.update_time IS '更新时间';
COMMENT ON COLUMN ss_parent_emotion_kit.remark IS '备注';
