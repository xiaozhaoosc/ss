import { defineConfig, devices } from '@playwright/test';

/**
 * Headed (有头) 演示模式配置
 * 用途：可视化演示、录屏展示、客户演示
 * 运行：DISPLAY=:10 npx playwright test --config=playwright.config.ts
 */
export default defineConfig({
  testDir: './tests',
  fullyParallel: false,   // 顺序执行，方便演示
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
    trace: 'retain-on-failure',  // 仅失败时保留 trace
    screenshot: 'on',
    video: 'off',                 // 无 ffmpeg，关闭
    viewport: { width: 1280, height: 720 },
    channel: 'chrome',
    actionTimeout: 5000,
    navigationTimeout: 10000,
  },
  projects: [
    {
      name: 'demo-chrome',
      use: { ...devices['Desktop Chrome'], channel: 'chrome' },
    },
  ],
});
