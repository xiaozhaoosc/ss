import { test, expect } from '@playwright/test';
import { LoginPage } from '../pages/LoginPage';
import { ChildHomePage } from '../pages/ChildHomePage';
import { ChildTaskExecutePage } from '../pages/ChildTaskExecutePage';
import { TEST_ACCOUNTS } from '../../fixtures/test-data';

test.describe.configure({ mode: 'serial' });

test.describe('Child Task Lifecycle Tests', () => {
  test.use({ storageState: 'playwright/.auth/child.json' });

  let homePage: ChildHomePage;
  let executePage: ChildTaskExecutePage;

  test.beforeEach(async ({ page }) => {
    homePage = new ChildHomePage(page);
    executePage = new ChildTaskExecutePage(page);
    
    await homePage.goto();
    await homePage.waitForReady();
  });

  test('Child can start and complete a task', async ({ page }) => {
    // Ensure at least one task exists
    const missionCount = await homePage.missionCards.count();
    if (missionCount === 0) {
      console.warn('No missions found for child, skipping lifecycle test.');
      return;
    }

    // 1. Click first mission
    await homePage.clickMission(0);
    await expect(page).toHaveURL(/.*task-execute/, { timeout: 10000 });

    // 2. Start task
    await executePage.startTask();
    
    // 3. Complete task
    await executePage.completeTask();
    
    // 4. Collect reward (wait for overlay)
    await executePage.collectReward();
    
    // 5. Verify return to home
    await expect(page).toHaveURL(/.*child\/home/, { timeout: 10000 });
  });

  test('Navigation to other sections works', async ({ page }) => {
    await homePage.goToShop();
    await expect(page).toHaveURL(/.*reward-shop/);
    await homePage.goto();

    await homePage.goToTimeMachine();
    await expect(page).toHaveURL(/.*time-machine/);
    await homePage.goto();

    await homePage.goToTreehole();
    await expect(page).toHaveURL(/.*treehole-chat/);
  });
});
