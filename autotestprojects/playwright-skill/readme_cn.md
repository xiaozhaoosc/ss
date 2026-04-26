# 适用于 Claude Code 的 Playwright Skill

**作为 Claude 技能的通用浏览器自动化工具**

这是一个 [Claude Skill (技能)](https://www.anthropic.com/blog/skills)，它使 Claude 能够即时编写并执行任何 Playwright 自动化任务 —— 从简单的页面测试到复杂的多步操作流程。它被打包为一个 [Claude Code Plugin (插件)](https://docs.claude.com/en/docs/claude-code/plugins)，以便于安装和分发。

Claude 会根据您的浏览器自动化需求自主决定何时使用此技能，仅加载您特定任务所需的最少信息。

基于 Claude Code 制作。

## 功能特点

- **任何自动化任务** - Claude 会针对您的特定请求编写自定义代码，不仅限于预置的脚本。
- **默认可见的浏览器** - 通过 `headless: false` 实时查看自动化执行过程。
- **零模块解析错误** - 通用执行器确保正确的模块访问。
- **渐进式加载** - 仅在需要时才加载带有完整 API 参考的简明 SKILL.md。
- **安全清理** - 智能管理临时文件，无竞争条件（Race conditions）。
- **全面的辅助函数** - 提供用于常见任务的可选实用函数。

## 安装指南

此仓库的结构为一个包含技能的 [Claude Code 插件](https://docs.claude.com/en/docs/claude-code/plugins)。您可以将其作为**插件**安装（推荐），也可以将其提取为**独立技能**安装。

### 理解目录结构

此仓库使用嵌套结构的插件格式：

```text
playwright-skill/              # 插件根目录
├── .claude-plugin/           # 插件元数据
└── skills/
    └── playwright-skill/     # 实际的技能文件
        └── SKILL.md
```

Claude Code 期望技能直接放置在 `.claude/skills/` 文件夹下，因此手动安装需要提取嵌套的技能文件夹。

---

### 选项 1：插件安装（推荐）

通过 Claude Code 的插件系统安装，以便获得自动更新和团队分发支持：

```bash
# 将此仓库添加为市场
/plugin marketplace add lackeyjb/playwright-skill

# 安装该插件
/plugin install playwright-skill@playwright-skill

# 导航至该技能目录并运行 setup
cd ~/.claude/plugins/marketplaces/playwright-skill/skills/playwright-skill
npm run setup
```

通过运行 `/help` 确认技能可用以验证安装。

---

### 选项 2：独立技能安装

如果要作为独立技能安装（不使用插件系统），请仅提取该技能文件夹：

**全局安装（随处可用）：**

```bash
# 克隆到临时位置
git clone https://github.com/lackeyjb/playwright-skill.git /tmp/playwright-skill-temp

# 仅将技能文件夹复制到您的全局 skills 目录
mkdir -p ~/.claude/skills
cp -r /tmp/playwright-skill-temp/skills/playwright-skill ~/.claude/skills/

# 导航至该技能并运行 setup
cd ~/.claude/skills/playwright-skill
npm run setup

# 清理临时文件
rm -rf /tmp/playwright-skill-temp
```

**项目专属安装：**

```bash
# 克隆到临时位置
git clone https://github.com/lackeyjb/playwright-skill.git /tmp/playwright-skill-temp

# 仅将技能文件夹复制到您的项目中
mkdir -p .claude/skills
cp -r /tmp/playwright-skill-temp/skills/playwright-skill .claude/skills/

# 导航至该技能并运行 setup
cd .claude/skills/playwright-skill
npm run setup

# 清理临时文件
rm -rf /tmp/playwright-skill-temp
```

**为什么要采用这种结构？** 插件格式需要 `skills/` 目录来组织一个插件内的多个技能。作为独立技能安装时，您只需要内部的 `skills/playwright-skill/` 文件夹内容。

---

### 选项 3：下载发布版 (Release)

1. 从 [GitHub Releases](https://github.com/lackeyjb/playwright-skill/releases) 下载并解压最新版本。
2. 仅将 `skills/playwright-skill/` 文件夹复制到：
   - 全局：`~/.claude/skills/playwright-skill`
   - 项目：`/path/to/your/project/.claude/skills/playwright-skill`
3. 导航至该技能目录并运行 setup：
   ```bash
   cd ~/.claude/skills/playwright-skill  # 或您的项目路径
   npm run setup
   ```

---

### 验证安装

运行 `/help` 确认技能已加载，然后要求 Claude 执行一个简单的浏览器任务，例如“测试 google.com 是否能加载”。

## 快速开始

安装后，只需让 Claude 测试或自动化任何浏览器任务即可。Claude 将为该任务编写自定义的 Playwright 代码，执行它，并返回包含屏幕截图和控制台输出的结果。

## 使用示例

### 测试任何页面

```text
"测试主页"
"检查联系表单是否正常工作"
"验证注册流程"
```

### 视觉测试

```text
"在移动端和桌面端对仪表板进行截图"
"在不同视口之间测试响应式设计"
```

### 交互测试

```text
"填写注册表单并提交"
"点击浏览主导航"
"测试搜索功能"
```

### 验证

```text
"检查死链（失效链接）"
"验证所有图片是否加载"
"测试表单验证"
```

## 工作原理

1. 描述您想要测试或自动化的内容
2. Claude 为该任务编写自定义的 Playwright 代码
3. 通用执行器 (`run.js`) 结合正确的模块解析来运行它
4. 浏览器打开（默认可见）并执行自动化
5. 显示带有控制台输出和屏幕截图的结果

## 配置项

默认设置：

- **Headless（无头模式）:** `false`（浏览器可见，除非明确要求隐藏）
- **Slow Motion（慢动作）:** `100ms` 以便观察
- **Timeout（超时）:** `30s`
- **Screenshots（截图）:** 保存至 `/tmp/`

## 项目结构

```text
playwright-skill/
├── .claude-plugin/
│   ├── plugin.json          # 用于分发的插件元数据
│   └── marketplace.json     # 市场配置
├── skills/
│   └── playwright-skill/    # 实际的技能 (Claude 发现的是这个)
│       ├── SKILL.md         # Claude 阅读的内容
│       ├── run.js           # 通用执行器 (正确的模块解析)
│       ├── package.json     # 依赖项及 setup 脚本
│       └── lib/
│           └── helpers.js   # 可选的实用函数
│       └── API_REFERENCE.md # 完整的 Playwright API 参考
├── README.md                # 英文原版用户文档
├── CONTRIBUTING.md          # 贡献指南
└── LICENSE                  # MIT 许可证
```

## 进阶用法

当需要针对选择器、网络拦截、身份验证、视觉回归测试、移动设备模拟、性能测试和调试提供全面的文档时，Claude 将自动加载 `API_REFERENCE.md`。

## 依赖项

- Node.js
- Playwright (通过 `npm run setup` 安装)
- Chromium (通过 `npm run setup` 安装)

## 故障排除

**Playwright 未安装？**
导航至该技能目录并运行 `npm run setup`。

**找不到模块 (Module not found) 错误？**
确保自动化脚本是通过 `run.js` 运行的，它会处理模块的解析。

**浏览器未打开？**
验证是否设置了 `headless: false`。除非要求使用无头模式，否则该技能默认开启可见浏览器。

**安装所有浏览器？**
在该技能目录中运行 `npm run install-all-browsers`。

## 什么是 Skill (技能)？

[Agent Skills (智能体技能)](https://agentskills.io) 包含说明、脚本和资源的文件夹，智能体（Agents）可以发现并使用它们来更准确、更高效地执行任务。当您要求 Claude 测试网页或自动执行浏览器交互时，Claude 会发现此技能，加载必要的说明，执行自定义的 Playwright 代码，并返回包含屏幕截图和控制台输出的结果。

此 Playwright 技能实现了 [开放 Agent Skills 规范](https://agentskills.io)，使其兼容各种跨智能体平台。

## 贡献

欢迎参与贡献。请 Fork 该仓库，创建一个 feature 分支，进行您的更改，并提交 Pull Request。详情请参阅 [CONTRIBUTING.md](CONTRIBUTING.md)。

## 了解更多

- [Agent Skills 规范](https://agentskills.io) - 针对智能体技能的开放规范
- [Claude Code 技能文档](https://docs.claude.com/en/docs/claude-code/skills)
- [Claude Code 插件文档](https://docs.claude.com/en/docs/claude-code/plugins)
- [插件市场](https://docs.claude.com/en/docs/claude-code/plugin-marketplaces)
- [API_REFERENCE.md](skills/playwright-skill/API_REFERENCE.md) - 完整的 Playwright 文档
- [GitHub Issues](https://github.com/lackeyjb/playwright-skill/issues)

## 许可证

MIT License - 详情请见 [LICENSE](LICENSE) 文件。
