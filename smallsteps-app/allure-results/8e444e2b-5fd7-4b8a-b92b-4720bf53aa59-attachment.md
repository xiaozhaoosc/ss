# Instructions

- Following Playwright test failed.
- Explain why, be concise, respect Playwright best practices.
- Provide a snippet of code with the fix, if possible.

# Test info

- Name: spec\parent-dashboard.spec.ts >> Parent Dashboard Tests >> Test stats and timeline interactions
- Location: tests\e2e\spec\parent-dashboard.spec.ts:56:7

# Error details

```
Test timeout of 30000ms exceeded.
```

```
Error: locator.hover: Test timeout of 30000ms exceeded.
Call log:
  - waiting for locator('.stats-scroll')
    - locator resolved to <uni-scroll-view data-v-bd9dca71="" class="stats-scroll no-scrollbar">…</uni-scroll-view>
  - attempting hover action
    2 × waiting for element to be visible and stable
      - element is visible and stable
      - scrolling into view if needed
      - done scrolling
      - <div class="uni-modal__bd">Handler dispatch failed: java.lang.Error: Unresol…</div> from <div id="u-a-m" data-v-app="">…</div> subtree intercepts pointer events
    - retrying hover action
    - waiting 20ms
    - waiting for element to be visible and stable
    - element is visible and stable
    - scrolling into view if needed
    - done scrolling
    - <div class="uni-modal__bd">Handler dispatch failed: java.lang.Error: Unresol…</div> from <div id="u-a-m" data-v-app="">…</div> subtree intercepts pointer events
  2 × retrying hover action
      - waiting 100ms
      - waiting for element to be visible and stable
      - element is visible and stable
      - scrolling into view if needed
      - done scrolling
      - <strong class="uni-modal__title">系统提示</strong> from <div id="u-a-m" data-v-app="">…</div> subtree intercepts pointer events
  9 × retrying hover action
      - waiting 500ms
      - waiting for element to be visible and stable
      - element is visible and stable
      - scrolling into view if needed
      - done scrolling
      - <div class="uni-modal__bd">Handler dispatch failed: java.lang.Error: Unresol…</div> from <div id="u-a-m" data-v-app="">…</div> subtree intercepts pointer events
    - retrying hover action
      - waiting 500ms
      - waiting for element to be visible and stable
      - element is visible and stable
      - scrolling into view if needed
      - done scrolling
      - <div class="uni-modal__bd">Handler dispatch failed: java.lang.Error: Unresol…</div> from <div id="u-a-m" data-v-app="">…</div> subtree intercepts pointer events
    - retrying hover action
      - waiting 500ms
      - waiting for element to be visible and stable
      - element is visible and stable
      - scrolling into view if needed
      - done scrolling
      - <strong class="uni-modal__title">系统提示</strong> from <div id="u-a-m" data-v-app="">…</div> subtree intercepts pointer events
    - retrying hover action
      - waiting 500ms
      - waiting for element to be visible and stable
      - element is visible and stable
      - scrolling into view if needed
      - done scrolling
      - <strong class="uni-modal__title">系统提示</strong> from <div id="u-a-m" data-v-app="">…</div> subtree intercepts pointer events
  - retrying hover action
    - waiting 500ms

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
  - generic [ref=e97]:
    - strong [ref=e99]: 系统提示
    - generic [ref=e100]: "Handler dispatch failed: java.lang.Error: Unresolved compilation problems: The import com.kenzhao.smallsteps.common.mybatis cannot be resolved The method equals(Object) of type ChildTask must override or implement a supertype method The method hashCode() of type ChildTask must override or implement a supertype method BaseEntity cannot be resolved to a type"
    - generic [ref=e102] [cursor=pointer]: 知道了
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
  9  |   readonly viewWeeklyButton: Locator;
  10 |   readonly dailyFocusSection: Locator;
  11 |   readonly dailyFocusDetailsLink: Locator;
  12 |   readonly execRecordSection: Locator;
  13 |   readonly execRecordViewAllLink: Locator;
  14 |   readonly statsContainer: Locator;
  15 |   readonly timelineContainer: Locator;
  16 | 
  17 |   constructor(page: Page) {
  18 |     this.page = page;
  19 |     this.notificationBell = page.getByRole('button', { name: 'notifications' });
  20 |     this.notificationDropdown = page.locator('.notification-dropdown');
  21 |     this.markAllReadButton = page.getByText('全部已读');
  22 |     this.aiInsightCard = page.locator('ai-insight-card');
  23 |     this.viewWeeklyButton = page.getByText('查看周报');
  24 |     this.dailyFocusSection = page.locator('.section-header:has-text("今日焦点")');
  25 |     this.dailyFocusDetailsLink = this.dailyFocusSection.getByText('详情');
  26 |     this.execRecordSection = page.locator('.section-header:has-text("执行记录")');
  27 |     this.execRecordViewAllLink = this.execRecordSection.getByText('查看全部');
  28 |     this.statsContainer = page.locator('.stats-container');
  29 |     this.timelineContainer = page.locator('.timeline-container');
  30 |   }
  31 | 
  32 |   async goto() {
  33 |     await this.page.goto('/pages/parent/dashboard/index');
  34 |   }
  35 | 
  36 |   async toggleNotifications() {
  37 |     await this.notificationBell.click();
  38 |   }
  39 | 
  40 |   async markAllNotificationsAsRead() {
  41 |     await this.markAllReadButton.click();
  42 |   }
  43 | 
  44 |   async clickAiInsightCard() {
  45 |     await this.aiInsightCard.click();
  46 |   }
  47 | 
  48 |   async viewWeeklyReport() {
  49 |     await this.viewWeeklyButton.click();
  50 |   }
  51 | 
  52 |   async goToDailyFocusDetails() {
  53 |     await this.dailyFocusDetailsLink.click();
  54 |   }
  55 | 
  56 |   async goToExecRecord() {
  57 |     await this.execRecordViewAllLink.click();
  58 |   }
  59 | 
  60 |   async scrollStatsHorizontally() {
  61 |     const statsScroll = this.page.locator('.stats-scroll');
> 62 |     await statsScroll.hover();
     |                       ^ Error: locator.hover: Test timeout of 30000ms exceeded.
  63 |     await this.page.mouse.move(100, 0);
  64 |     await this.page.mouse.down();
  65 |     await this.page.mouse.move(300, 0);
  66 |     await this.page.mouse.up();
  67 |   }
  68 | 
  69 |   async clickTimelineItem(index: number) {
  70 |     const timelineItems = this.timelineContainer.locator('.timeline-item');
  71 |     await timelineItems.nth(index).click();
  72 |   }
  73 | }
  74 | 
```