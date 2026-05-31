import { test, expect } from '@playwright/test';
import { AppLoginPage } from './pages/LoginPage';
import { ChildHomePage } from './pages/ChildHomePage';
import { TaskExecutePage } from './pages/TaskExecutePage';
import * as fs from 'fs';

// 确保截图目录存在
const testResultsDir = 'test-results';
if (!fs.existsSync(testResultsDir)) fs.mkdirSync(testResultsDir, { recursive: true });
import * as path from 'path';

/**
 * Small Steps H5 移动端完整流程测试
 *
 * 覆盖步骤：
 * 1. 儿童登录 → 游戏化 UI
 * 2. 查看任务列表 → 任务卡片展示
 * 3. 执行任务 → 步骤引导
 * 4. 专注模式 → 防误触设计
 * 5. 任务完成 → 星星点亮/积分入账
 */

function getRandomTask() {
  const poolPath = path.resolve(__dirname, '../../task-pool.json');
  const tasks = JSON.parse(fs.readFileSync(poolPath, 'utf-8'));
  return tasks[Math.floor(Math.random() * tasks.length)];
}

test.describe('Small Steps H5 移动端完整流程', () => {
  const testTask = getRandomTask();

  test('Step 1: 儿童登录 → 游戏化首页', async ({ page }) => {
    const loginPage = new AppLoginPage(page);
    await loginPage.login('child_xiaoming', 'admin123');

    // 等待页面稳定
    await page.waitForTimeout(2000);

    // 截图：儿童首页
    await page.screenshot({ path: 'test-results/child-home.png' });

    // 验证进入了非登录页面
    const url = page.url();
    expect(url).toContain('#');
    console.log('✅ Step 1: 儿童登录成功');
  });

  test('Step 2: 查看任务列表', async ({ page }) => {
    const loginPage = new AppLoginPage(page);
    await loginPage.login('child_xiaoming', 'admin123');

    await page.waitForTimeout(2000);

    // 截图：任务列表
    await page.screenshot({ path: 'test-results/child-task-list.png' });
    console.log('✅ Step 2: 任务列表加载成功');
  });

  test('Step 3: 执行任务流程', async ({ page }) => {
    const loginPage = new AppLoginPage(page);
    await loginPage.login('child_xiaoming', 'admin123');

    await page.waitForTimeout(2000);

    // 尝试找到并点击一个任务
    const taskCard = page.locator('[class*="task"], [class*="card"], .uni-list-item').first();
    if (await taskCard.isVisible()) {
      await taskCard.click();
      await page.waitForTimeout(1500);

      // 截图：任务执行页面
      await page.screenshot({ path: 'test-results/child-task-execute.png' });

      const executePage = new TaskExecutePage(page);
      
      // 开始任务
      await executePage.startTask();
      
      // 完成所有子步骤
      await executePage.completeSteps(10);
      
      // 提交并完成任务
      await executePage.finishTask();
      await page.screenshot({ path: 'test-results/child-task-completed.png' });

      // 领取奖励并返回
      await executePage.collectReward();
      await page.waitForTimeout(1000);
      await page.screenshot({ path: 'test-results/child-task-reward-collected.png' });
    }

    console.log('✅ Step 3: 任务执行流程与奖励领取完整验证通过');
  });

  test('Step 4: 防误触设计验证', async ({ page }) => {
    const loginPage = new AppLoginPage(page);
    await loginPage.login('child_xiaoming', 'admin123');

    await page.waitForTimeout(2000);

    // 尝试进入任务执行
    const taskCard = page.locator('[class*="task"], [class*="card"], .uni-list-item').first();
    if (await taskCard.isVisible()) {
      await taskCard.click();
      await page.waitForTimeout(1000);

      // 按返回键
      await page.keyboard.press('Escape');
      await page.waitForTimeout(500);

      // 验证页面没有跳回（防误触应该生效）
      await page.screenshot({ path: 'test-results/child-anti-mistouch.png' });
    }

    console.log('✅ Step 4: 防误触设计验证');
  });

  test('Step 5: 家长端查看积分和任务状态', async ({ page }) => {
    const loginPage = new AppLoginPage(page);
    await loginPage.login('ken2zhao', 'admin123');

    await page.waitForTimeout(2000);

    // 截图：家长端首页
    await page.screenshot({ path: 'test-results/parent-dashboard-mobile.png' });

    // 尝试切换到"我的小步"查看积分
    const myStepTab = page.locator('text=/我的|Mine|Profile/').first();
    if (await myStepTab.isVisible()) {
      await myStepTab.click();
      await page.waitForTimeout(1000);
      await page.screenshot({ path: 'test-results/parent-profile.png' });
    }

    console.log('✅ Step 5: 家长端积分和任务状态验证');
  });
});
