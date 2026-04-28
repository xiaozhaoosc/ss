# Instructions

- Following Playwright test failed.
- Explain why, be concise, respect Playwright best practices.
- Provide a snippet of code with the fix, if possible.

# Test info

- Name: e2e\reward_redemption.spec.ts >> Reward Redemption E2E >> Child can redeem a reward successfully
- Location: e2e\reward_redemption.spec.ts:8:7

# Error details

```
Error: expect(locator).toBeVisible() failed

Locator: locator('.product-card').first()
Expected: visible
Timeout: 5000ms
Error: element(s) not found

Call log:
  - Expect "toBeVisible" with timeout 5000ms
  - waiting for locator('.product-card').first()

```

# Page snapshot

```yaml
- generic [ref=e7]:
  - generic [ref=e8]:
    - generic [ref=e9]:
      - generic [ref=e11] [cursor=pointer]: arrow_back_ios_new
      - img [ref=e15]
    - generic [ref=e16]:
      - generic [ref=e17]:
        - generic [ref=e18]: 奖励商店
        - generic [ref=e19]: 用星星兑换超棒的礼物！
      - generic [ref=e20]:
        - generic [ref=e22]: star
        - generic [ref=e23]:
          - generic [ref=e24]: 我的星星
          - generic [ref=e25]: "0"
        - generic [ref=e26]: auto_awesome
  - generic [ref=e37]:
    - generic [ref=e38]:
      - generic [ref=e40]: storefront
      - generic [ref=e41]: Shop
    - generic [ref=e42]:
      - generic [ref=e44]: emoji_events
      - generic [ref=e45]: Home
    - generic [ref=e46]:
      - generic [ref=e48]: history
      - generic [ref=e49]: Time
```

# Test source

```ts
  1  | import { test, expect } from '@playwright/test';
  2  | 
  3  | const ACCOUNTS = {
  4  |   child: { user: 'child_xiaoming', pass: 'admin123' },
  5  | };
  6  | 
  7  | test.describe('Reward Redemption E2E', () => {
  8  |   test('Child can redeem a reward successfully', async ({ page }) => {
  9  |     // 1. Go to Login
  10 |     await page.goto('http://localhost:9090/#/pages/login/index');
  11 |     
  12 |     // 2. Perform Login
  13 |     await page.fill('input[type="text"]', ACCOUNTS.child.user);
  14 |     await page.fill('input[type="password"]', ACCOUNTS.child.pass);
  15 |     await page.click('.login-btn');
  16 |     
  17 |     // 3. Wait for Home
  18 |     await expect(page).toHaveURL(/.*child\/home/);
  19 |     
  20 |     // 4. Navigate to Reward Shop (using direct URL for stability)
  21 |     await page.goto('http://localhost:9090/#/pages/child/reward-shop/index');
  22 |     await page.waitForTimeout(2000);
  23 |     
  24 |     // 5. Check if products are loaded
  25 |     const productCards = page.locator('.product-card');
> 26 |     await expect(productCards.first()).toBeVisible();
     |                                        ^ Error: expect(locator).toBeVisible() failed
  27 |     
  28 |     // 6. Find a redeemable product (the first one)
  29 |     const firstRedeemBtn = productCards.first().locator('.redeem-btn');
  30 |     const btnText = await firstRedeemBtn.innerText();
  31 |     
  32 |     if (btnText === '兑换') {
  33 |       // 7. Click Redeem
  34 |       await firstRedeemBtn.click();
  35 |       
  36 |       // 8. Handle Uni-app Modal (confirm)
  37 |       const modalConfirm = page.locator('.uni-modal__btn-confirm');
  38 |       await modalConfirm.click();
  39 |       
  40 |       // 9. Check for Toast (Success)
  41 |       // Uni-app toast is often a div with class 'uni-sample-toast' or similar
  42 |       // We can also check if the balance is updated (store logic)
  43 |       // But let's check for "兑换成功" text
  44 |       await expect(page.locator('text=兑换成功')).toBeVisible();
  45 |     } else {
  46 |       console.log('Skipping redemption: Points insufficient');
  47 |     }
  48 |   });
  49 | });
  50 | 
```