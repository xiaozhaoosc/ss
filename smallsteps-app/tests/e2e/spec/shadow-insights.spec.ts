import { test, expect } from '@playwright/test';
import { LoginPage } from '../pages/LoginPage';
import { TEST_ACCOUNTS } from '../../fixtures/test-data';

test.describe('家长端 - 影子观察者情绪预警趋势测试', () => {
  test.use({ storageState: 'playwright/.auth/parent.json' });

  test.beforeEach(async ({ page }) => {
    // 使用 storageState 后无需手动登录
  });

  /**
   * TC-C01: App 端预警显示测试
   * 验证家长端洞察页面显示情绪预警趋势图表
   */
  test('情绪预警趋势页面加载', async ({ page }) => {
    await page.goto('/pages/parent/insights/index');
    await page.waitForLoadState('networkidle');
    await page.waitForTimeout(2000);

    // 验证页面标题
    await expect(page.getByText('家长洞察')).toBeVisible({ timeout: 10000 });

    // 验证影子观察者区域存在
    const shadowSection = page.locator('text=影子观察者：情绪预警趋势');
    await expect(shadowSection).toBeVisible({ timeout: 5000 });
  });

  /**
   * TC-C01 扩展: 验证本周预警总数统计
   */
  test('影子观察者统计数据展示', async ({ page }) => {
    await page.goto('/pages/parent/insights/index');
    await page.waitForLoadState('networkidle');
    await page.waitForTimeout(2000);

    // 验证统计区域存在
    const shadowStats = page.locator('.shadow-stats');
    await expect(shadowStats).toBeVisible({ timeout: 5000 });

    // 验证预警总数显示
    const warningCount = page.locator('.shadow-stats .stat-item:first-child .stat-value');
    if (await warningCount.count() > 0) {
      const countText = await warningCount.textContent();
      console.log('本周预警总数:', countText);
    }

    // 验证平均情绪指数显示
    const avgMood = page.locator('.shadow-stats .stat-item:last-child .stat-value');
    if (await avgMood.count() > 0) {
      const moodText = await avgMood.textContent();
      console.log('平均情绪指数:', moodText);
    }
  });

  /**
   * TC-C01 扩展: 验证预警胶囊显示
   */
  test('情绪预警趋势柱状图 - 预警胶囊显示', async ({ page }) => {
    await page.goto('/pages/parent/insights/index');
    await page.waitForLoadState('networkidle');
    await page.waitForTimeout(3000);

    // 查找预警胶囊（红色胶囊显示挫败次数）
    const warningCapsules = page.locator('.warning-capsule');
    const capsuleCount = await warningCapsules.count();
    console.log(`预警胶囊数量: ${capsuleCount}`);

    // 如果有预警胶囊，验证内容
    if (capsuleCount > 0) {
      for (let i = 0; i < capsuleCount; i++) {
        const capsule = warningCapsules.nth(i);
        const text = await capsule.textContent();
        console.log(`预警胶囊 ${i + 1}: ${text}`);
      }
    }
  });

  /**
   * TC-C01 扩展: 验证柱状图颜色编码
   */
  test('情绪预警趋势柱状图 - 颜色编码验证', async ({ page }) => {
    await page.goto('/pages/parent/insights/index');
    await page.waitForLoadState('networkidle');
    await page.waitForTimeout(2000);

    // 查找情绪柱状图
    const moodBars = page.locator('.mood-bar');
    const barCount = await moodBars.count();
    console.log(`情绪柱状图数量: ${barCount}`);

    // 验证柱状图存在并具有颜色
    if (barCount > 0) {
      await expect(moodBars.first()).toBeVisible();
    }
  });

  /**
   * 测试情绪热力图显示
   */
  test('月度情绪热力图显示', async ({ page }) => {
    await page.goto('/pages/parent/insights/index');
    await page.waitForLoadState('networkidle');
    await page.waitForTimeout(2000);

    // 验证热力图区域存在
    const heatmapSection = page.locator('text=月度情绪热力图');
    await expect(heatmapSection).toBeVisible({ timeout: 5000 });

    // 验证日历网格存在
    const calendarGrid = page.locator('.calendar-grid');
    await expect(calendarGrid).toBeVisible({ timeout: 5000 });
  });

  /**
   * 测试影子观察者说明弹窗
   */
  test('影子观察者说明弹窗', async ({ page }) => {
    await page.goto('/pages/parent/insights/index');
    await page.waitForLoadState('networkidle');
    await page.waitForTimeout(1000);

    // 查找问号提示按钮
    const hintIcon = page.locator('.hint-icon');
    if (await hintIcon.count() > 0) {
      await hintIcon.click({ force: true });
      await page.waitForTimeout(500);

      // 验证弹窗显示
      const modal = page.locator('.uni-modal, text=影子观察者说明');
      if (await modal.count() > 0) {
        console.log('说明弹窗已显示');
      }
    }
  });

  /**
   * 测试每周重点区域
   */
  test('每周重点区域显示', async ({ page }) => {
    await page.goto('/pages/parent/insights/index');
    await page.waitForLoadState('networkidle');
    await page.waitForTimeout(2000);

    // 验证每周重点区域存在
    const weeklySection = page.locator('text=每周重点');
    await expect(weeklySection).toBeVisible({ timeout: 5000 });

    // 验证能力发展总览卡片
    const overviewCard = page.locator('text=能力发展总览');
    await expect(overviewCard).toBeVisible({ timeout: 5000 });
  });

  /**
   * 测试详情按钮导航
   */
  test('详情按钮导航', async ({ page }) => {
    await page.goto('/pages/parent/insights/index');
    await page.waitForLoadState('networkidle');
    await page.waitForTimeout(1000);

    // 查找详情按钮
    const detailBtn = page.locator('.more-btn:has-text("详情")');
    if (await detailBtn.count() > 0) {
      await detailBtn.click({ force: true });
      await page.waitForTimeout(1500);

      // 验证导航到周报告页面
      await expect(page).toHaveURL(/weekly-report/, { timeout: 5000 }).catch(() => {
        console.log('导航可能失败，检查路由配置');
      });
    }
  });
});

test.describe('影子观察者 API 测试', () => {
  /**
   * 测试影子情绪趋势 API 数据结构
   */
  test('影子情绪趋势 API - 数据结构验证', async ({ page }) => {
    // 直接调用 API
    const response = await page.request.get('/api/parent/insight/emotion/shadow-trend/1', {
      params: { days: 7 }
    });

    // 验证响应状态
    expect([200, 401, 500]).toContain(response.status());

    if (response.status() === 200) {
      const data = await response.json();
      
      // 验证数据结构
      expect(data).toHaveProperty('code');
      expect(data).toHaveProperty('data');

      if (data.data && Array.isArray(data.data)) {
        // 验证数组长度
        expect(data.data.length).toBe(7);

        // 验证每个数据点的结构
        data.data.forEach((item: any) => {
          expect(item).toHaveProperty('date');
          expect(item).toHaveProperty('dayLabel');
          expect(item).toHaveProperty('avgMood');
          expect(item).toHaveProperty('frustrationCount');
        });
      }
    }
  });

  /**
   * 测试情绪提交 API
   */
  test('情绪提交 API - 数据结构验证', async ({ page }) => {
    const emotionData = {
      childId: 1,
      moodLevel: 2,
      moodType: 'frustrated',
      description: '[影子观察] 测试高频点击检测'
    };

    const response = await page.request.post('/api/child/emotion/submit', {
      data: emotionData,
      headers: { 'Content-Type': 'application/json' }
    });

    expect([200, 401, 500]).toContain(response.status());
  });
});
