# Instructions

- Following Playwright test failed.
- Explain why, be concise, respect Playwright best practices.
- Provide a snippet of code with the fix, if possible.

# Test info

- Name: spec\parent-insights.spec.ts >> Parent Insights Tests >> Test bottom navigation from insights
- Location: tests\e2e\spec\parent-insights.spec.ts:54:7

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
    34 × waiting for element to be visible, enabled and stable
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
> 19 |     await this.homeTab.click();
     |                        ^ Error: locator.click: Test timeout of 30000ms exceeded.
  20 |   }
  21 | 
  22 |   async goToTaskCreator() {
  23 |     await this.taskTab.click();
  24 |   }
  25 | 
  26 |   async goToInsights() {
  27 |     await this.insightsTab.click();
  28 |   }
  29 | 
  30 |   async goToProfile() {
  31 |     await this.profileTab.click();
  32 |   }
  33 | }
  34 | 
```