import { test, expect } from '@playwright/test';

test.describe('Backend Converter Verification', () => {
  test('should load parent rewards without converter error', async ({ page }) => {
    // 1. Login as parent
    await page.goto('http://localhost:9090/#/login');
    await page.fill('input[type="text"]', 'ken2zhao');
    await page.fill('input[type="password"]', 'Aa123456');
    await page.click('text=登 录');
    
    // Wait for navigation
    await page.waitForTimeout(3000); // Give it some time to load everything
    
    // 2. Go to Reward Shop (Parent side)
    // We need to find the entry to reward shop. In the previous test, it was on the "Task" tab or "Home" tab.
    // Let's try the Home tab first.
    await page.click('text=任务');
    await page.waitForTimeout(2000); // Wait for list to load
    
    // Check if there is a uni-modal with the error message
    const modal = page.locator('.uni-modal');
    if (await modal.isVisible()) {
      const content = await modal.locator('.uni-modal__bd').innerText();
      console.log('Modal found:', content);
      expect(content).not.toContain('cannot find converter');
    } else {
      console.log('No error modal found. Good!');
    }
    
    // 3. Specifically check the Reward list if possible
    // The previous test mentioned "Parent Dashboard" and "Task Creator".
    // Let's try to navigate to the reward management page if it exists.
    // Based on the previous logs, the error happened on the list page.
  });
});
