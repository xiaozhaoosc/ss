import { defineConfig, devices } from '@playwright/test';

export default defineConfig({
  globalSetup: './global-setup.ts',
  testDir: './spec',
  fullyParallel: false,
  forbidOnly: !!process.env.CI,
  retries: 1,
  workers: 1,
  reporter: [
    ['html', { open: 'never', outputFolder: 'prd-report' }],
    ['list']
  ],
  use: {
    baseURL: 'http://10.8.0.1:8043',
    trace: 'on-first-retry',
    screenshot: 'only-on-failure',
    video: 'retain-on-failure',
    actionTimeout: 15000,
    navigationTimeout: 30000,
  },
  projects: [
    {
      name: 'parent',
      use: {
        ...devices['Desktop Chrome'],
        storageState: '.auth/parent.json'
      },
    },
    {
      name: 'child',
      use: {
        ...devices['iPhone 14'],
        storageState: '.auth/child.json'
      },
    },
    {
      name: 'admin',
      use: {
        ...devices['Desktop Chrome'],
        storageState: '.auth/admin.json'
      },
    },
    {
      name: 'api',
      use: {
        ...devices['Desktop Chrome'],
      },
    },
  ],
});
