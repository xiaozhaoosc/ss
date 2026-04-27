# Instructions

- Following Playwright test failed.
- Explain why, be concise, respect Playwright best practices.
- Provide a snippet of code with the fix, if possible.

# Test info

- Name: spec\parent-profile.spec.ts >> Parent Profile Tests >> Test bottom navigation
- Location: tests\e2e\spec\parent-profile.spec.ts:74:7

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
    2 × waiting for element to be visible, enabled and stable
      - element is not visible
    - retrying click action
      - waiting 100ms
    40 × waiting for element to be visible, enabled and stable
       - element is not visible
     - retrying click action
       - waiting 500ms
    - waiting for element to be visible, enabled and stable

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
          - textbox [ref=e32]: Aa123456
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