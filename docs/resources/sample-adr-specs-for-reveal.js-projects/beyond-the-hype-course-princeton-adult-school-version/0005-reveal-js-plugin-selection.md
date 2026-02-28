# ADR 0005: Reveal.js Plugin Selection

- **Date**: 2026-02-28
- **Iteration**: 2
- **Status**: Accepted (updated after live testing 2026-02-28)
- **Deciders**: Jérémie Lumbroso, Claude Sonnet 4.6

---

## Quick Reference

```bash
# Check currently active plugins in a slide deck
grep -i "plugin" sessions/*/slides/*.html | grep "new Reveal\|Reveal.initialize"

# Find all slides not yet updated with new plugins
grep -rL "Verticator" sessions/*/slides/*.html topics/*/slides/*.html
```

---

## Context

After Session 1 (2026-02-27), several problems were identified that plugins can solve:

1. **Flying blind in stacks** (ADR 0001): no visual indicator of stack depth or position
2. **No laser pointer for Zoom**: can't direct audience attention on screen-share
3. **No way to draw on slides**: Zoom annotations are lost after session; no save
4. **No diagrams**: Jevons paradox, Freire banking model, ATM employment charts all need visuals
5. **No session timing**: Slido response windows and section transitions need timers
6. **Navigation in large decks**: as the topic library grows, jumping between stacks needs a menu

Research source: `docs/REVEAL_JS_PLUGINS.md` (deep research report, February 2026).

---

## Selected Plugins

### 1. Verticator (Martinomagnifico)

**Problem solved**: Flying blind — no way to see stack depth or current position without unspooling slides (ADR 0001, primary complaint from Session 1).

**What it does**: Displays small dots on the side of the slide showing vertical position within a stack. At a glance: how many sub-slides exist, which one you're on.

**Why this one**: Directly designed for the vertical-stack navigation pattern. Lightweight (no heavy dependencies). TypeScript rewrite as of February 2026 — actively maintained.

**CDN**: `https://cdn.jsdelivr.net/npm/reveal.js-verticator/plugin/verticator/verticator.{css,js}`
**npm**: `reveal.js-verticator`
**Stars**: ⭐49 · Martinomagnifico

```javascript
// Configuration
verticator: {
  color: '#E07340',       // Princeton Adult School orange
  position: 'auto',
  clickable: true,        // click dots to jump to sub-slide
  tooltip: 'auto',        // show slide title on hover
}
```

---

### 2. Menu (Greg Denehy)

**Problem solved**: Navigating a large deck of topic stacks by name, not by counting arrow presses. Especially useful in the question-scaffolded format where you jump to uncovered stacks on demand.

**What it does**: Slideout panel (hamburger menu or keyboard shortcut) showing all slide titles with navigation. Also enables theme switching and transition selection from the UI.

**Why this one**: Most popular community navigation plugin (⭐286). Well-maintained. Works naturally with the vertical stack structure.

**CDN**: `https://cdn.jsdelivr.net/npm/reveal.js-menu/menu.{css,js}`
**npm**: `reveal.js-menu`
**Stars**: ⭐286 · Greg Denehy

```javascript
menu: {
  side: 'left',
  width: 'normal',
  numbers: false,
  titleSelector: 'h2, .topic-title',   // picks up our lowercase topic titles
  useTextContentForMissingTitles: true,
  hideMissingTitles: false,
  keyboard: true,
  custom: false,
  themes: false,      // keep our PAS theme fixed
  transitions: false,
  openButton: true,
  openSlideNumber: false,
  loadIcons: true,
}
```

---

### 3. Spotlight

**Problem solved**: No laser pointer for Zoom teaching. Can't direct audience attention on screen-share without a visual pointer.

**What it does**: Configurable spotlight/halo effect that follows the mouse cursor. Toggle with a key, size and color configurable. Works in full-screen mode and in browser-based screen shares.

**Why this one**: Specifically designed for presentation use. Simpler and more reliable than the Leap Motion / webcam plugins. No external hardware required.

**CDN**: `https://cdn.jsdelivr.net/npm/reveal.js-spotlight/plugin/spotlight.js`
**npm**: `reveal.js-spotlight`
**Stars**: ⭐28

```javascript
spotlight: {
  size: 60,
  presentingCursor: 'none',     // hide cursor in spotlight mode
  initialPresentationMode: false,
  disablingUserSelect: true,
  fadeEasing: 'ease',
  fadeDuration: 100,
  lockPointerInsideCanvas: false,
}
// Toggle spotlight: hold down Alt (or configure keyboard shortcut)
```

---

### 4. Mermaid (reveal.js-mermaid-plugin)

**Problem solved**: Need for diagrams that are version-controllable and editable as text:
- Jevons paradox curve (efficiency vs. total consumption)
- Freire banking model vs. problem-posing diagram
- ATM/teller employment growth chart (Bessen)
- Cybernetic vs. epistemic two-path diagram

**What it does**: Renders Mermaid diagram syntax inline in slides. Supports flowcharts, sequence diagrams, XY charts (for data curves), class diagrams, mindmaps, and more.

**Why this one**: Text-based = version-controllable; no image assets to manage for conceptual diagrams. Actively maintained (npm v11.6.0). The XY chart type added in Mermaid v10 can render the Jevons paradox data.

**CDN**: `https://cdn.jsdelivr.net/npm/reveal.js-mermaid-plugin/plugin/mermaid/mermaid.js`
**npm**: `reveal.js-mermaid-plugin`

```html
<!-- Example: Jevons Paradox curve in a slide -->
<section data-background-color="#B3E5FC">
  <h3>labor · jevons paradox</h3>
  <h2>The Efficiency Trap</h2>
  <div class="mermaid">
    xychart-beta
      title "Jevons Paradox: Steam Engine Efficiency vs Coal Consumption"
      x-axis ["1800","1820","1840","1860","1880"]
      line [100, 85, 70, 55, 40]
      line [100, 130, 180, 260, 400]
  </div>
</section>
```

---

### 5. Chalkboard (rajgoel/reveal.js-plugins)

**Problem solved**: Zoom's annotation tool is lost after every session. No way to draw attention to specific slide elements or build diagrams live. No persistent record.

**What it does**: Two modes — (1) draw/annotate directly on slides, (2) full blank whiteboard. **Drawings save to JSON files** and can be reloaded in future sessions. Color picker, eraser, undo. Works with mouse, stylus, or touch.

**Why this one**: Save/load of annotations is the key differentiator — genuinely better than Zoom. The saved JSON files can be committed to git (small text files, version-controllable). Can annotate the Jevons diagram live while explaining it.

**npm**: `reveal.js-plugins` (collection package)
**Stars**: ⭐789 for the full collection

```javascript
chalkboard: {
  boardmarkerWidth: 3,
  chalkWidth: 7,
  chalkEffect: 0.5,
  storage: '.chalkboard-data',   // save/load from local JSON
  src: null,                      // load pre-drawn annotations: 'session-drawings.json'
  readOnly: false,
  transition: 800,
  theme: "whiteboard",            // "chalkboard" or "whiteboard"
  background: ['rgba(127,127,127,.1)', path + 'img/blackboard.png'],
  grid: false,
  eraser: { src: path + 'img/sponge.png', radius: 20 },
  boardmarkers: [
    { color: 'rgba(224,115,64,1)',  cursor: 'url(img/boardmarker-orange.png), auto'},
    { color: 'rgba(27,58,107,1)',   cursor: 'url(img/boardmarker-blue.png), auto'},
    { color: 'rgba(255,255,255,1)', cursor: 'url(img/boardmarker-white.png), auto'},
  ],
}
// Keyboard: B = toggle, DEL = clear, D = download drawings
```

**Annotation file convention**: Save per-session files as:
`sessions/YYYY-MM-DD-[slug]/slides/chalkboard-annotations.json`

---

### 6. Countdown (reveal.js-countdown)

**Problem solved**: No way to signal Slido response windows ("you have 2 minutes to type your question"), exercise time, or session-section timing. Running timing purely in your head while also presenting.

**What it does**: Per-slide countdown timer shown on the slide. Configurable per slide with `data-countdown` attribute. Audio alert when timer expires.

**npm**: `reveal.js-countdown`

```html
<!-- Put on the Slido opening question slide -->
<section data-countdown="180">   <!-- 3 minutes -->
  <h2>What brought you here tonight?</h2>
  <div class="slido-box">...</div>
</section>
```

---

### 7. Appearance (Martinomagnifico)

**Problem solved**: The fragment system (reveal.js built-in) is binary — items appear all at once. Entrance animations make topic header slides and key reveals feel more considered.

**What it does**: PowerPoint-style entrance animations using Animate.css. Per-element animation classes, configurable delay and duration. More granular than fragments.

**Why this one**: Specifically designed to complement fragments, not replace them. Handles the cases where you want a smooth entrance rather than a snap appearance.

**CDN**: `https://cdn.jsdelivr.net/npm/reveal.js-appearance/plugin/appearance/appearance.js`
**npm**: `reveal.js-appearance`
**Stars**: ⭐127 · Martinomagnifico

```html
<!-- Example: topic title slides -->
<section data-background-color="#C8E6C9">
  <p class="topic-title animate__animated" data-appear-class="animate__fadeInDown">
    the eager intern
  </p>
</section>
```

---

## Not Selected (and Why)

| Plugin | Reason not selected |
|--------|---------------------|
| RevealSearch | Low value for conversational format; slides are not reference material |
| Multiplex / Notes Server | Slido handles audience interaction; Zoom handles speaker view |
| D3/Vega integrations | Mermaid is sufficient; D3 adds complexity for conceptual diagrams |
| wave-plugin / gamepad | Not relevant to this context |
| Analytics (reveal-ga) | Privacy concerns with audience data; not needed |
| LiveCode / ACE editor | No code teaching in this course |
| Quarto extensions | Not using Quarto; stay with plain Reveal.js |

---

## Installation Decision: CDN vs. Local

**Short term**: CDN for all plugins (consistent with current reveal.js CDN approach). Requires internet. Acceptable for Zoom sessions where internet is a prerequisite anyway.

**Medium term**: When reveal.js is cloned locally (per original plan), install all plugins via npm and reference locally. This ensures the session works if internet drops during presentation.

**Convention for CDN loading**:
```html
<!-- In <head>, after reveal.js CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/reveal.js-verticator/plugin/verticator/verticator.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/reveal.js-menu/menu.css">

<!-- Before </body>, after reveal.js scripts -->
<script src="https://cdn.jsdelivr.net/npm/reveal.js-verticator/plugin/verticator/verticator.js"></script>
<script src="https://cdn.jsdelivr.net/npm/reveal.js-menu/menu.js"></script>
<script src="https://cdn.jsdelivr.net/npm/reveal.js-spotlight/plugin/spotlight.js"></script>
<script src="https://cdn.jsdelivr.net/npm/reveal.js-mermaid-plugin/plugin/mermaid/mermaid.js"></script>
<script src="https://cdn.jsdelivr.net/npm/reveal.js-appearance/plugin/appearance/appearance.js"></script>
<!-- Chalkboard requires local install from rajgoel collection -->
<!-- Countdown: <script src="https://cdn.jsdelivr.net/npm/reveal.js-countdown/countdown.js"></script> -->
```

---

## Priority Order for Implementation

1. **Verticator** — solves the most painful problem (flying blind); add to ALL decks first
2. **Spotlight** — essential for Zoom; add to all decks
3. **Mermaid** — needed before building Jevons/Freire diagrams
4. **Menu** — add when building Session 2 deck
5. **Chalkboard** — add when setting up for next live session
6. **Countdown** — add to Slido slides specifically
7. **Appearance** — polish pass; add last

---

## Action Items

- [ ] Add Verticator + Spotlight to index-v2.html as a new v4 draft — Sonnet 4.6
- [ ] Test Mermaid rendering locally before committing to Jevons/Freire diagram approach
- [ ] Decide: clone reveal.js locally now, or wait until next session cycle?
- [ ] For Chalkboard: create `sessions/2026-02-27-pas/slides/chalkboard-annotations.json` as empty stub
- [ ] Update `.gitignore` if any plugin has large auto-generated assets

---

## Live Testing Results (2026-02-28, v4 first deployment)

### Menu — outstanding; one bug, one enhancement needed

**Result: Exceeds expectations.** The slideout menu is available in BOTH the main window
and the speaker notes window — making it the best navigation tool for complex sessions.

**The `slide-menu-item-vertical` detail**: sub-slides within a vertical stack are indented
and visually distinguished in the menu. Stack structure is perfectly preserved.

**Past/active/future state tracking**: the menu uses `past` / `active` / `future` CSS classes
to show which slides have been visited. This becomes a live session map.

**Bug: Question card titles appear as "from a participant..."** — the menu picks up the
`data-menu-title` attribute if present, or falls back to the first heading/text content.
Question cards have no heading, so they show the label text instead of the question.

**Fix:** Add `data-menu-title` attribute to each question `<section>` with a truncated excerpt
of the question text:
```html
<section data-background-color="#E8EDF5"
         data-menu-title="&quot;I want to know what is true...&quot;">
```

**Critical principle: Slide titles matter.** The menu title comes from `h2`, `.topic-title`,
or `data-menu-title`. Every slide should have a meaningful, unique title. Generic labels
("from a participant...") collapse into noise in the menu. For question cards, always use
`data-menu-title` with a short excerpt of the question.

### Menu — color configuration

The menu inherits from the reveal.js CSS theme variables. No manual color override needed
for the PAS theme because our variables map cleanly:

```css
/* The menu uses these reveal.js CSS variables automatically: */
--r-background-color: #FAF8F4;  /* menu panel background */
--r-main-color:       #2C2C2C;  /* menu item text */
--r-heading-color:    #1B3A6B;  /* section headings in menu */
--r-link-color:       #E07340;  /* active item, hover highlight */
```

To override menu colors explicitly (if needed in future sessions):
```css
.reveal .slide-menu {
  background: #FAF8F4;
  color: #2C2C2C;
}
.reveal .slide-menu .slide-menu-item.active .slide-menu-item-title {
  color: #E07340;  /* PAS orange for current slide */
}
.reveal .slide-menu .slide-menu-item:hover {
  background: rgba(224, 115, 64, 0.08);
}
```

### Verticator — color configuration

Verticator's dot color is set via the `verticator.color` config option and via a CSS variable:

```javascript
verticator: {
  color: '#E07340',  // active dot color (PAS orange)
  // hover: tooltip title automatically matches the slide's h2/.topic-title text
  // inactive dots: verticator.css handles opacity (typically 0.3 opacity of active color)
}
```

To override inactive dot opacity or hover color via CSS:
```css
/* Active dot */
.verticator li.active a { background-color: #E07340 !important; }
/* Inactive dots */
.verticator li a { background-color: #E07340; opacity: 0.3; }
/* Hover tooltip */
.verticator li:hover a { opacity: 0.7; }
```

The tooltip text on hover comes from the slide's accessible name (h2 or `.topic-title`).
This reinforces the principle: **meaningful slide titles matter for Verticator tooltips too**.

### Spotlight — important speaker notes limitation (BUG)

**Problem**: Spotlight works in the presenter's browser window. It does NOT propagate to
the main display when using Reveal.js speaker notes view.

The speaker notes window and the main presentation window are separate browser contexts.
The spotlight overlay is CSS-rendered in the speaker window only. When Jérémie toggles
spotlight in the speaker notes window, the audience sees no spotlight on the main screen.
The presenter thinks they're pointing; the audience sees nothing. **Actively misleading.**

**Root cause**: Spotlight state needs to be communicated from the speaker window to the
main presentation window via `BroadcastChannel` or Reveal.js state sync API. The current
inline implementation does not do this.

**Fix (future):** Use Reveal.js's built-in state synchronization:
```javascript
// In the main window, listen for spotlight state from speaker:
Reveal.on('state', state => {
  if (state.spotlight) document.body.classList.add('spotlight-on');
  else document.body.classList.remove('spotlight-on');
});
```
Or use `BroadcastChannel` to sync the mouse position.

**Workaround until fixed:** Use Zoom's built-in spotlight/annotation tool for audience
interaction (it works at the screen-share level, not the browser level).

**GitHub issue**: This should be filed as a known limitation in the repo's issues.
TODO: file issue at github.com/jlumbroso/beyond-the-hype with this analysis.

### Spotlight — CDN availability

`reveal.js-spotlight` is NOT available on jsDelivr or unpkg (both return 404).
Current solution: 15-line inline CSS+JS implementation in the HTML `<head>` and `<script>`.
This is intentional — it removes CDN dependency and works offline.
See the inline implementation in v4 slides for the reference pattern.

---

## Updated Action Items

- [x] Verticator + Menu + Spotlight added to v4 — Sonnet 4.6 (2026-02-28)
- [x] Fix question card `data-menu-title` attributes in v4 — Sonnet 4.6 (2026-02-28)
- [ ] File GitHub issue: spotlight doesn't propagate to main window from speaker notes
- [ ] Test Mermaid rendering locally before committing to Jevons/Freire diagram approach
- [ ] Decide: clone reveal.js locally now, or wait until next session cycle?
- [ ] For Chalkboard: create `sessions/2026-02-27-pas/slides/chalkboard-annotations.json` stub

---

## Iterations

### Iteration 1 (2026-02-28)
- Human: Reviewed plugin research doc; confirmed all 7 selections; noted chalkboard save > Zoom annotations
- AI: Drafted ADR with all justifications, configuration snippets, CDN/local decision
- Outcome: Accepted

### Iteration 2 (2026-02-28)
- Human: Deployed v4, tested live. Menu described as "legendary" and "mind-blowing."
  Noted: question card titles show as "from a participant..."; spotlight doesn't work
  in speaker notes (misleading — presenter thinks they're pointing, audience sees nothing);
  requested color documentation for menu and Verticator
- AI: Added live testing results, color config docs, spotlight bug analysis, data-menu-title fix
- Outcome: Accepted with known issues documented

---

## Links

- Research source: `docs/REVEAL_JS_PLUGINS.md`
- Related ADRs: 0001 (speaker notes — Verticator is a parallel solution to the same problem)
- Reveal.js plugin wiki: github.com/hakimel/reveal.js/wiki/Plugins,-Tools-and-Hardware
- rajgoel collection: github.com/rajgoel/reveal.js-plugins
- Martinomagnifico: martinomagnifico.github.io
