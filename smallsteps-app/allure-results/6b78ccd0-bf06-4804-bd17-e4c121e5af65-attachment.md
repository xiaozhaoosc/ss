# Instructions

- Following Playwright test failed.
- Explain why, be concise, respect Playwright best practices.
- Provide a snippet of code with the fix, if possible.

# Test info

- Name: spec\parent-insights.spec.ts >> Parent Insights Tests >> Test weekly focus section
- Location: tests\e2e\spec\parent-insights.spec.ts:28:7

# Error details

```
Error: expect(page).toHaveURL(expected) failed

Expected pattern: /weekly-report/
Received string:  "http://localhost:9090/pages/login/index#/pages/parent/insights/index"
Timeout: 5000ms

Call log:
  - Expect "toHaveURL" with timeout 5000ms
    8 × unexpected value "http://localhost:9090/pages/login/index#/pages/parent/insights/index"

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
          - generic [ref=e25]:
            - generic [ref=e26]:
              - generic [ref=e27]:
                - generic [ref=e28]: 能力发展总览
                - generic [ref=e29]:
                  - generic [ref=e30]: 总体良好
                  - generic [ref=e31]:
                    - generic [ref=e32]: ↑
                    - generic [ref=e33]: +5%
              - generic [ref=e35]: 📊
            - generic [ref=e37]:
              - generic [ref=e38]:
                - generic [ref=e41]: 78%
                - generic [ref=e42]: 专注力
              - generic [ref=e43]:
                - generic [ref=e46]: 0%
                - generic [ref=e47]: 执行力
              - generic [ref=e48]:
                - generic [ref=e51]: 65%
                - generic [ref=e52]: 创造力
              - generic [ref=e53]:
                - generic [ref=e56]: 70%
                - generic [ref=e57]: 社交能力
              - generic [ref=e58]:
                - generic [ref=e61]: 75%
                - generic [ref=e62]: 情绪管理
              - generic [ref=e63]:
                - generic [ref=e66]: 80%
                - generic [ref=e67]: 学习能力
        - generic [ref=e68]:
          - generic [ref=e69]: 月度情绪热力图
          - generic [ref=e70]:
            - generic [ref=e71]:
              - generic [ref=e72]: <
              - generic [ref=e73]: 2026年 4月
              - generic [ref=e74]: ">"
            - generic [ref=e75]:
              - generic [ref=e76]: 日
              - generic [ref=e77]: 一
              - generic [ref=e78]: 二
              - generic [ref=e79]: 三
              - generic [ref=e80]: 四
              - generic [ref=e81]: 五
              - generic [ref=e82]: 六
            - generic [ref=e83]:
              - generic [ref=e88]: "1"
              - generic [ref=e91]: "2"
              - generic [ref=e94]: "3"
              - generic [ref=e97]: "4"
              - generic [ref=e100]: "5"
              - generic [ref=e103]: "6"
              - generic [ref=e106]: "7"
              - generic [ref=e109]: "8"
              - generic [ref=e112]: "9"
              - generic [ref=e115]: "10"
              - generic [ref=e118]: "11"
              - generic [ref=e121]: "12"
              - generic [ref=e124]: "13"
              - generic [ref=e127]: "14"
              - generic [ref=e130]: "15"
              - generic [ref=e133]: "16"
              - generic [ref=e136]: "17"
              - generic [ref=e139]: "18"
              - generic [ref=e142]: "19"
              - generic [ref=e145]: "20"
              - generic [ref=e148]: "21"
              - generic [ref=e151]: "22"
              - generic [ref=e154]: "23"
              - generic [ref=e157]: "24"
              - generic [ref=e160]: "25"
              - generic [ref=e163]: "26"
              - generic [ref=e165]: "27"
              - generic [ref=e167]: "28"
              - generic [ref=e169]: "29"
              - generic [ref=e171]: "30"
            - generic [ref=e172]:
              - generic [ref=e175]: 平静/开心
              - generic [ref=e178]: 兴奋
              - generic [ref=e181]: 一般
      - generic [ref=e182]:
        - generic [ref=e183] [cursor=pointer]:
          - generic [ref=e185]: 🏠
          - generic [ref=e186]: 首页
        - generic [ref=e187] [cursor=pointer]:
          - generic [ref=e189]: 📝
          - generic [ref=e190]: 任务
        - generic [ref=e191] [cursor=pointer]:
          - generic [ref=e193]: 📊
          - generic [ref=e194]: 洞察
        - generic [ref=e195] [cursor=pointer]:
          - generic [ref=e197]: 👤
          - generic [ref=e198]: 我的
    - generic [ref=e200]:
      - generic [ref=e203] [cursor=pointer]:
        - img [ref=e205]
        - generic [ref=e206]: 首页
      - generic [ref=e208] [cursor=pointer]:
        - img [ref=e210]
        - generic [ref=e211]: 任务
      - generic [ref=e213] [cursor=pointer]:
        - img [ref=e215]
        - generic [ref=e216]: 洞察
      - generic [ref=e218] [cursor=pointer]:
        - img [ref=e220]
        - generic [ref=e221]: 我的
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
> 30 |     await expect(page).toHaveURL(/weekly-report/);
     |                        ^ Error: expect(page).toHaveURL(expected) failed
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