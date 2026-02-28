# Research Prompt: BrowserMCP Alternatives for Claude Code

*Hand off to Claude Web (Sonnet 4.5) for deep research.*
*Context: Jérémie Lumbroso is building a reveal.js presentation tool with Claude Code.*
*Goal: Find a reliable browser automation MCP server for Claude Code that can screenshot,*
*navigate, and interact with locally-served HTML pages (reveal.js presentations).*

---

## Current Situation

We are using `@browsermcp/mcp` (configured via `.mcp.json` in a Claude Code project).
It is **unstable**: connections drop during interactive actions, WebSocket timeouts occur
after 30 seconds, and keyboard events fail with "connection lost" errors.

What works:
- `browser_navigate` (URL hash navigation) ✓
- `browser_screenshot` (when connection is active) ✓
- `browser_go_back` / `browser_go_forward` ✓

What fails:
- `browser_press_key` → WebSocket timeout after 30s
- `browser_click` on reveal.js slides → WebSocket timeout
- Any action that triggers a CSS animation in reveal.js → connection lost

The underlying issue appears to be: BrowserMCP requires a browser extension to be
"connected" to a specific tab, and that connection drops unpredictably. It is designed
for general web automation, not for the sustained interactive session needed to review
presentation slides.

---

## What We Need

A browser MCP server for Claude Code that can:

1. **Navigate** to `http://localhost:8765/some/slide.html` reliably
2. **Screenshot** the current state (no timing issues)
3. **Execute JavaScript** — needed to advance reveal.js slides via `Reveal.next()`
   instead of keyboard events (which require focus and are unreliable)
4. **Click elements** reliably (for reveal.js navigation buttons)
5. **Stable connection** — doesn't drop during a 10-20 minute review session
6. **No browser extension required** — or at least, extension-free mode available

Bonus but not required:
- Read browser console logs (for debugging JavaScript errors in slides)
- Take full-page screenshots

---

## Research Questions

Please research and answer all of the following:

### 1. What Playwright MCP servers exist for Claude Code?

Microsoft maintains an official `@playwright/mcp` package. Please research:
- Is it available and how is it installed? (`npx @playwright/mcp@latest` or npm install?)
- What tools does it expose? (navigate, screenshot, click, evaluate/executeScript?)
- How is it configured in `.mcp.json`?
- Does it require a running browser, or does it launch its own?
- Any known issues with JavaScript-heavy SPAs (Single Page Applications)?
- GitHub repo and stars?

### 2. What Puppeteer MCP servers exist?

There are several community Puppeteer MCP implementations. Please research:
- `@modelcontextprotocol/server-puppeteer` — official MCP puppeteer server?
- Any other notable Puppeteer MCP packages on npm?
- Same questions as above (tools, config, browser requirements)

### 3. Compare BrowserMCP vs Playwright MCP vs Puppeteer MCP

Make a comparison table covering:
- Connection stability
- Tool set (navigate / screenshot / click / keyboard / executeScript)
- Browser extension required? (yes/no)
- Works with localhost? (known issues?)
- Configuration complexity
- Active maintenance (last commit, issues resolved)
- Community size

### 4. What is the recommended `.mcp.json` configuration?

For the best option you identify, provide the exact `.mcp.json` configuration:
```json
{
  "mcpServers": {
    "[name]": {
      "command": "...",
      "args": [...]
    }
  }
}
```

### 5. JavaScript execution capability

For a reveal.js presentation, the cleanest way to navigate slides is:
```javascript
Reveal.next();           // advance one slide
Reveal.slide(h, v);      // jump to specific slide
Reveal.getState();       // get current position
```

Which MCP servers support executing arbitrary JavaScript in the browser context?
What is the tool name and parameters for the winning option?

### 6. Any reveal.js-specific MCP tools or patterns?

Is there any existing work on automating reveal.js with MCP? Any blog posts, GitHub issues,
or community discussion about using Claude Code with reveal.js presentations?

### 7. Stability recommendations

Based on your research, what is the most reliable way to use browser automation with
Claude Code for a session of 10-20 minutes of sustained interaction with a localhost
HTML/JS application?

---

## Context for Evaluation

The use case is:
- Serve a reveal.js presentation from `localhost:8765`
- Claude Code reviews slide-by-slide: navigate, screenshot, identify issues
- This happens in development sessions of 20-60 minutes
- The presentation uses CSS animations (fade transitions between slides)
- CDN resources (Google Fonts, unpkg.com) are loaded

The key failure mode to avoid: connection drops when CSS animations are triggered.

---

## Deliverable

Please return:
1. Your recommendation (which tool to use)
2. The exact `.mcp.json` configuration
3. Any known gotchas or required setup steps
4. The tool names I need to add to Claude Code's `settings.json` allow list

---

*Created: 2026-02-28 | For: Jérémie Lumbroso | Handoff to Claude Web*
