# Instructions

- Following Playwright test failed.
- Explain why, be concise, respect Playwright best practices.
- Provide a snippet of code with the fix, if possible.

# Test info

- Name: e2e\comprehensive_test.spec.ts >> Mobile App Comprehensive Testing (9090) >> Parent Role: Detailed Verification
- Location: e2e\comprehensive_test.spec.ts:38:7

# Error details

```
Error: page.goto: Protocol error (Page.navigate): Cannot navigate to invalid URL
Call log:
  - navigating to "/", waiting until "load"

```

# Test source

```ts
  1   | import { test, expect, Page } from '@playwright/test';
  2   | 
  3   | const MOBILE_URL = 'http://localhost:9090';
  4   | 
  5   | const ACCOUNTS = {
  6   |   parent: { user: 'ken2zhao', pass: 'admin123' },
  7   |   child: { user: 'child_xiaoming', pass: 'admin123' },
  8   | };
  9   | 
  10  | async function setupAutoCloseModal(page: Page) {
  11  |   await page.evaluate(() => {
  12  |     setInterval(() => {
  13  |       const modal = document.querySelector('uni-modal');
  14  |       if (modal) {
  15  |         const btn = Array.from(modal.querySelectorAll('.uni-modal__btn')).find(el => 
  16  |           el.textContent?.includes('知道了') || el.textContent?.includes('确定')
  17  |         ) as HTMLElement;
  18  |         if (btn) {
  19  |           btn.click();
  20  |         }
  21  |       }
  22  |     }, 500);
  23  |   });
  24  | }
  25  | 
  26  | test.describe('Mobile App Comprehensive Testing (9090)', () => {
  27  |   
  28  |   test.beforeEach(async ({ page }) => {
> 29  |     await page.goto('/');
      |                ^ Error: page.goto: Protocol error (Page.navigate): Cannot navigate to invalid URL
  30  |     await page.evaluate(() => {
  31  |       localStorage.clear();
  32  |       sessionStorage.clear();
  33  |     });
  34  |     await page.reload();
  35  |     await setupAutoCloseModal(page);
  36  |   });
  37  | 
  38  |   test('Parent Role: Detailed Verification', async ({ page }) => {
  39  |     test.skip(test.info().project.name !== 'mobile-parent');
  40  |     
  41  |     // Login
  42  |     await page.fill('input[type="text"]', ACCOUNTS.parent.user);
  43  |     await page.fill('input[type="password"]', ACCOUNTS.parent.pass);
  44  |     await page.click('text=登 录');
  45  |     
  46  |     await expect(page).toHaveURL(/.*dashboard/);
  47  |     await page.waitForTimeout(2000);
  48  |     
  49  |     // 1. Task Creator Sub-pages
  50  |     await page.click('.uni-tabbar__item >> text=任务', { force: true });
  51  |     await expect(page).toHaveURL(/.*task-creator/);
  52  |     
  53  |     // Click "创建任务" button
  54  |     const createBtn = page.locator('text=创建任务');
  55  |     await createBtn.click({ force: true });
  56  |     // This might open a new page or a modal. 
  57  |     // Usually it goes to /pages/parent/task-creator/form (deduced)
  58  |     await page.waitForTimeout(1000);
  59  |     
  60  |     // 2. Insights
  61  |     await page.click('.uni-tabbar__item >> text=洞察', { force: true });
  62  |     await expect(page).toHaveURL(/.*insights/);
  63  |     
  64  |     // 3. Profile
  65  |     await page.click('.uni-tabbar__item >> text=我的', { force: true });
  66  |     await expect(page).toHaveURL(/.*profile/);
  67  |     await expect(page.locator('text=设置')).toBeVisible();
  68  |   });
  69  | 
  70  |   test('Child Role: Detailed Verification', async ({ page }) => {
  71  |     test.skip(test.info().project.name !== 'mobile-parent');
  72  | 
  73  |     // Login
  74  |     await page.fill('input[type="text"]', ACCOUNTS.child.user);
  75  |     await page.fill('input[type="password"]', ACCOUNTS.child.pass);
  76  |     await page.click('text=登 录');
  77  | 
  78  |     await expect(page).toHaveURL(/.*child\/home/);
  79  |     
  80  |     // 1. Shop and its items
  81  |     await page.click('text=Shop', { force: true });
  82  |     await expect(page).toHaveURL(/.*reward-shop/);
  83  |     await expect(page.locator('text=我的勋章')).toBeVisible();
  84  |     await page.goto('/#/pages/child/home/index');
  85  |     
  86  |     // 2. Time Machine interaction
  87  |     await page.click('text=Time', { force: true });
  88  |     await expect(page).toHaveURL(/.*time-machine/);
  89  |     await expect(page.locator('text=给未来的信')).toBeVisible();
  90  |     await page.goto('/#/pages/child/home/index');
  91  |     
  92  |     // 3. Treehole Chat interaction
  93  |     await page.click('text=点我聊天吧！', { force: true });
  94  |     await expect(page).toHaveURL(/.*treehole-chat/);
  95  |     const input = page.locator('input[placeholder*="想对我说什么"]');
  96  |     if (await input.count() > 0) {
  97  |         await input.fill('你好，小步');
  98  |         await page.keyboard.press('Enter');
  99  |     }
  100 |   });
  101 | });
  102 | 
```