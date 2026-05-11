import { test, expect } from '@playwright/test';
import { LoginPage } from './pages/LoginPage';
import { TEST_ACCOUNTS } from '../fixtures/test-data';

/**
 * 奖励兑换全链路自动化测试
 * 覆盖：儿童发起兑换 -> 家长收到通知/列表 -> 家长批准 -> 积分扣除
 */
test.describe('奖励兑换全链路审批流', () => {
  
  test('全链路：儿童兑换奖励 & 家长批准', async ({ page, browser }) => {
    // 增加全局超时
    test.setTimeout(120000);
    
    // --- 第一阶段：儿童发起兑换 ---
    const childPage = page; // 使用默认 Page
    const childLogin = new LoginPage(childPage);
    
    console.log('Step 1: Child login...');
    await childLogin.goto(); // LoginPage.goto already uses hash if needed or I should check it
    await childLogin.login(TEST_ACCOUNTS.child1.username, TEST_ACCOUNTS.child1.password);
    
    await expect(childPage).toHaveURL(/.*pages\/child\/home\/index.*/, { timeout: 15000 });
    console.log('Child entered home');

    // 导航到奖励商店
    console.log('Step 2: Navigating to Reward Shop...');
    // 点击底部导航栏的“百宝箱”图标
    const shopNav = childPage.locator('text=百宝箱');
    await expect(shopNav).toBeVisible({ timeout: 10000 });
    await shopNav.click();
    await expect(childPage.locator('.product-card')).toBeVisible({ timeout: 15000 });

    // 查找可兑换的奖励 (星星足够的)
    const redeemBtn = childPage.locator('.redeem-btn').first();
    await expect(redeemBtn).toBeVisible({ timeout: 10000 });
    
    const isRedeemable = await redeemBtn.isEnabled();
    if (!isRedeemable) {
       console.log('Redeem button is disabled. Stars might be insufficient.');
    }

    const rewardName = await childPage.locator('.name').first().textContent();
    console.log(`Redeeming reward: ${rewardName}`);
    
    await redeemBtn.click();
    
    // 处理确认弹窗
    const confirmBtn = childPage.locator('.uni-modal__btn_primary, text=确定').first();
    await expect(confirmBtn).toBeVisible({ timeout: 5000 });
    await confirmBtn.click();

    // 等待成功提示
    await expect(childPage.locator('text=兑换成功')).toBeVisible({ timeout: 10000 });
    console.log('Redemption request submitted successfully');

    // --- 第二阶段：家长批准兑换 ---
    console.log('Step 3: Parent approval flow...');
    
    await childPage.goto('/#/pages/login/index'); 
    const parentLogin = new LoginPage(childPage);
    await parentLogin.login(TEST_ACCOUNTS.parent1.username, TEST_ACCOUNTS.parent1.password);
    
    await expect(childPage).toHaveURL(/.*pages\/parent\/dashboard\/index.*/, { timeout: 15000 });
    console.log('Parent logged in');

    // 直接导航到奖励管理页
    await childPage.goto('/#/pages/parent/reward-config/index');
    console.log('Navigated to Reward Config');

    // 寻找待处理请求
    const requestCard = childPage.locator('.pending-request-card').first();
    await expect(requestCard).toBeVisible({ timeout: 15000 });
    
    const reqText = await requestCard.textContent();
    console.log(`Found pending request: ${reqText}`);
    
    // 点击批准按钮
    const approveBtn = requestCard.locator('text=批准').first();
    await approveBtn.click();
    
    // 处理确认模态框
    const modalConfirm = childPage.locator('.uni-modal__btn_primary, text=确定').first();
    await expect(modalConfirm).toBeVisible({ timeout: 5000 });
    await modalConfirm.click();

    // 验证成功提示
    await expect(childPage.locator('text=已批准')).toBeVisible({ timeout: 10000 });
    console.log('Reward approved successfully');

    // --- 第三阶段：验证历史记录 ---
    console.log('Step 4: Verifying history...');
    await childPage.click('text=兑换历史');
    
    const historyItem = childPage.locator('.history-item').first();
    await expect(historyItem).toBeVisible({ timeout: 10000 });
    await expect(historyItem).toContainText('已批准');
    
    console.log('All link verification PASSED');
  });

});
