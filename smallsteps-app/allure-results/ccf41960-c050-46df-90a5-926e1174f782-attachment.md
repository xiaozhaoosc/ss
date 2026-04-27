# Instructions

- Following Playwright test failed.
- Explain why, be concise, respect Playwright best practices.
- Provide a snippet of code with the fix, if possible.

# Test info

- Name: spec\parent-profile.spec.ts >> Parent Profile Tests >> Test child management
- Location: tests\e2e\spec\parent-profile.spec.ts:26:7

# Error details

```
Test timeout of 30000ms exceeded.
```

```
Error: locator.click: Test timeout of 30000ms exceeded.
Call log:
  - waiting for getByRole('button', { name: '添加' })

```

# Page snapshot

```yaml
- generic [active] [ref=e1]:
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
          - generic [ref=e25]: 暂无孩子档案，请点击右上角添加
        - generic [ref=e26]:
          - generic [ref=e27]: 通用设置
          - generic [ref=e28]:
            - generic [ref=e29]:
              - generic [ref=e30]:
                - generic [ref=e32]: notifications
                - generic [ref=e33]: 通知设置
              - generic [ref=e34]: chevron_right
            - generic [ref=e35]:
              - generic [ref=e36]:
                - generic [ref=e38]: shield
                - generic [ref=e39]: 隐私政策
              - generic [ref=e40]: chevron_right
            - generic [ref=e41]:
              - generic [ref=e42]:
                - generic [ref=e44]: lock
                - generic [ref=e45]: 账号安全
              - generic [ref=e46]: chevron_right
        - generic [ref=e49]:
          - generic [ref=e50]:
            - generic [ref=e52]: help
            - generic [ref=e53]: 帮助与反馈
          - generic [ref=e54]: chevron_right
        - generic [ref=e55]:
          - generic [ref=e56] [cursor=pointer]: 退出登录
          - generic [ref=e57]: 版本号 v2.4.0 (Small Steps)
      - generic [ref=e59]:
        - generic [ref=e60] [cursor=pointer]:
          - generic [ref=e62]: 🏠
          - generic [ref=e63]: 首页
        - generic [ref=e64] [cursor=pointer]:
          - generic [ref=e66]: 📝
          - generic [ref=e67]: 任务
        - generic [ref=e68] [cursor=pointer]:
          - generic [ref=e70]: 📊
          - generic [ref=e71]: 洞察
        - generic [ref=e72] [cursor=pointer]:
          - generic [ref=e74]: 👤
          - generic [ref=e75]: 我的
    - generic [ref=e77]:
      - generic [ref=e80] [cursor=pointer]:
        - img [ref=e82]
        - generic [ref=e83]: 首页
      - generic [ref=e85] [cursor=pointer]:
        - img [ref=e87]
        - generic [ref=e88]: 任务
      - generic [ref=e90] [cursor=pointer]:
        - img [ref=e92]
        - generic [ref=e93]: 洞察
      - generic [ref=e95] [cursor=pointer]:
        - img [ref=e97]
        - generic [ref=e98]: 我的
  - generic [ref=e102]:
    - strong [ref=e104]: 系统提示
    - generic [ref=e105]: "Handler dispatch failed: java.lang.Error: Unresolved compilation problems: The import com.kenzhao.smallsteps.common.mybatis cannot be resolved The method equals(Object) of type ChildTask must override or implement a supertype method The method hashCode() of type ChildTask must override or implement a supertype method BaseEntity cannot be resolved to a type"
    - generic [ref=e107] [cursor=pointer]: 知道了
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
> 33 |     await this.addChildButton.click();
     |                               ^ Error: locator.click: Test timeout of 30000ms exceeded.
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
  65 |     await this.logoutButton.click();
  66 |     if (confirm) {
  67 |       await this.logoutConfirmButton.click();
  68 |     } else {
  69 |       await this.logoutCancelButton.click();
  70 |     }
  71 |   }
  72 | }
  73 | 
```