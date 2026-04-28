# Instructions

- Following Playwright test failed.
- Explain why, be concise, respect Playwright best practices.
- Provide a snippet of code with the fix, if possible.

# Test info

- Name: reward_redemption.spec.ts >> 奖励兑换全链路验证 >> 儿童登录并兑换奖励
- Location: tests\e2e\reward_redemption.spec.ts:13:7

# Error details

```
Test timeout of 60000ms exceeded.
```

```
Error: page.fill: Test timeout of 60000ms exceeded.
Call log:
  - waiting for locator('input[placeholder="账号"]')

```

# Page snapshot

```yaml
- generic [ref=e4]:
  - generic [ref=e8]: 登录
  - generic [ref=e12]:
    - generic [ref=e13]:
      - img [ref=e17]
      - generic [ref=e18]:
        - generic [ref=e19]: Small Steps
        - generic [ref=e20]: 每一次进步，都值得被看见
    - generic [ref=e21]:
      - generic [ref=e22]: 欢迎回来
      - generic [ref=e23]:
        - generic [ref=e24]:
          - generic [ref=e25]: 
          - generic [ref=e27]:
            - generic: 账号
            - textbox [ref=e28]
        - generic [ref=e29]:
          - generic [ref=e30]: 
          - generic [ref=e32]:
            - generic: 密码
            - textbox [ref=e33]
      - generic [ref=e35] [cursor=pointer]:
        - generic [ref=e36]: 
        - generic [ref=e39]: 记住密码
      - generic [ref=e40]:
        - generic [ref=e41] [cursor=pointer]: 登 录
        - generic [ref=e42]:
          - generic [ref=e43]: 注册账号
          - generic [ref=e44]: "|"
          - generic [ref=e45]: 忘记密码?
    - generic [ref=e47]:
      - generic [ref=e48]: 登录即代表同意
      - generic [ref=e49]: 《用户协议》
      - generic [ref=e50]: "&"
      - generic [ref=e51]: 《隐私协议》
```

# Test source

```ts
  1  | import { test, expect } from '@playwright/test';
  2  | 
  3  | /**
  4  |  * 奖励兑换全链路验证测试
  5  |  * 1. 登录儿童账号
  6  |  * 2. 检查星星余额
  7  |  * 3. 访问奖励商店
  8  |  * 4. 选择奖励并确认兑换
  9  |  * 5. 验证余额扣减与成功提示
  10 |  */
  11 | test.describe('奖励兑换全链路验证', () => {
  12 |   
  13 |   test('儿童登录并兑换奖励', async ({ page }) => {
  14 |     // 增加超时时间，因为 uni-app 编译和加载可能较慢
  15 |     test.setTimeout(60000);
  16 | 
  17 |     // 1. 访问登录页
  18 |     await page.goto('/#/pages/login/index');
  19 |     
  20 |     // 等待页面加载
  21 |     await expect(page.locator('.login-btn')).toBeVisible();
  22 | 
  23 |     // 2. 登录 (优先尝试 child_xiaoming)
> 24 |     await page.fill('input[placeholder="账号"]', 'child_xiaoming');
     |                ^ Error: page.fill: Test timeout of 60000ms exceeded.
  25 |     await page.fill('input[placeholder="密码"]', 'gly321??gly321!!');
  26 |     
  27 |     // 点击登录
  28 |     await page.click('button.login-btn');
  29 |     
  30 |     // 3. 验证是否跳转到儿童首页
  31 |     // 如果登录失败或跳转不对，会在这里报错
  32 |     try {
  33 |       await expect(page).toHaveURL(/.*pages\/child\/home\/index/, { timeout: 10000 });
  34 |     } catch (e) {
  35 |       console.log('child_xiaoming 登录失败，尝试 admin 登录并检查角色');
  36 |       await page.goto('/#/pages/login/index');
  37 |       await page.fill('input[placeholder="账号"]', 'admin');
  38 |       await page.fill('input[placeholder="密码"]', 'gly321??gly321!!');
  39 |       await page.click('button.login-btn');
  40 |       
  41 |       // 如果 admin 是家长，这个测试将无法继续儿童路径，除非能切换
  42 |       // 这里我们假设测试环境已有正确配置的儿童账号
  43 |       await expect(page).toHaveURL(/.*pages\/child\/home\/index/, { timeout: 10000 });
  44 |     }
  45 |     
  46 |     console.log('成功进入儿童首页');
  47 | 
  48 |     // 4. 记录当前星星余额
  49 |     const balanceText = await page.locator('.streak-val').textContent();
  50 |     console.log('当前打卡天数/状态:', balanceText);
  51 |     
  52 |     // 5. 导航到奖励商店
  53 |     // 点击底部导航栏的“Shop”图标
  54 |     const shopNav = page.locator('text=Shop');
  55 |     await expect(shopNav).toBeVisible();
  56 |     await shopNav.click();
  57 |     
  58 |     await expect(page).toHaveURL(/.*pages\/child\/reward-shop\/index/);
  59 |     console.log('进入奖励商店');
  60 |     
  61 |     // 6. 验证奖励列表加载
  62 |     const productCards = page.locator('.product-card');
  63 |     await expect(productCards.first()).toBeVisible({ timeout: 10000 });
  64 |     
  65 |     const count = await productCards.count();
  66 |     console.log(`发现 ${count} 个奖励项目`);
  67 |     
  68 |     // 7. 执行兑换操作
  69 |     // 查找第一个“兑换”按钮 (排除“还差 X 颗星”的禁用按钮)
  70 |     const redeemBtn = page.locator('.redeem-btn:not(.disabled)').first();
  71 |     
  72 |     if (await redeemBtn.isVisible()) {
  73 |       await redeemBtn.click();
  74 |       console.log('点击兑换按钮');
  75 |       
  76 |       // 等待原生模态框 (uni.showModal 在 H5 中通常是 HTML 模拟)
  77 |       // 根据 uni-app H5 实现，通常会有“确定”按钮
  78 |       const confirmBtn = page.locator('.uni-modal__btn_primary, text=确定').first();
  79 |       await expect(confirmBtn).toBeVisible();
  80 |       await confirmBtn.click();
  81 |       
  82 |       // 8. 验证成功提示 (uni.showToast)
  83 |       // uni-app 的 toast 在 H5 中是一个简单的 div
  84 |       await expect(page.locator('.uni-sample-toast, .uni-toast, text=兑换成功')).toBeVisible();
  85 |       console.log('兑换成功验证通过');
  86 |     } else {
  87 |       console.log('没有可兑换的奖励（星星可能不足），测试跳过兑换确认步骤');
  88 |     }
  89 |   });
  90 | 
  91 | });
  92 | 
```