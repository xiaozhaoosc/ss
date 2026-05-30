import { defineConfig, devices } from '@playwright/test';

export default defineConfig({
  testDir: '.',
  fullyParallel: false,
  forbidOnly: true,
  retries: 0,
  workers: 1,
  timeout: 45000,
  reporter: [['list']],
  use: {
    baseURL: 'http://localhost:9090',
    headless: process.env.DISPLAY_MODE !== 'headed',
    screenshot: 'only-on-failure',
    trace: 'retain-on-failure',
    viewport: { width: 393, height: 727 },
    ...(process.platform === 'linux' ? { channel: 'chrome' } : {}),
  },
  projects: [
    {
      name: 'mobile-chrome',
      use: { ...devices['Pixel 5'] },
    },
  ],
});
