import { test, expect } from '@playwright/test';

test.describe('ADHD 模板库 E2E 测试', () => {
  // 假设在 web (H5) 环境下运行
  test('能够访问模板库列表页', async ({ page }) => {
    await page.goto('/#/pages/template/library');
    
    // 应该显示页面或至少触发请求并展示加载中/空状态
    await expect(page.locator('text=ADHD 模板库').or(page.locator('.min-h-screen'))).toBeVisible();
  });
  
  test('能够访问详情页', async ({ page }) => {
    // 传递一个假 ID 进行测试
    await page.goto('/#/pages/template/detail?id=123');
    
    // 等待加载消失或显示内容
    await expect(page.locator('.min-h-screen')).toBeVisible();
    await expect(page.locator('text=应用此模板至今日').or(page.locator('text=加载中'))).toBeVisible();
  });
});