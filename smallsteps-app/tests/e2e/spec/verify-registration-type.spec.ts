import { test, expect } from '@playwright/test';

test.describe('Registration UserType Verification', () => {
  test('should pass userType=1 when registering a new parent account', async ({ page }) => {
    // 1. 监听控制台日志
    let detectedUserType = '';
    page.on('console', msg => {
      if (msg.text().includes('[DEBUG] Registering user with type:')) {
        detectedUserType = msg.text().split(':').pop()?.trim() || '';
      }
    });

    // 2. 拦截并 Mock 注册接口，防止真实创建账号导致冲突
    await page.route('**/auth/register', async route => {
      await route.fulfill({
        status: 200,
        contentType: 'application/json',
        body: JSON.stringify({ code: 200, msg: '注册成功' })
      });
    });

    // 3. 导航到注册页面
    await page.goto('/#/pages/register/index');

    // 4. 填写表单
    const randomSuffix = Math.floor(Math.random() * 10000);
    await page.locator('input[placeholder="设置账号"]').fill(`test_parent_${randomSuffix}`);
    await page.locator('input[placeholder="设置密码"]').fill('password123');
    await page.locator('input[placeholder="确认密码"]').fill('password123');

    // 5. 点击注册
    await page.getByRole('button', { name: '立即注册' }).click();

    // 6. 验证日志中的 userType 是否为 1
    // 给一点时间让日志产生
    await page.waitForTimeout(1000);
    
    console.log('Detected UserType in log:', detectedUserType);
    expect(detectedUserType).toBe('1');
  });
});
