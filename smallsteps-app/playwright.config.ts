import { defineConfig, devices } from '@playwright/test';

export default defineConfig({
  globalSetup: './tests/e2e/global-setup.ts',
  testDir: './tests/e2e',
  fullyParallel: true,
  forbidOnly: !!process.env.CI,
  retries: process.env.CI ? 2 : 0,
  workers: 1,
  reporter: [
    ['html', { open: 'never' }],
    ['allure-playwright', {
      detail: true,
      outputFolder: 'allure-results',
      suiteTitle: false
    }]
  ],
  use: {
    baseURL: 'http://127.0.0.1:9090',
    trace: 'on-first-retry',
    screenshot: 'only-on-failure',
    video: 'retain-on-failure',
  },
  projects: [
    {
      name: 'parent',
      use: { 
        ...devices['Desktop Chrome'],
        storageState: 'playwright/.auth/parent.json'
      },
    },
    {
      name: 'child',
      use: { 
        ...devices['iPhone 14'],
        storageState: 'playwright/.auth/child.json'
      },
    },
    {
      name: 'chromium',
      use: { ...devices['Desktop Chrome'] },
    },
    {
      name: 'mobile',
      use: { ...devices['iPhone 14'] },
    },
  ],
  // 注释掉 webServer，因为我们测试的是已经运行的服务器
  // webServer: {
  //   command: 'npm run dev:h5',
  //   url: 'http://localhost:5173',
  //   reuseExistingServer: !process.env.CI,
  //   timeout: 120000,
  // },
});
