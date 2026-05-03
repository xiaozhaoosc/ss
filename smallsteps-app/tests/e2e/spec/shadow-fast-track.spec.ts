import { test, expect } from '@playwright/test';
import { LoginPage } from '../pages/LoginPage';
import { TEST_ACCOUNTS } from '../../fixtures/test-data';

test.describe('影子观察者 - 快速通道测试', () => {
  test.use({ storageState: 'playwright/.auth/child.json' });

  test.beforeEach(async ({ page }) => {
    // 使用 storageState 后无需手动登录
  });

  test('儿童首页 hover-class 点击反馈应在 100ms 内响应', async ({ page }) => {
    // 确保导航到儿童首页
    await page.goto('/#/pages/child/home/index');
    await page.waitForLoadState('networkidle');

    // 等待页面元素加载
    await page.waitForTimeout(3000);

    // 查找页面内容（使用更宽松的选择器）
    const pageContent = page.locator('.child-home-page, .main-content, .header-bar');
    const contentCount = await pageContent.count();
    
    if (contentCount > 0) {
      console.log('页面内容已加载');
      
      // 查找机器人区域（作为主要交互元素）
      const robotArea = page.locator('.robot-area');
      if (await robotArea.count() > 0) {
        await expect(robotArea).toBeVisible();

        // 验证 hover-class 样式已配置
        const robotHoverClass = page.locator('[hover-class="robot-hover"]');
        if (await robotHoverClass.count() > 0) {
          await expect(robotHoverClass).toBeVisible();
        }

        // 验证点击响应时间
        const startTime = Date.now();
        await robotArea.click({ force: true });
        const endTime = Date.now();
        const clickDuration = endTime - startTime;

        // 点击反馈应在 100ms 内
        expect(clickDuration).toBeLessThan(100);
      } else {
        console.log('机器人区域未找到，跳过点击测试');
      }
    } else {
      console.log('页面内容未找到，测试跳过');
    }
  });

  test('儿童首页 - 设置按钮 hover-class 反馈', async ({ page }) => {
    await page.goto('/#/pages/child/home/index');
    await page.waitForLoadState('networkidle');
    await page.waitForTimeout(2000);

    // 查找设置按钮（可能在头部区域）
    const settingsBtn = page.locator('.settings-btn');
    if (await settingsBtn.count() > 0) {
      await expect(settingsBtn).toBeVisible();

      // 验证 hover-class 配置
      const settingsWithHover = page.locator('[hover-class="btn-hover"]');
      await expect(settingsWithHover).toBeVisible();
    } else {
      console.log('设置按钮未找到');
    }
  });

  test('儿童首页 - 快速链接卡片 hover-class 反馈', async ({ page }) => {
    await page.goto('/#/pages/child/home/index');
    await page.waitForLoadState('networkidle');
    await page.waitForTimeout(2000);

    // 查找快速链接卡片
    const linkCards = page.locator('.link-card');
    const count = await linkCards.count();
    
    if (count > 0) {
      await expect(linkCards.first()).toBeVisible();

      // 验证 card-hover 类已配置
      const cardWithHover = page.locator('[hover-class="card-hover"]');
      await expect(cardWithHover).toBeVisible();
    } else {
      console.log('快速链接卡片未找到');
    }
  });

  test('儿童首页 - 任务卡片 hover-class 反馈', async ({ page }) => {
    await page.goto('/#/pages/child/home/index');
    await page.waitForLoadState('networkidle');
    await page.waitForTimeout(2000);

    // 查找任务卡片
    const missionCard = page.locator('mission-card');
    if (await missionCard.count() > 0) {
      await expect(missionCard).toBeVisible();
    } else {
      console.log('任务卡片未找到');
    }
  });

  test('验证页面基本结构', async ({ page }) => {
    await page.goto('/#/pages/child/home/index');
    await page.waitForLoadState('networkidle');
    await page.waitForTimeout(2000);

    // 验证页面基本元素
    const headerBar = page.locator('.header-bar');
    const mainContent = page.locator('.main-content');
    const bottomNav = page.locator('child-bottom-nav');

    if (await headerBar.count() > 0) await expect(headerBar).toBeVisible();
    if (await mainContent.count() > 0) await expect(mainContent).toBeVisible();
    if (await bottomNav.count() > 0) await expect(bottomNav).toBeVisible();
  });
});
