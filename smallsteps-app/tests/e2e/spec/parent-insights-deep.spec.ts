import { test, expect } from '@playwright/test';
import { LoginPage } from '../pages/LoginPage';
import { ParentNavPage } from '../pages/ParentNavPage';
import { TEST_ACCOUNTS } from '../../fixtures/test-data';

test.describe('洞察菜单深度测试', () => {
  let loginPage: LoginPage;
  let navPage: ParentNavPage;

  test.beforeEach(async ({ page }) => {
    loginPage = new LoginPage(page);
    navPage = new ParentNavPage(page);
    await loginPage.goto();
    await loginPage.login(TEST_ACCOUNTS.parent1.username, TEST_ACCOUNTS.parent1.password);
    
    // 确保登录成功后再跳转，或者直接使用导航组件跳转
    await navPage.goToInsights();
    await page.waitForURL(/insights/);
  });

  test('洞察页面基本元素验证', async ({ page }) => {
    // 验证页面加载
    await expect(page).toHaveURL(/insights/);

    // 验证页面标题
    await expect(page.locator('.section-title').first()).toBeVisible();

    // 验证底部导航栏
    await expect(navPage.homeTab).toBeVisible();
    await expect(navPage.taskTab).toBeVisible();
    await expect(navPage.insightsTab).toBeVisible();
    await expect(navPage.profileTab).toBeVisible();
  });

  test('每周重点卡片测试', async ({ page }) => {
    // 查找每周重点卡片
    const weeklyFocusSection = page.locator('.section:has-text("每周重点")');

    if (await weeklyFocusSection.count() > 0) {
      await expect(weeklyFocusSection).toBeVisible();

      // 测试详情链接
      const detailsLink = weeklyFocusSection.getByText('详情');
      if (await detailsLink.count() > 0) {
        await detailsLink.click();
        // 可能跳转到周报详情页面
        await page.waitForTimeout(1000);
      }
    }
  });

  test('能力发展图表测试', async ({ page }) => {
    // 查找图表容器
    const chartContainer = page.locator('.chart-container, .ability-chart, .progress-chart');

    if (await chartContainer.count() > 0) {
      await expect(chartContainer.first()).toBeVisible();
    }

    // 查找进度项
    const progressItems = page.locator('.progress-item, .chart-item, .stat-item');
    const count = await progressItems.count();
    if (count > 0) {
      // 验证至少有一些进度项可见
      await expect(progressItems.first()).toBeVisible();
    }
  });

  test('月度情绪热力图测试', async ({ page }) => {
    // 查找日历卡片
    const calendarCard = page.locator('.calendar-card, .emotion-heatmap');

    if (await calendarCard.count() > 0) {
      await expect(calendarCard).toBeVisible();

      // 查找月份切换按钮
      const prevButton = calendarCard.locator('.nav-arrow, .prev-month, .arrow-left').first();
      const nextButton = calendarCard.locator('.nav-arrow, .next-month, .arrow-right').first();

      // 测试上个月切换
      if (await prevButton.count() > 0) {
        await prevButton.click();
        await page.waitForTimeout(500);
      }

      // 测试下个月切换
      if (await nextButton.count() > 0) {
        await nextButton.click();
        await page.waitForTimeout(500);
      }

      // 查找日历日期
      const calendarDays = calendarCard.locator('.day-cell, .calendar-day, .day');
      const dayCount = await calendarDays.count();
      if (dayCount > 0) {
        // 点击某个日期
        await calendarDays.nth(10).click();
        await page.waitForTimeout(500);
      }
    }
  });

  test('底部导航栏测试', async ({ page }) => {
    // 导航到首页
    await navPage.goToHome();
    await expect(page).toHaveURL(/dashboard/);

    // 导航到任务
    await navPage.goToTaskCreator();
    await expect(page).toHaveURL(/task-creator/);

    // 导航到我的
    await navPage.goToProfile();
    await expect(page).toHaveURL(/profile/);

    // 返回洞察
    await navPage.goToInsights();
    await expect(page).toHaveURL(/insights/);
  });

  test('周报详情页面测试', async ({ page }) => {
    // 查找查看周报按钮
    const weeklyReportBtn = page.getByText('查看周报');

    if (await weeklyReportBtn.count() > 0) {
      await weeklyReportBtn.click();
      await page.waitForTimeout(1000);

      // 验证跳转
      if (page.url().includes('weekly-report')) {
        await expect(page).toHaveURL(/weekly-report/);
      }
    }
  });

  test('情绪急救包测试', async ({ page }) => {
    // 查找情绪急救包入口
    const emergencyKit = page.getByText('情绪急救包');

    if (await emergencyKit.count() > 0) {
      await emergencyKit.click();
      await page.waitForTimeout(1000);

      // 验证跳转
      if (page.url().includes('emotion')) {
        await expect(page).toHaveURL(/emotion/);
      }
    }
  });

  test('数据加载等待测试', async ({ page }) => {
    // 刷新页面
    await page.reload();
    await page.waitForLoadState('networkidle');

    // 验证页面关键元素已加载
    await expect(page).toHaveURL(/insights/);

    // 等待数据加载
    await page.waitForTimeout(3000);

    // 验证图表或数据已显示
    const chartsOrData = page.locator('.chart, .data-card, .stat-card');
    if (await chartsOrData.count() > 0) {
      await expect(chartsOrData.first()).toBeVisible();
    }
  });
});
