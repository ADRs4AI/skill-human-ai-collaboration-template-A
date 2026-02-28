# Subskill: Slides.com Format

Load this when working with Slides.com exports, converting between Slides.com and
hand-crafted reveal.js, or analyzing the structural differences.

**Source material**: Playwright analysis + two offline exports (2026-02-28):
- `docs/resources/slides.com/slides_test-slides/` — purpose-built test deck
- `docs/resources/slides.com/slides_deck-0a7905/` — question-scaffolded.html imported → re-exported

---

## What Slides.com Is

Slides.com is a commercial WYSIWYG editor built on reveal.js. Its exported HTML files
use reveal.js as the engine but wrap all content in absolutely-positioned `.sl-block` divs
(a "canvas" model, like PowerPoint) rather than HTML document flow.

Slides.com offline exports are **self-contained** — `lib/offline-v2.css`, reveal.js, and
all assets are bundled. This makes them portable but opaque.

---

## Confirmed Structure (from Playwright analysis, 2026-02-28)

### What's the same as hand-crafted reveal.js
- `<section>` hierarchy — horizontal slides, vertical stacks with `class="stack"`
- Reveal.js API fully functional (`Reveal.slide()`, `Reveal.getState()`, `Reveal.next()`)
- Background images via `data-background-image="..."` on `<section>`
- Background gradients via `data-background-gradient="linear-gradient(...)"` on `<section>`
- Background colors via `data-background-color="rgb(...)"` on `<section>`
- **Fragments**: standard `.fragment` class + `data-fragment-index` on individual elements
- Stack navigation (↓ for vertical)
- 0 console errors on a properly bundled export

### What's different

| Feature | Hand-crafted | Slides.com |
|---|---|---|
| Content model | HTML document flow | Absolute-positioned `.sl-block` divs |
| Theme | CSS variables + external `.css` | Inline in `<style id="theme-css-output">` |
| **Speaker notes** | `<aside class="notes">` in DOM | **`SLConfig.notes[slideUUID]`** in JS config |
| Images | Semantic `<img>` in flow | `<div class="sl-block" data-block-type="image"><img data-src="..."></div>` |
| Code blocks | `<pre><code class="language">` | `<div class="sl-block" data-block-type="code"><pre><code>` |
| Lines / dividers | CSS borders | SVG `<path>` in `.sl-block[data-block-type="line"]` |
| Section IDs | Meaningful or absent | UUIDs (`data-id="704083770bd8..."`) |
| Reveal.js version | Controlled by you | Bundled in `lib/` |
| Portability | Depends on CDN or local | Self-contained with sibling assets folder |
| Animations (own system) | n/a | `.sl-block-content.animate` + `data-animation-type` |

---

## Speaker Notes: The Actual Mechanism

**Correction from initial analysis**: Slides.com exports DO include speaker notes, but
they are stored in the JavaScript config object, NOT as `<aside class="notes">` DOM elements.

```javascript
// In index.html, inside <script>:
var SLConfig = {
  "deck": {
    // ...
    "notes": {
      "e79acd0f572422ded6fa245940a8252b": "These are speaker notes",
      // key = slide UUID (matches data-id attribute on <section>)
      // value = the note text
    }
  }
};
```

**How to find your note for a slide**: Match the slide's `data-id` attribute to the key in `SLConfig.notes`.

**Implication**: `document.querySelectorAll('aside.notes')` returns 0 — but notes DO exist
in the JS config. This is why Playwright's DOM query showed 0 notes.

**In practice**: Slides.com renders notes through its offline.js. The Reveal.js `S` key
should still open speaker view with those notes (via the RevealNotes plugin registered in
the Slides.com export's `plugins: [RevealZoom, RevealNotes, RevealMarkdown, RevealHighlight]`).

**Extraction script** (for converting speaker notes to `<aside>` format):
```javascript
// In Playwright, extract all notes and their slide positions
() => {
  const notes = SLConfig.deck.notes || {};
  const sections = document.querySelectorAll('.reveal .slides section[data-id]');
  return Array.from(sections).map((s, i) => ({
    index: i,
    uuid: s.getAttribute('data-id'),
    note: notes[s.getAttribute('data-id')] || null
  })).filter(n => n.note);
}
```

---

## Two Animation Systems

Slides.com has its **own animation system** (different from reveal.js fragments):

### System 1: Slides.com animations (block-level, whole block fades in on click)
```html
<div class="sl-block-content animate"
     data-animation-type="fade-in"
     data-animation-trigger="click"
     data-animation-trigger-id="self"
     style="transition-duration: 0.6s;">
  <!-- entire block content appears on click -->
</div>
```

### System 2: Standard reveal.js fragments (element-level, granular)
```html
<ul>
  <li class="fragment" data-fragment-index="0">First item</li>
  <li class="fragment" data-fragment-index="1">Second item</li>
  <li class="fragment" data-fragment-index="2">Third item</li>
</ul>
```

Both systems survive export. Fragments are the standard reveal.js mechanism and work
identically to hand-crafted presentations. The Slides.com animation system uses `offline.js`
and is **not** compatible with hand-crafted reveal.js.

**When converting FROM Slides.com**: keep `.fragment` elements as-is; remove the
`.animate` class and `data-animation-*` attributes (they won't work without `lib/offline.js`).

---

## Code Blocks

Slides.com uses a dedicated `data-block-type="code"` block type:

```html
<div class="sl-block" data-block-type="code"
     style="width: 500px; height: 300px; left: 230px; top: 200px;">
  <div class="sl-block-content notranslate"
       data-highlight-theme="monokai"
       data-code-frame="none"
       style="z-index: 10;">
    <pre style="font-size: 16px; line-height: 19px; tab-size: 4;">
      <code data-line-numbers="">def func(a, b):
  return a + b

print(func(a, b))</code>
    </pre>
  </div>
</div>
```

**Key attributes**:
- `data-highlight-theme="monokai"` — highlight.js theme
- `data-code-frame="none"` — Slides.com UI frame option
- `data-line-numbers=""` — line numbers enabled

**When converting**: extract the `<code>` content, wrap in standard `<pre><code class="language-python">`.

---

## The .sl-block Model

Every piece of content is an absolutely-positioned container. Coordinate system: **960 × 700px**.

```html
<section data-id="[UUID]">

  <!-- Text block -->
  <div class="sl-block" data-block-type="text"
       style="width: 900px; left: 30px; top: 237px; height: auto;">
    <div class="sl-block-content" data-placeholder-tag="h1" style="z-index: 10;">
      <h1>Title Text</h1>
    </div>
  </div>

  <!-- Image block -->
  <div class="sl-block" data-block-type="image"
       style="width: 407px; height: 135px; left: 11px; top: 12px;">
    <div class="sl-block-content" style="z-index: 11;">
      <img data-lazy-loaded="" data-src="folder/image.png">
    </div>
  </div>

</section>
```

**Two-column layout** = two text blocks, one at `left: 30px`, one at `left: 495px`.
No flexbox or grid — pure absolute positioning.

---

## Import Behavior: Hand-crafted → Slides.com → Re-export

When importing a hand-crafted reveal.js presentation into Slides.com, the result is **mangled**:

### What survives import
- Text content (all HTML inside `<section>` elements)
- Fragment classes (`.fragment`, `data-fragment-index`) — preserved intact
- Background gradients / colors (`data-background-gradient`, `data-background-color`)
- Section structure (horizontal/vertical)

### What is lost or broken
- **Custom CSS** — all classes like `.two-col`, `.mode-box`, `.slido-box`, `.callout` lose their styles. The class names survive in HTML but the stylesheet does not transfer.
- **Speaker notes** — `<aside class="notes">` elements are NOT converted to `SLConfig.notes`. Lost.
- **Layout** — custom `.two-col` grids collapse to single-column since the CSS is gone
- **Fine-grained positioning** — Slides.com wraps each slide's entire content in ONE `.sl-block` with `data-has-custom-html=""`, instead of interpreting individual elements

### The mangling pattern
```html
<!-- Before (hand-crafted): -->
<section>
  <h2>Title</h2>
  <div class="two-col">
    <div class="mode-box">...</div>
    <div class="mode-box">...</div>
  </div>
</section>

<!-- After (Slides.com re-export): -->
<section data-id="[UUID]">
  <div class="sl-block" data-block-type="text" data-has-custom-html="">
    <div class="sl-block-content">
      <!-- HTML preserved but .two-col, .mode-box have no CSS -->
      <h2>Title</h2>
      <div class="two-col">
        <div class="mode-box">...</div>
        <div class="mode-box">...</div>
      </div>
    </div>
  </div>
</section>
```

**Verdict**: Import round-tripping (hand-crafted → Slides.com → back) is **destructive**.
Do not use Slides.com as a round-trip converter. Keep hand-crafted and Slides.com formats
as separate parallel tracks.

---

## Converting FROM Slides.com to Hand-crafted

### Step 1: Extract speaker notes from SLConfig
```javascript
// Playwright: extract all notes
() => {
  const notes = SLConfig.deck.notes || {};
  const sections = document.querySelectorAll('.reveal .slides section[data-id]');
  return Array.from(sections).map((s, i) => ({
    index: i, uuid: s.getAttribute('data-id'),
    note: notes[s.getAttribute('data-id')] || ''
  }));
}
```
Add these as `<aside class="notes">` in the converted HTML.

### Step 2: Extract text content
Each text block's content lives in `.sl-block-content`. Strip the `.sl-block` wrapper.

### Step 3: Handle the coordinate system
Absolute positions (e.g., `left: 495px`) map to the 960×700 canvas. For two-column
layouts, `left: 30px` + `left: 495px` → use CSS flexbox/grid in hand-crafted.

### Step 4: Fix images
Change `data-src="..."` to `src="..."`. Rename hash-named files to descriptive names.

### Step 5: Remove Slides.com animations
Remove `class="animate"` and `data-animation-type="fade-in"` attributes. Keep
`.fragment` and `data-fragment-index` unchanged.

### Step 6: Fix code blocks
Extract `<code>` content from `data-block-type="code"` blocks. Wrap in:
```html
<pre><code class="python" data-line-numbers>
  your code here
</code></pre>
```

### Step 7: Rebuild theme as CSS variables
```css
/* From Slides.com SLConfig.theme + theme CSS output: */
:root {
  --r-main-color: #011F5B;
  --r-main-font: "TWK Everett", sans-serif;
  --r-heading-color: #990000;
  --r-background-color: #FFFFFF;
}
```

---

## Offline Export Portability

Slides.com offline exports require the sibling assets folder:
```
slides_my-talk/          ← keep together as a unit
├── index.html
├── lib/                 ← Slides.com's bundled reveal.js + CSS + fonts
└── my-talk/             ← images (named as hashes)
```

Always distribute / archive as a zip of the entire `slides_my-talk/` folder.

---

## Hypotheses: Final Status

| Hypothesis | Status | Evidence |
|---|---|---|
| All content in `.sl-block` absolute positioning | ✅ | 315 blocks, read HTML |
| Section structure = standard reveal.js | ✅ | 8 stacks, Reveal API works |
| Theme CSS inlined | ✅ | `<style id="theme-css-output">` |
| Reveal.js API works identically | ✅ | slide(), getState() in Playwright |
| Fragments = standard `.fragment` class | ✅ | `data-fragment-index` in test deck |
| Speaker notes in SLConfig.notes[UUID] | ✅ | test deck JS config |
| Sub-slide counters are manual text blocks | ✅ | "1/3" is a `.sl-block` |
| Background via `data-background-*` | ✅ | Read HTML |
| No overflow (abs positioning) | ✅ | Playwright overflow check |
| Separate Slides.com animation system | ✅ | `.animate` + `data-animation-type` |
| Code blocks via `data-block-type="code"` | ✅ | test deck HTML |
| Import mangling (hand-crafted → Slides.com) | ✅ | deck-0a7905 export |
