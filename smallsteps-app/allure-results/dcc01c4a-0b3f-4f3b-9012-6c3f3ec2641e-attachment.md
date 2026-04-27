# Instructions

- Following Playwright test failed.
- Explain why, be concise, respect Playwright best practices.
- Provide a snippet of code with the fix, if possible.

# Test info

- Name: spec\parent-full.spec.ts >> Parent Full E2E Flow Tests >> Complete parent workflow
- Location: tests\e2e\spec\parent-full.spec.ts:24:7

# Error details

```
Test timeout of 30000ms exceeded.
```

```
Error: locator.click: Test timeout of 30000ms exceeded.
Call log:
  - waiting for getByText('任务')
    - locator resolved to <div class="uni-tabbar__label">任务</div>
  - attempting click action
    2 × waiting for element to be visible, enabled and stable
      - element is not visible
    - retrying click action
    - waiting 20ms
    2 × waiting for element to be visible, enabled and stable
      - element is not visible
    - retrying click action
      - waiting 100ms
    54 × waiting for element to be visible, enabled and stable
       - element is not visible
     - retrying click action
       - waiting 500ms

```

# Page snapshot

```yaml
- generic [active] [ref=e1]:
  - generic [ref=e7]:
    - generic [ref=e8]:
      - generic [ref=e10]: arrow_back_ios
      - generic [ref=e11]: 执行记录
    - generic [ref=e17]:
      - generic [ref=e18]: history
      - generic [ref=e19]: 暂无历史记录
  - generic [ref=e22]:
    - strong [ref=e24]: 系统提示
    - generic [ref=e25]: "Handler dispatch failed: java.lang.Error: Unresolved compilation problems: The import com.kenzhao.smallsteps.common.mybatis cannot be resolved The method equals(Object) of type ChildTask must override or implement a supertype method The method hashCode() of type ChildTask must override or implement a supertype method BaseEntity cannot be resolved to a type"
    - generic [ref=e27] [cursor=pointer]: 知道了
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
     |                        ^ Error: locator.click: Test timeout of 30000ms exceeded.
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