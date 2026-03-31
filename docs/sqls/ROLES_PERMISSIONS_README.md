# Small Steps 角色与权限配置说明

## 📋 概述

本文档说明了 Small Steps 系统中家长和儿童两个核心角色的权限配置方案。

## 🎭 角色定义

### 1. 家长角色 (Parent)

- **角色ID**: `10`
- **角色标识**: `parent`
- **数据权限**: 仅本人数据 (data_scope=5)
- **描述**: 家长可以管理自己的孩子档案、配置任务和奖励、查看情绪记录、管理设备等

### 2. 儿童角色 (Child)

- **角色ID**: `11`
- **角色标识**: `child`
- **数据权限**: 仅本人数据 (data_scope=5)
- **描述**: 儿童可以查看自己的任务、奖励、成就，记录情绪等

## 🔐 权限体系

### 权限前缀规则

```
parent:*     - 家长角色的所有权限
child:*      - 儿童角色的所有权限
```

### 家长权限清单

| 模块 | 权限前缀 | 说明 |
|------|---------|------|
| 儿童管理 | `parent:child:*` | 增删改查儿童档案 |
| 任务管理 | `parent:task:*` | 配置和管理任务 |
| 奖励管理 | `parent:reward:*` | 配置和管理奖励 |
| 情绪记录 | `parent:emotion:*` | 查看和反馈情绪 |
| 设备管理 | `parent:device:*` | 绑定和配置设备 |
| 知识学堂 | `parent:knowledge:*` | 查看和收藏知识 |
| 亲子契约 | `parent:contract:*` | 管理亲子契约 |

### 儿童权限清单

| 模块 | 权限前缀 | 说明 |
|------|---------|------|
| 我的任务 | `child:task:*` | 查看和完成任务 |
| 我的奖励 | `child:reward:*` | 查看和兑换奖励 |
| 我的成就 | `child:achievement:*` | 查看成就进度 |
| 我的心情 | `child:emotion:*` | 记录和查看情绪 |

## 📦 安装步骤

### 1. 执行 SQL 脚本

```bash
# 连接到 PostgreSQL 数据库
psql -U postgres -d smallsteps

# 执行角色权限配置脚本
\i docs/sqls/roles_permissions.sql
```

### 2. 验证安装

```sql
-- 查看角色是否创建成功
SELECT role_id, role_name, role_key FROM sys_role WHERE role_id IN (10, 11);

-- 查看菜单是否创建成功
SELECT menu_id, menu_name, perms FROM sys_menu WHERE menu_id >= 2000 AND menu_id < 4000;

-- 查看角色菜单关联
SELECT r.role_name, m.menu_name, m.perms 
FROM sys_role_menu rm
JOIN sys_role r ON rm.role_id = r.role_id
JOIN sys_menu m ON rm.menu_id = m.menu_id
WHERE r.role_id IN (10, 11)
ORDER BY r.role_id, m.menu_id;
```

## 💻 代码使用示例

### 在 Controller 中使用权限注解

#### 家长端示例

```java
@RestController
@RequestMapping("/ssapi/parent/task")
public class ParentTaskController {
    
    // 查询任务列表 - 需要 parent:task:list 权限
    @SaCheckPermission("parent:task:list")
    @GetMapping("/list")
    public R<List<Task>> list() {
        // ...
    }
    
    // 新增任务 - 需要 parent:task:add 权限
    @SaCheckPermission("parent:task:add")
    @PostMapping
    public R<Void> add(@RequestBody Task task) {
        // ...
    }
    
    // 使用通配符 - 需要任何 parent:task:* 权限
    @SaCheckPermission("parent:task:*")
    @PutMapping
    public R<Void> edit(@RequestBody Task task) {
        // ...
    }
}
```

#### 儿童端示例

```java
@RestController
@RequestMapping("/ssapi/child/task")
public class ChildTaskController {
    
    // 查询我的任务 - 需要 child:task:list 权限
    @SaCheckPermission("child:task:list")
    @GetMapping("/my")
    public R<List<Task>> myTasks() {
        // ...
    }
    
    // 完成任务 - 需要 child:task:finish 权限
    @SaCheckPermission("child:task:finish")
    @PostMapping("/finish/{taskId}")
    public R<Void> finish(@PathVariable Long taskId) {
        // ...
    }
}
```

### 在代码中动态检查权限

```java
// 检查是否有家长权限
if (StpUtil.hasPermission("parent:*")) {
    // 执行家长操作
}

// 检查是否有儿童权限
if (StpUtil.hasPermission("child:*")) {
    // 执行儿童操作
}

// 检查具体权限
if (StpUtil.hasPermission("parent:task:add")) {
    // 可以新增任务
}
```

## 🔄 权限更新

如果需要添加新的权限或菜单，请按照以下步骤：

### 1. 添加新菜单

```sql
-- 添加新的二级菜单
INSERT INTO sys_menu VALUES(
  2800,  -- 新的菜单ID
  '新功能', 
  '2000',  -- 父菜单ID (Small Steps)
  '8',  -- 排序
  'newfeature', 
  'smallsteps/newfeature/index', 
  '', 
  '1', 
  '0', 
  'C', 
  '0', 
  '0', 
  'parent:newfeature:list',  -- 权限标识
  'icon-name', 
  103, 
  1, 
  now(), 
  null, 
  null, 
  '新功能菜单'
);
```

### 2. 添加按钮权限

```sql
-- 添加按钮权限
INSERT INTO sys_menu VALUES(2801, '新功能查询', '2800', '1', '#', '', '', '1', '0', 'F', '0', '0', 'parent:newfeature:query', '#', 103, 1, now(), null, null, '');
INSERT INTO sys_menu VALUES(2802, '新功能新增', '2800', '2', '#', '', '', '1', '0', 'F', '0', '0', 'parent:newfeature:add', '#', 103, 1, now(), null, null, '');
```

### 3. 关联到角色

```sql
-- 将新菜单关联到家长角色
INSERT INTO sys_role_menu VALUES (10, 2800);
INSERT INTO sys_role_menu VALUES (10, 2801);
INSERT INTO sys_role_menu VALUES (10, 2802);
```

## 🧪 测试权限

### 创建测试用户

```sql
-- 创建家长测试用户
INSERT INTO sys_user VALUES(
  100, '000000', 103, 'parent_test', '测试家长', 'sys_user', 
  'parent@test.com', '13800000001', '0', null, 
  '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', 
  '0', '0', '127.0.0.1', now(), 103, 1, now(), null, null, '家长测试账号'
);

-- 分配家长角色
INSERT INTO sys_user_role VALUES (100, 10);

-- 创建儿童测试用户
INSERT INTO sys_user VALUES(
  101, '000000', 103, 'child_test', '测试儿童', 'sys_user', 
  'child@test.com', '13800000002', '0', null, 
  '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', 
  '0', '0', '127.0.0.1', now(), 103, 1, now(), null, null, '儿童测试账号'
);

-- 分配儿童角色
INSERT INTO sys_user_role VALUES (101, 11);
```

### 验证权限

```bash
# 使用测试账号登录
# 用户名: parent_test / child_test
# 密码: admin123

# 登录后检查菜单和权限是否正确显示
```

## 📝 注意事项

1. **权限前缀规范**: 
   - 家长权限必须以 `parent:` 开头
   - 儿童权限必须以 `child:` 开头
   - 使用 `*` 通配符表示所有操作

2. **数据隔离**:
   - 两个角色都设置为"仅本人数据"权限
   - 需要在业务层确保数据过滤逻辑正确

3. **菜单ID规划**:
   - 家长菜单: 2000-2999
   - 儿童菜单: 3000-3999
   - 避免ID冲突

4. **权限检查**:
   - 在 Controller 层使用 `@SaCheckPermission` 注解
   - 在 Service 层可使用 `StpUtil.hasPermission()` 方法
   - 前端也需要根据权限控制按钮显示

## 🔗 相关文件

- [`roles_permissions.sql`](./roles_permissions.sql) - 角色权限配置脚本
- [`init_smallsteps.sql`](./init_smallsteps.sql) - 核心业务表结构
- [`parent_schema.sql`](./parent_schema.sql) - 家长模块表结构

## 📞 支持

如有问题，请联系开发团队或查看项目文档。
