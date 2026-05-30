import { Page, expect } from '@playwright/test';

export class TaskPage {
  constructor(private page: Page) {}

  async goto() {
    await this.page.goto('/webadminss/#/smallsteps/task');
    await this.page.waitForLoadState('domcontentloaded');
    await this.page.waitForTimeout(1000);
  }

  /** 打开新增任务对话框 */
  async openCreateDialog() {
    await this.page.locator('button:has-text("新增任务")').click();
    await expect(this.page.locator('.el-dialog')).toBeVisible();
  }

  /** 填写任务表单（不包含 AI 拆解） */
  async fillTaskForm(task: {
    title: string;
    description?: string;
    difficulty?: number;
    rewardPoints?: number;
    cycleType?: string;
  }) {
    // 任务标题（必填）
    const dialog = this.page.locator('.el-dialog');
    const titleInput = dialog.locator('input[placeholder*="任务标题"], input[type="text"]').first();
    await titleInput.fill(task.title);

    // 任务描述
    if (task.description) {
      const descInput = dialog.locator('textarea[placeholder*="任务描述"], textarea').first();
      await descInput.fill(task.description);
    }

    // 难度等级（slider，通过点击星星设置）
    if (task.difficulty && task.difficulty > 1) {
      const stars = dialog.locator('.el-rate__item').nth(task.difficulty - 1);
      await stars.click();
    }

    // 奖励积分
    if (task.rewardPoints) {
      const pointsInput = dialog.locator('input[type="number"]').first();
      await pointsInput.fill(String(task.rewardPoints));
    }
  }

  /** 触发 AI 拆解 */
  async triggerAIBreakdown() {
    const dialog = this.page.locator('.el-dialog');
    const aiBtn = dialog.locator('button:has-text("AI")');
    // 等待按钮变为可用（填写标题后才能点击）
    await this.page.waitForTimeout(500);
    if (await aiBtn.isEnabled()) {
      await aiBtn.click();
      // 等待 AI 结果加载
      await this.page.waitForTimeout(3000);
    }
  }

  /** 提交任务 */
  async submitTask() {
    const dialog = this.page.locator('.el-dialog');
    // "确 定" 按钮文字中间有空格
    await dialog.locator('button:has-text("确"), button:has-text("确定")').last().click();
    await this.page.waitForTimeout(1000);
  }

  /** 在列表中搜索任务 */
  async searchTask(title: string) {
    await this.page.fill('input[placeholder*="任务标题"], input[type="text"]', title);
    await this.page.locator('button:has-text("搜索")').click();
    await this.page.waitForTimeout(1000);
  }

  /** 检查任务是否出现在列表中 */
  async expectTaskVisible(title: string) {
    await expect(this.page.locator(`text=${title}`)).toBeVisible({ timeout: 5000 });
  }
}
