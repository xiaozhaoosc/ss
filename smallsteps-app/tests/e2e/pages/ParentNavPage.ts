import { Page, Locator } from '@playwright/test';

export class ParentNavPage {
  readonly page: Page;
  readonly homeTab: Locator;
  readonly taskTab: Locator;
  readonly insightsTab: Locator;
  readonly profileTab: Locator;

  constructor(page: Page) {
    this.page = page;
    this.homeTab = page.getByText('首页');
    this.taskTab = page.getByText('任务');
    this.insightsTab = page.getByText('洞察');
    this.profileTab = page.getByText('我的');
  }

  async goToHome() {
    await this.homeTab.click();
  }

  async goToTaskCreator() {
    await this.taskTab.click();
  }

  async goToInsights() {
    await this.insightsTab.click();
  }

  async goToProfile() {
    await this.profileTab.click();
  }
}
