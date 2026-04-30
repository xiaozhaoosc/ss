import { chromium, type FullConfig } from '@playwright/test';
import { LoginPage } from './pages/LoginPage';
import { TEST_ACCOUNTS } from '../fixtures/test-data';

/**
 * Global Setup for E2E Tests
 * Ensures stable business data: reward templates, star balances, etc.
 */
async function globalSetup(config: FullConfig) {
  const { baseURL, storageState } = config.projects[0].use;
  const browser = await chromium.launch();
  const page = await browser.newPage({ baseURL: baseURL as string });
  
  const loginPage = new LoginPage(page);

  const STABLE_REWARDS = [
    { name: '看动画片30分钟', points: 10, icon: '🎬' },
    { name: '吃美味冰淇淋', points: 20, icon: '🍦' },
    { name: '购买心仪玩具', points: 100, icon: '🎁' }
  ];

  const STAR_BOOSTER_TASK = {
    name: '[系统] 每日能量礼包',
    reward: 500
  };

  try {
    console.log('--- GLOBAL SETUP START ---');
    
    // 0. Ensure auth directory exists
    const fs = require('fs');
    const path = require('path');
    const authDir = path.join(process.cwd(), 'playwright', '.auth');
    if (!fs.existsSync(authDir)) {
      fs.mkdirSync(authDir, { recursive: true });
    }

    // 1. Parent Login & Save State
    console.log('Logging in as Parent and saving state...');
    await page.goto('/');
    await loginPage.login(TEST_ACCOUNTS.parent1.username, TEST_ACCOUNTS.parent1.password);
    await page.waitForURL(/.*dashboard/);
    await page.context().storageState({ path: path.join(authDir, 'parent.json') });

    // 2. Preset Reward Templates
    console.log('Presetting Reward Templates...');
    await page.goto('/#/pages/parent/reward-config/index');
    await page.waitForSelector('.add-reward-btn');

    for (const reward of STABLE_REWARDS) {
      const exists = await page.getByText(reward.name).isVisible();
      if (exists) {
        console.log(`Reward "${reward.name}" already exists, skipping.`);
        continue;
      }

      console.log(`Adding reward: ${reward.name}`);
      await page.goto('/#/pages/parent/reward-creator/index');
      await page.waitForSelector('.save-btn');
      
      await page.locator('.input-field input').first().fill(reward.name);
      await page.locator('.input-field input').nth(1).fill(reward.points.toString());
      await page.click(`text=${reward.icon}`);
      await page.click('.save-btn');
      
      await page.waitForURL('**/pages/parent/reward-config/index**', { timeout: 10000 }).catch(() => page.goto('/#/pages/parent/reward-config/index'));
      await page.waitForSelector('.add-reward-btn');
    }

    // 3. Create Star Booster Task
    console.log('Creating Star Booster Task...');
    await page.goto('/#/pages/parent/task-creator/index');
    await page.waitForSelector('.task-textarea');
    
    // Select first child if available
    const childItem = page.locator('.child-item').first();
    if (await childItem.isVisible()) {
      await childItem.click();
    }
    
    await page.fill('.task-textarea textarea', STAR_BOOSTER_TASK.name);
    await page.click('.submit-btn', { force: true });
    await page.waitForURL(/.*pages\/parent\/(dashboard|reward-config)\/index.*/, { timeout: 15000 });

    // 4. Child Login & Save State & Complete Task
    console.log('Logging in as Child and saving state...');
    await page.goto('/#/pages/login/index');
    await loginPage.login(TEST_ACCOUNTS.child1.username, TEST_ACCOUNTS.child1.password);
    await page.waitForURL(/.*pages\/child\/home\/index.*/);
    await page.context().storageState({ path: path.join(authDir, 'child.json') });
    
    console.log('Child Completing Task for Stars...');
    // Wait for task to sync (retry logic)
    let missionCard = page.locator('.mission-card').filter({ hasText: STAR_BOOSTER_TASK.name });
    for (let i = 0; i < 3; i++) {
        if (await missionCard.isVisible()) break;
        console.log(`Task not found, retry ${i+1}...`);
        await page.reload();
        await page.waitForTimeout(3000); // Increased wait
        missionCard = page.locator('.mission-card').filter({ hasText: STAR_BOOSTER_TASK.name });
    }

    if (await missionCard.isVisible()) {
      await missionCard.click();
      await page.waitForURL('**/pages/child/task-execute/index**');
      await page.click('.complete-btn', { force: true });
      const collectBtn = page.locator('.collect-btn');
      await collectBtn.waitFor({ state: 'visible' });
      await collectBtn.click({ force: true });
      console.log('Task completed.');
    }

    // 5. Parent Approve
    console.log('Parent Approving Task...');
    await page.goto('/#/pages/login/index');
    await loginPage.login(TEST_ACCOUNTS.parent1.username, TEST_ACCOUNTS.parent1.password);
    await page.click('.icon-btn', { force: true }); 
    await page.waitForSelector('.notification-dropdown');
    
    const approveBtn = page.locator('.notification-item')
      .filter({ hasText: STAR_BOOSTER_TASK.name })
      .locator('text=批准');
      
    if (await approveBtn.isVisible()) {
      await approveBtn.click({ force: true });
      await page.locator('.uni-modal__btn_primary, text=确定').first().click();
      await page.waitForTimeout(1000); // Wait for modal to clear
      console.log('Task approved.');
    }

    console.log('--- GLOBAL SETUP SUCCESS ---');
  } catch (error) {
    console.error('--- GLOBAL SETUP FAILED ---', error);
  } finally {
    await browser.close();
  }
}

export default globalSetup;
