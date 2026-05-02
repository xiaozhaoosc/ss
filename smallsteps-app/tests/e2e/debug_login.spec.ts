import { test, expect } from '@playwright/test';
import { LoginPage } from './pages/LoginPage';
import { TEST_ACCOUNTS } from '../fixtures/test-data';

test('Debug Login', async ({ page }) => {
  const loginPage = new LoginPage(page);
  await loginPage.goto();
  console.log('Page loaded');
  
  await page.screenshot({ path: 'debug_login_start.png' });
  
  await page.locator('input[type="text"]').first().fill(TEST_ACCOUNTS.parent1.username);
  await page.locator('input[type="password"]').first().fill(TEST_ACCOUNTS.parent1.password);
  
  await page.screenshot({ path: 'debug_login_filled.png' });
  
  await page.locator('.login-btn').click();
  console.log('Login button clicked');
  
  try {
    await page.waitForURL(/.*pages\/parent\/dashboard\/index/, { timeout: 15000 });
    console.log('Successfully navigated to dashboard');
  } catch (e) {
    console.log('Navigation failed, taking screenshot');
    await page.screenshot({ path: 'debug_login_failed.png' });
    throw e;
  }
});
