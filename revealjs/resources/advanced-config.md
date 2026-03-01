# Subskill: Advanced Configuration

Load this for the complete configuration reference, themes, keyboard shortcuts, API events, scroll view, slide state, visibility, and multiple presentations.

---

## Complete Configuration Reference

```javascript
Reveal.initialize({
  // ── Navigation ──────────────────────────────────────────
  hash: true,               // slide index in URL hash (#/2/1)
  hashOneBasedIndex: false, // start from 1 instead of 0
  history: false,           // push each change to browser history
  keyboard: true,           // keyboard navigation
  mouseWheel: false,        // scroll wheel navigation
  navigationMode: 'default',// 'default' | 'linear' | 'grid'

  // ── Display ──────────────────────────────────────────────
  controls: true,           // navigation arrows
  controlsTutorial: true,   // hints for controls
  controlsLayout: 'bottom-right', // 'bottom-right' | 'edges'
  controlsBackArrows: 'faded',    // 'faded' | 'hidden' | 'visible'
  progress: true,           // progress bar at bottom
  slideNumber: 'c/t',       // false | true | 'h.v' | 'h/v' | 'c' | 'c/t'
  showSlideNumber: 'all',   // 'all' | 'print' | 'speaker'
  center: true,             // vertically center slides
  rtl: false,               // right-to-left

  // ── Sizing ───────────────────────────────────────────────
  width: 960,
  height: 700,
  margin: 0.04,             // empty space around content (fraction)
  minScale: 0.2,
  maxScale: 2.0,

  // ── Transitions ──────────────────────────────────────────
  transition: 'slide',       // 'none'|'fade'|'slide'|'convex'|'concave'|'zoom'
  transitionSpeed: 'default',// 'default'|'fast'|'slow'
  backgroundTransition: 'fade',

  // ── Fragments ────────────────────────────────────────────
  fragments: true,          // enable fragments globally
  fragmentInURL: true,      // include fragment index in URL

  // ── Notes ────────────────────────────────────────────────
  showNotes: false,         // false | true | 'separate-page'

  // ── Auto-slide ───────────────────────────────────────────
  autoSlide: 0,             // ms between slides (0 = disabled)
  autoSlideStoppable: true, // pause auto-slide on user input
  defaultTiming: null,      // avg seconds per slide (for pacing indicator)

  // ── PDF export ───────────────────────────────────────────
  pdfSeparateFragments: true,  // each fragment = separate page
  pdfMaxPagesPerSlide: Infinity,

  // ── View mode ────────────────────────────────────────────
  view: 'default',          // 'default' | 'scroll' | 'reader'

  // ── Misc ─────────────────────────────────────────────────
  touch: true,              // touch navigation
  loop: false,
  shuffle: false,
  embedded: false,          // for embedding in other pages
  help: true,               // show help overlay on '?'
  pause: true,              // allow pausing ('b' or '.')
  showHiddenSlides: false,  // show data-visibility="hidden" slides
  previewLinks: false,      // all links open as preview by default
});
```

---

## Themes

Built-in themes (load one via `<link>`):

```html
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/reveal.js@5/dist/theme/[THEME].css">
```

| Theme | Description |
|---|---|
| `black` | Dark background (default) |
| `white` | Light background |
| `league` | Dark grey, yellow headings |
| `sky` | Blue gradient |
| `beige` | Warm beige |
| `simple` | Minimal, clean |
| `serif` | Serif fonts |
| `blood` | Dark, crimson headings |
| `night` | Dark, orange headings |
| `moon` | Dark blue |
| `solarized` | Solarized color scheme |

Switch themes at runtime:
```javascript
document.getElementById('theme').setAttribute('href',
  'https://cdn.jsdelivr.net/npm/reveal.js@5/dist/theme/moon.css');
```

---

## Keyboard Shortcuts

| Key | Action |
|---|---|
| `→` / `Space` | Next slide |
| `←` | Previous slide |
| `↓` | Next vertical slide |
| `↑` | Previous vertical slide |
| `Shift+Space` | Previous slide |
| `Esc` / `O` | Slide overview mode |
| `S` | Open speaker notes window |
| `F` | Fullscreen |
| `B` or `.` | Pause (blackout) |
| `?` | Help panel |
| `Alt+Click` | Zoom in on element (RevealZoom) |
| `Ctrl+Shift+F` | Search (RevealSearch) |

---

## Slide Transitions (per slide)

Override the global transition for specific slides:

```html
<!-- Single transition -->
<section data-transition="zoom">

<!-- Separate in and out transitions -->
<section data-transition="zoom-in fade-out">

<!-- Override background transition -->
<section data-background="#4d7e65" data-background-transition="zoom">
```

Available values: `none`, `fade`, `slide`, `convex`, `concave`, `zoom`
Combined: `[type]-in`, `[type]-out` — e.g. `zoom-in fade-out`

---

## Slide Visibility

```html
<!-- Hide slide from navigation (still counted in total) -->
<section data-visibility="hidden">
  <h2>Draft slide — not shown</h2>
</section>

<!-- Show hidden slides (e.g. for author review) -->
<script>
  Reveal.initialize({ showHiddenSlides: true });
</script>

<!-- Uncounted: hidden and not counted in slide total -->
<section data-visibility="uncounted">
  <h2>Extra slide</h2>
</section>
```

---

## Slide State and Events

Apply custom CSS class to `<html>` when a slide is active, and listen for it:

```html
<section data-state="special-slide">
  <h2>When this slide is active, html gets class "special-slide"</h2>
</section>

<style>
  html.special-slide .reveal { background: #111; }
</style>

<script>
  Reveal.on('special-slide', function() {
    // trigger custom behavior, e.g. start an animation
    console.log('special-slide is active');
  });
</script>
```

---

## API Events

```javascript
// Slide changed
Reveal.on('slidechanged', event => {
  // event.previousSlide, event.currentSlide
  // event.indexh (horizontal), event.indexv (vertical)
  console.log(`Now at ${event.indexh}/${event.indexv}`);
});

// Fragment shown/hidden
Reveal.on('fragmentshown', event => {
  // event.fragment = the .fragment element
});
Reveal.on('fragmenthidden', event => {
  // event.fragment = the .fragment element
});

// Presentation ready
Reveal.on('ready', event => {
  // event.currentSlide, event.indexh, event.indexv
});

// Overview mode
Reveal.on('overviewshown', () => { });
Reveal.on('overviewhidden', () => { });

// Paused/resumed
Reveal.on('paused', () => { });
Reveal.on('resumed', () => { });

// Auto-slide
Reveal.on('autoslideresumed', () => { });
Reveal.on('autoslidepaused', () => { });
```

---

## Scroll View

Present slides in a scrolling layout instead of full-screen transitions:

```javascript
Reveal.initialize({
  view: 'scroll',
  hash: true,
  plugins: [ RevealMarkdown, RevealHighlight, RevealNotes ]
});
```

In scroll view:
- Fragments trigger as you scroll past them
- Auto-animate works
- Code step-through highlights trigger on scroll
- Good for documents / single-page presentations

---

## Navigation Mode

```javascript
Reveal.initialize({
  navigationMode: 'default' // 'default' | 'linear' | 'grid'
});
```

- `default`: right arrow skips over vertical stacks to next horizontal
- `linear`: arrow keys move through all slides sequentially (no skipping stacks)
- `grid`: keyboard moves in a 2D grid matching the slide layout

---

## Multiple Presentations on One Page

```html
<div class="reveal deck1">
  <div class="slides">
    <section>Deck 1 Slide 1</section>
  </div>
</div>

<div class="reveal deck2">
  <div class="slides">
    <section>Deck 2 Slide 1</section>
  </div>
</div>

<script>
  // Each instance gets its own config
  let deck1 = new Reveal(document.querySelector('.deck1'), {
    embedded: true,
    keyboardCondition: 'focused' // only respond to keys when focused
  });
  deck1.initialize();

  let deck2 = new Reveal(document.querySelector('.deck2'), {
    embedded: true,
    keyboardCondition: 'focused'
  });
  deck2.initialize();
</script>
```

---

## Slide Identifiers and Deep Links

```html
<!-- Named slide (shareable URL fragment) -->
<section id="introduction">
  <h2>Introduction</h2>
</section>

<!-- Link to it -->
<a href="#/introduction">Go to Introduction</a>

<!-- Link by index -->
<a href="#/2/3">Slide 2, sub-slide 3</a>
```

With `hash: true`, the URL updates automatically as you navigate.

---

## Auto-Slide Configuration

```javascript
Reveal.initialize({
  autoSlide: 5000,            // advance every 5 seconds
  autoSlideStoppable: true,   // pause on user interaction
  defaultTiming: 120,         // 2 minutes per slide (used for pacing indicator)
});
```

Override per slide:
```html
<section data-autoslide="2000">This slide auto-advances after 2s</section>
<section data-autoslide="0">This slide never auto-advances</section>
```
