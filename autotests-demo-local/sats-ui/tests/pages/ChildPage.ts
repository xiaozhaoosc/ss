import { Page, expect } from '@playwright/test';

export class ChildPage {
  constructor(private page: Page) {}

  async goto() {
    await this.page.goto('/webadminss/#/smallsteps/child');
    await this.page.waitForLoadState('domcontentloaded');
    await this.page.waitForTimeout(1000);
  }

  async expectVisible() {
    // 等待儿童列表页面加载
    await this.page.waitForLoadState('domcontentloaded');
    await this.page.waitForTimeout(1000);
  }
}
