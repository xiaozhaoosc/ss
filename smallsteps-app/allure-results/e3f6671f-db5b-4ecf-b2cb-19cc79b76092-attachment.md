# Instructions

- Following Playwright test failed.
- Explain why, be concise, respect Playwright best practices.
- Provide a snippet of code with the fix, if possible.

# Test info

- Name: spec\parent-full.spec.ts >> Parent Full E2E Flow Tests >> Complete parent workflow
- Location: tests\e2e\spec\parent-full.spec.ts:24:7

# Error details

```
Error: locator.click: Error: strict mode violation: getByText('任务') resolved to 3 elements:
    1) <span>任务总数</span> aka getByText('任务总数')
    2) <span>任务</span> aka locator('uni-page-body').getByText('任务', { exact: true })
    3) <div class="uni-tabbar__label">任务</div> aka locator('uni-tabbar').getByText('任务')

Call log:
  - waiting for getByText('任务')

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
        - generic [ref=e18]:
          - generic [ref=e19]: 通知中心
          - generic [ref=e20] [cursor=pointer]: 全部已读
      - generic [ref=e24]:
        - generic [ref=e25]:
          - generic [ref=e26]: 今日焦点
          - generic [ref=e27]: 详情
        - generic [ref=e32]:
          - generic [ref=e33]:
            - generic [ref=e36]: check_circle
            - generic [ref=e37]:
              - generic [ref=e38]: 任务总数
              - generic [ref=e39]:
                - generic [ref=e40]: "0"
                - generic [ref=e41]: 个
          - generic [ref=e42]:
            - generic [ref=e45]: emoji_events
            - generic [ref=e46]:
              - generic [ref=e47]: 奖励总数
              - generic [ref=e48]:
                - generic [ref=e49]: "0"
                - generic [ref=e50]: 个
        - generic [ref=e51]:
          - generic [ref=e52]: 执行记录
          - generic [ref=e53]: 查看全部
        - generic [ref=e54]:
          - generic [ref=e55]:
            - generic [ref=e57]: task
            - generic [ref=e58]:
              - generic [ref=e59]:
                - generic [ref=e60]: 20:24
                - generic [ref=e61]: 已完成
              - generic [ref=e62]: 数学作业
              - generic [ref=e63]: 任务记录
          - generic [ref=e64]:
            - generic [ref=e66]: task
            - generic [ref=e67]:
              - generic [ref=e68]:
                - generic [ref=e69]: 20:24
                - generic [ref=e70]: 已完成
              - generic [ref=e71]: 阅读30分钟
              - generic [ref=e72]: 任务记录
          - generic [ref=e73]:
            - generic [ref=e75]: task
            - generic [ref=e76]:
              - generic [ref=e77]:
                - generic [ref=e78]: 20:24
                - generic [ref=e79]: 已完成
              - generic [ref=e80]: 数学作业
              - generic [ref=e81]: 任务记录
          - generic [ref=e82]:
            - generic [ref=e84]: task
            - generic [ref=e85]:
              - generic [ref=e86]:
                - generic [ref=e87]: 20:24
                - generic [ref=e88]: 已完成
              - generic [ref=e89]: 早起刷牙
              - generic [ref=e90]: 任务记录
          - generic [ref=e91]:
            - generic [ref=e93]: task
            - generic [ref=e94]:
              - generic [ref=e95]:
                - generic [ref=e96]: 20:24
                - generic [ref=e97]: 已完成
              - generic [ref=e98]: 数学作业
              - generic [ref=e99]: 任务记录
          - generic [ref=e100]:
            - generic [ref=e102]: task
            - generic [ref=e103]:
              - generic [ref=e104]:
                - generic [ref=e105]: 20:24
                - generic [ref=e106]: 已完成
              - generic [ref=e107]: 数学作业
              - generic [ref=e108]: 任务记录
          - generic [ref=e109]:
            - generic [ref=e111]: task
            - generic [ref=e112]:
              - generic [ref=e113]:
                - generic [ref=e114]: 20:24
                - generic [ref=e115]: 已完成
              - generic [ref=e116]: 早起刷牙
              - generic [ref=e117]: 任务记录
          - generic [ref=e118]:
            - generic [ref=e120]: task
            - generic [ref=e121]:
              - generic [ref=e122]:
                - generic [ref=e123]: 20:24
                - generic [ref=e124]: 已完成
              - generic [ref=e125]: 数学作业
              - generic [ref=e126]: 任务记录
          - generic [ref=e127]:
            - generic [ref=e129]: task
            - generic [ref=e130]:
              - generic [ref=e131]:
                - generic [ref=e132]: 20:24
                - generic [ref=e133]: 已完成
              - generic [ref=e134]: 数学作业
              - generic [ref=e135]: 任务记录
          - generic [ref=e136]:
            - generic [ref=e138]: task
            - generic [ref=e139]:
              - generic [ref=e140]:
                - generic [ref=e141]: 20:24
                - generic [ref=e142]: 已完成
              - generic [ref=e143]: 早起刷牙
              - generic [ref=e144]: 任务记录
          - generic [ref=e145]:
            - generic [ref=e147]: task
            - generic [ref=e148]:
              - generic [ref=e149]:
                - generic [ref=e150]: 20:24
                - generic [ref=e151]: 已完成
              - generic [ref=e152]: 数学作业
              - generic [ref=e153]: 任务记录
          - generic [ref=e154]:
            - generic [ref=e156]: task
            - generic [ref=e157]:
              - generic [ref=e158]:
                - generic [ref=e159]: 20:24
                - generic [ref=e160]: 已完成
              - generic [ref=e161]: 早起刷牙
              - generic [ref=e162]: 任务记录
          - generic [ref=e163]:
            - generic [ref=e165]: task
            - generic [ref=e166]:
              - generic [ref=e167]:
                - generic [ref=e168]: 20:24
                - generic [ref=e169]: 已完成
              - generic [ref=e170]: 整理房间
              - generic [ref=e171]: 任务记录
          - generic [ref=e172]:
            - generic [ref=e174]: task
            - generic [ref=e175]:
              - generic [ref=e176]:
                - generic [ref=e177]: 20:24
                - generic [ref=e178]: 已完成
              - generic [ref=e179]: 整理房间
              - generic [ref=e180]: 任务记录
          - generic [ref=e181]:
            - generic [ref=e183]: task
            - generic [ref=e184]:
              - generic [ref=e185]:
                - generic [ref=e186]: 20:24
                - generic [ref=e187]: 已完成
              - generic [ref=e188]: 数学作业
              - generic [ref=e189]: 任务记录
          - generic [ref=e190]:
            - generic [ref=e192]: task
            - generic [ref=e193]:
              - generic [ref=e194]:
                - generic [ref=e195]: 20:24
                - generic [ref=e196]: 已完成
              - generic [ref=e197]: 数学作业
              - generic [ref=e198]: 任务记录
          - generic [ref=e199]:
            - generic [ref=e201]: task
            - generic [ref=e202]:
              - generic [ref=e203]:
                - generic [ref=e204]: 20:24
                - generic [ref=e205]: 已完成
              - generic [ref=e206]: 数学作业
              - generic [ref=e207]: 任务记录
          - generic [ref=e208]:
            - generic [ref=e210]: task
            - generic [ref=e211]:
              - generic [ref=e212]:
                - generic [ref=e213]: 20:24
                - generic [ref=e214]: 已完成
              - generic [ref=e215]: 早起刷牙
              - generic [ref=e216]: 任务记录
          - generic [ref=e217]:
            - generic [ref=e219]: task
            - generic [ref=e220]:
              - generic [ref=e221]:
                - generic [ref=e222]: 20:24
                - generic [ref=e223]: 已完成
              - generic [ref=e224]: 阅读30分钟
              - generic [ref=e225]: 任务记录
          - generic [ref=e226]:
            - generic [ref=e228]: task
            - generic [ref=e229]:
              - generic [ref=e230]:
                - generic [ref=e231]: 20:24
                - generic [ref=e232]: 已完成
              - generic [ref=e233]: 阅读30分钟
              - generic [ref=e234]: 任务记录
          - generic [ref=e235]:
            - generic [ref=e237]: task
            - generic [ref=e238]:
              - generic [ref=e239]:
                - generic [ref=e240]: 20:24
                - generic [ref=e241]: 已完成
              - generic [ref=e242]: 早起刷牙
              - generic [ref=e243]: 任务记录
          - generic [ref=e244]:
            - generic [ref=e246]: task
            - generic [ref=e247]:
              - generic [ref=e248]:
                - generic [ref=e249]: 20:24
                - generic [ref=e250]: 已完成
              - generic [ref=e251]: 数学作业
              - generic [ref=e252]: 任务记录
          - generic [ref=e253]:
            - generic [ref=e255]: task
            - generic [ref=e256]:
              - generic [ref=e257]:
                - generic [ref=e258]: 20:24
                - generic [ref=e259]: 已完成
              - generic [ref=e260]: 早起刷牙
              - generic [ref=e261]: 任务记录
      - generic [ref=e262]:
        - generic [ref=e263] [cursor=pointer]:
          - generic [ref=e265]: 🏠
          - generic [ref=e266]: 首页
        - generic [ref=e267] [cursor=pointer]:
          - generic [ref=e269]: 📝
          - generic [ref=e270]: 任务
        - generic [ref=e271] [cursor=pointer]:
          - generic [ref=e273]: 📊
          - generic [ref=e274]: 洞察
        - generic [ref=e275] [cursor=pointer]:
          - generic [ref=e277]: 👤
          - generic [ref=e278]: 我的
    - generic [ref=e280]:
      - generic [ref=e283] [cursor=pointer]:
        - img [ref=e285]
        - generic [ref=e286]: 首页
      - generic [ref=e288] [cursor=pointer]:
        - img [ref=e290]
        - generic [ref=e291]: 任务
      - generic [ref=e293] [cursor=pointer]:
        - img [ref=e295]
        - generic [ref=e296]: 洞察
      - generic [ref=e298] [cursor=pointer]:
        - img [ref=e300]
        - generic [ref=e301]: 我的
  - generic:
    - generic:
      - generic:
        - paragraph: 加载中...
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
> 23 |     await this.taskTab.click();
     |                        ^ Error: locator.click: Error: strict mode violation: getByText('任务') resolved to 3 elements:
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