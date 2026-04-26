import { defineConfig, devices } from '@playwright/test';

export default defineConfig({
  testDir: './tests/e2e',
  fullyParallel: true,
  forbidOnly: !!process.env.CI,
  retries: process.env.CI ? 2 : 0,
  workers: process.env.CI ? 1 : undefined,
  reporter: 'html',
  use: {
    baseURL: 'http://localhost:9090',
    trace: 'on-first-retry',
    screenshot: 'only-on-failure',
  },
  projects: [
    {
      name: 'mobile-parent',
      use: { 
        ...devices['iPhone 14'],
        baseURL: 'http://localhost:9090',
      },
    },
    {
      name: 'desktop-admin',
      use: { 
        ...devices['Desktop Chrome'],
        baseURL: 'http://localhost:88',
      },
    },
  ],
});
