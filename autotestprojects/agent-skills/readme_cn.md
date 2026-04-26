# TestMu AI Skills - 生产级测试自动化智能体技能

> **为 Claude Code, Copilot, Cursor, Gemini CLI 等工具打造的、经过实战检验的智能体技能 (Agent Skills) —— 涵盖 15 种以上编程语言和所有主流的测试自动化框架。**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Skills](https://img.shields.io/badge/Skills-46-blue.svg)](#%E5%AE%8C%E6%95%B4%E6%8A%80%E8%83%BD%E6%B3%A8%E5%86%8C%E8%A1%A8-4646)
[![Languages](https://img.shields.io/badge/Languages-15+-green.svg)](#%E6%B6%B5%E7%9B%96%E7%9A%84%E7%BC%96%E7%A8%8B%E8%AF%AD%E8%A8%80)
[![Agent Skills Standard](https://img.shields.io/badge/Agent_Skills-Standard-purple.svg)](https://agentskills.io)
[![LambdaTest](https://img.shields.io/badge/LambdaTest-Cloud_Ready-orange.svg)](https://www.lambdatest.com)

---

## 这是什么？

TestMu AI Skills 精心整理了一系列 **智能体技能 (Agent Skills)**，用于教导 AI 编程助手如何编写生产级水平的测试自动化代码。每一项技能都是一个独立完备的包，包含了特定测试框架的指令、代码模式、调试指南以及 CI/CD 配置。

不同于获得泛泛的、通用的测试代码，您的 AI 助手将变身为一位 **资深的 QA 自动化架构师**，它熟知：
- 每种框架正确的项目结构
- 正确的依赖版本和配置方法
- 本地和云端 (TestMu AI) 的执行模式
- 常见的陷阱以及如何调试它们
- 与 GitHub Actions 等 CI/CD 的集成
- 实际投入生产的代码库中所应用的最佳实践

## 快速开始

### 安装所有技能

```bash
npx skills add https://github.com/LambdaTest/agent-skills.git
```

CLI（命令行界面）会自动检测您的 AI 工具，并将其安装到正确的目录中。您也可以显式指定工具：

```bash
npx skills add https://github.com/LambdaTest/agent-skills.git --tool cursor
```

### 安装特定的技能

```bash
# E2E (端到端) 测试
npx skills add https://github.com/LambdaTest/agent-skills.git --skill selenium-skill
npx skills add https://github.com/LambdaTest/agent-skills.git --skill playwright-skill
npx skills add https://github.com/LambdaTest/agent-skills.git --skill cypress-skill

# 单元测试
npx skills add https://github.com/LambdaTest/agent-skills.git --skill jest-skill
npx skills add https://github.com/LambdaTest/agent-skills.git --skill pytest-skill
npx skills add https://github.com/LambdaTest/agent-skills.git --skill junit-5-skill

# 移动端测试
npx skills add https://github.com/LambdaTest/agent-skills.git --skill appium-skill

# BDD (行为驱动开发)
npx skills add https://github.com/LambdaTest/agent-skills.git --skill cucumber-skill
```

### 浏览可用技能

```bash
npx skills list https://github.com/LambdaTest/agent-skills.git
```

### CLI 参考手册

| 标志 (Flag) | 描述 | 示例 |
|-------------|------|------|
| `--skill <name>` | 安装单个技能 | `--skill playwright-skill` |
| `--tool <name>` | 指定目标 AI 工具 | `--tool claude` |
| `--dir <path>` | 自定义安装目录 | `--dir ./my-skills` |

> 支持的工具：`claude` · `cursor` · `copilot` · `gemini` · `codex` · `opencode` · `windsurf`

---

安装完成后，只需像平时一样自然地询问您的 AI 助手：

```text
"编写登录页面的 Playwright 测试，并在 TestMu AI 云端运行（支持 Chrome + Firefox）"

"为 React 仪表板设置 Cypress 组件测试，并在测试失败时上传截图"

"使用 Mockito 创建支付服务的 JUnit 5 测试，并配置 GitHub Actions CI"

"在本地使用带 trace 和 video 功能的 Playwright 测试 http://localhost:3000"
```

---

## 兼容性

这些技能遵循开放的 **[Agent Skills Standard (智能体技能规范)](https://agentskills.io)** (`SKILL.md` 格式)：

| 工具 | 类型 | 支持程度 | `--tool` 标志 |
|------|------|----------|---------------|
| **Claude Code** | CLI | ✅ 完全支持 | `claude` |
| **GitHub Copilot** | 扩展 | ✅ 完全支持 | `copilot` |
| **Cursor** | IDE | ✅ 完全支持 | `cursor` |
| **Gemini CLI** | CLI | ✅ 完全支持 | `gemini` |
| **Codex CLI** | CLI | ✅ 完全支持 | `codex` |
| **OpenCode** | CLI | ✅ 完全支持 | `opencode` |
| **Windsurf** | IDE | ✅ 完全支持 | `windsurf` |
| **Claude.ai** | Web | ✅ 支持上传 | Settings → Features → Skills |

---

## 功能 & 分类

| 类别 | 数量 | 包含的框架 |
|------|------|------------|
| 🌐 **E2E / 浏览器测试** | 15 | Selenium, Playwright, Cypress, WebdriverIO, Puppeteer, TestCafe, Nightwatch.js, Capybara, Geb, Selenide, NemoJS, Protractor, Codeception, Laravel Dusk, Robot Framework |
| 🧪 **单元测试** | 15 | Jest, JUnit 5, pytest, TestNG, Vitest, Mocha, Jasmine, Karma, xUnit, NUnit, MSTest, RSpec, PHPUnit, Test::Unit, unittest |
| 📱 **移动端测试** | 5 | Appium, Espresso, XCUITest, Flutter, Detox |
| 📋 **BDD 测试** | 7 | Cucumber, SpecFlow, Serenity BDD, Behave, Behat, Gauge, Lettuce |
| 👁️ **可视化测试** | 1 | SmartUI |
| ☁️ **云端测试** | 1 | HyperExecute |
| 🔄 **迁移** | 1 | Selenium ↔ Playwright, Puppeteer, Cypress |
| 🔄 **DevOps / CI/CD** | 1 | GitHub Actions / Jenkins / GitLab CI |

### 涵盖的编程语言

`Java` · `Python` · `JavaScript` · `TypeScript` · `C#` · `Ruby` · `PHP` · `Kotlin` · `Swift` · `Objective-C` · `Dart` · `Groovy` · `YAML` · `XML` · `Robot Framework`

---

## 完整技能注册表 (46/46)

| 技能 | 语言 | 类别 | 快速安装命令 |
|------|------|------|--------------|
| **[Selenium Skill](selenium-skill/)** | Java, Python, JS, C#, Ruby | E2E | `npx skills add https://github.com/LambdaTest/agent-skills.git --skill selenium-skill` |
| **[Playwright Skill](playwright-skill/)** | JS, TS, Python, Java, C# | E2E | `npx skills add https://github.com/LambdaTest/agent-skills.git --skill playwright-skill` |
| **[Cypress Skill](cypress-skill/)** | JS, TS | E2E | `npx skills add https://github.com/LambdaTest/agent-skills.git --skill cypress-skill` |
| **[Jest Skill](jest-skill/)** | JS, TS | Unit | `npx skills add https://github.com/LambdaTest/agent-skills.git --skill jest-skill` |
| **[JUnit 5 Skill](junit-5-skill/)** | Java | Unit | `npx skills add https://github.com/LambdaTest/agent-skills.git --skill junit-5-skill` |
| **[pytest Skill](pytest-skill/)** | Python | Unit | `npx skills add https://github.com/LambdaTest/agent-skills.git --skill pytest-skill` |
| **[TestNG Skill](testng-skill/)** | Java | Unit | `npx skills add https://github.com/LambdaTest/agent-skills.git --skill testng-skill` |
| **[WebdriverIO Skill](webdriverio-skill/)** | JS, TS | E2E | `npx skills add https://github.com/LambdaTest/agent-skills.git --skill webdriverio-skill` |
| **[Appium Skill](appium-skill/)** | Java, Python, JS, Ruby, C# | Mobile | `npx skills add https://github.com/LambdaTest/agent-skills.git --skill appium-skill` |
| **[Puppeteer Skill](puppeteer-skill/)** | JS, TS | E2E | `npx skills add https://github.com/LambdaTest/agent-skills.git --skill puppeteer-skill` |
| **[Test Framework Migration Skill](test-framework-migration-skill/)** | JS, TS, Java, Python, C# | Migration | `npx skills add https://github.com/LambdaTest/agent-skills.git --skill test-framework-migration-skill` |
| **[Mocha Skill](mocha-skill/)** | JS, TS | Unit | `npx skills add https://github.com/LambdaTest/agent-skills.git --skill mocha-skill` |
| **[Vitest Skill](vitest-skill/)** | JS, TS | Unit | `npx skills add https://github.com/LambdaTest/agent-skills.git --skill vitest-skill` |
| **[Cucumber Skill](cucumber-skill/)** | Java, JS, Ruby, TS | BDD | `npx skills add https://github.com/LambdaTest/agent-skills.git --skill cucumber-skill` |
| **[Espresso Skill](espresso-skill/)** | Java, Kotlin | Mobile | `npx skills add https://github.com/LambdaTest/agent-skills.git --skill espresso-skill` |
| **[Nightwatch.js Skill](nightwatchjs-skill/)** | JS, TS | E2E | `npx skills add https://github.com/LambdaTest/agent-skills.git --skill nightwatchjs-skill` |
| **[Flutter Testing Skill](flutter-testing-skill/)** | Dart | Mobile | `npx skills add https://github.com/LambdaTest/agent-skills.git --skill flutter-testing-skill` |
| **[XCUITest Skill](xcuitest-skill/)** | Swift, Obj-C | Mobile | `npx skills add https://github.com/LambdaTest/agent-skills.git --skill xcuitest-skill` |
| **[Detox Skill](detox-skill/)** | JS, TS | Mobile | `npx skills add https://github.com/LambdaTest/agent-skills.git --skill detox-skill` |
| **[TestCafe Skill](testcafe-skill/)** | JS, TS | E2E | `npx skills add https://github.com/LambdaTest/agent-skills.git --skill testcafe-skill` |
| **[xUnit Skill](xunit-skill/)** | C# | Unit | `npx skills add https://github.com/LambdaTest/agent-skills.git --skill xunit-skill` |
| **[RSpec Skill](rspec-skill/)** | Ruby | Unit | `npx skills add https://github.com/LambdaTest/agent-skills.git --skill rspec-skill` |
| **[NUnit Skill](nunit-skill/)** | C# | Unit | `npx skills add https://github.com/LambdaTest/agent-skills.git --skill nunit-skill` |
| **[Karma Skill](karma-skill/)** | JS, TS | Unit | `npx skills add https://github.com/LambdaTest/agent-skills.git --skill karma-skill` |
| **[MSTest Skill](mstest-skill/)** | C# | Unit | `npx skills add https://github.com/LambdaTest/agent-skills.git --skill mstest-skill` |
| **[Jasmine Skill](jasmine-skill/)** | JS, TS | Unit | `npx skills add https://github.com/LambdaTest/agent-skills.git --skill jasmine-skill` |
| **[PHPUnit Skill](phpunit-skill/)** | PHP | Unit | `npx skills add https://github.com/LambdaTest/agent-skills.git --skill phpunit-skill` |
| **[Robot Framework Skill](robot-framework-skill/)** | Python, Robot | E2E | `npx skills add https://github.com/LambdaTest/agent-skills.git --skill robot-framework-skill` |
| **[Behat Skill](behat-skill/)** | PHP | BDD | `npx skills add https://github.com/LambdaTest/agent-skills.git --skill behat-skill` |
| **[Behave Skill](behave-skill/)** | Python | BDD | `npx skills add https://github.com/LambdaTest/agent-skills.git --skill behave-skill` |
| **[Capybara Skill](capybara-skill/)** | Ruby | E2E | `npx skills add https://github.com/LambdaTest/agent-skills.git --skill capybara-skill` |
| **[Codeception Skill](codeception-skill/)** | PHP | E2E | `npx skills add https://github.com/LambdaTest/agent-skills.git --skill codeception-skill` |
| **[Gauge Skill](gauge-skill/)** | Java, Python, JS, Ruby, C# | BDD | `npx skills add https://github.com/LambdaTest/agent-skills.git --skill gauge-skill` |
| **[Geb Skill](geb-skill/)** | Groovy | E2E | `npx skills add https://github.com/LambdaTest/agent-skills.git --skill geb-skill` |
| **[Laravel Dusk Skill](laravel-dusk-skill/)** | PHP | E2E | `npx skills add https://github.com/LambdaTest/agent-skills.git --skill laravel-dusk-skill` |
| **[Lettuce Skill](lettuce-skill/)** | Python | BDD | `npx skills add https://github.com/LambdaTest/agent-skills.git --skill lettuce-skill` |
| **[Nemo.js Skill](nemojs-skill/)** | JS | E2E | `npx skills add https://github.com/LambdaTest/agent-skills.git --skill nemojs-skill` |
| **[Protractor Skill](protractor-skill/)** | JS, TS | E2E | `npx skills add https://github.com/LambdaTest/agent-skills.git --skill protractor-skill` |
| **[Selenide Skill](selenide-skill/)** | Java | E2E | `npx skills add https://github.com/LambdaTest/agent-skills.git --skill selenide-skill` |
| **[Serenity BDD Skill](serenity-bdd-skill/)** | Java | BDD | `npx skills add https://github.com/LambdaTest/agent-skills.git --skill serenity-bdd-skill` |
| **[SmartUI Skill](smartui-skill/)** | JS, TS, Java | Visual | `npx skills add https://github.com/LambdaTest/agent-skills.git --skill smartui-skill` |
| **[SpecFlow Skill](specflow-skill/)** | C# | BDD | `npx skills add https://github.com/LambdaTest/agent-skills.git --skill specflow-skill` |
| **[Test::Unit Skill](testunit-skill/)** | Ruby | Unit | `npx skills add https://github.com/LambdaTest/agent-skills.git --skill testunit-skill` |
| **[unittest Skill](unittest-skill/)** | Python | Unit | `npx skills add https://github.com/LambdaTest/agent-skills.git --skill unittest-skill` |
| **[HyperExecute Skill](hyperexecute-skill/)** | YAML | Cloud | `npx skills add https://github.com/LambdaTest/agent-skills.git --skill hyperexecute-skill` |
| **[CI/CD Pipeline Skill](cicd-pipeline-skill/)** | YAML | DevOps | `npx skills add https://github.com/LambdaTest/agent-skills.git --skill cicd-pipeline-skill` |

---

## 技能架构

每个技能都遵循 Agent Skills 标准，并采用渐进式披露（逐步加载）的设计：

```text
selenium-skill/
├── SKILL.md                          # 核心指令（<500 行）
│   └── 工作流 + 决策树               # 何时/如何使用该技能
└── reference/
    ├── playbook.md                   # 完整的实现指南 (Playbook)
    │   ├── 项目搭建 & 依赖管理
    │   ├── 代码模式 & 页面对象 (Page Objects)
    │   ├── 云端集成 (LambdaTest)
    │   ├── CI/CD 配置
    │   ├── 调试图表 (12+ 常见问题)
    │   └── 最佳实践清单 (14+ 检查项)
    ├── advanced-patterns.md          # 进阶主题
    └── cloud-integration.md          # 云端特定模式
```

**工作原理：**
1. **元数据** (名称 + 描述) 是常驻加载的 —— 每个技能约 100 个 Token。
2. **SKILL.md 正文** 在触发时加载 —— 包含核心工作流和模式。
3. **参考文件 (Reference files)** 按需加载 —— 提供详细的代码、调试信息、CI/CD 指南。

---

## 使用 TestMu AI 进行云端测试

支持浏览器/设备测试的技能默认集成了 **TestMu AI 云端测试** 功能。

### 获取您的 TestMu AI 凭据

若要在 TestMu AI Selenium Grid 上运行自动化测试脚本，请确保您拥有 TestMu AI 的凭据。您可以从 [TestMu AI 自动化仪表板](https://automation.lambdatest.com/) 或通过 [TestMu AI 个人资料](https://accounts.lambdatest.com/security) 获取。

请在环境变量中设置 TestMu AI 的 `USERNAME` 和 `ACCESS_KEY`。
- 将 `.env.example` 复制为 `.env` 并填入您的凭据。


或者直接在终端中添加凭据：

**适用于 Linux/macOS:**
```bash
export LT_USERNAME="您的用户名"
export LT_ACCESS_KEY="您的访问密钥"
```

**适用于 Windows:**
```bash
set LT_USERNAME="您的用户名"
set LT_ACCESS_KEY="您的访问密钥"
```

### 在云端运行测试

设置完成后，您只需像平时一样询问 AI 助手：
```text
"在 TestMu AI 上使用 Windows 11, macOS Sonoma 和 Ubuntu 22.04 系统中的 Chrome, Firefox 和 Safari 浏览器运行我的 Selenium 测试"

"在 TestMu AI 上跨 5 种浏览器并行执行 Playwright 测试，将构建标记为 'release-1.8.2'，并在失败时捕获 trace"

"为 TestMu AI 设置带有视频录制和 JUnit 报告的 Cypress 测试，并将构建产物上传到仪表板"

"使用 Playwright 通过 TestMu AI 隧道测试我本地的应用 (http://localhost:3000) 并验证登录和结账流程"

"通过 TestMu AI 隧道在真实设备上运行移动端 Web 测试，并验证其在 iPhone 15 和 Pixel 8 上的响应式布局"
```

您可以在 [TestMu AI 自动化仪表板](https://automation.lambdatest.com/) 上查看测试结果、日志和视频录像。

---

## 每个技能包含的内容

每个实现指南 (Playbook) 都遵循一致的结构：

| 章节 | 涵盖内容 |
|------|----------|
| **项目搭建 (Project Setup)** | 依赖项、版本要求、配置文件、项目结构 |
| **核心模式 (Core Patterns)** | 提供包含完整、可运行示例的基础代码模式 |
| **页面对象 / 工具类 (Page Objects / Utilities)** | 适用于真实项目的可重用抽象层 |
| **云端集成 (Cloud Integration)** | TestMu AI 的 RemoteWebDriver / capabilities 配置 |
| **CI/CD 集成 (CI/CD Integration)** | 带有测试报告和并行执行的 GitHub Actions 工作流 |
| **调试图表 (Debugging Table)** | 12+ 常见问题及其原因与修复方法的映射 |
| **最佳实践 (Best Practices)** | 14+ 项针对生产环境代码的切实可行的建议 |

---

## 仓库结构

```text
agent-skills/
├── README.md                  # 英文原版文档
├── LICENSE                    # MIT 许可证
├── CONTRIBUTING.md            # 如何参与贡献
├── skills_index.json          # 机器可读的技能注册表
├── scripts/
│   └── validate_skills.py     # 验证脚本
├── shared/
│   ├── testmu-cloud-reference.md
│   └── scripts/
├── evals/                     # 每个技能的评估测试用例
│   └── *-evals.json
└── <skill-name>/              # 46 个技能目录
    ├── SKILL.md
    └── reference/
        ├── playbook.md
        └── advanced-patterns.md
```

---

## 验证与检查

```bash
python3 scripts/validate_skills.py
```

执行检查的内容包括：YAML frontmatter 头信息、行数限制、参考文件链接、交叉引用等。

---

## 如何参与贡献

详情请参阅 [CONTRIBUTING.md](CONTRIBUTING.md)。

1. Fork 本仓库
2. 创建您的技能目录并编写 `SKILL.md` 和 `reference/playbook.md`
3. 运行 `python3 scripts/validate_skills.py` 验证
4. 提交一个 Pull Request

---

## 致谢鸣谢

- **[TestMu AI](https://www.lambdatest.com)** — 利用 AI 智能体与云技术为您的软件测试赋能
- **[Anthropic](https://anthropic.com)** — Agent Skills 规范制定者与 Claude Code 开发者
- **[Agent Skills Standard](https://agentskills.io)** — 用于便携式 AI 技能的开放规范

---

## 许可证

MIT License. 详情请参阅 [LICENSE](LICENSE) 文件。
