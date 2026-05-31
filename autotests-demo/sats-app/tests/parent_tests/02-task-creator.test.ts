import { test, expect } from '@playwright/test';
import { loginAsParent, switchTab, screenshot } from './utils';

test.describe('Tab 2: 任务管理 (Tasks)', () => {
  test.beforeEach(async ({ page, request }) => {
    await loginAsParent(page, request);
    await switchTab(page, '任务');
  });

  test('2.1 创建任务页面加载', async ({ page }) => {
    // 实际显示: "创建任务" 标题
    await expect(page.getByText('创建任务')).toBeVisible({ timeout: 15000 });
    await screenshot(page, '02-task-loaded');
  });

  test('2.2 任务输入区域', async ({ page }) => {
    // 实际显示: 输入框 placeholder "输入你想让孩子做的事"
    const input = page.locator('textarea, input[type="text"]').first();
    await expect(input).toBeVisible({ timeout: 15000 });
    await screenshot(page, '02-task-input');
  });

  test('2.3 AI 拆解按钮', async ({ page }) => {
    // 实际显示: "AI 拆解" 按钮
    await expect(page.getByText(/AI.*拆解/).first()).toBeVisible({ timeout: 15000 });
    await screenshot(page, '02-task-ai-btn');
  });

  test('2.4 指派给孩子', async ({ page }) => {
    // 实际显示: "指派给" + 孩子头像
    await expect(page.getByText('指派给')).toBeVisible({ timeout: 15000 });
    await screenshot(page, '02-task-assign');
  });
});
