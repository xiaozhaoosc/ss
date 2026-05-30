import { test, expect } from '@playwright/test';
import { loginAsParent, switchTab, screenshot } from './utils';

test.describe('Tab 2: 任务创建器 (Task Creator)', () => {
  test.beforeEach(async ({ page }) => {
    await loginAsParent(page);
    await switchTab(page, '任务');
  });

  test('2.1 任务创建页面加载', async ({ page }) => {
    // 验证"创建任务"标题
    const title = page.locator('text=/创建任务/');
    await expect(title).toBeVisible({ timeout: 10000 });
    await screenshot(page, '02-task-creator-loaded');
  });

  test('2.2 任务输入框和字数限制', async ({ page }) => {
    // 验证输入提示
    const placeholder = page.locator('text=/输入你想让孩子做的事/');
    await expect(placeholder).toBeVisible({ timeout: 10000 });
    // 验证字数显示 0/200
    const charCount = page.locator('text=/0\/200/');
    await expect(charCount).toBeVisible();
    await screenshot(page, '02-task-input');
  });

  test('2.3 AI 拆解和模板库按钮', async ({ page }) => {
    const aiBtn = page.locator('text=/AI 拆解/');
    await expect(aiBtn).toBeVisible({ timeout: 10000 });
    const templateBtn = page.locator('text=/模板库/');
    await expect(templateBtn).toBeVisible();
    await screenshot(page, '02-task-buttons');
  });

  test('2.4 孩子选择区域', async ({ page }) => {
    // 验证"指派给"区域
    const assignLabel = page.locator('text=/指派给/');
    await expect(assignLabel).toBeVisible({ timeout: 10000 });
    // 验证有孩子头像
    const children = page.locator('text=/张小明|张小红/');
    const count = await children.count();
    expect(count).toBeGreaterThan(0);
    await screenshot(page, '02-task-children');
  });

  test('2.5 任务步骤列表', async ({ page }) => {
    // 验证"任务步骤"区域
    const stepsLabel = page.locator('text=/任务步骤/');
    await expect(stepsLabel).toBeVisible({ timeout: 10000 });
    // 验证有步骤条目
    const stepItems = page.locator('text=/drag_indicator/');
    const count = await stepItems.count();
    expect(count).toBeGreaterThan(0);
    // 验证"添加步骤"按钮
    const addStep = page.locator('text=/添加步骤/');
    await expect(addStep).toBeVisible();
    await screenshot(page, '02-task-steps');
  });

  test('2.6 重复和模板选项', async ({ page }) => {
    const repeat = page.locator('text=/每天重复/');
    await expect(repeat).toBeVisible({ timeout: 10000 });
    const saveTemplate = page.locator('text=/存为模板/');
    await expect(saveTemplate).toBeVisible();
    await screenshot(page, '02-task-options');
  });

  test('2.7 发布按钮', async ({ page }) => {
    const publishBtn = page.locator('text=/发布/');
    await expect(publishBtn).toBeVisible({ timeout: 10000 });
    await screenshot(page, '02-task-publish');
  });
});
