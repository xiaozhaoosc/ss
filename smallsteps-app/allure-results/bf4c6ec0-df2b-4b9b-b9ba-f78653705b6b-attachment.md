# Instructions

- Following Playwright test failed.
- Explain why, be concise, respect Playwright best practices.
- Provide a snippet of code with the fix, if possible.

# Test info

- Name: spec\parent-insights.spec.ts >> Parent Insights Tests >> Test emotion heatmap interactions
- Location: tests\e2e\spec\parent-insights.spec.ts:34:7

# Error details

```
Error: expect(received).not.toBe(expected) // Object.is equality

Expected: not ""
```

# Page snapshot

```yaml
- generic [ref=e3]:
  - generic [ref=e7]:
    - generic [ref=e8]:
      - generic [ref=e9]: 家长洞察
      - generic [ref=e12]: CN
    - generic [ref=e18]:
      - generic [ref=e19]:
        - generic [ref=e20]:
          - generic [ref=e21]: 每周重点
          - generic [ref=e22]:
            - generic [ref=e23]: 详情
            - generic [ref=e24]: ">"
        - generic [ref=e26]:
          - generic [ref=e27]:
            - generic [ref=e28]: 能力发展总览
            - generic [ref=e29]:
              - generic [ref=e30]: 总体良好
              - generic [ref=e31]:
                - generic [ref=e32]: ↑
                - generic [ref=e33]: +5%
          - generic [ref=e35]: 📊
      - generic [ref=e38]:
        - generic [ref=e39]: 月度情绪热力图
        - generic [ref=e40]:
          - generic [ref=e41]:
            - generic [ref=e42]: <
            - generic [ref=e43]: ">"
          - generic [ref=e44]:
            - generic [ref=e45]: 日
            - generic [ref=e46]: 一
            - generic [ref=e47]: 二
            - generic [ref=e48]: 三
            - generic [ref=e49]: 四
            - generic [ref=e50]: 五
            - generic [ref=e51]: 六
          - generic [ref=e52]:
            - generic [ref=e55]: 平静/开心
            - generic [ref=e58]: 兴奋
            - generic [ref=e61]: 一般
    - generic [ref=e62]:
      - generic [ref=e63] [cursor=pointer]:
        - generic [ref=e65]: 🏠
        - generic [ref=e66]: 首页
      - generic [ref=e67] [cursor=pointer]:
        - generic [ref=e69]: 📝
        - generic [ref=e70]: 任务
      - generic [ref=e71] [cursor=pointer]:
        - generic [ref=e73]: 📊
        - generic [ref=e74]: 洞察
      - generic [ref=e75] [cursor=pointer]:
        - generic [ref=e77]: 👤
        - generic [ref=e78]: 我的
  - generic [ref=e80]:
    - generic [ref=e83] [cursor=pointer]:
      - img [ref=e85]
      - generic [ref=e86]: 首页
    - generic [ref=e88] [cursor=pointer]:
      - img [ref=e90]
      - generic [ref=e91]: 任务
    - generic [ref=e93] [cursor=pointer]:
      - img [ref=e95]
      - generic [ref=e96]: 洞察
    - generic [ref=e98] [cursor=pointer]:
      - img [ref=e100]
      - generic [ref=e101]: 我的
```

# Test source

```ts
  1  | import { test, expect } from '@playwright/test';
  2  | import { LoginPage } from '../pages/LoginPage';
  3  | import { ParentInsightsPage } from '../pages/ParentInsightsPage';
  4  | import { ParentNavPage } from '../pages/ParentNavPage';
  5  | import { TEST_ACCOUNTS } from '../../fixtures/test-data';
  6  | 
  7  | test.describe('Parent Insights Tests', () => {
  8  |   let loginPage: LoginPage;
  9  |   let insightsPage: ParentInsightsPage;
  10 |   let navPage: ParentNavPage;
  11 | 
  12 |   test.beforeEach(async ({ page }) => {
  13 |     loginPage = new LoginPage(page);
  14 |     insightsPage = new ParentInsightsPage(page);
  15 |     navPage = new ParentNavPage(page);
  16 |     await loginPage.goto();
  17 |     await loginPage.login(TEST_ACCOUNTS.parent1.username, TEST_ACCOUNTS.parent1.password);
  18 |     await navPage.goToInsights();
  19 |   });
  20 | 
  21 |   test('Verify insights page loads correctly', async ({ page }) => {
  22 |     await expect(page).toHaveURL(/insights/);
  23 |     await expect(insightsPage.weeklyFocusSection).toBeVisible();
  24 |     await expect(insightsPage.abilityChart).toBeVisible();
  25 |     await expect(insightsPage.emotionHeatmap).toBeVisible();
  26 |   });
  27 | 
  28 |   test('Test weekly focus section', async ({ page }) => {
  29 |     await insightsPage.goToWeeklyReportDetails();
  30 |     await expect(page).toHaveURL(/weekly-report/);
  31 |     await page.goBack();
  32 |   });
  33 | 
  34 |   test('Test emotion heatmap interactions', async ({ page }) => {
  35 |     // 测试月份切换
  36 |     const initialMonth = await insightsPage.getCurrentMonth();
  37 |     await insightsPage.changeMonth('next');
  38 |     const nextMonth = await insightsPage.getCurrentMonth();
> 39 |     expect(nextMonth).not.toBe(initialMonth);
     |                           ^ Error: expect(received).not.toBe(expected) // Object.is equality
  40 | 
  41 |     await insightsPage.changeMonth('previous');
  42 |     const previousMonth = await insightsPage.getCurrentMonth();
  43 |     expect(previousMonth).toBe(initialMonth);
  44 | 
  45 |     // 测试日历点击
  46 |     const calendarDays = insightsPage.calendarDays;
  47 |     const count = await calendarDays.count();
  48 |     if (count > 0) {
  49 |       await insightsPage.clickCalendarDay(10);
  50 |       // 应该显示当天的情绪详情
  51 |     }
  52 |   });
  53 | 
  54 |   test('Test bottom navigation from insights', async ({ page }) => {
  55 |     await navPage.goToHome();
  56 |     await expect(page).toHaveURL(/dashboard/);
  57 | 
  58 |     await navPage.goToTaskCreator();
  59 |     await expect(page).toHaveURL(/task-creator/);
  60 | 
  61 |     await navPage.goToProfile();
  62 |     await expect(page).toHaveURL(/profile/);
  63 | 
  64 |     await navPage.goToInsights();
  65 |     await expect(page).toHaveURL(/insights/);
  66 |   });
  67 | });
  68 | 
```