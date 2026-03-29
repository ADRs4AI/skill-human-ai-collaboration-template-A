# ADR-0004: Skill Structure Using Architecture of Complexity Principles

- **Date**: 2026-03-28
- **Iteration**: 3 (Rewritten 2026-03-29)
- **Status**: Accepted
- **Deciders**: Jérémie Lumbroso, Claude Sonnet 4.5/4.6

---

## Context

### QST: How should skills be structured?

Skills teach methodologies or provide guidance. When the skill itself embodies a hierarchical process, the skill structure should mirror that hierarchy. Herbert Simon's Architecture of Complexity (available as a companion skill at `.claude/skills/architecture-of-complexity/`) provides principles for this structural decision.

---

## Decision

### Hierarchical skill with SKILL.md as complete entry point + optional specialized subskills

**Generic Structure**:
```
your-skill-name/
├── SKILL.md                        # Complete methodology (~300-500 lines)
├── README.md                       # Human-readable overview
├── LICENSE                         # License file
└── resources/                      # Specialized subskills (optional)
    ├── specialized-context-1.md    # Adaptations for specific use case
    ├── specialized-context-2.md    # Alternative methodology variation
    ├── worked-examples/            # Full demonstrations
    │   └── example-application.md
    └── reference-catalog.md        # Extended reference material
```

### SKILL.md as stable intermediate form

SKILL.md should be **complete and self-sufficient** for the primary use case:
1. Core methodology or guidance
2. Step-by-step procedures or protocols
3. Key principles or indicators (comprehensive checklist)
4. Output format templates or patterns
5. When to use guidance
6. Integration with other skills (if applicable)

Target: ~300-500 lines (under 500 line recommendation)

### Subskill loading heuristics (optional)

| Context | Load subskill (when needed) |
|---|---|
| Specialized domain or context | `specialized-context-1.md` |
| Alternative methodology | `specialized-context-2.md` |
| Need worked examples for pattern recognition | `worked-examples/` |
| Deep dive into specific aspects | `reference-catalog.md` |

---

## The AoC Principles Applied to Skills

### Near-Decomposability

Skills are **near-decomposable** systems:
- **Core skill (SKILL.md)**: Strong internal coupling - all essential concepts relate to each other
- **Subskills (resources/)**: Weak external coupling - can be loaded independently based on context
- **Stable intermediate form**: SKILL.md works alone; subskills add depth without being required

### The Watchmaker Parable in Practice

**Anti-pattern (Tempus)**: Requiring users to load 10 different files to understand the basic methodology → interruptions (cognitive load, lost context) force restart.

**Pattern (Hora)**: Building understanding module-by-module, each module a stable unit → interruptions affect only current module, prior understanding preserved.

SKILL.md is the stable first assembly. Subskills extend it.

### Hierarchical Levels

Think of skill structure in levels:
- **Level 2 (Complete Skill)**: SKILL.md - the methodology as a whole
- **Level 1 (Core Concepts)**: Sections within SKILL.md (procedures, principles, templates)
- **Level 0 (Details)**: Subskills in resources/ (specialized contexts, extended examples)

At each level, internal coupling is strong (concepts within a section relate to each other) and external coupling is weak (sections can be understood semi-independently).

---

## Alternatives Considered

### Option A: Minimal SKILL.md + many subskills for details
- Pro: Keeps entry point small
- Con: Primary use case requires loading multiple files
- Con: Violates "stable intermediate form" principle — base isn't useful alone
- **Rejected**: Not self-sufficient

### Option B: Everything inline, no subskills
- Pro: Single file, no dependencies
- Con: Would exceed 500-line recommendation for complex skills
- Con: No room for specialized guidance (domain-specific adaptations)
- **Rejected**: Doesn't scale

### Option C (Chosen): Complete SKILL.md + optional specialized subskills
- Pro: SKILL.md is complete and immediately useful (stable intermediate form)
- Pro: Specialized subskills provide depth for edge cases without bloating main file
- Pro: Primary use case requires no additional loading
- Pro: Matches the near-decomposability principle

---

## Notes

### NOT: 2026-03-28
Applying Architecture of Complexity to skill structure itself creates clarity: SKILL.md is the stable form that works independently, with optional depth for specialized contexts. This mirrors how complex systems are built from stable subassemblies.

### NOT: 2026-03-29
This principle applies whether the skill teaches hierarchical analysis, code generation, or any other methodology. The structure (complete core + optional depth) is universal.

---

## Iterations

### Iteration 1 (2026-03-28)
- Applied AoC principles to skill structure
- Identified SKILL.md as stable intermediate form
- Defined subskill loading heuristics
- Outcome: Clear structural pattern for skill organization

### Iteration 2 (2026-03-29) - Answered as no longer relevant
- Human noted that specific skill examples (epistemic arc mapping) are no longer this project's concern
- Confirmed focus on general skill template

### Iteration 3 (2026-03-29) - Template Transformation
- AI: Rewrote ADR generically for skill-building template
- Kept AoC principles (near-decomposability, watchmaker parable, hierarchical levels)
- Removed all skill-specific examples
- Used generic `your-skill-name` structure
- Emphasized that AoC principles apply to any skill structure

---

## Links

- Related: ADR-0001 (Skill Packaging Format)
- Related: ADR-0002 (Versioning Strategy)
- Related: ADR-0004 (Skill Consumer Context) - environment affects structure choices
- Companion: `.claude/skills/architecture-of-complexity/` - AoC principles reference
