import { test as base, Page } from '@playwright/test';
import { LoginPage } from '../pages/LoginPage';

type AuthFixtures = {
  parentPage: Page;
  adminPage: Page;
};

export const test = base.extend<AuthFixtures>({
  parentPage: async ({ browser }, use) => {
    const context = await browser.newContext();
    const page = await context.newPage();
    const loginPage = new LoginPage(page);
    await loginPage.login('ken2zhao', 'admin123');
    await use(page);
    await context.close();
  },
  adminPage: async ({ browser }, use) => {
    const context = await browser.newContext();
    const page = await context.newPage();
    const loginPage = new LoginPage(page);
    await loginPage.login('admin', 'admin123');
    await use(page);
    await context.close();
  },
});

export { expect } from '@playwright/test';
