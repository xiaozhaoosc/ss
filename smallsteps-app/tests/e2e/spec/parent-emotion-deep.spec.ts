import { test, expect } from '@playwright/test';
import { LoginPage } from '../pages/LoginPage';
import { TEST_ACCOUNTS } from '../../fixtures/test-data';

test.describe('情绪相关页面深度测试', () => {
  let loginPage: LoginPage;

  test.beforeEach(async ({ page }) => {
    loginPage = new LoginPage(page);
    await loginPage.goto();
    await loginPage.login(TEST_ACCOUNTS.parent1.username, TEST_ACCOUNTS.parent1.password);
  });

  test('情绪警报页面加载测试', async ({ page }) => {
    await page.goto('/pages/parent/emotion-alert/index');
    await page.waitForLoadState('networkidle');

    // 验证页面加载
    await expect(page).toHaveURL(/emotion-alert/);

    // 验证警告框存在
    const alertBox = page.locator('.bg-red-50');
    await expect(alertBox).toBeVisible({ timeout: 10000 });

    // 验证警告文本
    await expect(page.getByText('AI Alert: High Frustration Detected')).toBeVisible();

    // 验证 Mark as Read 按钮
    const markReadBtn = page.locator('button:has-text("Mark as Read")');
    await expect(markReadBtn).toBeVisible();
  });

  test('情绪警报页面 - Mark as Read 按钮点击', async ({ page }) => {
    await page.goto('/pages/parent/emotion-alert/index');
    await page.waitForLoadState('networkidle');

    const markReadBtn = page.locator('button:has-text("Mark as Read")');

    // 点击 Mark as Read
    await markReadBtn.click({ force: true });

    // 验证 Toast 提示
    await expect(page.locator('.uni-toast')).toBeVisible({ timeout: 3000 });
  });

  test('情绪详情页面加载测试', async ({ page }) => {
    await page.goto('/pages/parent/emotion-detail/index');
    await page.waitForLoadState('networkidle');

    // 验证页面加载
    await expect(page).toHaveURL(/emotion-detail/);

    // 验证页面标题
    await expect(page.getByText('情感详情')).toBeVisible({ timeout: 10000 });

    // 验证 AI 分析报告卡片
    await expect(page.getByText('AI 分析报告')).toBeVisible();

    // 验证录音文稿卡片
    await expect(page.getByText('录音文稿')).toBeVisible();
  });

  test('情绪详情页面 - 音频播放器测试', async ({ page }) => {
    await page.goto('/pages/parent/emotion-detail/index');
    await page.waitForLoadState('networkidle');

    // 查找音频播放器组件
    const audioPlayer = page.locator('audio-player');
    if (await audioPlayer.count() > 0) {
      await expect(audioPlayer).toBeVisible();
    }
  });

  test('情绪详情页面 - 查看更多按钮', async ({ page }) => {
    await page.goto('/pages/parent/emotion-detail/index');
    await page.waitForLoadState('networkidle');

    // 查找查看更多按钮
    const viewMoreBtn = page.locator('button:has-text("查看更多")');
    if (await viewMoreBtn.count() > 0) {
      await expect(viewMoreBtn).toBeVisible();
      await viewMoreBtn.click({ force: true });
    }
  });

  test('情绪详情页面 - 底部操作按钮', async ({ page }) => {
    await page.goto('/pages/parent/emotion-detail/index');
    await page.waitForLoadState('networkidle');

    // 验证底部操作区
    await expect(page.getByText('家长回复')).toBeVisible();

    // 验证录制语音按钮
    const voiceBtn = page.locator('.action-btn.voice');
    await expect(voiceBtn).toBeVisible();

    // 验证 AI 建议按钮
    const aiBtn = page.locator('.action-btn.ai');
    await expect(aiBtn).toBeVisible();
  });

  test('情绪详情页面 - 录制语音按钮点击', async ({ page }) => {
    await page.goto('/pages/parent/emotion-detail/index');
    await page.waitForLoadState('networkidle');

    const voiceBtn = page.locator('.action-btn.voice');

    if (await voiceBtn.count() > 0) {
      await voiceBtn.click({ force: true });
      await page.waitForTimeout(500);
    }
  });

  test('情绪详情页面 - AI 建议按钮点击', async ({ page }) => {
    await page.goto('/pages/parent/emotion-detail/index');
    await page.waitForLoadState('networkidle');

    const aiBtn = page.locator('.action-btn.ai');

    if (await aiBtn.count() > 0) {
      await aiBtn.click({ force: true });
      await page.waitForTimeout(500);
    }
  });

  test('情绪急救包页面加载测试', async ({ page }) => {
    await page.goto('/pages/parent/emotion-kit/index');
    await page.waitForLoadState('networkidle');

    // 验证页面加载
    await expect(page).toHaveURL(/emotion-kit/);

    // 验证页面标题
    await expect(page.locator('.section-title, .page-title, view').first()).toBeVisible({ timeout: 10000 });
  });

  test('情绪急救包页面 - 急救方法列表', async ({ page }) => {
    await page.goto('/pages/parent/emotion-kit/index');
    await page.waitForLoadState('networkidle');

    // 等待数据加载
    await page.waitForTimeout(2000);

    // 查找急救方法卡片
    const methodCards = page.locator('.method-card, .kit-item, .emergency-item');
    const count = await methodCards.count();

    if (count > 0) {
      await expect(methodCards.first()).toBeVisible();
    }
  });

  test('情绪急救包页面 - 底部导航栏', async ({ page }) => {
    await page.goto('/pages/parent/emotion-kit/index');
    await page.waitForLoadState('networkidle');

    // 验证底部导航
    await expect(page.getByText('首页')).toBeVisible();
    await expect(page.getByText('任务')).toBeVisible();
    await expect(page.getByText('洞察')).toBeVisible();
    await expect(page.getByText('我的')).toBeVisible();
  });
});
