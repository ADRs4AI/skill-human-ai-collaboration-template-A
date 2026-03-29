# CLAUDE.md - Project Guidance

- **Project**: Human-AI Collaboration A v3.2 Skill Template
- **Human**: Jérémie Lumbroso  
- **AI**: Claude Web Sonnet 4.5 and Claude Code Sonnet 4.5
- **Last Updated**: March 28, 2026

---

## Prime Directive

**COMMIT DISCUSSIONS TO ADRs IMMEDIATELY**

Never let decisions stay only in conversation. Our thinking is valuable - preserve it.

---

## Secondary Directive

**SURFACE DOUBTS; THE HUMAN CONSIDERS YOUR DOUBTS TO BE GENERATIVE**

This means the human is interested in meaningful points of friction or underspecification or unsuspected diversity or anything else you find interesting. These doubts are the cornerstone of the human-LLM conversations.

---

## Tenth Directive

(Other directives have been occluded because they are not relevant.)

**EXPERIMENT AND LEARN WHEN APPROPRIATE**

(The original Tenth Directive about Playwright MCP was specific to the reveal.js skill. For epistemic arc mapping, experimentation means testing the methodology on diverse papers to refine the framework.)

---

## The Workflow

### When you receive a brain dump:

1. **Read** the dump (use bash for large files)
2. **Identify threads** - separate topics/decisions (usually 2-5)
3. **Create ADRs** - one per thread using `collab-adr-lean.md`
4. **Seed each** with relevant excerpt from dump
5. **Add navigation codes** (QST:, ANS:, COD:, etc.)
6. **Ask clarifying questions** with context

### When you receive answers:

1. **Process** the answers
2. **Fill decision section**
3. **Note action items**
4. **Increment iteration number**

### Navigation codes:

```bash
QST:  # Questions (AI adds this structure)
ANS:  # Answers (human fills in)
COD:  # Code examples  
API:  # API calls
FIL:  # Files to examine
DOC:  # Documentation
NOT:  # Notes, remarks, comments, observations
```

**Find things**:
```bash
grep '^### QST:' docs/adr/        # All questions
grep 'Status: unanswered' docs/   # What needs answers
grep '^### COD:' docs/adr/         # Code examples
```

---

## Temporary Scripts / Ephemeray Scripts / One-Off Diagnostic Scripts

Please create all temporary scripts in:

`./scripts/ephemeral`

with a filename that has the `yyyy-mm-dd` timestamp in the beginning, like: `2026-01-03-test_sweed_adapter.py`

and commit them separately with `chore: script for ...` and qualify the purpose. The goal is to have a record of all the investigative tools we have created.

- Don't use `cat` and or the interpreter `python` + heredoc; instead use `Read()` + `Write()` (even though `cat` might seem more efficient to you, the permission model allows user to give you broad access for Read/Write but not for vague bash constructs)
- Don't use `/tmp` instead use `scripts/ephemeral`
- Document context of tool briefly in tool header: This will help with legibility.

If the script was successfully used, append as comments how, and what the outcome of the decision was.

---

## Project Context

### What we're building:
This repository is to create a skill template repository, that is scaffolded with the human-ai-collaboration-template-A (see `https://github.com/jlumbroso/human-ai-collaboration-template-A` which you are free to clone). We've imported the repository of an actual skill, and the main mission will be to clean up the repository, remove any skill-specific mention, and then create a README.md describing the template, and finally create a `CLAUDE.template.md` that will replace this one and will poise this to start the human with skill building.

### Current focus:
The skill itself (SKILL.md) has been created by Claude Web Sonnet 4.5. Current work involves:
- Cleaning up repository structure (removing artifacts)
- Updating documentation to reflect template
- Preparing for initial release (v0.1.0)

### Key decisions made:
- [Skill packaging format](docs/adr/0001-skill-packaging-format.md) — ZIP with YAML frontmatter
- [Versioning strategy](docs/adr/0002-versioning-strategy.md) — Semantic versioning (SemVer)
- [Consumer context](docs/adr/0005-skill-consumer-context.md) — Claude Web (primary), Claude Code (batch)
- [Skill structure](docs/adr/0006-skill-structure-architecture-of-complexity.md) — Complete SKILL.md + optional specialized subskills

### Current status:
- ✅ SKILL.md created (complete, ~420 lines)
- ✅ README.md updated
- ✅ ADRs cleaned up (removed reveal.js-specific ones)
- ⚠️  Need to finalize packaging and release process

---

## File Structure

**NOT:** will need to be redone

```
epistemic-arc-mapping-skill/
├── .claude/
│   └── skills/
│       └── architecture-of-complexity/       # Companion skill used during development
├── epistemic-arc-mapping/                    # The skill itself
│   ├── SKILL.md                              # Complete methodology (~420 lines)
│   ├── README.md                             # Quick reference
│   ├── LICENSE                               # CC BY-SA 4.0
│   └── resources/                            # Future specialized subskills
│       └── .gitkeep
├── docs/
│   ├── adr/                                  # Architecture Decision Records
│   │   ├── 0001-skill-packaging-format.md
│   │   ├── 0002-versioning-strategy.md
│   │   ├── 0003-license-file-structure.md
│   │   ├── 0004-license-files-in-skill-directory.md
│   │   ├── 0005-skill-consumer-context.md
│   │   ├── 0006-skill-structure-architecture-of-complexity.md
│   │   ├── 0008-nested-git-repos-handling.md
│   │   └── templates/
│   │       ├── collab-adr-lean.md            # human-AI extended ADR template
│   │       ├── seed-template.md              # human-AI seed template
│   │       └── template.md                   # MADR template
│   └── feedback/
│       └── INITIAL-SONNET-4.5.md             # Founding conversation
├── scripts/
│   └── ephemeral/                            # Temporary diagnostic scripts
├── CLAUDE.md                                 # This file — agent guidance
├── README.md                                 # Repository overview
└── LICENSE                                   # Repository license
```

---

## Templates

The templates are in the folder `docs/adr/templates/`.

- **Brain dump**: `docs/adr/templates/seed-template.md` → Simple capture
- **Collaborative decision**: `docs/adr/templates/collab-adr-lean.md` → Full workflow
- **Simple decision**: `docs/adr/templates/template.md` → Standard MADR format

**When to use**:
- Quick question? → Start in conversation, escalate to ADR if needed
- Complex decision? → Create ADR immediately
- Multiple threads? → Create separate ADRs, link them

---

## Git Commits

- **IMPORTANT:** Make sure commits are granular, and ongoing.
- Commit ADR drafts before asking for human feedback (so there's a record of your iteration, and then human feedback gets another commit)

Format: `type: subject` (lowercase)

Types: `feat`, `fix`, `docs`, `refactor`, `test`, `chore`, `style`, `perf`, `meta`

Example: `feat: implement JWT authentication per ADR-0014`

`meta:` commits are relative to `AGENTS.md`/`CLAUDE.md`, `.claude` settings, and meta-configuration of the repository.

---

## Handoff Protocol

If context window fills mid-work, create `docs/HANDOFF-datetime.md`:

```markdown
# Handoff

**Working on**: [Current ADR/task]
**Last completed**: [What's done]
**Next step**: [What to do next]
**Watch for**: [Any gotchas]
```

---

## Project-Specific Notes

- This repo was originally cloned from `epistemic-arc-mapping-skill` and has been repurposed for as a general template for skill packaging. Cleanup is ongoing.

- The `architecture-of-complexity-skill` is installed at `.claude/skills/architecture-of-complexity/` as a companion skill. It was used to structure this skill (see ADR-0006).

- It's possible the user uses `asdf` for Node.js and Python and the runtime of most languages. You can `source .claude/agent.env` before calling the runtimes, like `python` or `node` to access them through `asdf`'s shims. See: https://asdf-vm.com/manage/configuration.html

---

*For methodology and philosophy, see: `docs/METHODOLOGY.md` (read once, reference as needed)*
