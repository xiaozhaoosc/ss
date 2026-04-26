const path = require('path');

async function executeStep(page, step, options = {}) {
  const p = step.params || {};

  switch (step.action) {
    case 'goto':
      await page.goto(p.url, { waitUntil: 'domcontentloaded', timeout: 30000 });
      break;
    case 'goBack':
      await page.goBack({ waitUntil: 'domcontentloaded' });
      break;
    case 'goForward':
      await page.goForward({ waitUntil: 'domcontentloaded' });
      break;
    case 'reload':
      await page.reload({ waitUntil: 'domcontentloaded' });
      break;
    case 'click':
      if (p.selector) {
        await page.click(p.selector, { timeout: p.timeout || 5000 });
      } else if (p.x != null && p.y != null) {
        await page.mouse.click(p.x, p.y);
      }
      break;
    case 'fill':
      if (p.selector && p.value != null) {
        await page.fill(p.selector, String(p.value));
      }
      break;
    case 'type':
      if (p.selector && p.text != null) {
        await page.locator(p.selector).pressSequentially(String(p.text), { delay: p.delay || 50 });
      } else if (p.text != null) {
        await page.keyboard.type(String(p.text), { delay: p.delay || 50 });
      }
      break;
    case 'press':
      if (p.selector) {
        await page.locator(p.selector).press(p.key);
      } else {
        await page.keyboard.press(p.key);
      }
      break;
    case 'hover':
      if (p.selector) {
        await page.hover(p.selector);
      } else if (p.x != null && p.y != null) {
        await page.mouse.move(p.x, p.y);
      }
      break;
    case 'focus':
      if (p.selector) await page.focus(p.selector);
      break;
    case 'selectOption':
      if (p.selector) await page.selectOption(p.selector, p.values || p.value);
      break;
    case 'check':
      if (p.selector) await page.check(p.selector, { timeout: p.timeout || 5000 });
      break;
    case 'uncheck':
      if (p.selector) await page.uncheck(p.selector, { timeout: p.timeout || 5000 });
      break;
    case 'waitForSelector':
      await page.waitForSelector(p.selector, { state: p.state || 'visible', timeout: p.timeout || 30000 });
      break;
    case 'waitForLoadState':
      await page.waitForLoadState(p.state || 'domcontentloaded', { timeout: p.timeout || 30000 });
      break;
    case 'wait':
      await new Promise(r => setTimeout(r, Math.min(p.ms || 1000, 30000)));
      break;
    case 'evaluate':
      return await page.evaluate(p.expression);
    case 'screenshot': {
      const dir = options.scriptsDir || process.env.REPLAYRIGHT_SCRIPTS_DIR || path.join(require('os').homedir(), '.replayright', 'scripts');
      await page.screenshot({ path: path.join(dir, p.name || `screenshot-${Date.now()}.png`) });
      break;
    }
    default:
      throw new Error(`Unknown action: ${step.action}`);
  }
}

module.exports = { executeStep };
