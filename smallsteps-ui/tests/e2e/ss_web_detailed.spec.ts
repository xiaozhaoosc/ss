import { test, expect } from '@playwright/test';

test.describe('Small Steps Web端 - 首页模块详细测试', () => {
  test('首页 - 登录页面元素验证', async ({ page }) => {
    await page.goto('/');
    await page.waitForLoadState('domcontentloaded');
    await page.waitForTimeout(2000);

    const pageContent = await page.content();
    expect(pageContent).toContain('用户名');
    expect(pageContent).toContain('密码');
    expect(pageContent).toContain('登录');
  });

  test('首页 - 登录功能测试', async ({ page }) => {
    await page.goto('/');
    await page.waitForLoadState('domcontentloaded');
    await page.waitForTimeout(2000);

    await page.locator('input[placeholder="用户名"]').fill('admin');
    await page.locator('input[placeholder="密码"]').fill('admin123');
    await page.getByRole('button', { name: '登 录' }).click();
    await page.waitForTimeout(5000);

    const url = page.url();
    console.log('登录后URL:', url);
    expect(url.includes('index') || url.includes('dashboard')).toBe(true);
  });
});

test.describe('Small Steps Web端 - AI管理模块详细测试', () => {
  test.beforeEach(async ({ page }) => {
    await page.goto('/');
    await page.waitForLoadState('domcontentloaded');
    await page.waitForTimeout(3000);
  });

  test('AI模型管理 - 页面加载', async ({ page }) => {
    await page.goto('/#/ai/model');
    await page.waitForLoadState('domcontentloaded');
    await page.waitForTimeout(3000);

    const pageContent = await page.content();
    const hasException = pageContent.includes('Exception');
    expect(hasException).toBe(false);
  });

  test('AI提示词模板 - 页面加载', async ({ page }) => {
    await page.goto('/#/ai/prompt');
    await page.waitForLoadState('domcontentloaded');
    await page.waitForTimeout(3000);

    const pageContent = await page.content();
    const hasException = pageContent.includes('Exception');
    expect(hasException).toBe(false);
  });

  test('AI路由配置 - 页面加载', async ({ page }) => {
    await page.goto('/#/ai/route');
    await page.waitForLoadState('domcontentloaded');
    await page.waitForTimeout(3000);

    const pageContent = await page.content();
    const hasException = pageContent.includes('Exception');
    expect(hasException).toBe(false);
  });

  test('AI供应商配置 - 页面加载', async ({ page }) => {
    await page.goto('/#/ai/provider');
    await page.waitForLoadState('domcontentloaded');
    await page.waitForTimeout(3000);

    const pageContent = await page.content();
    const hasException = pageContent.includes('Exception');
    expect(hasException).toBe(false);
  });

  test('AI日志 - 页面加载', async ({ page }) => {
    await page.goto('/#/ai/log');
    await page.waitForLoadState('domcontentloaded');
    await page.waitForTimeout(3000);

    const pageContent = await page.content();
    const hasException = pageContent.includes('Exception');
    expect(hasException).toBe(false);
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
    const hasException = pageContent.includes('Exception');
    expect(hasException).toBe(false);
  });

  test('我的小步 - 奖励列表页面', async ({ page }) => {
    await page.goto('/#/smallsteps/reward');
    await page.waitForLoadState('domcontentloaded');
    await page.waitForTimeout(3000);

    const pageContent = await page.content();
    const hasException = pageContent.includes('Exception');
    expect(hasException).toBe(false);
  });

  test('我的小步 - 合约列表页面', async ({ page }) => {
    await page.goto('/#/smallsteps/contract');
    await page.waitForLoadState('domcontentloaded');
    await page.waitForTimeout(3000);

    const pageContent = await page.content();
    const hasException = pageContent.includes('Exception');
    expect(hasException).toBe(false);
  });

  test('我的小步 - 情绪管理页面', async ({ page }) => {
    await page.goto('/#/smallsteps/emotion');
    await page.waitForLoadState('domcontentloaded');
    await page.waitForTimeout(3000);

    const pageContent = await page.content();
    const hasException = pageContent.includes('Exception');
    expect(hasException).toBe(false);
  });

  test('我的小步 - 设备管理页面', async ({ page }) => {
    await page.goto('/#/smallsteps/device');
    await page.waitForLoadState('domcontentloaded');
    await page.waitForTimeout(3000);

    const pageContent = await page.content();
    const hasException = pageContent.includes('Exception');
    expect(hasException).toBe(false);
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
    const hasException = pageContent.includes('Exception');
    expect(hasException).toBe(false);
  });

  test('学生端 - 成就管理页面', async ({ page }) => {
    await page.goto('/#/child/achievement');
    await page.waitForLoadState('domcontentloaded');
    await page.waitForTimeout(3000);

    const pageContent = await page.content();
    const hasException = pageContent.includes('Exception');
    expect(hasException).toBe(false);
  });

  test('学生端 - 奖励管理页面', async ({ page }) => {
    await page.goto('/#/child/reward');
    await page.waitForLoadState('domcontentloaded');
    await page.waitForTimeout(3000);

    const pageContent = await page.content();
    const hasException = pageContent.includes('Exception');
    expect(hasException).toBe(false);
  });

  test('学生端 - 积分管理页面', async ({ page }) => {
    await page.goto('/#/child/score');
    await page.waitForLoadState('domcontentloaded');
    await page.waitForTimeout(3000);

    const pageContent = await page.content();
    const hasException = pageContent.includes('Exception');
    expect(hasException).toBe(false);
  });

  test('学生端 - 情绪管理页面', async ({ page }) => {
    await page.goto('/#/child/emotion');
    await page.waitForLoadState('domcontentloaded');
    await page.waitForTimeout(3000);

    const pageContent = await page.content();
    const hasException = pageContent.includes('Exception');
    expect(hasException).toBe(false);
  });

  test('学生端 - AI助手页面', async ({ page }) => {
    await page.goto('/#/child/ai');
    await page.waitForLoadState('domcontentloaded');
    await page.waitForTimeout(3000);

    const pageContent = await page.content();
    const hasException = pageContent.includes('Exception');
    expect(hasException).toBe(false);
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
    const hasException = pageContent.includes('Exception');
    expect(hasException).toBe(false);
  });

  test('系统管理 - 角色管理页面', async ({ page }) => {
    await page.goto('/#/system/role');
    await page.waitForLoadState('domcontentloaded');
    await page.waitForTimeout(3000);

    const pageContent = await page.content();
    const hasException = pageContent.includes('Exception');
    expect(hasException).toBe(false);
  });

  test('系统管理 - 菜单管理页面', async ({ page }) => {
    await page.goto('/#/system/menu');
    await page.waitForLoadState('domcontentloaded');
    await page.waitForTimeout(3000);

    const pageContent = await page.content();
    const hasException = pageContent.includes('Exception');
    expect(hasException).toBe(false);
  });

  test('系统管理 - 部门管理页面', async ({ page }) => {
    await page.goto('/#/system/dept');
    await page.waitForLoadState('domcontentloaded');
    await page.waitForTimeout(3000);

    const pageContent = await page.content();
    const hasException = pageContent.includes('Exception');
    expect(hasException).toBe(false);
  });

  test('系统管理 - 参数设置页面', async ({ page }) => {
    await page.goto('/#/system/config');
    await page.waitForLoadState('domcontentloaded');
    await page.waitForTimeout(3000);

    const pageContent = await page.content();
    const hasException = pageContent.includes('Exception');
    expect(hasException).toBe(false);
  });

  test('系统管理 - 数据字典页面', async ({ page }) => {
    await page.goto('/#/system/dict');
    await page.waitForLoadState('domcontentloaded');
    await page.waitForTimeout(3000);

    const pageContent = await page.content();
    const hasException = pageContent.includes('Exception');
    expect(hasException).toBe(false);
  });
});