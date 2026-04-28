# Instructions

- Following Playwright test failed.
- Explain why, be concise, respect Playwright best practices.
- Provide a snippet of code with the fix, if possible.

# Test info

- Name: spec\parent-insights.spec.ts >> Parent Insights Tests >> Test emotion heatmap interactions
- Location: tests\e2e\spec\parent-insights.spec.ts:34:7

# Error details

```
Error: expect(received).toBe(expected) // Object.is equality

Expected: ""
Received: "2026年 4月"
```

# Page snapshot

```yaml
- generic [active] [ref=e1]:
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
              - generic [ref=e43]: 2026年 4月
              - generic [ref=e44]: ">"
            - generic [ref=e45]:
              - generic [ref=e46]: 日
              - generic [ref=e47]: 一
              - generic [ref=e48]: 二
              - generic [ref=e49]: 三
              - generic [ref=e50]: 四
              - generic [ref=e51]: 五
              - generic [ref=e52]: 六
            - generic [ref=e53]:
              - generic [ref=e58]: "1"
              - generic [ref=e60]: "2"
              - generic [ref=e62]: "3"
              - generic [ref=e64]: "4"
              - generic [ref=e66]: "5"
              - generic [ref=e68]: "6"
              - generic [ref=e70]: "7"
              - generic [ref=e72]: "8"
              - generic [ref=e74]: "9"
              - generic [ref=e76]: "10"
              - generic [ref=e78]: "11"
              - generic [ref=e80]: "12"
              - generic [ref=e82]: "13"
              - generic [ref=e84]: "14"
              - generic [ref=e86]: "15"
              - generic [ref=e88]: "16"
              - generic [ref=e90]: "17"
              - generic [ref=e92]: "18"
              - generic [ref=e94]: "19"
              - generic [ref=e96]: "20"
              - generic [ref=e98]: "21"
              - generic [ref=e100]: "22"
              - generic [ref=e102]: "23"
              - generic [ref=e104]: "24"
              - generic [ref=e106]: "25"
              - generic [ref=e108]: "26"
              - generic [ref=e110]: "27"
              - generic [ref=e112]: "28"
              - generic [ref=e114]: "29"
              - generic [ref=e116]: "30"
            - generic [ref=e117]:
              - generic [ref=e120]: 平静/开心
              - generic [ref=e123]: 兴奋
              - generic [ref=e126]: 一般
      - generic [ref=e127]:
        - generic [ref=e128] [cursor=pointer]:
          - generic [ref=e130]: 🏠
          - generic [ref=e131]: 首页
        - generic [ref=e132] [cursor=pointer]:
          - generic [ref=e134]: 📝
          - generic [ref=e135]: 任务
        - generic [ref=e136] [cursor=pointer]:
          - generic [ref=e138]: 📊
          - generic [ref=e139]: 洞察
        - generic [ref=e140] [cursor=pointer]:
          - generic [ref=e142]: 👤
          - generic [ref=e143]: 我的
    - generic [ref=e145]:
      - generic [ref=e148] [cursor=pointer]:
        - img [ref=e150]
        - generic [ref=e151]: 首页
      - generic [ref=e153] [cursor=pointer]:
        - img [ref=e155]
        - generic [ref=e156]: 任务
      - generic [ref=e158] [cursor=pointer]:
        - img [ref=e160]
        - generic [ref=e161]: 洞察
      - generic [ref=e163] [cursor=pointer]:
        - img [ref=e165]
        - generic [ref=e166]: 我的
  - generic:
    - generic:
      - generic:
        - paragraph: 加载中...
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
  39 |     expect(nextMonth).not.toBe(initialMonth);
  40 | 
  41 |     await insightsPage.changeMonth('previous');
  42 |     const previousMonth = await insightsPage.getCurrentMonth();
> 43 |     expect(previousMonth).toBe(initialMonth);
     |                           ^ Error: expect(received).toBe(expected) // Object.is equality
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