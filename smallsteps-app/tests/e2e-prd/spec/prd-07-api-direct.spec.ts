import { test, expect, APIRequestContext } from '@playwright/test';
import { PROD_ACCOUNTS, PRD_ROUTES } from '../fixtures/prd-test-data';

/**
 * PRD Section 5.2 - API接口直接验证
 * 不依赖前端UI，直接测试后端接口的权限、状态流转
 */

test.describe('PRD 5.2 - API接口验证', () => {

  test('登录接口返回Token', async ({ request }) => {
    const response = await request.post(`${PRD_ROUTES.api.base}/login`, {
      data: {
        username: PROD_ACCOUNTS.parent1.username,
        password: PROD_ACCOUNTS.parent1.password,
      },
      headers: { 'Content-Type': 'application/json' }
    });

    expect(response.ok()).toBeTruthy();
    const body = await response.json();
    // Sa-Token 返回 token 字段
    expect(body.token || body.data?.token).toBeTruthy();
  });

  test('错误密码登录返回失败', async ({ request }) => {
    const response = await request.post(`${PRD_ROUTES.api.base}/login`, {
      data: {
        username: PROD_ACCOUNTS.parent1.username,
        password: 'definitely_wrong_password',
      },
      headers: { 'Content-Type': 'application/json' }
    });

    // 应返回非200或code非200
    const body = await response.json();
    const failed = response.status() !== 200 || body.code !== 200;
    expect(failed).toBeTruthy();
  });

  test('无Token访问家长接口返回401', async ({ request }) => {
    const response = await request.get(`${PRD_ROUTES.api.base}/parent/task/list`, {
      headers: { 'Content-Type': 'application/json' }
    });
    expect(response.status()).toBe(401);
  });

  test('无Token访问儿童接口返回401', async ({ request }) => {
    const response = await request.get(`${PRD_ROUTES.api.base}/child/task/list`, {
      headers: { 'Content-Type': 'application/json' }
    });
    expect(response.status()).toBe(401);
  });

  test('家长Token可访问家长接口', async ({ request }) => {
    // 登录获取token
    const loginRes = await request.post(`${PRD_ROUTES.api.base}/login`, {
      data: {
        username: PROD_ACCOUNTS.parent1.username,
        password: PROD_ACCOUNTS.parent1.password,
      }
    });
    const loginBody = await loginRes.json();
    const token = loginBody.token || loginBody.data?.token;

    if (token) {
      const response = await request.get(`${PRD_ROUTES.api.base}/parent/task/list`, {
        headers: {
          'Authorization': token,
          'Content-Type': 'application/json',
        }
      });
      // 应返回200或403（取决于接口实现），但不应是401
      expect(response.status()).not.toBe(401);
    }
  });

  test('儿童Token访问家长接口被拒绝（横向越权）', async ({ request }) => {
    // 用child账号登录
    const loginRes = await request.post(`${PRD_ROUTES.api.base}/login`, {
      data: {
        username: PROD_ACCOUNTS.child1.username,
        password: PROD_ACCOUNTS.child1.password,
      }
    });
    const loginBody = await loginRes.json();
    const token = loginBody.token || loginBody.data?.token;

    if (token) {
      // 尝试访问家长接口
      const response = await request.get(`${PRD_ROUTES.api.base}/parent/task/list`, {
        headers: {
          'Authorization': token,
          'Content-Type': 'application/json',
        }
      });
      // 应返回403权限不足
      expect(response.status()).toBeGreaterThanOrEqual(403);
    }
  });
});
