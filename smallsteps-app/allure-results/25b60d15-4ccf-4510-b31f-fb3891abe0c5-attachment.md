# Instructions

- Following Playwright test failed.
- Explain why, be concise, respect Playwright best practices.
- Provide a snippet of code with the fix, if possible.

# Test info

- Name: spec\parent-insights-deep.spec.ts >> 洞察菜单深度测试 >> 底部导航栏测试
- Location: tests\e2e\spec\parent-insights-deep.spec.ts:98:7

# Error details

```
Test timeout of 30000ms exceeded.
```

```
Error: locator.click: Test timeout of 30000ms exceeded.
Call log:
  - waiting for getByText('首页')
    - locator resolved to <div class="uni-tabbar__label">首页</div>
  - attempting click action
    2 × waiting for element to be visible, enabled and stable
      - element is not visible
    - retrying click action
    - waiting 20ms
    2 × waiting for element to be visible, enabled and stable
      - element is not visible
    - retrying click action
      - waiting 100ms
    24 × waiting for element to be visible, enabled and stable
       - element is not visible
     - retrying click action
       - waiting 500ms

```

# Page snapshot

```yaml
- generic [ref=e4]:
  - generic [ref=e8]: 登录
  - generic [ref=e12]:
    - generic [ref=e17]:
      - generic [ref=e18]: Small Steps
      - generic [ref=e19]: 每一次进步，都值得被看见
    - generic [ref=e20]:
      - generic [ref=e21]: 欢迎回来
      - generic [ref=e22]:
        - generic [ref=e23]:
          - generic [ref=e24]: 
          - generic [ref=e26]:
            - generic: 账号
            - textbox [ref=e27]
        - generic [ref=e28]:
          - generic [ref=e29]: 
          - generic [ref=e31]:
            - generic: 密码
            - textbox [ref=e32]
      - generic [ref=e34] [cursor=pointer]:
        - generic [ref=e35]: 
        - generic [ref=e38]: 记住密码
      - generic [ref=e39]:
        - generic [ref=e40] [cursor=pointer]: 登 录
        - generic [ref=e41]:
          - generic [ref=e42]: 注册账号
          - generic [ref=e43]: "|"
          - generic [ref=e44]: 忘记密码?
    - generic [ref=e46]:
      - generic [ref=e47]: 登录即代表同意
      - generic [ref=e48]: 《用户协议》
      - generic [ref=e49]: "&"
      - generic [ref=e50]: 《隐私协议》
```

# Test source

```ts
  1   | import { test, expect } from '@playwright/test';
  2   | import { LoginPage } from '../pages/LoginPage';
  3   | import { TEST_ACCOUNTS } from '../../fixtures/test-data';
  4   | 
  5   | test.describe('洞察菜单深度测试', () => {
  6   |   let loginPage: LoginPage;
  7   | 
  8   |   test.beforeEach(async ({ page }) => {
  9   |     loginPage = new LoginPage(page);
  10  |     await loginPage.goto();
  11  |     await loginPage.login(TEST_ACCOUNTS.parent1.username, TEST_ACCOUNTS.parent1.password);
  12  |     await page.goto('/pages/parent/insights/index');
  13  |     await page.waitForLoadState('networkidle');
  14  |   });
  15  | 
  16  |   test('洞察页面基本元素验证', async ({ page }) => {
  17  |     // 验证页面加载
  18  |     await expect(page).toHaveURL(/insights/);
  19  | 
  20  |     // 验证页面标题
  21  |     await expect(page.locator('.section-title').first()).toBeVisible();
  22  | 
  23  |     // 验证底部导航栏
  24  |     await expect(page.getByText('首页')).toBeVisible();
  25  |     await expect(page.getByText('任务')).toBeVisible();
  26  |     await expect(page.getByText('洞察')).toBeVisible();
  27  |     await expect(page.getByText('我的')).toBeVisible();
  28  |   });
  29  | 
  30  |   test('每周重点卡片测试', async ({ page }) => {
  31  |     // 查找每周重点卡片
  32  |     const weeklyFocusSection = page.locator('.section:has-text("每周重点")');
  33  | 
  34  |     if (await weeklyFocusSection.count() > 0) {
  35  |       await expect(weeklyFocusSection).toBeVisible();
  36  | 
  37  |       // 测试详情链接
  38  |       const detailsLink = weeklyFocusSection.getByText('详情');
  39  |       if (await detailsLink.count() > 0) {
  40  |         await detailsLink.click();
  41  |         // 可能跳转到周报详情页面
  42  |         await page.waitForTimeout(1000);
  43  |       }
  44  |     }
  45  |   });
  46  | 
  47  |   test('能力发展图表测试', async ({ page }) => {
  48  |     // 查找图表容器
  49  |     const chartContainer = page.locator('.chart-container, .ability-chart, .progress-chart');
  50  | 
  51  |     if (await chartContainer.count() > 0) {
  52  |       await expect(chartContainer.first()).toBeVisible();
  53  |     }
  54  | 
  55  |     // 查找进度项
  56  |     const progressItems = page.locator('.progress-item, .chart-item, .stat-item');
  57  |     const count = await progressItems.count();
  58  |     if (count > 0) {
  59  |       // 验证至少有一些进度项可见
  60  |       await expect(progressItems.first()).toBeVisible();
  61  |     }
  62  |   });
  63  | 
  64  |   test('月度情绪热力图测试', async ({ page }) => {
  65  |     // 查找日历卡片
  66  |     const calendarCard = page.locator('.calendar-card, .emotion-heatmap');
  67  | 
  68  |     if (await calendarCard.count() > 0) {
  69  |       await expect(calendarCard).toBeVisible();
  70  | 
  71  |       // 查找月份切换按钮
  72  |       const prevButton = calendarCard.locator('.nav-arrow, .prev-month, .arrow-left').first();
  73  |       const nextButton = calendarCard.locator('.nav-arrow, .next-month, .arrow-right').first();
  74  | 
  75  |       // 测试上个月切换
  76  |       if (await prevButton.count() > 0) {
  77  |         await prevButton.click();
  78  |         await page.waitForTimeout(500);
  79  |       }
  80  | 
  81  |       // 测试下个月切换
  82  |       if (await nextButton.count() > 0) {
  83  |         await nextButton.click();
  84  |         await page.waitForTimeout(500);
  85  |       }
  86  | 
  87  |       // 查找日历日期
  88  |       const calendarDays = calendarCard.locator('.day-cell, .calendar-day, .day');
  89  |       const dayCount = await calendarDays.count();
  90  |       if (dayCount > 0) {
  91  |         // 点击某个日期
  92  |         await calendarDays.nth(10).click();
  93  |         await page.waitForTimeout(500);
  94  |       }
  95  |     }
  96  |   });
  97  | 
  98  |   test('底部导航栏测试', async ({ page }) => {
  99  |     // 导航到首页
> 100 |     await page.getByText('首页').click();
      |                                ^ Error: locator.click: Test timeout of 30000ms exceeded.
  101 |     await expect(page).toHaveURL(/dashboard/);
  102 | 
  103 |     // 导航到任务
  104 |     await page.getByText('任务').click();
  105 |     await expect(page).toHaveURL(/task-creator/);
  106 | 
  107 |     // 导航到我的
  108 |     await page.getByText('我的').click();
  109 |     await expect(page).toHaveURL(/profile/);
  110 | 
  111 |     // 返回洞察
  112 |     await page.getByText('洞察').click();
  113 |     await expect(page).toHaveURL(/insights/);
  114 |   });
  115 | 
  116 |   test('周报详情页面测试', async ({ page }) => {
  117 |     // 查找查看周报按钮
  118 |     const weeklyReportBtn = page.getByText('查看周报');
  119 | 
  120 |     if (await weeklyReportBtn.count() > 0) {
  121 |       await weeklyReportBtn.click();
  122 |       await page.waitForTimeout(1000);
  123 | 
  124 |       // 验证跳转
  125 |       if (page.url().includes('weekly-report')) {
  126 |         await expect(page).toHaveURL(/weekly-report/);
  127 |       }
  128 |     }
  129 |   });
  130 | 
  131 |   test('情绪急救包测试', async ({ page }) => {
  132 |     // 查找情绪急救包入口
  133 |     const emergencyKit = page.getByText('情绪急救包');
  134 | 
  135 |     if (await emergencyKit.count() > 0) {
  136 |       await emergencyKit.click();
  137 |       await page.waitForTimeout(1000);
  138 | 
  139 |       // 验证跳转
  140 |       if (page.url().includes('emotion')) {
  141 |         await expect(page).toHaveURL(/emotion/);
  142 |       }
  143 |     }
  144 |   });
  145 | 
  146 |   test('数据加载等待测试', async ({ page }) => {
  147 |     // 刷新页面
  148 |     await page.reload();
  149 |     await page.waitForLoadState('networkidle');
  150 | 
  151 |     // 验证页面关键元素已加载
  152 |     await expect(page).toHaveURL(/insights/);
  153 | 
  154 |     // 等待数据加载
  155 |     await page.waitForTimeout(3000);
  156 | 
  157 |     // 验证图表或数据已显示
  158 |     const chartsOrData = page.locator('.chart, .data-card, .stat-card');
  159 |     if (await chartsOrData.count() > 0) {
  160 |       await expect(chartsOrData.first()).toBeVisible();
  161 |     }
  162 |   });
  163 | });
  164 | 
```