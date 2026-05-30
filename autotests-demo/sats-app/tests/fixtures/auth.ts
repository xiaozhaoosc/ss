import { test as base, Page } from '@playwright/test';
import { AppLoginPage } from '../pages/LoginPage';

type AppAuthFixtures = {
  childPage: Page;
  parentPage: Page;
};

export const test = base.extend<AppAuthFixtures>({
  childPage: async ({ browser }, use) => {
    const context = await browser.newContext();
    const page = await context.newPage();
    const loginPage = new AppLoginPage(page);
    await loginPage.login('child_xiaoming', 'admin123');
    await use(page);
    await context.close();
  },
  parentPage: async ({ browser }, use) => {
    const context = await browser.newContext();
    const page = await context.newPage();
    const loginPage = new AppLoginPage(page);
    await loginPage.login('ken2zhao', 'Aa123456');
    await use(page);
    await context.close();
  },
});

export { expect } from '@playwright/test';
