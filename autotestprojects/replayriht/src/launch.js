/**
 * Launch a Chromium instance with a CDP debugging port.
 *
 * Uses Playwright's managed Chromium binary so there's no need to install
 * Chrome separately.
 *
 * Prerequisites:
 *   npx playwright install chromium
 */

const { spawn } = require('child_process');
const fs = require('fs');
const http = require('http');
const net = require('net');
const os = require('os');
const path = require('path');

const PORT_FILE = path.join(os.homedir(), '.replayright', 'port');

function readSavedPort() {
  try {
    const p = parseInt(fs.readFileSync(PORT_FILE, 'utf-8').trim());
    return isNaN(p) ? null : p;
  } catch {
    return null;
  }
}

function httpGet(url, timeoutMs = 2000) {
  return new Promise((resolve, reject) => {
    const req = http.get(url, { timeout: timeoutMs }, (res) => {
      let data = '';
      res.on('data', (chunk) => data += chunk);
      res.on('end', () => resolve(data));
    });
    req.on('error', reject);
    req.on('timeout', () => { req.destroy(); reject(new Error('timeout')); });
  });
}

async function waitForPort(port, timeoutMs = 10000) {
  const deadline = Date.now() + timeoutMs;
  while (Date.now() < deadline) {
    try {
      const json = await httpGet(`http://127.0.0.1:${port}/json/version`);
      return JSON.parse(json);
    } catch {}
    await new Promise((r) => setTimeout(r, 300));
  }
  return null;
}

function isPortFree(port) {
  return new Promise((resolve) => {
    const server = net.createServer();
    server.once('error', () => resolve(false));
    server.once('listening', () => { server.close(); resolve(true); });
    server.listen(port, '127.0.0.1');
  });
}

async function isCdpUsable(port) {
  return new Promise((resolve) => {
    const req = http.get(`http://127.0.0.1:${port}/json/version`, { timeout: 500 }, (res) => {
      if (res.statusCode !== 200) { res.resume(); return resolve(null); }
      let data = '';
      res.on('data', (chunk) => data += chunk);
      res.on('end', () => {
        try { resolve(JSON.parse(data)); } catch { resolve(null); }
      });
    });
    req.on('error', () => resolve(null));
    req.on('timeout', () => { req.destroy(); resolve(null); });
  });
}

async function resolvePort(preferred) {
  for (let port = preferred; port < preferred + 100; port++) {
    // Check if a usable CDP endpoint is already listening (200 + valid JSON)
    const version = await isCdpUsable(port);
    if (version) {
      return { port, existing: true, version };
    }

    // If port is free, we can launch on it
    if (await isPortFree(port)) {
      return { port, existing: false };
    }

    // Port busy but no CDP response — not usable, try next
  }
  throw new Error(`No free port found near ${preferred}`);
}

function savePort(port) {
  const dir = path.dirname(PORT_FILE);
  if (!fs.existsSync(dir)) fs.mkdirSync(dir, { recursive: true });
  fs.writeFileSync(PORT_FILE, String(port));
}

function clearPort() {
  try { fs.unlinkSync(PORT_FILE); } catch {}
}

/**
 * Launch a Chromium instance and return its port and child process.
 * If an existing CDP endpoint is found on the preferred port, returns that instead.
 *
 * @param {object} [options]
 * @param {number} [options.port=9222] - Preferred CDP port
 * @param {boolean} [options.headed=false] - Show browser window
 * @returns {Promise<{ port: number, child: ChildProcess|null, existing: boolean }>}
 */
async function launchBrowser(options = {}) {
  const preferred = options.port || 9222;
  const headed = options.headed || false;

  const resolved = await resolvePort(preferred);

  if (resolved.existing) {
    savePort(resolved.port);
    return { port: resolved.port, child: null, existing: true };
  }

  const port = resolved.port;

  let chromiumPath;
  try {
    chromiumPath = require('playwright').chromium.executablePath();
  } catch {
    throw new Error('Playwright Chromium not found. Run: npx playwright install chromium');
  }

  const userDataDir = process.env.CHROME_DEBUG_USER_DATA ||
    path.join(os.tmpdir(), `chromium-headless-${port}`);

  const chromeArgs = [
    `--remote-debugging-port=${port}`,
    '--remote-allow-origins=*',
    '--no-first-run',
    '--no-default-browser-check',
    '--disable-background-networking',
    '--disable-sync',
    '--disable-translate',
    '--metrics-recording-only',
    `--user-data-dir=${userDataDir}`,
  ];

  if (!headed) {
    chromeArgs.push('--headless=new');
  }

  chromeArgs.push('about:blank');

  const child = spawn(chromiumPath, chromeArgs, {
    stdio: ['ignore', 'ignore', 'pipe'],
    detached: false,
  });

  child.stderr.on('data', (chunk) => {
    const lines = chunk.toString().split('\n');
    for (const line of lines) {
      if (/ERROR|FATAL/.test(line)) {
        process.stderr.write(line + '\n');
      }
    }
  });

  const version = await waitForPort(port);
  if (!version) {
    child.kill();
    throw new Error(`Browser launched but debug port not responding on port ${port}`);
  }

  savePort(port);
  return { port, child, existing: false };
}

module.exports = { launchBrowser, clearPort, readSavedPort, PORT_FILE };
