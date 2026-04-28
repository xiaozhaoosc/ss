import { Page, Locator } from '@playwright/test';

export class FamilyCreatePage {
  private page: Page;
  private usernameInput: Locator;
  private passwordInput: Locator;
  private nicknameInput: Locator;
  private maleOption: Locator;
  private femaleOption: Locator;
  private birthdayPicker: Locator;
  private remarkTextarea: Locator;
  private createButton: Locator;
  private toastMessage: Locator;

  constructor(page: Page) {
    this.page = page;
    this.usernameInput = page.locator('input[placeholder="设置孩子的登录账号"]');
    this.passwordInput = page.locator('input[type="password"][placeholder="设置登录密码"]');
    this.nicknameInput = page.locator('input[placeholder="孩子的昵称或小名"]');
    this.maleOption = page.locator('.gender-option:has-text("男孩")');
    this.femaleOption = page.locator('.gender-option:has-text("女孩")');
    this.birthdayPicker = page.locator('.picker-box:has-text("请选择日期")');
    this.remarkTextarea = page.locator('textarea[placeholder="例如：ADHD"]');
    this.createButton = page.locator('button:has-text("创建账号")');
    this.toastMessage = page.locator('.uni-toast-message');
  }

  async waitForLoaded() {
    await this.page.waitForLoadState('domcontentloaded');
    await this.usernameInput.waitFor({ state: 'visible' });
  }

  async fillUsername(username: string) {
    await this.usernameInput.fill(username);
  }

  async fillPassword(password: string) {
    await this.passwordInput.fill(password);
  }

  async fillNickname(nickname: string) {
    await this.nicknameInput.fill(nickname);
  }

  async selectGender(gender: 'male' | 'female') {
    if (gender === 'male') {
      await this.maleOption.click();
    } else {
      await this.femaleOption.click();
    }
  }

  async fillBirthday(birthday: string) {
    await this.birthdayPicker.click();
    await this.page.waitForTimeout(500);
    // 选择日期
    await this.page.locator(`.picker-item:has-text("${birthday}")`).click();
    await this.page.waitForTimeout(500);
  }

  async fillRemark(remark: string) {
    await this.remarkTextarea.fill(remark);
  }

  async submit() {
    await this.createButton.click();
    await this.page.waitForTimeout(1000);
  }

  async getSuccessMessage() {
    const modal = this.page.locator('.uni-modal');
    await modal.waitFor({ state: 'visible' });
    return await modal.locator('.uni-modal-content').textContent();
  }

  async getToastMessage() {
    await this.toastMessage.waitFor({ state: 'visible' });
    const message = await this.toastMessage.textContent();
    await this.toastMessage.waitFor({ state: 'hidden' });
    return message;
  }
}