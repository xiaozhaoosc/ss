import { test, expect } from '@playwright/test';
import { LoginPage } from '../pages/LoginPage';
import { TEST_ACCOUNTS } from '../../fixtures/test-data';

test.describe('家长中心深度测试', () => {
  let loginPage: LoginPage;

  test.beforeEach(async ({ page }) => {
    loginPage = new LoginPage(page);
    await loginPage.goto();
    await loginPage.login(TEST_ACCOUNTS.parent1.username, TEST_ACCOUNTS.parent1.password);
    await page.goto('/pages/parent/profile/index');
    await page.waitForLoadState('networkidle');
  });

  test('家长中心页面基本元素验证', async ({ page }) => {
    // 验证页面标题
    await expect(page.locator('.section-title').first()).toBeVisible();

    // 验证添加按钮
    const addBtn = page.locator('.add-btn');
    await expect(addBtn).toBeVisible();
    await expect(addBtn).toContainText('添加');

    // 验证通用设置区域
    await expect(page.getByText('通用设置')).toBeVisible();

    // 验证设置项
    await expect(page.getByText('通知设置')).toBeVisible();
    await expect(page.getByText('隐私政策')).toBeVisible();
    await expect(page.getByText('账号安全')).toBeVisible();

    // 验证帮助与反馈
    await expect(page.getByText('帮助与反馈')).toBeVisible();

    // 验证退出登录按钮
    const logoutBtn = page.locator('.logout-btn');
    await expect(logoutBtn).toBeVisible();
    await expect(logoutBtn).toContainText('退出登录');

    // 验证版本号
    await expect(page.getByText('版本号 v2.4.0 (Small Steps)')).toBeVisible();
  });

  test('添加孩子按钮点击测试', async ({ page }) => {
    const addBtn = page.locator('.add-btn');
    await addBtn.click();

    // 验证跳转到绑定页面
    await expect(page).toHaveURL(/bind/);
  });

  test('设置项点击测试', async ({ page }) => {
    // 测试通知设置
    await page.getByText('通知设置').click();
    await expect(page.locator('.uni-toast')).toBeVisible({ timeout: 3000 });

    // 返回
    await page.goBack();
    await page.waitForLoadState('networkidle');

    // 测试隐私政策
    await page.getByText('隐私政策').click();
    await expect(page.locator('.uni-toast')).toBeVisible({ timeout: 3000 });

    // 返回
    await page.goBack();
    await page.waitForLoadState('networkidle');

    // 测试账号安全
    await page.getByText('账号安全').click();
    await expect(page.locator('.uni-toast')).toBeVisible({ timeout: 3000 });
  });

  test('帮助与反馈点击测试', async ({ page }) => {
    await page.getByText('帮助与反馈').click();
    await expect(page.locator('.uni-toast')).toBeVisible({ timeout: 3000 });
  });

  test('退出登录按钮 - 取消操作', async ({ page }) => {
    const logoutBtn = page.locator('.logout-btn');

    // 监听弹窗事件
    page.on('dialog', async dialog => {
      expect(dialog.message()).toContain('确定要退出登录吗？');
      await dialog.dismiss(); // 点击取消
    });

    await logoutBtn.click();

    // 等待弹窗出现
    await page.waitForTimeout(500);

    // 验证仍在当前页面
    await expect(page).toHaveURL(/profile/);
  });

  test('退出登录按钮 - 确认操作', async ({ page }) => {
    const logoutBtn = page.locator('.logout-btn');

    // 监听弹窗事件
    page.on('dialog', async dialog => {
      expect(dialog.message()).toContain('确定要退出登录吗？');
      await dialog.accept(); // 点击确定
    });

    await logoutBtn.click();

    // 等待退出并跳转到登录页
    await page.waitForURL(/login/, { timeout: 5000 });
    await expect(page).toHaveURL(/login/);
  });

  test('底部导航栏测试', async ({ page }) => {
    // 导航到首页
    await page.getByText('首页').click();
    await expect(page).toHaveURL(/dashboard/);

    // 导航到任务
    await page.getByText('任务').click();
    await expect(page).toHaveURL(/task-creator/);

    // 导航到洞察
    await page.getByText('洞察').click();
    await expect(page).toHaveURL(/insights/);

    // 导航到我的
    await page.getByText('我的').click();
    await expect(page).toHaveURL(/profile/);
  });

  test('孩子档案列表查看', async ({ page }) => {
    // 等待孩子列表加载
    await page.waitForTimeout(2000);

    // 检查是否有孩子档案
    const childCards = page.locator('.child-card');
    const count = await childCards.count();

    if (count > 0) {
      // 验证孩子卡片元素
      await expect(childCards.first().locator('.avatar')).toBeVisible();
      await expect(childCards.first().locator('.name')).toBeVisible();
      await expect(childCards.first().locator('.desc')).toBeVisible();

      // 验证操作按钮
      const actions = childCards.first().locator('.actions .icon-btn');
      await expect(actions.first()).toBeVisible(); // 二维码按钮
      await expect(actions.nth(1)).toBeVisible(); // 编辑按钮
    } else {
      // 验证空状态
      await expect(page.getByText('暂无孩子档案')).toBeVisible();
    }
  });

  test('孩子二维码显示测试', async ({ page }) => {
    // 等待孩子列表加载
    await page.waitForTimeout(2000);

    const childCards = page.locator('.child-card');
    const count = await childCards.count();

    if (count > 0) {
      // 点击二维码按钮
      const qrButton = childCards.first().locator('.actions .icon-btn').first();
      await qrButton.click();

      // 验证弹窗出现
      await page.waitForTimeout(500);

      // 检查是否有弹窗（uni.showModal）
      const modal = page.locator('.uni-modal');
      if (await modal.count() > 0) {
        await expect(modal).toBeVisible();
      }
    }
  });

  test('编辑孩子档案测试', async ({ page }) => {
    // 等待孩子列表加载
    await page.waitForTimeout(2000);

    const childCards = page.locator('.child-card');
    const count = await childCards.count();

    if (count > 0) {
      // 点击编辑按钮
      const editButton = childCards.first().locator('.actions .icon-btn').nth(1);
      await editButton.click();

      // 验证跳转到编辑页面
      await expect(page).toHaveURL(/edit/);
    }
  });
});
