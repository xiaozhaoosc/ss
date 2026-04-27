import { test, expect } from '@playwright/test';
import { LoginPage } from '../pages/LoginPage';
import { TEST_ACCOUNTS } from '../../fixtures/test-data';

test.describe('Parent Basic Tests', () => {
  let loginPage: LoginPage;

  test.beforeEach(async ({ page }) => {
    loginPage = new LoginPage(page);
  });

  test('Login with parent1', async ({ page }) => {
    // 登录
    await loginPage.goto();
    await loginPage.login(TEST_ACCOUNTS.parent1.username, TEST_ACCOUNTS.parent1.password);
    
    // 验证仪表盘页面加载
    await expect(page).toHaveURL(/dashboard/);
  });

  test('Login with parent2', async ({ page }) => {
    // 登录
    await loginPage.goto();
    await loginPage.login(TEST_ACCOUNTS.parent2.username, TEST_ACCOUNTS.parent2.password);
    
    // 验证仪表盘页面加载
    await expect(page).toHaveURL(/dashboard/);
  });

  test('Navigate to profile page', async ({ page }) => {
    // 登录
    await loginPage.goto();
    await loginPage.login(TEST_ACCOUNTS.parent1.username, TEST_ACCOUNTS.parent1.password);
    
    // 导航到个人中心
    await page.goto('/pages/parent/profile/index');
    
    // 验证页面加载
    await expect(page).toHaveURL(/profile/);
  });

  test('Navigate to insights page', async ({ page }) => {
    // 登录
    await loginPage.goto();
    await loginPage.login(TEST_ACCOUNTS.parent1.username, TEST_ACCOUNTS.parent1.password);
    
    // 导航到洞察页面
    await page.goto('/pages/parent/insights/index');
    
    // 验证页面加载
    await expect(page).toHaveURL(/insights/);
  });

  test('Navigate to task creator page', async ({ page }) => {
    // 登录
    await loginPage.goto();
    await loginPage.login(TEST_ACCOUNTS.parent1.username, TEST_ACCOUNTS.parent1.password);
    
    // 导航到任务创建页面
    await page.goto('/pages/parent/task-creator/index');
    
    // 验证页面加载
    await expect(page).toHaveURL(/task-creator/);
  });

  test('Navigate to daily focus page', async ({ page }) => {
    // 登录
    await loginPage.goto();
    await loginPage.login(TEST_ACCOUNTS.parent1.username, TEST_ACCOUNTS.parent1.password);
    
    // 导航到每日焦点页面
    await page.goto('/pages/parent/daily-focus/index');
    
    // 验证页面加载
    await expect(page).toHaveURL(/daily-focus/);
  });

  test('Navigate to exec record page', async ({ page }) => {
    // 登录
    await loginPage.goto();
    await loginPage.login(TEST_ACCOUNTS.parent1.username, TEST_ACCOUNTS.parent1.password);
    
    // 导航到执行记录页面
    await page.goto('/pages/parent/exec-record/index');
    
    // 验证页面加载
    await expect(page).toHaveURL(/exec-record/);
  });

  test('Navigate to weekly report page', async ({ page }) => {
    // 登录
    await loginPage.goto();
    await loginPage.login(TEST_ACCOUNTS.parent1.username, TEST_ACCOUNTS.parent1.password);
    
    // 导航到周报页面
    await page.goto('/pages/parent/weekly-report/index');
    
    // 验证页面加载
    await expect(page).toHaveURL(/weekly-report/);
  });
});
