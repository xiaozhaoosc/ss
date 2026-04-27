import { test, expect } from '@playwright/test';
import { LoginPage } from '../pages/LoginPage';
import { ParentDashboardPage } from '../pages/ParentDashboardPage';
import { TEST_ACCOUNTS } from '../../fixtures/test-data';

test.describe('Parent Authentication Tests', () => {
  let loginPage: LoginPage;
  let dashboardPage: ParentDashboardPage;

  test.beforeEach(async ({ page }) => {
    loginPage = new LoginPage(page);
    dashboardPage = new ParentDashboardPage(page);
    await loginPage.goto();
  });

  test('Login with valid parent1 credentials', async ({ page }) => {
    await loginPage.login(TEST_ACCOUNTS.parent1.username, TEST_ACCOUNTS.parent1.password);
    await expect(page).toHaveURL(/dashboard/);
  });

  test('Login with valid parent2 credentials', async ({ page }) => {
    await loginPage.login(TEST_ACCOUNTS.parent2.username, TEST_ACCOUNTS.parent2.password);
    await expect(page).toHaveURL(/dashboard/);
  });

  test.skip('Login with invalid credentials', async ({ page }) => {
    await loginPage.login('invalid', 'invalid');
    // 应该显示错误提示
    await expect(page.getByText('请输入账号')).toBeVisible({ timeout: 5000 });
  });

  test('Navigate to register page', async ({ page }) => {
    await loginPage.goToRegister();
    await expect(page).toHaveURL(/register/);
  });
});
