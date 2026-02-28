# Subskill: Topic Curation for Presentations

Load this when building a presentation from a collection of topic stacks, or when organizing
expertise into reusable modules for multiple audiences.

**Note:** This is a simplified instantiation of the Topic Curation pattern for slide
presentations. The full generic pattern (applicable to blog posts, memos, podcasts, etc.)
is documented at `docs/seeds/topic-curation-skill-seed.md` and will become its own skill.

---

## The Core Mental Model

A presentation is a **projection** — a selection and ordering of topic stacks for a specific
audience and occasion. The topic stacks are the stable material; the presentation is ephemeral.

```
Topic Library        →    Session Assembly    →    Presentation
(stable, growing)         (selection + order)       (ephemeral projection)

Like a music catalog  →   Setlist              →    Concert
```

**AoC framing**: Topic stacks = stable subassemblies. Sessions = watchmaker's assembly.
Never build from scratch. Always select from pre-built modules.

---

## Topic Stack Anatomy

Each topic is a folder:

```
topics/[slug]/
├── README.md                    # Accumulation substrate — APPEND ONLY
├── sources/                     # Articles, excerpts, links
├── assets/                      # Images, diagrams
├── audience-questions.md        # Questions that came up in real sessions
└── slides/                      # Projections
    └── YYYY-MM-DD-vN-[context].html
```

### README.md zones

**Zone 1: Structured (maintain these)**:
```markdown
# topic: [name]

## Core claim
[1–2 sentences: central argument]

## Bad takes we're arguing against
[What does hype/misinformation say? What are we correcting?]

## Key examples and case studies
[The building blocks: what facts/stories does this topic rely on?]

## What makes audiences anxious / curious about this
[The productive tension — the question this topic presents in the wild]

## Content inventory
[Index of sources/ and assets/]

## Projection history
| Date | Session | What was emphasized |
|---|---|---|
| 2026-02-27 | Princeton Adult School | Case study A, light on B |

## Connected topics
[Which other topic folders connect here, and how]
```

**Zone 2: Free zone (append only)**
```
---
## Notes, observations, things that don't fit yet
[Never gets cleaned up — overflow that feeds future structured entries]
```

---

## Session Assembly Process

### 1. Context intake

Establish the parameters before selecting topics:

```markdown
## Session parameters
- **Audience**: [Who? Background? Expertise level?]
- **Occasion**: [Conference / class / workshop / 30-min talk / podcast]
- **Time budget**: [Total minutes available]
- **Primary goal**: [Inspire / teach / persuade / inform / co-create]
- **Angle to emphasize**: [Controversy / practical / historical / technical / human interest]
- **Topics to avoid**: [Anything off-limits for this audience?]
- **Anchor questions**: [Slido questions or discussion prompts that anchor the arc]
```

### 2. Topic selection dialogue

Present the topic library, ask the human to select:

```
Here are the available topic stacks:
1. [Topic A] — [core claim] — [~N slides when full]
2. [Topic B] — [core claim] — [~N slides when full]
3. [Topic C] — [core claim] — [~N slides when full]
...

For a [X-minute] session with [audience], I suggest:
- Topics: A, C, F (in that order)
- Rationale: A establishes the frame, C provides the main argument, F closes with call to action
- Coverage: 3 topics × ~8 min each = 24 min + 6 min intro/Q&A = 30 min

Alternative: Drop F, add B for a more technical slant.

What's your preference? Any topics to add/remove/reorder?
```

### 3. Depth vs. breadth decision

For each selected topic:
- **Full stack** (depth): 8–12 slides, 15–20 min — for topics that are the main focus
- **Curated selection** (breadth): 2–3 slides, 5–8 min — for topics supporting the main arc
- **Single headline slide** (touch): 1 slide, 1–2 min — for context or framing

### 4. Session deck assembly

Combine selected stacks in order. Standard structure:

```html
<!-- Opening: Context and session setup -->
<section>...</section>

<!-- Optional: Slido introduction slide -->
<section>...</section>

<!-- Topic stacks in selected order -->
<section class="stack"> <!-- Topic A full stack --> </section>
<section class="stack"> <!-- Topic B curated selection --> </section>
<section class="stack"> <!-- Topic C headline only --> </section>

<!-- Closing: Call to action, Q&A, survey -->
<section>...</section>
```

### 5. Post-session archive

After the session:
- Add to each topic's `## Projection history` table
- Append audience questions to `audience-questions.md`
- Note what worked / what fell flat in the topic README Zone 2
- Save the session deck as `YYYY-MM-DD-vN-[context].html` in the topic's `slides/` folder

---

## Naming Conventions

### Projection files
```
YYYY-MM-DD-vN-[context].html

Examples:
2026-02-27-v1-initial.html
2026-02-27-v2-princeton-adult-school.html
2026-04-15-v1-penn-engineering.html
```

- **Date first** — files sort chronologically; date is anchor
- **vN** — iteration within that date (v1 = first attempt, v2 = post-feedback revision)
- **Context** — short slug describing audience/occasion
- **Never overwrite** — every projection persists; create a new file with today's date

### Topic slugs
```
labor-automation
cybernetic-epistemic
algorithms-randomized
climate-models
```
Lowercase, hyphenated, concise.

---

## The Accumulation Principle (Critical)

Topic README files are **append-only**. Never delete, never rewrite.

| Action | Right | Wrong |
|---|---|---|
| New case study found | Append to Zone 2, then move to Zone 1 when structured | Rewrite existing section |
| Old information superseded | Add `[SUPERSEDED YYYY-MM-DD: ...]` annotation + keep | Delete old entry |
| Projection created | Add row to `## Projection history` | Overwrite old projection file |
| Audience question answered | Append to `audience-questions.md` | Summarize/delete old questions |

**Why**: Accumulated history is how a model (or human) learns what has worked across contexts.
Deletion destroys this learning. The cost of accumulation is low; the cost of deletion is permanent.

---

## Multi-Audience Variants

The same topic stack can be projected differently for different audiences:

| Audience | What to emphasize | What to cut |
|---|---|---|
| Technical (engineers) | Mechanisms, implementation, edge cases | Narrative framing, history |
| General public | Narrative, real-world impact, analogies | Technical depth, notation |
| Domain experts | Controversy, nuance, current debate | Introduction, basics |
| Students | Process, worked examples, misconceptions | Debate, uncertainty |
| Decision-makers | Implications, trade-offs, recommendations | Implementation details |

Document audience-specific observations in the topic README Zone 2 after each session.

---

## When to Use This Pattern

**Use topic curation when**:
- Building a talk from an existing collection of developed topics
- Preparing multiple talks for different audiences on related themes
- Have 3+ reusable topics ready

**Don't use when**:
- Building a completely new, one-time presentation from scratch
- The topic is singular and narrow
- The audience requires a completely unique structure

---

## Relationship to Other Subskills

Session assembly creates a deck → use `SKILL.md` for HTML structure and CSS.
Topic stack contains math → when projecting, use `math-katex.md`.
Topic stack contains diagrams → when projecting, use `diagrams-mermaid.md`.
Final deck needs visual QA → use `playwright-review.md`.
Final deck includes Slido → use `slido.md`.
