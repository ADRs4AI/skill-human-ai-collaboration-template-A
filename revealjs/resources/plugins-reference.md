# Plugin Reference Table

Complete lookup table for reveal.js plugins. For each plugin: CDN URL, npm package, JS initialization key, and key config.

**CDN base**: `https://cdn.jsdelivr.net/npm/`

---

## Built-in Plugins (ship with reveal.js@5)

These require no extra install — just load from the reveal.js CDN.

| Use Case | Plugin Name | `<script src="">` (relative to CDN base) | Init key | Notes |
|---|---|---|---|---|
| Speaker notes (`S`) | RevealNotes | `reveal.js@5/plugin/notes/notes.js` | `RevealNotes` | Must be in BOTH `<script>` AND `plugins[]` |
| Syntax highlighting | RevealHighlight | `reveal.js@5/plugin/highlight/highlight.js` | `RevealHighlight` | Pairs with `<pre><code class="language">` |
| Math (KaTeX) | RevealMath.KaTeX | `reveal.js@5/plugin/math/math.js` | `RevealMath.KaTeX` | Fastest; recommended default |
| Math (MathJax 3) | RevealMath.MathJax3 | `reveal.js@5/plugin/math/math.js` | `RevealMath.MathJax3` | Slower, more complete |
| Math (MathJax 2) | RevealMath.MathJax2 | `reveal.js@5/plugin/math/math.js` | `RevealMath.MathJax2` | Legacy; avoid for new decks |
| Markdown slides | RevealMarkdown | `reveal.js@5/plugin/markdown/markdown.js` | `RevealMarkdown` | Write slides in `.md` |
| Full-text search | RevealSearch | `reveal.js@5/plugin/search/search.js` | `RevealSearch` | `Ctrl+Shift+F` |
| Alt+click zoom | RevealZoom | `reveal.js@5/plugin/zoom/zoom.js` | `RevealZoom` | Alt+click to zoom element |

---

## Navigation & UX Plugins

| Use Case | Plugin Name | CDN (full URL) | npm package | Init key | Key config |
|---|---|---|---|---|---|
| Slide navigation menu | RevealMenu | `reveal.js-menu/menu.js` + `menu.css` | `reveal.js-menu` | `RevealMenu` | `side: 'left'`, `titleSelector: 'h2'` |
| Vertical progress dots | Verticator | `reveal.js-verticator/plugin/verticator/verticator.js` + `.css` | `reveal.js-verticator` | `Verticator` | `color: '#hex'`, `clickable: true` |

**RevealMenu full config**:
```javascript
menu: {
  side: 'left',
  width: 'normal',
  numbers: false,
  titleSelector: 'h2, .topic-title',
  useTextContentForMissingTitles: true,
  hideMissingTitles: false,
  keyboard: true,
  themes: false,
  transitions: false,
  openButton: true,
}
```
Bug: Question cards without h2 show raw text. Fix: add `data-menu-title` attribute to the `<section>`.

**Verticator full config**:
```javascript
verticator: {
  color: '#E07340',
  position: 'auto',
  clickable: true,
  tooltip: 'auto',
}
```

---

## Diagrams

| Use Case | Plugin Name | CDN (full URL) | npm package | Init key | Notes |
|---|---|---|---|---|---|
| Flowcharts, state, sequence | RevealMermaid | `reveal.js-mermaid-plugin@11.12.2/plugin/mermaid/mermaid.js` | `reveal.js-mermaid-plugin` | `RevealMermaid` | Pin version; wait 2s for async render |
| D3.js visualizations | reveald3 | (GitHub only) | — | — | Also supports Vega/Vega-lite |
| PlantUML diagrams | RevealPlantUml | (GitHub only) | — | — | Requires PlantUML server |

---

## Drawing & Annotation

| Use Case | Plugin Name | CDN (full URL) | Init key | Key config / notes |
|---|---|---|---|---|
| Whiteboard + slide annotation | RevealChalkboard | `reveal.js-plugins@4.6.0/chalkboard/chalkboard.js` | `RevealChalkboard` | Saves to JSON; `B` = toggle, `DEL` = clear |
| Spotlight / laser pointer | Spotlight | martinomagnifico CDN | `Spotlight` | `size: 60`; **Bug**: doesn't propagate to audience window in speaker mode |
| Draw over slides | RevealDrawer | (GitHub only) | — | Drawings persist between transitions |

**RevealChalkboard CDN**:
```
https://cdn.jsdelivr.net/npm/reveal.js-plugins@4.6.0/chalkboard/chalkboard.js
https://cdn.jsdelivr.net/npm/reveal.js-plugins@4.6.0/chalkboard/chalkboard.css
```

**Spotlight CDN** (Martinomagnifico):
```
https://cdn.jsdelivr.net/npm/reveal.js-spotlight/plugin/spotlight.js
```

**Spotlight known bug**: Works in presenter's browser window only. Does not propagate to audience's browser (different browser context). Use Zoom's built-in spotlight for audience interaction.

---

## Code Presentation

| Use Case | Plugin Name | CDN / notes | Init key |
|---|---|---|---|
| Highlight specific lines | RevealHighlight | bundled — `data-line-numbers="1-3\|4-6"` | `RevealHighlight` |
| Code from external files | EmbedCode | GitHub | — |
| Live coding with CodeMirror | livecode | GitHub | — |
| Open in Compiler Explorer | reveal-compiler-explorer | GitHub (updated Dec 2024) | — |

---

## Audience Interaction

| Use Case | Plugin Name | CDN | npm | Notes |
|---|---|---|---|---|
| Live audience voting (poll) | RevealPoll | rajgoel collection | `reveal.js-plugins` | Requires Socket.io server (Seminar) |
| Upvotable Q&A | RevealQuestions | rajgoel collection | `reveal.js-plugins` | Requires Socket.io server (Seminar) |
| Embedded quizzes | Quizzes | GitHub | — | No server needed |
| Countdown per slide | RevealCountdown | CDN | `reveal.js-countdown` | `<section data-countdown="180">` |
| Presentation analytics | reveal.js-tracking | GitHub | — | Dwell times, clicks, quiz responses |

---

## Animations & Transitions

| Use Case | Plugin Name | CDN | Init key | Notes |
|---|---|---|---|---|
| Entrance animations (Animate.css) | Appearance | martinomagnifico CDN | `Appearance` | `class="animate__animated" data-appear-class="animate__fadeInDown"` |
| SVG animations | RevealAnimate | rajgoel collection | `RevealAnimate` | Uses SVG.js |
| JS-rendered content (anything) | RevealAnything | rajgoel collection | `RevealAnything` | Render arbitrary JS in slide |
| Auto-animate (built-in) | — | built-in | — | `data-auto-animate` on `<section>` |

**Appearance CDN** (Martinomagnifico):
```
https://cdn.jsdelivr.net/npm/reveal.js-appearance/plugin/appearance/appearance.js
https://cdn.jsdelivr.net/npm/reveal.js-appearance/plugin/appearance/appearance.css
```
Also requires Animate.css:
```
https://cdn.jsdelivr.net/npm/animate.css/animate.min.css
```

---

## rajgoel Collection (Full List)

All from: `https://cdn.jsdelivr.net/npm/reveal.js-plugins@4.6.0/[name]/`

| Plugin | Directory | Function |
|---|---|---|
| Chalkboard | `chalkboard/` | Whiteboard and annotation |
| Audio Slideshow | `audio-slideshow/` | Per-slide audio |
| Chart | `chart/` | Chart.js data visualizations |
| Animate | `animate/` | SVG.js animations |
| Anything | `anything/` | JS-rendered content in slides |
| Custom Controls | `customcontrols/` | Additional toolbar buttons |
| Fullscreen | `fullscreen/` | Per-element fullscreen |
| Load Content | `loadcontent/` | Pull in external HTML |
| Seminar | `seminar/` | Real-time multi-user Socket.io |
| Poll | `poll/` | Live voting (needs Seminar) |
| Questions | `questions/` | Upvotable Q&A (needs Seminar) |

---

## Martinomagnifico Collection (Full List)

All individually packaged. Browse: martinomagnifico.github.io

| Plugin | npm | Stars | Function |
|---|---|---|---|
| Appearance | `reveal.js-appearance` | ⭐127 | Animate.css entrance animations |
| Simplemenu | `reveal.js-simplemenu` | ⭐57 | Auto-generated menubar from chapters |
| Verticator | `reveal.js-verticator` | ⭐49 | Vertical slide position dots |
| CopyCode | `reveal.js-copycode` | ⭐43 | Copy buttons on code blocks |
| Spotlight | `reveal.js-spotlight` | ⭐28 | Spotlight cursor effect |
| Internation | `reveal.js-internation` | — | Full multilingual support |
| FontsFirst | `reveal.js-fontsfirst` | — | Ensures fonts load before init |
| Tagteam | `reveal.js-tagteam` | — | Dynamic section visibility |
| FsFx | `reveal.js-fsfx` | — | Fullscreen effects |
| CounterAct | `reveal.js-counteract` | — | CSS counter fixes |

---

## Separate Repos (formerly bundled)

| Plugin | npm | Function |
|---|---|---|
| Multiplex | `reveal-multiplex` | Real-time audience sync via Socket.io |
| Notes Server | `reveal-notes-server` | Networked speaker notes |

---

## Installation Patterns

### Pattern 1: CDN (recommended for single-file or Claude Web)
```html
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/reveal.js-menu/menu.css">
<script src="https://cdn.jsdelivr.net/npm/reveal.js-menu/menu.js"></script>
```

### Pattern 2: npm + local (for projects with package.json)
```bash
npm install reveal.js-menu
```
```html
<link rel="stylesheet" href="node_modules/reveal.js-menu/menu.css">
<script src="node_modules/reveal.js-menu/menu.js"></script>
```

### Pattern 3: ES module import
```javascript
import RevealMenu from './node_modules/reveal.js-menu/menu.esm.js';
```

### Registration (always required, regardless of install method)
```javascript
Reveal.initialize({
  plugins: [ RevealNotes, RevealMenu, Verticator, RevealMermaid ]
  // ↑ include ALL plugins here
});
```

---

## Discovering More Plugins

- **Official community wiki**: github.com/hakimel/reveal.js/wiki/Plugins,-Tools-and-Hardware (220+ entries)
- **npm**: search `reveal.js-plugin` or `revealjs-plugin`
- **Quarto extensions**: quarto.org/docs/extensions/listing-revealjs.html (30+ extensions, different install model)
- **Martinomagnifico**: martinomagnifico.github.io
