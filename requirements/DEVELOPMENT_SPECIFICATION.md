# 开发规范文档

## 1. 概述

### 1.1 文档目的
本文档详细描述 Small Steps 系统的开发规范，包括编码规范、命名规范、代码审查流程等，确保开发团队的代码风格一致，提高代码质量和可维护性。

### 1.2 适用范围
本规范适用于 Small Steps 系统的所有开发人员，包括前端、后端、硬件和 AI 中台的开发。

## 2. 编码规范

### 2.1 前端编码规范

#### 2.1.1 Vue 编码规范
- **组件命名**：使用 PascalCase 命名组件，如 `TaskCard.vue`
- **变量命名**：使用 camelCase 命名变量，如 `taskList`
- **常量命名**：使用 UPPER_SNAKE_CASE 命名常量，如 `MAX_TASK_COUNT`
- **方法命名**：使用 camelCase 命名方法，如 `getTaskList()`
- **缩进**：使用 2 个空格缩进
- **分号**：使用分号结束语句
- **引号**：使用单引号 `'` 或反引号 `` ` ``
- **模板语法**：使用 Vue 3 的 Composition API
- **代码风格**：遵循 ESLint + Prettier 规范

#### 2.1.2 UniApp X 编码规范
- **页面命名**：使用 kebab-case 命名页面，如 `task-detail.vue`
- **组件命名**：使用 PascalCase 命名组件，如 `TaskCard.vue`
- **API 调用**：使用封装的 request 方法，统一处理错误和认证
- **状态管理**：使用 Pinia 进行状态管理
- **路由**：使用 UniApp 的路由配置
- **样式**：使用 Tailwind CSS

#### 2.1.3 Nuxt 3 编码规范
- **页面命名**：使用 kebab-case 命名页面，如 `dashboard.vue`
- **组件命名**：使用 PascalCase 命名组件，如 `DataPanel.vue`
- **API 调用**：使用 Nuxt 的 useFetch 或 useAsyncData
- **状态管理**：使用 Pinia 进行状态管理
- **路由**：使用 Nuxt 的自动路由
- **样式**：使用 Tailwind CSS

### 2.2 后端编码规范

#### 2.2.1 Java 编码规范
- **类命名**：使用 PascalCase 命名类，如 `TaskService`
- **方法命名**：使用 camelCase 命名方法，如 `createTask()`
- **变量命名**：使用 camelCase 命名变量，如 `taskList`
- **常量命名**：使用 UPPER_SNAKE_CASE 命名常量，如 `MAX_PAGE_SIZE`
- **缩进**：使用 4 个空格缩进
- **大括号**：使用 Egyptian 风格的大括号
- **注释**：使用 Javadoc 注释
- **代码风格**：遵循 Java 代码规范，使用 IDE 格式化

#### 2.2.2 Spring Boot 编码规范
- **包命名**：使用小写字母和点分隔，如 `com.smallsteps.task`
- **控制器命名**：使用 `Controller` 后缀，如 `TaskController`
- **服务命名**：使用 `Service` 后缀，如 `TaskService`
- **数据访问命名**：使用 `Mapper` 或 `Repository` 后缀，如 `TaskMapper`
- **DTO 命名**：使用 `DTO` 后缀，如 `TaskDTO`
- **配置命名**：使用 `Config` 后缀，如 `SecurityConfig`

### 2.3 硬件编码规范

#### 2.3.1 MicroPython 编码规范
- **文件命名**：使用小写字母和下划线，如 `task_manager.py`
- **类命名**：使用 PascalCase 命名类，如 `TaskManager`
- **方法命名**：使用 snake_case 命名方法，如 `get_task_list()`
- **变量命名**：使用 snake_case 命名变量，如 `task_list`
- **常量命名**：使用 UPPER_SNAKE_CASE 命名常量，如 `MAX_TASK_COUNT`
- **缩进**：使用 4 个空格缩进
- **注释**：使用 # 进行单行注释
- **代码风格**：遵循 PEP 8 规范

### 2.4 AI 中台编码规范

#### 2.4.1 Python 编码规范
- **文件命名**：使用小写字母和下划线，如 `task_breakdown.py`
- **类命名**：使用 PascalCase 命名类，如 `TaskBreakdownService`
- **方法命名**：使用 snake_case 命名方法，如 `breakdown_task()`
- **变量命名**：使用 snake_case 命名变量，如 `task_data`
- **常量命名**：使用 UPPER_SNAKE_CASE 命名常量，如 `MAX_STEPS`
- **缩进**：使用 4 个空格缩进
- **注释**：使用 docstring 进行文档注释
- **代码风格**：遵循 PEP 8 规范

## 3. 命名规范

### 3.1 项目命名
- **项目名称**：使用小写字母和连字符，如 `smallsteps-api`
- **模块名称**：使用小写字母和连字符，如 `smallsteps-common-core`

### 3.2 文件命名
- **前端文件**：
  - 组件文件：使用 PascalCase，如 `TaskCard.vue`
  - 页面文件：使用 kebab-case，如 `task-detail.vue`
  - 工具文件：使用 camelCase，如 `dateUtils.js`
- **后端文件**：
  - 类文件：使用 PascalCase，如 `TaskService.java`
  - 配置文件：使用 kebab-case，如 `application.yml`
- **硬件文件**：
  - Python 文件：使用 snake_case，如 `task_manager.py`
  - 配置文件：使用 snake_case，如 `config.py`

### 3.3 变量命名
- **前端变量**：使用 camelCase，如 `taskList`
- **后端变量**：使用 camelCase，如 `taskList`
- **硬件变量**：使用 snake_case，如 `task_list`
- **AI 中台变量**：使用 snake_case，如 `task_data`

### 3.4 常量命名
- 所有常量使用 UPPER_SNAKE_CASE，如 `MAX_TASK_COUNT`

### 3.5 数据库命名
- **表名**：使用小写字母和下划线，如 `user`、`task`
- **字段名**：使用小写字母和下划线，如 `user_id`、`task_title`
- **索引名**：使用 `idx_` 前缀，如 `idx_user_username`

## 4. 代码审查流程

### 4.1 代码审查目的
- 确保代码质量和可维护性
- 发现并修复潜在的缺陷
- 确保代码符合编码规范
- 促进知识共享和团队协作

### 4.2 代码审查流程
1. **提交代码**：开发人员提交代码到 feature 分支
2. **创建 Pull Request**：开发人员创建 Pull Request 到 develop 分支
3. **代码审查**：
   - 代码审查人员检查代码是否符合编码规范
   - 检查代码是否存在潜在的缺陷
   - 检查代码是否有足够的注释
   - 检查代码是否通过单元测试
4. **反馈**：代码审查人员提供反馈
5. **修改**：开发人员根据反馈修改代码
6. **合并**：代码审查通过后，合并到 develop 分支

### 4.3 代码审查标准
- **代码质量**：代码是否清晰、简洁、可维护
- **功能正确性**：代码是否实现了预期的功能
- **性能**：代码是否高效，是否存在性能问题
- **安全性**：代码是否存在安全漏洞
- **测试覆盖**：代码是否有足够的测试覆盖
- **文档**：代码是否有足够的文档和注释

## 5. 版本控制规范

### 5.1 分支管理
- **main**：主分支，保持稳定，用于生产部署
- **develop**：开发分支，用于集成测试
- **feature/***：功能分支，用于开发新功能
- **bugfix/***：bug 修复分支，用于修复 bug
- **hotfix/***：热修复分支，用于紧急修复生产环境的问题

### 5.2 提交规范
- **提交信息格式**：使用语义化提交信息，格式为 `type(scope): subject`
  - **type**：提交类型，如 feat（新功能）、fix（修复）、docs（文档）、style（样式）、refactor（重构）、test（测试）、chore（构建）
  - **scope**：提交范围，如 task、reward、device 等
  - **subject**：提交主题，简洁明了地描述提交内容
- **提交频率**：频繁提交，每次提交只包含一个逻辑变更
- **提交内容**：确保提交内容完整，不包含临时文件或无关文件

### 5.3 代码合并
- **合并策略**：使用 Pull Request 进行代码合并
- **合并冲突**：及时解决合并冲突
- **代码审查**：合并前必须经过代码审查

## 6. 文档规范

### 6.1 技术文档
- **格式**：使用 Markdown 格式
- **内容**：包含项目概述、技术栈、架构设计、API 文档等
- **更新**：文档必须与代码同步更新

### 6.2 API 文档
- **格式**：使用 Swagger 或 Apifox
- **内容**：包含 API 接口、参数、返回值、错误码等
- **更新**：API 文档必须与代码同步更新

### 6.3 注释规范
- **前端注释**：使用 `//` 进行单行注释，`/* */` 进行多行注释
- **后端注释**：使用 Javadoc 注释
- **硬件注释**：使用 # 进行单行注释
- **AI 中台注释**：使用 docstring 进行文档注释
- **注释内容**：注释应该清晰、简洁，解释代码的目的和逻辑

## 7. 开发工具规范

### 7.1 编辑器配置
- **前端**：使用 VS Code，安装 ESLint、Prettier 插件
- **后端**：使用 IntelliJ IDEA 或 Eclipse
- **硬件**：使用 VS Code，安装 Python 插件
- **AI 中台**：使用 VS Code，安装 Python 插件

### 7.2 版本控制工具
- **Git**：使用 Git 进行版本控制
- **Git 客户端**：使用 Git GUI 客户端或命令行

### 7.3 构建工具
- **前端**：使用 Vite
- **后端**：使用 Maven
- **硬件**：使用 MicroPython 固件工具
- **AI 中台**：使用 Pip 和 Docker

### 7.4 测试工具
- **前端**：使用 Vitest、Playwright
- **后端**：使用 JUnit、Mockito、Postman
- **硬件**：使用 MicroPython 测试框架
- **AI 中台**：使用 pytest

## 8. 代码质量保证

### 8.1 静态代码分析
- **前端**：使用 ESLint 进行静态代码分析
- **后端**：使用 SonarQube 进行静态代码分析
- **硬件**：使用 pylint 进行静态代码分析
- **AI 中台**：使用 pylint 进行静态代码分析

### 8.2 单元测试
- **前端**：使用 Vitest 进行单元测试，测试覆盖率 ≥ 80%
- **后端**：使用 JUnit 进行单元测试，测试覆盖率 ≥ 80%
- **硬件**：使用 MicroPython 测试框架进行单元测试
- **AI 中台**：使用 pytest 进行单元测试，测试覆盖率 ≥ 80%

### 8.3 集成测试
- **前端**：使用 Playwright 进行端到端测试
- **后端**：使用 Postman 进行 API 测试
- **硬件**：测试硬件与后端的通信
- **AI 中台**：测试 AI 服务与后端的集成

## 9. 安全规范

### 9.1 代码安全
- **避免硬编码**：避免硬编码敏感信息，如密码、API 密钥
- **输入验证**：对所有用户输入进行验证和过滤
- **SQL 注入防护**：使用参数化查询，避免直接拼接 SQL 语句
- **XSS 防护**：对输出进行转义，避免跨站脚本攻击
- **CSRF 防护**：实现 CSRF 令牌验证

### 9.2 数据安全
- **密码加密**：使用 BCrypt 加密存储密码
- **敏感数据加密**：对敏感数据进行加密存储
- **数据传输加密**：使用 HTTPS 进行数据传输
- **数据备份**：定期备份数据

### 9.3 部署安全
- **环境变量**：使用环境变量管理配置
- **权限管理**：设置合理的文件权限
- **防火墙**：配置防火墙规则
- **定期更新**：定期更新依赖包和系统补丁

## 10. 总结

本开发规范文档详细描述了 Small Steps 系统的编码规范、命名规范、代码审查流程、版本控制规范、文档规范、开发工具规范、代码质量保证和安全规范。

通过严格遵守本规范，开发团队可以确保代码风格一致，提高代码质量和可维护性，减少错误和缺陷，提高开发效率。同时，本规范也有助于促进团队协作和知识共享，确保系统的安全性和可靠性。

总之，本开发规范文档为 Small Steps 系统的开发工作提供了明确的指导，确保系统的质量和可靠性，为 ADHD 儿童的行为习惯养成提供安全、稳定、高效的技术支持。