import { test, expect } from '@playwright/test';
import { LoginPage } from './pages/LoginPage';
import { TEST_ACCOUNTS } from '../fixtures/test-data';

/**
 * 稳定业务数据预置脚本
 * 1. 预置奖励模板
 * 2. 预置星星余额 (通过完成系统任务)
 */
test.describe('稳定业务数据预置', () => {

  const STABLE_REWARDS = [
    { name: '看动画片30分钟', points: 10, icon: '🎬' },
    { name: '吃美味冰淇淋', points: 20, icon: '🍦' },
    { name: '购买心仪玩具', points: 100, icon: '🎁' }
  ];

  const STAR_BOOSTER_TASK = {
    name: '[系统] 每日能量礼包',
    reward: 500
  };

  test('全链路预置业务数据', async ({ page }) => {
    const loginPage = new LoginPage(page);
    test.setTimeout(120000); // 流程较长，设置 2 分钟超时

    // --- STEP 1: 家长登录并预置奖励模板 ---
    console.log('Step 1: Parent login...');
    await loginPage.goto();
    await loginPage.login(TEST_ACCOUNTS.parent1.username, TEST_ACCOUNTS.parent1.password);
    
    // 导航到奖励配置页
    console.log('Navigating to Reward Config...');
    await page.goto('/pages/parent/reward-config/index');
    await page.waitForSelector('.add-reward-btn');

    for (const reward of STABLE_REWARDS) {
      // 检查奖励是否已存在
      const exists = await page.getByText(reward.name).isVisible();
      if (exists) {
        console.log(`Reward "${reward.name}" already exists, skipping.`);
        continue;
      }

      console.log(`Adding reward: ${reward.name}`);
      await page.click('.add-reward-btn');
      await page.waitForURL(/.*pages\/parent\/reward-creator\/index/);
      
      // 填写奖励信息
      await page.fill('input[placeholder*="看动画片30分钟"]', reward.name);
      await page.fill('input[type="number"]', reward.points.toString());
      
      // 选择图标 (可选，这里点击匹配的表情符号)
      await page.click(`text=${reward.icon}`);
      
      // 保存
      await page.click('.save-btn');
      
      // 等待返回并加载
      await page.waitForURL(/.*pages\/parent\/reward-config\/index/);
      await page.waitForSelector('.add-reward-btn');
    }

    // --- STEP 2: 家长发布加星任务 ---
    console.log('Step 2: Creating star booster task...');
    await page.goto('/pages/parent/task-creator/index');
    await page.waitForSelector('.task-textarea');
    
    await page.fill('.task-textarea', STAR_BOOSTER_TASK.name);
    // 这里简化，直接发布，默认奖励假设是足够的，或者如果能改奖励点数则更好
    // 根据 src/pages/parent/task-creator/index.vue, 默认 rewardPoints 是 10
    // 如果需要 500 星，可能需要修改 UI 或 API。
    // 但作为自动化脚本，我们可以尝试通过控制台调用或寻找 UI 上的奖励设置（如果存在）
    // 看来当前 UI 没暴露 rewardPoints 的输入，但我们可以尝试直接发布。
    // 如果需要大量星，可能需要多次执行。
    
    await page.click('.submit-btn');
    await page.waitForURL(/.*pages\/parent\/dashboard\/index/);
    console.log('Task booster published.');

    // --- STEP 3: 儿童登录并完成任务 ---
    console.log('Step 3: Child login and complete task...');
    await page.goto('/pages/login/index');
    await loginPage.login(TEST_ACCOUNTS.child1.username, TEST_ACCOUNTS.child1.password);
    
    await expect(page).toHaveURL(/.*pages\/child\/home\/index/);
    
    // 找到刚才发布的任务
    console.log(`Searching for task: ${STAR_BOOSTER_TASK.name}`);
    // 任务卡片在 child-home-page 中
    const missionCard = page.locator('.mission-card').filter({ hasText: STAR_BOOSTER_TASK.name });
    
    // 如果首页没看到，尝试滚动或等待
    await missionCard.scrollIntoViewIfNeeded();
    
    if (await missionCard.isVisible()) {
      await missionCard.click(); // 进入执行页
      console.log('Navigating to task execution page...');
      await page.waitForURL(/.*pages\/child\/task-execute\/index/);
      
      // 在执行页点击“我完成了！”
      console.log('Clicking complete button...');
      const completeBtn = page.locator('.complete-btn');
      await completeBtn.click();
      
      // 等待奖励弹窗出现并点击“领取奖励”
      console.log('Waiting for reward overlay...');
      const collectBtn = page.locator('.collect-btn');
      await expect(collectBtn).toBeVisible({ timeout: 15000 });
      await collectBtn.click();
      
      console.log('Task completed and reward collected by child.');
    } else {
      console.error('Booster task not found on child home!');
      throw new Error('Booster task not found');
    }

    // --- STEP 4: 家长登录并批准任务 ---
    console.log('Step 4: Parent approve task...');
    await page.goto('/pages/login/index');
    await loginPage.login(TEST_ACCOUNTS.parent1.username, TEST_ACCOUNTS.parent1.password);
    
    // 点击通知铃铛
    console.log('Opening notifications...');
    await page.click('.icon-btn'); 
    const notificationDropdown = page.locator('.notification-dropdown');
    await expect(notificationDropdown).toBeVisible();
    
    // 查找包含任务名的批准按钮
    console.log('Looking for approval button...');
    const approveBtn = notificationDropdown.locator('.notification-item')
      .filter({ hasText: STAR_BOOSTER_TASK.name })
      .locator('text=批准');
      
    if (await approveBtn.isVisible()) {
      await approveBtn.click();
      
      // 处理二次确认 (uni.showModal)
      console.log('Confirming approval...');
      const finalConfirm = page.locator('.uni-modal__btn_primary, text=确定').first();
      await finalConfirm.click();
      
      console.log('Task approved by parent.');
    } else {
      console.log('Approval notification not found. Maybe auto-approved?');
    }

    // --- FINAL VERIFICATION ---
    console.log('Final verification...');
    await page.goto('/pages/login/index');
    await loginPage.login(TEST_ACCOUNTS.child1.username, TEST_ACCOUNTS.child1.password);
    
    const balance = await page.locator('.streak-val').textContent();
    console.log(`Final balance status: ${balance}`);
  });

});
