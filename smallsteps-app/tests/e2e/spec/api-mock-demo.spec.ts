import { test, expect } from '@playwright/test';
import { LoginPage } from '../pages/LoginPage';
import { ChildHomePage } from '../pages/ChildHomePage';
import { TEST_ACCOUNTS } from '../../fixtures/test-data';

test.describe('API Mocking & Edge Cases', () => {
  let loginPage: LoginPage;
  let homePage: ChildHomePage;

  test.beforeEach(async ({ page }) => {
    loginPage = new LoginPage(page);
    homePage = new ChildHomePage(page);
    // 使用 storageState 自动登录，直接跳转到儿童首页
    await page.goto('/#/pages/child/home/index');
    await page.waitForLoadState('networkidle');
  });

  test('Mock empty task list', async ({ page }) => {
    // Intercept task list API and return empty array
    await page.route('**/ssapi/child/task/list**', async route => {
      await route.fulfill({
        status: 200,
        contentType: 'application/json',
        body: JSON.stringify({
          code: 200,
          msg: 'Success',
          data: []
        })
      });
    });

    await homePage.goto();
    await expect(page.locator('text=全部任务完成')).toBeVisible();
  });

  test('Mock backend 500 error', async ({ page }) => {
    // Intercept and return 500
    await page.route('**/ssapi/child/task/list**', async route => {
      await route.fulfill({
        status: 500,
        contentType: 'application/json',
        body: JSON.stringify({
          code: 500,
          msg: 'Internal Server Error'
        })
      });
    });

    await homePage.goto();
    // Verify error toast or handling
    await expect(page.locator('.uni-toast-message, text=服务器异常')).toBeVisible();
  });
});
