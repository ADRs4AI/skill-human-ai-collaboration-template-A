# ADR 0001: Topic Stack Architecture and Speaker Notes Format

- **Date**: 2026-02-27
- **Iteration**: 1
- **Status**: Accepted
- **Deciders**: Jérémie Lumbroso, Claude Sonnet 4.6

---

## Quick Reference

```bash
grep '^### QST:' docs/adr/0001-*.md   # Open questions
grep 'Status: unanswered' docs/adr/0001-*.md
```

---

## Human Context

> The format with the stacks, the thematic stacks works very well, but we need to do something
> with the speaking notes. In the speaking notes, what would be nice is if I had a recap 1, 2, 3, 4
> of the things covered in the stack and the order in which they're covered. So that when I touch
> the stack, I can see what's inside of it without having to unspool the slides.
>
> One of the things that made it hard is because of the builds, I wasn't able to see a lot of...
> Like my RAM was not able to load a lot of the slides. Like I was flying almost blind.
> And the interface in SpeakerJS was not very good for that.
>
> — Jérémie, debrief after 2026-02-27 Princeton Adult School session

**Core problems identified:**
1. Stack header slides give no preview of what's inside — presenter must unspool to see
2. Reveal.js's overview mode and speaker notes were insufficient given Zoom + browser constraints
3. Memory/RAM constraints meant slides didn't load well in speaker view

---

## AI Interpretation

**Two related but distinct decisions:**

1. **Stack TOC in speaker notes** — A quick, implementable fix: every stack header slide should have a numbered table of contents in its `<aside class="notes">` showing exactly what sub-slides exist and in what order.

2. **Broader "how to navigate stacks in the dark" problem** — This is about the presenter's mental model of what's available. The TOC fixes speaker view; a separate "stack index card" concept might help further.

**Assumptions:**
- The topic stack structure (pastel color header → 2-5 sub-slides) is confirmed as working well
- The Zoom + browser-share constraint is real and permanent (not a temporary setup issue)
- Speaker notes are accessed via Reveal.js speaker view (press `S`) on a separate window/tab

---

## Decision

### Context

The first session (2026-02-27, Princeton Adult School) confirmed that the **topic stack structure works well** as a conversational scaffold. Each stack gives the presenter a natural chapter boundary and thematic anchor.

However, the **header slide was a "black box"** during presentation: touching a topic stack showed only its title, requiring the presenter to either:
- Unspool sub-slides to see what's inside (disrupts flow)
- Rely on memory for 12+ topic stacks (unreliable under live conditions)

This was particularly painful on Zoom with browser sharing where switching between windows has overhead.

### Options

**Option A: TOC in header slide speaker notes**
- Format: numbered list in `<aside class="notes">` on each stack header
- Pros: Zero extra slides; uses existing speaker view; immediate
- Cons: Requires speaker view to be open and functional

**Option B: Visual mini-map sub-slide**
- An actual slide (data-visibility="hidden"?) after the header showing the stack contents
- Pros: Visible in overview mode (press Esc); doesn't require speaker view
- Cons: Adds clutter; navigation confusion

**Option C: Stack overview card as a printed reference**
- Generate a PDF cheat sheet showing all stacks and their contents
- Pros: Works offline, no RAM pressure
- Cons: Two-window management

### Chosen: Option A (TOC in speaker notes) + Option C (printed cheat sheet) as backup

**Why**: Option A is the right primary fix and costs nothing. The COURSE-MAP.md already serves as the cheat-sheet content — print it before each session.

**Trade-offs accepted**: Still requires speaker view to be functional (RAM-dependent). For low-RAM situations, have COURSE-MAP.md open in a separate tab.

---

## Implemented Format

Every **stack header slide** (the pastel topic title slide) must have speaker notes in this exact format:

```html
<section data-background-color="#COLORCODE">
  <p class="topic-title">topic name</p>
  <p class="topic-tagline">subtitle</p>
  <aside class="notes">
    STACK: topic name
    ─────────────────
    1. [Sub-slide title] — [one-line description]
    2. [Sub-slide title] — [one-line description]
    3. [Sub-slide title] — [one-line description]
    [Add more as needed]
    ─────────────────
    NAVIGATE: ↓ to dive in · → to skip to next topic

    [Optional: conversation prompt or key question for this topic]
  </aside>
</section>
```

**Rules:**
- Always present — no stack header without a TOC
- Maximum 1 line per sub-slide (discipline in brevity)
- Always include the NAVIGATE line
- Can include one optional conversation starter after the divider

---

## Example: labor & automation stack header notes

```
STACK: labor & automation
─────────────────
1. Entry-Level Crisis — the on-ramp disappearing
2. ATM Lesson — Bessen: teller employment went UP
3. Jevons Paradox — efficiency → more consumption, not less (Narayanan/lawyers)
4. Radiologist Mistake — Hinton 2016, still wrong in 2026
5. Home Robot Reality — physical world ≠ language world
─────────────────
NAVIGATE: ↓ to dive in · → to skip to next topic

Opening prompt: "Is anyone seeing the entry-level problem in their field?"
```

---

## Action Items

- [x] Format defined — Sonnet 4.6
- [ ] Apply to index-v3.html — Sonnet 4.6 (next session prep)
- [ ] Apply to index-v2.html — Sonnet 4.6 (next session prep)
- [ ] Print COURSE-MAP.md before each session — Jérémie
- [ ] Consider adding a "loading" or "lightweight" mode config to Reveal.js — future

---

## Iterations

### Iteration 1 (2026-02-27)
- Human: Identified flying-blind problem after first live session
- AI: Defined TOC format for speaker notes; chose Option A + C
- Outcome: Format specified; implementation pending

---

## Links

- Related ADRs: 0002 (repo architecture), 0003 (session instance structure)
- Supersedes: nothing (first ADR for this course)
- Applied to: `slides/index-v3.html`, `slides/index-v2.html`
- Reference: `docs/COURSE-MAP.md` (the printable cheat sheet)
