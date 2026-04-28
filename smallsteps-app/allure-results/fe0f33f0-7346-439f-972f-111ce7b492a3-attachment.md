# Instructions

- Following Playwright test failed.
- Explain why, be concise, respect Playwright best practices.
- Provide a snippet of code with the fix, if possible.

# Test info

- Name: spec\parent-other-deep.spec.ts >> 设备配置和亲子契约页面测试 >> 亲子契约页面 - 星星数量显示
- Location: tests\e2e\spec\parent-other-deep.spec.ts:121:7

# Error details

```
Error: expect(locator).toBeVisible() failed

Locator: locator('.star-icon')
Expected: visible
Timeout: 5000ms
Error: element(s) not found

Call log:
  - Expect "toBeVisible" with timeout 5000ms
  - waiting for locator('.star-icon')

```

# Page snapshot

```yaml
- generic [ref=e4]:
  - generic [ref=e8]: 登录
  - generic [ref=e12]:
    - generic [ref=e17]:
      - generic [ref=e18]: Small Steps
      - generic [ref=e19]: 每一次进步，都值得被看见
    - generic [ref=e20]:
      - generic [ref=e21]: 欢迎回来
      - generic [ref=e22]:
        - generic [ref=e23]:
          - generic [ref=e24]: 
          - generic [ref=e26]:
            - generic: 账号
            - textbox [ref=e27]
        - generic [ref=e28]:
          - generic [ref=e29]: 
          - generic [ref=e31]:
            - generic: 密码
            - textbox [ref=e32]
      - generic [ref=e34] [cursor=pointer]:
        - generic [ref=e35]: 
        - generic [ref=e38]: 记住密码
      - generic [ref=e39]:
        - generic [ref=e40] [cursor=pointer]: 登 录
        - generic [ref=e41]:
          - generic [ref=e42]: 注册账号
          - generic [ref=e43]: "|"
          - generic [ref=e44]: 忘记密码?
    - generic [ref=e46]:
      - generic [ref=e47]: 登录即代表同意
      - generic [ref=e48]: 《用户协议》
      - generic [ref=e49]: "&"
      - generic [ref=e50]: 《隐私协议》
```

# Test source

```ts
  26  |     await expect(page.getByText('ESP32相关功能已临时关闭，敬请期待')).toBeVisible();
  27  |   });
  28  | 
  29  |   test('设备配置页面 - 返回按钮', async ({ page }) => {
  30  |     await page.goto('/pages/parent/device-config/index');
  31  |     await page.waitForLoadState('networkidle');
  32  | 
  33  |     // 查找返回按钮
  34  |     const backBtn = page.locator('.btn-primary, .back-btn, button:has-text("返回")');
  35  | 
  36  |     if (await backBtn.count() > 0) {
  37  |       await expect(backBtn.first()).toBeVisible();
  38  |     }
  39  |   });
  40  | 
  41  |   test('亲子契约页面加载测试', async ({ page }) => {
  42  |     await page.goto('/pages/parent/contract/index');
  43  |     await page.waitForLoadState('networkidle');
  44  | 
  45  |     // 验证页面加载
  46  |     await expect(page).toHaveURL(/contract/);
  47  | 
  48  |     // 验证页面标题
  49  |     await expect(page.getByText('星空契约')).toBeVisible({ timeout: 10000 });
  50  | 
  51  |     // 验证星星数量
  52  |     await expect(page.locator('.star-count')).toBeVisible();
  53  |   });
  54  | 
  55  |   test('亲子契约页面 - 待处理兑换区域', async ({ page }) => {
  56  |     await page.goto('/pages/parent/contract/index');
  57  |     await page.waitForLoadState('networkidle');
  58  | 
  59  |     // 验证待处理兑换标题
  60  |     await expect(page.getByText('待处理兑换')).toBeVisible();
  61  | 
  62  |     // 等待数据加载
  63  |     await page.waitForTimeout(2000);
  64  | 
  65  |     // 检查是否有待处理项
  66  |     const pendingSection = page.locator('.empty-mini, .card-list');
  67  |     await expect(pendingSection.first()).toBeVisible();
  68  |   });
  69  | 
  70  |   test('亲子契约页面 - 活跃契约区域', async ({ page }) => {
  71  |     await page.goto('/pages/parent/contract/index');
  72  |     await page.waitForLoadState('networkidle');
  73  | 
  74  |     // 验证活跃契约标题
  75  |     await expect(page.getByText('活跃契约')).toBeVisible();
  76  | 
  77  |     // 等待数据加载
  78  |     await page.waitForTimeout(2000);
  79  | 
  80  |     // 检查是否有契约卡片
  81  |     const contractCard = page.locator('.contract-card');
  82  |     if (await contractCard.count() > 0) {
  83  |       await expect(contractCard).toBeVisible();
  84  |     }
  85  |   });
  86  | 
  87  |   test('亲子契约页面 - 契约卡片内容', async ({ page }) => {
  88  |     await page.goto('/pages/parent/contract/index');
  89  |     await page.waitForLoadState('networkidle');
  90  | 
  91  |     // 等待数据加载
  92  |     await page.waitForTimeout(2000);
  93  | 
  94  |     // 查找契约类型
  95  |     const contractType = page.getByText('每日动力');
  96  |     if (await contractType.count() > 0) {
  97  |       await expect(contractType).toBeVisible();
  98  |     }
  99  | 
  100 |     // 查找契约状态
  101 |     const contractStatus = page.getByText('进行中');
  102 |     if (await contractStatus.count() > 0) {
  103 |       await expect(contractStatus).toBeVisible();
  104 |     }
  105 |   });
  106 | 
  107 |   test('亲子契约页面 - 进度条', async ({ page }) => {
  108 |     await page.goto('/pages/parent/contract/index');
  109 |     await page.waitForLoadState('networkidle');
  110 | 
  111 |     // 等待数据加载
  112 |     await page.waitForTimeout(2000);
  113 | 
  114 |     // 查找进度条
  115 |     const progressBar = page.locator('.progress-bar');
  116 |     if (await progressBar.count() > 0) {
  117 |       await expect(progressBar).toBeVisible();
  118 |     }
  119 |   });
  120 | 
  121 |   test('亲子契约页面 - 星星数量显示', async ({ page }) => {
  122 |     await page.goto('/pages/parent/contract/index');
  123 |     await page.waitForLoadState('networkidle');
  124 | 
  125 |     // 验证星星图标
> 126 |     await expect(page.locator('.star-icon')).toBeVisible();
      |                                              ^ Error: expect(locator).toBeVisible() failed
  127 | 
  128 |     // 验证星星数量
  129 |     await expect(page.locator('.count')).toBeVisible();
  130 |   });
  131 | });
  132 | 
```