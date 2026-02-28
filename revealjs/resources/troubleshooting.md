# Subskill: Troubleshooting — Common Failure Points

Load this when something isn't working. Each entry has: **Symptom → Diagnosis → Fix**.

These were identified through Playwright dogfooding on real sample presentations
(2026-02-28). The patterns repeat across decks.

---

## The Big One: `ReferenceError: Reveal is not defined`

**Symptom**: Presentation loads as plain HTML. No slideshow, no transitions, no Reveal.js API.
Playwright `evaluate(() => Reveal.getState())` throws `ReferenceError`.
Console shows: `Failed to load resource: 404 — dist/reveal.js`

**Diagnosis**: The HTML references reveal.js via a **relative local path** that no longer resolves:
```html
<!-- These break when moved to a different directory -->
<script src="../../dist/reveal.js"></script>
<link rel="stylesheet" href="../../dist/reveal.css">
<script src="../../plugin/notes/notes.js"></script>
```
This happens when a presentation was built inside a local `reveal.js/` repository clone.
Moving the file, or serving from a different root, breaks all relative paths.

**Fix**: Replace all local paths with CDN:
```html
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/reveal.js@5/dist/reveal.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/reveal.js@5/dist/theme/white.css">
<script src="https://cdn.jsdelivr.net/npm/reveal.js@5/dist/reveal.js"></script>
<script src="https://cdn.jsdelivr.net/npm/reveal.js@5/plugin/notes/notes.js"></script>
<script src="https://cdn.jsdelivr.net/npm/reveal.js@5/plugin/highlight/highlight.js"></script>
<script src="https://cdn.jsdelivr.net/npm/reveal.js@5/plugin/math/math.js"></script>
```

**Diagnosis script** (run in Playwright):
```javascript
() => document.querySelectorAll('script[src], link[rel=stylesheet]')
  .length > 0 ? 'scripts present' : 'no scripts'
// Then check console errors for 404s
```

---

## Plugin Loads but Doesn't Work

**Symptom**: Plugin behavior absent. No menu, no speaker notes, no Verticator dots, etc.
No console errors.

**Diagnosis**: Plugin script is loaded via `<script>` but NOT registered in `plugins: []`.
This is the most common plugin mistake — both steps are required.

```html
<!-- Step 1 is present: -->
<script src=".../menu.js"></script>

<!-- Step 2 is MISSING: -->
Reveal.initialize({
  plugins: [ RevealNotes ]  // ← RevealMenu not listed here
});
```

**Fix**: Add the plugin key to `plugins: []`:
```javascript
Reveal.initialize({
  plugins: [ RevealNotes, RevealMenu, RevealHighlight, RevealMath.KaTeX ]
  //                      ↑ add here
});
```

**Quick check**: open browser console and type the plugin's global name (e.g., `RevealMenu`).
If it's defined but not working, it's missing from `plugins[]`.

---

## Speaker Notes Window Doesn't Open

**Symptom**: Pressing `S` does nothing, or popup is immediately closed.

**Two separate causes:**

**Cause A — Plugin not loaded at all:**
`RevealNotes` is missing from either the `<script>` tag OR the `plugins: []` array.
(Both are required — see above.)

**Cause B — Browser blocked the popup:**
Browser popup blocker prevents the speaker notes window.
**Fix**: Allow popups for `localhost` in browser settings. Chrome: lock icon → Site settings → Pop-ups → Allow.

**Diagnostic**:
```javascript
// In Playwright: check if notes plugin registered
() => Reveal.hasPlugin('notes')
// Returns true if registered, false if not
```

---

## Mermaid Diagram Shows as Raw Text

**Symptom**: Instead of a rendered diagram, you see the raw Mermaid syntax as text in the slide.

**Cause A — Missing `<pre>` wrapper:**
```html
<!-- WRONG — no <pre> wrapper -->
<div class="mermaid">
  graph TD
    A --> B
</div>

<!-- RIGHT — <pre> is required -->
<div class="mermaid">
  <pre>
  graph TD
    A --> B
  </pre>
</div>
```

**Cause B — Render not complete yet (async):**
Mermaid renders asynchronously after slide load. If you screenshot immediately after navigating, the diagram hasn't rendered yet.

**Fix**: Wait 2 seconds after navigation:
```javascript
await mcp__playwright__browser_evaluate({ function: '() => Reveal.slide(2, 0)' });
await mcp__playwright__browser_wait_for({ time: 2 });
await mcp__playwright__browser_take_screenshot({ type: 'png' });
```

**Diagnostic**:
```javascript
() => Array.from(document.querySelectorAll('.mermaid')).map(d => ({
  hasSvg: !!d.querySelector('svg'),
  text: d.textContent.slice(0, 40)
}))
// hasSvg: false → not rendered; hasSvg: true → ok
```

---

## Math Not Rendering (Raw LaTeX Visible)

**Symptom**: `\( E[X] \)` appears as literal text, not rendered math.

**Cause A — Wrong plugin key in `plugins: []`:**
```javascript
// WRONG:
plugins: [ RevealMath ]         // ← not a valid key

// RIGHT:
plugins: [ RevealMath.KaTeX ]   // ← must specify renderer
// or:
plugins: [ RevealMath.MathJax3 ]
```

**Cause B — katex config block missing:**
```javascript
// Needs both the plugins entry AND optionally the config:
katex: {
  version: 'latest',
  delimiters: [
    { left: '\\(', right: '\\)', display: false },
    { left: '\\[', right: '\\]', display: true },
  ]
},
plugins: [ RevealMath.KaTeX ]
```

**Cause C — Delimiter conflict:**
KaTeX's `$...$` inline delimiter conflicts with currency signs. If dollar signs in text are triggering failed renders, disable the `$` delimiter and use only `\(...\)`.

---

## Content Cut Off at Bottom (Overflow)

**Symptom**: Slide content is cut at the bottom. Last bullet point or code line is invisible.

**Causes** (in order of frequency):
1. `line-height: 1.6` — default or explicitly set. Change to `1.3`.
2. Too many bullet points (>5 on one slide)
3. Code box too large (>8 lines with default font size)
4. Mixing text + code + math + spacers without checking budget

**Diagnostic**:
```javascript
() => Array.from(document.querySelectorAll('.reveal .slides section'))
  .map((s, i) => ({ i, overflows: s.scrollHeight > s.clientHeight + 5 }))
  .filter(s => s.overflows)
// Returns indices of overflowing slides
```

**Fixes** (in order of preference):
1. Split into two sub-slides
2. Remove one bullet (combine into one)
3. Reduce code box font: `font-size: 0.78em` (minimum acceptable)
4. Reduce spacer margins: `15px → 8px`

Never increase container size. Never reduce `--r-main-font-size` below `24px`.

---

## Slides.com Export: Images Not Loading

**Symptom**: Slides.com offline export shows placeholder boxes instead of images.

**Diagnosis**: Slides.com offline export bundles images in a sibling folder named after the
presentation. The `index.html` must stay in the same directory as that folder.

```
slides_my-talk/
├── index.html                 ← the presentation
└── my-talk/                   ← images folder (must be here, same level)
    ├── abc123.png
    └── def456.jpg
```

Moving `index.html` out of the folder breaks all image references.

**Fix**: Always keep `index.html` together with its sibling assets folder. Zip them as a unit.

---

## HTTP Server Port Already in Use

**Symptom**: `OSError: [Errno 48] Address already in use` when starting `python3 -m http.server`.
Playwright can't connect, or connects to wrong server (different project's directory).

**Diagnosis**: Another process is already using the port. May be a previous server from an
earlier session or a different project.

**Fix**:
```bash
# Find and kill the process on port 8765
lsof -ti:8765 | xargs kill -9

# Then restart
python3 -m http.server 8765 --directory /path/to/project
```

Or use a different port (`8766`, `8767`, etc.) and update your Playwright URL accordingly.

**Verification**: After starting, confirm you're serving the right directory:
```javascript
// Navigate to root and check what's listed
await mcp__playwright__browser_navigate({ url: 'http://localhost:8765/' });
// Should show your project's files, not some other project's
```

---

## Algorithm Box / Pseudocode Shows on One Line

**Symptom**: Multi-line algorithm or pseudocode collapses to a single line, losing all indentation.

**Diagnosis**: Missing `white-space: pre-wrap` on the container. HTML collapses whitespace by default.

**Fix**: Add to the box's CSS:
```css
.algorithm-box {
  white-space: pre-wrap;  /* ← REQUIRED */
}
```

Or if the box uses `<pre>` inside a styled container, remove the `<pre>` and add `white-space: pre-wrap` to the container CSS. See `resources/pseudocode-algorithms.md`.

---

## Fragments Don't Animate

**Symptom**: All content is visible at once; `.fragment` elements don't hide/reveal on advance.

**Causes:**
1. Fragment elements outside an active `<section>`
2. Reveal.js not loaded (see first entry above)
3. Using Playwright's `evaluate` to reveal all fragments (intentional — see `playwright-review.md`)

For actual delivery: confirm by opening the presentation in a browser without Playwright scripting.

---

## Navigation Arrows Missing / Presenter Lost

**Symptom**: Can't tell which direction to navigate; audience following in wrong order.

**Quick fixes:**
- Add `slideNumber: 'c/t'` to `Reveal.initialize()` — shows "3 / 54" in corner
- Install Verticator for vertical position dots
- Ensure every stack header has the NAVIGATE note in speaker notes (see `speaker-notes.md`)

---

## Quick Diagnostic Checklist (run in Playwright)

```javascript
// 1. Is Reveal loaded?
() => typeof Reveal !== 'undefined'

// 2. Which plugins are registered?
() => Reveal.getPlugins().map(p => p.id)

// 3. Any overflowing slides?
() => Array.from(document.querySelectorAll('.reveal .slides section'))
  .map((s,i) => ({i, over: s.scrollHeight > s.clientHeight+5})).filter(s=>s.over)

// 4. Mermaid rendered?
() => Array.from(document.querySelectorAll('.mermaid'))
  .map(d => ({ ok: !!d.querySelector('svg'), text: d.textContent.slice(0,30) }))

// 5. Console errors?
// mcp__playwright__browser_console_messages({ level: 'error' })
```
