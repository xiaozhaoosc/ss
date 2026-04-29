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
    // 启用全量日志监听
    page.on('console', msg => console.log(`[BROWSER-CONSOLE] ${msg.text()}`));
    page.on('request', request => {
      if (request.url().includes('/ssapi/')) {
        console.log(`[BROWSER-API-REQ] ${request.method()} ${request.url()}`);
      }
    });
    page.on('response', response => {
      if (response.url().includes('/ssapi/')) {
        console.log(`[BROWSER-API-RES] ${response.status()} ${response.url()}`);
      }
    });

    console.log('Step 1: Parent Login (ken2zhao)');
    const loginPage = new LoginPage(page);
    test.setTimeout(120000); // 流程较长，设置 2 分钟超时

    // --- STEP 1: 家长登录并预置奖励模板 ---
    console.log('Step 1: Parent login...');
    await loginPage.goto();
    await loginPage.login(TEST_ACCOUNTS.parent1.username, TEST_ACCOUNTS.parent1.password);
    
    // 导航到奖励配置页
    console.log('Navigating to Reward Config...');
    await page.goto('/#/pages/parent/reward-config/index');
    await page.waitForSelector('.add-reward-btn');

    for (const reward of STABLE_REWARDS) {
      // 检查奖励是否已存在
      const exists = await page.getByText(reward.name).isVisible();
      if (exists) {
        console.log(`Reward "${reward.name}" already exists, skipping.`);
        continue;
      }

      console.log(`Adding reward: ${reward.name}`);
      await page.goto('/#/pages/parent/reward-creator/index');
      await page.waitForSelector('.save-btn', { timeout: 10000 });
      
      // 填写奖励信息
      // 填写奖励信息
      await page.locator('.input-field input').first().fill(reward.name);
      await page.locator('.input-field input').nth(1).fill(reward.points.toString());
      await page.waitForTimeout(500); // 确保 Vue 响应式更新
      
      // 选择图标 (可选，这里点击匹配的表情符号)
      await page.click(`text=${reward.icon}`);
      
      // 保存
      await page.click('.save-btn');
      
      // 等待返回并加载
      try {
        await page.waitForURL('**/pages/parent/reward-config/index**', { timeout: 8000 });
      } catch (e) {
        console.log('Navigation after save timed out, forcing goto config page...');
        await page.goto('/#/pages/parent/reward-config/index');
      }
      await page.waitForSelector('.add-reward-btn');
      await page.waitForTimeout(1000); // Wait for list to refresh
    }

    // --- STEP 2: 家长发布加星任务 ---
    console.log('Step 2: Creating star booster task...');
    await page.goto('/#/pages/parent/task-creator/index');
    await page.waitForSelector('.task-textarea');
    
    await page.fill('.task-textarea textarea', STAR_BOOSTER_TASK.name);
    await page.click('.submit-btn');
    // 根据导航历史，可能返回到 reward-config 或 dashboard
    await page.waitForURL(/.*pages\/parent\/(dashboard|reward-config)\/index.*/, { timeout: 10000 });
    console.log('Task booster published.');

    // --- STEP 3: 儿童登录并完成任务 ---
    console.log('Step 3: Child login and complete task...');
    await page.goto('/#/pages/login/index');
    await loginPage.login(TEST_ACCOUNTS.child1.username, TEST_ACCOUNTS.child1.password);
    
    await expect(page).toHaveURL(/.*pages\/child\/home\/index.*/, { timeout: 15000 });
    await page.waitForTimeout(2000); // 等待异步数据加载

    // 找到刚才发布的任务
    console.log(`Searching for task: ${STAR_BOOSTER_TASK.name}`);
    
    let missionCard = page.locator('.mission-card').filter({ hasText: STAR_BOOSTER_TASK.name });
    
    // 增加重试刷新逻辑，应对后端同步延迟
    if (!(await missionCard.isVisible())) {
      console.log('Task not visible initially, reloading page...');
      await page.reload();
      await page.waitForTimeout(3000);
      missionCard = page.locator('.mission-card').filter({ hasText: STAR_BOOSTER_TASK.name });
    }

    if (await missionCard.isVisible()) {
      await missionCard.click(); // 进入执行页
      console.log('Navigating to task execution page...');
      await page.waitForURL('**/pages/child/task-execute/index**', { timeout: 15000 });
      
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
    await page.goto('/#/pages/login/index');
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
    await page.goto('/#/pages/login/index');
    await loginPage.login(TEST_ACCOUNTS.child1.username, TEST_ACCOUNTS.child1.password);
    
    const balance = await page.locator('.streak-val').textContent();
    console.log(`Final balance status: ${balance}`);
  });

});
