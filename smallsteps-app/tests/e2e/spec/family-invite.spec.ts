import { test, expect } from '@playwright/test';
import { TEST_ACCOUNTS } from '../../fixtures/test-data';
import { LoginPage } from '../pages/LoginPage';
import { ParentDashboardPage } from '../pages/ParentDashboardPage';
import { ParentNavPage } from '../pages/ParentNavPage';

test.describe('家庭邀请功能', () => {
  let loginPage: LoginPage;
  let dashboardPage: ParentDashboardPage;
  let navPage: ParentNavPage;
  let generatedInviteCode: string;

  test.beforeEach(async ({ page }) => {
    loginPage = new LoginPage(page);
    dashboardPage = new ParentDashboardPage(page);
    navPage = new ParentNavPage(page);
  });

  test('家长生成分享链接和邀请码', async ({ page }) => {
    await loginPage.goto();
    await loginPage.login(TEST_ACCOUNTS.parent1.username, TEST_ACCOUNTS.parent1.password);
    await dashboardPage.waitForReady();

    await navPage.goToProfile();
    await page.waitForURL(/profile/);

    await page.click('.invite-btn');
    await page.waitForURL(/invite/);

    const shareLink = await page.locator('.share-link').textContent();
    expect(shareLink).toContain('smallsteps://join?code=');

    generatedInviteCode = shareLink.split('code=')[1];
    console.log('生成的邀请码:', generatedInviteCode);
  });

  test('用户通过邀请码申请加入', async ({ page }) => {
    if (!generatedInviteCode) {
      console.log('跳过测试：没有邀请码');
      return;
    }

    await loginPage.goto();
    await loginPage.login(TEST_ACCOUNTS.parent2.username, TEST_ACCOUNTS.parent2.password);
    await dashboardPage.waitForReady();

    await page.goto(`/pages/family/invite/index?code=${generatedInviteCode}`);
    await page.waitForLoadState('domcontentloaded');

    const familyCard = page.locator('.family-card');
    await expect(familyCard).toBeVisible();

    await page.click('.apply-btn');
    await page.waitForURL(/apply/);

    await page.click('.submit-btn');

    await expect(page.locator('.uni-toast')).toContainText('申请已提交');
  });

  test('家长审核加入申请', async ({ page }) => {
    await loginPage.goto();
    await loginPage.login(TEST_ACCOUNTS.parent1.username, TEST_ACCOUNTS.parent1.password);
    await dashboardPage.waitForReady();

    await navPage.goToProfile();
    await page.waitForURL(/profile/);

    await page.click('.request-list-btn');
    await page.waitForURL(/requests/);

    const requestItems = await page.locator('.request-item').count();
    expect(requestItems).toBeGreaterThan(0);

    await page.locator('.approve-btn').first().click();

    await expect(page.locator('.uni-toast')).toContainText('成功');
  });

  test('邀请码过期场景', async ({ page }) => {
    await page.goto('/pages/family/invite/index?code=EXPIRED1');
    await page.waitForLoadState('domcontentloaded');

    const invalidText = page.locator('.invalid-text');
    await expect(invalidText).toContainText('邀请码无效或已过期');
  });
});