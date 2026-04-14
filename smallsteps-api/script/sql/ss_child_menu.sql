-- ----------------------------
-- 儿童管理菜单及权限 (PostgreSQL)
-- 手动指定 ID
-- ----------------------------
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
VALUES (4000, '儿童管理', 0, 10, 'child', 'ss/child/index', '1', '0', 'C', '0', '0', 'ss:child:list', 'peoples', 1, current_timestamp, '儿童管理菜单');

INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
VALUES (4001, '儿童查询', 4000, 1, '#', '', '1', '0', 'F', '0', '0', 'ss:child:query', '#', 1, current_timestamp, '');

INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
VALUES (4002, '儿童新增', 4000, 2, '#', '', '1', '0', 'F', '0', '0', 'ss:child:add', '#', 1, current_timestamp, '');

INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
VALUES (4003, '儿童修改', 4000, 3, '#', '', '1', '0', 'F', '0', '0', 'ss:child:edit', '#', 1, current_timestamp, '');

INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
VALUES (4004, '儿童删除', 4000, 4, '#', '', '1', '0', 'F', '0', '0', 'ss:child:remove', '#', 1, current_timestamp, '');
