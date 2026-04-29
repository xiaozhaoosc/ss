import { Page, Locator } from '@playwright/test';

export class ChildTaskExecutePage {
  readonly page: Page;
  readonly startButton: Locator;
  readonly completeButton: Locator;
  readonly collectRewardButton: Locator;

  constructor(page: Page) {
    this.page = page;
    this.startButton = page.locator('.start-btn');
    this.completeButton = page.locator('.complete-btn');
    this.collectRewardButton = page.locator('.collect-btn');
  }

  async startTask() {
    await this.startButton.waitFor({ state: 'visible' });
    await this.startButton.click();
  }

  async completeTask() {
    await this.completeButton.waitFor({ state: 'visible' });
    await this.completeButton.click();
  }

  async collectReward() {
    await this.collectRewardButton.waitFor({ state: 'visible', timeout: 15000 });
    await this.collectRewardButton.click();
  }
}
