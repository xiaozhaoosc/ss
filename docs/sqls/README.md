# Small Steps 工程 PostgreSQL 初始化脚本清单

本目录包含 Small Steps 工程中所有针对 PostgreSQL 数据库的初始化、升级和测试脚本。

## 📋 脚本分类与作用

### 🎯 核心业务初始化脚本

#### 1. **Small Steps 核心业务表** 
**路径**: `init_smallsteps.sql`  
**作用**: Small Steps 核心业务数据库初始化（PostgreSQL 版本）。包含儿童档案、任务系统、奖励系统、设备管理、情绪记录等核心业务表。

---

#### 2. **AI 模块表**
**路径**: `../../projects/smallsteps-api/smallsteps-common/smallsteps-ai/ai_schema_postgres.sql`  
**作用**: AI 供应商和模型管理表。支持多供应商配置、模型成本管理和动态路由策略。

---

#### 3. **家长模块表 (代码生成测试)**
**路径**: `../../projects/smallsteps-api/smallsteps-modules/smallsteps-generator/src/test/resources/parent_schema.sql`  
**作用**: 家长端功能表定义（用于代码生成器测试）。包含家长任务、奖励配置和亲子契约表。

---

#### 4. **角色与权限配置**
**路径**: `roles_permissions.sql`  
**作用**: 家长和儿童角色的权限配置，包括角色定义、菜单权限和数据权限。定义了 `parent:*` 和 `child:*` 两套权限体系。  
**文档**: 详见 [`ROLES_PERMISSIONS_README.md`](./ROLES_PERMISSIONS_README.md)


---

### 🔧 系统框架初始化脚本

#### 4. **RuoYi-Vue-Plus 系统表**
**路径**: `../../projects/smallsteps-api/script/sql/postgres/postgres_ry_vue_5.X.sql`  
**作用**: 框架底层系统表，包含用户权限、多租户、日志监控、文件管理等系统级功能。

---

#### 5. **Docker 初始化脚本**
**路径**: `../dockers/sql/init.sql`  
**作用**: Docker 镜像启动时自动加载的初始化脚本，内容与框架系统表一致。

---

### 🔄 更新与测试脚本

#### 6. **版本升级脚本**
**路径**: `../../projects/smallsteps-api/script/sql/update/postgres/`  
**作用**: 框架各版本的增量更新脚本，用于生产环境的平滑升级。

#### 7. **AI 测试数据**
**路径**: `../../projects/smallsteps-api/smallsteps-common/smallsteps-ai/test_data_zhipu_postgres.sql`  
**作用**: 预置智谱 AI 的配置数据，用于快速验证 AI 模块。

---

#### 8. **Small Steps 测试数据**
**路径**: `test_data_smallsteps.sql`  
**作用**: Small Steps 完整测试数据，包含租户、用户、角色关联、儿童档案、任务、奖励等业务数据。  
**文档**: 详见 [`TEST_DATA_README.md`](./TEST_DATA_README.md)  
**测试账号**: 
- 家长端: `parent_zhang` / `parent_li` (密码: admin123)
- 儿童端: `child_xiaoming` / `child_xiaohong` (密码: admin123)


---

## 🎯 推荐初始化顺序

1. **框架层**: `postgres_ry_vue_5.X.sql` (系统基础)
2. **业务层**: `init_smallsteps.sql` (Small Steps 核心)
3. **权限层**: `roles_permissions.sql` (角色与权限配置)
4. **功能层**: `ai_schema_postgres.sql` (AI 支持)
5. **数据层**: `test_data_zhipu_postgres.sql` (AI 示例数据)
6. **测试层**: `test_data_smallsteps.sql` (业务测试数据)


---

**最后更新**: 2026-02-06  
**维护**: Small Steps Team / Antigravity AI

