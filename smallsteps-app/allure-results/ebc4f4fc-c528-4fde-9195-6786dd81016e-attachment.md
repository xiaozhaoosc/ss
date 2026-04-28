# Instructions

- Following Playwright test failed.
- Explain why, be concise, respect Playwright best practices.
- Provide a snippet of code with the fix, if possible.

# Test info

- Name: spec\parent-dashboard.spec.ts >> Parent Dashboard Tests >> Test notification functionality
- Location: tests\e2e\spec\parent-dashboard.spec.ts:27:7

# Error details

```
Error: page.waitForSelector: Unexpected token "=" while parsing css selector ".loading-container, text=加载中...". Did you mean to CSS.escape it?
Call log:
  - waiting for .loading-container, text=加载中... to be detached

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
  1  | import { Page, Locator } from '@playwright/test';
  2  | 
  3  | export class ParentDashboardPage {
  4  |   readonly page: Page;
  5  |   readonly notificationBell: Locator;
  6  |   readonly notificationDropdown: Locator;
  7  |   readonly markAllReadButton: Locator;
  8  |   readonly aiInsightCard: Locator;
  9  |   readonly dailyFocusDetailsLink: Locator;
  10 |   readonly execRecordViewAllLink: Locator;
  11 |   readonly statsContainer: Locator;
  12 |   readonly timelineContainer: Locator;
  13 | 
  14 |   constructor(page: Page) {
  15 |     this.page = page;
  16 |     this.notificationBell = page.locator('.icon-btn');
  17 |     this.notificationDropdown = page.locator('.notification-dropdown');
  18 |     this.markAllReadButton = page.getByText('全部已读');
  19 |     this.aiInsightCard = page.locator('ai-insight-card');
  20 |     this.dailyFocusDetailsLink = page.getByText('详情').first();
  21 |     this.execRecordViewAllLink = page.getByText('查看全部');
  22 |     this.statsContainer = page.locator('.stats-container');
  23 |     this.timelineContainer = page.locator('.timeline-container');
  24 |   }
  25 | 
  26 |   async goto() {
  27 |     await this.page.goto('/pages/parent/dashboard/index');
  28 |   }
  29 | 
  30 |   async waitForReady() {
> 31 |     await this.page.locator('.loading-container, text=加载中...').waitFor({ state: 'detached', timeout: 20000 }).catch(() => {});
     |                     ^ Error: page.waitForSelector: Unexpected token "=" while parsing css selector ".loading-container, text=加载中...". Did you mean to CSS.escape it?
  32 |     // AI 卡片可能是动态加载的
  33 |     await this.aiInsightCard.waitFor({ state: 'attached', timeout: 10000 }).catch(() => {});
  34 |   }
  35 | 
  36 |   async toggleNotifications() {
  37 |     await this.waitForReady();
  38 |     await this.notificationBell.waitFor({ state: 'visible' });
  39 |     await this.notificationBell.click({ force: true });
  40 |   }
  41 | 
  42 |   async markAllNotificationsAsRead() {
  43 |     await this.markAllReadButton.waitFor({ state: 'visible' });
  44 |     await this.markAllReadButton.click({ force: true });
  45 |   }
  46 | 
  47 |   async clickAiInsightCard() {
  48 |     await this.waitForReady();
  49 |     await this.aiInsightCard.waitFor({ state: 'visible' });
  50 |     await this.aiInsightCard.click({ force: true });
  51 |   }
  52 | 
  53 |   async goToDailyFocusDetails() {
  54 |     await this.waitForReady();
  55 |     await this.dailyFocusDetailsLink.waitFor({ state: 'visible' });
  56 |     await this.dailyFocusDetailsLink.click({ force: true });
  57 |   }
  58 | 
  59 |   async goToExecRecord() {
  60 |     await this.waitForReady();
  61 |     await this.execRecordViewAllLink.waitFor({ state: 'visible' });
  62 |     await this.execRecordViewAllLink.click({ force: true });
  63 |   }
  64 | 
  65 |   async scrollStatsHorizontally() {
  66 |     const statsScroll = this.page.locator('.stats-scroll');
  67 |     await statsScroll.hover();
  68 |     await this.page.mouse.move(100, 0);
  69 |     await this.page.mouse.down();
  70 |     await this.page.mouse.move(300, 0);
  71 |     await this.page.mouse.up();
  72 |   }
  73 | 
  74 |   async clickTimelineItem(index: number) {
  75 |     const timelineItems = this.timelineContainer.locator('timeline-item');
  76 |     await timelineItems.nth(index).click();
  77 |   }
  78 | }
  79 | 
```