# reveal.js Skill

**Authors:** Jérémie Lumbroso and Claude Sonnet 4.6
**License:** CC BY-SA 4.0
**Version:** 0.2.0 (beta)
**Last updated:** 2026-02-28

---

## What this skill does

Enables Claude to create, edit, and validate reveal.js HTML presentations with depth:
math (KaTeX), diagrams (Mermaid), pseudocode, speaker notes, plugins, Slido integration,
PDF export, and visual quality checking via Playwright MCP.

## File structure

```
revealjs/
├── SKILL.md                       # Entry point (~410 lines): always load this
├── README.md                      # This file
├── LICENSE                        # CC BY-SA 4.0
└── resources/                     # Subskills: load on demand
    ├── plugins-reference.md       # Full plugin lookup table (CDN URLs, init keys)
    ├── math-katex.md              # KaTeX: proof-steps grid, color vars, notation box
    ├── diagrams-mermaid.md        # Mermaid: setup, color theme, diagram types
    ├── pseudocode-algorithms.md   # white-space: pre-wrap, algorithm/proof boxes
    ├── playwright-review.md       # Visual QA: Reveal.js API, overflow detection
    ├── speaker-notes.md           # Stack TOC format, timing, pre-publish checklist
    ├── pdf-export.md              # DeckTape (primary), print-pdf, file:// vs localhost
    ├── slido.md                   # Intro slide, copy-paste format, end survey
    ├── topic-curation.md          # Topic stacks, session assembly, multi-audience
    ├── troubleshooting.md         # 11 failure patterns: symptom → diagnosis → fix
    └── slides-com.md              # Slides.com format, SLConfig notes, conversion
```

## When to load subskills

| You need... | Load |
|---|---|
| Math formulas, proofs | `resources/math-katex.md` |
| Flowcharts, state diagrams | `resources/diagrams-mermaid.md` |
| Pseudocode, algorithms | `resources/pseudocode-algorithms.md` |
| Check for overflow, visual bugs | `resources/playwright-review.md` |
| Add menu, verticator, or any plugin | `resources/plugins-reference.md` |
| Speaker notes for performance | `resources/speaker-notes.md` |
| Export to PDF | `resources/pdf-export.md` |
| Slido polls / Q&A / surveys | `resources/slido.md` |
| Building from topic stacks | `resources/topic-curation.md` |
| Something's broken | `resources/troubleshooting.md` |
| Working with Slides.com exports | `resources/slides-com.md` |

## Architecture

This skill follows Herbert Simon's Architecture of Complexity — the same hierarchical
decomposition reveal.js itself uses. SKILL.md is the stable intermediate form; subskills
are near-decomposable modules loaded on demand. See [ADR-0006](../docs/adr/0006-skill-structure-architecture-of-complexity.md).
