# Instructions

- Following Playwright test failed.
- Explain why, be concise, respect Playwright best practices.
- Provide a snippet of code with the fix, if possible.

# Test info

- Name: spec\parent-reward-deep.spec.ts >> 奖励相关页面深度测试 >> 奖励配置页面 - 底部导航栏
- Location: tests\e2e\spec\parent-reward-deep.spec.ts:102:7

# Error details

```
Error: expect(locator).toBeVisible() failed

Locator:  getByText('首页')
Expected: visible
Received: hidden
Timeout:  5000ms

Call log:
  - Expect "toBeVisible" with timeout 5000ms
  - waiting for getByText('首页')
    9 × locator resolved to <div class="uni-tabbar__label">首页</div>
      - unexpected value "hidden"

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
  7   | 
  8   |   test.beforeEach(async ({ page }) => {
  9   |     loginPage = new LoginPage(page);
  10  |     await loginPage.goto();
  11  |     await loginPage.login(TEST_ACCOUNTS.parent1.username, TEST_ACCOUNTS.parent1.password);
  12  |   });
  13  | 
  14  |   test('奖励配置页面加载测试', async ({ page }) => {
  15  |     await page.goto('/pages/parent/reward-config/index');
  16  |     await page.waitForLoadState('networkidle');
  17  | 
  18  |     // 验证页面加载
  19  |     await expect(page).toHaveURL(/reward-config/);
  20  | 
  21  |     // 验证页面标题
  22  |     await expect(page.getByText('奖励设置')).toBeVisible({ timeout: 10000 });
  23  | 
  24  |     // 验证待处理请求区域
  25  |     await expect(page.getByText('待处理请求')).toBeVisible();
  26  | 
  27  |     // 验证 Tab 切换
  28  |     await expect(page.getByText('配置奖励')).toBeVisible();
  29  |     await expect(page.getByText('兑换历史')).toBeVisible();
  30  |   });
  31  | 
  32  |   test('奖励配置页面 - Tab 切换测试', async ({ page }) => {
  33  |     await page.goto('/pages/parent/reward-config/index');
  34  |     await page.waitForLoadState('networkidle');
  35  | 
  36  |     // 等待页面加载
  37  |     await page.waitForTimeout(1000);
  38  | 
  39  |     // 点击兑换历史 Tab
  40  |     const historyTab = page.getByText('兑换历史');
  41  |     if (await historyTab.count() > 0) {
  42  |       await historyTab.click({ force: true });
  43  |       await page.waitForTimeout(500);
  44  |     }
  45  | 
  46  |     // 点击配置奖励 Tab
  47  |     const configTab = page.getByText('配置奖励');
  48  |     if (await configTab.count() > 0) {
  49  |       await configTab.click({ force: true });
  50  |       await page.waitForTimeout(500);
  51  |     }
  52  |   });
  53  | 
  54  |   test('奖励配置页面 - 添加新奖励按钮', async ({ page }) => {
  55  |     await page.goto('/pages/parent/reward-config/index');
  56  |     await page.waitForLoadState('networkidle');
  57  | 
  58  |     // 等待页面加载
  59  |     await page.waitForTimeout(1000);
  60  | 
  61  |     // 查找添加奖励按钮
  62  |     const addBtn = page.locator('.add-reward-btn, button:has-text("添加新奖励")');
  63  | 
  64  |     if (await addBtn.count() > 0) {
  65  |       await expect(addBtn.first()).toBeVisible();
  66  |       await addBtn.first().click({ force: true });
  67  |       await page.waitForTimeout(1000);
  68  |     }
  69  |   });
  70  | 
  71  |   test('奖励配置页面 - 待处理请求', async ({ page }) => {
  72  |     await page.goto('/pages/parent/reward-config/index');
  73  |     await page.waitForLoadState('networkidle');
  74  | 
  75  |     // 等待数据加载
  76  |     await page.waitForTimeout(2000);
  77  | 
  78  |     // 查找请求卡片
  79  |     const requestCards = page.locator('reward-request-card');
  80  | 
  81  |     if (await requestCards.count() > 0) {
  82  |       await expect(requestCards.first()).toBeVisible();
  83  |     }
  84  |   });
  85  | 
  86  |   test('奖励配置页面 - 现有奖励列表', async ({ page }) => {
  87  |     await page.goto('/pages/parent/reward-config/index');
  88  |     await page.waitForLoadState('networkidle');
  89  | 
  90  |     // 等待数据加载
  91  |     await page.waitForTimeout(2000);
  92  | 
  93  |     // 查找奖励项
  94  |     const rewardItems = page.locator('reward-config-item, .reward-item');
  95  |     const count = await rewardItems.count();
  96  | 
  97  |     if (count > 0) {
  98  |       await expect(rewardItems.first()).toBeVisible();
  99  |     }
  100 |   });
  101 | 
  102 |   test('奖励配置页面 - 底部导航栏', async ({ page }) => {
  103 |     await page.goto('/pages/parent/reward-config/index');
  104 |     await page.waitForLoadState('networkidle');
  105 | 
  106 |     // 验证底部导航
> 107 |     await expect(page.getByText('首页')).toBeVisible();
      |                                        ^ Error: expect(locator).toBeVisible() failed
  108 |     await expect(page.getByText('任务')).toBeVisible();
  109 |     await expect(page.getByText('洞察')).toBeVisible();
  110 |     await expect(page.getByText('我的')).toBeVisible();
  111 |   });
  112 | 
  113 |   test('奖励创建页面加载测试', async ({ page }) => {
  114 |     await page.goto('/pages/parent/reward-creator/index');
  115 |     await page.waitForLoadState('networkidle');
  116 | 
  117 |     // 验证页面加载
  118 |     await expect(page).toHaveURL(/reward-creator/);
  119 | 
  120 |     // 等待页面标题
  121 |     await page.waitForTimeout(1000);
  122 | 
  123 |     // 查找表单元素
  124 |     const formElements = page.locator('input, textarea, picker');
  125 |     const count = await formElements.count();
  126 | 
  127 |     // 至少应该有表单元素存在
  128 |     expect(count).toBeGreaterThanOrEqual(0);
  129 |   });
  130 | 
  131 |   test('奖励创建页面 - 表单字段验证', async ({ page }) => {
  132 |     await page.goto('/pages/parent/reward-creator/index');
  133 |     await page.waitForLoadState('networkidle');
  134 | 
  135 |     // 等待表单加载
  136 |     await page.waitForTimeout(2000);
  137 | 
  138 |     // 查找输入框
  139 |     const inputs = page.locator('input');
  140 |     const inputCount = await inputs.count();
  141 | 
  142 |     if (inputCount > 0) {
  143 |       // 验证至少有一些输入框存在
  144 |       await expect(inputs.first()).toBeVisible();
  145 |     }
  146 |   });
  147 | 
  148 |   test('奖励创建页面 - 保存按钮', async ({ page }) => {
  149 |     await page.goto('/pages/parent/reward-creator/index');
  150 |     await page.waitForLoadState('networkidle');
  151 | 
  152 |     // 等待页面加载
  153 |     await page.waitForTimeout(1000);
  154 | 
  155 |     // 查找保存按钮
  156 |     const saveBtn = page.locator('button:has-text("保存"), .save-btn, button:has-text("创建")');
  157 | 
  158 |     if (await saveBtn.count() > 0) {
  159 |       await expect(saveBtn.first()).toBeVisible();
  160 |     }
  161 |   });
  162 | 
  163 |   test('奖励创建页面 - 取消按钮', async ({ page }) => {
  164 |     await page.goto('/pages/parent/reward-creator/index');
  165 |     await page.waitForLoadState('networkidle');
  166 | 
  167 |     // 等待页面加载
  168 |     await page.waitForTimeout(1000);
  169 | 
  170 |     // 查找取消按钮
  171 |     const cancelBtn = page.locator('button:has-text("取消"), .cancel-btn');
  172 | 
  173 |     if (await cancelBtn.count() > 0) {
  174 |       await expect(cancelBtn.first()).toBeVisible();
  175 |     }
  176 |   });
  177 | });
  178 | 
```