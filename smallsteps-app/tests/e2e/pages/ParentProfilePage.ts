import { Page, Locator } from '@playwright/test';

export class ParentProfilePage {
  readonly page: Page;
  readonly addChildButton: Locator;
  readonly childrenList: Locator;
  readonly notificationSettings: Locator;
  readonly privacyPolicy: Locator;
  readonly accountSecurity: Locator;
  readonly helpAndFeedback: Locator;
  readonly logoutButton: Locator;
  readonly logoutConfirmButton: Locator;
  readonly logoutCancelButton: Locator;

  constructor(page: Page) {
    this.page = page;
    this.addChildButton = page.locator('.add-btn');
    this.childrenList = page.locator('.child-card');
    this.notificationSettings = page.getByText('通知设置');
    this.privacyPolicy = page.getByText('隐私政策');
    this.accountSecurity = page.getByText('账号安全');
    this.helpAndFeedback = page.getByText('帮助与反馈');
    this.logoutButton = page.locator('.logout-btn');
    this.logoutConfirmButton = page.getByRole('button', { name: '确定' });
    this.logoutCancelButton = page.getByRole('button', { name: '取消' });
  }

  async goto() {
    await this.page.goto('/pages/parent/profile/index');
  }

  async addChild() {
    await this.addChildButton.click();
  }

  async editChild(index: number) {
    const childCard = this.childrenList.nth(index);
    const editButton = childCard.locator('.icon-btn.primary');
    await editButton.click();
  }

  async showChildQr(index: number) {
    const childCard = this.childrenList.nth(index);
    const qrButton = childCard.locator('.icon-btn').first();
    await qrButton.click();
  }

  async goToNotificationSettings() {
    await this.notificationSettings.click();
  }

  async goToPrivacyPolicy() {
    await this.privacyPolicy.click();
  }

  async goToAccountSecurity() {
    await this.accountSecurity.click();
  }

  async goToHelpAndFeedback() {
    await this.helpAndFeedback.click();
  }

  async logout(confirm: boolean = true) {
    await this.logoutButton.click();
    if (confirm) {
      await this.logoutConfirmButton.click();
    } else {
      await this.logoutCancelButton.click();
    }
  }
}
