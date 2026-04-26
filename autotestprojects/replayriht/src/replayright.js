/**
 * Replayright — autonomous browser automation via Playwright.
 *
 * Connects to a Chrome/Chromium instance via CDP, creates a dedicated page,
 * and provides a high-level action + observation API for AI agents.
 * All actions are auto-recorded into a replayable Playwright script by codegen.
 *
 * No server required — this is a standalone module.
 *
 * Usage:
 *   const Replayright = require('replayright');
 *   const agent = new Replayright({ port: 9222 });
 *   await agent.open('https://example.com');
 *   const result = await agent.act({ action: 'click', params: { selector: 'a' } });
 *   console.log(result.observation.a11yTree);
 *   const script = agent.getScript();
 *   await agent.close('my-workflow');
 */

const fs = require('fs');
const path = require('path');
const os = require('os');
const { executeStep } = require('./actions');
const { stepToRecorderAction } = require('./recorder');

let chromium = null;
function getChromium() {
  if (!chromium) {
    try {
      chromium = require('playwright').chromium;
    } catch {
      throw new Error(
        'Playwright is not installed. Run: npm install playwright\n' +
        'Then install browser binaries: npx playwright install chromium'
      );
    }
  }
  return chromium;
}

const SCRIPTS_DIR = process.env.REPLAYRIGHT_SCRIPTS_DIR ||
  path.join(os.homedir(), '.replayright', 'scripts');

const { readSavedPort } = require('./launch');

class Replayright {
  /**
   * @param {object} [options]
   * @param {number} [options.port=9222] - Chrome debugging port
   * @param {string} [options.scriptsDir] - Directory to save generated scripts
   */
  constructor(options = {}) {
    this.port = options.port || parseInt(process.env.CHROME_DEBUG_PORT) || readSavedPort() || 9222;
    this.headed = options.headed || false;
    this.scriptsDir = options.scriptsDir || SCRIPTS_DIR;
    this.browser = null;
    this._context = null;
    this._page = null;
    this._recording = false;
    this._scriptFile = null;
    this._browserProcess = null;
  }

  // ==================== Lifecycle ====================

  /**
   * Connect to the browser via CDP. Auto-launches if no browser found.
   */
  async connect() {
    if (this.browser?.isConnected()) return;
    const pw = getChromium();

    // Try connecting to an existing browser first
    try {
      this.browser = await pw.connectOverCDP(`http://localhost:${this.port}`);
      this.browser.on('disconnected', () => { this.browser = null; });
      return;
    } catch {}

    // No browser found — auto-launch one
    try {
      const { launchBrowser } = require('./launch');
      const result = await launchBrowser({ port: this.port, headed: this.headed });
      this.port = result.port;
      this._browserProcess = result.child;

      this.browser = await pw.connectOverCDP(`http://localhost:${this.port}`);
      this.browser.on('disconnected', () => { this.browser = null; });
    } catch (err) {
      throw new Error(`Failed to launch browser: ${err.message}`);
    }
  }

  /**
   * Open the agent's working page. Enables codegen recording automatically.
   * @param {string} [url] - Navigate to this URL after creating
   * @returns {Promise<{ active: boolean, url: string, recording: boolean, scriptFile: string }>}
   */
  async open(url) {
    await this.connect();

    if (this._page && !this._page.isClosed()) {
      if (url) {
        await this._page.goto(url, { waitUntil: 'domcontentloaded', timeout: 30000 });
        await this._recordAction(this._page, { name: 'navigate', url, signals: [] });
      }
      return this.status();
    }

    this._context = await this.browser.newContext();
    this._page = await this._context.newPage();
    await this._enableRecording();

    if (url) {
      await this._page.goto(url, { waitUntil: 'domcontentloaded', timeout: 30000 });
      await this._recordAction(this._page, { name: 'navigate', url, signals: [] });
    }

    return this.status();
  }

  /**
   * Close the agent's page and return the generated script.
   * @param {string} [name] - Script name (without extension). Falls back to URL-derived name.
   * @returns {Promise<{ closed: boolean, scriptFile?: string, script?: string }>}
   */
  async close(name) {
    // Rename temp recording file to final name
    if (this._scriptFile && fs.existsSync(this._scriptFile)) {
      const currentUrl = this._page && !this._page.isClosed() ? this._page.url() : null;
      const rawName = name
        || (currentUrl && !currentUrl.startsWith('about:') ? this._urlToName(currentUrl) : null);
      const finalName = rawName ? this._sanitizeName(rawName) : null;
      if (finalName) {
        const finalPath = this._uniquePath(finalName);
        try {
          fs.renameSync(this._scriptFile, finalPath);
          this._scriptFile = finalPath;
        } catch {}
      }
    }

    let script = null;
    if (this._scriptFile) {
      try { script = fs.readFileSync(this._scriptFile, 'utf-8'); } catch {}
    }

    if (this._context) {
      try { await this._context._disableRecorder(); } catch {}
    }
    if (this._page && !this._page.isClosed()) {
      await this._page.close().catch(() => {});
    }
    this._page = null;
    if (this._context) {
      await this._context.close().catch(() => {});
    }
    this._context = null;
    this._recording = false;

    const result = { closed: true };
    if (script) {
      result.scriptFile = this._scriptFile;
      result.script = script;
    }
    this._scriptFile = null;
    return result;
  }

  /**
   * Disconnect from the browser entirely.
   * Kills auto-launched browser if we started one.
   */
  async disconnect() {
    await this.close();
    if (this.browser) {
      try { await this.browser.close(); } catch {}
      this.browser = null;
    }
    if (this._browserProcess) {
      this._browserProcess.kill();
      this._browserProcess = null;
      const { clearPort } = require('./launch');
      clearPort();
    }
  }

  /**
   * Get current status.
   */
  status() {
    if (!this._page || this._page.isClosed()) {
      return { active: false };
    }
    return {
      active: true,
      url: this._page.url(),
      recording: this._recording,
      scriptFile: this._scriptFile || null,
    };
  }

  // ==================== Actions ====================

  /**
   * Perform a single action on the agent page.
   * @param {{ action: string, params?: object }} step
   * @param {{ observe?: boolean, screenshot?: boolean }} [options]
   * @returns {Promise<{ success: boolean, action: string, duration: number, observation?: object, error?: string }>}
   */
  async act(step, options = {}) {
    if (!this._page || this._page.isClosed()) {
      throw new Error('Agent page not open. Call open() first.');
    }

    const doObserve = options.observe !== false;
    const startTime = Date.now();

    try {
      const stepResult = await executeStep(this._page, step, { scriptsDir: this.scriptsDir });
      await this._recordAction(this._page, stepToRecorderAction(step));

      const result = { success: true, action: step.action, duration: Date.now() - startTime };
      if (stepResult !== undefined) result.result = stepResult;
      if (doObserve) {
        result.observation = await this.observe({ screenshot: options.screenshot !== false });
      }
      return result;
    } catch (err) {
      const result = { success: false, action: step.action, error: err.message, duration: Date.now() - startTime };

      if (this._recording) {
        await this._ensureRecorderAlive();
      }

      if (doObserve) {
        try { result.observation = await this.observe({ screenshot: options.screenshot !== false }); } catch {}
      }
      return result;
    }
  }

  // ==================== Observation ====================

  /**
   * Observe the current state of the page.
   * @param {{ screenshot?: boolean }} [options]
   * @returns {Promise<{ pageInfo: object, a11yTree: string, screenshot?: string }>}
   */
  async observe({ screenshot = true } = {}) {
    if (!this._page || this._page.isClosed()) {
      throw new Error('Agent page not open. Call open() first.');
    }

    await this._page.waitForLoadState('domcontentloaded', { timeout: 5000 }).catch(() => {});
    await this._page.waitForLoadState('networkidle', { timeout: 2000 }).catch(() => {});

    const observation = {};

    try {
      observation.pageInfo = { url: this._page.url(), title: await this._page.title() };
    } catch {
      observation.pageInfo = { url: '', title: '' };
    }

    try {
      observation.a11yTree = await this._page.locator('body').ariaSnapshot();
    } catch (e) {
      observation.a11yTree = `(error: ${e.message})`;
    }

    if (screenshot) {
      try {
        const buf = await this._page.screenshot({ type: 'png' });
        observation.screenshot = 'data:image/png;base64,' + buf.toString('base64');
      } catch {
        observation.screenshot = null;
      }
    }

    return observation;
  }

  // ==================== Script ====================

  /**
   * Get the codegen-generated script.
   */
  getScript() {
    if (!this._scriptFile) return null;
    try {
      return { file: this._scriptFile, script: fs.readFileSync(this._scriptFile, 'utf-8') };
    } catch {
      return null;
    }
  }

  // ==================== Internal ====================

  /** @private */
  async _enableRecording() {
    if (!this._context) return;

    // Use a temp name during recording; final name is decided on close()
    const timestamp = new Date().toISOString().slice(0, 19).replace(/[T:]/g, '-');
    if (!fs.existsSync(this.scriptsDir)) fs.mkdirSync(this.scriptsDir, { recursive: true });
    this._scriptFile = path.join(this.scriptsDir, `recording-${timestamp}.js`);

    try {
      await this._context._enableRecorder({
        language: 'javascript',
        mode: 'recording',
        outputFile: this._scriptFile,
      });
      this._recording = true;
    } catch (err) {
      console.warn('[Replayright] Codegen recording not available:', err.message);
      this._recording = false;
    }
  }

  /** @private - Sanitize a name for use as a filename */
  _sanitizeName(name) {
    return name.replace(/[^a-zA-Z0-9-]/g, '-').replace(/-+/g, '-').replace(/^-|-$/g, '').slice(0, 80) || null;
  }

  /** @private - Derive a script name from a URL */
  _urlToName(url) {
    try {
      const u = new URL(url);
      const parts = [u.hostname, ...u.pathname.split('/').filter(Boolean)];
      return parts.join('-');
    } catch {
      return null;
    }
  }

  /** @private - Return a unique file path, appending -2, -3 etc. if needed */
  _uniquePath(name) {
    let filePath = path.join(this.scriptsDir, `${name}.js`);
    if (!fs.existsSync(filePath)) return filePath;
    let i = 2;
    while (fs.existsSync(path.join(this.scriptsDir, `${name}-${i}.js`))) i++;
    return path.join(this.scriptsDir, `${name}-${i}.js`);
  }

  /** @private */
  async _ensureRecorderAlive() {
    if (!this._context || !this._scriptFile) return;
    try {
      await this._context._enableRecorder({
        language: 'javascript',
        mode: 'recording',
        outputFile: this._scriptFile,
      });
      this._recording = true;
    } catch {}
  }

  /** @private */
  async _recordAction(page, recorderAction) {
    if (!this._recording || !recorderAction || !page || page.isClosed()) return;
    try {
      await page.evaluate(async (action) => {
        if (typeof window.__pw_recorderRecordAction === 'function') {
          await window.__pw_recorderRecordAction(action);
        }
      }, recorderAction);
    } catch {}
  }
}

module.exports = Replayright;
