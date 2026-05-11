import { Page, Locator } from '@playwright/test';

export class ChildTaskExecutePage {
  readonly page: Page;
  readonly startButton: Locator;
  readonly completeButton: Locator;
  readonly collectRewardButton: Locator;

  constructor(page: Page) {
    this.page = page;
    // Current UI uses .complete-btn for all task actions (Start, Next Step, Complete)
    this.startButton = page.locator('.complete-btn');
    this.completeButton = page.locator('.complete-btn');
    this.collectRewardButton = page.locator('.collect-btn');
  }

  async startTask() {
    // If the task has steps, the first click on .complete-btn acts as "Start/First Step"
    await this.startButton.waitFor({ state: 'visible' });
    await this.startButton.click();
  }

  async completeTask() {
    // For tasks with steps, we might need multiple clicks. 
    await this.completeButton.waitFor({ state: 'visible' });
    await this.completeButton.click();
  }

  /**
   * Clicks the action button repeatedly until the reward overlay (collect-btn) is visible.
   * Useful for tasks with multiple steps.
   */
  async completeTaskUntilFinished() {
    let attempts = 0;
    while (attempts < 10) { // Safety limit
      if (await this.collectRewardButton.isVisible()) break;
      
      await this.completeButton.waitFor({ state: 'visible' });
      await this.completeButton.click();
      
      // Wait a bit for transition
      await this.page.waitForTimeout(1000);
      attempts++;
    }
    
    await this.collectRewardButton.waitFor({ state: 'visible', timeout: 5000 });
  }

  async collectReward() {
    await this.collectRewardButton.waitFor({ state: 'visible', timeout: 15000 });
    await this.collectRewardButton.click();
  }
}
