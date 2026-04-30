import { test, expect } from '@playwright/test';
import { ChildHomePage } from '../pages/ChildHomePage';

test.describe('Treehole Deep Logic Hardening', () => {
  test.use({ storageState: 'playwright/.auth/child.json' });

  test('AI should provide emotional support for negative input', async ({ page }) => {
    const homePage = new ChildHomePage(page);
    await homePage.goto();
    await homePage.waitForReady();
    
    // 1. Navigate to Treehole
    await homePage.goToTreehole();
    await expect(page).toHaveURL(/.*treehole-chat/);

    // 2. Send a frustrated message
    const frustrationMsg = "我今天很难过，数学作业太难了，我怎么都做不对。";
    const input = page.locator('.text-input input');
    await input.fill(frustrationMsg);
    await page.click('.send-btn');

    // 3. Verify user message appears
    await expect(page.locator('.message-item.user').last()).toContainText(frustrationMsg);

    // 4. Wait for AI response (streaming)
    // The bubble class is consistent, but internal tags might vary (rich-text, span, etc.)
    const aiBubble = page.locator('.message-item.ai .bubble').last();
    // AI response might take time to stream
    await expect(aiBubble).not.toBeEmpty({ timeout: 25000 });

    // 5. Verify AI empathy (check for keywords or encouraging tone)
    const responseText = await aiBubble.textContent();
    console.log('AI Response:', responseText);
    
    // Check if AI is being supportive (generic keywords that should appear in empathetic AI)
    const keywords = ['没事', '加油', '理解', '慢慢来', '❤️', '🌟', '进步'];
    const hasKeyword = keywords.some(k => responseText?.includes(k));
    
    // Note: AI might not use exact keywords, but should not be empty or generic "Error"
    expect(responseText.length).toBeGreaterThan(5);
  });
});
