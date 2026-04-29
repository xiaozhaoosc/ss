import { Page, Locator } from '@playwright/test';

export class ParentDashboardPage {
  readonly page: Page;
  readonly notificationBell: Locator;
  readonly notificationDropdown: Locator;
  readonly markAllReadButton: Locator;
  readonly aiInsightCard: Locator;
  readonly dailyFocusDetailsLink: Locator;
  readonly execRecordViewAllLink: Locator;
  readonly statsContainer: Locator;
  readonly timelineContainer: Locator;

  constructor(page: Page) {
    this.page = page;
    this.notificationBell = page.locator('.icon-btn');
    this.notificationDropdown = page.locator('.notification-dropdown');
    this.markAllReadButton = page.getByText('全部已读');
    this.aiInsightCard = page.locator('ai-insight-card');
    this.dailyFocusDetailsLink = page.getByText('详情').first();
    this.execRecordViewAllLink = page.getByText('查看全部');
    this.statsContainer = page.locator('.stats-container');
    this.timelineContainer = page.locator('.timeline-container');
  }

  async goto() {
    await this.page.goto('/#/pages/parent/dashboard/index');
  }

  async waitForReady() {
    // Wait for the main content or loading indicator to resolve
    const loading = this.page.locator('.loading-container, text=加载中...');
    if (await loading.isVisible()) {
      await loading.waitFor({ state: 'detached', timeout: 15000 });
    }
    // AI card is a core part of the dashboard
    await this.aiInsightCard.waitFor({ state: 'visible', timeout: 10000 });
  }

  async toggleNotifications() {
    await this.waitForReady();
    await this.notificationBell.click();
  }

  async markAllNotificationsAsRead() {
    await this.markAllReadButton.waitFor({ state: 'visible' });
    await this.markAllReadButton.click();
  }

  async clickAiInsightCard() {
    await this.waitForReady();
    await this.aiInsightCard.click();
  }

  async goToDailyFocusDetails() {
    await this.waitForReady();
    await this.dailyFocusDetailsLink.click();
  }

  async goToExecRecord() {
    await this.waitForReady();
    await this.execRecordViewAllLink.click();
  }

  async scrollStatsHorizontally() {
    const statsScroll = this.page.locator('.stats-scroll');
    await statsScroll.waitFor({ state: 'visible' });
    // Use evaluate for more reliable scrolling than mouse moves
    await statsScroll.evaluate(el => el.scrollBy(200, 0));
  }

  async clickTimelineItem(index: number) {
    const timelineItems = this.timelineContainer.locator('.timeline-item');
    await timelineItems.nth(index).waitFor({ state: 'visible' });
    await timelineItems.nth(index).click();
  }
}
