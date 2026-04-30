import { test, expect } from '@playwright/test';
import { ChildHomePage } from '../pages/ChildHomePage';

test.describe('Game Energy Logic Hardening', () => {
  test.use({ storageState: 'playwright/.auth/child.json' });

  test('Energy should decrease during game time', async ({ page }) => {
    const homePage = new ChildHomePage(page);
    await homePage.goto();
    
    // 1. Navigate to Game Time (assuming it's a tab or button)
    // Looking at ChildHomePage.ts, it doesn't have a direct method. 
    // We'll navigate by URL or find the button.
    await page.goto('/#/pages/child/game-time/index');

    // 2. Check initial energy (should be high)
    const energyBar = page.locator('.inner-circle');
    await expect(energyBar).toBeVisible();
    
    // Get initial height (percent)
    const getEnergy = async () => {
      const style = await energyBar.getAttribute('style');
      const match = style?.match(/height:\s*([\d.]+)%/);
      return match ? parseFloat(match[1]) : 0;
    };

    const initialEnergy = await getEnergy();
    console.log('Initial Energy:', initialEnergy);

    // 3. Start game
    const startBtn = page.locator('text=点击小步开始挑战！');
    await startBtn.waitFor({ state: 'visible' });
    await startBtn.click({ force: true });
    
    // 4. Wait for energy to decrease
    await page.waitForTimeout(6000); 
    
    const laterEnergy = await getEnergy();
    console.log('Later Energy:', laterEnergy);

    expect(laterEnergy).toBeLessThan(initialEnergy);
  });
});
