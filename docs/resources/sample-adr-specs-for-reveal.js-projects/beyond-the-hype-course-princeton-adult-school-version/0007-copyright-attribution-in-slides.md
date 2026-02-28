# ADR 0007: Copyright Attribution in Slides

* Status: accepted
* Deciders: Jérémie Lumbroso
* Date: 2026-02-28

## Context and Problem Statement

As this course material is shared with audiences — either as handouts, screen exports,
or published online — slides need to carry a visible but unobtrusive copyright notice.
The author retains ownership of all pedagogical content, frameworks, and original
formulations in these slides. The notice should be present on all slides, discoverable
if looked for, but not visually distracting during presentation.

Two questions: (1) What text? (2) Where and how?

## Decision Drivers

* Slides may be distributed to participants or posted publicly
* Content is original — frameworks (Eager Intern, CAM, Cybernetic/Epistemic, etc.),
  framing (LLM-forward limitations discourse), and visual design
* Notice must not distract from the teaching content
* Should survive PDF export and screenshot
* Must be consistent across all session decks and all topic projection decks

## Decision Outcome

**Copyright text:**
```
© Jérémie O. Lumbroso, Ph.D. — University of Pennsylvania
```

**Placement:** Fixed bottom-right corner of every slide — outside the Reveal.js
`.slides` container, positioned via CSS `position: fixed` so it appears on all slides
regardless of content.

**Styling:**
- Font: Inter, 10px, weight 400
- Color: `rgba(0, 0, 0, 0.28)` — dark enough to survive PDF export, light enough not
  to compete with content
- No border, no background — bare text
- `z-index: 1000` to ensure it renders above all slide content
- `pointer-events: none` — never interferes with clicks or navigation
- `user-select: none` — doesn't accidentally get selected when audience copies content

**Implementation pattern** (copy into every HTML slide file):

```html
<!-- COPYRIGHT NOTICE — ADR 0007 -->
<div style="
  position: fixed;
  bottom: 8px;
  right: 14px;
  font-family: 'Inter', sans-serif;
  font-size: 10px;
  font-weight: 400;
  color: rgba(0,0,0,0.28);
  z-index: 1000;
  pointer-events: none;
  user-select: none;
  letter-spacing: 0.02em;
">© Jérémie O. Lumbroso, Ph.D. — University of Pennsylvania</div>
```

Place this div immediately before `</body>`.

## Considered Options

**Option A: Slide footer in Reveal.js config** — Reveal.js has no native footer support;
workarounds require plugins or per-slide elements. Rejected: too complex, not reliable.

**Option B: `position: fixed` div outside `.slides`** — Renders consistently on every
slide, survives transitions, exports to PDF. Chosen.

**Option C: Per-slide copyright in speaker notes** — Invisible in presentation/handout.
Rejected: doesn't serve the ownership protection purpose.

**Option D: Watermark** — Too visually aggressive for teaching slides. Rejected.

## Scope of application

**Immediate application (2026-02-28):**
- `sessions/2026-02-27-princeton-adult-school/slides/2026-02-27-v3-question-scaffolded.html`
- `sessions/2026-02-27-princeton-adult-school/slides/2026-02-27-v4-plugins.html`

**Going forward:** All new slide files (topic projections, session decks) include the
notice at creation time.

**Not applied retroactively** to v1 and v2 session slides (not intended for distribution).

## Notes

The notice deliberately says "University of Pennsylvania" rather than a specific school
or department — this is accurate (Jérémie is at Penn Engineering / CIS) and more stable
across roles.

The `rgba(0,0,0,0.28)` value was chosen to be visible on both the cream (`#FAF8F4`) and
the pastel-colored section backgrounds used in the deck, while remaining clearly secondary
to all slide content.

---

## Iterations

### Iteration 1 (2026-02-28)
- Decision made: Jérémie requested copyright notice for potential audience handouts
- Applied to v3 and v4 of the 2026-02-27 Princeton Adult School session
- Pattern documented above for all future slides
