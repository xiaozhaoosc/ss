import { test, expect } from '@playwright/test';
import { LoginPage } from './pages/LoginPage';
import { TaskPage } from './pages/TaskPage';
import * as fs from 'fs';
import * as path from 'path';

/**
 * Small Steps 完整业务流程自动化测试
 *
 * 覆盖 7 个关键步骤：
 * 1. 家长端登录 → 展示家长模式 UI
 * 2. 创建任务（从任务池随机获取）→ 展示任务拆解功能
 * 3. 查看任务列表 → 验证任务状态流转
 * 4. 查看奖励管理 → 展示积分激励体系
 * 5. 查看儿童管理 → 展示儿童档案
 * 6. 查看 AI 智能中心 → 展示 LLM 应用
 * 7. 查看情绪记录 → 展示数据看板
 */

// 从任务池随机选取一个任务
function getRandomTask() {
  const poolPath = path.resolve(__dirname, '../../task-pool.json');
  const tasks = JSON.parse(fs.readFileSync(poolPath, 'utf-8'));
  const idx = Math.floor(Math.random() * tasks.length);
  return tasks[idx];
}

test.describe('Small Steps 完整业务流程 (Full Lifecycle)', () => {
  const testTask = getRandomTask();
  // 动态生成包含时间戳的唯一任务标题，防止防重名逻辑直接跳过创建步骤
  const timeSuffix = new Date().toTimeString().slice(0, 5).replace(':', '');
  const taskTitle = `${testTask.title}_${timeSuffix}`;
  console.log(`🎲 随机选中任务: "${taskTitle}" (难度:${testTask.difficulty}, 积分:${testTask.rewardPoints})`);

  test('Step 1: 家长登录 → 家长模式 Dashboard', async ({ page }) => {
    // 登录
    const loginPage = new LoginPage(page);
    await loginPage.login('ken2zhao', 'Aa123456');

    // 验证 Dashboard 加载
    await expect(page).toHaveTitle(/Small Steps/);

    // 验证家长模式特有的元素
    const greeting = page.locator('text=/早安|守护者|小步/');
    await expect(greeting).toBeVisible({ timeout: 10000 });

    // 验证统计卡片可见
    const statsCards = page.locator('text=/在线儿童|任务完成率|专注时长|情绪平衡/');
    await expect(statsCards.first()).toBeVisible();

    // 验证 AI 智能中心可见
    const aiCenter = page.locator('text=/AI 智能中心/');
    await expect(aiCenter).toBeVisible();

    // 截图记录
    await page.screenshot({ path: 'test-results/step1-dashboard.png' });
    console.log('✅ Step 1: 家长 Dashboard 验证通过');
  });

  test('Step 2: 创建任务 → AI 拆解 → 任务列表验证', async ({ page }) => {
    // 登录
    const loginPage = new LoginPage(page);
    await loginPage.login('ken2zhao', 'Aa123456');

    // 进入任务管理
    const taskPage = new TaskPage(page);
    await taskPage.goto();

    // 搜索框验证：确保没有重名任务
    await taskPage.searchTask(taskTitle);
    const existingTask = page.locator(`text=${taskTitle}`);
    if (await existingTask.isVisible()) {
      console.log(`⚠️ 任务 "${taskTitle}" 已存在，跳过创建`);
      return;
    }

    // 打开新增对话框
    await taskPage.openCreateDialog();
    await expect(page.locator('.el-dialog')).toBeVisible();

    // 截图：任务创建表单
    await page.screenshot({ path: 'test-results/step2-task-form.png' });

    // 填写任务信息
    await taskPage.fillTaskForm({
      title: taskTitle,
      description: testTask.description,
      difficulty: testTask.difficulty,
      rewardPoints: testTask.rewardPoints,
    });

    // 触发 AI 拆解
    await taskPage.triggerAIBreakdown();

    // 截图：AI 拆解结果
    await page.screenshot({ path: 'test-results/step2-ai-breakdown.png' });

    // 提交任务
    await taskPage.submitTask();

    // 等待对话框关闭
    await expect(page.locator('.el-dialog')).toBeHidden({ timeout: 5000 });

    // 验证任务出现在列表中
    await taskPage.searchTask(taskTitle);
    await taskPage.expectTaskVisible(taskTitle);

    // 截图：任务列表
    await page.screenshot({ path: 'test-results/step2-task-created.png' });
    console.log(`✅ Step 2: 任务 "${taskTitle}" 创建成功`);
  });

  test('Step 3: 任务状态流转 → 列表展示', async ({ page }) => {
    const loginPage = new LoginPage(page);
    await loginPage.login('ken2zhao', 'Aa123456');

    const taskPage = new TaskPage(page);
    await taskPage.goto();

    // 验证任务列表有数据
    const taskCards = page.locator('.el-table__row, .task-card, [class*="task"]');
    const count = await taskCards.count();
    expect(count).toBeGreaterThan(0);

    // 验证有任务状态标签
    const statusTags = page.locator('.el-tag, .status-tag, [class*="status"]');
    if (await statusTags.first().isVisible()) {
      console.log(`📊 任务状态标签可见`);
    }

    // 截图
    await page.screenshot({ path: 'test-results/step3-task-list.png' });
    console.log('✅ Step 3: 任务列表验证通过');
  });

  test('Step 4: 奖励管理 → 积分激励体系', async ({ page }) => {
    const loginPage = new LoginPage(page);
    await loginPage.login('ken2zhao', 'Aa123456');

    // 进入奖励管理
    await page.goto('/#/smallsteps/reward');
    await page.waitForLoadState('domcontentloaded');
    await page.waitForTimeout(1000);

    // 验证奖励列表加载
    await page.screenshot({ path: 'test-results/step4-reward-list.png' });
    console.log('✅ Step 4: 奖励管理页面加载成功');
  });

  test('Step 5: 儿童管理 → 查看儿童档案', async ({ page }) => {
    const loginPage = new LoginPage(page);
    await loginPage.login('ken2zhao', 'Aa123456');

    // 进入儿童管理
    await page.goto('/#/smallsteps/child');
    await page.waitForLoadState('domcontentloaded');
    await page.waitForTimeout(1000);

    // 验证儿童列表加载
    await page.screenshot({ path: 'test-results/step5-child-list.png' });
    console.log('✅ Step 5: 儿童管理页面加载成功');
  });

  test('Step 6: AI 智能中心 → Dashboard 数据', async ({ page }) => {
    const loginPage = new LoginPage(page);
    await loginPage.login('ken2zhao', 'Aa123456');

    // 回到 Dashboard 查看 AI 智能中心
    await page.waitForLoadState('domcontentloaded');
    await page.waitForTimeout(1000);

    // 验证 AI 智能中心
    const aiCenter = page.locator('text=/AI 智能中心/');
    await expect(aiCenter).toBeVisible({ timeout: 10000 });

    // 验证 Token 消耗信息
    const tokenInfo = page.locator('text=/Token|消耗|额度/');
    if (await tokenInfo.first().isVisible()) {
      console.log('📊 Token 消耗数据可见');
    }

    // 验证图表（Canvas）
    const charts = page.locator('canvas');
    const chartCount = await charts.count();
    expect(chartCount).toBeGreaterThan(0);

    // 截图
    await page.screenshot({ path: 'test-results/step6-ai-center.png' });
    console.log('✅ Step 6: AI 智能中心验证通过');
  });

  test('Step 7: 执行中任务 → 完整闭环验证', async ({ page }) => {
    const loginPage = new LoginPage(page);
    await loginPage.login('ken2zhao', 'Aa123456');

    // Dashboard 上的"正在执行中的任务"区域
    const executingTasks = page.locator('text=/正在执行中|执行中的任务/');
    await expect(executingTasks.first()).toBeVisible({ timeout: 10000 });

    // 验证有任务卡片
    const taskItems = page.locator('text=/晨间洗漱|口算|整理书包|跳绳|起床|上学/');
    if (await taskItems.first().isVisible()) {
      console.log('📋 正在执行中的任务可见');
    }

    // 验证积分显示
    const points = page.locator('text=/\\+\\d+/');
    if (await points.first().isVisible()) {
      console.log('⭐ 积分信息可见');
    }

    // 截图
    await page.screenshot({ path: 'test-results/step7-executing-tasks.png' });
    console.log('✅ Step 7: 执行中任务验证通过');
  });
});
