# reveal.js Skill — Repository

A Claude Code skill for creating, editing, and validating reveal.js HTML presentations.
Built through human-AI collaboration, dogfooded with Playwright MCP, and structured using
Herbert Simon's Architecture of Complexity principles.

**Authors:** Jérémie Lumbroso and Claude Sonnet 4.6
**Version:** 0.2.0 (beta)
**License:** CC BY-SA 4.0
**Created:** February 2026

---

## Quick Start

### Install the skill

```bash
# Download the latest release
# https://github.com/jlumbroso/revealjs-skill/releases

# Unzip to your Claude skills directory
unzip revealjs-0.2.0.skill -d ~/.claude/skills/revealjs/
```

Or reference manually in your project's `CLAUDE.md`:
```markdown
Load the reveal.js skill from `.claude/skills/revealjs/SKILL.md`.
```

### Use it

The skill activates when you:
- Ask Claude to create or edit a reveal.js presentation
- Work on any `.html` file containing `Reveal.initialize(`
- Need math (KaTeX), diagrams (Mermaid), code, or speaker notes in slides

---

## What's in this repository

### The Skill (`revealjs/`)

```
revealjs/
├── SKILL.md                      # Entry point (~410 lines) — always load this
├── README.md                     # Skill-specific quick reference
├── LICENSE                       # CC BY-SA 4.0
└── resources/                    # 11 subskills — load on demand
    ├── plugins-reference.md      # Full plugin lookup table (CDN URLs, init keys)
    ├── math-katex.md             # Proof-steps grid, color vars, notation box
    ├── diagrams-mermaid.md       # Mermaid setup, color theme, diagram types
    ├── pseudocode-algorithms.md  # white-space: pre-wrap, algorithm/proof boxes
    ├── playwright-review.md      # Visual QA workflow, Reveal.js navigation API
    ├── speaker-notes.md          # Stack TOC format, timing, pre-publish checklist
    ├── pdf-export.md             # DeckTape (primary), print-pdf, file:// vs localhost
    ├── slido.md                  # Intro slide, copy-paste format, end survey
    ├── topic-curation.md         # Topic stacks, session assembly, multi-audience
    ├── troubleshooting.md        # 11 failure patterns: symptom → diagnosis → fix
    └── slides-com.md             # Slides.com format, SLConfig notes, conversion guide
```

### Documentation (`docs/`)

#### Decision Records (`docs/adr/`)

| ADR | Decision |
|---|---|
| [0001](docs/adr/0001-skill-packaging-format.md) | Skill packaging format |
| [0002](docs/adr/0002-versioning-strategy.md) | Versioning strategy |
| [0003](docs/adr/0003-license-file-structure.md) | License file structure |
| [0004](docs/adr/0004-license-files-in-skill-directory.md) | LICENSE in skill directory |
| [0005](docs/adr/0005-skill-consumer-context.md) | Claude Code vs Claude Web context |
| [0006](docs/adr/0006-skill-structure-architecture-of-complexity.md) | AoC-based skill hierarchy |
| [0007](docs/adr/0007-plugin-reference-table-format.md) | Plugin table in markdown |
| [0008](docs/adr/0008-nested-git-repos-handling.md) | Nested repos → gitignore + provenance |
| [0009](docs/adr/0009-playwright-as-visual-qa-methodology.md) | Playwright as visual QA |
| [0010](docs/adr/0010-topic-curation-aoc-derivation.md) | Topic curation pattern (AoC-derived insight) |
| [0011](docs/adr/0011-playwright-dogfooding-findings.md) | Dogfooding findings from 3 sample presentations |

#### Reference Materials (`docs/resources/`)

- `reveal.js/` — Research reports: REVEAL_JS_SPECIFICATION.md, REVEAL_JS_PLUGINS.md, REVEAL_JS_PLUGIN_WIKI.md
- `reveal.js/sample-talks/` — Three sample presentations (lecture10, Slides.com, question-scaffolded)
- `slides.com/` — Two Slides.com exports (test deck, mangled import)
- `sample-adr-specs-for-reveal.js-projects/` — 18 ADRs from 2 real courses (penn-cis5020, beyond-the-hype)
- `skill-format/` — Reference implementations of other Claude skills
- `automated-testing/` — Playwright MCP documentation

#### Seed Documents (`docs/seeds/`)

- `topic-curation-skill-seed.md` — Full seed for a future standalone "topic curation" skill

---

## Key Design Principles

### Architecture of Complexity applied to reveal.js

reveal.js is near-decomposable at five levels:
```
Level 4 — PRESENTATION   The HTML file
Level 3 — TOPIC          <section> horizontal slides (chapters)
Level 2 — SLIDE          <section> vertical slides (individual)
Level 1 — BLOCK          Content elements (h2, lists, code, math)
Level 0 — FRAGMENT       .fragment elements (progressive reveal)
```

SKILL.md (the skill entry point) is itself a stable intermediate form — useful alone,
enhanced by subskills loaded on demand. See [ADR-0006](docs/adr/0006-skill-structure-architecture-of-complexity.md).

### Critical CSS values (do not inflate)

- `line-height: 1.3` (not 1.6)
- `--r-main-font-size: 28px`
- `white-space: pre-wrap` on `.algorithm-box`, `.proof-box` (never on `.math-box`)
- `.code-box { font-size: 0.85em }`

### What Playwright dogfooding confirmed

Testing three real sample presentations (2026-02-28) found:
- **The Big One**: local relative paths (`../../dist/reveal.js`) silently break presentations — always use CDN
- Slides.com exports: 0 console errors, Reveal API works, speaker notes in `SLConfig.notes[UUID]`
- Slides.com imports: destructive for custom CSS — maintain as parallel tracks

---

## Development

### Building

```bash
# CI/CD builds automatically on push to main (artifact) or tag v*.*.* (release)
# Manual test build:
cd revealjs
zip -r ../revealjs-test.skill . -x "*.git*" -x "*.DS_Store" -x ".gitkeep"
```

### Contributing

See [CLAUDE.md](CLAUDE.md) for:
- Prime Directive: commit discussions to ADRs immediately
- Commit message format (`type: subject`)
- Navigation codes (QST:, ANS:, COD:, NOT:, etc.)
- Ephemeral scripts → `scripts/ephemeral/YYYY-MM-DD-*.py`

---

## Companion Skill

The Architecture of Complexity skill (`.claude/skills/architecture-of-complexity/`)
is installed in this repository. It was used during development to derive the skill
architecture (ADR-0006) and identified that the topic curation pattern is generic
enough to become its own skill (ADR-0010).

---

## License

**Skill content:** CC BY-SA 4.0 — Jérémie Lumbroso and Claude Sonnet 4.6

---

**Built using the principles it teaches**
**Status:** Beta (v0.2.0) — Dogfooded via Playwright, not yet production-tested end-to-end
