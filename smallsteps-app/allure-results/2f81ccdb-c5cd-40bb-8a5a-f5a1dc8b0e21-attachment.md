# Instructions

- Following Playwright test failed.
- Explain why, be concise, respect Playwright best practices.
- Provide a snippet of code with the fix, if possible.

# Test info

- Name: spec\parent-profile.spec.ts >> Parent Profile Tests >> Test logout functionality
- Location: tests\e2e\spec\parent-profile.spec.ts:64:7

# Error details

```
Test timeout of 30000ms exceeded.
```

```
Error: locator.click: Test timeout of 30000ms exceeded.
Call log:
  - waiting for getByRole('button', { name: '退出登录' })

```

# Page snapshot

```yaml
- generic [ref=e3]:
  - generic [ref=e7]:
    - generic [ref=e8]:
      - generic [ref=e10]: 家长中心
      - generic [ref=e13]: CN
    - generic [ref=e17]:
      - generic [ref=e18]:
        - generic [ref=e19]:
          - generic [ref=e20]: 孩子档案
          - generic [ref=e21] [cursor=pointer]:
            - generic [ref=e22]: add
            - generic [ref=e23]: 添加
        - generic [ref=e24]:
          - generic [ref=e28]:
            - generic [ref=e29]: 小红
            - generic [ref=e30]: 7岁
          - generic [ref=e31]:
            - generic [ref=e33]: qr_code_2
            - generic [ref=e35]: edit
        - generic [ref=e36]:
          - generic [ref=e40]:
            - generic [ref=e41]: 小明
            - generic [ref=e42]: 9岁
          - generic [ref=e43]:
            - generic [ref=e45]: qr_code_2
            - generic [ref=e47]: edit
        - generic [ref=e48]:
          - generic [ref=e53]: 小明
          - generic [ref=e54]:
            - generic [ref=e56]: qr_code_2
            - generic [ref=e58]: edit
        - generic [ref=e59]:
          - generic [ref=e64]: 小红
          - generic [ref=e65]:
            - generic [ref=e67]: qr_code_2
            - generic [ref=e69]: edit
      - generic [ref=e70]:
        - generic [ref=e71]: 通用设置
        - generic [ref=e72]:
          - generic [ref=e73]:
            - generic [ref=e74]:
              - generic [ref=e76]: notifications
              - generic [ref=e77]: 通知设置
            - generic [ref=e78]: chevron_right
          - generic [ref=e79]:
            - generic [ref=e80]:
              - generic [ref=e82]: shield
              - generic [ref=e83]: 隐私政策
            - generic [ref=e84]: chevron_right
          - generic [ref=e85]:
            - generic [ref=e86]:
              - generic [ref=e88]: lock
              - generic [ref=e89]: 账号安全
            - generic [ref=e90]: chevron_right
      - generic [ref=e93]:
        - generic [ref=e94]:
          - generic [ref=e96]: help
          - generic [ref=e97]: 帮助与反馈
        - generic [ref=e98]: chevron_right
      - generic [ref=e99]:
        - generic [ref=e100] [cursor=pointer]: 退出登录
        - generic [ref=e101]: 版本号 v2.4.0 (Small Steps)
    - generic [ref=e103]:
      - generic [ref=e104] [cursor=pointer]:
        - generic [ref=e106]: 🏠
        - generic [ref=e107]: 首页
      - generic [ref=e108] [cursor=pointer]:
        - generic [ref=e110]: 📝
        - generic [ref=e111]: 任务
      - generic [ref=e112] [cursor=pointer]:
        - generic [ref=e114]: 📊
        - generic [ref=e115]: 洞察
      - generic [ref=e116] [cursor=pointer]:
        - generic [ref=e118]: 👤
        - generic [ref=e119]: 我的
  - generic [ref=e121]:
    - generic [ref=e124] [cursor=pointer]:
      - img [ref=e126]
      - generic [ref=e127]: 首页
    - generic [ref=e129] [cursor=pointer]:
      - img [ref=e131]
      - generic [ref=e132]: 任务
    - generic [ref=e134] [cursor=pointer]:
      - img [ref=e136]
      - generic [ref=e137]: 洞察
    - generic [ref=e139] [cursor=pointer]:
      - img [ref=e141]
      - generic [ref=e142]: 我的
```

# Test source

```ts
  1  | import { Page, Locator } from '@playwright/test';
  2  | 
  3  | export class ParentProfilePage {
  4  |   readonly page: Page;
  5  |   readonly addChildButton: Locator;
  6  |   readonly childrenList: Locator;
  7  |   readonly notificationSettings: Locator;
  8  |   readonly privacyPolicy: Locator;
  9  |   readonly accountSecurity: Locator;
  10 |   readonly helpAndFeedback: Locator;
  11 |   readonly logoutButton: Locator;
  12 |   readonly logoutConfirmButton: Locator;
  13 |   readonly logoutCancelButton: Locator;
  14 | 
  15 |   constructor(page: Page) {
  16 |     this.page = page;
  17 |     this.addChildButton = page.getByRole('button', { name: '添加' });
  18 |     this.childrenList = page.locator('.child-card');
  19 |     this.notificationSettings = page.getByText('通知设置');
  20 |     this.privacyPolicy = page.getByText('隐私政策');
  21 |     this.accountSecurity = page.getByText('账号安全');
  22 |     this.helpAndFeedback = page.getByText('帮助与反馈');
  23 |     this.logoutButton = page.getByRole('button', { name: '退出登录' });
  24 |     this.logoutConfirmButton = page.getByRole('button', { name: '确定' });
  25 |     this.logoutCancelButton = page.getByRole('button', { name: '取消' });
  26 |   }
  27 | 
  28 |   async goto() {
  29 |     await this.page.goto('/pages/parent/profile/index');
  30 |   }
  31 | 
  32 |   async addChild() {
  33 |     await this.addChildButton.click();
  34 |   }
  35 | 
  36 |   async editChild(index: number) {
  37 |     const childCard = this.childrenList.nth(index);
  38 |     const editButton = childCard.locator('.icon-btn.primary');
  39 |     await editButton.click();
  40 |   }
  41 | 
  42 |   async showChildQr(index: number) {
  43 |     const childCard = this.childrenList.nth(index);
  44 |     const qrButton = childCard.locator('.icon-btn').first();
  45 |     await qrButton.click();
  46 |   }
  47 | 
  48 |   async goToNotificationSettings() {
  49 |     await this.notificationSettings.click();
  50 |   }
  51 | 
  52 |   async goToPrivacyPolicy() {
  53 |     await this.privacyPolicy.click();
  54 |   }
  55 | 
  56 |   async goToAccountSecurity() {
  57 |     await this.accountSecurity.click();
  58 |   }
  59 | 
  60 |   async goToHelpAndFeedback() {
  61 |     await this.helpAndFeedback.click();
  62 |   }
  63 | 
  64 |   async logout(confirm: boolean = true) {
> 65 |     await this.logoutButton.click();
     |                             ^ Error: locator.click: Test timeout of 30000ms exceeded.
  66 |     if (confirm) {
  67 |       await this.logoutConfirmButton.click();
  68 |     } else {
  69 |       await this.logoutCancelButton.click();
  70 |     }
  71 |   }
  72 | }
  73 | 
```