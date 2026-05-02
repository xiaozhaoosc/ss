import { test, expect } from '@playwright/test';
import { TEST_ACCOUNTS } from '../../fixtures/test-data';
import { LoginPage } from '../pages/LoginPage';
import { ParentDashboardPage } from '../pages/ParentDashboardPage';
import { ParentProfilePage } from '../pages/ParentProfilePage';
import { ParentNavPage } from '../pages/ParentNavPage';

test.describe('家长创建/绑定儿童账号流程', () => {
  let loginPage: LoginPage;
  let dashboardPage: ParentDashboardPage;
  let profilePage: ParentProfilePage;
  let navPage: ParentNavPage;

  test.beforeEach(async ({ page }) => {
    loginPage = new LoginPage(page);
    dashboardPage = new ParentDashboardPage(page);
    profilePage = new ParentProfilePage(page);
    navPage = new ParentNavPage(page);

    // 使用 storageState 自动登录，直接跳转到家长首页
    await page.goto('/#/pages/parent/dashboard/index');
    await dashboardPage.waitForReady();
  });

  test('家长绑定儿童账号 - 完整流程', async ({ page }) => {
    // 1. 通过底部导航进入个人中心
    await navPage.goToProfile();
    await page.waitForURL(/profile/);

    // 2. 点击添加孩子按钮（绑定孩子档案）
    await profilePage.addChild();
    
    // 3. 验证跳转到绑定页面
    await expect(page).toHaveURL(/bind/);
    
    // 4. 返回个人中心
    await page.goBack();
    await page.waitForURL(/profile/);
  });

  test('家长管理孩子列表', async ({ page }) => {
    // 1. 通过底部导航进入个人中心
    await navPage.goToProfile();
    await page.waitForURL(/profile/);

    // 2. 检查孩子列表
    const childrenCount = await profilePage.childrenList.count();
    console.log(`当前孩子数量: ${childrenCount}`);

    // 3. 如果有孩子，测试编辑功能
    if (childrenCount > 0) {
      await profilePage.editChild(0);
      await expect(page).toHaveURL(/edit/);
      await page.goBack();
      await page.waitForURL(/profile/);
    }
  });

  test('家长切换账号测试', async ({ page }) => {
    // 1. 通过底部导航进入个人中心
    await navPage.goToProfile();
    await page.waitForURL(/profile/);

    // 2. 返回首页
    await navPage.goToHome();
    await expect(page).toHaveURL(/dashboard/);
  });
});