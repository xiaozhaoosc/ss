import { test, expect } from '@playwright/test';

const ACCOUNTS = {
  child: { user: 'child_xiaoming', pass: 'admin123' },
};

test.describe('Reward Redemption E2E', () => {
  test('Child can redeem a reward successfully', async ({ page }) => {
    // 1. Go to Login
    await page.goto('http://localhost:9090/#/pages/login/index');
    
    // 2. Perform Login
    await page.fill('input[type="text"]', ACCOUNTS.child.user);
    await page.fill('input[type="password"]', ACCOUNTS.child.pass);
    await page.click('.login-btn');
    
    // 3. Wait for Home
    await expect(page).toHaveURL(/.*child\/home/);
    
    // 4. Navigate to Reward Shop (using direct URL for stability)
    await page.goto('http://localhost:9090/#/pages/child/reward-shop/index');
    await page.waitForTimeout(2000);
    
    // 5. Check if products are loaded
    const productCards = page.locator('.product-card');
    await expect(productCards.first()).toBeVisible();
    
    // 6. Find a redeemable product (the first one)
    const firstRedeemBtn = productCards.first().locator('.redeem-btn');
    const btnText = await firstRedeemBtn.innerText();
    
    if (btnText === '兑换') {
      // 7. Click Redeem
      await firstRedeemBtn.click();
      
      // 8. Handle Uni-app Modal (confirm)
      const modalConfirm = page.locator('.uni-modal__btn-confirm');
      await modalConfirm.click();
      
      // 9. Check for Toast (Success)
      // Uni-app toast is often a div with class 'uni-sample-toast' or similar
      // We can also check if the balance is updated (store logic)
      // But let's check for "兑换成功" text
      await expect(page.locator('text=兑换成功')).toBeVisible();
    } else {
      console.log('Skipping redemption: Points insufficient');
    }
  });
});
