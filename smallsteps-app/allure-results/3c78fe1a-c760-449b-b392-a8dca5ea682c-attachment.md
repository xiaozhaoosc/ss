# Instructions

- Following Playwright test failed.
- Explain why, be concise, respect Playwright best practices.
- Provide a snippet of code with the fix, if possible.

# Test info

- Name: spec\parent-dashboard.spec.ts >> Parent Dashboard Tests >> Test bottom navigation from dashboard
- Location: tests\e2e\spec\parent-dashboard.spec.ts:69:7

# Error details

```
Test timeout of 30000ms exceeded.
```

```
Error: locator.click: Test timeout of 30000ms exceeded.
Call log:
  - waiting for getByText('我的')
    - locator resolved to <div class="uni-tabbar__label">我的</div>
  - attempting click action
    2 × waiting for element to be visible, enabled and stable
      - element is visible, enabled and stable
      - scrolling into view if needed
      - done scrolling
      - <div class="uni-mask"></div> from <div id="u-a-m" data-v-app="">…</div> subtree intercepts pointer events
    - retrying click action
    - waiting 20ms
    2 × waiting for element to be visible, enabled and stable
      - element is visible, enabled and stable
      - scrolling into view if needed
      - done scrolling
      - <div class="uni-mask"></div> from <div id="u-a-m" data-v-app="">…</div> subtree intercepts pointer events
    - retrying click action
      - waiting 100ms
    38 × waiting for element to be visible, enabled and stable
       - element is visible, enabled and stable
       - scrolling into view if needed
       - done scrolling
       - <div class="uni-mask"></div> from <div id="u-a-m" data-v-app="">…</div> subtree intercepts pointer events
     - retrying click action
       - waiting 500ms
    - waiting for element to be visible, enabled and stable

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
                - generic [ref=e41]: 65%
                - generic [ref=e42]: 数学
              - generic [ref=e43]:
                - generic [ref=e46]: 42%
                - generic [ref=e47]: 社交
              - generic [ref=e48]:
                - generic [ref=e51]: 85%
                - generic [ref=e52]: 专注
              - generic [ref=e53]:
                - generic [ref=e56]: 30%
                - generic [ref=e57]: 创造
        - generic [ref=e58]:
          - generic [ref=e59]: 月度情绪热力图
          - generic [ref=e60]:
            - generic [ref=e61]:
              - generic [ref=e62]: <
              - generic [ref=e63]: 2026年 4月
              - generic [ref=e64]: ">"
            - generic [ref=e65]:
              - generic [ref=e66]: 日
              - generic [ref=e67]: 一
              - generic [ref=e68]: 二
              - generic [ref=e69]: 三
              - generic [ref=e70]: 四
              - generic [ref=e71]: 五
              - generic [ref=e72]: 六
            - generic [ref=e73]:
              - generic [ref=e78]: "1"
              - generic [ref=e80]: "2"
              - generic [ref=e82]: "3"
              - generic [ref=e84]: "4"
              - generic [ref=e86]: "5"
              - generic [ref=e88]: "6"
              - generic [ref=e90]: "7"
              - generic [ref=e92]: "8"
              - generic [ref=e94]: "9"
              - generic [ref=e96]: "10"
              - generic [ref=e98]: "11"
              - generic [ref=e100]: "12"
              - generic [ref=e102]: "13"
              - generic [ref=e104]: "14"
              - generic [ref=e106]: "15"
              - generic [ref=e108]: "16"
              - generic [ref=e110]: "17"
              - generic [ref=e112]: "18"
              - generic [ref=e114]: "19"
              - generic [ref=e116]: "20"
              - generic [ref=e118]: "21"
              - generic [ref=e120]: "22"
              - generic [ref=e122]: "23"
              - generic [ref=e124]: "24"
              - generic [ref=e126]: "25"
              - generic [ref=e128]: "26"
              - generic [ref=e130]: "27"
              - generic [ref=e132]: "28"
              - generic [ref=e134]: "29"
              - generic [ref=e136]: "30"
            - generic [ref=e137]:
              - generic [ref=e140]: 平静/开心
              - generic [ref=e143]: 兴奋
              - generic [ref=e146]: 一般
      - generic [ref=e147]:
        - generic [ref=e148] [cursor=pointer]:
          - generic [ref=e150]: 🏠
          - generic [ref=e151]: 首页
        - generic [ref=e152] [cursor=pointer]:
          - generic [ref=e154]: 📝
          - generic [ref=e155]: 任务
        - generic [ref=e156] [cursor=pointer]:
          - generic [ref=e158]: 📊
          - generic [ref=e159]: 洞察
        - generic [ref=e160] [cursor=pointer]:
          - generic [ref=e162]: 👤
          - generic [ref=e163]: 我的
    - generic [ref=e165]:
      - generic [ref=e168] [cursor=pointer]:
        - img [ref=e170]
        - generic [ref=e171]: 首页
      - generic [ref=e173] [cursor=pointer]:
        - img [ref=e175]
        - generic [ref=e176]: 任务
      - generic [ref=e178] [cursor=pointer]:
        - img [ref=e180]
        - generic [ref=e181]: 洞察
      - generic [ref=e183] [cursor=pointer]:
        - img [ref=e185]
        - generic [ref=e186]: 我的
  - generic [ref=e190]:
    - strong [ref=e192]: 系统提示
    - generic [ref=e193]: "Handler dispatch failed: java.lang.Error: Unresolved compilation problems: The import com.kenzhao.smallsteps.common.mybatis cannot be resolved The method equals(Object) of type ChildTask must override or implement a supertype method The method hashCode() of type ChildTask must override or implement a supertype method BaseEntity cannot be resolved to a type"
    - generic [ref=e195] [cursor=pointer]: 知道了
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
  27 |     await this.insightsTab.click();
  28 |   }
  29 | 
  30 |   async goToProfile() {
> 31 |     await this.profileTab.click();
     |                           ^ Error: locator.click: Test timeout of 30000ms exceeded.
  32 |   }
  33 | }
  34 | 
```