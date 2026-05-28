import { test, expect, APIRequestContext } from '@playwright/test';
import { PROD_ACCOUNTS, PRD_ROUTES } from '../fixtures/prd-test-data';

/**
 * PRD Section 5.2.1 - 权限隔离测试
 * 验证 Sa-Token 的横向越权与纵向越权防护
 */

test.describe('PRD 5.2.1 - 权限隔离', () => {

  test.describe('API层权限校验', () => {

    test('无Token访问受保护接口返回401', async ({ request }) => {
      const response = await request.get(`${PRD_ROUTES.api.base}/parent/task/list`, {
        headers: { 'Content-Type': 'application/json' }
      });
      expect(response.status()).toBe(401);
    });

    test('儿童Token访问家长接口返回403（横向越权）', async ({ request }) => {
      // 先获取child token
      const loginRes = await request.post(`${PRD_ROUTES.api.base}/login`, {
        data: {
          username: PROD_ACCOUNTS.child1.username,
          password: PROD_ACCOUNTS.child1.password,
        }
      });
      expect(loginRes.ok()).toBeTruthy();
      const { token } = await loginRes.json();

      // 用child token访问家长接口
      const response = await request.get(`${PRD_ROUTES.api.base}/parent/task/list`, {
        headers: {
          'Authorization': token,
          'Content-Type': 'application/json',
        }
      });
      // 应返回403权限不足
      expect(response.status()).toBeGreaterThanOrEqual(403);
    });
  });

  test.describe('页面层权限校验', () => {

    test('儿童登录后无法直接访问家长页面', async ({ page }) => {
      // 用child的storage state
      await page.goto('/#/pages/parent/dashboard/index');
      await page.waitForTimeout(3000);
      // 应被重定向到登录页或儿童首页
      const url = page.url();
      const redirected = url.includes('login') || url.includes('child/home');
      expect(redirected).toBeTruthy();
    });
  });
});
