import { Page, expect } from '@playwright/test';

export class RewardPage {
  constructor(private page: Page) {}

  async goto() {
    await this.page.goto('/webadminss/#/smallsteps/reward');
    await this.page.waitForLoadState('domcontentloaded');
    await this.page.waitForTimeout(1000);
  }

  async expectVisible() {
    await expect(this.page.locator('.el-table, table')).toBeVisible({ timeout: 10000 });
  }
}
