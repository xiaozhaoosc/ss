# Instructions

- Following Playwright test failed.
- Explain why, be concise, respect Playwright best practices.
- Provide a snippet of code with the fix, if possible.

# Test info

- Name: template.spec.ts >> ADHD 模板库 E2E 测试 >> 能够访问详情页
- Location: tests\e2e\template.spec.ts:12:7

# Error details

```
Error: expect(locator).toBeVisible() failed

Locator: locator('.min-h-screen')
Expected: visible
Timeout: 5000ms
Error: element(s) not found

Call log:
  - Expect "toBeVisible" with timeout 5000ms
  - waiting for locator('.min-h-screen')

```

# Page snapshot

```yaml
- generic [active] [ref=e1]:
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
            - generic [ref=e27]:
              - generic: 账号
              - textbox [ref=e28]
          - generic [ref=e29]:
            - generic [ref=e30]: 
            - generic [ref=e32]:
              - generic: 密码
              - textbox [ref=e33]
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
  - generic [ref=e53]:
    - strong [ref=e55]: 系统提示
    - generic [ref=e56]: No endpoint GET /ssapi/template/detail/123.
    - generic [ref=e58] [cursor=pointer]: 知道了
```

# Test source

```ts
  1  | import { test, expect } from '@playwright/test';
  2  | 
  3  | test.describe('ADHD 模板库 E2E 测试', () => {
  4  |   // 假设在 web (H5) 环境下运行
  5  |   test('能够访问模板库列表页', async ({ page }) => {
  6  |     await page.goto('/#/pages/template/library');
  7  |     
  8  |     // 应该显示页面或至少触发请求并展示加载中/空状态
  9  |     await expect(page.locator('text=ADHD 模板库').or(page.locator('.min-h-screen'))).toBeVisible();
  10 |   });
  11 |   
  12 |   test('能够访问详情页', async ({ page }) => {
  13 |     // 传递一个假 ID 进行测试
  14 |     await page.goto('/#/pages/template/detail?id=123');
  15 |     
  16 |     // 等待加载消失或显示内容
> 17 |     await expect(page.locator('.min-h-screen')).toBeVisible();
     |                                                 ^ Error: expect(locator).toBeVisible() failed
  18 |     await expect(page.locator('text=应用此模板至今日').or(page.locator('text=加载中'))).toBeVisible();
  19 |   });
  20 | });
```