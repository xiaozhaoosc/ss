const { chromium } = require('playwright');
const fs = require('fs');

const BUG_FILE = 'bug_20260427.md';
function logBug(bug) {
  const timestamp = new Date().toISOString();
  fs.appendFileSync(BUG_FILE, `- [${timestamp}] ${bug}\n`);
  console.log(`[BUG LOGGED] ${bug}`);
}

const accounts = [
  { user: 'ken2zhao', pass: 'Aa123456', role: '家长1' },
  { user: 'parent_zhang', pass: 'admin123', role: '家长2' },
  { user: 'child_xiaoming', pass: 'admin123', role: '孩子1' },
  { user: 'child_xiaohong', pass: 'admin123', role: '孩子2' }
];

(async () => {
  const browser = await chromium.launch({ headless: true });
  
  for (const account of accounts) {
    const context = await browser.newContext();
    const page = await context.newPage();
    
    const issues = [];
    page.on('response', response => {
      if (response.status() >= 400 && response.url().includes('localhost')) {
        const msg = `API Error during ${account.user} session: ${response.status()} ${response.statusText()} on ${response.url()}`;
        issues.push(msg);
        logBug(msg);
      }
    });

    page.on('pageerror', error => {
      const msg = `Console Error during ${account.user} session: ${error.message}`;
      issues.push(msg);
      logBug(msg);
    });

    try {
      console.log(`\nNavigating to login for ${account.user}...`);
      await page.goto('http://localhost:9090/#/login', { waitUntil: 'networkidle' });
      await page.waitForTimeout(2000);

      // Close any error popups like "知道了"
      let confirmBtn = page.locator('text=知道了');
      if (await confirmBtn.isVisible()) {
        await confirmBtn.click();
        await page.waitForTimeout(500);
      }

      console.log(`Logging in as ${account.user}...`);
      const inputs = page.locator('input');
      await inputs.nth(0).fill(''); // clear first
      await inputs.nth(0).fill(account.user);
      await inputs.nth(1).fill(''); // clear first
      await inputs.nth(1).fill(account.pass);
      
      await page.locator('button', { hasText: '登 录' }).click({ force: true }).catch(async () => {
        await page.locator('text=登 录').click({ force: true });
      });

      await page.waitForTimeout(3000);
      console.log(`Login attempt finished for ${account.user}. Current URL: ${page.url()}`);

      if (page.url().includes('login') || page.url() === 'http://localhost:9090/#/') {
        // Look for 500 error popup again
        confirmBtn = page.locator('text=知道了');
        if (await confirmBtn.isVisible()) {
            const errText = await page.locator('body').innerText();
            logBug(`Failed to login as ${account.user}. UI shows error popup. Page text excerpt: ${errText.substring(0, 100)}...`);
        } else {
            logBug(`Failed to login as ${account.user}. URL did not change to dashboard.`);
        }
      } else {
        console.log(`Login successful for ${account.user}! Exploring menus...`);
        // Here we would explore "家长中心" (Parent Center) and "洞察" (Insights)
        // Check if the menus are visible
        const menus = await page.locator('.sidebar-menu, .el-menu, .ant-menu, nav').innerText();
        console.log(`Menus found for ${account.user}:`, menus.substring(0, 200).replace(/\n/g, ' '));
        
        if (!menus.includes('家长中心') && account.role.includes('家长')) {
           logBug(`User ${account.user} missing menu: 家长中心`);
        }
        if (!menus.includes('洞察')) {
           logBug(`User ${account.user} missing menu: 洞察`);
        }
      }
    } catch (err) {
      console.error(`Test script crashed for ${account.user}:`, err);
      logBug(`Playwright script crashed during ${account.user}: ${err.message}`);
    } finally {
      await context.close();
    }
  }
  
  await browser.close();
  console.log('Finished testing all accounts.');
})();