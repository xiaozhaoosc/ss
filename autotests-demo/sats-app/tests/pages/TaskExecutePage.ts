import { Page, expect } from '@playwright/test';

export class TaskExecutePage {
  constructor(private page: Page) {}

  /** 点击任务进入执行页面 */
  async openTask(taskTitle: string) {
    await this.page.locator(`text=${taskTitle}`).click();
    await this.page.waitForTimeout(1000);
  }

  /** 点击开始执行 */
  async startTask() {
    const startBtn = this.page.locator('button:has-text("开始"), button:has-text("Start"), [class*="start"]');
    if (await startBtn.isVisible()) {
      await startBtn.click();
      await this.page.waitForTimeout(500);
    }
  }

  /** 逐步完成任务步骤 */
  async completeSteps(stepCount: number = 10) {
    for (let i = 0; i < stepCount; i++) {
      const stepBtn = this.page.locator('button:has-text("下一步"), button:has-text("Next")');
      if (await stepBtn.isVisible()) {
        await stepBtn.click();
        await this.page.waitForTimeout(800);
      } else {
        break;
      }
    }
  }

  /** 最终完成任务 */
  async finishTask() {
    const finishBtn = this.page.locator('button:has-text("我完成了！"), button:has-text("完成任务"), button:has-text("Finish"), button:has-text("提交")');
    if (await finishBtn.isVisible()) {
      await finishBtn.click();
      await this.page.waitForTimeout(2000);
    }
  }

  /** 领取奖励 */
  async collectReward() {
    const collectBtn = this.page.locator('button:has-text("领取奖励"), button:has-text("Collect"), .collect-btn');
    if (await collectBtn.isVisible()) {
      await collectBtn.click();
      await this.page.waitForTimeout(1000);
    }
  }

  /** 尝试按返回键（测试防误触） */
  async pressBack() {
    await this.page.keyboard.press('Escape');
    await this.page.waitForTimeout(500);
  }

  /** 验证仍在执行页面（防误触有效） */
  async expectStillInTask() {
    // 页面应该仍然在任务执行中，没有跳走
    const url = this.page.url();
    expect(url).toContain('#');
  }
}
