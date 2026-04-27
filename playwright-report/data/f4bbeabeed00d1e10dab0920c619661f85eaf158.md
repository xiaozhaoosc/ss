# Instructions

- Following Playwright test failed.
- Explain why, be concise, respect Playwright best practices.
- Provide a snippet of code with the fix, if possible.

# Test info

- Name: dashboard.spec.ts >> Parent Dashboard Functional Scan >> Navigate to Task Creation
- Location: tests\e2e\dashboard.spec.ts:23:7

# Error details

```
Test timeout of 30000ms exceeded while running "beforeEach" hook.
```

```
Error: page.click: Test timeout of 30000ms exceeded.
Call log:
  - waiting for locator('text=登 录')
    - locator resolved to <uni-button id="" class="login-btn" data-v-45258083="">登 录</uni-button>
  - attempting click action
    - waiting for element to be visible, enabled and stable
    - element is not stable
  - retrying click action
    - waiting for element to be visible, enabled and stable
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
    41 × waiting for element to be visible, enabled and stable
       - element is visible, enabled and stable
       - scrolling into view if needed
       - done scrolling
       - <div class="uni-mask"></div> from <div id="u-a-m" data-v-app="">…</div> subtree intercepts pointer events
     - retrying click action
       - waiting 500ms

```

# Page snapshot

```yaml
- generic [ref=e1]:
  - generic [ref=e4]:
    - generic [ref=e8]: 登录
    - generic [ref=e12]:
      - generic [ref=e13]:
        - img [ref=e17]
        - generic [ref=e18]:
          - generic [ref=e19]: Small Steps
          - generic [ref=e20]: 每一次进步，都值得被看见
      - generic [ref=e21]:
        - generic [ref=e22]: 欢迎回来
        - generic [ref=e23]:
          - generic [ref=e24]:
            - generic [ref=e25]: 
            - textbox [ref=e28]: ken2zhao
          - generic [ref=e29]:
            - generic [ref=e30]: 
            - textbox [active] [ref=e33]: Aa123456
        - generic [ref=e35] [cursor=pointer]:
          - generic [ref=e36]: 
          - generic [ref=e39]: 记住密码
        - generic [ref=e40]:
          - generic [ref=e41] [cursor=pointer]: 登 录
          - generic [ref=e42]:
            - generic [ref=e43]: 注册账号
            - generic [ref=e44]: "|"
            - generic [ref=e45]: 忘记密码?
      - generic [ref=e47]:
        - generic [ref=e48]: 登录即代表同意
        - generic [ref=e49]: 《用户协议》
        - generic [ref=e50]: "&"
        - generic [ref=e51]: 《隐私协议》
  - generic [ref=e54]:
    - strong [ref=e56]: 系统提示
    - generic [ref=e57]: 服务器异常(500)
    - generic [ref=e59] [cursor=pointer]: 知道了
```

# Test source

```ts
  1  | import { test, expect } from '@playwright/test';
  2  | 
  3  | test.describe('Parent Dashboard Functional Scan', () => {
  4  |   test.beforeEach(async ({ page }) => {
  5  |     test.skip(test.info().project.name !== 'mobile-parent');
  6  |     
  7  |     // 登录
  8  |     await page.goto('/');
  9  |     await page.fill('input[type="text"]', 'ken2zhao');
  10 |     await page.fill('input[type="password"]', 'Aa123456');
> 11 |     await page.click('text=登 录');
     |                ^ Error: page.click: Test timeout of 30000ms exceeded.
  12 |     await page.waitForURL(/.*dashboard.*/);
  13 |   });
  14 | 
  15 |   test('Check Dashboard Metrics', async ({ page }) => {
  16 |     // 验证核心组件是否显示
  17 |     // 根据 Uni-app 编译后的结果，可能需要寻找特定的文本或类名
  18 |     await expect(page.locator('text=今日焦点')).toBeVisible({ timeout: 10000 });
  19 |     await expect(page.locator('text=时光机')).toBeVisible();
  20 |     await expect(page.locator('text=执行记录')).toBeVisible();
  21 |   });
  22 | 
  23 |   test('Navigate to Task Creation', async ({ page }) => {
  24 |     // 寻找“新增任务”或类似按钮
  25 |     const addTaskBtn = page.locator('text=新增, text=添加, .uni-icons-plus');
  26 |     if (await addTaskBtn.count() > 0) {
  27 |       await addTaskBtn.first().click();
  28 |       await expect(page).toHaveURL(/.*task-edit.*/);
  29 |     } else {
  30 |       console.log('Add task button not found with default selectors, scanning page...');
  31 |       // 记录一个潜在的 UI 发现
  32 |     }
  33 |   });
  34 | });
  35 | 
```