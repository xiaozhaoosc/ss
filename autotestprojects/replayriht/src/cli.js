#!/usr/bin/env node
/**
 * Replayright CLI — browser automation for AI agents.
 *
 * Usage:
 *   replayright [options]     Start interactive REPL
 *
 * Run `replayright --help` for full usage.
 */

const args = process.argv.slice(2);

if (args[0] === '--help' || args[0] === '-h') {
  printHelp();
  process.exit(0);
}

if (args[0] === '--version' || args[0] === '-V') {
  console.log(require('../package.json').version);
  process.exit(0);
}

handleRepl(args);

// ==================== Help ====================

function printHelp() {
  console.log(`Usage: replayright [options]

Starts an interactive REPL. Auto-launches a browser if none is running.

Commands:
  open [url]              Open agent page (starts codegen recording)
  close [name]            Close agent page, save script (name optional)
  status                  Show page status
  observe                 Print accessibility tree and page info
  script                  Print generated Playwright script
  goto <url>              Navigate to URL
  back                    Go back
  forward                 Go forward
  reload                  Reload page
  click <selector>        Click element
  fill <selector> <value> Fill input field
  type <selector> <text>  Type text character by character
  press <key>             Press key (Enter, Tab, etc.)
  hover <selector>        Hover over element
  select <selector> <val> Select dropdown option
  check <selector>        Check a checkbox
  uncheck <selector>      Uncheck a checkbox
  eval <expression>       Evaluate JavaScript in page
  wait <ms>               Wait for milliseconds (max 30s)
  screenshot [name]       Take screenshot
  quit / exit             Close page and exit

Options:
  --port, -p PORT   Chrome debugging port (default: 9222)
  --headed          Show browser window (default: headless)
  --help, -h        Show this help
  --version, -V     Show version number

Environment:
  CHROME_DEBUG_PORT       Override default Chrome debugging port
  REPLAYRIGHT_SCRIPTS_DIR  Directory for generated scripts (default: ~/.replayright/scripts)`);
}

// ==================== Shared ====================

/** Split string at first whitespace: 'foo bar baz' → ['foo', 'bar baz'] */
function splitFirst(str) {
  const i = str.search(/\s/);
  if (i === -1) return [str, ''];
  return [str.slice(0, i), str.slice(i).trimStart()];
}

async function dispatch(agent, cmd, rest) {
  switch (cmd) {
    case 'open':
      return await agent.open(rest || undefined);

    case 'close': {
      const r = await agent.close(rest || undefined);
      if (r.script) {
        console.log('--- Generated Script ---');
        console.log(r.script);
        if (r.scriptFile) console.log(`--- Saved to: ${r.scriptFile} ---`);
      }
      return { closed: r.closed };
    }

    case 'status':
      return agent.status();

    case 'observe': {
      const obs = await agent.observe({ screenshot: false });
      console.log(`URL: ${obs.pageInfo.url}`);
      console.log(`Title: ${obs.pageInfo.title}`);
      console.log(`\n${obs.a11yTree}`);
      return undefined;
    }

    case 'script': {
      const s = agent.getScript();
      return s ? s.script : 'No script available';
    }

    case 'goto':
      if (!rest) throw new Error('Usage: goto <url>');
      return formatActResult(await agent.act(
        { action: 'goto', params: { url: rest } }, { screenshot: false }
      ));

    case 'back':
      return formatActResult(await agent.act(
        { action: 'goBack' }, { screenshot: false }
      ));

    case 'forward':
      return formatActResult(await agent.act(
        { action: 'goForward' }, { screenshot: false }
      ));

    case 'reload':
      return formatActResult(await agent.act(
        { action: 'reload' }, { screenshot: false }
      ));

    case 'click':
      if (!rest) throw new Error('Usage: click <selector>');
      return formatActResult(await agent.act(
        { action: 'click', params: { selector: rest } }, { screenshot: false }
      ));

    case 'fill': {
      const [selector, value] = splitFirst(rest);
      if (!selector || !value) throw new Error('Usage: fill <selector> <value>');
      return formatActResult(await agent.act(
        { action: 'fill', params: { selector, value } }, { screenshot: false }
      ));
    }

    case 'type': {
      const [selector, text] = splitFirst(rest);
      if (!selector || !text) throw new Error('Usage: type <selector> <text>');
      return formatActResult(await agent.act(
        { action: 'type', params: { selector, text } }, { screenshot: false }
      ));
    }

    case 'press':
      if (!rest) throw new Error('Usage: press <key>');
      return formatActResult(await agent.act(
        { action: 'press', params: { key: rest } }, { screenshot: false }
      ));

    case 'hover':
      if (!rest) throw new Error('Usage: hover <selector>');
      return formatActResult(await agent.act(
        { action: 'hover', params: { selector: rest } }, { screenshot: false }
      ));

    case 'select': {
      const [selector, value] = splitFirst(rest);
      if (!selector || !value) throw new Error('Usage: select <selector> <value>');
      return formatActResult(await agent.act(
        { action: 'selectOption', params: { selector, value } }, { screenshot: false }
      ));
    }

    case 'check':
      if (!rest) throw new Error('Usage: check <selector>');
      return formatActResult(await agent.act(
        { action: 'check', params: { selector: rest } }, { screenshot: false }
      ));

    case 'uncheck':
      if (!rest) throw new Error('Usage: uncheck <selector>');
      return formatActResult(await agent.act(
        { action: 'uncheck', params: { selector: rest } }, { screenshot: false }
      ));

    case 'eval':
      if (!rest) throw new Error('Usage: eval <expression>');
      return formatActResult(await agent.act(
        { action: 'evaluate', params: { expression: rest } }, { screenshot: false }
      ));

    case 'screenshot':
      return formatActResult(await agent.act(
        { action: 'screenshot', params: { name: rest || undefined } }, { observe: false }
      ));

    case 'wait': {
      const ms = parseInt(rest, 10);
      if (!ms || ms <= 0) throw new Error('Usage: wait <ms>');
      return formatActResult(await agent.act(
        { action: 'wait', params: { ms } }, { observe: false }
      ));
    }

    default:
      throw new Error(`Unknown command: ${cmd}`);
  }
}

function formatActResult(result) {
  const out = { success: result.success, action: result.action, duration: result.duration };
  if (result.result !== undefined) out.result = result.result;
  if (result.error) out.error = result.error;
  if (result.observation) {
    out.url = result.observation.pageInfo?.url;
    out.title = result.observation.pageInfo?.title;
    if (result.observation.a11yTree) {
      console.log(result.observation.a11yTree);
    }
  }
  return out;
}

function parseArgs(args) {
  const opts = {};
  for (let i = 0; i < args.length; i++) {
    if ((args[i] === '--port' || args[i] === '-p') && args[i + 1]) {
      opts.port = parseInt(args[++i], 10);
    } else if (args[i] === '--headed') {
      opts.headed = true;
    }
  }
  return opts;
}

// ==================== Interactive REPL ====================

function handleRepl(replArgs) {
  const Replayright = require('./replayright');
  const readline = require('readline');

  const opts = parseArgs(replArgs);
  const agent = new Replayright(opts);

  // Clean up auto-launched browser on unexpected exit
  process.on('exit', () => {
    if (agent._browserProcess) {
      agent._browserProcess.kill();
    }
  });

  console.log(`Replayright REPL (port: ${agent.port})`);
  console.log('Type "help" for commands, "quit" to exit.\n');

  const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout,
    prompt: 'agent> '
  });
  rl.prompt();

  rl.on('line', async (line) => {
    const trimmed = line.trim();
    if (!trimmed) { rl.prompt(); return; }

    const spaceIdx = trimmed.indexOf(' ');
    const cmd = spaceIdx === -1 ? trimmed : trimmed.slice(0, spaceIdx);
    const rest = spaceIdx === -1 ? '' : trimmed.slice(spaceIdx + 1).trim();

    if (cmd === 'quit' || cmd === 'exit') {
      await agent.disconnect();
      rl.close();
      return;
    }

    if (cmd === 'help') {
      console.log('Commands: open [url], close [name], status, observe, script, goto <url>,');
      console.log('  back, forward, reload, click <sel>, fill <sel> <val>,');
      console.log('  type <sel> <text>, press <key>, hover <sel>, select <sel> <val>,');
      console.log('  check <sel>, uncheck <sel>, eval <expr>, wait <ms>,');
      console.log('  screenshot [name], quit');
      rl.prompt();
      return;
    }

    try {
      const result = await dispatch(agent, cmd, rest);
      if (result !== undefined) {
        if (typeof result === 'string') {
          console.log(result);
        } else {
          console.log(JSON.stringify(result, null, 2));
        }
      }
    } catch (err) {
      console.error(`Error: ${err.message}`);
    }
    rl.prompt();
  });

  rl.on('close', async () => {
    await agent.disconnect();
    process.exit(0);
  });
}
