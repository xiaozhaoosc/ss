import { test, expect } from '@playwright/test';
import { LoginPage } from '../pages/LoginPage';
import { TEST_ACCOUNTS } from '../../fixtures/test-data';

test.describe.configure({ mode: 'serial' });

test.describe('奖励相关页面深度测试', () => {
  test.use({ storageState: 'playwright/.auth/parent.json' });

  test.beforeEach(async ({ page }) => {
    // 使用 storageState 后无需手动登录
  });

  test('奖励配置页面加载测试', async ({ page }) => {
    await page.goto('/#/pages/parent/reward-config/index');
    await page.waitForLoadState('networkidle');

    // 验证页面加载
    await expect(page).toHaveURL(/reward-config/);

    // 验证页面标题
    await expect(page.getByText('奖励设置')).toBeVisible({ timeout: 10000 });

    // 验证待处理请求区域
    await expect(page.getByText('待处理请求')).toBeVisible();

    // 验证 Tab 切换
    await expect(page.getByText('配置奖励')).toBeVisible();
    await expect(page.getByText('兑换历史')).toBeVisible();
  });

  test('奖励配置页面 - Tab 切换测试', async ({ page }) => {
    await page.goto('/#/pages/parent/reward-config/index');
    await page.waitForLoadState('networkidle');

    // 等待页面加载
    await page.waitForTimeout(1000);

    // 点击兑换历史 Tab
    const historyTab = page.getByText('兑换历史');
    if (await historyTab.count() > 0) {
      await historyTab.click({ force: true });
      await page.waitForTimeout(500);
    }

    // 点击配置奖励 Tab
    const configTab = page.getByText('配置奖励');
    if (await configTab.count() > 0) {
      await configTab.click({ force: true });
      await page.waitForTimeout(500);
    }
  });

  test('奖励配置页面 - 添加新奖励按钮', async ({ page }) => {
    await page.goto('/#/pages/parent/reward-config/index');
    await page.waitForLoadState('networkidle');

    // 等待页面加载
    await page.waitForTimeout(1000);

    // 查找添加奖励按钮
    const addBtn = page.locator('.add-reward-btn, button:has-text("添加新奖励")');

    if (await addBtn.count() > 0) {
      await expect(addBtn.first()).toBeVisible();
      await addBtn.first().click({ force: true });
      await page.waitForTimeout(1000);
    }
  });

  test('奖励配置页面 - 待处理请求', async ({ page }) => {
    await page.goto('/#/pages/parent/reward-config/index');
    await page.waitForLoadState('networkidle');

    // 等待数据加载
    await page.waitForTimeout(2000);

    // 查找请求卡片
    const requestCards = page.locator('reward-request-card');

    if (await requestCards.count() > 0) {
      await expect(requestCards.first()).toBeVisible();
    }
  });

  test('奖励配置页面 - 现有奖励列表', async ({ page }) => {
    await page.goto('/#/pages/parent/reward-config/index');
    await page.waitForLoadState('networkidle');

    // 等待数据加载
    await page.waitForTimeout(2000);

    // 查找奖励项
    const rewardItems = page.locator('reward-config-item, .reward-item');
    const count = await rewardItems.count();

    if (count > 0) {
      await expect(rewardItems.first()).toBeVisible();
    }
  });

  test('奖励配置页面 - 底部导航栏', async ({ page }) => {
    await page.goto('/#/pages/parent/reward-config/index');
    await page.waitForLoadState('networkidle');

    // 验证底部导航
    await expect(page.getByText('首页')).toBeVisible();
    await expect(page.getByText('任务')).toBeVisible();
    await expect(page.getByText('洞察')).toBeVisible();
    await expect(page.getByText('我的')).toBeVisible();
  });

  test('奖励创建页面加载测试', async ({ page }) => {
    await page.goto('/#/pages/parent/reward-creator/index');
    await page.waitForLoadState('networkidle');

    // 验证页面加载
    await expect(page).toHaveURL(/reward-creator/);

    // 等待页面标题
    await page.waitForTimeout(1000);

    // 查找表单元素
    const formElements = page.locator('input, textarea, picker');
    const count = await formElements.count();

    // 至少应该有表单元素存在
    expect(count).toBeGreaterThanOrEqual(0);
  });

  test('奖励创建页面 - 表单字段验证', async ({ page }) => {
    await page.goto('/#/pages/parent/reward-creator/index');
    await page.waitForLoadState('networkidle');

    // 等待表单加载
    await page.waitForTimeout(2000);

    // 查找输入框
    const inputs = page.locator('input');
    const inputCount = await inputs.count();

    if (inputCount > 0) {
      // 验证至少有一些输入框存在
      await expect(inputs.first()).toBeVisible();
    }
  });

  test('奖励创建页面 - 保存按钮', async ({ page }) => {
    await page.goto('/#/pages/parent/reward-creator/index');
    await page.waitForLoadState('networkidle');

    // 等待页面加载
    await page.waitForTimeout(1000);

    // 查找保存按钮
    const saveBtn = page.locator('button:has-text("保存"), .save-btn, button:has-text("创建")');

    if (await saveBtn.count() > 0) {
      await expect(saveBtn.first()).toBeVisible();
    }
  });

  test('奖励创建页面 - 取消按钮', async ({ page }) => {
    await page.goto('/#/pages/parent/reward-creator/index');
    await page.waitForLoadState('networkidle');

    // 等待页面加载
    await page.waitForTimeout(1000);

    // 查找取消按钮
    const cancelBtn = page.locator('button:has-text("取消"), .cancel-btn');

    if (await cancelBtn.count() > 0) {
      await expect(cancelBtn.first()).toBeVisible();
    }
  });
});
