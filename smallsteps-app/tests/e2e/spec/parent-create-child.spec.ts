import { test, expect } from '@playwright/test';
import { TEST_ACCOUNTS } from '../../fixtures/test-data';
import { LoginPage } from '../pages/LoginPage';
import { ParentDashboardPage } from '../pages/ParentDashboardPage';
import { ParentProfilePage } from '../pages/ParentProfilePage';
import { FamilyCreatePage } from '../pages/FamilyCreatePage';

test.describe('家长创建儿童账号流程', () => {
  let loginPage: LoginPage;
  let dashboardPage: ParentDashboardPage;
  let profilePage: ParentProfilePage;
  let familyCreatePage: FamilyCreatePage;

  const childUsername = `child_test_${Date.now().toString().slice(-6)}`;
  const childPassword = 'Aa123456';
  const childNickname = '测试小朋友';

  test.beforeEach(async ({ page }) => {
    loginPage = new LoginPage(page);
    dashboardPage = new ParentDashboardPage(page);
    profilePage = new ParentProfilePage(page);
    familyCreatePage = new FamilyCreatePage(page);

    // 登录家长账号
    await loginPage.goto();
    await loginPage.login(TEST_ACCOUNTS.parent1.username, TEST_ACCOUNTS.parent1.password);
    await dashboardPage.waitForReady();
  });

  test('家长创建儿童账号 - 完整流程', async ({ page }) => {
    // 1. 导航到个人中心
    await page.goto('/pages/parent/profile/index');
    await page.waitForLoadState('domcontentloaded');

    // 2. 点击添加孩子按钮
    await profilePage.addChild();

    // 3. 填写创建表单
    await familyCreatePage.waitForLoaded();
    await familyCreatePage.fillUsername(childUsername);
    await familyCreatePage.fillPassword(childPassword);
    await familyCreatePage.fillNickname(childNickname);
    await familyCreatePage.selectGender('male');
    await familyCreatePage.fillBirthday('2018-06-15');
    await familyCreatePage.fillRemark('测试孩子账号，用于自动化测试');

    // 4. 提交创建
    await familyCreatePage.submit();

    // 5. 验证创建成功提示
    const successMessage = await familyCreatePage.getSuccessMessage();
    expect(successMessage).toContain('创建成功');

    // 6. 返回个人中心页面
    await page.goBack();
    await page.waitForLoadState('domcontentloaded');

    // 7. 验证新创建的孩子已显示在列表中
    const childCards = await profilePage.childrenList.allTextContents();
    expect(childCards.join('')).toContain(childNickname);
  });

  test('家长创建儿童账号 - 必填字段校验', async ({ page }) => {
    // 导航到个人中心
    await page.goto('/pages/parent/profile/index');
    await page.waitForLoadState('domcontentloaded');

    // 点击添加孩子按钮
    await profilePage.addChild();

    // 等待页面加载
    await familyCreatePage.waitForLoaded();

    // 直接点击提交（不填任何信息）
    await familyCreatePage.submit();

    // 验证提示信息
    const toastMessage = await familyCreatePage.getToastMessage();
    expect(toastMessage).toContain('请输入账号');
  });

  test('家长创建儿童账号 - 密码长度校验', async ({ page }) => {
    // 导航到个人中心
    await page.goto('/pages/parent/profile/index');
    await page.waitForLoadState('domcontentloaded');

    // 点击添加孩子按钮
    await profilePage.addChild();

    // 等待页面加载
    await familyCreatePage.waitForLoaded();

    // 填写账号和短密码
    await familyCreatePage.fillUsername('testchild');
    await familyCreatePage.fillPassword('123'); // 密码太短

    // 点击提交
    await familyCreatePage.submit();

    // 验证密码长度提示
    const toastMessage = await familyCreatePage.getToastMessage();
    expect(toastMessage).toContain('密码至少6位');
  });

  test('儿童账号登录验证', async ({ page }) => {
    // 使用新创建的儿童账号登录
    await profilePage.logout();
    await loginPage.goto();
    
    // 尝试使用儿童账号登录
    await loginPage.login(childUsername, childPassword);
    
    // 验证登录成功（检查是否跳转到儿童端首页）
    await page.waitForLoadState('domcontentloaded');
    expect(page.url()).toContain('/pages/child');
  });
});