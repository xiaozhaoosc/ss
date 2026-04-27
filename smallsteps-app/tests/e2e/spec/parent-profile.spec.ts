import { test, expect } from '@playwright/test';
import { LoginPage } from '../pages/LoginPage';
import { ParentProfilePage } from '../pages/ParentProfilePage';
import { ParentNavPage } from '../pages/ParentNavPage';
import { TEST_ACCOUNTS } from '../../fixtures/test-data';

test.describe('Parent Profile Tests', () => {
  let loginPage: LoginPage;
  let profilePage: ParentProfilePage;
  let navPage: ParentNavPage;

  test.beforeEach(async ({ page }) => {
    loginPage = new LoginPage(page);
    profilePage = new ParentProfilePage(page);
    navPage = new ParentNavPage(page);
    await loginPage.goto();
    await loginPage.login(TEST_ACCOUNTS.parent1.username, TEST_ACCOUNTS.parent1.password);
    await navPage.goToProfile();
  });

  test('Verify profile page loads correctly', async ({ page }) => {
    await expect(page).toHaveURL(/profile/);
    await expect(profilePage.logoutButton).toBeVisible();
  });

  test('Test child management', async ({ page }) => {
    // 测试添加孩子
    await profilePage.addChild();
    await expect(page).toHaveURL(/bind/);
    await page.goBack();

    // 测试编辑孩子（如果有孩子）
    const childrenCount = await profilePage.childrenList.count();
    if (childrenCount > 0) {
      await profilePage.editChild(0);
      await expect(page).toHaveURL(/edit/);
      await page.goBack();

      // 测试显示二维码
      await profilePage.showChildQr(0);
      await expect(page.getByRole('dialog')).toBeVisible();
      await page.getByRole('button', { name: '确定' }).click();
    }
  });

  test('Test settings navigation', async ({ page }) => {
    // 测试通知设置
    await profilePage.goToNotificationSettings();
    // 应该显示提示或跳转到设置页面

    // 测试隐私政策
    await profilePage.goToPrivacyPolicy();
    // 应该显示提示或跳转到隐私政策页面

    // 测试账号安全
    await profilePage.goToAccountSecurity();
    // 应该显示提示或跳转到账号安全页面

    // 测试帮助与反馈
    await profilePage.goToHelpAndFeedback();
    // 应该显示提示或跳转到帮助页面
  });

  test('Test logout functionality', async ({ page }) => {
    // 测试取消退出
    await profilePage.logout(false);
    await expect(profilePage.logoutButton).toBeVisible();

    // 测试确认退出
    await profilePage.logout(true);
    await expect(page).toHaveURL(/login/);
  });

  test('Test bottom navigation', async ({ page }) => {
    await navPage.goToHome();
    await expect(page).toHaveURL(/dashboard/);

    await navPage.goToTaskCreator();
    await expect(page).toHaveURL(/task-creator/);

    await navPage.goToInsights();
    await expect(page).toHaveURL(/insights/);

    await navPage.goToProfile();
    await expect(page).toHaveURL(/profile/);
  });
});
