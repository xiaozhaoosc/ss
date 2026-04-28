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
- generic [active] [ref=e1]:
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
        - generic [ref=e50]:
          - generic [ref=e51]:
            - generic [ref=e53]: task
            - generic [ref=e54]:
              - generic [ref=e55]:
                - generic [ref=e56]: 20:24
                - generic [ref=e57]: 已完成
              - generic [ref=e58]: 数学作业
              - generic [ref=e59]: 任务记录
          - generic [ref=e60]:
            - generic [ref=e62]: task
            - generic [ref=e63]:
              - generic [ref=e64]:
                - generic [ref=e65]: 20:24
                - generic [ref=e66]: 已完成
              - generic [ref=e67]: 阅读30分钟
              - generic [ref=e68]: 任务记录
          - generic [ref=e69]:
            - generic [ref=e71]: task
            - generic [ref=e72]:
              - generic [ref=e73]:
                - generic [ref=e74]: 20:24
                - generic [ref=e75]: 已完成
              - generic [ref=e76]: 数学作业
              - generic [ref=e77]: 任务记录
          - generic [ref=e78]:
            - generic [ref=e80]: task
            - generic [ref=e81]:
              - generic [ref=e82]:
                - generic [ref=e83]: 20:24
                - generic [ref=e84]: 已完成
              - generic [ref=e85]: 早起刷牙
              - generic [ref=e86]: 任务记录
          - generic [ref=e87]:
            - generic [ref=e89]: task
            - generic [ref=e90]:
              - generic [ref=e91]:
                - generic [ref=e92]: 20:24
                - generic [ref=e93]: 已完成
              - generic [ref=e94]: 数学作业
              - generic [ref=e95]: 任务记录
          - generic [ref=e96]:
            - generic [ref=e98]: task
            - generic [ref=e99]:
              - generic [ref=e100]:
                - generic [ref=e101]: 20:24
                - generic [ref=e102]: 已完成
              - generic [ref=e103]: 数学作业
              - generic [ref=e104]: 任务记录
          - generic [ref=e105]:
            - generic [ref=e107]: task
            - generic [ref=e108]:
              - generic [ref=e109]:
                - generic [ref=e110]: 20:24
                - generic [ref=e111]: 已完成
              - generic [ref=e112]: 早起刷牙
              - generic [ref=e113]: 任务记录
          - generic [ref=e114]:
            - generic [ref=e116]: task
            - generic [ref=e117]:
              - generic [ref=e118]:
                - generic [ref=e119]: 20:24
                - generic [ref=e120]: 已完成
              - generic [ref=e121]: 数学作业
              - generic [ref=e122]: 任务记录
          - generic [ref=e123]:
            - generic [ref=e125]: task
            - generic [ref=e126]:
              - generic [ref=e127]:
                - generic [ref=e128]: 20:24
                - generic [ref=e129]: 已完成
              - generic [ref=e130]: 数学作业
              - generic [ref=e131]: 任务记录
          - generic [ref=e132]:
            - generic [ref=e134]: task
            - generic [ref=e135]:
              - generic [ref=e136]:
                - generic [ref=e137]: 20:24
                - generic [ref=e138]: 已完成
              - generic [ref=e139]: 早起刷牙
              - generic [ref=e140]: 任务记录
          - generic [ref=e141]:
            - generic [ref=e143]: task
            - generic [ref=e144]:
              - generic [ref=e145]:
                - generic [ref=e146]: 20:24
                - generic [ref=e147]: 已完成
              - generic [ref=e148]: 数学作业
              - generic [ref=e149]: 任务记录
          - generic [ref=e150]:
            - generic [ref=e152]: task
            - generic [ref=e153]:
              - generic [ref=e154]:
                - generic [ref=e155]: 20:24
                - generic [ref=e156]: 已完成
              - generic [ref=e157]: 早起刷牙
              - generic [ref=e158]: 任务记录
          - generic [ref=e159]:
            - generic [ref=e161]: task
            - generic [ref=e162]:
              - generic [ref=e163]:
                - generic [ref=e164]: 20:24
                - generic [ref=e165]: 已完成
              - generic [ref=e166]: 整理房间
              - generic [ref=e167]: 任务记录
          - generic [ref=e168]:
            - generic [ref=e170]: task
            - generic [ref=e171]:
              - generic [ref=e172]:
                - generic [ref=e173]: 20:24
                - generic [ref=e174]: 已完成
              - generic [ref=e175]: 整理房间
              - generic [ref=e176]: 任务记录
          - generic [ref=e177]:
            - generic [ref=e179]: task
            - generic [ref=e180]:
              - generic [ref=e181]:
                - generic [ref=e182]: 20:24
                - generic [ref=e183]: 已完成
              - generic [ref=e184]: 数学作业
              - generic [ref=e185]: 任务记录
          - generic [ref=e186]:
            - generic [ref=e188]: task
            - generic [ref=e189]:
              - generic [ref=e190]:
                - generic [ref=e191]: 20:24
                - generic [ref=e192]: 已完成
              - generic [ref=e193]: 数学作业
              - generic [ref=e194]: 任务记录
          - generic [ref=e195]:
            - generic [ref=e197]: task
            - generic [ref=e198]:
              - generic [ref=e199]:
                - generic [ref=e200]: 20:24
                - generic [ref=e201]: 已完成
              - generic [ref=e202]: 数学作业
              - generic [ref=e203]: 任务记录
          - generic [ref=e204]:
            - generic [ref=e206]: task
            - generic [ref=e207]:
              - generic [ref=e208]:
                - generic [ref=e209]: 20:24
                - generic [ref=e210]: 已完成
              - generic [ref=e211]: 早起刷牙
              - generic [ref=e212]: 任务记录
          - generic [ref=e213]:
            - generic [ref=e215]: task
            - generic [ref=e216]:
              - generic [ref=e217]:
                - generic [ref=e218]: 20:24
                - generic [ref=e219]: 已完成
              - generic [ref=e220]: 阅读30分钟
              - generic [ref=e221]: 任务记录
          - generic [ref=e222]:
            - generic [ref=e224]: task
            - generic [ref=e225]:
              - generic [ref=e226]:
                - generic [ref=e227]: 20:24
                - generic [ref=e228]: 已完成
              - generic [ref=e229]: 阅读30分钟
              - generic [ref=e230]: 任务记录
          - generic [ref=e231]:
            - generic [ref=e233]: task
            - generic [ref=e234]:
              - generic [ref=e235]:
                - generic [ref=e236]: 20:24
                - generic [ref=e237]: 已完成
              - generic [ref=e238]: 早起刷牙
              - generic [ref=e239]: 任务记录
          - generic [ref=e240]:
            - generic [ref=e242]: task
            - generic [ref=e243]:
              - generic [ref=e244]:
                - generic [ref=e245]: 20:24
                - generic [ref=e246]: 已完成
              - generic [ref=e247]: 数学作业
              - generic [ref=e248]: 任务记录
          - generic [ref=e249]:
            - generic [ref=e251]: task
            - generic [ref=e252]:
              - generic [ref=e253]:
                - generic [ref=e254]: 20:24
                - generic [ref=e255]: 已完成
              - generic [ref=e256]: 早起刷牙
              - generic [ref=e257]: 任务记录
      - generic [ref=e258]:
        - generic [ref=e259] [cursor=pointer]:
          - generic [ref=e261]: 🏠
          - generic [ref=e262]: 首页
        - generic [ref=e263] [cursor=pointer]:
          - generic [ref=e265]: 📝
          - generic [ref=e266]: 任务
        - generic [ref=e267] [cursor=pointer]:
          - generic [ref=e269]: 📊
          - generic [ref=e270]: 洞察
        - generic [ref=e271] [cursor=pointer]:
          - generic [ref=e273]: 👤
          - generic [ref=e274]: 我的
    - generic [ref=e276]:
      - generic [ref=e279] [cursor=pointer]:
        - img [ref=e281]
        - generic [ref=e282]: 首页
      - generic [ref=e284] [cursor=pointer]:
        - img [ref=e286]
        - generic [ref=e287]: 任务
      - generic [ref=e289] [cursor=pointer]:
        - img [ref=e291]
        - generic [ref=e292]: 洞察
      - generic [ref=e294] [cursor=pointer]:
        - img [ref=e296]
        - generic [ref=e297]: 我的
  - generic:
    - generic:
      - generic:
        - paragraph: 加载中...
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