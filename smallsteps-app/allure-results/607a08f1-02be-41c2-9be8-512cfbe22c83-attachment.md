# Instructions

- Following Playwright test failed.
- Explain why, be concise, respect Playwright best practices.
- Provide a snippet of code with the fix, if possible.

# Test info

- Name: spec\parent-profile.spec.ts >> Parent Profile Tests >> Test child management
- Location: tests\e2e\spec\parent-profile.spec.ts:26:7

# Error details

```
Test timeout of 30000ms exceeded while running "beforeEach" hook.
```

```
Error: locator.click: Test timeout of 30000ms exceeded.
Call log:
  - waiting for getByText('我的')
    - locator resolved to <div class="uni-tabbar__label">我的</div>
  - attempting click action
    2 × waiting for element to be visible, enabled and stable
      - element is not visible
    - retrying click action
    - waiting 20ms
    - waiting for element to be visible, enabled and stable
    - element is not stable
  - retrying click action
    - waiting 100ms
    - waiting for element to be visible, enabled and stable
    - element is visible, enabled and stable
    - scrolling into view if needed
    - done scrolling
    - performing click action
    - <span>我的</span> from <uni-page type="tabBar" data-page="pages/parent/dashboard/index">…</uni-page> subtree intercepts pointer events
  - retrying click action
    - waiting 100ms
    30 × waiting for element to be visible, enabled and stable
       - element is visible, enabled and stable
       - scrolling into view if needed
       - done scrolling
       - <span>我的</span> from <uni-page type="tabBar" data-page="pages/parent/dashboard/index">…</uni-page> subtree intercepts pointer events
     - retrying click action
       - waiting 500ms

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
    - generic [ref=e21]:
      - generic [ref=e22]:
        - generic [ref=e23]: 今日焦点
        - generic [ref=e24]: 详情
      - generic [ref=e29]:
        - generic [ref=e30]:
          - generic [ref=e33]: check_circle
          - generic [ref=e34]:
            - generic [ref=e35]: 任务总数
            - generic [ref=e36]:
              - generic [ref=e37]: "0"
              - generic [ref=e38]: 个
        - generic [ref=e39]:
          - generic [ref=e42]: emoji_events
          - generic [ref=e43]:
            - generic [ref=e44]: 奖励总数
            - generic [ref=e45]:
              - generic [ref=e46]: "1"
              - generic [ref=e47]: 个
      - generic [ref=e48]:
        - generic [ref=e49]: 执行记录
        - generic [ref=e50]: 查看全部
      - generic [ref=e51]:
        - generic [ref=e52]:
          - generic [ref=e54]: task
          - generic [ref=e55]:
            - generic [ref=e56]:
              - generic [ref=e57]: 20:24
              - generic [ref=e58]: 已完成
            - generic [ref=e59]: 数学作业
            - generic [ref=e60]: 任务记录
        - generic [ref=e61]:
          - generic [ref=e63]: task
          - generic [ref=e64]:
            - generic [ref=e65]:
              - generic [ref=e66]: 20:24
              - generic [ref=e67]: 已完成
            - generic [ref=e68]: 阅读30分钟
            - generic [ref=e69]: 任务记录
        - generic [ref=e70]:
          - generic [ref=e72]: task
          - generic [ref=e73]:
            - generic [ref=e74]:
              - generic [ref=e75]: 20:24
              - generic [ref=e76]: 已完成
            - generic [ref=e77]: 数学作业
            - generic [ref=e78]: 任务记录
        - generic [ref=e79]:
          - generic [ref=e81]: task
          - generic [ref=e82]:
            - generic [ref=e83]:
              - generic [ref=e84]: 20:24
              - generic [ref=e85]: 已完成
            - generic [ref=e86]: 早起刷牙
            - generic [ref=e87]: 任务记录
        - generic [ref=e88]:
          - generic [ref=e90]: task
          - generic [ref=e91]:
            - generic [ref=e92]:
              - generic [ref=e93]: 20:24
              - generic [ref=e94]: 已完成
            - generic [ref=e95]: 数学作业
            - generic [ref=e96]: 任务记录
        - generic [ref=e97]:
          - generic [ref=e99]: task
          - generic [ref=e100]:
            - generic [ref=e101]:
              - generic [ref=e102]: 20:24
              - generic [ref=e103]: 已完成
            - generic [ref=e104]: 数学作业
            - generic [ref=e105]: 任务记录
        - generic [ref=e106]:
          - generic [ref=e108]: task
          - generic [ref=e109]:
            - generic [ref=e110]:
              - generic [ref=e111]: 20:24
              - generic [ref=e112]: 已完成
            - generic [ref=e113]: 早起刷牙
            - generic [ref=e114]: 任务记录
        - generic [ref=e115]:
          - generic [ref=e117]: task
          - generic [ref=e118]:
            - generic [ref=e119]:
              - generic [ref=e120]: 20:24
              - generic [ref=e121]: 已完成
            - generic [ref=e122]: 数学作业
            - generic [ref=e123]: 任务记录
        - generic [ref=e124]:
          - generic [ref=e126]: task
          - generic [ref=e127]:
            - generic [ref=e128]:
              - generic [ref=e129]: 20:24
              - generic [ref=e130]: 已完成
            - generic [ref=e131]: 数学作业
            - generic [ref=e132]: 任务记录
        - generic [ref=e133]:
          - generic [ref=e135]: task
          - generic [ref=e136]:
            - generic [ref=e137]:
              - generic [ref=e138]: 20:24
              - generic [ref=e139]: 已完成
            - generic [ref=e140]: 早起刷牙
            - generic [ref=e141]: 任务记录
        - generic [ref=e142]:
          - generic [ref=e144]: task
          - generic [ref=e145]:
            - generic [ref=e146]:
              - generic [ref=e147]: 20:24
              - generic [ref=e148]: 已完成
            - generic [ref=e149]: 数学作业
            - generic [ref=e150]: 任务记录
        - generic [ref=e151]:
          - generic [ref=e153]: task
          - generic [ref=e154]:
            - generic [ref=e155]:
              - generic [ref=e156]: 20:24
              - generic [ref=e157]: 已完成
            - generic [ref=e158]: 早起刷牙
            - generic [ref=e159]: 任务记录
        - generic [ref=e160]:
          - generic [ref=e162]: task
          - generic [ref=e163]:
            - generic [ref=e164]:
              - generic [ref=e165]: 20:24
              - generic [ref=e166]: 已完成
            - generic [ref=e167]: 整理房间
            - generic [ref=e168]: 任务记录
        - generic [ref=e169]:
          - generic [ref=e171]: task
          - generic [ref=e172]:
            - generic [ref=e173]:
              - generic [ref=e174]: 20:24
              - generic [ref=e175]: 已完成
            - generic [ref=e176]: 整理房间
            - generic [ref=e177]: 任务记录
        - generic [ref=e178]:
          - generic [ref=e180]: task
          - generic [ref=e181]:
            - generic [ref=e182]:
              - generic [ref=e183]: 20:24
              - generic [ref=e184]: 已完成
            - generic [ref=e185]: 数学作业
            - generic [ref=e186]: 任务记录
        - generic [ref=e187]:
          - generic [ref=e189]: task
          - generic [ref=e190]:
            - generic [ref=e191]:
              - generic [ref=e192]: 20:24
              - generic [ref=e193]: 已完成
            - generic [ref=e194]: 数学作业
            - generic [ref=e195]: 任务记录
        - generic [ref=e196]:
          - generic [ref=e198]: task
          - generic [ref=e199]:
            - generic [ref=e200]:
              - generic [ref=e201]: 20:24
              - generic [ref=e202]: 已完成
            - generic [ref=e203]: 数学作业
            - generic [ref=e204]: 任务记录
        - generic [ref=e205]:
          - generic [ref=e207]: task
          - generic [ref=e208]:
            - generic [ref=e209]:
              - generic [ref=e210]: 20:24
              - generic [ref=e211]: 已完成
            - generic [ref=e212]: 早起刷牙
            - generic [ref=e213]: 任务记录
        - generic [ref=e214]:
          - generic [ref=e216]: task
          - generic [ref=e217]:
            - generic [ref=e218]:
              - generic [ref=e219]: 20:24
              - generic [ref=e220]: 已完成
            - generic [ref=e221]: 阅读30分钟
            - generic [ref=e222]: 任务记录
        - generic [ref=e223]:
          - generic [ref=e225]: task
          - generic [ref=e226]:
            - generic [ref=e227]:
              - generic [ref=e228]: 20:24
              - generic [ref=e229]: 已完成
            - generic [ref=e230]: 阅读30分钟
            - generic [ref=e231]: 任务记录
        - generic [ref=e232]:
          - generic [ref=e234]: task
          - generic [ref=e235]:
            - generic [ref=e236]:
              - generic [ref=e237]: 20:24
              - generic [ref=e238]: 已完成
            - generic [ref=e239]: 早起刷牙
            - generic [ref=e240]: 任务记录
        - generic [ref=e241]:
          - generic [ref=e243]: task
          - generic [ref=e244]:
            - generic [ref=e245]:
              - generic [ref=e246]: 20:24
              - generic [ref=e247]: 已完成
            - generic [ref=e248]: 数学作业
            - generic [ref=e249]: 任务记录
        - generic [ref=e250]:
          - generic [ref=e252]: task
          - generic [ref=e253]:
            - generic [ref=e254]:
              - generic [ref=e255]: 20:24
              - generic [ref=e256]: 已完成
            - generic [ref=e257]: 早起刷牙
            - generic [ref=e258]: 任务记录
    - generic [ref=e259]:
      - generic [ref=e260] [cursor=pointer]:
        - generic [ref=e262]: 🏠
        - generic [ref=e263]: 首页
      - generic [ref=e264] [cursor=pointer]:
        - generic [ref=e266]: 📝
        - generic [ref=e267]: 任务
      - generic [ref=e268] [cursor=pointer]:
        - generic [ref=e270]: 📊
        - generic [ref=e271]: 洞察
      - generic [ref=e272] [cursor=pointer]:
        - generic [ref=e274]: 👤
        - generic [ref=e275]: 我的
  - generic [ref=e277]:
    - generic [ref=e280] [cursor=pointer]:
      - img [ref=e282]
      - generic [ref=e283]: 首页
    - generic [ref=e285] [cursor=pointer]:
      - img [ref=e287]
      - generic [ref=e288]: 任务
    - generic [ref=e290] [cursor=pointer]:
      - img [ref=e292]
      - generic [ref=e293]: 洞察
    - generic [ref=e295] [cursor=pointer]:
      - img [ref=e297]
      - generic [ref=e298]: 我的
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