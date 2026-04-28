-- 家庭邀请功能数据库脚本
-- 日期: 2026-04-28
-- 说明: 创建家庭邀请表和家庭加入申请表

-- 家庭邀请表
CREATE TABLE IF NOT EXISTS ss_family_invite (
    invite_id          BIGINT          NOT NULL AUTO_INCREMENT PRIMARY KEY,
    dept_id            BIGINT          NOT NULL COMMENT '家庭部门ID',
    invite_code        VARCHAR(16)     NOT NULL UNIQUE COMMENT '邀请码',
    creator_id         BIGINT          NOT NULL COMMENT '创建者ID',
    expires_at         TIMESTAMP       NOT NULL COMMENT '过期时间',
    max_uses           INT             DEFAULT 1 COMMENT '最大使用次数',
    used_count         INT             DEFAULT 0 COMMENT '已使用次数',
    status             CHAR(1)         DEFAULT '0' COMMENT '状态(0有效 1失效)',
    del_flag           CHAR(1)         DEFAULT '0' COMMENT '删除标志',
    create_time        TIMESTAMP       DEFAULT CURRENT_TIMESTAMP,
    update_time        TIMESTAMP       DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_invite_code (invite_code),
    INDEX idx_dept_id (dept_id)
) COMMENT '家庭邀请表';

-- 家庭加入申请表
CREATE TABLE IF NOT EXISTS ss_family_join_request (
    request_id         BIGINT          NOT NULL AUTO_INCREMENT PRIMARY KEY,
    invite_code        VARCHAR(16)     NOT NULL COMMENT '邀请码',
    applicant_id       BIGINT          NOT NULL COMMENT '申请人ID',
    target_dept_id     BIGINT          NOT NULL COMMENT '目标家庭ID',
    current_dept_id    BIGINT          COMMENT '原家庭ID',
    status             CHAR(1)         DEFAULT '0' COMMENT '状态(0待审核 1已通过 2已拒绝)',
    del_flag           CHAR(1)         DEFAULT '0' COMMENT '删除标志',
    create_time        TIMESTAMP       DEFAULT CURRENT_TIMESTAMP,
    update_time        TIMESTAMP       DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_applicant_id (applicant_id),
    INDEX idx_status (status)
) COMMENT '家庭加入申请表';