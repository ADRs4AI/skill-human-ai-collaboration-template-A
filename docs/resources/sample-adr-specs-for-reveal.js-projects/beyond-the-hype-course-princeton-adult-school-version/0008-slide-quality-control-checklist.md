# ADR 0008: Slide Quality Control Checklist

* Status: accepted
* Deciders: Jérémie Lumbroso
* Date: 2026-02-28

## Context and Problem Statement

Recurring issues have appeared across multiple slide projections that could be caught
early with a systematic pre-publish checklist. These span three categories: required
plugins, stylistic rules, and structural conventions. Without a checklist, each new
slide deck requires manual cross-referencing of ADRs 0001–0007.

## The Checklist

Run this before committing any new slide file. All items must be checked.

---

### ✅ A. Required plugins & scripts

| Item | Check |
|------|-------|
| `reveal.js` v5.1.0 from unpkg | `https://unpkg.com/reveal.js@5.1.0/dist/reveal.js` |
| `plugin/notes/notes.js` loaded | `https://unpkg.com/reveal.js@5.1.0/plugin/notes/notes.js` |
| `RevealNotes` in plugins array | `plugins: [ RevealNotes, RevealMenu ]` |
| `RevealMenu` loaded + in plugins | `https://cdn.jsdelivr.net/npm/reveal.js-menu/menu.js` |
| Custom vertical dots script | `id="vdots"` div + `Reveal.on('ready', ...)` dot generator |
| Copyright notice div | `© Jérémie O. Lumbroso, Ph.D. — University of Pennsylvania` (ADR 0007) |

**Note on Verticator:** Verticator is NOT used in single-topic slide files — it does not
generate dots when there is only one horizontal section (`s.length < 2` condition in
Verticator source). Use the custom dots script instead. Verticator IS used in multi-topic
session slides (e.g., v4-plugins.html) where multiple horizontal sections exist.

---

### ✅ B. Speaker notes — every slide must have `<aside class="notes">`

| Item | Rule |
|------|------|
| Stack header slide | Must have the full TOC format (ADR 0001): `STACK: name / numbered items / NAVIGATE hint` |
| All content slides | Must have contextual notes for speaker use |
| Speaker instructions | Must be in notes — NEVER in slide body text (audiences can see slide body) |
| Navigation reminder | Include `NAVIGATE: ↓ / S for speaker notes (allow popup)` on title slide |

**Pressing S** opens speaker view in a new browser popup. Browser must allow popups for
localhost. Remind speakers to enable popup permission on first use.

---

### ✅ C. Slide structure

| Item | Rule |
|------|------|
| `data-menu-title` on all slides | Required on any slide without a heading; RevealMenu falls back to text content but explicit is better |
| Stack header has speaker TOC | Numbered list of sub-slides with NAVIGATE hint (ADR 0001) |
| No standalone horizontal sections | All content slides must be inside one outer `<section>` for single-topic files |
| Transitions | `transition: 'fade'`, `transitionSpeed: 'fast'` |
| Slide number | `slideNumber: 'c/t'` |

---

### ✅ D. Stylistic conventions (Jérémie's voice — CLAUDE.md)

| Item | Rule |
|------|------|
| Colon capitalization | Capitalize first word after `:` when introducing a complete thought |
| Em-dashes — subordinate | Spaced: ` — ` (e.g., "He didn't know — or did he?") |
| Em-dashes — incise | Unspaced: `—` (e.g., "She was choking—gasping—in the smoke.") |
| Quotes | Always wrap in `<em>` tags for visual distinction |
| Machine Learning | Always `Machine Learning` (capital M, capital L) |
| Human Learning | Always `Human Learning` (capital H, capital L) |
| Speaker instructions | In `<aside class="notes">` only — never in slide body |
| AI terminology | Prefer "Synthetic Intelligence" in explanatory contexts; "AI" acceptable as shorthand |

---

### ✅ E. Visual rules

| Item | Rule |
|------|------|
| Color palette | Navy `#1B3A6B`, Orange `#E07340`, Cream `#FAF8F4` |
| Comic images | `border: 3px solid white; box-shadow: none` |
| `<ol>` inside bordered items | `padding-left: 1.6em` to avoid number clashing with left border |
| `<strong>` inside `<ol> li` | `display: inline` (override `.item strong { display: block }` rule) |
| Copyright | `position: fixed; bottom: 8px; right: 14px; font-size: 10px; color: rgba(0,0,0,0.28)` |
| Fonts | Inter (body) + Crimson Text (headings) — loaded from Google Fonts |

---

### ✅ F. Pre-publish verification steps

1. Open in browser at `http://localhost:8765/[path]`
2. Press `S` — confirm speaker notes popup opens (allow popup in browser)
3. Check slide dots appear on the right side (custom dots script working)
4. Open RevealMenu (≡) — confirm all slide titles are listed correctly
5. Navigate through all slides — confirm no overflow, no broken images, no layout issues
6. Check copyright appears in bottom-right on first slide and a mid-deck slide
7. Verify fragments appear correctly (click through all animations)

---

## Action Items

- [x] ADR 0008 written — 2026-02-28
- [x] v3 slides (llm-limitations, ml-vs-algorithms) pass this checklist
- [ ] Apply checklist retroactively to metacognition, labor-automation, banking-model slides
- [ ] Add `RevealNotes` plugin to all existing topic slide files (v1/v2 files can be skipped;
      apply to any file still actively used as the primary reference)

---

## Iterations

### Iteration 1 (2026-02-28)
- Human: Requested a QC checklist after recurring issues caught during slide review
  (missing RevealNotes, Verticator not working in single-column, speaker instructions
  in slide body, ol numbering clashing with border, quotes not italic)
- AI: Consolidated all rules from ADRs 0001–0007 + session review feedback into this checklist
