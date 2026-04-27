import { test, expect } from '@playwright/test';
import { LoginPage } from '../pages/LoginPage';
import { ParentDashboardPage } from '../pages/ParentDashboardPage';
import { ParentNavPage } from '../pages/ParentNavPage';
import { TEST_ACCOUNTS } from '../../fixtures/test-data';

test.describe('Parent Dashboard Tests', () => {
  let loginPage: LoginPage;
  let dashboardPage: ParentDashboardPage;
  let navPage: ParentNavPage;

  test.beforeEach(async ({ page }) => {
    loginPage = new LoginPage(page);
    dashboardPage = new ParentDashboardPage(page);
    navPage = new ParentNavPage(page);
    await loginPage.goto();
    await loginPage.login(TEST_ACCOUNTS.parent1.username, TEST_ACCOUNTS.parent1.password);
  });

  test('Verify dashboard page loads correctly', async ({ page }) => {
    await expect(page).toHaveURL(/dashboard/);
    await expect(dashboardPage.aiInsightCard).toBeVisible();
    await expect(dashboardPage.dailyFocusSection).toBeVisible();
    await expect(dashboardPage.execRecordSection).toBeVisible();
  });

  test('Test notification functionality', async ({ page }) => {
    await dashboardPage.toggleNotifications();
    await expect(dashboardPage.notificationDropdown).toBeVisible();

    // 测试全部已读
    await dashboardPage.markAllNotificationsAsRead();
    // 验证通知数量已重置
  });

  test('Test AI insight card interactions', async ({ page }) => {
    await dashboardPage.clickAiInsightCard();
    // 应该跳转到AI洞察详情页面
    await page.goBack();

    await dashboardPage.viewWeeklyReport();
    // 应该跳转到周报页面
    await page.goBack();
  });

  test('Test section navigation', async ({ page }) => {
    await dashboardPage.goToDailyFocusDetails();
    await expect(page).toHaveURL(/daily-focus/);
    await page.goBack();

    await dashboardPage.goToExecRecord();
    await expect(page).toHaveURL(/exec-record/);
    await page.goBack();
  });

  test('Test stats and timeline interactions', async ({ page }) => {
    // 测试统计数据横向滚动
    await dashboardPage.scrollStatsHorizontally();

    // 测试时间线点击
    const timelineItems = dashboardPage.timelineContainer.locator('.timeline-item');
    const count = await timelineItems.count();
    if (count > 0) {
      await dashboardPage.clickTimelineItem(0);
      // 应该显示详情或跳转到详情页面
    }
  });

  test('Test bottom navigation from dashboard', async ({ page }) => {
    await navPage.goToTaskCreator();
    await expect(page).toHaveURL(/task-creator/);

    await navPage.goToInsights();
    await expect(page).toHaveURL(/insights/);

    await navPage.goToProfile();
    await expect(page).toHaveURL(/profile/);

    await navPage.goToHome();
    await expect(page).toHaveURL(/dashboard/);
  });
});
