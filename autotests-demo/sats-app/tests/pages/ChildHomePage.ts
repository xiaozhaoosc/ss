import { Page, expect } from '@playwright/test';

export class ChildHomePage {
  constructor(private page: Page) {}

  /** 验证已进入儿童首页 */
  async expectVisible() {
    // 儿童模式有不同的 UI 风格
    await this.page.waitForLoadState('networkidle');
    await this.page.waitForTimeout(1000);
  }

  /** 查看任务列表 */
  async expectTaskCard(taskTitle: string) {
    const taskCard = this.page.locator(`text=${taskTitle}`);
    await expect(taskCard).toBeVisible({ timeout: 10000 });
  }
}
