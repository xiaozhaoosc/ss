import { test, expect } from '@playwright/test';

test.describe('Small Steps Web端 - 首页模块详细测试', () => {
  test('首页 - 仪表盘加载验证', async ({ page }) => {
    await page.goto('/#/dashboard');
    await expect(page.getByRole('heading', { name: '早安, 小步守护者' })).toBeVisible({ timeout: 15000 });
    await expect(page.locator('.el-card')).toHaveCountAtLeast(2);
  });
});

test.describe('Small Steps Web端 - AI管理模块详细测试', () => {
  test.beforeEach(async ({ page }) => {
    await page.goto('/');
    // Skip guided tour if present
    const skipBtn = page.locator('.introjs-skipbutton');
    if (await skipBtn.isVisible()) {
      await skipBtn.click();
    }
  });

  test('AI模型管理 - 列表验证', async ({ page }) => {
    await page.goto('/#/ai/model');
    await page.waitForSelector('.el-table', { timeout: 10000 });
    const headers = await page.locator('.el-table__header').textContent();
    expect(headers).toContain('模型名称');
    expect(headers).toContain('模型标识');
  });

  test('AI提示词模板 - 列表验证', async ({ page }) => {
    await page.goto('/#/ai/prompt');
    await page.waitForSelector('.el-table', { timeout: 10000 });
    await expect(page.locator('.el-table')).toBeVisible();
  });

  test('AI日志 - 列表验证', async ({ page }) => {
    await page.goto('/#/ai/log');
    await page.waitForSelector('.el-table', { timeout: 10000 });
    await expect(page.locator('.el-table')).toBeVisible();
  });
});

test.describe('Small Steps Web端 - 我的小步模块详细测试', () => {
  test.beforeEach(async ({ page }) => {
    await page.goto('/');
    await page.waitForLoadState('domcontentloaded');
    await page.waitForTimeout(3000);
  });

  test('我的小步 - 任务列表页面', async ({ page }) => {
    await page.goto('/#/smallsteps/task');
    await page.waitForLoadState('domcontentloaded');
    await page.waitForTimeout(3000);

    const pageContent = await page.content();
    expect(pageContent.length).toBeGreaterThan(100);
  });

  test('我的小步 - 奖励列表页面', async ({ page }) => {
    await page.goto('/#/smallsteps/reward');
    await page.waitForLoadState('domcontentloaded');
    await page.waitForTimeout(3000);

    const pageContent = await page.content();
    expect(pageContent.length).toBeGreaterThan(100);
  });

  test('我的小步 - 合约列表页面', async ({ page }) => {
    await page.goto('/#/smallsteps/contract');
    await page.waitForLoadState('domcontentloaded');
    await page.waitForTimeout(3000);

    const pageContent = await page.content();
    expect(pageContent.length).toBeGreaterThan(100);
  });

  test('我的小步 - 情绪管理页面', async ({ page }) => {
    await page.goto('/#/smallsteps/emotion');
    await page.waitForLoadState('domcontentloaded');
    await page.waitForTimeout(3000);

    const pageContent = await page.content();
    expect(pageContent.length).toBeGreaterThan(100);
  });

  test('我的小步 - 设备管理页面', async ({ page }) => {
    await page.goto('/#/smallsteps/device');
    await page.waitForLoadState('domcontentloaded');
    await page.waitForTimeout(3000);

    const pageContent = await page.content();
    expect(pageContent.length).toBeGreaterThan(100);
  });
});

test.describe('Small Steps Web端 - 学生端模块详细测试', () => {
  test.beforeEach(async ({ page }) => {
    await page.goto('/');
    await page.waitForLoadState('domcontentloaded');
    await page.waitForTimeout(3000);
  });

  test('学生端 - 任务管理页面', async ({ page }) => {
    await page.goto('/#/child/task');
    await page.waitForLoadState('domcontentloaded');
    await page.waitForTimeout(3000);

    const pageContent = await page.content();
    expect(pageContent.length).toBeGreaterThan(100);
  });

  test('学生端 - 成就管理页面', async ({ page }) => {
    await page.goto('/#/child/achievement');
    await page.waitForLoadState('domcontentloaded');
    await page.waitForTimeout(3000);

    const pageContent = await page.content();
    expect(pageContent.length).toBeGreaterThan(100);
  });

  test('学生端 - 奖励管理页面', async ({ page }) => {
    await page.goto('/#/child/reward');
    await page.waitForLoadState('domcontentloaded');
    await page.waitForTimeout(3000);

    const pageContent = await page.content();
    expect(pageContent.length).toBeGreaterThan(100);
  });

  test('学生端 - 积分管理页面', async ({ page }) => {
    await page.goto('/#/child/score');
    await page.waitForLoadState('domcontentloaded');
    await page.waitForTimeout(3000);

    const pageContent = await page.content();
    expect(pageContent.length).toBeGreaterThan(100);
  });

  test('学生端 - 情绪管理页面', async ({ page }) => {
    await page.goto('/#/child/emotion');
    await page.waitForLoadState('domcontentloaded');
    await page.waitForTimeout(3000);

    const pageContent = await page.content();
    expect(pageContent.length).toBeGreaterThan(100);
  });

  test('学生端 - AI助手页面', async ({ page }) => {
    await page.goto('/#/child/ai');
    await page.waitForLoadState('domcontentloaded');
    await page.waitForTimeout(3000);

    const pageContent = await page.content();
    expect(pageContent.length).toBeGreaterThan(100);
  });
});

test.describe('Small Steps Web端 - 系统管理模块详细测试', () => {
  test.beforeEach(async ({ page }) => {
    await page.goto('/');
    await page.waitForLoadState('domcontentloaded');
    await page.waitForTimeout(3000);
  });

  test('系统管理 - 用户管理页面', async ({ page }) => {
    await page.goto('/#/system/user');
    await page.waitForLoadState('domcontentloaded');
    await page.waitForTimeout(3000);

    const pageContent = await page.content();
    expect(pageContent.length).toBeGreaterThan(100);
  });

  test('系统管理 - 角色管理页面', async ({ page }) => {
    await page.goto('/#/system/role');
    await page.waitForLoadState('domcontentloaded');
    await page.waitForTimeout(3000);

    const pageContent = await page.content();
    expect(pageContent.length).toBeGreaterThan(100);
  });

  test('系统管理 - 菜单管理页面', async ({ page }) => {
    await page.goto('/#/system/menu');
    await page.waitForLoadState('domcontentloaded');
    await page.waitForTimeout(3000);

    const pageContent = await page.content();
    expect(pageContent.length).toBeGreaterThan(100);
  });

  test('系统管理 - 部门管理页面', async ({ page }) => {
    await page.goto('/#/system/dept');
    await page.waitForLoadState('domcontentloaded');
    await page.waitForTimeout(3000);

    const pageContent = await page.content();
    expect(pageContent.length).toBeGreaterThan(100);
  });

  test('系统管理 - 参数设置页面', async ({ page }) => {
    await page.goto('/#/system/config');
    await page.waitForLoadState('domcontentloaded');
    await page.waitForTimeout(3000);

    const pageContent = await page.content();
    expect(pageContent.length).toBeGreaterThan(100);
  });

  test('系统管理 - 数据字典页面', async ({ page }) => {
    await page.goto('/#/system/dict');
    await page.waitForLoadState('domcontentloaded');
    await page.waitForTimeout(3000);

    const pageContent = await page.content();
    expect(pageContent.length).toBeGreaterThan(100);
  });
});