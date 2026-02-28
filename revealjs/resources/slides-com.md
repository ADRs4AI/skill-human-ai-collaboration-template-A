# Subskill: Slides.com Format

Load this when working with Slides.com exports, converting between Slides.com and
hand-crafted reveal.js, or analyzing the structural differences.

---

## What Slides.com Is

Slides.com is a commercial WYSIWYG editor built on reveal.js. Its exported HTML files
use reveal.js as the engine but wrap all content in absolutely-positioned `.sl-block` divs
(a "canvas" model, like PowerPoint) rather than HTML document flow.

Slides.com offline exports are **self-contained** — `lib/offline-v2.css`, reveal.js, and
all assets are bundled. This makes them portable but opaque.

---

## Confirmed Structure (from Playwright analysis, 2026-02-28)

**Tested on**: `slides_text-rules-penn-engineering-may-2025-ai-summit/index.html`

### What's the same as hand-crafted reveal.js
- `<section>` hierarchy — horizontal slides, vertical stacks with `class="stack"`
- Reveal.js API fully functional (`Reveal.slide()`, `Reveal.getState()`, `Reveal.next()`)
- Background images via `data-background-image="..."` on `<section>`
- Background colors via `data-background-color="rgb(...)"` on `<section>`
- Stack navigation (↓ for vertical)
- No overflow (absolute positioning means content never reflows)
- 0 console errors on a properly bundled export

### What's different
| Feature | Hand-crafted | Slides.com |
|---|---|---|
| Content model | HTML document flow | Absolute-positioned `.sl-block` divs |
| Theme | CSS variables + external `.css` | Inline in `<style id="theme-css-output">` |
| Speaker notes | `<aside class="notes">` | **None** — not exported |
| Fonts | Google Fonts CDN or system | Custom (TWK Everett, Pitch Sans) via remote CDN |
| Images | Semantic `<img>` in flow | `<div class="sl-block"><img data-src="..."></div>` |
| Lines / dividers | CSS borders | SVG `<path>` elements in `.sl-block[data-block-type="line"]` |
| Sub-slide counters | Automatic (Verticator) or none | Manual text blocks ("1/3", "2/3", "3/3") |
| Reveal.js version | Controlled by you | Bundled in `lib/offline-v2.css` / `lib/offline.js` |
| Portability | Depends on CDN or local | Fully self-contained (with sibling assets folder) |
| Section IDs | Meaningful or absent | UUIDs (`data-id="704083770bd8c22cfe2d249f13048036"`) |

---

## The .sl-block Model

Every piece of content is a positioned container:

```html
<section data-id="[UUID]" data-background-image="path.png">

  <!-- Text block -->
  <div class="sl-block" data-block-type="text"
       style="width: 554px; left: 402px; top: 12px; height: auto;"
       data-block-id="[UUID]">
    <div class="sl-block-content" data-placeholder-tag="h1" style="z-index: 10;">
      <h1><span style="color:#ffffff">TITLE TEXT</span></h1>
    </div>
  </div>

  <!-- Image block -->
  <div class="sl-block" data-block-type="image"
       style="width: 407px; height: 135px; left: 11px; top: 12px;"
       data-block-id="[UUID]">
    <div class="sl-block-content" style="z-index: 11;">
      <img data-natural-width="1810" data-natural-height="599"
           data-lazy-loaded="" data-src="folder/image.png">
    </div>
  </div>

  <!-- SVG line -->
  <div class="sl-block" data-block-type="line"
       style="left: 0; top: 318px;" data-block-id="[UUID]">
    <div class="sl-block-content" data-line-x1="0" data-line-y1="0"
         data-line-x2="960" data-line-y2="0" data-line-color="#000000"
         data-line-width="2px" style="z-index: 16;">
      <svg ...><path class="line-element" ...></path></svg>
    </div>
  </div>

</section>
```

**Coordinate system**: 960px wide × 700px tall (reveal.js default). All positions are
pixel offsets from the top-left corner of the slide.

---

## Converting FROM Slides.com to Hand-Crafted

When you want to take Slides.com content and convert it to maintainable hand-crafted HTML.

### Why convert?
- Add speaker notes (not exported by Slides.com)
- Add Mermaid diagrams or KaTeX math
- Make content reflow-friendly (responsive)
- Add Verticator, Menu, or other plugins
- Move content into a topic stack system

### Conversion process

**Step 1: Extract content from `.sl-block-content`**
Each text block's content lives in `.sl-block-content`. Extract it, discard the wrapper.

```javascript
// In Playwright — extract all text content by slide
() => Array.from(document.querySelectorAll('.reveal .slides > section:not(.stack)')).map((section, i) => ({
  slide: i,
  texts: Array.from(section.querySelectorAll('.sl-block-content[data-placeholder-tag]')).map(el => ({
    tag: el.getAttribute('data-placeholder-tag'),
    html: el.innerHTML.trim().slice(0, 100)
  }))
}))
```

**Step 2: Rebuild as semantic HTML**
Replace absolute-positioned blocks with document-flow HTML:

```html
<!-- Slides.com: -->
<div class="sl-block" style="width:710px; left:0; top:121px;">
  <div class="sl-block-content"><ul><li>Point one</li></ul></div>
</div>

<!-- Hand-crafted equivalent: -->
<ul>
  <li>Point one</li>
</ul>
```

**Step 3: Reconstruct theme as CSS variables**
The inline `<style id="theme-css-output">` can be adapted to reveal.js CSS variables:

```css
/* From Slides.com theme output: */
.reveal .slides { color: #011F5B; font-family: "TWK Everett", sans-serif; }
.reveal .slides h1, h2, h3 { color: #990000; }

/* Translate to reveal.js variables: */
:root {
  --r-main-color: #011F5B;
  --r-main-font: "TWK Everett", sans-serif;
  --r-heading-color: #990000;
}
```

**Step 4: Add speaker notes**
Slides.com exports have **zero speaker notes** (`<aside class="notes">` = 0 in the DOM).
These must be written from scratch or reconstructed from memory/recordings.

**Step 5: Restore images**
Images use `data-src` (lazy-loaded). In hand-crafted HTML, use standard `src`:
```html
<!-- Slides.com: -->
<img data-lazy-loaded="" data-src="folder/abc123.png">

<!-- Hand-crafted: -->
<img src="assets/descriptive-name.png" alt="Description">
```
Rename the hash-named files to descriptive names.

---

## Converting TO Slides.com Style (Hand-crafted → Canvas Model)

Generally not recommended — the absolute positioning model breaks at different screen sizes
and makes content harder to maintain. But if you need to match Slides.com's visual approach:

```html
<section style="position: relative;">
  <div style="position: absolute; width: 554px; left: 402px; top: 12px;">
    <h1 style="color: #ffffff;">TITLE</h1>
  </div>
  <div style="position: absolute; width: 710px; left: 0; top: 121px;">
    <ul><li>Content</li></ul>
  </div>
</section>
```

The slide canvas in reveal.js is 960×700px by default. All absolute positions are relative
to that coordinate system.

---

## No Speaker Notes: The Critical Gap

Slides.com exports contain **zero speaker notes**. This is the most significant difference
from hand-crafted reveal.js presentations.

When importing a Slides.com deck:
1. Press `S` → no speaker view opens (or opens empty)
2. Presenter has no in-slide prompts during delivery
3. Stack TOC format in notes is absent

**Mitigation**: After conversion, add speaker notes to every slide. Use the stack TOC
format from `speaker-notes.md` for topic stacks.

---

## Offline Export Portability

Slides.com offline exports bundle everything **except** they require the sibling assets folder:

```
slides_my-talk/          ← keep together as a unit
├── index.html
├── lib/                 ← Slides.com's bundled reveal.js + CSS
└── my-talk/             ← images (named as hashes)
    ├── 704083770bd8.png
    └── 3c1bafb1b428.jpg
```

If `index.html` is separated from its sibling folders, all images break (404).
If only `lib/` is missing, reveal.js itself won't load.

Always distribute / archive as a zip of the entire `slides_my-talk/` folder.

---

## Hypotheses for Further Investigation

These are unconfirmed — verified by requesting specific test slides from the user.

| Hypothesis | Status | Test |
|---|---|---|
| All content uses `.sl-block` absolute positioning | ✅ Confirmed (315 blocks, 979 lines) | Read HTML |
| Section structure = standard reveal.js | ✅ Confirmed (8 stacks, Reveal API works) | Playwright |
| Theme CSS is inlined in `<style id="theme-css-output">` | ✅ Confirmed | Read HTML |
| Reveal.js API works identically | ✅ Confirmed (slide(), getState() work) | Playwright |
| Speaker notes absent | ✅ Confirmed (0 `<aside class="notes">`) | Playwright |
| Sub-slide counters are manual text blocks | ✅ Confirmed ("1/3" is a `.sl-block`) | Read HTML |
| Background images via `data-background-image` | ✅ Confirmed | Read HTML |
| No overflow issues possible | ✅ Confirmed (abs positioning fills exactly 700px) | Playwright |
| Fragments can be added in slides.com | ❓ Unconfirmed | Request test deck |
| KaTeX/Mermaid can be added post-export | ❓ Unconfirmed | Request test deck |
| Slide transitions are configurable | ❓ Unconfirmed | Read HTML more carefully |

---

## Reverse-Engineering Spec (for user to create)

To verify the unconfirmed hypotheses, create a Slides.com deck with these specific slides:

1. **Slide A**: Title + single bullet list (baseline text structure)
2. **Slide B**: Two-column layout with text left, image right
3. **Slide C**: A code block (if Slides.com supports it — what does the HTML look like?)
4. **Slide D**: A slide with a fragment/animation (if Slides.com supports it)
5. **Slide E**: A vertical stack (3 sub-slides) with meaningful titles

Export offline and provide the `index.html`. This will let us:
- Confirm whether fragments appear as `.fragment` in the output
- See how code blocks are represented
- Understand the two-column layout structure for conversion mapping
