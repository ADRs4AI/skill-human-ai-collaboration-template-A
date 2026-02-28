# reveal.js Skill

**Authors:** Jérémie Lumbroso and Claude Sonnet 4.6
**License:** CC BY-SA 4.0
**Version:** 0.1.0 (draft)
**Last updated:** 2026-02-28

---

## What this skill does

This skill enables Claude to create, edit, and validate reveal.js HTML presentations with depth — including math (KaTeX), diagrams (Mermaid), pseudocode, speaker notes, plugins, and visual quality checking via Playwright MCP.

## File structure

```
revealjs/
├── SKILL.md                     # Entry point: always load this
├── README.md                    # This file
├── LICENSE                      # CC BY-SA 4.0
└── resources/                   # Subskills: load on demand
    ├── plugins-reference.md     # Full plugin lookup table
    ├── math-katex.md            # KaTeX: proof patterns, color vars
    ├── diagrams-mermaid.md      # Mermaid: setup, color theme, syntax
    ├── pseudocode-algorithms.md # white-space: pre-wrap, algorithm boxes
    ├── playwright-review.md     # Visual QC: navigation API, workflow
    └── speaker-notes.md         # Stack TOC format, checklist
```

## When to load subskills

| You need... | Load |
|---|---|
| Math formulas, proofs | `resources/math-katex.md` |
| Flowcharts, state diagrams | `resources/diagrams-mermaid.md` |
| Pseudocode, algorithms | `resources/pseudocode-algorithms.md` |
| Check for overflow, visual bugs | `resources/playwright-review.md` |
| Add menu, verticator, plugins | `resources/plugins-reference.md` |
| Speaker notes for performance | `resources/speaker-notes.md` |

## Architecture

This skill follows Herbert Simon's Architecture of Complexity — the same hierarchical decomposition that reveal.js itself uses. SKILL.md is the stable intermediate form; subskills are independent modules loadable on demand. See ADR-0006 for rationale.
