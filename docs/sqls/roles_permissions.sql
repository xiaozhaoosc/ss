-- -------------------------------------------------------------------------------------------------------------------
-- Small Steps 角色与权限配置 (PostgreSQL)
-- Author: Antigravity
-- Date: 2026-02-06
-- Description: 家长和儿童角色的权限配置，包括角色定义、菜单权限和数据权限
-- -------------------------------------------------------------------------------------------------------------------

-- ========================================
-- 1. 角色定义
-- ========================================

-- 家长角色 (Parent Role)
-- role_id: 10 (避免与系统角色冲突)
-- role_key: parent (权限标识符)
-- data_scope: 5 (仅本人数据权限)
INSERT INTO sys_role VALUES(
  10, 
  '000000', 
  '家长', 
  'parent', 
  10, 
  '5',  -- 仅本人数据权限
  't', 
  't', 
  '0',  -- 正常状态
  '0',  -- 未删除
  103, 
  1, 
  now(), 
  null, 
  null, 
  '家长角色，可管理自己的孩子和任务'
) ON CONFLICT (role_id) DO UPDATE SET
  role_name = EXCLUDED.role_name,
  role_key = EXCLUDED.role_key,
  update_time = now();

-- 儿童角色 (Child Role)
-- role_id: 11
-- role_key: child (权限标识符)
-- data_scope: 5 (仅本人数据权限)
INSERT INTO sys_role VALUES(
  11, 
  '000000', 
  '儿童', 
  'child', 
  11, 
  '5',  -- 仅本人数据权限
  't', 
  't', 
  '0',  -- 正常状态
  '0',  -- 未删除
  103, 
  1, 
  now(), 
  null, 
  null, 
  '儿童角色，可查看任务和奖励'
) ON CONFLICT (role_id) DO UPDATE SET
  role_name = EXCLUDED.role_name,
  role_key = EXCLUDED.role_key,
  update_time = now();


-- ========================================
-- 2. 菜单定义 (Small Steps 业务菜单)
-- ========================================

-- 一级菜单：Small Steps 管理
INSERT INTO sys_menu VALUES(
  2000, 
  'Small Steps', 
  '0', 
  '10', 
  'smallsteps', 
  null, 
  '', 
  '1', 
  '0', 
  'M', 
  '0', 
  '0', 
  '', 
  'star', 
  103, 
  1, 
  now(), 
  null, 
  null, 
  'Small Steps 管理目录'
) ON CONFLICT (menu_id) DO UPDATE SET
  menu_name = EXCLUDED.menu_name,
  update_time = now();

-- 二级菜单：儿童管理
INSERT INTO sys_menu VALUES(
  2100, 
  '儿童管理', 
  '2000', 
  '1', 
  'child', 
  'smallsteps/child/index', 
  '', 
  '1', 
  '0', 
  'C', 
  '0', 
  '0', 
  'parent:child:list', 
  'user', 
  103, 
  1, 
  now(), 
  null, 
  null, 
  '儿童档案管理菜单'
) ON CONFLICT (menu_id) DO UPDATE SET
  menu_name = EXCLUDED.menu_name,
  perms = EXCLUDED.perms,
  update_time = now();

-- 二级菜单：任务管理
INSERT INTO sys_menu VALUES(
  2200, 
  '任务管理', 
  '2000', 
  '2', 
  'task', 
  'smallsteps/task/index', 
  '', 
  '1', 
  '0', 
  'C', 
  '0', 
  '0', 
  'parent:task:list', 
  'list', 
  103, 
  1, 
  now(), 
  null, 
  null, 
  '任务配置管理菜单'
) ON CONFLICT (menu_id) DO UPDATE SET
  menu_name = EXCLUDED.menu_name,
  perms = EXCLUDED.perms,
  update_time = now();

-- 二级菜单：奖励管理
INSERT INTO sys_menu VALUES(
  2300, 
  '奖励管理', 
  '2000', 
  '3', 
  'reward', 
  'smallsteps/reward/index', 
  '', 
  '1', 
  '0', 
  'C', 
  '0', 
  '0', 
  'parent:reward:list', 
  'gift', 
  103, 
  1, 
  now(), 
  null, 
  null, 
  '奖励配置管理菜单'
) ON CONFLICT (menu_id) DO UPDATE SET
  menu_name = EXCLUDED.menu_name,
  perms = EXCLUDED.perms,
  update_time = now();

-- 二级菜单：情绪记录
INSERT INTO sys_menu VALUES(
  2400, 
  '情绪记录', 
  '2000', 
  '4', 
  'emotion', 
  'smallsteps/emotion/index', 
  '', 
  '1', 
  '0', 
  'C', 
  '0', 
  '0', 
  'parent:emotion:list', 
  'smile', 
  103, 
  1, 
  now(), 
  null, 
  null, 
  '情绪记录查看菜单'
) ON CONFLICT (menu_id) DO UPDATE SET
  menu_name = EXCLUDED.menu_name,
  perms = EXCLUDED.perms,
  update_time = now();

-- 二级菜单：设备管理
INSERT INTO sys_menu VALUES(
  2500, 
  '设备管理', 
  '2000', 
  '5', 
  'device', 
  'smallsteps/device/index', 
  '', 
  '1', 
  '0', 
  'C', 
  '0', 
  '0', 
  'parent:device:list', 
  'phone', 
  103, 
  1, 
  now(), 
  null, 
  null, 
  '硬件设备管理菜单'
) ON CONFLICT (menu_id) DO UPDATE SET
  menu_name = EXCLUDED.menu_name,
  perms = EXCLUDED.perms,
  update_time = now();

-- 二级菜单：知识学堂
INSERT INTO sys_menu VALUES(
  2600, 
  '知识学堂', 
  '2000', 
  '6', 
  'knowledge', 
  'smallsteps/knowledge/index', 
  '', 
  '1', 
  '0', 
  'C', 
  '0', 
  '0', 
  'parent:knowledge:list', 
  'education', 
  103, 
  1, 
  now(), 
  null, 
  null, 
  '父母学堂知识库菜单'
) ON CONFLICT (menu_id) DO UPDATE SET
  menu_name = EXCLUDED.menu_name,
  perms = EXCLUDED.perms,
  update_time = now();

-- 二级菜单：亲子契约
INSERT INTO sys_menu VALUES(
  2700, 
  '亲子契约', 
  '2000', 
  '7', 
  'contract', 
  'smallsteps/contract/index', 
  '', 
  '1', 
  '0', 
  'C', 
  '0', 
  '0', 
  'parent:contract:list', 
  'documentation', 
  103, 
  1, 
  now(), 
  null, 
  null, 
  '亲子契约管理菜单'
) ON CONFLICT (menu_id) DO UPDATE SET
  menu_name = EXCLUDED.menu_name,
  perms = EXCLUDED.perms,
  update_time = now();


-- ========================================
-- 3. 家长角色按钮权限 (Parent Role Permissions)
-- ========================================

-- 儿童管理按钮
INSERT INTO sys_menu VALUES(2101, '儿童查询', '2100', '1', '#', '', '', '1', '0', 'F', '0', '0', 'parent:child:query', '#', 103, 1, now(), null, null, '') ON CONFLICT (menu_id) DO NOTHING;
INSERT INTO sys_menu VALUES(2102, '儿童新增', '2100', '2', '#', '', '', '1', '0', 'F', '0', '0', 'parent:child:add', '#', 103, 1, now(), null, null, '') ON CONFLICT (menu_id) DO NOTHING;
INSERT INTO sys_menu VALUES(2103, '儿童修改', '2100', '3', '#', '', '', '1', '0', 'F', '0', '0', 'parent:child:edit', '#', 103, 1, now(), null, null, '') ON CONFLICT (menu_id) DO NOTHING;
INSERT INTO sys_menu VALUES(2104, '儿童删除', '2100', '4', '#', '', '', '1', '0', 'F', '0', '0', 'parent:child:remove', '#', 103, 1, now(), null, null, '') ON CONFLICT (menu_id) DO NOTHING;
INSERT INTO sys_menu VALUES(2105, '儿童导出', '2100', '5', '#', '', '', '1', '0', 'F', '0', '0', 'parent:child:export', '#', 103, 1, now(), null, null, '') ON CONFLICT (menu_id) DO NOTHING;

-- 任务管理按钮
INSERT INTO sys_menu VALUES(2201, '任务查询', '2200', '1', '#', '', '', '1', '0', 'F', '0', '0', 'parent:task:query', '#', 103, 1, now(), null, null, '') ON CONFLICT (menu_id) DO NOTHING;
INSERT INTO sys_menu VALUES(2202, '任务新增', '2200', '2', '#', '', '', '1', '0', 'F', '0', '0', 'parent:task:add', '#', 103, 1, now(), null, null, '') ON CONFLICT (menu_id) DO NOTHING;
INSERT INTO sys_menu VALUES(2203, '任务修改', '2200', '3', '#', '', '', '1', '0', 'F', '0', '0', 'parent:task:edit', '#', 103, 1, now(), null, null, '') ON CONFLICT (menu_id) DO NOTHING;
INSERT INTO sys_menu VALUES(2204, '任务删除', '2200', '4', '#', '', '', '1', '0', 'F', '0', '0', 'parent:task:remove', '#', 103, 1, now(), null, null, '') ON CONFLICT (menu_id) DO NOTHING;
INSERT INTO sys_menu VALUES(2205, '任务导出', '2200', '5', '#', '', '', '1', '0', 'F', '0', '0', 'parent:task:export', '#', 103, 1, now(), null, null, '') ON CONFLICT (menu_id) DO NOTHING;

-- 奖励管理按钮
INSERT INTO sys_menu VALUES(2301, '奖励查询', '2300', '1', '#', '', '', '1', '0', 'F', '0', '0', 'parent:reward:query', '#', 103, 1, now(), null, null, '') ON CONFLICT (menu_id) DO NOTHING;
INSERT INTO sys_menu VALUES(2302, '奖励新增', '2300', '2', '#', '', '', '1', '0', 'F', '0', '0', 'parent:reward:add', '#', 103, 1, now(), null, null, '') ON CONFLICT (menu_id) DO NOTHING;
INSERT INTO sys_menu VALUES(2303, '奖励修改', '2300', '3', '#', '', '', '1', '0', 'F', '0', '0', 'parent:reward:edit', '#', 103, 1, now(), null, null, '') ON CONFLICT (menu_id) DO NOTHING;
INSERT INTO sys_menu VALUES(2304, '奖励删除', '2300', '4', '#', '', '', '1', '0', 'F', '0', '0', 'parent:reward:remove', '#', 103, 1, now(), null, null, '') ON CONFLICT (menu_id) DO NOTHING;
INSERT INTO sys_menu VALUES(2305, '奖励导出', '2300', '5', '#', '', '', '1', '0', 'F', '0', '0', 'parent:reward:export', '#', 103, 1, now(), null, null, '') ON CONFLICT (menu_id) DO NOTHING;

-- 情绪记录按钮
INSERT INTO sys_menu VALUES(2401, '情绪查询', '2400', '1', '#', '', '', '1', '0', 'F', '0', '0', 'parent:emotion:query', '#', 103, 1, now(), null, null, '') ON CONFLICT (menu_id) DO NOTHING;
INSERT INTO sys_menu VALUES(2402, '情绪反馈', '2400', '2', '#', '', '', '1', '0', 'F', '0', '0', 'parent:emotion:feedback', '#', 103, 1, now(), null, null, '') ON CONFLICT (menu_id) DO NOTHING;
INSERT INTO sys_menu VALUES(2403, '情绪导出', '2400', '3', '#', '', '', '1', '0', 'F', '0', '0', 'parent:emotion:export', '#', 103, 1, now(), null, null, '') ON CONFLICT (menu_id) DO NOTHING;

-- 设备管理按钮
INSERT INTO sys_menu VALUES(2501, '设备查询', '2500', '1', '#', '', '', '1', '0', 'F', '0', '0', 'parent:device:query', '#', 103, 1, now(), null, null, '') ON CONFLICT (menu_id) DO NOTHING;
INSERT INTO sys_menu VALUES(2502, '设备绑定', '2500', '2', '#', '', '', '1', '0', 'F', '0', '0', 'parent:device:bind', '#', 103, 1, now(), null, null, '') ON CONFLICT (menu_id) DO NOTHING;
INSERT INTO sys_menu VALUES(2503, '设备解绑', '2500', '3', '#', '', '', '1', '0', 'F', '0', '0', 'parent:device:unbind', '#', 103, 1, now(), null, null, '') ON CONFLICT (menu_id) DO NOTHING;
INSERT INTO sys_menu VALUES(2504, '设备配置', '2500', '4', '#', '', '', '1', '0', 'F', '0', '0', 'parent:device:config', '#', 103, 1, now(), null, null, '') ON CONFLICT (menu_id) DO NOTHING;

-- 知识学堂按钮
INSERT INTO sys_menu VALUES(2601, '知识查询', '2600', '1', '#', '', '', '1', '0', 'F', '0', '0', 'parent:knowledge:query', '#', 103, 1, now(), null, null, '') ON CONFLICT (menu_id) DO NOTHING;
INSERT INTO sys_menu VALUES(2602, '知识收藏', '2600', '2', '#', '', '', '1', '0', 'F', '0', '0', 'parent:knowledge:favorite', '#', 103, 1, now(), null, null, '') ON CONFLICT (menu_id) DO NOTHING;

-- 亲子契约按钮
INSERT INTO sys_menu VALUES(2701, '契约查询', '2700', '1', '#', '', '', '1', '0', 'F', '0', '0', 'parent:contract:query', '#', 103, 1, now(), null, null, '') ON CONFLICT (menu_id) DO NOTHING;
INSERT INTO sys_menu VALUES(2702, '契约新增', '2700', '2', '#', '', '', '1', '0', 'F', '0', '0', 'parent:contract:add', '#', 103, 1, now(), null, null, '') ON CONFLICT (menu_id) DO NOTHING;
INSERT INTO sys_menu VALUES(2703, '契约修改', '2700', '3', '#', '', '', '1', '0', 'F', '0', '0', 'parent:contract:edit', '#', 103, 1, now(), null, null, '') ON CONFLICT (menu_id) DO NOTHING;
INSERT INTO sys_menu VALUES(2704, '契约删除', '2700', '4', '#', '', '', '1', '0', 'F', '0', '0', 'parent:contract:remove', '#', 103, 1, now(), null, null, '') ON CONFLICT (menu_id) DO NOTHING;


-- ========================================
-- 4. 儿童角色菜单 (Child Role Menus)
-- ========================================

-- 一级菜单：我的小步
INSERT INTO sys_menu VALUES(
  3000, 
  '我的小步', 
  '0', 
  '20', 
  'mysteps', 
  null, 
  '', 
  '1', 
  '0', 
  'M', 
  '0', 
  '0', 
  '', 
  'star', 
  103, 
  1, 
  now(), 
  null, 
  null, 
  '儿童端主菜单'
) ON CONFLICT (menu_id) DO UPDATE SET
  menu_name = EXCLUDED.menu_name,
  update_time = now();

-- 二级菜单：我的任务
INSERT INTO sys_menu VALUES(
  3100, 
  '我的任务', 
  '3000', 
  '1', 
  'mytask', 
  'child/task/index', 
  '', 
  '1', 
  '0', 
  'C', 
  '0', 
  '0', 
  'child:task:list', 
  'list', 
  103, 
  1, 
  now(), 
  null, 
  null, 
  '儿童任务查看菜单'
) ON CONFLICT (menu_id) DO UPDATE SET
  menu_name = EXCLUDED.menu_name,
  perms = EXCLUDED.perms,
  update_time = now();

-- 二级菜单：我的奖励
INSERT INTO sys_menu VALUES(
  3200, 
  '我的奖励', 
  '3000', 
  '2', 
  'myreward', 
  'child/reward/index', 
  '', 
  '1', 
  '0', 
  'C', 
  '0', 
  '0', 
  'child:reward:list', 
  'gift', 
  103, 
  1, 
  now(), 
  null, 
  null, 
  '儿童奖励查看菜单'
) ON CONFLICT (menu_id) DO UPDATE SET
  menu_name = EXCLUDED.menu_name,
  perms = EXCLUDED.perms,
  update_time = now();

-- 二级菜单：我的成就
INSERT INTO sys_menu VALUES(
  3300, 
  '我的成就', 
  '3000', 
  '3', 
  'achievement', 
  'child/achievement/index', 
  '', 
  '1', 
  '0', 
  'C', 
  '0', 
  '0', 
  'child:achievement:list', 
  'trophy', 
  103, 
  1, 
  now(), 
  null, 
  null, 
  '儿童成就查看菜单'
) ON CONFLICT (menu_id) DO UPDATE SET
  menu_name = EXCLUDED.menu_name,
  perms = EXCLUDED.perms,
  update_time = now();

-- 二级菜单：我的心情
INSERT INTO sys_menu VALUES(
  3400, 
  '我的心情', 
  '3000', 
  '4', 
  'myemotion', 
  'child/emotion/index', 
  '', 
  '1', 
  '0', 
  'C', 
  '0', 
  '0', 
  'child:emotion:list', 
  'smile', 
  103, 
  1, 
  now(), 
  null, 
  null, 
  '儿童情绪记录菜单'
) ON CONFLICT (menu_id) DO UPDATE SET
  menu_name = EXCLUDED.menu_name,
  perms = EXCLUDED.perms,
  update_time = now();


-- ========================================
-- 5. 儿童角色按钮权限 (Child Role Permissions)
-- ========================================

-- 我的任务按钮
INSERT INTO sys_menu VALUES(3101, '任务查询', '3100', '1', '#', '', '', '1', '0', 'F', '0', '0', 'child:task:query', '#', 103, 1, now(), null, null, '') ON CONFLICT (menu_id) DO NOTHING;
INSERT INTO sys_menu VALUES(3102, '任务完成', '3100', '2', '#', '', '', '1', '0', 'F', '0', '0', 'child:task:finish', '#', 103, 1, now(), null, null, '') ON CONFLICT (menu_id) DO NOTHING;
INSERT INTO sys_menu VALUES(3103, '上传证明', '3100', '3', '#', '', '', '1', '0', 'F', '0', '0', 'child:task:proof', '#', 103, 1, now(), null, null, '') ON CONFLICT (menu_id) DO NOTHING;

-- 我的奖励按钮
INSERT INTO sys_menu VALUES(3201, '奖励查询', '3200', '1', '#', '', '', '1', '0', 'F', '0', '0', 'child:reward:query', '#', 103, 1, now(), null, null, '') ON CONFLICT (menu_id) DO NOTHING;
INSERT INTO sys_menu VALUES(3202, '奖励兑换', '3200', '2', '#', '', '', '1', '0', 'F', '0', '0', 'child:reward:exchange', '#', 103, 1, now(), null, null, '') ON CONFLICT (menu_id) DO NOTHING;

-- 我的成就按钮
INSERT INTO sys_menu VALUES(3301, '成就查询', '3300', '1', '#', '', '', '1', '0', 'F', '0', '0', 'child:achievement:query', '#', 103, 1, now(), null, null, '') ON CONFLICT (menu_id) DO NOTHING;

-- 我的心情按钮
INSERT INTO sys_menu VALUES(3401, '心情查询', '3400', '1', '#', '', '', '1', '0', 'F', '0', '0', 'child:emotion:query', '#', 103, 1, now(), null, null, '') ON CONFLICT (menu_id) DO NOTHING;
INSERT INTO sys_menu VALUES(3402, '心情记录', '3400', '2', '#', '', '', '1', '0', 'F', '0', '0', 'child:emotion:add', '#', 103, 1, now(), null, null, '') ON CONFLICT (menu_id) DO NOTHING;


-- ========================================
-- 6. 家长角色菜单关联 (Parent Role Menu Mapping)
-- ========================================

-- 家长角色关联所有 parent:* 权限的菜单
-- 主菜单
INSERT INTO sys_role_menu VALUES (10, 2000) ON CONFLICT DO NOTHING;

-- 儿童管理
INSERT INTO sys_role_menu VALUES (10, 2100) ON CONFLICT DO NOTHING;
INSERT INTO sys_role_menu VALUES (10, 2101) ON CONFLICT DO NOTHING;
INSERT INTO sys_role_menu VALUES (10, 2102) ON CONFLICT DO NOTHING;
INSERT INTO sys_role_menu VALUES (10, 2103) ON CONFLICT DO NOTHING;
INSERT INTO sys_role_menu VALUES (10, 2104) ON CONFLICT DO NOTHING;
INSERT INTO sys_role_menu VALUES (10, 2105) ON CONFLICT DO NOTHING;

-- 任务管理
INSERT INTO sys_role_menu VALUES (10, 2200) ON CONFLICT DO NOTHING;
INSERT INTO sys_role_menu VALUES (10, 2201) ON CONFLICT DO NOTHING;
INSERT INTO sys_role_menu VALUES (10, 2202) ON CONFLICT DO NOTHING;
INSERT INTO sys_role_menu VALUES (10, 2203) ON CONFLICT DO NOTHING;
INSERT INTO sys_role_menu VALUES (10, 2204) ON CONFLICT DO NOTHING;
INSERT INTO sys_role_menu VALUES (10, 2205) ON CONFLICT DO NOTHING;

-- 奖励管理
INSERT INTO sys_role_menu VALUES (10, 2300) ON CONFLICT DO NOTHING;
INSERT INTO sys_role_menu VALUES (10, 2301) ON CONFLICT DO NOTHING;
INSERT INTO sys_role_menu VALUES (10, 2302) ON CONFLICT DO NOTHING;
INSERT INTO sys_role_menu VALUES (10, 2303) ON CONFLICT DO NOTHING;
INSERT INTO sys_role_menu VALUES (10, 2304) ON CONFLICT DO NOTHING;
INSERT INTO sys_role_menu VALUES (10, 2305) ON CONFLICT DO NOTHING;

-- 情绪记录
INSERT INTO sys_role_menu VALUES (10, 2400) ON CONFLICT DO NOTHING;
INSERT INTO sys_role_menu VALUES (10, 2401) ON CONFLICT DO NOTHING;
INSERT INTO sys_role_menu VALUES (10, 2402) ON CONFLICT DO NOTHING;
INSERT INTO sys_role_menu VALUES (10, 2403) ON CONFLICT DO NOTHING;

-- 设备管理
INSERT INTO sys_role_menu VALUES (10, 2500) ON CONFLICT DO NOTHING;
INSERT INTO sys_role_menu VALUES (10, 2501) ON CONFLICT DO NOTHING;
INSERT INTO sys_role_menu VALUES (10, 2502) ON CONFLICT DO NOTHING;
INSERT INTO sys_role_menu VALUES (10, 2503) ON CONFLICT DO NOTHING;
INSERT INTO sys_role_menu VALUES (10, 2504) ON CONFLICT DO NOTHING;

-- 知识学堂
INSERT INTO sys_role_menu VALUES (10, 2600) ON CONFLICT DO NOTHING;
INSERT INTO sys_role_menu VALUES (10, 2601) ON CONFLICT DO NOTHING;
INSERT INTO sys_role_menu VALUES (10, 2602) ON CONFLICT DO NOTHING;

-- 亲子契约
INSERT INTO sys_role_menu VALUES (10, 2700) ON CONFLICT DO NOTHING;
INSERT INTO sys_role_menu VALUES (10, 2701) ON CONFLICT DO NOTHING;
INSERT INTO sys_role_menu VALUES (10, 2702) ON CONFLICT DO NOTHING;
INSERT INTO sys_role_menu VALUES (10, 2703) ON CONFLICT DO NOTHING;
INSERT INTO sys_role_menu VALUES (10, 2704) ON CONFLICT DO NOTHING;


-- ========================================
-- 7. 儿童角色菜单关联 (Child Role Menu Mapping)
-- ========================================

-- 儿童角色关联所有 child:* 权限的菜单
-- 主菜单
INSERT INTO sys_role_menu VALUES (11, 3000) ON CONFLICT DO NOTHING;

-- 我的任务
INSERT INTO sys_role_menu VALUES (11, 3100) ON CONFLICT DO NOTHING;
INSERT INTO sys_role_menu VALUES (11, 3101) ON CONFLICT DO NOTHING;
INSERT INTO sys_role_menu VALUES (11, 3102) ON CONFLICT DO NOTHING;
INSERT INTO sys_role_menu VALUES (11, 3103) ON CONFLICT DO NOTHING;

-- 我的奖励
INSERT INTO sys_role_menu VALUES (11, 3200) ON CONFLICT DO NOTHING;
INSERT INTO sys_role_menu VALUES (11, 3201) ON CONFLICT DO NOTHING;
INSERT INTO sys_role_menu VALUES (11, 3202) ON CONFLICT DO NOTHING;

-- 我的成就
INSERT INTO sys_role_menu VALUES (11, 3300) ON CONFLICT DO NOTHING;
INSERT INTO sys_role_menu VALUES (11, 3301) ON CONFLICT DO NOTHING;

-- 我的心情
INSERT INTO sys_role_menu VALUES (11, 3400) ON CONFLICT DO NOTHING;
INSERT INTO sys_role_menu VALUES (11, 3401) ON CONFLICT DO NOTHING;
INSERT INTO sys_role_menu VALUES (11, 3402) ON CONFLICT DO NOTHING;


-- ========================================
-- 8. 权限说明文档
-- ========================================

/*
权限体系说明：

1. 家长角色 (parent)
   - role_id: 10
   - 权限前缀: parent:*
   - 数据范围: 仅本人数据 (data_scope=5)
   - 可访问模块:
     * 儿童管理 (parent:child:*)
     * 任务管理 (parent:task:*)
     * 奖励管理 (parent:reward:*)
     * 情绪记录 (parent:emotion:*)
     * 设备管理 (parent:device:*)
     * 知识学堂 (parent:knowledge:*)
     * 亲子契约 (parent:contract:*)

2. 儿童角色 (child)
   - role_id: 11
   - 权限前缀: child:*
   - 数据范围: 仅本人数据 (data_scope=5)
   - 可访问模块:
     * 我的任务 (child:task:*)
     * 我的奖励 (child:reward:*)
     * 我的成就 (child:achievement:*)
     * 我的心情 (child:emotion:*)

3. 权限匹配规则
   - 使用通配符 * 表示所有操作
   - 例如: parent:* 匹配所有 parent: 开头的权限
   - 例如: child:* 匹配所有 child: 开头的权限
   - 具体权限如: parent:task:list, child:reward:query

4. 使用方法
   - 在 Controller 中使用 @SaCheckPermission 注解
   - 例如: @SaCheckPermission("parent:task:list")
   - 或使用通配符: @SaCheckPermission("parent:*")
*/
