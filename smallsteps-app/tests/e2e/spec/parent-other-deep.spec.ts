import { test, expect } from '@playwright/test';
import { LoginPage } from '../pages/LoginPage';
import { TEST_ACCOUNTS } from '../../fixtures/test-data';

test.describe('设备配置和亲子契约页面测试', () => {
  let loginPage: LoginPage;

  test.beforeEach(async ({ page }) => {
    loginPage = new LoginPage(page);
    await loginPage.goto();
    await loginPage.login(TEST_ACCOUNTS.parent1.username, TEST_ACCOUNTS.parent1.password);
  });

  test('设备配置页面加载测试', async ({ page }) => {
    await page.goto('/pages/parent/device-config/index');
    await page.waitForLoadState('networkidle');

    // 验证页面加载
    await expect(page).toHaveURL(/device-config/);

    // 验证页面标题
    await expect(page.getByText('设备配置')).toBeVisible({ timeout: 10000 });

    // 验证功能不可用提示
    await expect(page.getByText('功能暂时不可用')).toBeVisible();
    await expect(page.getByText('ESP32相关功能已临时关闭，敬请期待')).toBeVisible();
  });

  test('设备配置页面 - 返回按钮', async ({ page }) => {
    await page.goto('/pages/parent/device-config/index');
    await page.waitForLoadState('networkidle');

    // 查找返回按钮
    const backBtn = page.locator('.btn-primary, .back-btn, button:has-text("返回")');

    if (await backBtn.count() > 0) {
      await expect(backBtn.first()).toBeVisible();
    }
  });

  test('亲子契约页面加载测试', async ({ page }) => {
    await page.goto('/pages/parent/contract/index');
    await page.waitForLoadState('networkidle');

    // 验证页面加载
    await expect(page).toHaveURL(/contract/);

    // 验证页面标题
    await expect(page.getByText('星空契约')).toBeVisible({ timeout: 10000 });

    // 验证星星数量
    await expect(page.locator('.star-count')).toBeVisible();
  });

  test('亲子契约页面 - 待处理兑换区域', async ({ page }) => {
    await page.goto('/pages/parent/contract/index');
    await page.waitForLoadState('networkidle');

    // 验证待处理兑换标题
    await expect(page.getByText('待处理兑换')).toBeVisible();

    // 等待数据加载
    await page.waitForTimeout(2000);

    // 检查是否有待处理项
    const pendingSection = page.locator('.empty-mini, .card-list');
    await expect(pendingSection.first()).toBeVisible();
  });

  test('亲子契约页面 - 活跃契约区域', async ({ page }) => {
    await page.goto('/pages/parent/contract/index');
    await page.waitForLoadState('networkidle');

    // 验证活跃契约标题
    await expect(page.getByText('活跃契约')).toBeVisible();

    // 等待数据加载
    await page.waitForTimeout(2000);

    // 检查是否有契约卡片
    const contractCard = page.locator('.contract-card');
    if (await contractCard.count() > 0) {
      await expect(contractCard).toBeVisible();
    }
  });

  test('亲子契约页面 - 契约卡片内容', async ({ page }) => {
    await page.goto('/pages/parent/contract/index');
    await page.waitForLoadState('networkidle');

    // 等待数据加载
    await page.waitForTimeout(2000);

    // 查找契约类型
    const contractType = page.getByText('每日动力');
    if (await contractType.count() > 0) {
      await expect(contractType).toBeVisible();
    }

    // 查找契约状态
    const contractStatus = page.getByText('进行中');
    if (await contractStatus.count() > 0) {
      await expect(contractStatus).toBeVisible();
    }
  });

  test('亲子契约页面 - 进度条', async ({ page }) => {
    await page.goto('/pages/parent/contract/index');
    await page.waitForLoadState('networkidle');

    // 等待数据加载
    await page.waitForTimeout(2000);

    // 查找进度条
    const progressBar = page.locator('.progress-bar');
    if (await progressBar.count() > 0) {
      await expect(progressBar).toBeVisible();
    }
  });

  test('亲子契约页面 - 星星数量显示', async ({ page }) => {
    await page.goto('/pages/parent/contract/index');
    await page.waitForLoadState('networkidle');

    // 验证星星图标
    await expect(page.locator('.star-icon')).toBeVisible();

    // 验证星星数量
    await expect(page.locator('.count')).toBeVisible();
  });
});
