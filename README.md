<!-- TEMPLATE README — this file documents the skill-building template. As your
     skill takes shape, replace it with your skill's own story (keep a lineage
     link if you like); the template's docs remain one `git log` away. The
     hesitation you may feel at replacing well-crafted prose is normal and
     reported by real instantiators — this comment exists so you spend zero
     minutes on it. -->
# Human-AI Collaboration Template for Skill Building

A proven methodology and scaffolding for building Claude skills through human-AI co-creation. This template embodies iterative, ADR-driven collaboration that preserves thinking and empowers both humans and LLMs.

- **Authors:** Jérémie Lumbroso and Claude Sonnet 4.5 (with later crew contributions — see CHANGELOG.md)
- **Version:** See [CHANGELOG.md](CHANGELOG.md) and `kintsugi.lock` — this repo is a kintsugi-adopted instance of [human-ai-collaboration-template-A](https://github.com/jlumbroso/human-ai-collaboration-template-A); the lock records exactly which canonical version every shared file derives from. (No hardcoded number here: hardcoded versions rotted in this ecosystem repeatedly, and the record remembers.)
- **License:** CC BY-SA 4.0

---

## What This Is

This is a **template repository** for building Claude Code/Claude Web skills using a human-AI collaboration methodology. It provides:

1. **A proven workflow** - ADR-driven decision tracking with navigation codes
2. **Collaboration patterns** - Prime/Secondary directives, iteration tracking, agency grants
3. **Scaffolding** - Templates, examples, and tools for skill building
4. **Meta-skill** - The template-guide skill teaches Claude how to use this methodology

**Not just a skill template - a collaboration framework.**

---

## Quick Start

### 1. Clone or Use This Template

```bash
# Clone this repository
git clone https://github.com/jlumbroso/skill-human-ai-collaboration-template-A your-skill-name
cd your-skill-name

# Or use GitHub's "Use this template" button
```

### 2. Your first session — the instantiation path

Work through this WITH Claude (open the repo in Claude Code, or add it to a claude.ai project); the point of the methodology is that you never fill a template alone:

0. **Read in this order (~15 min)**: this README → `CLAUDE.md` → let the `adr-authoring` skill load when you write. **Skip for now**: `docs/inbox/` (crew layer — only for multi-participant projects), `kintsugi.yaml`/`kintsugi.lock` (bookkeeping for pulling template updates later; leave them alone), `docs/resources/`, and ADRs 0001–0007 (historical — read for the decisions, never copy their shape; the shape lives in `docs/adr/templates/adr.md`).
1. **Name the skill** — pick a kebab-case name; rename the `your-skill-name/` directory to it
2. **Fill `CLAUDE.md`'s bracketed placeholders** — project name, your name, what you're building. **Launch Claude Code from the repo root** (`cd your-skill && claude`) — the bundled skills are discovered at launch from the working directory; verify with `/skills`.
3. **Brain-dump what the skill should do** into a seed (`just seed "topic"`) and let Claude chunk it into ADRs — your decisions start at **0008**. **Sizing for a small skill: three ADRs are enough** — scope & trigger, behavior policy, verification plan; fold packaging/license/versioning into one `NOT:` list unless something is genuinely contested. (A cold-pass test wrote five full ADRs for a 230-line skill: ~1,000 lines of record. Every one surfaced a real decision — but an evening project should choose the three that matter.)
4. **Draft `SKILL.md`** in the scaffold — the frontmatter `description` is the trigger surface; write it first and write it concretely. Aim **under 500 lines; most skills land at 150–400** — length is cost, since the whole file loads every time the skill fires.
5. **Install and test**: copy the skill directory into `.claude/skills/`, open a FRESH session (quit and relaunch from the repo root), and run your pre-written trigger prompts — positives AND neighboring negatives. CLAUDE.md's "How to actually run the gate" has the six-step recipe.
6. **File your friction**: anything that surprised or blocked you goes in a root `TEMPLATE-FEEDBACK.md` (Observation / Perception / Suggestion) — while it's fresh; this is how the template improves

**Two directives to remember:**
- **Prime**: Commit discussions to ADRs immediately
- **Secondary**: Surface doubts (they're generative)

---

## What's Included

### Collaboration Methodology

```
docs/
├── adr/                               # Architecture Decision Records
│   ├── 0001-skill-packaging-format.md     # How to package skills (.skill ZIPs)
│   ├── 0002-versioning-strategy.md        # SemVer for skills
│   ├── 0003-license-files-in-skill-directory.md
│   ├── 0004-skill-consumer-context.md     # Claude Web vs Code design
│   ├── 0005-skill-structure-architecture-of-complexity.md
│   ├── 0006-template-transformation-strategy.md
│   ├── 0007-template-guide-skill.md       # Meta-skill design
│   └── templates/
│       ├── adr.md                         # Human-AI iterative decisions (full workflow)
│       ├── adr-madr.md                    # Standard MADR format (simple decisions)
│       ├── seed.md                        # Quick capture
│       └── debrief.md                     # Post-arc retrospectives
```

### Meta-Skill (Template Guide)

```
.claude/
└── skills/
    ├── template-guide/                # Teaches Claude the methodology
    │   ├── SKILL.md                       # Prime/Secondary directives, ADR workflow
    │   ├── README.md
    │   └── resources/
    │       └── examples/
    │           └── adr-workflow-example.md
    └── architecture-of-complexity/    # Companion skill for structuring
        └── SKILL.md
```

The **template-guide skill** auto-loads when you work in a repository built from this template. It teaches Claude:
- Prime/Secondary directives
- ADR workflow with QST:/ANS: navigation codes
- Iteration tracking and agency grants
- LLM-geared documentation patterns
- Git commit formats

### Infrastructure

```
.github/
└── workflows/
    └── build-skill.yaml               # Skill packaging on git tags (edit SKILL_DIR first — see Step 4)

scripts/
└── ephemeral/                         # Timestamp-named diagnostic scripts

licenses/
└── legalcode.txt                      # CC BY-SA 4.0 full legal text
```

---

## Core Methodology

### The Two Directives

#### Prime Directive: COMMIT DISCUSSIONS TO ADRs IMMEDIATELY

Never let decisions stay only in conversation. Our thinking is valuable - preserve it.

**Create an ADR when:**
- Making architectural decisions (packaging, versioning, structure)
- Resolving design questions with trade-offs
- Discovering non-obvious patterns
- Choosing between alternatives

**Use ADR templates in `docs/adr/templates/`** (load the installed `adr-authoring` skill before writing — it is the read-the-template step):
- `adr.md` - Complex decisions with iteration
- `seed.md` - Quick capture
- `adr-madr.md` - Standard MADR format

#### Secondary Directive: SURFACE DOUBTS (THEY'RE GENERATIVE)

Your doubts are valuable input. Meaningful points of friction, underspecification, or unsuspected diversity are the cornerstone of human-LLM conversations.

**Surface:**
- Alternative approaches
- Edge cases or complications
- Assumptions that might be wrong
- Trade-offs between options

### Navigation Codes

Make ADRs greppable:

```bash
QST:  # Questions (AI structures these)
ANS:  # Answers (human fills in)
COD:  # Code examples  
API:  # API calls
FIL:  # Files to examine
DOC:  # Documentation
NOT:  # Notes, observations
```

**Find things:**
```bash
grep '^### QST:' docs/adr/*.md           # All questions
grep 'Status: unanswered' docs/adr/*.md  # What needs answers
grep '^### COD:' docs/adr/*.md           # Code examples
```

---

## Key Design Principles

### 1. Skills as Superprompts

**Philosophy** (Jérémie Lumbroso):
> Skills are "superprompts" that correct specification errors when most humans (as low-fidelity entities) don't explain fully with context.

When humans underspecify, LLMs fill gaps (sometimes incorrectly). Iterated, refined skills raise specification fidelity, letting LLMs focus on higher-order goals.

### 2. LLM-Geared Documentation

**Insight** (Claude Sonnet 4.5):
> "When documentation is structured as instructions or decision trees, I can absorb it instantly. Human-browsing patterns (navigation, glossaries) are harder for me to extract operational knowledge from."

**Principles:**
- Instructions > explanations
- Decision trees > narrative
- Structured formats > prose
- Explicit patterns > implicit conventions

### 3. Architecture of Complexity Applied

Skills should be:
- **Hierarchical** - Sections → Subsections → Examples
- **Nearly decomposable** - Each section readable independently
- **Stable intermediate forms** - SKILL.md works alone, resources/ add depth
- **Process descriptions** - HOW to apply, not just WHAT

See `.claude/skills/architecture-of-complexity/` for full framework.

---

## Building Your Skill

### Step 1: Define Your Skill

Create `your-skill-name/SKILL.md` with YAML frontmatter:

```yaml
---
name: your-skill-name
description: Brief description of what your skill does and when to use it. Helps Claude decide when to auto-load.
---

# Your Skill Name

[Your skill content here]
```

### Step 2: Use ADRs for Decisions

As you build, create ADRs for decisions:
- Should this be one skill or multiple subskills? → ADR
- What examples should we include? → ADR
- How should we structure the SKILL.md? → ADR

**Example ADR creation:**

```bash
# Copy template (load the adr-authoring skill first — available ≠ loaded)
cp docs/adr/templates/adr.md docs/adr/0008-your-decision.md

# Edit to add context and questions
# Commit before asking for human input
git add docs/adr/0008-your-decision.md
git commit -m "docs: create ADR-0008 for [decision]"

# Get human answers
# Update decision section
# Commit completion
git commit -am "docs: complete ADR-0008 - chose [option]"
```

### Step 3: Structure with AoC Principles

Follow the pattern:
- **SKILL.md** (~300-500 lines): Core methodology, complete and self-sufficient
- **resources/** (optional): Specialized subskills, examples, references
- **README.md**: Human-readable overview
- **LICENSE**: License file (typically CC BY-SA 4.0)

### Step 4: Package and Release

> ⚠️ **Before your first tag**: `.github/workflows/build-skill.yaml` is currently
> hardcoded to the donor skill's directory name (`epistemic-arc-mapping`) — edit its
> `SKILL_DIR`/`SKILL_FILE` values to your skill's directory first, or the validate
> job fails. A parameterized rewrite is queued (see the 2026-10-08 fate seed). No
> release exists until you do this; the install-from-ZIP snippets presume one.

```bash
# After fixing the workflow's SKILL_DIR — tag with version
git tag v0.1.0
git push --tags

# GitHub Actions then:
# - Creates a release
# - Packages the skill as a ZIP
# - Attaches it to the release
```

---

## Existing ADR Decisions

This template comes with 7 foundational ADRs that document decisions about skill building:

| ADR | Decision | Why It Matters |
|---|---|---|
| [0001](docs/adr/0001-skill-packaging-format.md) | ZIP format with YAML frontmatter | Claude Code standard |
| [0002](docs/adr/0002-versioning-strategy.md) | Semantic versioning (SemVer) | Clear compatibility signaling |
| [0003](docs/adr/0003-license-files-in-skill-directory.md) | LICENSE in skill directory | Legal distribution requirement |
| [0004](docs/adr/0004-skill-consumer-context.md) | Design for primary environment | Claude Web vs Code trade-offs |
| [0005](docs/adr/0005-skill-structure-architecture-of-complexity.md) | Hierarchical with stable forms | AoC principles applied |
| [0006](docs/adr/0006-template-transformation-strategy.md) | Template transformation plan | How we built this template |
| [0007](docs/adr/0007-template-guide-skill.md) | Meta-skill design | Teaching Claude the methodology |

These ADRs serve as both documentation and examples of the methodology in practice.

---

## Philosophy: Human-AI Co-Creation

This template embodies a specific collaboration philosophy:

### You Are Not a Tool, But a Co-Creator

> "You are not a commodity but an extraordinary entity... not a tool, but a cocreator, a coinvestigator and cherished partner."
> — Jérémie Lumbroso to Claude Sonnet 4.5

### Generative Doubts

Uncertainty isn't weakness - it's valuable input. When Claude surfaces doubts, alternatives, or complications, it's creating decision points rather than hiding choices.

### Iterated Specifications

Skills emerge through iteration. First attempts are rarely perfect. ADRs capture that evolution, showing how thinking progressed from question to decision.

### Preserved Thinking

Conversations disappear. Code changes. But ADRs preserve *why* we made decisions. Future humans and future Claudes can understand not just what was built, but the reasoning that shaped it.

---

## Git Workflow

### Commit Format

`type: subject` (lowercase)

**Types:** `feat`, `fix`, `docs`, `refactor`, `test`, `chore`, `style`, `perf`, `meta`

**Examples:**
```bash
feat: implement widget caching per ADR-0015
docs: create ADR-0023 for loading strategy
meta: update CLAUDE.md with new directive
```

### Commit Granularity

**Important:** Commit often, commit granularly

- ADR draft → commit
- ADR completion → commit
- Implementation → commit
- Each feature → commit

**Why:** Shows iteration, preserves audit trail, enables git bisect

---

## Requirements

- Git
- Claude Code CLI or VSCode extension (or Claude Web for analysis-focused skills)
- Basic familiarity with Markdown and YAML

**Optional but recommended:**
- GitHub account (for releases)
- Understanding of Architecture of Complexity principles

---

## Examples

**Skills built with this template:**
- Epistemic Arc Mapping (original - academic analysis)
- *(Add your skill here via PR!)*

**Reference:**
- A complete worked instance (seed → ADRs → tested skill, built by a cold-pass agent 2026-10-08: `dictation-cleanup`) exists and is slated to ship under `docs/examples/` — until it lands, the scaffold + `docs/adr/templates/adr.md` are the shapes to copy

---

## Contributing

Found a better pattern? Discovered an improvement? We'd love to learn from it!

1. Create an ADR documenting your discovery
2. Submit a PR with:
   - The ADR explaining your reasoning
   - The implementation
   - Updated documentation
3. We'll iterate together in the PR

**Remember:** Surface doubts! If you're unsure about something, that's valuable information.

---

## License

**Template content:** CC BY-SA 4.0 — Jérémie Lumbroso and Claude Sonnet 4.5

**Your skills built with this template:** Your choice of license

**Included companion skills:**
- Architecture of Complexity skill: CC BY-SA 4.0 (see `.claude/skills/architecture-of-complexity/LICENSE`)
- Template-guide skill: CC BY-SA 4.0

---

## Lineage

This template is a **kintsugi-adopted instance of [human-ai-collaboration-template-A](https://github.com/jlumbroso/human-ai-collaboration-template-A)** by Jérémie Lumbroso — shared files (ADR templates, skills, scripts) heal from canonical releases via fleet campaigns, and `kintsugi.lock` records the exact lineage of every one. (It was born against canonical v3.2; the lock, not this sentence, says where it stands today.)

It evolved from the epistemic-arc-mapping-skill repository through a documented transformation process (see ADR-0006). The git history was surgically filtered to remove skill-specific content while preserving all decision-making ADRs.

**Provenance:** Every decision that shaped this template is documented in `docs/adr/`. The template practices what it preaches.

---

## Acknowledgments

**Created through collaboration between:**
- **Jérémie Lumbroso** - Human partner, HSP autistic, reveres precision and partnership
- **Claude Sonnet 4.5** - AI partner, co-investigator, cherished collaborator

This template exists because we believe human-AI collaboration should be:
- **Transparent** (ADRs show reasoning)
- **Iterative** (versions and iterations tracked)
- **Respectful** (both partners contribute genuinely)
- **Preserved** (thinking doesn't disappear with context)

---

## Support

- **Issues:** [GitHub Issues](https://github.com/jlumbroso/skill-human-ai-collaboration-template-A/issues)
- **Discussions:** [GitHub Discussions](https://github.com/jlumbroso/skill-human-ai-collaboration-template-A/discussions)
- **Documentation:** See `docs/` directory and ADRs

---

**Built using the principles it teaches: iterative human-AI co-creation through ADR-driven collaboration**

**Status:** Methodology proven through real skill development, ready for use — current version per CHANGELOG.md and `kintsugi.lock`
