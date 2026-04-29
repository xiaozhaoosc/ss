import { Page, Locator } from '@playwright/test';

export class ChildHomePage {
  readonly page: Page;
  readonly starBalance: Locator;
  readonly shopTab: Locator;
  readonly timeMachineTab: Locator;
  readonly treeholeTab: Locator;
  readonly missionCards: Locator;

  constructor(page: Page) {
    this.page = page;
    this.starBalance = page.locator('.streak-val');
    this.shopTab = page.locator('text=Shop');
    this.timeMachineTab = page.locator('text=Time');
    this.treeholeTab = page.locator('text=点我聊天吧！');
    this.missionCards = page.locator('.mission-card');
  }

  async goto() {
    await this.page.goto('/#/pages/child/home/index');
  }

  async waitForReady() {
    await this.page.locator('.loading-container, text=加载中...').waitFor({ state: 'detached', timeout: 15000 }).catch(() => {});
    await this.missionCards.first().waitFor({ state: 'visible', timeout: 10000 }).catch(() => {});
  }

  async clickMission(index: number) {
    await this.missionCards.nth(index).click();
  }

  async goToShop() {
    await this.shopTab.click();
  }

  async goToTimeMachine() {
    await this.timeMachineTab.click();
  }

  async goToTreehole() {
    await this.treeholeTab.click({ force: true });
  }
}
