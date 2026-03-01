# reveal.js Skill

- **Authors:** Jérémie Lumbroso and Claude Sonnet 4.6
- **License:** CC BY-SA 4.0
- **Version:** 0.3.0
- **Last updated:** 2026-02-28

---

## What this skill does

Enables Claude to create, edit, and validate reveal.js HTML presentations with complete
coverage of the reveal.js API — including math (KaTeX), diagrams (Mermaid), pseudocode,
auto-animate, layout helpers, speaker notes, all plugins, Slido integration, PDF export,
Playwright visual QA, and Slides.com conversion.

## File structure

```
revealjs/
├── SKILL.md                        # Entry point (~420 lines): always load this
├── README.md                       # This file
├── LICENSE                         # CC BY-SA 4.0
└── resources/                      # 15 subskills: load on demand
    ├── plugins-reference.md        # Full plugin lookup table (CDN URLs, init keys)
    ├── math-katex.md               # Proof-steps grid, color vars, notation box
    ├── diagrams-mermaid.md         # Mermaid setup, color theme, diagram types
    ├── pseudocode-algorithms.md    # white-space: pre-wrap, algorithm/proof boxes
    ├── playwright-review.md        # Visual QA: Reveal.js API, overflow detection
    ├── speaker-notes.md            # Stack TOC format, timing, pre-publish checklist
    ├── pdf-export.md               # DeckTape (primary), print-pdf, file:// vs localhost
    ├── slido.md                    # Intro slide, copy-paste format, end survey
    ├── topic-curation.md           # Topic stacks, session assembly, multi-audience
    ├── troubleshooting.md          # 11 failure patterns: symptom → diagnosis → fix
    ├── slides-com.md               # Slides.com format, SLConfig notes, conversion
    ├── auto-animate-layout.md      # Auto-Animate, r-stretch/r-stack/r-fit-text, all fragment styles
    ├── markdown-authoring.md       # Markdown slides, external .md files, separators
    ├── media-lightbox.md           # Video, audio, iframe, data-autoplay, lightbox
    └── advanced-config.md          # Full config, themes, keyboard, API events, scroll view
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
| Smooth slide transitions, layout classes | `resources/auto-animate-layout.md` |
| Writing slides in Markdown | `resources/markdown-authoring.md` |
| Video, audio, iframe, lightbox | `resources/media-lightbox.md` |
| Configuration, themes, API events | `resources/advanced-config.md` |

## Spec coverage

All sections of the official reveal.js specification are covered:

| Spec section | Covered in |
|---|---|
| Basic Structure | SKILL.md (boilerplate) |
| Slides (horizontal, vertical, IDs) | SKILL.md |
| Markdown Support | `markdown-authoring.md` |
| Auto-Animate | `auto-animate-layout.md` |
| Backgrounds | SKILL.md + `auto-animate-layout.md` |
| Layout Helpers (r-*) | `auto-animate-layout.md` |
| Transitions | SKILL.md + `advanced-config.md` |
| Fragments (all styles) | SKILL.md + `auto-animate-layout.md` |
| Code Highlighting | SKILL.md + `markdown-authoring.md` |
| Math (KaTeX/MathJax) | SKILL.md + `math-katex.md` |
| Media (video/audio/iframe) | `media-lightbox.md` |
| Lightbox/Preview | `media-lightbox.md` |
| Configuration | SKILL.md + `advanced-config.md` |
| Plugins | SKILL.md + `plugins-reference.md` |
| Advanced (scroll, state, events) | `advanced-config.md` |

## Architecture

This skill follows Herbert Simon's Architecture of Complexity — the same hierarchical
decomposition reveal.js itself uses. SKILL.md is the stable intermediate form; subskills
are near-decomposable modules loaded on demand. See [ADR-0006](../docs/adr/0006-skill-structure-architecture-of-complexity.md).
