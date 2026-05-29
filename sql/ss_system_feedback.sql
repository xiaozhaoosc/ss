-- ===================================================
-- Table structure for ss_system_feedback (系统意见反馈表)
-- ===================================================
DROP TABLE IF EXISTS ss_system_feedback;

CREATE TABLE ss_system_feedback (
    feedback_id   BIGSERIAL PRIMARY KEY,           -- 反馈自增主键ID
    user_id       BIGINT NOT NULL,                 -- 提交反馈的用户ID (对应 sys_user.user_id)
    content       TEXT NOT NULL,                   -- 反馈详细文本内容
    img_urls      VARCHAR(1000) DEFAULT NULL,      -- 反馈附加图片链接 (逗号隔开，支持多图)
    status        CHAR(1)       DEFAULT '0',       -- 反馈状态 (0-未处理, 1-已处理)
    
    -- 公共审计/状态字段
    create_by     VARCHAR(64)   DEFAULT NULL,      -- 创建人/提交人
    create_time   TIMESTAMP     DEFAULT NULL,      -- 提交时间
    update_by     VARCHAR(64)   DEFAULT NULL,      -- 更新人/处理人
    update_time   TIMESTAMP     DEFAULT NULL,      -- 更新处理时间
    remark        VARCHAR(500)  DEFAULT NULL       -- 处理备注
);

-- ===================================================
-- Table and Column Comments (PostgreSQL 规范)
-- ===================================================
COMMENT ON TABLE ss_system_feedback IS '系统用户意见与问题反馈表';
COMMENT ON COLUMN ss_system_feedback.feedback_id IS '反馈主键ID';
COMMENT ON COLUMN ss_system_feedback.user_id IS '提交反馈的用户ID';
COMMENT ON COLUMN ss_system_feedback.content IS '反馈详细文本内容';
COMMENT ON COLUMN ss_system_feedback.img_urls IS '反馈附加图片链接，多张以逗号隔开';
COMMENT ON COLUMN ss_system_feedback.status IS '反馈状态 (0-未处理, 1-已处理)';
COMMENT ON COLUMN ss_system_feedback.create_by IS '创建人';
COMMENT ON COLUMN ss_system_feedback.create_time IS '提交时间';
COMMENT ON COLUMN ss_system_feedback.update_by IS '处理人';
COMMENT ON COLUMN ss_system_feedback.update_time IS '处理时间';
COMMENT ON COLUMN ss_system_feedback.remark IS '处理备注';

-- ===================================================
-- 自动向后台系统菜单表 sys_menu 中挂载“帮助与反馈”菜单 (挂载在“测试菜单”即ID=5下面，或者在SmallSteps下)
-- ===================================================
DELETE FROM sys_menu WHERE menu_id = 2000;
INSERT INTO sys_menu (
    menu_id, menu_name, parent_id, order_num, path, component, query_param, 
    is_frame, is_cache, menu_type, visible, status, perms, icon, 
    create_by, create_time, remark
) VALUES (
    2000, '帮助与反馈', 5, 8, 'feedback', 'smallsteps/feedback/index', '', 
    1, 0, 'C', 0, 0, 'smallsteps:feedback:list', 'message', 
    'admin', now(), '意见反馈菜单'
);
