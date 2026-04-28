const { chromium } = require('playwright');

async function testAIModule() {
  console.log('启动浏览器...');
  const browser = await chromium.launch({
    headless: true,
    args: ['--no-sandbox', '--disable-setuid-sandbox']
  });
  const context = await browser.newContext();
  const page = await context.newPage();

  const results = [];

  try {
    console.log('1. 访问登录页面...');
    await page.goto('http://localhost:88/', { timeout: 30000 });
    await page.waitForLoadState('domcontentloaded');

    console.log('2. 填写登录信息...');
    await page.fill('input[placeholder="用户名"]', 'admin');
    await page.fill('input[placeholder="密码"]', 'admin123');

    console.log('3. 点击登录按钮...');
    await page.click('button[type="submit"]');

    console.log('4. 等待登录完成...');
    await page.waitForTimeout(5000);

    const url = page.url();
    console.log('登录后URL:', url);

    if (url.includes('/index') || url.includes('/dashboard') || url.includes('login') === false) {
      console.log('✅ 登录成功');
      results.push({ test: '登录测试', status: 'passed' });
    } else {
      console.log('❌ 登录失败');
      results.push({ test: '登录测试', status: 'failed', error: '登录未成功' });
      return results;
    }

    const pages = [
      { name: 'AI模型管理', path: '/#/ai/model', selector: '.el-table, h3, .page-container' },
      { name: 'AI提示词模板', path: '/#/ai/prompt', selector: '.el-table, h3, .page-container' },
      { name: 'AI路由配置', path: '/#/ai/route', selector: '.el-table, h3, .page-container' },
      { name: 'AI供应商配置', path: '/#/ai/provider', selector: '.el-table, h3, .page-container' },
      { name: 'AI日志', path: '/#/ai/log', selector: '.el-table, h3, .page-container' }
    ];

    for (const p of pages) {
      console.log(`\n测试 ${p.name}...`);
      try {
        await page.goto(`http://localhost:88${p.path}`, { timeout: 15000 });
        await page.waitForLoadState('domcontentloaded');
        await page.waitForTimeout(2000);

        const errorSelector = await page.$('.el-message--error, .el-alert--error, [class*="error"]');
        const hasError = errorSelector !== null;

        if (hasError) {
          console.log(`❌ ${p.name} - 页面包含错误信息`);
          results.push({ test: p.name, status: 'failed', error: '页面包含错误信息' });
        } else {
          console.log(`✅ ${p.name} - 页面加载正常`);
          results.push({ test: p.name, status: 'passed' });
        }
      } catch (e) {
        console.log(`❌ ${p.name} - 测试异常: ${e.message}`);
        results.push({ test: p.name, status: 'failed', error: e.message });
      }
    }
  } catch (error) {
    console.error('测试过程中发生错误:', error.message);
    results.push({ test: '整体测试', status: 'failed', error: error.message });
  } finally {
    await browser.close();
  }

  console.log('\n========== 测试结果汇总 ==========');
  results.forEach(r => {
    const statusIcon = r.status === 'passed' ? '✅' : '❌';
    console.log(`${statusIcon} ${r.test}: ${r.status}${r.error ? ' - ' + r.error : ''}`);
  });

  const passed = results.filter(r => r.status === 'passed').length;
  const failed = results.filter(r => r.status === 'failed').length;
  console.log(`\n通过: ${passed}, 失败: ${failed}`);

  return results;
}

testAIModule().catch(console.error);