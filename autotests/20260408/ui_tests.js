const path = require('path');
module.paths.push(path.resolve(__dirname, '../../smallsteps-app/node_modules'));
const { chromium } = require('@playwright/test');

async function runTests() {
  const browser = await chromium.launch({ headless: true });
  const context = await browser.newContext({
    viewport: { width: 1280, height: 720 }
  });
  const page = await context.newPage();

  const screenshotDir = path.resolve(__dirname, 'tests/imgs');

  try {
    // 1. UI (Web Admin) Test
    const uiUrl = 'http://localhost:8080/webadminss/login?redirect=%252Fdashboard';
    console.log(`Navigating to UI: ${uiUrl}`);
    await page.goto(uiUrl, { waitUntil: 'networkidle' });
    await page.screenshot({ path: path.join(screenshotDir, 'ui_login_page.png') });
    console.log('Saved screenshot: ui_login_page.png');

    // 2. App (H5) Test
    const h5Url = 'http://localhost:8082/#/';
    console.log(`Navigating to App H5: ${h5Url}`);
    await page.goto(h5Url, { waitUntil: 'networkidle' });
    await page.screenshot({ path: path.join(screenshotDir, 'app_h5_home.png') });
    console.log('Saved screenshot: app_h5_home.png');

    console.log('UI Tests completed successfully.');
  } catch (error) {
    console.error('An error occurred during UI testing:', error);
  } finally {
    await browser.close();
  }
}

runTests();
