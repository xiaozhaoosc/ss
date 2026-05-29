import { defineConfig, devices } from '@playwright/test';

/**
 * Headed (有头) 演示模式配置 - H5 移动端
 * 用途：可视化演示移动端界面
 * 运行：DISPLAY=:10 npx playwright test --config=playwright.config.ts
 */
export default defineConfig({
  testDir: './tests',
  fullyParallel: false,
  forbidOnly: true,
  retries: 0,
  workers: 1,
  timeout: 15000,
  reporter: [
    ['html', { open: 'never', outputFolder: 'playwright-report' }],
    ['list'],
  ],
  use: {
    baseURL: 'http://10.8.0.1:8043',
    headless: false,
    trace: 'retain-on-failure',
    screenshot: 'on',
    video: 'off',
    viewport: { width: 375, height: 812 },
    channel: 'chrome',
    actionTimeout: 5000,
    navigationTimeout: 10000,
  },
  projects: [
    {
      name: 'demo-mobile-chrome',
      use: { ...devices['Pixel 5'], channel: 'chrome' },
    },
  ],
});
