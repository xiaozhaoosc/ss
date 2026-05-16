CREATE TABLE sys_ai_knowledge (
    id BIGINT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    content_type VARCHAR(50) DEFAULT 'TEXT',
    content TEXT NOT NULL,
    keywords VARCHAR(500),
    status CHAR(1) DEFAULT '0',
    create_by VARCHAR(64),
    create_time TIMESTAMP,
    update_by VARCHAR(64),
    update_time TIMESTAMP,
    remark VARCHAR(500)
);

COMMENT ON TABLE sys_ai_knowledge IS 'AI Knowledge Base';
