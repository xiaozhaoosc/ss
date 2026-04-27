import { test, expect } from '@playwright/test';

test.describe('Parent Center & Insights Depth Test', () => {
  test.beforeEach(async ({ page }) => {
    await page.goto('http://localhost:88/');
    const okButton = page.getByText(/\u7e4f\u767f|\u7f5e\u905d\u4E8bx/);
    if (await okButton.isVisible()) await okButton.click();
    await page.locator('input').nth(0).fill('ken2zhao');
    await page.locator('input').nth(1).fill('Aa123456');
    const loginButton = page.locator('.el-button').first();
    await loginButton.click();
    await expect(page).toHaveURL(/.*pages\/parent\/dashboard\/index/);
  });

  test('Navigate and verify Parent Center', async ({ page }) => {
    await page.locator(�v'��V��F&&"r��vWD'�FW�B���Sf#Fe�SscFe�SFV6��6Ɩ6���f�&6S�G'VWғ��v�BW�V7B�vR��F�fUU$��vW5��&V�E��&�f��U����FW�򓰢ғ���FW7B�t�f�vFR�BfW&�g���6�v�G2r�7��2��vRҒ����v�BvR���6F�"�wV��F&&"r��vWD'�FW�B���Sf#Fe�Ss#Fe�SFV6��6Ɩ6���f�&6S�G'VRғ��v�BW�V7B�vR��F�fUU$��vW5��&V�E����6�v�G5����FW�򓰢ғ��ғ