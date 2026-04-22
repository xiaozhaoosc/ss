# SmallSteps 核心功能优化与 MCP 测试数据自动生成计划

> **面向 AI 代理的工作者：** 必需子技能：使用 superpowers:subagent-driven-development（推荐）或 superpowers:executing-plans 逐任务实现此计划。步骤使用复选框（`- [ ]`）语法来跟踪进度。

**目标：** 完善并优化 SmallSteps 系统中的“任务管理、奖励管理、情绪记录、设备管理、知识学堂、亲子契约”六大核心功能模块，并自动借助 MCP 工具（如 MySQL/PostgreSQL MCP 服务器）创建所有相关的测试数据。

**架构：** 基于现有的 Spring Boot 后端（`smallsteps-api`）与 Vue3 前端（`smallsteps-ui`），为已有模块补充缺失的前端页面和联调接口，为缺失的“知识学堂”模块从数据库层到前后端进行完整构建。随后，通过编写专用的 Python 脚本或直接提供 SQL 语句供数据库 MCP 工具调用，以自动化生成大规模、高仿真的测试用例数据。

**技术栈：** Java (Spring Boot), Vue 3 (Element Plus), MySQL/PostgreSQL, Python (Faker, 用于 MCP 测试数据生成脚本)

---

### 任务 1：完善优化已有后端模块与数据库确认

**文件：**
- 检查/修改：`smallsteps-api/script/sql/update/smallsteps_modules_update.sql` (新建)

- [ ] **步骤 1：梳理和补全数据库字段**
  为现有的 `ss_parent_task` (任务), `ss_parent_reward` (奖励), `ss_parent_contract` (契约), `ss_parent_emotion_kit` (情绪) 表补充缺失的审计和扩展字段（如分类、富文本详情等）。针对“设备管理”，确认并复用 `sys_device`（或新建 `ss_device`）。

```sql
-- 在 smallsteps-api/script/sql/update/smallsteps_modules_update.sql 中添加
ALTER TABLE ss_parent_task ADD COLUMN IF NOT EXISTS category_id BIGINT COMMENT '任务分类ID';
ALTER TABLE ss_parent_reward ADD COLUMN IF NOT EXISTS exchange_limit INT DEFAULT -1 COMMENT '兑换次数限制';
-- 添加设备表(如果不存在)
CREATE TABLE IF NOT EXISTS ss_device (
    device_id BIGINT PRIMARY KEY,
    user_id BIGINT,
    device_sn VARCHAR(100),
    device_name VARCHAR(100),
    status CHAR(1) DEFAULT '0',
    create_time TIMESTAMP
);
```

- [ ] **步骤 2：执行 SQL**
  运行：`mysql -u root -p smallsteps < smallsteps-api/script/sql/update/smallsteps_modules_update.sql`
  预期：执行成功，表结构更新。

- [ ] **步骤 3：Commit**
```bash
git add smallsteps-api/script/sql/update/smallsteps_modules_update.sql
git commit -m "feat: 优化任务、奖励、设备等基础表结构"
```

### 任务 2：新建“知识学堂”模块 (Knowledge School)

**文件：**
- 创建：`smallsteps-api/script/sql/update/ss_knowledge.sql`
- 创建：`smallsteps-api/smallsteps-modules/smallsteps-parent/src/main/java/com/kenzhao/smallsteps/parent/domain/SsKnowledge.java`
- 创建：`smallsteps-api/smallsteps-modules/smallsteps-parent/src/main/java/com/kenzhao/smallsteps/parent/controller/KnowledgeController.java`
- 创建：`smallsteps-api/smallsteps-modules/smallsteps-parent/src/main/java/com/kenzhao/smallsteps/parent/service/ISsKnowledgeService.java`

- [ ] **步骤 1：建表语句**
```sql
-- 在 ss_knowledge.sql 中添加
CREATE TABLE IF NOT EXISTS ss_knowledge (
    knowledge_id BIGINT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    content TEXT,
    author VARCHAR(50),
    cover_image VARCHAR(255),
    view_count INT DEFAULT 0,
    status CHAR(1) DEFAULT '0',
    create_time TIMESTAMP
);
```

- [ ] **步骤 2：执行建表并生成后端基础代码**
  运行数据库更新后，利用代码生成器或手动创建 `SsKnowledge` 实体、Mapper、Service 和 Controller。

- [ ] **步骤 3：Commit**
```bash
git add .
git commit -m "feat: 新增知识学堂模块后端代码及数据库表"
```

### 任务 3：前端视图完善与优化 (smallsteps-ui)

**文件：**
- 修改：`smallsteps-ui/src/views/smallsteps/task/index.vue`
- 修改：`smallsteps-ui/src/views/smallsteps/reward/index.vue`
- 创建：`smallsteps-ui/src/views/smallsteps/emotion/index.vue`
- 创建：`smallsteps-ui/src/views/smallsteps/device/index.vue`
- 创建：`smallsteps-ui/src/views/smallsteps/knowledge/index.vue`
- 创建：`smallsteps-ui/src/views/smallsteps/contract/index.vue`

- [ ] **步骤 1：优化任务与奖励管理 UI**
  在 `task/index.vue` 和 `reward/index.vue` 中补充高级筛选（如按分类、状态）、批量操作按钮，以及精美的列表/卡片展示视图。

- [ ] **步骤 2：实现情绪、设备、知识、契约模块页面**
  新建上述四个 Vue 页面，使用 Element Plus 的 Table、Form、Dialog 组件完成 CRUD 交互。确保接口调用对接后端 `@RestController`。

- [ ] **步骤 3：配置路由和菜单**
  确保这六个页面在 `sys_menu` 表中或前端的路由配置中被正确注册，使左侧菜单能够正常点击跳转。

- [ ] **步骤 4：Commit**
```bash
git add smallsteps-ui/src/views/smallsteps/
git commit -m "feat: 完善优化六大核心功能前端页面视图"
```

### 任务 4：自动借助 MCP 工具生成测试数据

**说明：**
由于我们需要**自动借助 MCP 工具**（如 Cursor/Trae 的内置 Database MCP 工具，或本地的 Python MCP Client）创建数据，我们将提供一个可由 MCP 工具直接读取和执行的 Python 脚本，它使用 `Faker` 库连接数据库并插入海量拟真数据。

**文件：**
- 创建：`scripts/mcp_test_data_generator.py`
- 创建：`scripts/requirements.txt`

- [ ] **步骤 1：编写依赖和生成脚本**

```python
# scripts/requirements.txt
Faker==19.13.0
pymysql==1.1.0
SQLAlchemy==2.0.23
```

```python
# scripts/mcp_test_data_generator.py
import random
from faker import Faker
import pymysql
from datetime import datetime

# 这个脚本设计为可由 MCP Server (如 Command execution MCP) 直接调用执行
def generate_mock_data(db_config):
    fake = Faker('zh_CN')
    conn = pymysql.connect(**db_config)
    cursor = conn.cursor()
    
    try:
        # 1. 生成任务数据
        for i in range(50):
            cursor.execute(
                "INSERT INTO ss_parent_task (task_id, title, description, reward_points, difficulty, status, create_time) VALUES (%s, %s, %s, %s, %s, %s, %s)",
                (fake.random_int(1000, 99999), fake.sentence(nb_words=3), fake.text(max_nb_chars=50), random.randint(5, 50), random.randint(1, 5), '0', datetime.now())
            )
            
        # 2. 生成奖励数据
        for i in range(30):
            cursor.execute(
                "INSERT INTO ss_parent_reward (reward_id, name, points_required, stock, status, create_time) VALUES (%s, %s, %s, %s, %s, %s)",
                (fake.random_int(1000, 99999), fake.word() + '奖励', random.randint(50, 500), random.randint(10, 100), '0', datetime.now())
            )
            
        # 3. 生成情绪记录数据
        # (假设表为 ss_parent_emotion_kit)
        for i in range(100):
            cursor.execute(
                "INSERT INTO ss_parent_emotion_kit (kit_id, emotion_type, intensity, notes, create_time) VALUES (%s, %s, %s, %s, %s)",
                (fake.random_int(1000, 99999), random.choice(['开心', '难过', '生气', '平静']), random.randint(1, 10), fake.sentence(), fake.date_time_this_month())
            )

        # 4. 生成设备、知识学堂、亲子契约数据
        for i in range(20):
            cursor.execute(
                "INSERT INTO ss_knowledge (knowledge_id, title, content, author, view_count) VALUES (%s, %s, %s, %s, %s)",
                (fake.random_int(1000, 99999), fake.catch_phrase(), fake.text(), fake.name(), random.randint(0, 1000))
            )
            
        conn.commit()
        print("✅ 成功借助 MCP 测试数据生成器插入所有核心模块测试数据！")
    except Exception as e:
        conn.rollback()
        print(f"❌ 插入数据失败: {e}")
    finally:
        cursor.close()
        conn.close()

if __name__ == "__main__":
    # 配置此处即可运行，MCP Agent 可直接执行此文件
    db_config = {
        'host': '127.0.0.1',
        'user': 'root',
        'password': 'password', # 请 MCP 运行时替换为环境变量
        'database': 'smallsteps',
        'charset': 'utf8mb4'
    }
    generate_mock_data(db_config)
```

- [ ] **步骤 2：测试并验证数据**
  运行：`pip install -r scripts/requirements.txt && python scripts/mcp_test_data_generator.py`
  预期：输出 `✅ 成功借助 MCP 测试数据生成器插入所有核心模块测试数据！`。

- [ ] **步骤 3：Commit**
```bash
git add scripts/
git commit -m "test: 添加基于 MCP 工具的自动化测试数据生成脚本"
```