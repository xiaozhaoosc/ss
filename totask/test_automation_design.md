# Small Steps 家长端自动化测试设计方案

## 1. 项目概述

本方案针对 Small Steps 项目的家长端应用进行完整的自动化测试，覆盖家长中心和洞察菜单的所有功能，确保每个页面的按钮和交互都得到充分测试。

## 2. 测试范围

### 2.1 测试目标
- 覆盖家长端所有核心功能
- 验证每个页面的按钮和交互
- 确保功能正常运行
- 记录发现的问题

### 2.2 测试环境
- **测试地址**: http://localhost:9090
- **测试工具**: Playwright + TypeScript
- **测试账号**:
  - 家长1: ken2zhao / admin123
  - 家长2: parent_zhang / admin123

## 3. 测试模块

### 3.1 家长中心模块 (Profile)
- ✅ 登录进入家长中心
- ✅ 孩子档案列表查看
- ✅ 添加孩子（跳转绑定页面）
- ✅ 编辑孩子档案
- ✅ 显示孩子二维码
- ✅ 通知设置（点击测试）
- ✅ 隐私政策（点击测试）
- ✅ 账号安全（点击测试）
- ✅ 帮助与反馈（点击测试）
- ✅ 退出登录（含确认弹窗）
- ✅ 底部导航栏切换

### 3.2 首页/仪表盘模块 (Dashboard)
- ✅ 页面加载和数据显示
- ✅ 通知铃铛点击
- ✅ 通知下拉菜单展开/收起
- ✅ 全部已读按钮
- ✅ AI洞察卡片点击
- ✅ 查看周报按钮
- ✅ 今日焦点详情跳转
- ✅ 执行记录查看全部跳转
- ✅ 统计数据卡片横向滚动
- ✅ 时间线项交互

### 3.3 任务创建模块 (Task Creator)
- ✅ 页面加载和表单显示
- ✅ 所有表单字段填写
- ✅ 步骤添加/编辑/删除
- ✅ 提交创建任务
- ✅ 取消操作

### 3.4 洞察菜单模块 (Insights)
- ✅ 每周重点卡片显示
- ✅ 能力发展图表显示
- ✅ 月度情绪热力图交互
- ✅ 月份切换（左右箭头）
- ✅ 查看周报详情跳转
- ✅ 底部导航栏切换

### 3.5 其他家长端页面
- ✅ 奖励配置页面
- ✅ 情绪详情页面
- ✅ 每周报告页面
- ✅ 情绪急救包页面
- ✅ 设备配置页面
- ✅ 执行记录页面
- ✅ 每日焦点页面
- ✅ 亲子契约页面

## 4. 架构设计

```
smallsteps-app/
├── tests/
│   ├── e2e/
│   │   ├── spec/
│   │   │   ├── parent-auth.spec.ts      # 认证测试
│   │   │   ├── parent-dashboard.spec.ts # 仪表盘测试
│   │   │   ├── parent-profile.spec.ts   # 家长中心测试
│   │   │   ├── parent-task.spec.ts      # 任务相关测试
│   │   │   ├── parent-insights.spec.ts  # 洞察菜单测试
│   │   │   └── parent-full.spec.ts      # 完整流程测试
│   │   └── pages/
│   │       ├── LoginPage.ts             # 登录页面POM
│   │       ├── ParentDashboardPage.ts   # 仪表盘POM
│   │       ├── ParentProfilePage.ts     # 家长中心POM
│   │       ├── ParentTaskPage.ts        # 任务页面POM
│   │       ├── ParentInsightsPage.ts    # 洞察页面POM
│   │       └── ParentNavPage.ts         # 导航组件POM
│   ├── fixtures/
│   │   └── test-data.ts                 # 测试数据
│   └── helpers/
│       ├── bug-reporter.ts              # Bug报告工具
│       └── test-utils.ts                # 测试工具函数
└── playwright.config.ts                 # 测试配置
```

## 5. Bug记录策略

每次发现问题时，按以下格式追加到 `bug_yyyyMMdd.md`：

```markdown
## [时间戳] - [简短描述]
- **页面**: [页面名称]
- **复现步骤**: 
  1. 
  2. 
  3. 
- **预期行为**: 
- **实际行为**: 
- **截图/视频**: [路径]
```

## 6. 执行计划

1. **环境准备**: 启动 H5 开发服务器
2. **测试执行**: 按模块顺序执行测试
3. **Bug记录**: 发现问题及时记录
4. **结果分析**: 生成测试报告
5. **总结**: 提供测试结果和建议

## 7. 技术栈

- **测试框架**: Playwright
- **语言**: TypeScript
- **报告工具**: Allure Playwright
- **设计模式**: Page Object Model (POM)
- **CI/CD**: 可集成到 GitHub Actions

## 8. 预期成果

- 完整的家长端功能测试覆盖
- 详细的测试报告
- 发现的问题记录
- 测试稳定性和可靠性提升

---

**执行日期**: 2026-04-27
**测试负责人**: TestMu AI
**项目**: Small Steps