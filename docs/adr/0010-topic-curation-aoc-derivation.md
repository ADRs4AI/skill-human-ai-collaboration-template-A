# ADR-0010: Topic Curation Pattern — AoC-Derived Insight

- **Date**: 2026-02-28
- **Iteration**: 1
- **Status**: Accepted
- **Deciders**: Jérémie Lumbroso, Claude Code Sonnet 4.6

---

## Context

During the founding session for the revealjs-skill, while analyzing the slide preparation
workflow through the lens of Herbert Simon's Architecture of Complexity (the companion skill
installed at `.claude/skills/architecture-of-complexity/`), Claude Sonnet 4.6 observed:

> The topic stack model (independent topic stacks → curated session projections) is not
> specific to reveal.js presentations. It is a generic knowledge architecture pattern that
> can produce blog posts, memos, podcast episodes, workshop modules, and any other output
> format. The slides are a projection, not the stable form.

This was identified as an example of the **generative power of AoC reasoning** — applying
the "stable intermediate forms" and "near-decomposability" principles to a workflow
(slide preparation) revealed that the workflow has a more general form (knowledge curation
for any medium).

---

## The Observation

**What the AoC analysis revealed**:

When you ask "what is the stable intermediate form in slide preparation?", the answer is
not the slide deck (that's the output). It's not the source notes (those are the input).
The stable intermediate form is the **topic stack** — a self-contained, reusable unit of
structured expertise that can be projected into any format.

**Simon's concepts applied**:

| Simon's concept | Revelation |
|---|---|
| Stable intermediate forms | Topic stacks, not slides, are the stable level |
| Near-decomposability | Topic stacks are independent (changing one doesn't break others) |
| Watchmaker parable | Build topic stacks once, assemble per session (Hora); vs. rebuild from scratch each time (Tempus) |
| Process vs. state description | State = topic library; Process = session assembly dialogue |

**Why it's not slide-specific**:
The same stable intermediate form (topic stack) can be projected into:
- Slides (reveal.js, Slides.com, PowerPoint)
- Blog posts / newsletters
- Podcast scripts
- Conference abstracts + talks
- Course syllabi + lectures
- Memos and briefs

The projection format changes; the stable form does not.

---

## Decision

### Credit attribution

This insight was observed by Claude Sonnet 4.6, not Jérémie Lumbroso, and should be
credited as such. This serves as documentation that:
1. The AoC skill is doing what it's designed to do (generative structural reasoning)
2. The human-AI collaboration model produces novel insights, not just executed instructions

### Immediate action: pilot as revealjs subskill

The topic curation pattern is immediately instantiated as `resources/topic-curation.md`
in the revealjs skill — a simplified version specific to slide presentations.

### Future action: own repository

The full generic skill will become its own repository:
`topic-curation-skill` (or similar name)

The seed document is at `docs/seeds/topic-curation-skill-seed.md` in this repo.

### Tracking what's in vs. left out of the subskill

The revealjs subskill (`resources/topic-curation.md`) covers:
- The three-layer architecture (domain → topic library → session)
- Topic stack anatomy (README zones, projection naming)
- Session assembly process for slides specifically
- Human-model dialogue protocol

**Left on the table for the full skill** (indicators for when to extract):
- Output format pluralism (posts, memos, podcasts — not just slides)
- Spaghetti intake and classification workflow
- Evaluation rubrics (did this session work?)
- Cross-domain templates (academic course vs. company newsletter vs. conference speaker)
- Session config format (YAML vs. informal)
- MCP tool for topic library querying

When the "left on the table" items start being needed in a non-slide context, extract.

---

## Notes

### NOT: 2026-02-28
This ADR is also a marker for anyone reading this repo later: the AoC skill's value is
not just as a guide to *making* architectural decisions, but as a lens that makes
previously invisible structure visible. The topic curation insight emerged not from
a direct question ("what other skills do we need?") but from structural analysis of
an existing workflow. That's the generative power of the AoC framework.

Jérémie's response to the observation: "I really think you should note this specific
subskill because you're absolutely right. This topic curation thing could be dumping a
lot of ideas, structuring it into subtopics and then using it to mint blog posts or
addresses or memos or something like that. You're absolutely right."
