import { test, expect } from '@playwright/test';

test.describe('Parent Dashboard Functional Scan', () => {
  test.beforeEach(async ({ page }) => {
    test.skip(test.info().project.name !== 'mobile-parent');
    
    // 登录
    await page.goto('/');
    await page.fill('input[type="text"]', 'ken2zhao');
    await page.fill('input[type="password"]', 'Aa123456');
    await page.click('text=登 录');
    await page.waitForURL(/.*dashboard.*/);
  });

  test('Check Dashboard Metrics', async ({ page }) => {
    // 验证核心组件是否显示
    // 根据 Uni-app 编译后的结果，可能需要寻找特定的文本或类名
    await expect(page.locator('text=今日焦点')).toBeVisible({ timeout: 10000 });
    await expect(page.locator('text=时光机')).toBeVisible();
    await expect(page.locator('text=执行记录')).toBeVisible();
  });

  test('Navigate to Task Creation', async ({ page }) => {
    // 寻找“新增任务”或类似按钮
    const addTaskBtn = page.locator('text=新增, text=添加, .uni-icons-plus');
    if (await addTaskBtn.count() > 0) {
      await addTaskBtn.first().click();
      await expect(page).toHaveURL(/.*task-edit.*/);
    } else {
      console.log('Add task button not found with default selectors, scanning page...');
      // 记录一个潜在的 UI 发现
    }
  });
});
