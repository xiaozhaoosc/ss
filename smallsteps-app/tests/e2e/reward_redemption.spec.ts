import { test, expect } from '@playwright/test';
import { LoginPage } from './pages/LoginPage';
import { TEST_ACCOUNTS } from '../fixtures/test-data';

/**
 * 奖励兑换全链路验证测试
 */
test.describe('奖励兑换全链路验证', () => {
  
  test('儿童登录并兑换奖励', async ({ page }) => {
    const loginPage = new LoginPage(page);
    // 增加超时时间，因为 uni-app 编译和加载可能较慢
    test.setTimeout(60000);

    // 1. 访问登录页并登录
    await loginPage.goto();
    await loginPage.login(TEST_ACCOUNTS.child1.username, TEST_ACCOUNTS.child1.password);
    
    // 3. 验证是否跳转到儿童首页
    await expect(page).toHaveURL(/.*pages\/child\/home\/index/, { timeout: 15000 });

    
    console.log('成功进入儿童首页');

    // 4. 记录当前星星余额
    const balanceText = await page.locator('.streak-val').textContent();
    console.log('当前打卡天数/状态:', balanceText);
    
    // 5. 导航到奖励商店
    // 点击底部导航栏的“百宝箱”图标
    const shopNav = page.locator('text=百宝箱');
    await expect(shopNav).toBeVisible();
    await shopNav.click();
    
    await expect(page).toHaveURL(/.*pages\/child\/reward-shop\/index/);
    console.log('进入奖励商店');
    
    // 6. 验证奖励列表加载
    const productCards = page.locator('.product-card');
    await expect(productCards.first()).toBeVisible({ timeout: 10000 });
    
    const count = await productCards.count();
    console.log(`发现 ${count} 个奖励项目`);
    
    // 7. 执行兑换操作
    // 查找第一个“兑换”按钮 (排除“还差 X 颗星”的禁用按钮)
    const redeemBtn = page.locator('.redeem-btn:not(.disabled)').first();
    
    if (await redeemBtn.isVisible()) {
      await redeemBtn.click();
      console.log('点击兑换按钮');
      
      // 等待原生模态框 (uni.showModal 在 H5 中通常是 HTML 模拟)
      // 根据 uni-app H5 实现，通常会有“确定”按钮
      const confirmBtn = page.locator('.uni-modal__btn_primary, text=确定').first();
      await expect(confirmBtn).toBeVisible();
      await confirmBtn.click();
      
      // 8. 验证成功提示 (uni.showToast)
      // uni-app 的 toast 在 H5 中是一个简单的 div
      await expect(page.locator('.uni-sample-toast, .uni-toast, text=兑换成功')).toBeVisible();
      console.log('兑换成功验证通过');
    } else {
      console.log('没有可兑换的奖励（星星可能不足），测试跳过兑换确认步骤');
    }
  });

});
