# Instructions

- Following Playwright test failed.
- Explain why, be concise, respect Playwright best practices.
- Provide a snippet of code with the fix, if possible.

# Test info

- Name: spec\parent-insights-deep.spec.ts >> 洞察菜单深度测试 >> 底部导航栏测试
- Location: tests\e2e\spec\parent-insights-deep.spec.ts:104:7

# Error details

```
Test timeout of 30000ms exceeded.
```

```
Error: locator.click: Test timeout of 30000ms exceeded.
Call log:
  - waiting for locator('.uni-tabbar').getByText('首页', { exact: true }).first()
    - locator resolved to <div class="uni-tabbar__label">首页</div>
  - attempting click action
    2 × waiting for element to be visible, enabled and stable
      - element is visible, enabled and stable
      - scrolling into view if needed
      - done scrolling
      - <span>首页</span> from <uni-page type="tabBar" data-page="pages/parent/insights/index">…</uni-page> subtree intercepts pointer events
    - retrying click action
    - waiting 20ms
    2 × waiting for element to be visible, enabled and stable
      - element is visible, enabled and stable
      - scrolling into view if needed
      - done scrolling
      - <span>首页</span> from <uni-page type="tabBar" data-page="pages/parent/insights/index">…</uni-page> subtree intercepts pointer events
    - retrying click action
      - waiting 100ms
    48 × waiting for element to be visible, enabled and stable
       - element is visible, enabled and stable
       - scrolling into view if needed
       - done scrolling
       - <span>首页</span> from <uni-page type="tabBar" data-page="pages/parent/insights/index">…</uni-page> subtree intercepts pointer events
     - retrying click action
       - waiting 500ms

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
```

# Test source

```ts
  6   | test.describe('洞察菜单深度测试', () => {
  7   |   let loginPage: LoginPage;
  8   |   let navPage: ParentNavPage;
  9   | 
  10  |   test.beforeEach(async ({ page }) => {
  11  |     loginPage = new LoginPage(page);
  12  |     navPage = new ParentNavPage(page);
  13  |     await loginPage.goto();
  14  |     await loginPage.login(TEST_ACCOUNTS.parent1.username, TEST_ACCOUNTS.parent1.password);
  15  |     
  16  |     // 确保登录成功后再跳转，或者直接使用导航组件跳转
  17  |     await navPage.insightsTab.click();
  18  |     await page.waitForURL(/insights/);
  19  |     await page.waitForLoadState('networkidle');
  20  |   });
  21  | 
  22  |   test('洞察页面基本元素验证', async ({ page }) => {
  23  |     // 验证页面加载
  24  |     await expect(page).toHaveURL(/insights/);
  25  | 
  26  |     // 验证页面标题
  27  |     await expect(page.locator('.section-title').first()).toBeVisible();
  28  | 
  29  |     // 验证底部导航栏
  30  |     await expect(navPage.homeTab).toBeVisible();
  31  |     await expect(navPage.taskTab).toBeVisible();
  32  |     await expect(navPage.insightsTab).toBeVisible();
  33  |     await expect(navPage.profileTab).toBeVisible();
  34  |   });
  35  | 
  36  |   test('每周重点卡片测试', async ({ page }) => {
  37  |     // 查找每周重点卡片
  38  |     const weeklyFocusSection = page.locator('.section:has-text("每周重点")');
  39  | 
  40  |     if (await weeklyFocusSection.count() > 0) {
  41  |       await expect(weeklyFocusSection).toBeVisible();
  42  | 
  43  |       // 测试详情链接
  44  |       const detailsLink = weeklyFocusSection.getByText('详情');
  45  |       if (await detailsLink.count() > 0) {
  46  |         await detailsLink.click();
  47  |         // 可能跳转到周报详情页面
  48  |         await page.waitForTimeout(1000);
  49  |       }
  50  |     }
  51  |   });
  52  | 
  53  |   test('能力发展图表测试', async ({ page }) => {
  54  |     // 查找图表容器
  55  |     const chartContainer = page.locator('.chart-container, .ability-chart, .progress-chart');
  56  | 
  57  |     if (await chartContainer.count() > 0) {
  58  |       await expect(chartContainer.first()).toBeVisible();
  59  |     }
  60  | 
  61  |     // 查找进度项
  62  |     const progressItems = page.locator('.progress-item, .chart-item, .stat-item');
  63  |     const count = await progressItems.count();
  64  |     if (count > 0) {
  65  |       // 验证至少有一些进度项可见
  66  |       await expect(progressItems.first()).toBeVisible();
  67  |     }
  68  |   });
  69  | 
  70  |   test('月度情绪热力图测试', async ({ page }) => {
  71  |     // 查找日历卡片
  72  |     const calendarCard = page.locator('.calendar-card, .emotion-heatmap');
  73  | 
  74  |     if (await calendarCard.count() > 0) {
  75  |       await expect(calendarCard).toBeVisible();
  76  | 
  77  |       // 查找月份切换按钮
  78  |       const prevButton = calendarCard.locator('.nav-arrow, .prev-month, .arrow-left').first();
  79  |       const nextButton = calendarCard.locator('.nav-arrow, .next-month, .arrow-right').first();
  80  | 
  81  |       // 测试上个月切换
  82  |       if (await prevButton.count() > 0) {
  83  |         await prevButton.click();
  84  |         await page.waitForTimeout(500);
  85  |       }
  86  | 
  87  |       // 测试下个月切换
  88  |       if (await nextButton.count() > 0) {
  89  |         await nextButton.click();
  90  |         await page.waitForTimeout(500);
  91  |       }
  92  | 
  93  |       // 查找日历日期
  94  |       const calendarDays = calendarCard.locator('.day-cell, .calendar-day, .day');
  95  |       const dayCount = await calendarDays.count();
  96  |       if (dayCount > 0) {
  97  |         // 点击某个日期
  98  |         await calendarDays.nth(10).click();
  99  |         await page.waitForTimeout(500);
  100 |       }
  101 |     }
  102 |   });
  103 | 
  104 |   test('底部导航栏测试', async ({ page }) => {
  105 |     // 导航到首页
> 106 |     await navPage.homeTab.click();
      |                           ^ Error: locator.click: Test timeout of 30000ms exceeded.
  107 |     await expect(page).toHaveURL(/dashboard/);
  108 | 
  109 |     // 导航到任务
  110 |     await navPage.taskTab.click();
  111 |     await expect(page).toHaveURL(/task-creator/);
  112 | 
  113 |     // 导航到我的
  114 |     await navPage.profileTab.click();
  115 |     await expect(page).toHaveURL(/profile/);
  116 | 
  117 |     // 返回洞察
  118 |     await navPage.insightsTab.click();
  119 |     await expect(page).toHaveURL(/insights/);
  120 |   });
  121 | 
  122 |   test('周报详情页面测试', async ({ page }) => {
  123 |     // 查找查看周报按钮
  124 |     const weeklyReportBtn = page.getByText('查看周报');
  125 | 
  126 |     if (await weeklyReportBtn.count() > 0) {
  127 |       await weeklyReportBtn.click();
  128 |       await page.waitForTimeout(1000);
  129 | 
  130 |       // 验证跳转
  131 |       if (page.url().includes('weekly-report')) {
  132 |         await expect(page).toHaveURL(/weekly-report/);
  133 |       }
  134 |     }
  135 |   });
  136 | 
  137 |   test('情绪急救包测试', async ({ page }) => {
  138 |     // 查找情绪急救包入口
  139 |     const emergencyKit = page.getByText('情绪急救包');
  140 | 
  141 |     if (await emergencyKit.count() > 0) {
  142 |       await emergencyKit.click();
  143 |       await page.waitForTimeout(1000);
  144 | 
  145 |       // 验证跳转
  146 |       if (page.url().includes('emotion')) {
  147 |         await expect(page).toHaveURL(/emotion/);
  148 |       }
  149 |     }
  150 |   });
  151 | 
  152 |   test('数据加载等待测试', async ({ page }) => {
  153 |     // 刷新页面
  154 |     await page.reload();
  155 |     await page.waitForLoadState('networkidle');
  156 | 
  157 |     // 验证页面关键元素已加载
  158 |     await expect(page).toHaveURL(/insights/);
  159 | 
  160 |     // 等待数据加载
  161 |     await page.waitForTimeout(3000);
  162 | 
  163 |     // 验证图表或数据已显示
  164 |     const chartsOrData = page.locator('.chart, .data-card, .stat-card');
  165 |     if (await chartsOrData.count() > 0) {
  166 |       await expect(chartsOrData.first()).toBeVisible();
  167 |     }
  168 |   });
  169 | });
  170 | 
```