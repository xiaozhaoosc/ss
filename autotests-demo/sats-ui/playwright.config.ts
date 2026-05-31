import { defineConfig, devices } from '@playwright/test';

/**
 * 管理后台 UI 测试配置 (跨平台)
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
    baseURL: 'http://10.8.0.1:8043',
    headless: process.env.DISPLAY_MODE !== 'headed',
    trace: 'retain-on-failure',
    screenshot: 'on',
    video: 'retain-on-failure',
    viewport: { width: 1280, height: 720 },
    actionTimeout: 5000,
    navigationTimeout: 10000,
    // Linux 用系统 Chrome，Windows 用 bundled Chromium
    ...(process.platform === 'linux' ? { channel: 'chrome' } : {}),
  },
  projects: [
    {
      name: 'chromium',
      use: {
        ...devices['Desktop Chrome'],
        ...(process.platform === 'linux' ? { channel: 'chrome' } : {}),
      },
    },
  ],
});
