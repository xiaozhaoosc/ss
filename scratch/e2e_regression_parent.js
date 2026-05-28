const { chromium } = require('playwright');
const fs = require('fs');

(async () => {
  console.log('🚀 Starting regression E2E test for Small Steps parent center...');
  const browser = await chromium.launch({ headless: true });
  const context = await browser.newContext();
  const page = await context.newPage();

  // 监听所有响应
  page.on('response', async (response) => {
    const url = response.url();
    if (url.includes('/parent/family/members') || url.includes('/ss/child/list')) {
      console.log(`\n======================= [API INTERCEPTED] =======================`);
      console.log(`URL: ${url}`);
      console.log(`Status: ${response.status()}`);
      try {
        const text = await response.text();
        console.log(`Raw Response Payload:\n${text}`);
        
        // 检验是否存在超长数字精度丢失（即大整数没有带双引号）
        // 通过正则寻找例如 "userId":2059933262075191297 这种不带引号的大整数
        const badNumberMatch = text.match(/"(userId|id|parentId)":\s*(\d{15,})/);
        if (badNumberMatch) {
          console.error(`❌ [PRECISION ERROR] Found unquoted large integer: ${badNumberMatch[0]}`);
        } else {
          console.log(`✅ [SUCCESS] All target long IDs are properly quoted as Strings!`);
        }
      } catch (err) {
        console.error(`Failed to read response body: ${err.message}`);
      }
      console.log(`=================================================================\n`);
    }
  });

  try {
    console.log('Navigating to Mobile Parent Center...');
    await page.goto('http://10.8.0.1:8043/#/login', { waitUntil: 'networkidle' });
    await page.waitForTimeout(1500);

    console.log('Inputting credentials for user: admin ...');
    const inputs = page.locator('input');
    await inputs.nth(0).fill('admin');
    await inputs.nth(1).fill('gly321??gly321!!');

    // 点击登录
    await page.locator('button', { hasText: '登 录' }).click({ force: true }).catch(async () => {
      await page.locator('text=登 录').click({ force: true });
    });

    await page.waitForTimeout(3000);
    console.log(`Login attempt completed. Current URL: ${page.url()}`);

    // 进入个人中心/家长中心主页，触发接口查询
    console.log('Navigating to Parent Profile Center...');
    await page.goto('http://10.8.0.1:8043/#/pages/parent/profile/index', { waitUntil: 'networkidle' });
    await page.waitForTimeout(3000);

  } catch (error) {
    console.error(`Test script crash details: ${error.message}`);
  } finally {
    await browser.close();
    console.log('E2E regression test finished.');
  }
})();
