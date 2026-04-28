import { test, expect } from '@playwright/test';

test.describe('Small Steps Web端 - 首页模块测试', () => {
  test.beforeEach(async ({ page }) => {
    await page.goto('/');
    await page.waitForLoadState('domcontentloaded');
  });

  test('首页 - 仪表盘加载', async ({ page }) => {
    await page.waitForTimeout(3000);
    const url = page.url();
    console.log('首页URL:', url);
    expect(url).toContain('localhost');
  });

  test('首页 - 验证首页元素', async ({ page }) => {
    const pageContent = await page.content();
    expect(pageContent.length).toBeGreaterThan(100);
  });
});

test.describe('Small Steps Web端 - AI管理模块测试', () => {
  test.beforeEach(async ({ page }) => {
    await page.goto('/');
    await page.waitForLoadState('domcontentloaded');
    await page.waitForTimeout(3000);
  });

  test('AI模型管理 - 列表页面加载', async ({ page }) => {
    await page.goto('/#/ai/model');
    await page.waitForLoadState('domcontentloaded');
    await page.waitForTimeout(2000);

    const pageContent = await page.content();
    const hasException = pageContent.includes('Exception');
    expect(hasException).toBe(false);
  });

  test('AI提示词模板 - 列表页面加载', async ({ page }) => {
    await page.goto('/#/ai/prompt');
    await page.waitForLoadState('domcontentloaded');
    await page.waitForTimeout(2000);

    const pageContent = await page.content();
    const hasException = pageContent.includes('Exception');
    expect(hasException).toBe(false);
  });

  test('AI路由配置 - 列表页面加载', async ({ page }) => {
    await page.goto('/#/ai/route');
    await page.waitForLoadState('domcontentloaded');
    await page.waitForTimeout(2000);

    const pageContent = await page.content();
    const hasException = pageContent.includes('Exception');
    expect(hasException).toBe(false);
  });

  test('AI供应商配置 - 列表页面加载', async ({ page }) => {
    await page.goto('/#/ai/provider');
    await page.waitForLoadState('domcontentloaded');
    await page.waitForTimeout(2000);

    const pageContent = await page.content();
    const hasException = pageContent.includes('Exception');
    expect(hasException).toBe(false);
  });

  test('AI日志 - 列表页面加载', async ({ page }) => {
    await page.goto('/#/ai/log');
    await page.waitForLoadState('domcontentloaded');
    await page.waitForTimeout(2000);

    const pageContent = await page.content();
    const hasException = pageContent.includes('Exception');
    expect(hasException).toBe(false);
  });
});

test.describe('Small Steps Web端 - 我的小步模块测试', () => {
  test.beforeEach(async ({ page }) => {
    await page.goto('/');
    await page.waitForLoadState('domcontentloaded');
    await page.waitForTimeout(3000);
  });

  test('我的小步 - 任务列表加载', async ({ page }) => {
    await page.goto('/#/smallsteps/task');
    await page.waitForLoadState('domcontentloaded');
    await page.waitForTimeout(2000);

    const pageContent = await page.content();
    const hasException = pageContent.includes('Exception');
    expect(hasException).toBe(false);
  });

  test('我的小步 - 奖励列表加载', async ({ page }) => {
    await page.goto('/#/smallsteps/reward');
    await page.waitForLoadState('domcontentloaded');
    await page.waitForTimeout(2000);

    const pageContent = await page.content();
    const hasException = pageContent.includes('Exception');
    expect(hasException).toBe(false);
  });

  test('我的小步 - 合约列表加载', async ({ page }) => {
    await page.goto('/#/smallsteps/contract');
    await page.waitForLoadState('domcontentloaded');
    await page.waitForTimeout(2000);

    const pageContent = await page.content();
    const hasException = pageContent.includes('Exception');
    expect(hasException).toBe(false);
  });

  test('我的小步 - 情绪管理加载', async ({ page }) => {
    await page.goto('/#/smallsteps/emotion');
    await page.waitForLoadState('domcontentloaded');
    await page.waitForTimeout(2000);

    const pageContent = await page.content();
    const hasException = pageContent.includes('Exception');
    expect(hasException).toBe(false);
  });

  test('我的小步 - 设备管理加载', async ({ page }) => {
    await page.goto('/#/smallsteps/device');
    await page.waitForLoadState('domcontentloaded');
    await page.waitForTimeout(2000);

    const pageContent = await page.content();
    const hasException = pageContent.includes('Exception');
    expect(hasException).toBe(false);
  });
});