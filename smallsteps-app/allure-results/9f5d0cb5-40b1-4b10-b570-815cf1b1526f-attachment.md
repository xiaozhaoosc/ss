# Instructions

- Following Playwright test failed.
- Explain why, be concise, respect Playwright best practices.
- Provide a snippet of code with the fix, if possible.

# Test info

- Name: spec\parent-auth.spec.ts >> Parent Authentication Tests >> Login with valid parent1 credentials
- Location: tests\e2e\spec\parent-auth.spec.ts:16:7

# Error details

```
Test timeout of 30000ms exceeded.
```

```
Error: locator.fill: Test timeout of 30000ms exceeded.
Call log:
  - waiting for getByLabel('用户名')

```

# Page snapshot

```yaml
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
```

# Test source

```ts
  1  | import { Page, Locator } from '@playwright/test';
  2  | 
  3  | export class LoginPage {
  4  |   readonly page: Page;
  5  |   readonly usernameInput: Locator;
  6  |   readonly passwordInput: Locator;
  7  |   readonly loginButton: Locator;
  8  |   readonly registerLink: Locator;
  9  | 
  10 |   constructor(page: Page) {
  11 |     this.page = page;
  12 |     this.usernameInput = page.getByLabel('用户名') || page.getByPlaceholder('用户名') || page.locator('input[type="text"]');
  13 |     this.passwordInput = page.getByLabel('密码') || page.getByPlaceholder('密码') || page.locator('input[type="password"]');
  14 |     this.loginButton = page.getByRole('button', { name: /登\s*录/i });
  15 |     this.registerLink = page.getByText('注册');
  16 |   }
  17 | 
  18 |   async goto() {
  19 |     await this.page.goto('/');
  20 |   }
  21 | 
  22 |   async login(username: string, password: string) {
> 23 |     await this.usernameInput.fill(username);
     |                              ^ Error: locator.fill: Test timeout of 30000ms exceeded.
  24 |     await this.passwordInput.fill(password);
  25 |     await this.loginButton.click();
  26 |   }
  27 | 
  28 |   async goToRegister() {
  29 |     await this.registerLink.click();
  30 |   }
  31 | }
  32 | 
```