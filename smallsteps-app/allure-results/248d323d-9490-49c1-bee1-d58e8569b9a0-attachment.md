# Instructions

- Following Playwright test failed.
- Explain why, be concise, respect Playwright best practices.
- Provide a snippet of code with the fix, if possible.

# Test info

- Name: pages.spec.ts >> 页面加载测试 >> 儿童成就页面应该能正常加载
- Location: tests\e2e\pages.spec.ts:12:7

# Error details

```
Error: page.goto: net::ERR_CONNECTION_REFUSED at http://localhost:5173/
Call log:
  - navigating to "http://localhost:5173/", waiting until "load"

```

# Test source

```ts
  1  | import { test, expect } from '@playwright/test';
  2  | 
  3  | // 页面路径常量
  4  | const PAGES = {
  5  |   achievements: '/#/pages/child/achievements/index',
  6  |   contract: '/#/pages/parent/contract/index',
  7  |   emotionKit: '/#/pages/parent/emotion-kit/index'
  8  | };
  9  | 
  10 | test.describe('页面加载测试', () => {
  11 |   
  12 |   test('儿童成就页面应该能正常加载', async ({ page }) => {
  13 |     // 直接访问页面（由于是 uni-app，需要等待路由初始化）
> 14 |     await page.goto('http://localhost:5173');
     |                ^ Error: page.goto: net::ERR_CONNECTION_REFUSED at http://localhost:5173/
  15 |     
  16 |     // 验证页面标题或基本元素
  17 |     await expect(page).toHaveTitle(/SmallSteps/);
  18 |   });
  19 | 
  20 |   test('亲子契约页面应该能正常加载', async ({ page }) => {
  21 |     await page.goto('http://localhost:5173');
  22 |     await expect(page).toHaveTitle(/SmallSteps/);
  23 |   });
  24 | 
  25 |   test('情绪急救包页面应该能正常加载', async ({ page }) => {
  26 |     await page.goto('http://localhost:5173');
  27 |     await expect(page).toHaveTitle(/SmallSteps/);
  28 |   });
  29 | 
  30 | });
  31 | 
  32 | test.describe('儿童成就页面功能测试', () => {
  33 |   
  34 |   test('页面应该有正确的标题', async ({ page }) => {
  35 |     // 这里我们简化测试，验证页面基本结构
  36 |     // 实际项目中应该等待路由加载并验证页面内容
  37 |     await page.goto('http://localhost:5173');
  38 |     
  39 |     // 验证应用是否正常启动
  40 |     const body = await page.locator('body');
  41 |     await expect(body).toBeVisible();
  42 |   });
  43 | 
  44 |   test('返回按钮应该存在并可点击', async ({ page }) => {
  45 |     await page.goto('http://localhost:5173');
  46 |     
  47 |     // 验证应用是否正常启动
  48 |     const body = await page.locator('body');
  49 |     await expect(body).toBeVisible();
  50 |   });
  51 | 
  52 | });
  53 | 
  54 | test.describe('亲子契约页面功能测试', () => {
  55 |   
  56 |   test('页面应该显示空状态提示', async ({ page }) => {
  57 |     await page.goto('http://localhost:5173');
  58 |     
  59 |     // 验证应用是否正常启动
  60 |     const body = await page.locator('body');
  61 |     await expect(body).toBeVisible();
  62 |   });
  63 | 
  64 |   test('添加按钮应该存在并可点击', async ({ page }) => {
  65 |     await page.goto('http://localhost:5173');
  66 |     
  67 |     // 验证应用是否正常启动
  68 |     const body = await page.locator('body');
  69 |     await expect(body).toBeVisible();
  70 |   });
  71 | 
  72 | });
  73 | 
  74 | test.describe('情绪急救包页面功能测试', () => {
  75 |   
  76 |   test('页面应该有正确的标题', async ({ page }) => {
  77 |     await page.goto('http://localhost:5173');
  78 |     
  79 |     // 验证应用是否正常启动
  80 |     const body = await page.locator('body');
  81 |     await expect(body).toBeVisible();
  82 |   });
  83 | 
  84 |   test('筛选功能应该存在', async ({ page }) => {
  85 |     await page.goto('http://localhost:5173');
  86 |     
  87 |     // 验证应用是否正常启动
  88 |     const body = await page.locator('body');
  89 |     await expect(body).toBeVisible();
  90 |   });
  91 | 
  92 | });
  93 | 
```