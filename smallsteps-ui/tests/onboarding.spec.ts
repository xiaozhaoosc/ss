import { test, expect } from '@playwright/test';

test('Onboarding overlay should appear on first visit', async ({ page }) => {
  // Clear localStorage to simulate first visit
  await page.addInitScript(() => {
    window.localStorage.removeItem('ss_onboarding_completed');
  });

  await page.goto('http://localhost:5173/bi/'); // Assuming the dev server is running here

  // Check if onboarding overlay is visible
  const overlay = page.locator('.onboarding-overlay');
  await expect(overlay).toBeVisible();

  // Check for Xiao Bu robot avatar
  const robot = page.locator('.robot-avatar');
  await expect(robot).toBeVisible();

  // Click skip and check if it disappears
  await page.getByText('跳过').click();
  await expect(overlay).not.toBeVisible();
});
