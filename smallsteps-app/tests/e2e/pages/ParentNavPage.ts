import { Page, Locator } from '@playwright/test';

export class ParentNavPage {
  readonly page: Page;
  readonly homeTab: Locator;
  readonly taskTab: Locator;
  readonly insightsTab: Locator;
  readonly profileTab: Locator;

  constructor(page: Page) {
    this.page = page;
    // 使用更精确的选择器，避免匹配到页面内容中的文本
    this.homeTab = page.locator('.uni-tabbar').getByText('首页', { exact: true }).first();
    this.taskTab = page.locator('.uni-tabbar').getByText('任务', { exact: true }).first();
    this.insightsTab = page.locator('.uni-tabbar').getByText('洞察', { exact: true }).first();
    this.profileTab = page.locator('.uni-tabbar').getByText('我的', { exact: true }).first();
  }

  async goToHome() {
    await this.homeTab.click({ force: true });
  }

  async goToTaskCreator() {
    await this.taskTab.click({ force: true });
  }

  async goToInsights() {
    await this.insightsTab.click({ force: true });
  }

  async goToProfile() {
    await this.profileTab.click({ force: true });
  }
}
