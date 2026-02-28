# ADR 0006: Playwright MCP for Browser Testing and Slide Review

- **Date**: 2026-02-28
- **Iteration**: 1
- **Status**: Accepted
- **Deciders**: Jérémie Lumbroso, Claude Sonnet 4.6

---

## Quick Reference

```bash
# Start local HTTP server (run once per session)
python3 -m http.server 8765 --directory /path/to/repo &

# Playwright MCP is configured in .claude/settings.json
# Tools available: navigate, screenshot, evaluate, snapshot,
#                  click, wait_for, press_key, console_messages
```

```javascript
// Reveal.js navigation via Playwright evaluate
Reveal.slide(h, v)          // jump to slide at horizontal h, vertical v
Reveal.next()               // advance one step (fragment or slide)
Reveal.nextFragment()       // reveal next fragment only
Reveal.prevFragment()       // hide last fragment
Reveal.getState()           // returns {indexh, indexv, indexf}
Reveal.getSlides()          // all slide elements
```

---

## Context

BrowserMCP (`@browsermcp/mcp`) proved unreliable for sustained slide review sessions:
- Connection dropped on keyboard events and CSS animations
- WebSocket timeout after 30 seconds of interactive use
- No JavaScript execution capability
- Required browser extension to be manually re-paired

Playwright MCP (headless Chromium, no extension required) was configured as a replacement.
The difference in experience is described by Jérémie as "different leagues completely."

---

## Configuration

### `.mcp.json`

```json
{
  "mcpServers": {
    "playwright": {
      "command": "npx",
      "args": ["@playwright/mcp@latest"]
    }
  }
}
```

### `.claude/settings.json` — allow list additions

```json
"mcp__playwright__browser_navigate",
"mcp__playwright__browser_take_screenshot",
"mcp__playwright__browser_click",
"mcp__playwright__browser_evaluate",
"mcp__playwright__browser_snapshot",
"mcp__playwright__browser_console_messages",
"mcp__playwright__browser_wait_for",
"mcp__playwright__browser_press_key",
"mcp__playwright__browser_close"
```

### First-time setup

The browser must be installed on first use:
```javascript
// Playwright will error: "Browser chromium is not installed"
// Fix: call the install tool once
mcp__playwright__browser_install()
```

---

## The Slide Review Workflow

### 1. Start the server

```bash
python3 -m http.server 8765 --directory /path/to/project &
```

### 2. Navigate to a slide deck

```javascript
mcp__playwright__browser_navigate({
  url: "http://localhost:8765/topics/labor-automation/slides/2026-02-28-v1-diagrams.html#/0/1"
})
```

Hash format: `#/[horizontal]/[vertical]/[fragment]`
- `#/0` — first horizontal slide
- `#/0/2` — third vertical slide in first stack
- `#/3/1/0` — second vertical of fourth horizontal, first fragment

### 3. Navigate programmatically via JavaScript

**Jump to specific slide:**
```javascript
mcp__playwright__browser_evaluate({ function: "() => Reveal.slide(0, 3)" })
```

**Reveal fragments:**
```javascript
// Reveal next fragment
mcp__playwright__browser_evaluate({ function: "() => Reveal.nextFragment()" })

// Reveal all fragments on current slide at once
mcp__playwright__browser_evaluate({ function: `() => {
  const slide = Reveal.getCurrentSlide();
  slide.querySelectorAll('.fragment').forEach(el => {
    el.classList.add('visible'); el.classList.remove('fragment');
  });
}` })
```

**Get current state:**
```javascript
mcp__playwright__browser_evaluate({ function: "() => Reveal.getState()" })
// Returns: { indexh: 0, indexv: 3, indexf: -1, paused: false }
```

### 4. Screenshot

```javascript
mcp__playwright__browser_take_screenshot({ type: "png" })
// Returns: screenshot file path + inline image for Claude to see
```

Screenshots are saved to `.playwright-mcp/page-[timestamp].png`.

### 5. Hard reload after file changes

```javascript
mcp__playwright__browser_evaluate({ function: "() => location.reload(true)" })
// Then wait for Mermaid/scripts to finish:
mcp__playwright__browser_wait_for({ time: 2 })
```

### 6. Check console errors

After loading a slide, check for JavaScript errors:
```javascript
mcp__playwright__browser_console_messages({ level: "error" })
```

This catches: missing CDN resources, Mermaid parse errors, plugin failures.

---

## Full Slide Deck Review Protocol

To systematically review a 54-slide deck:

```javascript
// 1. Navigate to deck
navigate("http://localhost:8765/sessions/.../slides/deck.html")

// 2. Iterate through horizontal sections
for (let h = 0; h < totalHorizontalSlides; h++) {
  evaluate("() => Reveal.slide(" + h + ", 0)")
  take_screenshot()  // check topic header

  // 3. For each vertical sub-slide
  for (let v = 1; v < verticalCount; v++) {
    evaluate("() => Reveal.slide(" + h + ", " + v + ")")
    take_screenshot()  // check content
  }
}
```

In practice: navigate to key slides by hash URL, screenshot, assess, fix, reload.

---

## Mermaid Diagram Review

Mermaid diagrams render asynchronously after `Reveal.on('ready')`.
Wait 2 seconds after navigation before screenshotting diagram slides.

```javascript
navigate("url#/0/1")
wait_for({ time: 2 })   // wait for Mermaid async render
take_screenshot()
```

To check if Mermaid rendered correctly:
```javascript
evaluate({ function: `() => {
  const divs = document.querySelectorAll('.mermaid');
  return Array.from(divs).map(d => ({
    hasSvg: !!d.querySelector('svg'),
    text: d.textContent.substring(0, 50)
  }));
}` })
```

If `hasSvg: false`, the Mermaid source has an error — check `console_messages({ level: "error" })`.

---

## Fragment Management for Screenshots

Reveal.js fragments (`.fragment` class) are hidden by default.
To get a "fully revealed" screenshot for documentation:

```javascript
mcp__playwright__browser_evaluate({ function: `() => {
  document.querySelectorAll('.fragment').forEach(el => {
    el.classList.add('visible');
    el.classList.remove('fragment');
  });
}` })
```

To restore fragment state:
```javascript
mcp__playwright__browser_evaluate({ function: "() => location.reload(true)" })
```

---

## Playwright vs. BrowserMCP: Why Playwright Wins

| Capability | BrowserMCP | Playwright MCP |
|-----------|-----------|----------------|
| JavaScript execution | ✗ | ✓ — `evaluate()` runs any JS |
| Connection stability | Fragile — drops on CSS animation | Rock solid — headless Chromium |
| Browser extension required | Yes | No |
| Works with localhost | Unreliable | Yes |
| Screenshot timing | Race conditions | Deterministic |
| Console log access | ✗ | ✓ |
| Fragment control | ✗ | ✓ via JS |
| Slide navigation | URL hash only | URL hash + Reveal.js API |
| Reload after edits | ✗ | ✓ `location.reload(true)` |

The decisive advantage: `evaluate()` gives us the full Reveal.js JavaScript API.
We can drive `Reveal.slide()`, `Reveal.nextFragment()`, and get `Reveal.getState()`
without any keyboard/click actions — which eliminates all the connection drop scenarios.

---

## Known Limitations

- **Playwright screenshots save to `.playwright-mcp/`** — add this to `.gitignore` (or commit selectively)
- **Headless Chromium rendering** may differ slightly from the user's actual browser (Safari/Chrome). Font rendering and some CSS properties may vary.
- **Fonts load from CDN** — if offline, Google Fonts won't load and fallback fonts will be used in screenshots. This is acceptable for review purposes.
- **BrowserMCP is still available** — if the Playwright MCP server ever has issues, BrowserMCP can be re-enabled in settings.

---

## .gitignore Addition

```
# Playwright MCP screenshots (auto-generated review artifacts)
.playwright-mcp/
```

---

## Action Items

- [x] Playwright MCP configured and tested — Jérémie + Sonnet 4.6 (2026-02-28)
- [x] Add `.playwright-mcp/` to `.gitignore` — done (2026-02-28)
- [ ] Consider writing a review script that iterates all topic slide folders

**Open idea — screenshot archiving as visual audit trail:**
The `.playwright-mcp/` auto-generated screenshots are ephemeral (gitignored) but contain
valuable "before/after" evidence of visual review decisions. For significant review sessions,
curate the most meaningful screenshots (e.g., "broken Hinton timeline" → "fixed 3-box timeline")
and copy them to `sessions/YYYY-MM-DD/slides/screenshots/` or `topics/[topic]/assets/review-YYYY-MM-DD/`
before the session ends. This creates an intentional visual decision log without committing
every intermediate artifact. Not germane right now — revisit when the review workflow matures.

---

## Iterations

### Iteration 1 (2026-02-28)
- Human: Switched from BrowserMCP to Playwright after research by Sonnet 4.5.
  "You need to interact with Playwright is such a pleasure. They're like different leagues completely."
- AI: Documented the full workflow, comparison table, Mermaid review protocol, fragment management
- Outcome: Accepted

---

## Links

- Research prompt: `docs/BROWSERMCP_ALTERNATIVES_RESEARCH_PROMPT.md`
- Related ADR: 0005 (plugin selection — Playwright used to verify plugins)
- Playwright MCP: `npx @playwright/mcp@latest`
