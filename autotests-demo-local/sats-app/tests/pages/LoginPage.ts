import { Page, expect } from '@playwright/test';

export class AppLoginPage {
  constructor(private page: Page) {}

  async goto() {
    await this.page.goto('/', { timeout: 20000, waitUntil: 'domcontentloaded' });
    await this.page.waitForURL(/.*#/, { timeout: 15000 });
  }

  async login(username: string, password: string) {
    await this.goto();
    // H5 移动端登录
    const textInputs = this.page.locator('input[type="text"], input[type="tel"], input:not([type])');
    const pwdInputs = this.page.locator('input[type="password"]');

    // 填写用户名（第一个文本输入框）
    await textInputs.first().fill(username);
    // 填写密码
    await pwdInputs.first().fill(password);

    // 点击登录按钮
    const loginBtn = this.page.locator('button, .login-btn, [class*="login"]').first();
    await loginBtn.click();

    // 等待跳转到首页
    await this.page.waitForTimeout(2000);
  }
}
