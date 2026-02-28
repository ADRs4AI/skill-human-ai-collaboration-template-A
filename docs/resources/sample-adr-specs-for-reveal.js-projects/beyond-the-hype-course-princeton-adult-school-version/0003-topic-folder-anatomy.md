# ADR 0003: Topic Folder Anatomy

- **Date**: 2026-02-28
- **Iteration**: 1
- **Status**: Accepted
- **Deciders**: Jérémie Lumbroso, Claude Sonnet 4.6

---

## Quick Reference

```bash
grep '^## ' topics/_template/README.md     # Topic README section headings
ls topics/labor-automation/slides/          # See all projections for a topic
```

---

## The Core Distinction: Accumulation vs. Projection

This is the foundational architectural principle for the whole library.

### Markdown = Accumulation Substrate

The topic `README.md` (and all Markdown files in a topic folder) **accumulate without curation pressure.**

- You only ever *add* to it — never delete, never rewrite
- When something is superseded, you add a note saying so, and keep the old material below it
- It can grow indefinitely; that's the point
- It gets richer with every encounter — new sources, new audience questions, new examples
- It is never "wrong" — it is always the complete historical record

### Slides = Projections

Each slide stack in `topics/[topic]/slides/` is **a projection of the accumulation at a specific moment in time**, made for a specific context.

- A projection is the cross-product of: (content accumulated so far × current perspective × scaffolding intent × target audience × session constraints)
- Projections do NOT "converge" — they don't replace each other the way software versions do
- Each projection is an artifact of its time, shaped by what was being taught, to whom, and why
- Two projections of the same topic may emphasize completely different aspects; both are legitimate
- Projections accumulate alongside the Markdown — they are the record of how the content has been *used*

### Why this matters for versioning

Git tracks *what changed* (continuous diff history).
Explicit projection files track *what the whole picture looked like at this moment* (snapshot history).

Both are needed. You cannot reconstruct a past projection from just git diffs — you also need to know why that selection was made and for what context.

**Never use `latest.html` or overwrite a projection.** Every projection persists.

---

## Slide Naming Convention

Format: `YYYY-MM-DD-vN-[context].html`

- **Date first**: Files sort chronologically in any file browser. The date is the anchor — it prevents vN from implying global convergence across sessions.
- **vN**: Iteration counter *within* a date. If you generate, get feedback, and regenerate on the same day, vN captures that. v1 = first attempt; v2 = post-feedback iteration; etc.
- **Context**: Short slug describing what motivated this projection (session name, audience type, length variant).
- **Not a software version**: vN here means "Nth attempt within this moment in time" — not "improved version of vN-1 from a different date." Each projection is an artifact of its time.

```
topics/labor-automation/slides/
├── 2026-02-27-v1-initial.html                     ← first draft
├── 2026-02-27-v2-princeton-adult-school.html       ← revised for session
├── 2026-04-15-v1-penn-engineering.html             ← different context, new projection
└── 2026-09-01-v1-workshop-deep-dive.html           ← depth session, full long stack
```

**Within a session folder** (`sessions/YYYY-MM-DD-slug/slides/`), the same convention applies — all the decks that were generated for that session are preserved, not just the one used.

---

## Topic Folder Structure

```
topics/[topic-slug]/
│
├── README.md                    # The accumulation substrate (never rewritten, only appended)
│
├── sources/                     # Raw materials relevant to this topic
│   ├── [article-name].md        # Summaries, excerpts, links, commentary
│   └── [study-name].md
│
├── assets/                      # Visual materials for this topic
│   ├── [image].png              # Charts, diagrams, photos
│   └── [visual-prompt].md       # Prompts for diffusion-model image generation
│
├── audience-questions.md        # Recurring questions from actual audiences
│                                # "How does the aporia of this topic present in the wild?"
│
├── connections.md               # Links to related topics and why they connect
│
└── slides/                      # Projections — one per session/context
    └── YYYY-MM-DD-[slug].html
```

---

## README.md Internal Structure

The README uses a **two-zone design**:

### Zone 1: Structured Frontmatter (maintained)

```markdown
# topic: [name]

## The core claim
[1-2 sentences: what is the central argument of this topic?]

## The bad takes we're arguing against
[What does the hype/misinformation say? What are we correcting?]

## Key examples and case studies
[The ATMs, the Jevons paradox, the Hinton radiologist quote — the building blocks]

## What makes audiences anxious / curious about this
[The "aporia" — how does this topic present as a question or concern in the wild?]

## Content inventory
[What's in sources/ and assets/ — a brief index]

## Slide projections made
[Dated list of projections with context: YYYY-MM-DD — [session] — [what was emphasized]]

## Connected topics
[Which other topic folders connect here, and how]
```

### Zone 2: Free Zone (append-only below the divider)

```markdown
---

## Notes, observations, things that don't fit yet

[Anything that doesn't fit the structured sections above goes here.
This section never gets cleaned up — it's an overflow that feeds future structured entries.
Deposit ideas here for later integration by Jérémie or AI.]
```

**The Free Zone is not an inbox.** It's topic-specific overflow. The root `inbox/` is for material that hasn't been assigned to any topic yet.

---

## The Long Stack Principle

Topic slide stacks should be **long and rich** — not short and curated.

- A topic might have 8-12 slides when fully developed (different case studies, different framings, depth and breadth versions of the same argument)
- **Curation happens at session-assembly time**, not at topic-creation time
- For a **depth session** (1-2 topics): pull the full stack for those topics
- For a **breadth session** (6-8 topics): AI selects 1-2 key slides per topic based on session context and time
- The long stack is the source; the session deck is the selection

This means: don't worry about making a topic stack "too long." More is better. Every addition to the stack is another option for future sessions.

---

## Agent Instructions (for AI reading this ADR)

When working with topic folders, follow these rules:

1. **Never delete from README.md** — only append. If something is outdated, annotate it with `[SUPERSEDED YYYY-MM-DD: ...]` and leave the original.

2. **Never overwrite a slide projection** — create a new file with today's date.

3. **Grow the stack, don't replace it** — when adding a new slide to a topic, add it to the existing HTML file OR create a new dated projection that includes both old and new material. Don't replace the old projection.

4. **When in doubt, put it in the Free Zone** — if something doesn't fit the structured README sections, append it to the Free Zone below the `---` divider. It will find its proper place later.

5. **Read the full topic folder before generating a projection** — a projection should be informed by everything in `README.md`, `sources/`, `audience-questions.md`, and `connections.md`.

6. **Date is always YYYY-MM-DD format** — in filenames, in the slide inventory table, in the Free Zone annotations.

---

## Validation

- [x] Jérémie: Accumulation/projection distinction — correct and complete
- [x] Jérémie: Slide naming convention (date first, no version numbers)
- [x] Jérémie: Two-zone README design (structured frontmatter + free zone)
- [x] Jérémie: Long stack principle
- [ ] Jérémie: Free Zone description — does this match your intent?

---

## Action Items

- [ ] Create `topics/_template/` with this anatomy — Sonnet 4.6 (pending approval of reorganization plan)
- [ ] Scaffold all topic folders with empty structure — Sonnet 4.6 (pending approval)
- [ ] Migrate existing topic content from `slides/index-v*.html` into topic folders — Sonnet 4.6 (pending approval)

---

## Iterations

### Iteration 1 (2026-02-28)
- Human: Accumulated/projection insight articulated post-session; confirmed slide naming, two-zone README, long stack principle
- AI: Drafted ADR capturing all decisions
- Outcome: Accepted

---

## Links

- Related ADRs: 0001 (speaker notes format), 0002 (repo as series), 0004 (what goes in ADRs)
- Template: `topics/_template/` (to be created)
- Informed by: Herbert Simon, "Architecture of Complexity" (1962) — near-decomposable subsystems
