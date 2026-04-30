# Small Steps App 自动化测试方案二次审查与优化

**日期**: 2026-04-29
**审查范围**: `smallsteps-app/tests/e2e/` 全量 Playwright E2E 测试代码
**状态**: 第二轮审查（首轮问题已修复确认）

---

## 一、首轮问题修复确认

首轮提出的 11 项问题，用户确认已全部修复。经代码验证，以下问题确实已解决：

| # | 问题 | 修复状态 |
|---|------|----------|
| 1 | 根目录与 smallsteps-app 存在两套 playwright.config.ts | [已修复] 仅保留 smallsteps-app/playwright.config.ts |
| 2 | vitest.config.ts 空壳 | [已修复] 已补充完整配置 |
| 3 | test:round 脚本引用不存在文件 | [已修复] 已创建 tests/scripts/run-test-round.js |
| 4 | 关键测试用例存在 waitForTimeout | [已修复] 关键路径已改为 waitForURL/waitForSelector |
| 5 | Page Object 方法未实现（存根注释） | [已修复] ParentDashboardPage 等 POM 已实现 |
| 6 | stabilize_data.spec.ts 替代 globalSetup | [已修复] 数据编排已移至 global-setup.ts |
| 7 | setupAutoCloseModal setInterval 反模式 | [已修复] 已移至 legacy-comprehensive.spec.ts 并 skip |
| 8 | 硬编码测试账号 | [已修复] 统一引用 tests/fixtures/test-data.ts |
| 9 | 无 API Mock 测试 | [已修复] 已添加 api-mock-demo.spec.ts |
| 10 | 无儿童端 POM | [已修复] 已添加 ChildHomePage.ts、ChildTaskExecutePage.ts |
| 11 | 根目录重复测试文件 | [已修复] 已删除根目录 tests |

---

## 二、本轮新发现的问题

### 问题 1 [严重]: POM 与测试用例不匹配 — 编译将失败

**文件**: `tests/e2e/spec/parent-dashboard.spec.ts`

**问题描述**: 测试用例引用了 `ParentDashboardPage` 中不存在的属性和方法：

```typescript
// parent-dashboard.spec.ts 第 22-23 行
await expect(dashboardPage.dailyFocusSection).toBeVisible();   // ❌ 不存在
await expect(dashboardPage.execRecordSection).toBeVisible();   // ❌ 不存在

// 第 40 行
await dashboardPage.viewWeeklyReport();                        // ❌ 不存在
```

**ParentDashboardPage.ts 实际定义的成员**:
- `notificationBell`, `notificationDropdown`, `aiInsightCard`
- `dailyFocusDetailsLink`, `execRecordViewAllLink`, `statsContainer`, `timelineContainer`
- 方法: `waitForReady()`, `toggleNotifications()`, `goToDailyFocusDetails()`, `goToExecRecord()` 等

**影响**: TypeScript 编译失败，测试无法运行。

**修复方案**: 在 `ParentDashboardPage.ts` 中补充缺失成员：

```typescript
// 新增属性
readonly dailyFocusSection = this.page.locator('.daily-focus-section');
readonly execRecordSection = this.page.locator('.exec-record-section');

// 新增方法
async viewWeeklyReport() {
  await this.page.locator('.weekly-report-btn').click();
}
```

或者修改测试用例，使用已有的 POM 成员（如 `goToDailyFocusDetails()` 替代直接断言 section 可见性）。

---

### 问题 2 [中等]: 全局 waitForTimeout 泛滥 — 90+ 处

**问题描述**: 虽然首轮修复了"关键路径"的 `waitForTimeout`，但全量扫描发现仍有 **90+ 处** 存在，分布如下：

| 文件 | 数量 | 典型值 |
|------|------|--------|
| `adhd-scaffolding.spec.ts` | 15 | 500-3000ms |
| `shadow-detection.spec.ts` | ~10 | 1000-3000ms |
| `shadow-emotion-detection.spec.ts` | ~10 | 1000-2000ms |
| `shadow-fast-track.spec.ts` | ~10 | 500-2000ms |
| `shadow-insights.spec.ts` | ~10 | 1000-3000ms |
| `parent-insights-deep.spec.ts` | ~5 | 1000-2000ms |
| `parent-emotion-deep.spec.ts` | ~5 | 1000-3000ms |
| `parent-reward-deep.spec.ts` | ~12 | 1000-3000ms |
| `parent-other-deep.spec.ts` | ~5 | 1000-2000ms |
| `parent-profile-deep.spec.ts` | ~3 | 1000-2000ms |
| `global-setup.ts` | 2 | 1000-3000ms |
| `FamilyCreatePage.ts` | 3 | 1000-2000ms |
| `game-energy.spec.ts` | 1 | 6000ms |
| `legacy-verify-converter.spec.ts` | 2 | 1000ms |

**影响**:
- 测试不稳定（flaky）：网络快时白等，网络慢时不够等
- 测试执行慢：90 个 waitForTimeout 平均浪费 1.5s = 额外 2+ 分钟
- 维护成本高：每个超时值都需要人工判断

**修复方案**:

**策略 A — 优先级驱动（推荐）**:
1. 高频执行的核心路径（child-task-lifecycle、parent-dashboard、reward-config）：全部替换为显式等待
2. 低频探索性测试（shadow-*、*-deep）：保留但添加 TODO 标记，逐步迁移

**策略 B — 工具函数封装**:
```typescript
// tests/e2e/utils/wait-helpers.ts
export async function waitForStable(page: Page, selector: string, ms = 500) {
  // 等待元素出现后，再等 ms 无变化
  await page.waitForSelector(selector);
  await page.waitForTimeout(ms);
}
```

**策略 C — 禁用 waitForTimeout（激进）**:
在 playwright.config.ts 中添加 lint 规则或 pre-commit hook 检测。

---

### 问题 3 [低]: 占位测试未清理

**文件**: `tests/e2e/spec/simple.spec.ts`

```typescript
// 当前内容：导航到 baidu.com，非业务测试
await page.goto('https://www.baidu.com');
await expect(page).toHaveTitle(/百度/);
```

**影响**: 浪费 CI 时间，无业务价值。

**修复方案**: 删除此文件，或改为应用健康检查：
```typescript
test('App loads successfully', async ({ page }) => {
  await page.goto('/');
  await expect(page).toHaveURL(/login/);
});
```

---

### 问题 4 [低]: Legacy 测试仍含硬编码 URL

**文件**:
- `legacy-comprehensive.spec.ts` 第 15 行: `const MOBILE_URL = 'http://localhost:9090'`
- `legacy-verify-converter.spec.ts` 第 8 行: `await page.goto('http://localhost:9090/#/login')`

**影响**: 与 `playwright.config.ts` 的 `baseURL: 'http://127.0.0.1:9090'` 不一致，若端口变更需改多处。

**修复方案**: 使用 `page.goto('/')` + config 中的 baseURL，或引用环境变量。

---

### 问题 5 [低]: global-setup.ts 仍有硬编码等待

**文件**: `tests/e2e/global-setup.ts`

```typescript
// 第 99 行
await page.waitForTimeout(3000); // Increased wait

// 第 127 行
await page.waitForTimeout(1000); // Wait for modal to clear
```

**影响**: global-setup 每次测试前运行，3s + 1s = 4s 固定浪费。

**修复方案**:
```typescript
// 第 99 行 → 等待任务卡片出现
await missionCard.waitFor({ state: 'visible', timeout: 10000 });

// 第 127 行 → 等待 modal 消失
await page.locator('.uni-modal').waitFor({ state: 'hidden', timeout: 5000 });
```

---

## 三、优化建议汇总

| 优先级 | 问题 | 修复方案 | 预计工作量 |
|--------|------|----------|-----------|
| P0 | POM-测试不匹配 | 补充 ParentDashboardPage 缺失成员 | 30min |
| P1 | 90+ waitForTimeout | 核心路径替换为显式等待，其余加 TODO | 4h |
| P2 | simple.spec.ts 占位 | 删除或改为健康检查 | 5min |
| P2 | Legacy 硬编码 URL | 统一使用 baseURL | 15min |
| P2 | global-setup 硬编码等待 | 替换为 waitForSelector | 15min |

---

## 四、测试覆盖度评估

### 当前覆盖的场景

| 模块 | 测试文件 | 覆盖场景 |
|------|----------|----------|
| 登录认证 | parent-auth.spec.ts | 家长登录、注册导航 |
| 家长看板 | parent-dashboard.spec.ts | 通知、AI洞察、数据区 |
| 儿童任务 | child-task-lifecycle.spec.ts | 任务启动、完成、奖励领取 |
| API Mock | api-mock-demo.spec.ts | 空列表、500 错误 |
| 游戏能量 | game-energy.spec.ts | 能量消耗 |
| 树洞倾诉 | treehole-deep.spec.ts | AI 共情回复 |
| 家庭创建 | (global-setup) | 创建家庭、邀请 |

### 缺失的高价值场景

1. **积分商城兑换流程** — 积分扣减 + 奖励发放 + 库存校验
2. **家长任务审批流** — 提交 → 待审批 → 批准/拒绝 → 积分变更
3. **多设备并发** — 家长和儿童同时操作同一任务
4. **数据边界** — 积分为 0 时兑换、任务重复完成、过期任务处理
5. **离线/弱网** — 硬件终端断网重连后状态同步

---

## 五、结论

首轮修复解决了基础设施层面的 11 项重大问题（配置冲突、POM 缺失、数据编排等），测试框架已具备可运行能力。

本轮发现的核心遗留问题是 **POM-测试用例不匹配**（编译失败）和 **waitForTimeout 泛滥**（稳定性风险）。建议优先修复 P0 问题以确保测试可运行，再逐步清理 waitForTimeout 以提升稳定性。

---

**审查人**: Claude Code
**审查日期**: 2026-04-29
**下一步**: 修复 P0 问题，运行 `npm run test:e2e` 验证
