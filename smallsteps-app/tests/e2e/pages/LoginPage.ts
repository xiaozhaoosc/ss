import { Page, Locator } from '@playwright/test';

export class LoginPage {
  readonly page: Page;
  readonly usernameInput: Locator;
  readonly passwordInput: Locator;
  readonly loginButton: Locator;
  readonly registerLink: Locator;

  constructor(page: Page) {
    this.page = page;
    this.usernameInput = page.locator('input[type="text"]').first();
    this.passwordInput = page.locator('input[type="password"]').first();
    this.loginButton = page.locator('.login-btn');
    this.registerLink = page.getByText('注册账号');
  }

  async goto() {
    await this.page.goto('/#/pages/login/index');
  }

  async login(username: string, password: string) {
    await this.usernameInput.fill(username);
    await this.passwordInput.fill(password);
    await this.loginButton.click();
    // 等待登录成功跳转（可能是首页或儿童首页）
    await this.page.waitForURL(/.*pages\/(parent\/dashboard|child\/home)\/index/, { timeout: 30000 });
    // 等待页面关键元素可见，确保会话已初始化
    await this.page.locator('.welcome-text, .streak-val, .icon-btn').first().waitFor({ state: 'visible', timeout: 10000 });
  }

  async goToRegister() {
    await this.registerLink.click();
  }
}
