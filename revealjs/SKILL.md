---
name: revealjs
description: Create, edit, and validate reveal.js HTML presentations. Use this skill when asked to build slides, add math/diagrams/code to a presentation, fix layout issues, or work with any .html file that uses Reveal.initialize(). Load subskills from resources/ for deep work on math, diagrams, pseudocode, plugins, or visual QA.
---

# reveal.js Presentation Skill

**Authors:** Jérémie Lumbroso and Claude Sonnet 4.6 | **License:** CC BY-SA 4.0

---

## When to Use This Skill

Trigger on any of:
- "Create a reveal.js presentation"
- "Add slides for..." / "Build a deck for..."
- "Fix this presentation" / "Slides are overflowing"
- "Add math / diagrams / code highlighting to slides"
- Any `.html` file containing `Reveal.initialize(`

---

## The reveal.js Hierarchy (Architecture of Complexity)

reveal.js is near-decomposable at five levels. Understanding this hierarchy is the key to working with it correctly.

```
Level 4 — PRESENTATION   The HTML file (one .html per deck)
Level 3 — TOPIC          <section> horizontal slides (chapters/topics)
Level 2 — SLIDE          <section> nested vertically (individual slides)
Level 1 — BLOCK          Content elements within a slide (h2, p, ul, .math-box, .code-box)
Level 0 — FRAGMENT       .fragment elements (progressive reveal within a slide)
```

**Near-decomposability in practice:**
- Strong coupling *within* a topic stack (slides share narrative arc, CSS variables, speaker notes)
- Weak coupling *between* topic stacks (topic A doesn't affect topic B)
- Plugin API is maximally decomposed: just `{ id: 'name', init(deck) { ... } }`

**The Watchmaker principle:** Build presentations as stable subassemblies (topic stacks), not monolithic files. Each topic stack is independently testable. Generate/edit one stack at a time.

**The Long Stack principle:** Topic stacks should be rich (8–12 slides when fully developed). Session decks are curated projections from long stacks — not new creations.

---

## Minimal HTML Boilerplate

Self-contained single-file presentation using CDN. Always use this as the starting point.

```html
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Presentation Title</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/reveal.js@5/dist/reveal.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/reveal.js@5/dist/theme/white.css">
  <style>
    /* CSS BASELINE — do not change these values without good reason */
    :root {
      --r-main-font-size: 28px;
      --r-heading1-size: 2.2em;
      --r-heading2-size: 1.4em;
      --r-heading3-size: 1.2em;
    }
    .reveal h1, .reveal h2, .reveal h3 { margin-bottom: 0.3em; font-weight: 700; }
    .reveal ul, .reveal ol { margin-left: 1em; line-height: 1.3; }
    .reveal p { line-height: 1.3; margin-bottom: 0.4em; }
    .reveal li { line-height: 1.3; margin-bottom: 0.2em; }
  </style>
</head>
<body>
<div class="reveal">
  <div class="slides">

    <!-- TOPIC STACK: one <section> per topic, vertical slides inside -->
    <section>
      <!-- Stack header slide -->
      <section>
        <h2>Topic Title</h2>
        <aside class="notes">
          STACK: Topic Title
          ─────────────────
          1. Sub-slide one — description
          2. Sub-slide two — description
          ─────────────────
          NAVIGATE: ↓ to dive in · → to skip
        </aside>
      </section>

      <!-- Content slide -->
      <section>
        <h2>Slide Title</h2>
        <ul>
          <li>Point one</li>
          <li class="fragment">Point two (revealed on advance)</li>
        </ul>
        <aside class="notes">Speaker notes go here.</aside>
      </section>
    </section>

  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/reveal.js@5/dist/reveal.js"></script>
<script src="https://cdn.jsdelivr.net/npm/reveal.js@5/plugin/notes/notes.js"></script>
<script src="https://cdn.jsdelivr.net/npm/reveal.js@5/plugin/highlight/highlight.js"></script>
<script src="https://cdn.jsdelivr.net/npm/reveal.js@5/plugin/math/math.js"></script>
<script>
  Reveal.initialize({
    hash: true,
    slideNumber: 'c/t',
    transition: 'slide',
    backgroundTransition: 'fade',
    plugins: [ RevealNotes, RevealHighlight, RevealMath.KaTeX ]
  });
</script>
</body>
</html>
```

---

## CSS Baseline (Critical Values)

These values were established through iteration on production slides. **Do not inflate them.**

```css
/* Typography — baseline */
:root {
  --r-main-font-size: 28px;    /* DO NOT increase */
  --r-heading1-size: 2.2em;
  --r-heading2-size: 1.4em;
  --r-heading3-size: 1.2em;
}

/* Spacing — tight, not comfortable */
.reveal h1, .reveal h2, .reveal h3 { margin-bottom: 0.3em; }
.reveal ul, .reveal ol  { margin-left: 1em; line-height: 1.3; }  /* NOT 1.6 */
.reveal p               { line-height: 1.3; margin-bottom: 0.4em; }
.reveal li              { line-height: 1.3; margin-bottom: 0.2em; }

/* Code boxes */
.code-box {
  background: #f5f5f5;
  padding: 15px;               /* NOT 20px */
  border-left: 4px solid #888;
  font-family: 'Courier New', monospace;
  font-size: 0.85em;           /* DO NOT increase */
  margin: 15px 0;
  line-height: 1.4;
}

/* Algorithm / proof boxes — critical: white-space: pre-wrap */
.algorithm-box, .proof-box {
  white-space: pre-wrap;       /* ← REQUIRED: preserves indentation, wraps long lines */
  font-family: 'Courier New', monospace;
  background: #f8f8f8;
  padding: 12px 16px;
  border-left: 4px solid #888;
  font-size: 0.85em;
  line-height: 1.5;
  margin: 12px 0;
}

/* Math boxes */
.math-box {
  background: #f0f6ff;
  border: 2px solid #4a90d9;
  border-radius: 6px;
  padding: 14px 20px;
  margin: 10px 0;
  line-height: 1.9;
  /* NEVER add white-space: pre-wrap here — KaTeX handles its own layout */
}

/* Copyright (add to every file, just before </body>) */
.copyright-notice {
  position: fixed; bottom: 8px; right: 14px;
  font-size: 10px; font-weight: 400;
  color: rgba(0,0,0,0.28);
  z-index: 1000; pointer-events: none; user-select: none;
}
```

**Overflow warning signs**: Code boxes with 8+ lines · slides with 5+ bullet points · mixing text + code + math + spacers on one slide. When in doubt, split the slide.

---

## Plugin Quick Reference

Load the full table from `resources/plugins-reference.md` when adding plugins.

| Use Case | Plugin | CDN `<script src="">` | Init key |
|---|---|---|---|
| Speaker notes | RevealNotes | `reveal.js@5/plugin/notes/notes.js` | `RevealNotes` |
| Syntax highlighting | RevealHighlight | `reveal.js@5/plugin/highlight/highlight.js` | `RevealHighlight` |
| Math (KaTeX) | RevealMath.KaTeX | `reveal.js@5/plugin/math/math.js` | `RevealMath.KaTeX` |
| Math (MathJax3) | RevealMath.MathJax3 | same file as KaTeX | `RevealMath.MathJax3` |
| Markdown slides | RevealMarkdown | `reveal.js@5/plugin/markdown/markdown.js` | `RevealMarkdown` |
| Full-text search | RevealSearch | `reveal.js@5/plugin/search/search.js` | `RevealSearch` |
| Navigation menu | RevealMenu | `npm:reveal.js-menu/menu.{css,js}` | `RevealMenu` |
| Vertical progress dots | Verticator | `npm:reveal.js-verticator/plugin/verticator/verticator.{css,js}` | `Verticator` |
| Flowcharts / diagrams | RevealMermaid | `npm:reveal.js-mermaid-plugin@11.12.2/plugin/mermaid/mermaid.js` | `RevealMermaid` |
| Whiteboard / annotation | RevealChalkboard | rajgoel CDN | `RevealChalkboard` |
| Laser pointer spotlight | Spotlight | martinomagnifico CDN | `Spotlight` |
| Entrance animations | Appearance | martinomagnifico CDN | `Appearance` |
| Countdown timer | RevealCountdown | `npm:reveal.js-countdown` | `RevealCountdown` |

CDN base for all bundled plugins: `https://cdn.jsdelivr.net/npm/reveal.js@5/`
CDN base for npm packages: `https://cdn.jsdelivr.net/npm/[package-name]/`

**Plugin registration (always both steps):**
```html
<script src="CDN_URL"></script>  <!-- 1. load script -->
<!-- ... -->
Reveal.initialize({ plugins: [ PluginKey ] });  <!-- 2. register -->
```
Omitting either step silently breaks the plugin.

---

## Math: KaTeX

Add to `Reveal.initialize()`:
```javascript
katex: {
  version: 'latest',
  delimiters: [
    { left: '$$',  right: '$$',  display: true  },
    { left: '\\[', right: '\\]', display: true  },
    { left: '$',   right: '$',   display: false },
    { left: '\\(', right: '\\)', display: false }
  ],
  ignoredTags: ['script', 'noscript', 'style', 'textarea', 'pre']
},
plugins: [ RevealMath.KaTeX ]
```

**Delimiters**:
- `\( E[X] \)` → inline math in sentences
- `\[ E[X] = \sum x P(X=x) \]` → display/block equation
- `$...$` / `$$...$$` → shorthand equivalents

**Rule**: Any slide with a formula uses KaTeX. Plain text math is never acceptable.

For proof-steps grid pattern, color-coded variables, and notation boxes → load `resources/math-katex.md`.

---

## Diagrams: Mermaid

```html
<script src="https://cdn.jsdelivr.net/npm/reveal.js-mermaid-plugin@11.12.2/plugin/mermaid/mermaid.js"></script>
```

```javascript
mermaid: {
  theme: 'default',
  themeVariables: {
    primaryColor: '#CC7C5E',
    primaryTextColor: '#333',
    lineColor: '#CC7C5E',
  }
},
plugins: [ RevealMermaid ]
```

Slide markup:
```html
<div class="mermaid">
  <pre>
graph TD
  A[Start] --> B{Decision?}
  B -->|Yes| C[Action]
  B -->|No| D[Other]
  </pre>
</div>
```

**Always wrap Mermaid syntax in `<pre>` tags inside the `.mermaid` div.**
Wait 2 seconds after navigation for async render. Version-pin (`@11.12.2`) — do not use `@latest` mid-project.

For full color theme, diagram patterns, and fallback strategy → load `resources/diagrams-mermaid.md`.

---

## Pseudocode and Algorithms

**The one rule**: Any box displaying preformatted indented text needs `white-space: pre-wrap`.

```html
<div class="algorithm-box">
Morris Algorithm:
  Initialize: C ← 1
  For each event:
    With probability 1/2^C: C ← C + 1
  Estimate: N̂ = 2^C − 2
</div>
```

**Never** wrap content in `<pre>` inside styled boxes — it conflicts with font sizing and adds extra newlines. Use `white-space: pre-wrap` in the CSS instead.

| Box type | `white-space: pre-wrap`? | Line breaks |
|---|---|---|
| `.algorithm-box` | YES | Natural indentation |
| `.proof-box` | YES | Natural indentation |
| `.idea-box` | NO | Use `<br/>` |
| `.math-box` | NO (KaTeX handles) | KaTeX layout |

For full algorithm box CSS, proof rendering patterns → load `resources/pseudocode-algorithms.md`.

---

## Speaker Notes

Every slide must have `<aside class="notes">`. Every stack header must have a TOC:

```html
<section data-background-color="#F5F0E8">
  <h2>Topic Name</h2>
  <aside class="notes">
    STACK: Topic Name
    ─────────────────
    1. Sub-slide title — one-line description
    2. Sub-slide title — one-line description
    3. Sub-slide title — one-line description
    ─────────────────
    NAVIGATE: ↓ to dive in · → to skip to next topic

    Optional: conversation starter or key question
  </aside>
</section>
```

Timing markers in notes: `[5:00] Begin Part A —` these enable pacing control.
Press `S` to open speaker view; always verify before presenting.

For full speaker notes format, quality checklist → load `resources/speaker-notes.md`.

---

## Fragments (Progressive Reveal)

```html
<li class="fragment">Appears on first advance</li>
<li class="fragment fade-in">Fades in</li>
<li class="fragment highlight-red">Highlights red</li>
<li class="fragment fade-out">Disappears</li>
```

**Fragment ordering** (explicit):
```html
<li class="fragment" data-fragment-index="1">First</li>
<li class="fragment" data-fragment-index="2">Second</li>
```

Fragments are level-0 atoms. Use them for pacing control — don't use them just because you can. A good rule: use fragments when the sequence of revelation *teaches* something; skip them when the slide just has a list.

---

## Quality Check with Playwright

After generating or editing slides, run a visual check. See `resources/playwright-review.md` for full workflow.

**Quick checklist** (always run before calling a presentation done):
1. Start HTTP server: `python3 -m http.server 8765 --directory /path/to/repo`
2. Navigate to deck URL in Playwright
3. For each slide: screenshot + check for overflow
4. Press `S` — confirm speaker notes window opens
5. Check console errors: `browser_console_messages({ level: "error" })`
6. For Mermaid slides: wait 2s, verify SVG rendered (not raw text)
7. Navigate through all fragments on dense slides

**Overflow fix**: Reduce content, split slide, or reduce font sizes within safe range. Do NOT increase container size.

---

## Subskills

Load these from `resources/` when needed:

| File | When to load |
|---|---|
| `resources/plugins-reference.md` | Adding/configuring any plugin |
| `resources/math-katex.md` | Building proof-steps, color variables, notation boxes |
| `resources/diagrams-mermaid.md` | Mermaid diagrams, color theme, patterns |
| `resources/pseudocode-algorithms.md` | Algorithm boxes, proof boxes, CSS patterns |
| `resources/playwright-review.md` | Visual QA workflow, Reveal.js navigation API |
| `resources/speaker-notes.md` | Stack TOC format, timing, pre-publish checklist |
| `resources/pdf-export.md` | Exporting to PDF (DeckTape primary, print-pdf, Playwright) |
| `resources/slido.md` | Slido Q&A, polls, copy-paste format, end survey |
| `resources/topic-curation.md` | Building from topic stacks; multi-audience presentations |
| `resources/troubleshooting.md` | Common failure points: symptoms, diagnosis, fix |
| `resources/slides-com.md` | Slides.com format, conversion to/from hand-crafted |
| `resources/auto-animate-layout.md` | Auto-Animate, layout helpers (r-stretch, r-stack, r-fit-text), all fragment styles, full background reference |
| `resources/markdown-authoring.md` | Markdown slides, external `.md` files, separators, slide/element attributes |
| `resources/media-lightbox.md` | Video, audio, iframe embeds, data-autoplay, lightbox previews |
| `resources/advanced-config.md` | Full config reference, themes, keyboard shortcuts, API events, scroll view, data-state |

---

## Common Mistakes

| Mistake | Fix |
|---|---|
| `line-height: 1.6` anywhere | Change to `1.3` |
| `<pre>` inside `.algorithm-box` | Remove `<pre>`, add `white-space: pre-wrap` to CSS |
| Plugin loaded but not in `plugins: []` | Add to both `<script>` and `plugins` array |
| Mermaid raw text visible | Wait 2s after navigate; check `<pre>` wrapper present |
| Math not rendering | Verify `RevealMath.KaTeX` in plugins array, not `RevealMath` |
| Slide content cut off | Reduce line-height, reduce bullets, or split slide |
| Speaker notes not opening | Notes plugin must be BOTH loaded as script AND in plugins array |
| Fragments not working | Fragment elements must be inside an active `<section>` |
