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
    await this.page.goto('/pages/parent/dashboard/index');
  }

  async waitForReady() {
    await this.page.locator('.loading-container, text=加载中...').waitFor({ state: 'detached', timeout: 20000 }).catch(() => {});
    // AI 卡片可能是动态加载的
    await this.aiInsightCard.waitFor({ state: 'attached', timeout: 10000 }).catch(() => {});
  }

  async toggleNotifications() {
    await this.waitForReady();
    await this.notificationBell.waitFor({ state: 'visible' });
    await this.notificationBell.click({ force: true });
  }

  async markAllNotificationsAsRead() {
    await this.markAllReadButton.waitFor({ state: 'visible' });
    await this.markAllReadButton.click({ force: true });
  }

  async clickAiInsightCard() {
    await this.waitForReady();
    await this.aiInsightCard.waitFor({ state: 'visible' });
    await this.aiInsightCard.click({ force: true });
  }

  async goToDailyFocusDetails() {
    await this.waitForReady();
    await this.dailyFocusDetailsLink.waitFor({ state: 'visible' });
    await this.dailyFocusDetailsLink.click({ force: true });
  }

  async goToExecRecord() {
    await this.waitForReady();
    await this.execRecordViewAllLink.waitFor({ state: 'visible' });
    await this.execRecordViewAllLink.click({ force: true });
  }

  async scrollStatsHorizontally() {
    const statsScroll = this.page.locator('.stats-scroll');
    await statsScroll.hover();
    await this.page.mouse.move(100, 0);
    await this.page.mouse.down();
    await this.page.mouse.move(300, 0);
    await this.page.mouse.up();
  }

  async clickTimelineItem(index: number) {
    const timelineItems = this.timelineContainer.locator('timeline-item');
    await timelineItems.nth(index).click();
  }
}
