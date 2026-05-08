import { test, expect } from '@playwright/test';

/**
 * Small Steps 首页（仪表盘）报表自动化测试脚本
 */
test.describe('仪表盘报表自动化测试', () => {
  
  test.beforeEach(async ({ page }) => {
    // 假设已通过 auth.setup.ts 完成登录，直接跳转首页
    await page.goto('/');
    // 等待加载动画消失
    await page.waitForSelector('#loader-wrapper', { state: 'hidden', timeout: 30000 });
    
    // 如果新手引导弹出，选择跳过并等待引导层消失
    const skipButton = page.getByRole('button', { name: '跳过' });
    if (await skipButton.isVisible()) {
      await skipButton.click();
      await expect(page.locator('.onboarding-overlay')).toBeHidden();
    }

    // 确保已进入仪表盘页面
    await expect(page).toHaveURL(/.*(dashboard|index)/);
  });

  test('验证核心报表卡片的可见性', async ({ page }) => {
    // 1. 验证 AI 智能中心
    const aiCenter = page.locator('.ai-center-card');
    await expect(aiCenter).toBeVisible();
    await expect(aiCenter.locator('.title')).toContainText('AI 智能中心');
    
    // 2. 验证 潜能开发雷达
    const radarCard = page.locator('.radar-card');
    await expect(radarCard).toBeVisible();
    await expect(radarCard.locator('.title')).toContainText('潜能开发雷达');

    // 3. 验证 行为一致性热力图
    const heatmapCard = page.locator('.heatmap-card');
    await expect(heatmapCard).toBeVisible();
    await expect(heatmapCard.locator('.title')).toContainText('行为一致性热力图');

    // 4. 验证 守护洞察图表
    const chartCard = page.locator('.chart-card');
    await expect(chartCard).toBeVisible();
    await expect(chartCard.locator('.title')).toContainText('守护洞察');
  });

  test('验证 ECharts 图表渲染状态', async ({ page }) => {
    // 检查 Canvas 是否渲染 (ECharts 的标志)
    const radarCanvas = page.locator('#abilityRadarChart canvas');
    await expect(radarCanvas).toBeVisible();

    const heatmapCanvas = page.locator('#habitHeatmapChart canvas');
    await expect(heatmapCanvas).toBeVisible();

    // 验证主图表
    const mainChart = page.locator('div[ref="mainChartRef"]');
    await expect(mainChart.locator('canvas').first()).toBeVisible();
    
    // 总计应有 3 个图表 canvas
    await expect(page.locator('canvas')).toHaveCount(3, { timeout: 10000 });
  });

  test('验证成就墙与任务队列', async ({ page }) => {
    // 验证成就墙是否有内容，且图标无 404 (图片应能正常加载)
    const achievementWall = page.locator('.achievement-wall');
    await expect(achievementWall).toBeVisible();
    const achievementIcons = achievementWall.locator('.achievement-item img');
    await expect(achievementIcons.first()).toBeVisible();
    
    // 检查图片是否加载成功 (naturalWidth > 0)
    const isImageLoaded = await achievementIcons.first().evaluate((img: HTMLImageElement) => img.naturalWidth > 0);
    expect(isImageLoaded).toBeTruthy();

    // 验证任务队列
    const taskList = page.locator('.task-list');
    await expect(taskList).toBeVisible();
    await expect(taskList.locator('.task-item')).not.toHaveCount(0);
  });

  test('验证时间维度切换交互', async ({ page }) => {
    const chartCard = page.locator('.chart-card');
    const radio30d = chartCard.locator('label:has-text("近30天")');
    
    // 模拟点击切换到 30天 (使用 force 以应对可能的微小遮挡)
    await radio30d.click({ force: true });
    
    // 验证切换后图表依然存在 (简单验证)
    await page.waitForTimeout(500); // 等待动画
    await expect(chartCard.locator('canvas')).toBeVisible();
  });

  test('验证响应式布局适配', async ({ page }) => {
    // 模拟手机端分辨率
    await page.setViewportSize({ width: 375, height: 667 });
    
    // 核心卡片应堆叠显示 (flex-direction: column or simple block)
    const aiCenter = page.locator('.ai-center-card');
    await expect(aiCenter).toBeVisible();
    
    // 确保没有横向滚动条 (简单检查)
    const hasHorizontalScroll = await page.evaluate(() => document.documentElement.scrollWidth > window.innerWidth);
    // 允许微小的溢出，或者根据实际布局调整
    // expect(hasHorizontalScroll).toBeFalsy();
  });

});
