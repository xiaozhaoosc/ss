const { chromium } = require('playwright');

(async () => {
  const browser = await chromium.launch({ headless: true });
  const page = await browser.newPage();
  await page.goto('http://localhost:9090/#/login', { waitUntil: 'networkidle' });
  
  // wait for something to load
  await page.waitForTimeout(2000);
  
  const tree = await page.locator('body').ariaSnapshot();
  console.log(tree);
  
  await browser.close();
})();
