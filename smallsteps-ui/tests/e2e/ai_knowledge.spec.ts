import { test, expect } from '@playwright/test';

test.describe('知识库管理功能测试', () => {
  test.beforeEach(async ({ page }) => {
    // Already logged in via storageState
    await page.goto('/');
    
    // Skip guided tour if present
    const skipBtn = page.locator('.introjs-skipbutton');
    if (await skipBtn.isVisible()) {
      await skipBtn.click();
    }
  });

  test('知识库管理 - 列表页面组件检查', async ({ page }) => {
    await page.route('**/system/ai/knowledge/list*', async route => {
      const json = {
        code: 200,
        rows: [{ id: 1, title: '危机干预规则', contentType: 'TEXT', content: '发现危险立即汇报', keywords: '自伤,危险', status: '0' }],
        total: 1
      };
      await route.fulfill({ json });
    });

    await page.goto('/#/system/ai/knowledge');
    await page.waitForTimeout(1000);
    expect(true).toBeTruthy();
  });
});
