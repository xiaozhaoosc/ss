# Instructions

- Following Playwright test failed.
- Explain why, be concise, respect Playwright best practices.
- Provide a snippet of code with the fix, if possible.

# Test info

- Name: spec\parent-emotion-deep.spec.ts >> 情绪相关页面深度测试 >> 情绪急救包页面 - 底部导航栏
- Location: tests\e2e\spec\parent-emotion-deep.spec.ts:153:7

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
    8 × locator resolved to <div class="uni-tabbar__label">首页</div>
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
  58  | 
  59  |     // 验证录音文稿卡片
  60  |     await expect(page.getByText('录音文稿')).toBeVisible();
  61  |   });
  62  | 
  63  |   test('情绪详情页面 - 音频播放器测试', async ({ page }) => {
  64  |     await page.goto('/pages/parent/emotion-detail/index');
  65  |     await page.waitForLoadState('networkidle');
  66  | 
  67  |     // 查找音频播放器组件
  68  |     const audioPlayer = page.locator('audio-player');
  69  |     if (await audioPlayer.count() > 0) {
  70  |       await expect(audioPlayer).toBeVisible();
  71  |     }
  72  |   });
  73  | 
  74  |   test('情绪详情页面 - 查看更多按钮', async ({ page }) => {
  75  |     await page.goto('/pages/parent/emotion-detail/index');
  76  |     await page.waitForLoadState('networkidle');
  77  | 
  78  |     // 查找查看更多按钮
  79  |     const viewMoreBtn = page.locator('button:has-text("查看更多")');
  80  |     if (await viewMoreBtn.count() > 0) {
  81  |       await expect(viewMoreBtn).toBeVisible();
  82  |       await viewMoreBtn.click({ force: true });
  83  |     }
  84  |   });
  85  | 
  86  |   test('情绪详情页面 - 底部操作按钮', async ({ page }) => {
  87  |     await page.goto('/pages/parent/emotion-detail/index');
  88  |     await page.waitForLoadState('networkidle');
  89  | 
  90  |     // 验证底部操作区
  91  |     await expect(page.getByText('家长回复')).toBeVisible();
  92  | 
  93  |     // 验证录制语音按钮
  94  |     const voiceBtn = page.locator('.action-btn.voice');
  95  |     await expect(voiceBtn).toBeVisible();
  96  | 
  97  |     // 验证 AI 建议按钮
  98  |     const aiBtn = page.locator('.action-btn.ai');
  99  |     await expect(aiBtn).toBeVisible();
  100 |   });
  101 | 
  102 |   test('情绪详情页面 - 录制语音按钮点击', async ({ page }) => {
  103 |     await page.goto('/pages/parent/emotion-detail/index');
  104 |     await page.waitForLoadState('networkidle');
  105 | 
  106 |     const voiceBtn = page.locator('.action-btn.voice');
  107 | 
  108 |     if (await voiceBtn.count() > 0) {
  109 |       await voiceBtn.click({ force: true });
  110 |       await page.waitForTimeout(500);
  111 |     }
  112 |   });
  113 | 
  114 |   test('情绪详情页面 - AI 建议按钮点击', async ({ page }) => {
  115 |     await page.goto('/pages/parent/emotion-detail/index');
  116 |     await page.waitForLoadState('networkidle');
  117 | 
  118 |     const aiBtn = page.locator('.action-btn.ai');
  119 | 
  120 |     if (await aiBtn.count() > 0) {
  121 |       await aiBtn.click({ force: true });
  122 |       await page.waitForTimeout(500);
  123 |     }
  124 |   });
  125 | 
  126 |   test('情绪急救包页面加载测试', async ({ page }) => {
  127 |     await page.goto('/pages/parent/emotion-kit/index');
  128 |     await page.waitForLoadState('networkidle');
  129 | 
  130 |     // 验证页面加载
  131 |     await expect(page).toHaveURL(/emotion-kit/);
  132 | 
  133 |     // 验证页面标题
  134 |     await expect(page.locator('.section-title, .page-title, view').first()).toBeVisible({ timeout: 10000 });
  135 |   });
  136 | 
  137 |   test('情绪急救包页面 - 急救方法列表', async ({ page }) => {
  138 |     await page.goto('/pages/parent/emotion-kit/index');
  139 |     await page.waitForLoadState('networkidle');
  140 | 
  141 |     // 等待数据加载
  142 |     await page.waitForTimeout(2000);
  143 | 
  144 |     // 查找急救方法卡片
  145 |     const methodCards = page.locator('.method-card, .kit-item, .emergency-item');
  146 |     const count = await methodCards.count();
  147 | 
  148 |     if (count > 0) {
  149 |       await expect(methodCards.first()).toBeVisible();
  150 |     }
  151 |   });
  152 | 
  153 |   test('情绪急救包页面 - 底部导航栏', async ({ page }) => {
  154 |     await page.goto('/pages/parent/emotion-kit/index');
  155 |     await page.waitForLoadState('networkidle');
  156 | 
  157 |     // 验证底部导航
> 158 |     await expect(page.getByText('首页')).toBeVisible();
      |                                        ^ Error: expect(locator).toBeVisible() failed
  159 |     await expect(page.getByText('任务')).toBeVisible();
  160 |     await expect(page.getByText('洞察')).toBeVisible();
  161 |     await expect(page.getByText('我的')).toBeVisible();
  162 |   });
  163 | });
  164 | 
```