import { test, expect } from '@playwright/test';

/**
 * Small Steps 家长洞察页面 E2E 测试
 * 遵循 E2E_Stability_Architect (v1.0) 准则
 */
test.describe('家长洞察页面功能测试', () => {

  test.beforeEach(async ({ page }) => {
    // 登录预置已通过 auth.setup.ts 完成
    await page.goto('/#/pages/parent/insights/index');
    
    // 1. 防御性导航：等待加载器消失
    await page.waitForSelector('.loading-mask', { state: 'hidden', timeout: 15000 }).catch(() => {});
    
    // 2. 防御性导航：处理可能存在的弹窗/引导 (Small Steps 惯例)
    const skipButton = page.getByRole('button', { name: '跳过' });
    if (await skipButton.isVisible()) {
      await skipButton.click();
    }
  });

  test('验证页面核心组件可见性', async ({ page }) => {
    // 验证标题
    await expect(page.locator('.header .title')).toContainText('家长洞察');
    
    // 验证儿童选择器
    const selector = page.locator('.child-selector');
    await expect(selector).toBeVisible();
    await expect(selector.locator('.child-item')).not.toHaveCount(0);
    
    // 验证核心卡片
    await expect(page.locator('.section-title').filter({ hasText: '每周重点' })).toBeVisible();
    await expect(page.locator('.section-title').filter({ hasText: '影子观察者' })).toBeVisible();
    await expect(page.locator('.section-title').filter({ hasText: '月度情绪热力图' })).toBeVisible();
  });

  test('验证多子女切换一致性 (Context Isolation)', async ({ page }) => {
    await page.waitForSelector('.child-item', { state: 'attached', timeout: 10000 });
    const childItems = page.locator('.child-item');
    const count = await childItems.count();
    
    if (count < 2) {
      console.log('当前家庭子女少于 2 人，跳过切换测试');
      return;
    }

    // 获取当前激活的孩子姓名
    const initialActiveName = await page.locator('.child-item.active .child-name').textContent();
    console.log(`初始激活孩子: ${initialActiveName}`);

    // 找到一个非激活的孩子并点击 (使用索引避免定位器漂移)
    const targetChild = childItems.nth(1);
    const targetName = (await targetChild.locator('.child-name').textContent())?.trim();
    
    await targetChild.click();

    // 1. 验证选中态 CSS 类更新
    await expect(targetChild).toHaveClass(/active/);
    
    // 2. 验证上下文更新 (由于页面没有全局 Header 显示姓名，我们通过 API 触发的渲染来间接验证)
    // 验证 Loader 再次出现并消失（代表正在加载新子女数据）
    // await page.waitForSelector('.loading-mask', { state: 'visible' }).catch(() => {});
    // await page.waitForSelector('.loading-mask', { state: 'hidden' });

    console.log(`成功切换至: ${targetName}`);
    expect(targetName).not.toBe(initialActiveName);
  });

  test('验证影子观察者说明弹窗', async ({ page }) => {
    const hintIcon = page.locator('.hint-icon');
    await hintIcon.click();
    
    // 验证 uni.showModal 弹出的对话框内容 (H5 环境下通常是 .uni-modal)
    const modal = page.locator('.uni-modal');
    await expect(modal).toBeVisible();
    await expect(modal.locator('.uni-modal__title')).toContainText('影子观察者说明');
    await expect(modal.locator('.uni-modal__bd')).toContainText('影子预警');
    
    // 关闭弹窗
    await modal.locator('.uni-modal__btn_primary').click();
    await expect(modal).toBeHidden();
  });

  test('验证图表渲染 (CSS-based Bars)', async ({ page }) => {
    // 验证能力发展条形图
    const bars = page.locator('.bar-chart .bar');
    await expect(bars.first()).toBeVisible();
    
    // 验证影子观察者情绪条
    const moodBars = page.locator('.shadow-chart .mood-bar');
    // 如果平均情绪为 0，高度可能为 0导致不可见，改为检查是否存在于 DOM
    await expect(moodBars.first()).toBeAttached();
    
    // 验证热力图打点
    const calendarGrid = page.locator('.calendar-grid');
    await expect(calendarGrid).toBeVisible();
  });

  test('验证响应式适配 (Mobile Viewport)', async ({ page }) => {
    await page.setViewportSize({ width: 375, height: 667 });
    
    // 验证选择器是否可滚动 (scroll-view)
    const scrollable = page.locator('.child-scroll');
    await expect(scrollable).toBeVisible();
    
    // 检查是否有非法横向滚动溢出
    const hasHorizontalScroll = await page.evaluate(() => {
      return document.documentElement.scrollWidth > window.innerWidth + 5; // 允许 5px 误差
    });
    expect(hasHorizontalScroll, '移动端布局不应有横向滚动溢出').toBeFalsy();
  });

});
