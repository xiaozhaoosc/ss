import { Page, Locator } from '@playwright/test';

export class ParentInsightsPage {
  readonly page: Page;
  readonly weeklyFocusSection: Locator;
  readonly weeklyFocusDetailsLink: Locator;
  readonly abilityChart: Locator;
  readonly emotionHeatmap: Locator;
  readonly previousMonthButton: Locator;
  readonly nextMonthButton: Locator;
  readonly currentMonthText: Locator;
  readonly calendarDays: Locator;

  constructor(page: Page) {
    this.page = page;
    this.weeklyFocusSection = page.locator('.section:has-text("每周重点")');
    this.weeklyFocusDetailsLink = this.weeklyFocusSection.getByText('详情');
    this.abilityChart = page.locator('.chart-container');
    this.emotionHeatmap = page.locator('.calendar-card');
    this.previousMonthButton = this.emotionHeatmap.locator('.nav-arrow').first();
    this.nextMonthButton = this.emotionHeatmap.locator('.nav-arrow').nth(1);
    this.currentMonthText = this.emotionHeatmap.locator('.calendar-month');
    this.calendarDays = this.emotionHeatmap.locator('.day-cell');
  }

  async goto() {
    await this.page.goto('/pages/parent/insights/index');
  }

  async goToWeeklyReportDetails() {
    await this.weeklyFocusDetailsLink.click();
  }

  async changeMonth(direction: 'previous' | 'next') {
    if (direction === 'previous') {
      await this.previousMonthButton.click();
    } else {
      await this.nextMonthButton.click();
    }
  }

  async getCurrentMonth() {
    return await this.currentMonthText.textContent();
  }

  async clickCalendarDay(index: number) {
    await this.calendarDays.nth(index).click();
  }
}
