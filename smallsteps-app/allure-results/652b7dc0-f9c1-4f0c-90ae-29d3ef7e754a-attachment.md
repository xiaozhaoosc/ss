# Instructions

- Following Playwright test failed.
- Explain why, be concise, respect Playwright best practices.
- Provide a snippet of code with the fix, if possible.

# Test info

- Name: spec\parent-dashboard.spec.ts >> Parent Dashboard Tests >> Verify dashboard page loads correctly
- Location: tests\e2e\spec\parent-dashboard.spec.ts:20:7

# Error details

```
Error: expect(locator).toBeVisible() failed

Locator: locator('ai-insight-card')
Expected: visible
Timeout: 5000ms
Error: element(s) not found

Call log:
  - Expect "toBeVisible" with timeout 5000ms
  - waiting for locator('ai-insight-card')

```

# Page snapshot

```yaml
- generic [ref=e3]:
  - generic [ref=e7]:
    - generic [ref=e8]:
      - generic [ref=e11]:
        - generic [ref=e12]: 欢迎回来,
        - generic [ref=e13]: 家长
      - generic [ref=e16]: notifications
    - generic [ref=e20]:
      - generic [ref=e21]:
        - generic [ref=e22]: 今日焦点
        - generic [ref=e23]: 详情
      - generic [ref=e28]:
        - generic [ref=e29]:
          - generic [ref=e32]: check_circle
          - generic [ref=e33]:
            - generic [ref=e34]: 任务总数
            - generic [ref=e35]:
              - generic [ref=e36]: "0"
              - generic [ref=e37]: 个
        - generic [ref=e38]:
          - generic [ref=e41]: emoji_events
          - generic [ref=e42]:
            - generic [ref=e43]: 奖励总数
            - generic [ref=e44]:
              - generic [ref=e45]: "0"
              - generic [ref=e46]: 个
      - generic [ref=e47]:
        - generic [ref=e48]: 执行记录
        - generic [ref=e49]: 查看全部
      - generic [ref=e51]:
        - generic [ref=e52]: history
        - generic [ref=e53]: 暂无执行记录
    - generic [ref=e54]:
      - generic [ref=e55] [cursor=pointer]:
        - generic [ref=e57]: 🏠
        - generic [ref=e58]: 首页
      - generic [ref=e59] [cursor=pointer]:
        - generic [ref=e61]: 📝
        - generic [ref=e62]: 任务
      - generic [ref=e63] [cursor=pointer]:
        - generic [ref=e65]: 📊
        - generic [ref=e66]: 洞察
      - generic [ref=e67] [cursor=pointer]:
        - generic [ref=e69]: 👤
        - generic [ref=e70]: 我的
  - generic [ref=e72]:
    - generic [ref=e75] [cursor=pointer]:
      - img [ref=e77]
      - generic [ref=e78]: 首页
    - generic [ref=e80] [cursor=pointer]:
      - img [ref=e82]
      - generic [ref=e83]: 任务
    - generic [ref=e85] [cursor=pointer]:
      - img [ref=e87]
      - generic [ref=e88]: 洞察
    - generic [ref=e90] [cursor=pointer]:
      - img [ref=e92]
      - generic [ref=e93]: 我的
```

# Test source

```ts
  1  | import { test, expect } from '@playwright/test';
  2  | import { LoginPage } from '../pages/LoginPage';
  3  | import { ParentDashboardPage } from '../pages/ParentDashboardPage';
  4  | import { ParentNavPage } from '../pages/ParentNavPage';
  5  | import { TEST_ACCOUNTS } from '../../fixtures/test-data';
  6  | 
  7  | test.describe('Parent Dashboard Tests', () => {
  8  |   let loginPage: LoginPage;
  9  |   let dashboardPage: ParentDashboardPage;
  10 |   let navPage: ParentNavPage;
  11 | 
  12 |   test.beforeEach(async ({ page }) => {
  13 |     loginPage = new LoginPage(page);
  14 |     dashboardPage = new ParentDashboardPage(page);
  15 |     navPage = new ParentNavPage(page);
  16 |     await loginPage.goto();
  17 |     await loginPage.login(TEST_ACCOUNTS.parent1.username, TEST_ACCOUNTS.parent1.password);
  18 |   });
  19 | 
  20 |   test('Verify dashboard page loads correctly', async ({ page }) => {
  21 |     await expect(page).toHaveURL(/dashboard/);
> 22 |     await expect(dashboardPage.aiInsightCard).toBeVisible();
     |                                               ^ Error: expect(locator).toBeVisible() failed
  23 |     await expect(dashboardPage.dailyFocusSection).toBeVisible();
  24 |     await expect(dashboardPage.execRecordSection).toBeVisible();
  25 |   });
  26 | 
  27 |   test('Test notification functionality', async ({ page }) => {
  28 |     await dashboardPage.toggleNotifications();
  29 |     await expect(dashboardPage.notificationDropdown).toBeVisible();
  30 | 
  31 |     // 测试全部已读
  32 |     await dashboardPage.markAllNotificationsAsRead();
  33 |     // 验证通知数量已重置
  34 |   });
  35 | 
  36 |   test('Test AI insight card interactions', async ({ page }) => {
  37 |     await dashboardPage.clickAiInsightCard();
  38 |     // 应该跳转到AI洞察详情页面
  39 |     await page.goBack();
  40 | 
  41 |     await dashboardPage.viewWeeklyReport();
  42 |     // 应该跳转到周报页面
  43 |     await page.goBack();
  44 |   });
  45 | 
  46 |   test('Test section navigation', async ({ page }) => {
  47 |     await dashboardPage.goToDailyFocusDetails();
  48 |     await expect(page).toHaveURL(/daily-focus/);
  49 |     await page.goBack();
  50 | 
  51 |     await dashboardPage.goToExecRecord();
  52 |     await expect(page).toHaveURL(/exec-record/);
  53 |     await page.goBack();
  54 |   });
  55 | 
  56 |   test('Test stats and timeline interactions', async ({ page }) => {
  57 |     // 测试统计数据横向滚动
  58 |     await dashboardPage.scrollStatsHorizontally();
  59 | 
  60 |     // 测试时间线点击
  61 |     const timelineItems = dashboardPage.timelineContainer.locator('.timeline-item');
  62 |     const count = await timelineItems.count();
  63 |     if (count > 0) {
  64 |       await dashboardPage.clickTimelineItem(0);
  65 |       // 应该显示详情或跳转到详情页面
  66 |     }
  67 |   });
  68 | 
  69 |   test('Test bottom navigation from dashboard', async ({ page }) => {
  70 |     await navPage.goToTaskCreator();
  71 |     await expect(page).toHaveURL(/task-creator/);
  72 | 
  73 |     await navPage.goToInsights();
  74 |     await expect(page).toHaveURL(/insights/);
  75 | 
  76 |     await navPage.goToProfile();
  77 |     await expect(page).toHaveURL(/profile/);
  78 | 
  79 |     await navPage.goToHome();
  80 |     await expect(page).toHaveURL(/dashboard/);
  81 |   });
  82 | });
  83 | 
```