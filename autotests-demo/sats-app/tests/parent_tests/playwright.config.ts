import { defineConfig, devices } from '@playwright/test';

export default defineConfig({
  globalSetup: require.resolve('./global-setup.ts'),
  testDir: './',
  testMatch: '**/*.test.ts',
  fullyParallel: false,
  forbidOnly: true,
  retries: 1,
  workers: 1,
  timeout: 45000,
  reporter: [
    ['html', { open: 'never', outputFolder: '../playwright-report-parent' }],
    ['list'],
  ],
  use: {
    baseURL: 'http://10.8.0.1:8043',
    headless: process.env.DISPLAY_MODE !== 'headed',
    trace: 'retain-on-failure',
    screenshot: 'only-on-failure',
    video: 'off',
    viewport: { width: 375, height: 812 },
    actionTimeout: 30000,
    navigationTimeout: 15000,
    ...(process.platform === 'linux' ? { channel: 'chrome' } : {}),
  },
  projects: [
    {
      name: 'mobile-chrome',
      use: {
        ...devices['Pixel 5'],
        ...(process.platform === 'linux' ? { channel: 'chrome' } : {}),
      },
    },
  ],
});
