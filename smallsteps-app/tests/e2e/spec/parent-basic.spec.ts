import { test, expect } from '@playwright/test';
import { LoginPage } from '../pages/LoginPage';
import { TEST_ACCOUNTS } from '../../fixtures/test-data';

test.describe('Parent Basic Tests', () => {
  test.use({ storageState: 'playwright/.auth/parent.json' });

  test('Login verification (Already logged in via storageState)', async ({ page }) => {
    await page.goto('/#/pages/parent/dashboard/index');
    await expect(page).toHaveURL(/dashboard/);
  });

  test('Login with parent2 (Explicit override)', async ({ page }) => {
    const loginPage = new LoginPage(page);
    await loginPage.goto();
    await loginPage.login(TEST_ACCOUNTS.parent2.username, TEST_ACCOUNTS.parent2.password);
    await expect(page).toHaveURL(/dashboard/);
  });

  test('Navigate to profile page', async ({ page }) => {
    await page.goto('/#/pages/parent/profile/index');
    await expect(page).toHaveURL(/profile/);
  });

  test('Navigate to insights page', async ({ page }) => {
    await page.goto('/#/pages/parent/insights/index');
    await expect(page).toHaveURL(/insights/);
  });

  test('Navigate to task creator page', async ({ page }) => {
    await page.goto('/#/pages/parent/task-creator/index');
    await expect(page).toHaveURL(/task-creator/);
  });

  test('Navigate to daily focus page', async ({ page }) => {
    await page.goto('/#/pages/parent/daily-focus/index');
    await expect(page).toHaveURL(/daily-focus/);
  });

  test('Navigate to exec record page', async ({ page }) => {
    await page.goto('/#/pages/parent/exec-record/index');
    await expect(page).toHaveURL(/exec-record/);
  });

  test('Navigate to weekly report page', async ({ page }) => {
    await page.goto('/#/pages/parent/weekly-report/index');
    await expect(page).toHaveURL(/weekly-report/);
  });
});
