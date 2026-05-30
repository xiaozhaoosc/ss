import { defineConfig, devices } from '@playwright/test';

/**
 * H5 移动端测试配置 (跨平台)
 * Linux:   需要 DISPLAY=:10，用系统 Chrome
 * Windows: 直接运行，用 bundled Chromium
 */
export default defineConfig({
  testDir: './tests',
  fullyParallel: false,
  forbidOnly: true,
  retries: 0,
  workers: 1,
  timeout: 60000,
  reporter: [
    ['html', { open: 'never', outputFolder: 'playwright-report' }],
    ['list'],
  ],
  use: {
    baseURL: 'http://localhost:8043',
    headless: process.env.DISPLAY_MODE !== 'headed',
    trace: 'retain-on-failure',
    screenshot: 'on',
    video: 'off',
    viewport: { width: 375, height: 812 },
    actionTimeout: 5000,
    navigationTimeout: 10000,
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
