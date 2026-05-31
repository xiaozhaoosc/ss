-- ===================================================
-- MinIO 地址迁移: 192.168.1.21:9000 → 10.8.0.1:9000
-- 执行前请先备份数据库！
-- ===================================================

-- 1. 更新 OSS 存储配置 (最关键的表，决定新文件上传地址)
UPDATE sys_oss_config
SET endpoint = '10.8.0.1:9000'
WHERE endpoint = '192.168.1.21:9000';

-- 2. 更新 OSS 文件记录中的 URL (sys_user.avatar 存的是 ossId，不需要改)
UPDATE sys_oss
SET url = REPLACE(url, '192.168.1.21:9000', '10.8.0.1:9000')
WHERE url LIKE '%192.168.1.21:9000%';

-- 3. 更新儿童头像 URL (ss_child.avatar_url 是 VARCHAR)
UPDATE ss_child
SET avatar_url = REPLACE(avatar_url, '192.168.1.21:9000', '10.8.0.1:9000')
WHERE avatar_url LIKE '%192.168.1.21:9000%';

-- 4. (可选) 更新操作日志中的 URL - 仅影响历史记录展示
-- UPDATE sys_oper_log
-- SET oper_param = REPLACE(oper_param, '192.168.1.21:9000', '10.8.0.1:9000')
-- WHERE oper_param LIKE '%192.168.1.21:9000%';
--
-- UPDATE sys_oper_log
-- SET json_result = REPLACE(json_result, '192.168.1.21:9000', '10.8.0.1:9000')
-- WHERE json_result LIKE '%192.168.1.21:9000%';
