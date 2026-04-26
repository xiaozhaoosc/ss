import { test, expect, Page } from '@playwright/test';

const MOBILE_URL = 'http://localhost:9090';

const ACCOUNTS = {
  parent: { user: 'ken2zhao', pass: 'Aa123456' },
  child: { user: 'child_xiaoming', pass: 'admin123' },
};

async function setupAutoCloseModal(page: Page) {
  await page.evaluate(() => {
    setInterval(() => {
      const modal = document.querySelector('uni-modal');
      if (modal) {
        const btn = Array.from(modal.querySelectorAll('.uni-modal__btn')).find(el => 
          el.textContent?.includes('知道了') || el.textContent?.includes('确定')
        ) as HTMLElement;
        if (btn) {
          btn.click();
        }
      }
    }, 500);
  });
}

test.describe('Mobile App Comprehensive Testing (9090)', () => {
  
  test.beforeEach(async ({ page }) => {
    await page.goto('/');
    await page.evaluate(() => {
      localStorage.clear();
      sessionStorage.clear();
    });
    await page.reload();
    await setupAutoCloseModal(page);
  });

  test('Parent Role: Detailed Verification', async ({ page }) => {
    test.skip(test.info().project.name !== 'mobile-parent');
    
    // Login
    await page.fill('input[type="text"]', ACCOUNTS.parent.user);
    await page.fill('input[type="password"]', ACCOUNTS.parent.pass);
    await page.click('text=登 录');
    
    await expect(page).toHaveURL(/.*dashboard/);
    await page.waitForTimeout(2000);
    
    // 1. Task Creator Sub-pages
    await page.click('.uni-tabbar__item >> text=任务', { force: true });
    await expect(page).toHaveURL(/.*task-creator/);
    
    // Click "创建任务" button
    const createBtn = page.locator('text=创建任务');
    await createBtn.click({ force: true });
    // This might open a new page or a modal. 
    // Usually it goes to /pages/parent/task-creator/form (deduced)
    await page.waitForTimeout(1000);
    
    // 2. Insights
    await page.click('.uni-tabbar__item >> text=洞察', { force: true });
    await expect(page).toHaveURL(/.*insights/);
    
    // 3. Profile
    await page.click('.uni-tabbar__item >> text=我的', { force: true });
    await expect(page).toHaveURL(/.*profile/);
    await expect(page.locator('text=设置')).toBeVisible();
  });

  test('Child Role: Detailed Verification', async ({ page }) => {
    test.skip(test.info().project.name !== 'mobile-parent');

    // Login
    await page.fill('input[type="text"]', ACCOUNTS.child.user);
    await page.fill('input[type="password"]', ACCOUNTS.child.pass);
    await page.click('text=登 录');

    await expect(page).toHaveURL(/.*child\/home/);
    
    // 1. Shop and its items
    await page.click('text=Shop', { force: true });
    await expect(page).toHaveURL(/.*reward-shop/);
    await expect(page.locator('text=我的勋章')).toBeVisible();
    await page.goto('/#/pages/child/home/index');
    
    // 2. Time Machine interaction
    await page.click('text=Time', { force: true });
    await expect(page).toHaveURL(/.*time-machine/);
    await expect(page.locator('text=给未来的信')).toBeVisible();
    await page.goto('/#/pages/child/home/index');
    
    // 3. Treehole Chat interaction
    await page.click('text=点我聊天吧！', { force: true });
    await expect(page).toHaveURL(/.*treehole-chat/);
    const input = page.locator('input[placeholder*="想对我说什么"]');
    if (await input.count() > 0) {
        await input.fill('你好，小步');
        await page.keyboard.press('Enter');
    }
  });
});
