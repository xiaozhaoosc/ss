# Instructions

- Following Playwright test failed.
- Explain why, be concise, respect Playwright best practices.
- Provide a snippet of code with the fix, if possible.

# Test info

- Name: spec\parent-insights.spec.ts >> Parent Insights Tests >> Test weekly focus section
- Location: tests\e2e\spec\parent-insights.spec.ts:28:7

# Error details

```
Test timeout of 30000ms exceeded while running "beforeEach" hook.
```

```
Error: locator.click: Test timeout of 30000ms exceeded.
Call log:
  - waiting for getByText('洞察')
    - locator resolved to <div class="uni-tabbar__label">洞察</div>
  - attempting click action
    2 × waiting for element to be visible, enabled and stable
      - element is not visible
    - retrying click action
    - waiting 20ms
    2 × waiting for element to be visible, enabled and stable
      - element is not visible
    - retrying click action
      - waiting 100ms
    - waiting for element to be visible, enabled and stable
    - element is not visible
  - retrying click action
    - waiting 500ms
    - waiting for element to be visible, enabled and stable
    - element is visible, enabled and stable
    - scrolling into view if needed
    - done scrolling
    - <span>洞察</span> from <uni-page type="tabBar" data-page="pages/parent/dashboard/index">…</uni-page> subtree intercepts pointer events
  55 × retrying click action
       - waiting 500ms
       - waiting for element to be visible, enabled and stable
       - element is visible, enabled and stable
       - scrolling into view if needed
       - done scrolling
       - <div class="uni-mask"></div> from <div id="u-a-m" data-v-app="">…</div> subtree intercepts pointer events
  - retrying click action
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
  3  | export class ParentNavPage {
  4  |   readonly page: Page;
  5  |   readonly homeTab: Locator;
  6  |   readonly taskTab: Locator;
  7  |   readonly insightsTab: Locator;
  8  |   readonly profileTab: Locator;
  9  | 
  10 |   constructor(page: Page) {
  11 |     this.page = page;
  12 |     this.homeTab = page.getByText('首页');
  13 |     this.taskTab = page.getByText('任务');
  14 |     this.insightsTab = page.getByText('洞察');
  15 |     this.profileTab = page.getByText('我的');
  16 |   }
  17 | 
  18 |   async goToHome() {
  19 |     await this.homeTab.click();
  20 |   }
  21 | 
  22 |   async goToTaskCreator() {
  23 |     await this.taskTab.click();
  24 |   }
  25 | 
  26 |   async goToInsights() {
> 27 |     await this.insightsTab.click();
     |                            ^ Error: locator.click: Test timeout of 30000ms exceeded.
  28 |   }
  29 | 
  30 |   async goToProfile() {
  31 |     await this.profileTab.click();
  32 |   }
  33 | }
  34 | 
```