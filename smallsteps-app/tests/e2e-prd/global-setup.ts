import { chromium, type FullConfig } from '@playwright/test';
import * as fs from 'fs';
import * as path from 'path';

const PROD_BASE = 'http://10.8.0.1:8043';
const API_BASE = 'http://10.8.0.1:8081/ssapi';

async function globalSetup(config: FullConfig) {
  const authDir = path.join(process.cwd(), 'tests', 'e2e-prd', '.auth');
  if (!fs.existsSync(authDir)) {
    fs.mkdirSync(authDir, { recursive: true });
  }

  const browser = await chromium.launch();

  try {
    console.log('--- PRD Global Setup: Saving auth states ---');

    // 1. Parent login via H5 app
    console.log('Logging in as parent...');
    const parentPage = await browser.newPage({ baseURL: PROD_BASE });
    await parentPage.goto('/#/pages/login/index');
    await parentPage.locator('input[type="text"]').first().fill('parent_zhang');
    await parentPage.locator('input[type="password"]').first().fill('admin123');
    await parentPage.locator('.login-btn').click();
    await parentPage.waitForURL(/.*pages\/parent\/dashboard\/index/, { timeout: 30000 });
    await parentPage.context().storageState({ path: path.join(authDir, 'parent.json') });
    await parentPage.close();
    console.log('Parent auth saved.');

    // 2. Child login via H5 app
    console.log('Logging in as child...');
    const childPage = await browser.newPage({ baseURL: PROD_BASE });
    await childPage.goto('/#/pages/login/index');
    await childPage.locator('input[type="text"]').first().fill('child_xiaoming');
    await childPage.locator('input[type="password"]').first().fill('admin123');
    await childPage.locator('.login-btn').click();
    await childPage.waitForURL(/.*pages\/child\/home\/index/, { timeout: 30000 });
    await childPage.context().storageState({ path: path.join(authDir, 'child.json') });
    await childPage.close();
    console.log('Child auth saved.');

    // 3. Admin login via admin UI
    console.log('Logging in as admin...');
    const adminPage = await browser.newPage({ baseURL: PROD_BASE });
    await adminPage.goto('/webadminss/login');
    await adminPage.waitForSelector('input[name="username"], input[type="text"]', { timeout: 15000 });
    await adminPage.locator('input[name="username"], input[type="text"]').first().fill('admin');
    await adminPage.locator('input[name="password"], input[type="password"]').first().fill('admin123');
    await adminPage.locator('button[type="submit"], .el-button--primary').first().click();
    await adminPage.waitForURL(/.*webadminss.*(index|dashboard)/, { timeout: 30000 }).catch(() => {
      // Some admin UIs redirect to root after login
      return adminPage.waitForURL(/.*webadminss/, { timeout: 10000 });
    });
    await adminPage.context().storageState({ path: path.join(authDir, 'admin.json') });
    await adminPage.close();
    console.log('Admin auth saved.');

    console.log('--- PRD Global Setup Complete ---');
  } catch (error) {
    console.error('--- PRD Global Setup Failed ---', error);
    // Create empty auth files so tests can still run (they'll fail gracefully)
    const emptyState = { cookies: [], origins: [] };
    ['parent', 'child', 'admin'].forEach(role => {
      const fp = path.join(authDir, `${role}.json`);
      if (!fs.existsSync(fp)) {
        fs.writeFileSync(fp, JSON.stringify(emptyState));
      }
    });
  } finally {
    await browser.close();
  }
}

export default globalSetup;
