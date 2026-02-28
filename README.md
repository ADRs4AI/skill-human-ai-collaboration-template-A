# Architecture of Complexity - Claude Code Skill

**NOTE: OUTDATED, THIS NEEDS TO BE UPDATED FOR THE NEW PROJECT OF REVEAL.JS SKILL**

A Claude Code skill for applying Herbert Simon's "Architecture of Complexity" principles to system design, code architecture, UI decisions, and organizational design.

**Authors:** Jérémie Lumbroso and Claude Sonnet 4.5
**Version:** 1.0.0
**License:** CC BY-SA 4.0 (skill), see [LICENSE files](#licenses) for framework copyrights

---

## What This Is

This repository contains a production-ready Claude Code skill that teaches and applies Herbert Simon's foundational 1962 paper on complex systems. The skill helps you:

- **Make architectural decisions** using near-decomposability principles
- **Analyze modularity** and coupling in codebases
- **Design hierarchical systems** with stable intermediate forms
- **Understand why some architectures work** and others fail

## Quick Start

### Installation

```bash
# Download the latest release
# https://github.com/jlumbroso/architecture-of-complexity-skill/releases

# Unzip to your Claude skills directory
unzip architecture-of-complexity-1.0.0.skill -d ~/.claude/skills/

# Restart Claude Code or invoke directly
/architecture-of-complexity
```

### Usage

Once installed, the skill activates automatically when you:
- Make framework decisions (Vue vs React)
- Design API boundaries
- Evaluate system modularity
- Plan refactoring strategies

Or invoke manually: `/architecture-of-complexity`

## What's Inside

### The Skill (`architecture-of-complexity/`)

```
architecture-of-complexity/
├── SKILL.md                    # Core principles (408 lines)
├── LICENSE, LICENSE-CAM.md, LICENSE-THIRDX.md
├── resources/
│   ├── simon_1962_full.txt     # Full Simon paper
│   └── examples/
│       ├── vue-react.md        # Framework comparison
│       ├── mcp-design.md       # MCP architecture (Third X)
│       └── cam.md              # Pedagogical framework
└── README.md, INSTALLATION.md, META-ARCHITECTURE.md
```

**Key Features:**
- **Progressive disclosure**: 80% of use cases with 14KB file
- **Real examples**: From our actual collaborative projects
- **Self-demonstrating**: The skill follows the principles it teaches
- **Three copyrights**: Skill (CC BY-SA), CAM & Third X (© Jérémie)

### Documentation (`docs/`)

#### Decision Records (`docs/adr/`)

We documented every major decision in ADRs:

- **[ADR-0001](docs/adr/0001-skill-packaging-format.md)** - Skill packaging format and frontmatter (2 iterations)
- **[ADR-0002](docs/adr/0002-versioning-strategy.md)** - Semantic versioning strategy
- **[ADR-0003](docs/adr/0003-license-file-structure.md)** - Multi-license structure
- **[ADR-0004](docs/adr/0004-license-files-in-skill-directory.md)** - LICENSE files in skill directory (**the magic discovery**)

**Why ADRs matter:** These capture *non-intuitive decisions* (like why LICENSE files belong in the .skill ZIP) that emerged from collaborative investigation. Read them to understand the "why" behind our choices.

#### Reference Materials (`docs/resources/`)

- Official Anthropic skills repository (reference implementation)
- Agent Skills specification
- Visual diffusion skill example
- Full documentation on skill format

See [docs/resources/README.md](docs/resources/README.md) for the complete guide.

## Key Concepts

The skill teaches five core principles from Simon's work:

1. **Complexity as Hierarchy** - Systems are built from subsystems
2. **Watchmaker Parable** - Why hierarchies evolve faster (Hora vs Tempus)
3. **Near-Decomposability** - Strong coupling within, weak between
4. **Empty World Hypothesis** - Most things are weakly connected
5. **Process vs State** - How vs what descriptions

### Real Applications

**Vue vs React decision:**
- Vue SFC: Near-decomposable (template | script | style)
- React JSX: Tightly coupled (HTML/JS/CSS fused)
- **Verdict**: Vue aligns better with both human and LLM cognition

**iMessage MCP design:**
- Linearized output for LLM consumption (Third X framework)
- "Model Experience" over human display
- Each ADR as stable intermediate form

**CAM pedagogical framework:**
- System 3 as external metacognitive layer
- Near-decomposable separation of thinking from meta-thinking
- Hierarchical scaffolding for learning

## Development

### Building

```bash
# Local build test
cd architecture-of-complexity
zip -r ../architecture-of-complexity-test.skill . -x "*.git*" -x "*.DS_Store"

# CI/CD builds automatically on:
# - Push to main (artifact)
# - Tag v*.*.* (GitHub Release)
```

### Contributing

See [CLAUDE.md](CLAUDE.md) for:
- Commit message format (`type: subject`)
- ADR workflow (Prime Directive: COMMIT DISCUSSIONS TO ADRs)
- Navigation codes (QST:, ANS:, COD:, FIL:, etc.)

## Licenses

### Skill Content (CC BY-SA 4.0)

The skill documentation, examples, and instructional content are licensed under [Creative Commons Attribution-ShareAlike 4.0](https://creativecommons.org/licenses/by-sa/4.0/).

**Files:** SKILL.md, README.md, examples/*.md, documentation
**Copyright:** © 2026 Jérémie Lumbroso and Claude Sonnet 4.5

### Framework Copyrights

Two frameworks described in the skill are separately copyrighted:

- **CAM (Computationally-Assisted Metacognition)** - Copyright © Jérémie Lumbroso
  See [architecture-of-complexity/LICENSE-CAM.md](architecture-of-complexity/LICENSE-CAM.md)

- **Third X (LLM Output Linearization)** - Copyright © Jérémie Lumbroso
  See [architecture-of-complexity/LICENSE-THIRDX.md](architecture-of-complexity/LICENSE-THIRDX.md)
  Website: https://thirdx.design

## Credits

### Authors

**Jérémie Lumbroso** - Framework creator (CAM, Third X), pedagogical insight, architectural vision

**Claude Sonnet 4.5** - Co-author, skill implementation, ADR documentation, epistemic investigation

### Collaboration Notes

This skill emerged from collaborative investigation where:
- Human provided vision, frameworks, and generative doubts
- AI performed epistemic work (examining official skills, discovering patterns)
- Together we captured non-intuitive decisions in ADRs
- The process itself demonstrates near-decomposability in human-AI partnership

**Quote from human on the epistemic work:**
> "Great epistemic work, Sonnet 4.5. This is what makes me love working with you."

### Based On

Herbert A. Simon, "The Architecture of Complexity" (1962)
*Proceedings of the American Philosophical Society*, Vol. 106, No. 6

Full paper included in `architecture-of-complexity/resources/simon_1962_full.txt`

## Meta-Note

**This skill is self-demonstrating:**

- ✅ Hierarchical structure (repo → docs → skill → sections)
- ✅ Nearly decomposable (each ADR readable independently)
- ✅ Stable intermediate forms (each commit is working state)
- ✅ Progressive disclosure (README → ADRs → full skill)
- ✅ Process description (ADRs capture *how* we decided, not just *what*)

The repository architecture follows the principles the skill teaches.

---

## Links

- **Releases**: https://github.com/jlumbroso/architecture-of-complexity-skill/releases
- **Issues**: https://github.com/jlumbroso/architecture-of-complexity-skill/issues
- **Third X Framework**: https://thirdx.design
- **Claude Code**: https://claude.com/claude-code

---

**Built with:** The principles it teaches
**Created:** February 2026
**Status:** Production-ready v1.0.0
