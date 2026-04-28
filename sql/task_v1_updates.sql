-- Small Steps V1 Updates - Shadow Observer & Task Templates
-- 本脚本用于补全影子观察者所需的情绪记录表及任务模板数据结构

-- 1. 情绪记录表 (ss_emotion_record)
CREATE TABLE IF NOT EXISTS ss_emotion_record (
    id BIGINT PRIMARY KEY,
    tenant_id VARCHAR(20) DEFAULT '000000',
    child_id BIGINT NOT NULL,
    mood_level INTEGER,
    mood_type VARCHAR(50),
    description VARCHAR(500),
    voice_url VARCHAR(255),
    parent_feedback VARCHAR(500),
    is_read CHAR(1) DEFAULT '0',
    record_time TIMESTAMP,
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE ss_emotion_record IS '儿童情绪记录表';
COMMENT ON COLUMN ss_emotion_record.mood_level IS '情绪等级 (1-5)';
COMMENT ON COLUMN ss_emotion_record.mood_type IS '情绪类型 (frustrated, calm, happy, etc.)';

-- 2. 任务模板表 (ss_task_template) 补全脚本
-- (如果表已存在，请检查字段是否匹配 com.kenzhao.smallsteps.common.ss.domain.TaskTemplate)
-- CREATE TABLE IF NOT EXISTS ss_task_template ( ... );

-- 3. 任务步骤模板表 (ss_task_step_template)
CREATE TABLE IF NOT EXISTS ss_task_step_template (
    step_template_id BIGINT PRIMARY KEY,
    template_id BIGINT NOT NULL,
    step_order INTEGER NOT NULL,
    content VARCHAR(500) NOT NULL,
    visual_hint VARCHAR(255),
    audio_hint VARCHAR(255)
);

-- 4. 导入初始模板数据示例 (仅供参考，详细数据请运行 task_templates.sql)
-- INSERT INTO ss_task_template (template_id, title, description, category, default_difficulty, default_prompt_level) ...
