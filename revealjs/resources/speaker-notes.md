# Subskill: Speaker Notes

Load this for guidance on stack TOC format, timing markers, and the pre-publish checklist.

---

## Setup (Required)

Speaker notes require both the script AND the plugins array entry:

```html
<script src="https://cdn.jsdelivr.net/npm/reveal.js@5/plugin/notes/notes.js"></script>
```

```javascript
plugins: [ RevealNotes ]
```

**Omitting either silently breaks speaker notes.** Always verify: press `S` before presenting.

---

## Stack Header TOC Format

Every topic stack header slide must have speaker notes with a table of contents:

```html
<section data-background-color="#F5F0E8">
  <h2>Topic Name</h2>
  <p class="subtitle">Optional tagline</p>
  <aside class="notes">
    STACK: Topic Name
    ─────────────────
    1. Sub-slide title — one-line description of content
    2. Sub-slide title — one-line description
    3. Sub-slide title — one-line description
    4. Sub-slide title — one-line description
    ─────────────────
    NAVIGATE: ↓ to dive in · → to skip to next topic

    Optional: opening question or conversation starter
  </aside>
</section>
```

**Rules**:
- Always present — no stack header without TOC
- Maximum 1 line per sub-slide (brevity discipline)
- Always include the NAVIGATE line
- Optional: one conversation starter at the end

**Why this exists**: Stack header slides are "black boxes" during presentation. Without the TOC in notes, the presenter must either unspool sub-slides to check content (disrupts flow) or rely on memory (unreliable for 10+ stacks).

---

## Content Slide Notes Format

Every content slide needs notes. Minimum viable:

```html
<section>
  <h2>Slide Title</h2>
  <!-- slide content -->
  <aside class="notes">
    [Main point to make] [30 sec]

    - Supporting detail
    - What to emphasize

    Transition: "So this leads us to..."
  </aside>
</section>
```

---

## Timing Markers

Add timing markers to enable pacing control:

```
[0:00] Opening — introduce the topic
[3:00] First case study — spend no more than 4 minutes
[7:00] Core algorithm — this is the key moment, slow down
[12:00] Questions from audience
[15:00] Transition to next topic
```

Timing marker format: `[MM:SS]` at the start of a line in speaker notes.

For long presentations, use cumulative timestamps from session start.

---

## Navigation Hints

Include navigation hints in notes to prevent disorientation:

```
NAVIGATE: ↓ for sub-slides · → to skip · S for speaker view
```

```
NAVIGATE: ↓ for 3 more examples · → to skip entire section
```

This is especially important for stacks with 8+ sub-slides.

---

## Speaker Instructions in Notes (Not Slides)

All speaker-only information goes in notes, never in slide body:
- Timing instructions
- "Pause here for questions"
- "Show demo now"
- Reminders about audience-specific context

Wrong:
```html
<p style="color: gray; font-size: 0.5em">[Ask for volunteers here]</p>
```

Right:
```html
<aside class="notes">
  Ask for volunteers here. Wait for hands before proceeding.
</aside>
```

---

## data-menu-title

When using RevealMenu, slides without a heading will show raw text as the menu title. Add `data-menu-title` to control it:

```html
<!-- Question card — no h2 visible, but needs clean menu title -->
<section data-menu-title="Q: What is the time complexity?">
  <div class="question-card">
    What is the time complexity of binary search?
  </div>
  <aside class="notes">Wait 60 seconds for Slido responses.</aside>
</section>
```

Without `data-menu-title`, the menu shows "What is the time complexity of binary search? ..." — verbose and not useful for navigation.

---

## Pre-Publish Verification Checklist

Run before every session:

**Technical**:
- [ ] `S` key opens speaker notes window (popup allowed in browser)
- [ ] All slides have `<aside class="notes">` (check with browser search or grep)
- [ ] Stack headers have TOC format in notes
- [ ] `RevealMenu` opens (`m` key or hamburger icon)
- [ ] All slide titles are unique and meaningful (for menu navigation)
- [ ] `slideNumber: 'c/t'` shows in bottom corner

**Visual**:
- [ ] No slides with content cut off at bottom
- [ ] All code blocks readable (font not too small)
- [ ] All Mermaid diagrams rendered (not raw text)
- [ ] All math formulas rendered (not raw LaTeX)
- [ ] Images load (not broken)
- [ ] Copyright notice visible bottom-right

**Copyright** (add to every file, just before `</body>`):
```html
<div style="position: fixed; bottom: 8px; right: 14px;
  font-family: sans-serif; font-size: 10px; font-weight: 400;
  color: rgba(0,0,0,0.28); z-index: 1000;
  pointer-events: none; user-select: none;">
  © Jérémie O. Lumbroso, Ph.D. — University of Pennsylvania
</div>
```

**Content**:
- [ ] Every slide has speaker notes
- [ ] No speaker instructions visible in slide body
- [ ] Timing markers present for long presentations
- [ ] `data-menu-title` on slides without headings
- [ ] Fragments appear in correct order

---

## Speaker Notes in PDF Export

For PDF export with notes on separate pages:
```javascript
Reveal.initialize({
  showNotes: 'separate-page'  // or true to overlay
})
```

DeckTape (external tool) handles full PDF export from any reveal.js deck with notes. Mermaid diagrams may not render in PDF — use screenshot fallbacks.
