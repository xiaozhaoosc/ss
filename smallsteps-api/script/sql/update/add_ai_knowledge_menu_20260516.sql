-- ---------------------------------------------------------
-- AI 知识库管理功能菜单及按钮权限初始化 SQL
-- Date: 2026-05-16
-- ---------------------------------------------------------
/common/upload 接口401，这个是公共接口不需要权限验证
-- 1. 添加“知识库管理”菜单 (作为 AI管理 4000 的子菜单)
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark)
VALUES (4006, '知识库管理', 4000, 4, 'knowledge', 'ai/knowledge/index', '', '1', '0', 'C', '0', '0', 'ai:knowledge:list', 'education', 103, 1, NOW(), NULL, NULL, 'AI知识库管理菜单')
ON CONFLICT (menu_id) DO UPDATE SET menu_name = EXCLUDED.menu_name, path = EXCLUDED.path, component = EXCLUDED.component, perms = EXCLUDED.perms, update_time = NOW();

-- 2. 添加相关按钮权限
-- 知识库查询
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark)
VALUES (4060, '知识库查询', 4006, 1, '#', '', '', '1', '0', 'F', '0', '0', 'ai:knowledge:query', '#', 103, 1, NOW(), NULL, NULL, '')
ON CONFLICT (menu_id) DO UPDATE SET menu_name = EXCLUDED.menu_name, perms = EXCLUDED.perms, update_time = NOW();

-- 知识库新增
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark)
VALUES (4061, '知识库新增', 4006, 2, '#', '', '', '1', '0', 'F', '0', '0', 'ai:knowledge:add', '#', 103, 1, NOW(), NULL, NULL, '')
ON CONFLICT (menu_id) DO UPDATE SET menu_name = EXCLUDED.menu_name, perms = EXCLUDED.perms, update_time = NOW();

-- 知识库修改
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark)
VALUES (4062, '知识库修改', 4006, 3, '#', '', '', '1', '0', 'F', '0', '0', 'ai:knowledge:edit', '#', 103, 1, NOW(), NULL, NULL, '')
ON CONFLICT (menu_id) DO UPDATE SET menu_name = EXCLUDED.menu_name, perms = EXCLUDED.perms, update_time = NOW();

-- 知识库删除
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark)
VALUES (4063, '知识库删除', 4006, 4, '#', '', '', '1', '0', 'F', '0', '0', 'ai:knowledge:remove', '#', 103, 1, NOW(), NULL, NULL, '')
ON CONFLICT (menu_id) DO UPDATE SET menu_name = EXCLUDED.menu_name, perms = EXCLUDED.perms, update_time = NOW();

-- 知识库向量同步
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark)
VALUES (4064, '知识库同步', 4006, 5, '#', '', '', '1', '0', 'F', '0', '0', 'ai:knowledge:sync', '#', 103, 1, NOW(), NULL, NULL, '')
ON CONFLICT (menu_id) DO UPDATE SET menu_name = EXCLUDED.menu_name, perms = EXCLUDED.perms, update_time = NOW();
