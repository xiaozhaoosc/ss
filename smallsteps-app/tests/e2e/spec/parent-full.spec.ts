import { test, expect } from '@playwright/test';
import { LoginPage } from '../pages/LoginPage';
import { ParentDashboardPage } from '../pages/ParentDashboardPage';
import { ParentProfilePage } from '../pages/ParentProfilePage';
import { ParentInsightsPage } from '../pages/ParentInsightsPage';
import { ParentNavPage } from '../pages/ParentNavPage';
import { TEST_ACCOUNTS } from '../../fixtures/test-data';

test.describe('Parent Full E2E Flow Tests', () => {
  let loginPage: LoginPage;
  let dashboardPage: ParentDashboardPage;
  let profilePage: ParentProfilePage;
  let insightsPage: ParentInsightsPage;
  let navPage: ParentNavPage;

  test.beforeEach(async ({ page }) => {
    loginPage = new LoginPage(page);
    dashboardPage = new ParentDashboardPage(page);
    profilePage = new ParentProfilePage(page);
    insightsPage = new ParentInsightsPage(page);
    navPage = new ParentNavPage(page);
  });

  test('Complete parent workflow', async ({ page }) => {
    // 1. 登录
    await loginPage.goto();
    await loginPage.login(TEST_ACCOUNTS.parent1.username, TEST_ACCOUNTS.parent1.password);
    await expect(page).toHaveURL(/dashboard/);

    // 2. 仪表盘操作
    await dashboardPage.toggleNotifications();
    await dashboardPage.markAllNotificationsAsRead();
    await dashboardPage.goToDailyFocusDetails();
    await page.goBack();
    await dashboardPage.goToExecRecord();
    await page.goBack();

    // 3. 导航到任务创建
    await navPage.goToTaskCreator();
    await expect(page).toHaveURL(/task-creator/);

    // 4. 导航到洞察页面
    await navPage.goToInsights();
    await expect(page).toHaveURL(/insights/);
    await insightsPage.changeMonth('next');
    await insightsPage.changeMonth('previous');
    await insightsPage.goToWeeklyReportDetails();
    await page.goBack();

    // 5. 导航到家长中心
    await navPage.goToProfile();
    await expect(page).toHaveURL(/profile/);

    // 6. 测试设置导航
    await profilePage.goToNotificationSettings();
    await profilePage.goToPrivacyPolicy();
    await profilePage.goToAccountSecurity();
    await profilePage.goToHelpAndFeedback();

    // 7. 退出登录
    await profilePage.logout(true);
    await expect(page).toHaveURL(/login/);
  });

  test('Test with parent2 account', async ({ page }) => {
    // 1. 登录 parent2
    await loginPage.goto();
    await loginPage.login(TEST_ACCOUNTS.parent2.username, TEST_ACCOUNTS.parent2.password);
    await expect(page).toHaveURL(/dashboard/);

    // 2. 基本导航测试
    await navPage.goToTaskCreator();
    await navPage.goToInsights();
    await navPage.goToProfile();
    await navPage.goToHome();

    // 3. 退出登录
    await navPage.goToProfile();
    await profilePage.logout(true);
    await expect(page).toHaveURL(/login/);
  });
});
