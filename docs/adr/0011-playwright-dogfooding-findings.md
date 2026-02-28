# ADR-0011: Playwright Dogfooding Findings

- **Date**: 2026-02-28
- **Iteration**: 1
- **Status**: Accepted
- **Deciders**: Jérémie Lumbroso, Claude Code Sonnet 4.6

---

## Context

Per the 10th Directive and ADR-0009, Playwright MCP was used to render all three sample
presentations in `docs/resources/reveal.js/sample-talks/`. This documents what was found.

**Presentations tested:**
1. `lecture10-slides.html` — hand-crafted, CIS 5020 course
2. `slides_text-rules-penn-engineering-may-2025-ai-summit/index.html` — Slides.com export
3. `2026-02-27-v3-question-scaffolded.html` — hand-crafted, Beyond the Hype course

**Screenshots archived in**: `docs/screenshots/2026-02-28-*`

---

## Findings

### Finding 1: lecture10-slides.html is broken (relative path trap)

**Status**: 14 console errors, `Reveal is not defined`, presents as plain HTML.

**Root cause**: Uses local relative paths built inside a reveal.js repository clone:
```html
<script src="../../dist/reveal.js"></script>
<link rel="stylesheet" href="../../dist/theme/simple.css">
<script src="../../plugin/notes/notes.js"></script>
```
These resolve to `http://localhost:8765/docs/resources/dist/reveal.js` — a path that
doesn't exist in this repo. The file worked when it lived inside a local `reveal.js/`
clone but broke when moved.

**Consequence**: This is a common failure pattern. Documented in `resources/troubleshooting.md`
as "The Big One: ReferenceError: Reveal is not defined".

**Lesson for the skill**: All new presentations should use CDN paths. The boilerplate in
SKILL.md uses CDN exclusively. Local path usage should be documented as a known trap.

### Finding 2: Slides.com export is completely self-contained and robust

**Status**: 0 console errors, Reveal.js API fully functional, renders beautifully.

**Key structural differences confirmed:**
- 315 `.sl-block` absolutely-positioned content divs (canvas model, not document flow)
- 0 `<aside class="notes">` — speaker notes completely absent from export
- 8 stacks — same `<section class="stack">` structure as hand-crafted
- Theme CSS fully inlined in `<style id="theme-css-output">` — no external CSS
- Images lazily loaded (`data-src`) from sibling assets folder
- Sub-slide counters (1/3, 2/3) are manually positioned text blocks

**Critical gap**: **No speaker notes.** This is the biggest conversion challenge when
importing Slides.com content into a repo-based workflow.

### Finding 3: question-scaffolded.html is the gold standard

**Status**: 0 console errors, full Reveal.js functionality, 54 slides, copyright notice
visible, gradient backgrounds, CDN-based.

**Key pattern**: Uses CDN paths, RevealMenu plugin, copyright notice, speaker notes.
This is the reference implementation for hand-crafted presentations in this repo.

---

## Decisions

### Troubleshooting subskill created

`resources/troubleshooting.md` documents 10 common failure patterns with symptoms,
diagnosis scripts, and fixes. The relative-path trap is documented first as "The Big One."

### Slides.com subskill created

`resources/slides-com.md` documents the `.sl-block` model, conversion procedures
(from and to Slides.com), confirmed hypotheses, and a reverse-engineering spec for
further verification.

### Screenshot archive policy

Screenshots are saved to `docs/screenshots/` with format `YYYY-MM-DD-[description].png`.
Archived: 4 screenshots from this session. This creates a visual changelog.

---

## Notes

### NOT: 2026-02-28
The relative-path trap (lecture10) is exactly the kind of error that Playwright can catch
autonomously without requiring the human to open the browser and notice visually. The
diagnostic (console errors → 404 → `../../dist/reveal.js`) takes ~10 seconds with
Playwright and would take a human several minutes of confusion. This validates ADR-0009's
argument for Playwright as the primary visual QA methodology.

The slides.com discovery that speaker notes are completely absent is a critical finding for
anyone converting Slides.com presentations to a repo-based workflow. It should be
prominently mentioned in the slides-com subskill.
