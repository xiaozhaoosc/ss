import { test, expect } from '@playwright/test';
import { LoginPage } from '../pages/LoginPage';
import { ParentInsightsPage } from '../pages/ParentInsightsPage';
import { ParentNavPage } from '../pages/ParentNavPage';
import { TEST_ACCOUNTS } from '../../fixtures/test-data';

test.describe('Parent Insights Tests', () => {
  let loginPage: LoginPage;
  let insightsPage: ParentInsightsPage;
  let navPage: ParentNavPage;

  test.beforeEach(async ({ page }) => {
    loginPage = new LoginPage(page);
    insightsPage = new ParentInsightsPage(page);
    navPage = new ParentNavPage(page);
    await loginPage.goto();
    await loginPage.login(TEST_ACCOUNTS.parent1.username, TEST_ACCOUNTS.parent1.password);
    await navPage.goToInsights();
  });

  test('Verify insights page loads correctly', async ({ page }) => {
    await expect(page).toHaveURL(/insights/);
    await expect(insightsPage.weeklyFocusSection).toBeVisible();
    await expect(insightsPage.abilityChart).toBeVisible();
    await expect(insightsPage.emotionHeatmap).toBeVisible();
  });

  test('Test weekly focus section', async ({ page }) => {
    await insightsPage.goToWeeklyReportDetails();
    await expect(page).toHaveURL(/weekly-report/);
    await page.goBack();
  });

  test('Test emotion heatmap interactions', async ({ page }) => {
    // 测试月份切换
    const initialMonth = await insightsPage.getCurrentMonth();
    await insightsPage.changeMonth('next');
    const nextMonth = await insightsPage.getCurrentMonth();
    expect(nextMonth).not.toBe(initialMonth);

    await insightsPage.changeMonth('previous');
    const previousMonth = await insightsPage.getCurrentMonth();
    expect(previousMonth).toBe(initialMonth);

    // 测试日历点击
    const calendarDays = insightsPage.calendarDays;
    const count = await calendarDays.count();
    if (count > 0) {
      await insightsPage.clickCalendarDay(10);
      // 应该显示当天的情绪详情
    }
  });

  test('Test bottom navigation from insights', async ({ page }) => {
    await navPage.goToHome();
    await expect(page).toHaveURL(/dashboard/);

    await navPage.goToTaskCreator();
    await expect(page).toHaveURL(/task-creator/);

    await navPage.goToProfile();
    await expect(page).toHaveURL(/profile/);

    await navPage.goToInsights();
    await expect(page).toHaveURL(/insights/);
  });
});
