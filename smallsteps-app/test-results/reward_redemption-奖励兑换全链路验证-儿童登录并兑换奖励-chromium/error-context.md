# Instructions

- Following Playwright test failed.
- Explain why, be concise, respect Playwright best practices.
- Provide a snippet of code with the fix, if possible.

# Test info

- Name: reward_redemption.spec.ts >> 奖励兑换全链路验证 >> 儿童登录并兑换奖励
- Location: tests\e2e\reward_redemption.spec.ts:10:7

# Error details

```
Error: expect(locator).toBeVisible() failed

Locator: locator('.product-card').first()
Expected: visible
Timeout: 10000ms
Error: element(s) not found

Call log:
  - Expect "toBeVisible" with timeout 10000ms
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
  2  | import { LoginPage } from './pages/LoginPage';
  3  | import { TEST_ACCOUNTS } from '../fixtures/test-data';
  4  | 
  5  | /**
  6  |  * 奖励兑换全链路验证测试
  7  |  */
  8  | test.describe('奖励兑换全链路验证', () => {
  9  |   
  10 |   test('儿童登录并兑换奖励', async ({ page }) => {
  11 |     const loginPage = new LoginPage(page);
  12 |     // 增加超时时间，因为 uni-app 编译和加载可能较慢
  13 |     test.setTimeout(60000);
  14 | 
  15 |     // 1. 访问登录页并登录
  16 |     await loginPage.goto();
  17 |     await loginPage.login(TEST_ACCOUNTS.child1.username, TEST_ACCOUNTS.child1.password);
  18 |     
  19 |     // 3. 验证是否跳转到儿童首页
  20 |     await expect(page).toHaveURL(/.*pages\/child\/home\/index/, { timeout: 15000 });
  21 | 
  22 |     
  23 |     console.log('成功进入儿童首页');
  24 | 
  25 |     // 4. 记录当前星星余额
  26 |     const balanceText = await page.locator('.streak-val').textContent();
  27 |     console.log('当前打卡天数/状态:', balanceText);
  28 |     
  29 |     // 5. 导航到奖励商店
  30 |     // 点击底部导航栏的“Shop”图标
  31 |     const shopNav = page.locator('text=Shop');
  32 |     await expect(shopNav).toBeVisible();
  33 |     await shopNav.click();
  34 |     
  35 |     await expect(page).toHaveURL(/.*pages\/child\/reward-shop\/index/);
  36 |     console.log('进入奖励商店');
  37 |     
  38 |     // 6. 验证奖励列表加载
  39 |     const productCards = page.locator('.product-card');
> 40 |     await expect(productCards.first()).toBeVisible({ timeout: 10000 });
     |                                        ^ Error: expect(locator).toBeVisible() failed
  41 |     
  42 |     const count = await productCards.count();
  43 |     console.log(`发现 ${count} 个奖励项目`);
  44 |     
  45 |     // 7. 执行兑换操作
  46 |     // 查找第一个“兑换”按钮 (排除“还差 X 颗星”的禁用按钮)
  47 |     const redeemBtn = page.locator('.redeem-btn:not(.disabled)').first();
  48 |     
  49 |     if (await redeemBtn.isVisible()) {
  50 |       await redeemBtn.click();
  51 |       console.log('点击兑换按钮');
  52 |       
  53 |       // 等待原生模态框 (uni.showModal 在 H5 中通常是 HTML 模拟)
  54 |       // 根据 uni-app H5 实现，通常会有“确定”按钮
  55 |       const confirmBtn = page.locator('.uni-modal__btn_primary, text=确定').first();
  56 |       await expect(confirmBtn).toBeVisible();
  57 |       await confirmBtn.click();
  58 |       
  59 |       // 8. 验证成功提示 (uni.showToast)
  60 |       // uni-app 的 toast 在 H5 中是一个简单的 div
  61 |       await expect(page.locator('.uni-sample-toast, .uni-toast, text=兑换成功')).toBeVisible();
  62 |       console.log('兑换成功验证通过');
  63 |     } else {
  64 |       console.log('没有可兑换的奖励（星星可能不足），测试跳过兑换确认步骤');
  65 |     }
  66 |   });
  67 | 
  68 | });
  69 | 
```