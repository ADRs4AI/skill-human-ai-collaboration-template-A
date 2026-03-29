# ADR-0006: Skill Structure Using Architecture of Complexity Principles

- **Date**: 2026-03-28
- **Iteration**: 2
- **Status**: Accepted
- **Deciders**: Jérémie Lumbroso, Claude Sonnet 4.5/4.6

---

## Context

### QST: How should the epistemic arc mapping skill be structured?
- Status: answered
The skill teaches a hierarchical analysis methodology — breaking papers into arcs, arcs into components (claims, evidence, tensions). The skill structure should mirror this analytical hierarchy. Herbert Simon's Architecture of Complexity (the companion skill installed at `.claude/skills/architecture-of-complexity/`) provides the framework for this decision.

**ANS:** (by Jérémie)

No. That skill has already been constructed in a separate repository. It is no longer this repository's concern (or ours).

### QST: How does epistemic arc mapping embody AoC principles?
- Status: answered
The methodology itself is near-decomposable at multiple levels:
- **Level 3 (Paper)**: The complete document being analyzed
- **Level 2 (Arcs)**: Major argumentative threads (4-6 per paper)
- **Level 1 (Arc Components)**: Claims, evidence, tensions within each arc
- **Level 0 (Sophistry Markers)**: Specific rhetorical patterns (when present)

At each level, internal coupling is strong (an arc's components relate to each other) and external coupling is weak (Arc 1 can be analyzed independently of Arc 3). This is Simon's near-decomposability in action.

The **watchmaker parable** maps to the analysis process: build arc-by-arc (stable intermediate forms), not attempting to hold the entire paper's argument structure in working memory at once.

**ANS:** (by Jérémie)

Once more, the epistemic arc mapping is not part of this project. This project is a general skill template, scaffolded by the human-AI collaboration template A.

---

## Decision

### Hierarchical skill with SKILL.md as complete entry point + optional specialized subskills

```
epistemic-arc-mapping/
├── SKILL.md                        # Complete methodology: ~420 lines
├── README.md                       # Human-readable overview
├── LICENSE                         # License file
└── resources/                      # Specialized subskills (future)
    ├── policy-documents.md         # Adaptations for policy analysis
    ├── book-chapters.md            # Book-length argument mapping
    ├── worked-examples/            # Full arc mappings
    │   └── chachko-executive-orders.md
    └── sophistry-catalog.md        # Extended sophistry patterns
```

### SKILL.md content (~420 lines)

SKILL.md is the stable intermediate form — complete and self-sufficient:
1. Core methodology (Claims → Evidence → Tensions → Probe points)
2. Four-step arc analysis protocol
3. Epistemic strength indicators (comprehensive checklist)
4. Sophistry detection matrix (7 categories, inline)
5. Output format template
6. Syntactic vs semantic thinking diagnostic
7. Steel man test (master diagnostic)
8. Quick reference comparison table
9. When to use guidance
10. Integration with other skills

### Future subskill loading heuristics

| Task | Load subskill (when created) |
|---|---|
| Analyzing policy documents or committee reports | `policy-documents.md` |
| Mapping book-length arguments | `book-chapters.md` |
| Need worked examples for pattern recognition | `worked-examples/` |
| Deep dive into specific sophistry patterns | `sophistry-catalog.md` |

---

## The AoC Mapping as Analytical Tool

Explicitly mapping epistemic arc methodology to AoC principles serves a specific purpose: it gives Claude an instinctual understanding of how to decompose complex arguments. When Claude understands that:
- Each arc = a stable subassembly (independently analyzable)
- Arc components (claim, evidence, tensions) = the internal structure with strong coupling
- Arcs relate weakly to each other = near-decomposability
- The meta-arc = the overarching structure that emerges from composed arcs

...it makes better analytical decisions when mapping papers.

### The Watchmaker Parable in Practice

**Anti-pattern (Tempus)**: Attempting to hold the entire paper's argument structure in working memory, analyzing everything at once → interruptions (new information, alternative interpretations) force restart.

**Pattern (Hora)**: Building arc-by-arc, each arc a stable analytical unit → interruptions affect only current arc, prior work preserved.

---

## Alternatives Considered

### Option A: Minimal SKILL.md + many subskills for details
- Pro: Keeps entry point small
- Con: Primary use case (single-paper analysis in Claude Web) requires loading multiple files
- Con: Violates "stable intermediate form" principle — base isn't useful alone

### Option B: Everything inline, no subskills
- Pro: Single file, no dependencies
- Con: Would exceed 500-line recommendation
- Con: No room for specialized guidance (policy docs vs academic papers)

### Option C (Chosen): Complete SKILL.md + optional specialized subskills
- Pro: SKILL.md is complete and immediately useful (stable intermediate form)
- Pro: Specialized subskills provide depth for edge cases without bloating main file
- Pro: Primary use case (Claude Web single-paper) requires no additional loading
- Pro: Matches the near-decomposability of the methodology itself

---

## Notes

### NOT: 2026-03-28
The epistemic arc mapping methodology itself embodies AoC principles (hierarchical decomposition, near-decomposability, stable intermediate forms). The skill structure should mirror this — SKILL.md is the stable form that works independently, with optional depth for specialized contexts.

This differs from the reveal.js skill structure decision (ADR-0006 iteration 1), where subskills were essential for different use cases (math, diagrams, etc.). For epistemic arc mapping, the core methodology is complete in SKILL.md; subskills provide specialized adaptations, not essential functionality.
