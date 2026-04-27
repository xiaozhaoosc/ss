import { test, expect } from '@playwright/test';
test('login', async ({ page }) => { await page.goto('http://localhost:88/'); });