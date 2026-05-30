import { Page, expect } from '@playwright/test';

export class LoginPage {
  constructor(private page: Page) {}

  async goto() {
    await this.page.goto('/');
  }

  async login(username: string, password: string) {
    await this.goto();
    await this.page.fill('input[placeholder="用户名"]', username);
    await this.page.fill('input[placeholder="密码"]', password);
    await this.page.locator('.el-button--primary').click();
    await this.page.waitForURL(/dashboard|index/, { timeout: 10000 });
  }
}
