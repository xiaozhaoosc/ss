import { test, expect } from '@playwright/test';

test.describe('Parent Center & Insights Depth Test', () => {
  test.beforeEach(async ({ page }) => {
    // 1. Login
    await page.goto('/');
    
    // Handle potential alerts (login expired or 500 error)
    const okButton = page.getByText(/纭畾|鐭ラ亾浜?);
    if (await okButton.isVisible()) {
      await okButton.click();
    }

    await page.locator('input').nth(0).fill('ken2zhao');
    await page.locator('input').nth(1).fill('Aa123456');
    await page.getByText('鐧?褰?).click();
    
    // Wait for login to complete and reach home page
    await expect(page).toHaveURL(/.*pages\/parent\/dashboard\/index/);
  });

  test('Navigate and verify Parent Center (Profile)', async ({ page }) => {
    // Click "鎴戠殑" tab
    await page.locator('uni-tabbar').getByText('鎴戠殑').click({ force: true });
    await expect(page).toHaveURL(/.*pages\/parent\/profile\/index/);

    // 1. Verify Child Profiles
    await expect(page.getByText('瀛╁瓙妗ｆ')).toBeVisible();

    // 2. Click Add Child
    await page.getByText('娣诲姞').click({ force: true });
    await expect(page).toHaveURL(/.*pages\/parent\/family\/bind/);
    await page.goBack();

    // 3. Click Edit Child Profile
    const editIcon = page.getByText('edit').first();
    if (await editIcon.isVisible()) {
      await editIcon.click({ force: true });
      await expect(page).toHaveURL(/.*pages\/parent\/family\/edit/);
      
      // Verify edit fields
      await expect(page.getByText('鏄电О')).toBeVisible();
      await expect(page.getByText('瀛╁瓙鐘跺喌/澶囨敞')).toBeVisible();
      await page.goBack();
    }

    // 4. Verify General Settings
    await expect(page.getByText('閫氱煡璁剧疆')).toBeVisible();
    await expect(page.getByText('闅愮鏀跨瓥')).toBeVisible();
    await expect(page.getByText('閫€鍑虹櫥褰?)).toBeVisible();
  });

  test('Navigate and verify Insights Menu', async ({ page }) => {
    // Click "娲炲療" tab
    await page.locator('uni-tabbar').getByText('娲炲療').click({ force: true });
    await expect(page).toHaveURL(/.*pages\/parent\/insights\/index/);

    // 1. Verify Weekly Focus
    await expect(page.getByText('姣忓懆閲嶇偣')).toBeVisible();
    await expect(page.getByText(/.*涓撴敞鍔?)).toBeVisible();
    
    // Click Details link
    await page.getByText('璇︽儏').first().click({ force: true });
    await expect(page).toHaveURL(/.*pages\/parent\/weekly-report\/index/);
    await page.goBack();

    // 2. Verify Monthly Emotion Heatmap
    await expect(page.getByText('鏈堝害鎯呯华鐑姏鍥?)).toBeVisible();
    
    // Check for color legend
    await expect(page.getByText('骞抽潤/寮€蹇?)).toBeVisible();
    await expect(page.getByText('涓€鑸?)).toBeVisible();
  });
});
