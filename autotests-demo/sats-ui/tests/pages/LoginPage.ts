import { Page, expect } from '@playwright/test';

export class LoginPage {
  constructor(private page: Page) {}

  async goto() {
    await this.page.goto('/webadminss/');
  }

  async login(username: string, password: string) {
    await this.goto();
    await this.page.fill('input[placeholder="用户名"]', username);
    await this.page.fill('input[placeholder="密码"]', password);
    await this.page.locator('.el-button--primary').click();
    // 等待 URL 变为 dashboard（匹配 hash 路径 #/dashboard 或 #/index，排除 #/login）
    await this.page.waitForURL(/#\/(dashboard|index)/, { timeout: 15000 });
    // 等待 dashboard 内容实际渲染
    await this.page.waitForLoadState('domcontentloaded');
    await this.page.waitForTimeout(2000);
  }
}
