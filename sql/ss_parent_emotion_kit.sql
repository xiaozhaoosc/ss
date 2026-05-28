-- ===================================================
-- Table structure for ss_parent_emotion_kit (对齐后端实体与XML)
-- ===================================================
DROP TABLE IF EXISTS ss_parent_emotion_kit;

CREATE TABLE ss_parent_emotion_kit (
    -- 主键 (后端 Java 实体中对应 @TableId 的 kitId 属性)
    kit_id        BIGSERIAL PRIMARY KEY,           
    
    -- 核心业务字段 (对齐 ParentEmotionKit 实体类属性)
    child_id      BIGINT NOT NULL,                 -- 孩子ID (对应 childId)
    kit_name      VARCHAR(255) NOT NULL,           -- 急救包名称/适用场景 (对应 kitName / scenario)
    emotion_type  INT NOT NULL,                    -- 情绪类型 1-5 (对应 emotionType)
    content       TEXT NOT NULL,                   -- 辅导策略内容 (对应 content / strategies)
    
    -- 公共审计/状态字段 (同若依/Ruoyi标准，继承自 BaseEntity)
    status        INT          DEFAULT 1,          -- 状态 (0-禁用, 1-启用)
    create_by     VARCHAR(64)  DEFAULT NULL,       -- 创建者
    create_time   TIMESTAMP    DEFAULT NULL,       -- 创建时间
    update_by     VARCHAR(64)  DEFAULT NULL,       -- 更新者
    update_time   TIMESTAMP    DEFAULT NULL        -- 更新时间
);

-- ===================================================
-- Table and Column Comments (PostgreSQL 规范)
-- ===================================================
COMMENT ON TABLE ss_parent_emotion_kit IS '情绪急救包配置表';
COMMENT ON COLUMN ss_parent_emotion_kit.kit_id IS '急救包主键ID';
COMMENT ON COLUMN ss_parent_emotion_kit.child_id IS '关联的孩子档案ID';
COMMENT ON COLUMN ss_parent_emotion_kit.kit_name IS '急救包名称 (对应场景描述 scenario)';
COMMENT ON COLUMN ss_parent_emotion_kit.emotion_type IS '情绪类型 (1-开心, 2-难过, 3-愤怒, 4-焦虑, 5-平静)';
COMMENT ON COLUMN ss_parent_emotion_kit.content IS '辅导引导内容 (对应应对策略 strategies)';
COMMENT ON COLUMN ss_parent_emotion_kit.status IS '启用状态 (0-禁用, 1-启用)';
COMMENT ON COLUMN ss_parent_emotion_kit.create_by IS '创建者';
COMMENT ON COLUMN ss_parent_emotion_kit.create_time IS '创建时间';
COMMENT ON COLUMN ss_parent_emotion_kit.update_by IS '更新者';
COMMENT ON COLUMN ss_parent_emotion_kit.update_time IS '更新时间';
