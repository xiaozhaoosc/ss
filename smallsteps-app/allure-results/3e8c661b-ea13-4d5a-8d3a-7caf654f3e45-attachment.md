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
  - waiting for getByText('洞察')
    - locator resolved to <div class="uni-tabbar__label">洞察</div>
  - attempting click action
    2 × waiting for element to be visible, enabled and stable
      - element is visible, enabled and stable
      - scrolling into view if needed
      - done scrolling
      - <span>洞察</span> from <uni-page type="tabBar" data-page="pages/parent/task-creator/index">…</uni-page> subtree intercepts pointer events
    - retrying click action
    - waiting 20ms
    2 × waiting for element to be visible, enabled and stable
      - element is visible, enabled and stable
      - scrolling into view if needed
      - done scrolling
      - <span>洞察</span> from <uni-page type="tabBar" data-page="pages/parent/task-creator/index">…</uni-page> subtree intercepts pointer events
    - retrying click action
      - waiting 100ms
    14 × waiting for element to be visible, enabled and stable
       - element is visible, enabled and stable
       - scrolling into view if needed
       - done scrolling
       - <span>洞察</span> from <uni-page type="tabBar" data-page="pages/parent/task-creator/index">…</uni-page> subtree intercepts pointer events
     - retrying click action
       - waiting 500ms

```

# Page snapshot

```yaml
- generic [ref=e3]:
  - generic [ref=e7]:
    - generic [ref=e8]:
      - generic [ref=e11] [cursor=pointer]: ←
      - generic [ref=e13]: 创建任务
      - generic [ref=e16]: CN
    - generic [ref=e20]:
      - generic [ref=e21]:
        - generic [ref=e22]:
          - generic [ref=e24]:
            - generic [ref=e25]: 输入你想让孩子做的事... 例如：收拾书包准备去学校
            - textbox [ref=e26]
          - generic [ref=e27]: 0/200
        - generic [ref=e28] [cursor=pointer]:
          - generic [ref=e29]: spark
          - generic [ref=e30]: AI 拆解
      - generic [ref=e31]:
        - generic [ref=e32]:
          - generic [ref=e33]: 任务步骤
          - generic [ref=e34]: 3 步
        - generic [ref=e35]:
          - generic [ref=e36]:
            - generic [ref=e38]: drag_indicator
            - generic [ref=e39]:
              - generic [ref=e40]: 穿好袜子
              - generic [ref=e41]: 找到一双干净的袜子并穿上
            - generic [ref=e42]:
              - generic [ref=e44] [cursor=pointer]: edit
              - generic [ref=e46] [cursor=pointer]: delete
          - generic [ref=e47]:
            - generic [ref=e49]: drag_indicator
            - generic [ref=e50]:
              - generic [ref=e51]: 穿好鞋子
              - generic [ref=e52]: 区分左右脚，系好鞋带
            - generic [ref=e53]:
              - generic [ref=e55] [cursor=pointer]: edit
              - generic [ref=e57] [cursor=pointer]: delete
          - generic [ref=e58]:
            - generic [ref=e60]: drag_indicator
            - generic [ref=e61]:
              - generic [ref=e62]: 拿上书包
              - generic [ref=e63]: 确认作业都在书包里
            - generic [ref=e64]:
              - generic [ref=e66] [cursor=pointer]: edit
              - generic [ref=e68] [cursor=pointer]: delete
          - generic [ref=e69] [cursor=pointer]:
            - generic [ref=e70]: add_circle
            - generic [ref=e71]: 添加步骤
      - generic [ref=e72]:
        - generic [ref=e73]:
          - generic [ref=e74] [cursor=pointer]:
            - generic [ref=e75]: 
            - generic [ref=e78]: 每天重复
          - generic [ref=e79] [cursor=pointer]:
            - generic [ref=e80]: 
            - generic [ref=e83]: 存为模板
        - generic [ref=e85] [cursor=pointer]: 发布
    - generic [ref=e87]:
      - generic [ref=e88] [cursor=pointer]:
        - generic [ref=e90]: 🏠
        - generic [ref=e91]: 首页
      - generic [ref=e92] [cursor=pointer]:
        - generic [ref=e94]: 📝
        - generic [ref=e95]: 任务
      - generic [ref=e96] [cursor=pointer]:
        - generic [ref=e98]: 📊
        - generic [ref=e99]: 洞察
      - generic [ref=e100] [cursor=pointer]:
        - generic [ref=e102]: 👤
        - generic [ref=e103]: 我的
  - generic [ref=e105]:
    - generic [ref=e108] [cursor=pointer]:
      - img [ref=e110]
      - generic [ref=e111]: 首页
    - generic [ref=e113] [cursor=pointer]:
      - img [ref=e115]
      - generic [ref=e116]: 任务
    - generic [ref=e118] [cursor=pointer]:
      - img [ref=e120]
      - generic [ref=e121]: 洞察
    - generic [ref=e123] [cursor=pointer]:
      - img [ref=e125]
      - generic [ref=e126]: 我的
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