---
name: replayright
description: >
  Automate a browser autonomously via Playwright. Use this skill when the agent needs to perform
  browser tasks itself — navigate sites, fill forms, click buttons, scrape content, test web pages.
  The agent opens its own browser page, observes via accessibility tree, acts via Playwright commands,
  and all actions are auto-recorded into a replayable Playwright script by codegen.
---

# Replayright Skill

Autonomous browser automation. The agent creates its own browser page, drives it with Playwright actions, and observes state via accessibility tree + screenshots. Playwright codegen automatically records every action into a replayable test script.

**When to use this skill:** The agent needs to DO things in a browser — navigate a site, fill a form, click through a workflow, scrape data, test a web page.

## Prerequisites

- Node.js >= 18

## How to Use

Start the interactive CLI as an async bash session, then send commands via `write_bash`:

```bash
npx replayright          # headless (default)
npx replayright --headed # visible browser window
```

Then send commands one at a time:

```
agent> open https://example.com
agent> observe
agent> click a
agent> fill input#email user@example.com
agent> press Enter
agent> script
agent> close login-flow
agent> quit
```

## Commands

### Page Lifecycle
| Command | Description |
|---------|-------------|
| `open [url]` | Open agent page at URL (starts codegen recording) |
| `close [name]` | Close page, save script. Agent should provide a descriptive name (e.g. `close login-flow`) |
| `status` | Show page status (active, URL, recording) |
| `quit` / `exit` | Close page and exit the REPL |

### Actions
All actions auto-observe after execution: print the a11y tree and page info.

| Command | Description |
|---------|-------------|
| `goto <url>` | Navigate to URL |
| `back` | Go back |
| `forward` | Go forward |
| `reload` | Reload page |
| `click <selector>` | Click element |
| `fill <selector> <value>` | Clear + fill input field |
| `type <selector> <text>` | Type text character by character |
| `press <key>` | Press key (Enter, Tab, ArrowDown, etc.) |
| `hover <selector>` | Hover over element |
| `select <selector> <value>` | Select dropdown option |
| `check <selector>` | Check a checkbox |
| `uncheck <selector>` | Uncheck a checkbox |
| `eval <expression>` | Run JavaScript in page, returns result |
| `wait <ms>` | Wait for milliseconds (max 30s) |
| `screenshot [name]` | Save screenshot to disk |

### Observation
| Command | Description |
|---------|-------------|
| `observe` | Print a11y tree + page info (no action) |
| `script` | Print the codegen-generated Playwright script |

## Observation Format

After each action, the CLI prints:

1. **A11y tree** — Playwright's ariaSnapshot format. Each line: `- role "name" [attributes]`
2. **Result JSON** — `{ success, action, duration, url, title }`

The a11y tree is the primary way to understand page state and decide the next action. Use element roles and names from the tree to target selectors.

## Codegen Recording

Every session automatically records a Playwright script:

- Recording starts on `open`
- Each action is fed to Playwright's codegen recorder
- Codegen generates code with resilient locators (getByRole, getByText)
- View the script anytime with `script`
- On `close`, the final script is printed and saved
- Scripts are standalone and replayable with `node <script>`

## Notes

- Actions auto-wait for elements to be actionable (visible, enabled, stable)
- Default timeout: 5s for clicks, 30s for navigation
- Agent page is an isolated browser context — separate from user's tabs
- Generated scripts saved to `~/.replayright/scripts/`
