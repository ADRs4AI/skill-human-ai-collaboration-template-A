# Subskill: Playwright MCP Visual Quality Review

Load this when checking slides for overflow, rendering errors, or layout issues. Requires Playwright MCP configured in `.mcp.json`.

---

## Why Playwright, Not BrowserMCP

| Capability | BrowserMCP | Playwright MCP |
|---|---|---|
| `evaluate()` (JS execution) | ❌ | ✅ — full Reveal.js API |
| Connection stability | Fragile | Rock solid |
| Works with localhost | Unreliable | ✅ |
| Screenshot timing | Race conditions | Deterministic |
| Console log access | ❌ | ✅ |
| Fragment control via JS | ❌ | ✅ |
| Reload after file edits | ❌ | ✅ |

**Decisive advantage**: `evaluate()` gives programmatic access to the Reveal.js API without keyboard/click fragility.

---

## Step 0: Start HTTP Server

Reveal.js requires HTTP (not `file://`) for plugin CDNs and font loading:

```bash
# From repo root — serves entire repo
python3 -m http.server 8765 --directory .

# Or from the slide directory
python3 -m http.server 8765 --directory /path/to/slides/
```

Presentation URL: `http://localhost:8765/path/to/presentation.html`

---

## Step 1: Navigate to the Deck

```javascript
mcp__playwright__browser_navigate({
  url: "http://localhost:8765/path/to/slides.html"
})
```

To jump directly to a slide: `#/[horizontal]/[vertical]/[fragment]`
```
http://localhost:8765/slides.html#/0/0     → first slide
http://localhost:8765/slides.html#/2/3     → topic 2, slide 3
http://localhost:8765/slides.html#/1/2/1   → topic 1, slide 2, fragment 1
```

---

## Step 2: Reveal.js Navigation API

All of these are called via `mcp__playwright__browser_evaluate`:

```javascript
// Jump to slide at position (h, v)
() => Reveal.slide(2, 3)

// Navigate
() => Reveal.next()              // advance one step (fragment or slide)
() => Reveal.prev()              // go back one step
() => Reveal.nextFragment()      // reveal next fragment only
() => Reveal.prevFragment()      // hide last fragment

// Get current state
() => Reveal.getState()
// Returns: { indexh: 2, indexv: 3, indexf: 0, paused: false }

// Get all slides
() => Reveal.getSlides().length

// Hard reload (after editing HTML files)
() => location.reload(true)
// Then wait: mcp__playwright__browser_wait_for({ time: 2 })
```

---

## Step 3: Screenshot and Inspect

```javascript
// Take screenshot
mcp__playwright__browser_take_screenshot({ type: "png" })

// Or save to file
mcp__playwright__browser_take_screenshot({
  type: "png",
  filename: "docs/screenshots/2026-02-28-slide-03.png"
})
```

**What to look for in screenshots**:
- Content cut off at bottom → overflow
- Text wrapping mid-word in code/algorithm blocks → missing `white-space: pre-wrap`
- Raw Mermaid text instead of diagram → rendering failure
- Overlapping elements → CSS collision
- Missing fonts (fallback serif visible) → font CDN not loaded

---

## Step 4: Reveal All Fragments (Full Content View)

To see a slide's full content (all fragments visible):

```javascript
() => {
  const slide = Reveal.getCurrentSlide();
  slide.querySelectorAll('.fragment').forEach(el => {
    el.classList.add('visible');
    el.classList.remove('fragment');
  });
}
```

---

## Step 5: Check Console Errors

```javascript
mcp__playwright__browser_console_messages({ level: "error" })
```

Common errors:
- `Failed to load resource` → CDN URL wrong or unreachable
- `Reveal is not defined` → script loading order issue
- `RevealMermaid is not defined` → Mermaid plugin not loaded
- KaTeX errors → malformed LaTeX syntax

---

## Step 6: Verify Mermaid Rendering

```javascript
() => {
  const divs = document.querySelectorAll('.mermaid');
  return Array.from(divs).map(d => ({
    hasSvg: !!d.querySelector('svg'),
    textPreview: d.textContent.substring(0, 60)
  }));
}
```

- `hasSvg: true` → rendered correctly
- `hasSvg: false` → failed, raw text visible → check syntax at mermaid.live

Always wait 2 seconds after navigating to a Mermaid slide before checking.

---

## Full Review Workflow

```
1. Start HTTP server
2. Navigate to deck
3. For each topic stack:
   a. Navigate to stack header: Reveal.slide(h, 0)
   b. Screenshot — check for obvious issues
   c. For each sub-slide:
      - Reveal.slide(h, v)
      - Reveal all fragments
      - Screenshot
      - Check for overflow (content cut at bottom)
4. Check console errors
5. Test speaker notes: press S key (or verify notes exist)
6. Check Mermaid diagrams
7. Note issues → fix → reload → re-check
```

---

## Overflow Detection

The most common issue. A slide overflows when content height > viewport height (700px typical).

**Detect programmatically**:
```javascript
() => {
  const slides = document.querySelectorAll('.reveal .slides section');
  return Array.from(slides).map((s, i) => ({
    index: i,
    scrollHeight: s.scrollHeight,
    clientHeight: s.clientHeight,
    overflows: s.scrollHeight > s.clientHeight
  })).filter(s => s.overflows);
}
```

Returns list of overflowing slides with their indices.

**Fix overflow (in order of preference)**:
1. Split slide into two sub-slides
2. Remove one bullet point (combine two into one)
3. Reduce code box to key lines only
4. Reduce `.code-box` font from 0.85em to 0.78em (minimum acceptable)
5. Reduce spacer margins from 15px to 8px

Never: increase the container, reduce body font below 24px, or remove speaker notes to save space.

---

## Screenshot Archiving

Save screenshots as visual documentation:

```
docs/screenshots/
├── YYYY-MM-DD-[deck-name]-slide-[N].png
├── YYYY-MM-DD-[deck-name]-overflow-found.png    (before fix)
└── YYYY-MM-DD-[deck-name]-overflow-fixed.png    (after fix)
```

This creates a visual changelog that complements git history.
