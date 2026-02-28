# ADR-0006: Skill Structure Using Architecture of Complexity Principles

- **Date**: 2026-02-28
- **Iteration**: 1
- **Status**: Accepted
- **Deciders**: Jérémie Lumbroso, Claude Code Sonnet 4.6

---

## Context

### QST: How should the reveal.js skill be structured?

reveal.js itself is a hierarchically-decomposed system. The skill that teaches Claude to work with reveal.js should mirror that structure. Herbert Simon's Architecture of Complexity (the companion skill installed at `.claude/skills/architecture-of-complexity/`) provides the framework for this decision.

### QST: How does reveal.js itself embody AoC principles?

reveal.js is near-decomposable at multiple levels:
- **Level 4 (Presentation)**: The HTML file = entire presentation
- **Level 3 (Topics)**: `<section>` horizontal slides = topic chapters
- **Level 2 (Slides)**: `<section>` vertical slides within topics = individual slides
- **Level 1 (Blocks)**: Content blocks within a slide (h2, lists, code, math, diagrams)
- **Level 0 (Fragments)**: `.fragment` elements = progressive reveal within a slide

At each level, internal coupling is strong (a slide's elements are semantically related) and external coupling is weak (changing slide 3 doesn't affect slide 7's content). This is Simon's near-decomposability in action.

The **watchmaker parable** maps directly: presentations are built from stable subassemblies (topic stacks), not from scratch. Each topic stack can be developed, tested, and reused independently — exactly "Hora's" approach.

---

## Decision

### Hierarchical skill with SKILL.md as entry point + loadable subskills

```
revealjs/
├── SKILL.md                        # Entry point: always loaded, ≤500 lines
├── README.md                       # Human-readable overview
├── LICENSE                         # License file
└── resources/                      # Subskills: loaded on demand
    ├── plugins-reference.md        # Plugin lookup table (no-stuttering)
    ├── math-katex.md               # KaTeX: proof patterns, color vars, budget
    ├── diagrams-mermaid.md         # Mermaid: setup, color theme, syntax
    ├── pseudocode-algorithms.md    # white-space: pre-wrap, algorithm-box
    ├── playwright-review.md        # Visual QC: navigation API, workflow
    └── speaker-notes.md            # Stack TOC format, timing, checklist
```

### SKILL.md content (~500 lines)

SKILL.md is the stable intermediate form — useful alone, enhanced by subskills:
1. AoC mental model mapping (this helps LLMs understand reveal.js structure intuitively)
2. Minimal HTML boilerplate (self-contained, CDN-based)
3. CSS baseline (the critical values learned through iteration)
4. Plugin quick reference table (inline summary, deep detail in `plugins-reference.md`)
5. Math: KaTeX minimal setup
6. Diagrams: Mermaid minimal setup
7. Pseudocode pattern (white-space: pre-wrap)
8. Speaker notes format
9. Fragment usage
10. Playwright quality check checklist
11. Subskill loading guidance

### Subskill loading heuristics

| Task | Load subskill |
|---|---|
| Building a presentation with math/proofs | `math-katex.md` |
| Adding flowcharts, state diagrams | `diagrams-mermaid.md` |
| Pseudocode, algorithm steps | `pseudocode-algorithms.md` |
| Need to check for overflow/wrapping | `playwright-review.md` |
| Adding navigation, menus, plugins | `plugins-reference.md` |
| Building speaker notes for performance | `speaker-notes.md` |

---

## The AoC Mapping as Pedagogical Tool

Explicitly mapping reveal.js to AoC principles in SKILL.md serves a specific purpose: it gives Claude an instinctual structural understanding, not just syntax knowledge. When Claude understands that:
- A topic stack = a stable subassembly
- Fragments = atomic sequential steps
- Plugins = near-decomposable modules with `id` + `init(deck)` interface
- CSS variables = the shared state layer (weakly coupled to slide content)

...it makes better architectural decisions when generating or editing presentations.

### The Watchmaker Parable in Practice

**Anti-pattern (Tempus)**: Writing one monolithic HTML file with all slides, inline styles, no reuse → any change requires understanding the whole.

**Pattern (Hora)**: Building topic stacks independently, with shared CSS baseline, CDN plugins, and speaker notes as navigation aid → each stack is testable and reusable.

---

## Alternatives Considered

### Option A: Single flat SKILL.md with everything
- Pro: Simple, one file
- Con: Exceeds 500 line limit; forces Claude to load 5000 lines for a simple task
- Con: Simon's watchmaker principle: flat assembly = high failure rate from interruption

### Option B: Separate skills for each use case (math-skill, diagram-skill)
- Pro: Maximum isolation
- Con: No shared context; CSS baseline would need to be in each
- Con: Violates near-decomposability — these use cases share the same HTML skeleton

### Option C (Chosen): Single SKILL.md + optional depth via resources/
- Pro: Stable intermediate form that works alone
- Pro: Depth is additive, not required
- Pro: Mirrors the long-stack/projection pattern from production use

---

## Notes

### NOT: 2026-02-28
The reveal.js AoC mapping should be documented prominently because it's generative — it's not just documentation, it's the mental model that makes everything else make sense. A model that understands "topic stacks are stable subassemblies" will naturally resist the urge to monolithically generate 50 slides at once.

Explicitly pointing out AoC at every level helps LLMs develop instinctual understanding of the structure. This was a specific request from Jérémie in the founding conversation.
