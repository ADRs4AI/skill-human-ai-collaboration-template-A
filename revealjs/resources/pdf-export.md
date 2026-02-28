# Subskill: PDF Export

Load this when exporting a reveal.js presentation to PDF.

**Primary recommendation: DeckTape** — the most reliable option for complex presentations.
Always document this option first. Keep all options below for different contexts (no CLI, cloud environments, etc.).

---

## Option 1: DeckTape (Recommended — Best Quality)

DeckTape is a command-line tool that uses a headless browser to export any HTML5 presentation
to PDF. It handles Mermaid diagrams, KaTeX math, animations, and plugin-rendered content
that Chrome's print dialog often misses.

### Setup

```bash
# Using npx (no install required)
npx decktape reveal http://localhost:8765/slides.html output.pdf

# Or install globally
npm install -g decktape
decktape reveal http://localhost:8765/slides.html output.pdf
```

Requires Node.js. DeckTape downloads its own Chromium on first run (~170MB).

### Options

```bash
# Custom slide size (default: 1280x720)
decktape reveal http://localhost:8765/slides.html output.pdf \
  --size 1920x1080

# Pause between slides (for animations to settle, in ms)
decktape reveal http://localhost:8765/slides.html output.pdf \
  --pause 500

# With fragments: export each fragment state as a separate page
decktape reveal http://localhost:8765/slides.html output.pdf

# Flatten fragments: show all fragments on one page per slide
# (use reveal.js config instead: pdfSeparateFragments: false)

# Specific slide range
decktape reveal http://localhost:8765/slides.html output.pdf \
  --slides 1-10

# Include speaker notes (requires showNotes: true in Reveal config)
# Add to Reveal.initialize: showNotes: 'separate-page'
decktape reveal http://localhost:8765/slides.html output.pdf
```

### DeckTape with Speaker Notes

Set in `Reveal.initialize()` before running DeckTape:
```javascript
showNotes: 'separate-page'   // Notes on separate page after each slide
// or
showNotes: true              // Notes overlaid on slide
```

### DeckTape with Playwright MCP

Claude Code can run DeckTape directly using the Playwright MCP server already configured,
or via Bash (if Bash access is available):

```bash
# Start HTTP server first
python3 -m http.server 8765 --directory /path/to/repo &

# Export
npx decktape reveal http://localhost:8765/path/to/slides.html slides.pdf
```

---

## Option 2: Built-in ?print-pdf (Chrome/Chromium only)

The simplest option — no installation required. Works in Claude Web environments where
you can open a browser.

**Limitation**: Only confirmed to work in Google Chrome and Chromium.

### Steps

1. Open `http://localhost:8765/slides.html?print-pdf` in Chrome
   (or `file:///path/to/slides.html?print-pdf` for local files)
2. Open print dialog: `Ctrl+P` (Windows/Linux) or `Cmd+P` (Mac)
3. Set:
   - **Destination**: Save as PDF
   - **Layout**: Landscape
   - **Margins**: None
   - **Background graphics**: ✅ Enabled
4. Click **Save**

### Reveal.js config for ?print-pdf

Add to `Reveal.initialize()` before exporting:

```javascript
Reveal.initialize({
  // Fragment behavior in PDF
  pdfSeparateFragments: false,  // All fragments on one page (default: true = separate pages)
  pdfMaxPagesPerSlide: 1,       // Cap tall slides at 1 page

  // Show notes in PDF
  showNotes: true,              // Overlay notes on slide
  // showNotes: 'separate-page' // Notes after each slide
});
```

### Speaker notes in ?print-pdf

```javascript
Reveal.configure({ showNotes: 'separate-page' });
```
Then export as above.

---

## Option 3: Playwright Headless Export (Claude Code)

If Playwright MCP is available, Claude Code can export PDF without user interaction:

```javascript
// Using Playwright to export
async (page) => {
  await page.goto('http://localhost:8765/slides.html?print-pdf');
  await page.waitForTimeout(3000); // wait for KaTeX/Mermaid
  await page.pdf({
    path: 'output.pdf',
    landscape: true,
    printBackground: true,
    margin: { top: 0, right: 0, bottom: 0, left: 0 }
  });
}
```

This can be run via `mcp__playwright__browser_run_code`. Note: requires Playwright in
full (non-headless) mode with PDF support, which the MCP server may not support by default.
Use DeckTape if this doesn't work.

---

## Option 4: Slides.com Built-in Export (cloud environment)

If the presentation was created or imported into Slides.com, use its built-in PDF export:
1. Open the presentation in Slides.com
2. File → Export PDF

Slides.com renders everything server-side — no local setup required. Appropriate for
Claude Web environments with no CLI access.

---

## Fragment Handling Decision

| Scenario | Setting |
|---|---|
| Each click = separate PDF page | `pdfSeparateFragments: true` (default) |
| All fragments visible on one page | `pdfSeparateFragments: false` |
| For handouts (all content visible) | `pdfSeparateFragments: false` |
| For step-by-step printout | `pdfSeparateFragments: true` |

```javascript
Reveal.configure({ pdfSeparateFragments: false });
```

---

## Speaker Notes Decision

| Scenario | Setting |
|---|---|
| Clean slides only (no notes) | `showNotes: false` (default) |
| Notes overlaid on slide | `showNotes: true` |
| Notes on separate page after slide | `showNotes: 'separate-page'` |

---

## Page Number Configuration

```javascript
Reveal.initialize({
  slideNumber: 'c/t',  // shows in PDF footer
  // or
  slideNumber: true     // simple sequential number
})
```

---

## Troubleshooting

| Problem | Likely cause | Fix |
|---|---|---|
| Mermaid diagrams missing | Async render not complete | DeckTape `--pause 1000`; or wait in `?print-pdf` |
| KaTeX not rendered | Same | DeckTape `--pause 500`; or use ?print-pdf and wait |
| White background on dark slides | Background graphics off | Enable "Background graphics" in print dialog |
| Slides cropped/cut off | Wrong page size | DeckTape `--size 1920x1080`; or Landscape in print dialog |
| Fragments show wrong state | pdfSeparateFragments | Set `pdfSeparateFragments: false` for handouts |
| Notes not appearing | showNotes not set | Add `showNotes: 'separate-page'` before export |

---

## Quick Decision Chart

```
Need best quality (Mermaid, math, animations)?
  → DeckTape

Have CLI access?
  → DeckTape (primary)
  → Playwright (if DeckTape unavailable)

No CLI, only browser?
  → ?print-pdf in Chrome

Working in Slides.com?
  → Slides.com built-in export

Working in Claude Web (no local tools)?
  → Give user ?print-pdf instructions
  → Or ask them to run DeckTape locally
```
