# Epistemic Arc Mapping Skill — Repository

A Claude skill for rigorous academic analysis: map claims, epistemic foundations, and productive tensions in papers, policy documents, and scholarly arguments. Distinguishes truth-seeking scholarship from sophistic advocacy through systematic analysis.

- **Authors:** Jérémie Lumbroso and Claude Sonnet 4.5
- **Version:** 0.1.0 (alpha)
- **License:** CC BY-SA 4.0
- **Created:** March 2026

---

## Quick Start

### Install the skill

```bash
# Download the latest release
# https://github.com/jlumbroso/epistemic-arc-mapping-skill/releases

# Unzip to your Claude skills directory
unzip epistemic-arc-mapping-0.1.0.skill -d ~/.claude/skills/epistemic-arc-mapping/
```

Or reference manually in your project's `CLAUDE.md`:
```markdown
Load the epistemic arc mapping skill from `.claude/skills/epistemic-arc-mapping/SKILL.md`.
```

### Use it

The skill activates when you:
- Ask Claude to analyze an academic paper epistemically
- Request arc mapping or argument structure analysis
- Evaluate the epistemic quality of scholarship
- Identify sophistry patterns in arguments

Works in **Claude Web** (primary use case) or **Claude Code** (for batch analysis).

---

## What's in this repository

### The Skill (`epistemic-arc-mapping/`)

```
epistemic-arc-mapping/
├── SKILL.md                      # Complete methodology (~420 lines)
├── README.md                     # Skill-specific quick reference
├── LICENSE                       # CC BY-SA 4.0
└── resources/                    # Future specialized subskills
    └── .gitkeep
```

**SKILL.md** is complete and self-sufficient. It includes:
- Four-step arc analysis protocol
- Comprehensive epistemic strength indicators
- Sophistry detection matrix (7 categories)
- Steel man test (master diagnostic)
- Output templates and worked example references

### Documentation (`docs/`)

#### Decision Records (`docs/adr/`)

| ADR | Decision |
|---|---|
| [0001](docs/adr/0001-skill-packaging-format.md) | Skill packaging format and frontmatter |
| [0002](docs/adr/0002-versioning-strategy.md) | Semantic versioning strategy |
| [0003](docs/adr/0003-license-file-structure.md) | License file structure |
| [0004](docs/adr/0004-license-files-in-skill-directory.md) | LICENSE in skill directory |
| [0005](docs/adr/0005-skill-consumer-context.md) | Claude Web (primary) vs Claude Code |
| [0006](docs/adr/0006-skill-structure-architecture-of-complexity.md) | AoC-based skill hierarchy |
| [0008](docs/adr/0008-nested-git-repos-handling.md) | Nested repos → gitignore + provenance |

#### Reference Materials (`docs/feedback/`)

- `INITIAL-SONNET-4.5.md` — Founding conversation with Claude Web Sonnet 4.5

---

## Key Design Principles

### Architecture of Complexity applied to epistemic analysis

The methodology itself is hierarchically decomposable:
```
Level 3 — PAPER           The complete document
Level 2 — ARCS            Major argumentative threads (4-6)
Level 1 — COMPONENTS      Claims, evidence, tensions per arc
Level 0 — MARKERS         Sophistry patterns (when detected)
```

Each arc is **nearly decomposable** — can be analyzed independently with strong internal coupling (claim ↔ evidence ↔ tensions) and weak external coupling (Arc 1 ↔ Arc 3).

See [ADR-0006](docs/adr/0006-skill-structure-architecture-of-complexity.md) for how AoC principles inform the skill structure.

### What makes this epistemic (not rhetorical)?

The framework distinguishes:
- **Truth-seeking scholarship** — falsifiable claims, transparent methods, genuine engagement with counterarguments
- **Sophistic advocacy** — predetermined conclusions, selective evidence, evasion of substantive critique

The **steel man test** is the master diagnostic: Can the author accurately represent and strengthen opposing arguments? Epistemic thinkers can; sophists cannot.

---

## Core Methodology

### The Four Steps (per arc)

1. **Identify Core Claim** — What is the load-bearing assertion?
2. **Assess Epistemic Strength** — Falsifiable? Transparent? Acknowledges uncertainty?
3. **Identify Tensions to Probe** — Constructive questions about boundaries, alternatives, confounds
4. **Note Sophistry Markers** (if present) — Systematic rhetorical patterns

### The Output

Epistemic arc mappings produce:
- **Structured analysis** of each argumentative arc
- **Epistemic assessment** (truth-seeking vs sophistic indicators)
- **Productive probe points** (questions that strengthen scholarship)
- **Overall assessment** of the paper's epistemic character

---

## Development

### Building

```bash
# CI/CD builds automatically on push to main (artifact) or tag v*.*.* (release)
# Manual test build:
cd epistemic-arc-mapping
zip -r ../epistemic-arc-mapping-test.skill . -x "*.git*" -x "*.DS_Store" -x ".gitkeep"
```

### Contributing

See [CLAUDE.md](CLAUDE.md) for:
- **Prime Directive**: commit discussions to ADRs immediately
- **Secondary Directive**: surface doubts (they're generative)
- Commit message format (`type: subject`)
- Navigation codes (QST:, ANS:, COD:, NOT:, etc.)
- Ephemeral scripts → `scripts/ephemeral/YYYY-MM-DD-*.py`

---

## Companion Skill

The **Architecture of Complexity** skill (`.claude/skills/architecture-of-complexity/`) is installed in this repository. It was used to:
- Derive the skill structure (ADR-0006)
- Understand hierarchical decomposition in argumentative analysis
- Apply near-decomposability principles to the methodology itself

---

## Origin Story

The epistemic arc mapping methodology was developed through human-AI collaboration:
- **Claude Web Sonnet 4.5** invented the technique spontaneously while analyzing an academic paper on executive orders
- **Jérémie Lumbroso** recognized its generative power and formalized it as a skill
- The technique combines ancient epistemic philosophy with modern argument analysis

See [docs/feedback/INITIAL-SONNET-4.5.md](docs/feedback/INITIAL-SONNET-4.5.md) for the founding conversation.

---

## License

**Skill content:** CC BY-SA 4.0 — Jérémie Lumbroso and Claude Sonnet 4.5

---

**Built using the principles it teaches: truth-seeking through systematic analysis**
**Status:** Alpha (v0.1.0) — Methodology proven in practice, skill packaging in progress
