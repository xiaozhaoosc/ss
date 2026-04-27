import { test, expect } from '@playwright/test';

test.describe('Parent Center & Insights Depth Test', () => {
  test.beforeEach(async ({ page }) => {
    // 1. Login
    await page.goto('/');
    
    // Handle potential alerts (login expired or 500 error)
    const okButton = page.getByText(/确定|知道了/);
    if (await okButton.isVisible()) {
      await okButton.click();
    }

    await page.locator('input').nth(0).fill('ken2zhao');
    await page.locator('input').nth(1).fill('Aa123456');
    await page.getByText('登 录').click();
    
    // Wait for login to complete and reach home page
    await expect(page).toHaveURL(/.*pages\/parent\/dashboard\/index/);
  });

  test('Navigate and verify Parent Center (Profile)', async ({ page }) => {
    // Click "我的" tab
    await page.locator('uni-tabbar').getByText('我的').click({ force: true });
    await expect(page).toHaveURL(/.*pages\/parent\/profile\/index/);

    // 1. Verify Child Profiles
    await expect(page.getByText('孩子档案')).toBeVisible();

    // 2. Click Add Child
    await page.getByText('添加').click({ force: true });
    await expect(page).toHaveURL(/.*pages\/parent\/family\/bind/);
    await page.goBack();

    // 3. Click Edit Child Profile
    const editIcon = page.getByText('edit').first();
    if (await editIcon.isVisible()) {
      await editIcon.click({ force: true });
      await expect(page).toHaveURL(/.*pages\/parent\/family\/edit/);
      
      // Verify edit fields
      await expect(page.getByText('昵称')).toBeVisible();
      await expect(page.getByText('孩子状况/备注')).toBeVisible();
      await page.goBack();
    }

    // 4. Verify General Settings
    await expect(page.getByText('通知设置')).toBeVisible();
    await expect(page.getByText('隐私政策')).toBeVisible();
    await expect(page.getByText('退出登录')).toBeVisible();
  });

  test('Navigate and verify Insights Menu', async ({ page }) => {
    // Click "洞察" tab
    await page.locator('uni-tabbar').getByText('洞察').click({ force: true });
    await expect(page).toHaveURL(/.*pages\/parent\/insights\/index/);

    // 1. Verify Weekly Focus
    await expect(page.getByText('每周重点')).toBeVisible();
    await expect(page.getByText(/.*专注力/)).toBeVisible();
    
    // Click Details link
    await page.getByText('详情').first().click({ force: true });
    await expect(page).toHaveURL(/.*pages\/parent\/weekly-report\/index/);
    await page.goBack();

    // 2. Verify Monthly Emotion Heatmap
    await expect(page.getByText('月度情绪热力图')).toBeVisible();
    
    // Check for color legend
    await expect(page.getByText('平静/开心')).toBeVisible();
    await expect(page.getByText('一般')).toBeVisible();
  });
});
