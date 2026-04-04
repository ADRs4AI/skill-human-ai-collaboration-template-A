# CLAUDE.md - Project Guidance

- **Project**: [Your Skill Name]
- **Human**: [Your Name]
- **AI**: Claude Web Sonnet 4.5 and/or Claude Code Sonnet 4.5
- **Last Updated**: [YYYY-MM-DD]

---

## Prime Directive

**COMMIT DISCUSSIONS TO ADRs IMMEDIATELY**

Never let decisions stay only in conversation. Our thinking is valuable - preserve it.

---

## Secondary Directive

**SURFACE DOUBTS; THE HUMAN CONSIDERS YOUR DOUBTS TO BE GENERATIVE**

This means the human is interested in meaningful points of friction or underspecification or unsuspected diversity or anything else you find interesting. These doubts are the cornerstone of the human-LLM conversations.

---

## The Workflow

### When you receive a brain dump:

1. **Read** the dump (use bash for large files)
2. **Identify threads** - separate topics/decisions (usually 2-5)
3. **Create ADRs** - one per thread using `docs/adr/templates/collab-adr-lean.md`
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

## Temporary Scripts / Ephemeral Scripts / One-Off Diagnostic Scripts

Please create all temporary scripts in:

`./scripts/ephemeral`

with a filename that has the `yyyy-mm-dd` timestamp in the beginning, like: `2026-01-03-test-widget-loading.py`

and commit them separately with `chore: script for ...` and qualify the purpose. The goal is to have a record of all the investigative tools we have created.

- Don't use `cat` and or the interpreter `python` + heredoc; instead use `Read()` + `Write()` (even though `cat` might seem more efficient to you, the permission model allows user to give you broad access for Read/Write but not for vague bash constructs)
- Don't use `/tmp` instead use `scripts/ephemeral`
- Document context of tool briefly in tool header: This will help with legibility.

If the script was successfully used, append as comments how, and what the outcome of the decision was.

---

## Project Context

### What we're building:

[Describe your skill here. What does it do? What problem does it solve? Who is it for?]

Example:
> This is a skill for [purpose]. It helps Claude [main capability]. Primary use case is [scenario].

### Current focus:

[What are you working on right now?]

Example:
> - Defining core methodology
> - Creating SKILL.md structure  
> - Building example use cases
> - Preparing for v0.1.0 release

### Key decisions made:

[List ADRs with brief summaries as they're created]

Example:
> - [ADR-0008](docs/adr/0008-skill-structure.md) — Hierarchical with SKILL.md + resources/
> - [ADR-0009](docs/adr/0009-primary-environment.md) — Claude Web primary, Claude Code secondary
> - [ADR-0010](docs/adr/0010-example-format.md) — Worked examples in resources/examples/

### Current status:

[Track major milestones]

Example:
> - ⏳ SKILL.md in progress (~200/500 lines)
> - ⏳ Gathering example use cases
> - ❌ Need to decide on subskill structure
> - ✅ Core methodology defined

---

## File Structure

[Document your intended structure here. Update as it evolves.]

```
your-skill-name/
├── .claude/
│   └── skills/
│       └── [companion-skill]/          # Optional: other skills used during development
├── your-skill-name/                    # The skill itself
│   ├── SKILL.md                        # Main skill content (~300-500 lines recommended)
│   ├── README.md                       # Human-readable overview
│   ├── LICENSE                         # Your chosen license (e.g., CC BY-SA 4.0)
│   └── resources/                      # Optional: subskills, examples, references
│       ├── specialized-context.md
│       └── examples/
│           └── worked-example.md
├── docs/
│   └── adr/                            # Architecture Decision Records
│       ├── 0001-first-decision.md
│       ├── 0002-second-decision.md
│       └── templates/
│           ├── collab-adr-lean.md     # Human-AI extended ADR template
│           ├── seed-template.md        # Quick capture
│           └── template.md             # Standard MADR template
├── scripts/
│   └── ephemeral/                      # Temporary diagnostic scripts
├── CLAUDE.md                           # This file — agent guidance
├── README.md                           # Repository overview
└── LICENSE                             # Repository license
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

- **IMPORTANT:** Make sure commits are granular and ongoing.
- Commit ADR drafts before asking for human feedback (so there's a record of your iteration, and then human feedback gets another commit)

Format: `type: subject` (lowercase)

Types: `feat`, `fix`, `docs`, `refactor`, `test`, `chore`, `style`, `perf`, `meta`

Example: `feat: implement JWT authentication per ADR-0014`

`meta:` commits are relative to `CLAUDE.md`, `.claude` settings, and meta-configuration of the repository.

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

[Add any specific notes, preferences, or patterns for this project]

Examples:
- Preferred code style or formatting
- Domain-specific terminology
- Stakeholders or reviewers
- Dependencies or constraints
- Testing requirements
- Documentation standards

---

## Skill-Specific Guidance

[Add guidance specific to your skill domain]

Examples:
- If academic skill: citation format, rigor standards
- If code generation skill: language preferences, patterns to follow
- If analysis skill: output format, depth of analysis
- If tutorial skill: pedagogical approach, target audience

---

*For methodology and philosophy, see: `README.md` in repository root (read once, reference as needed)*

*For collaboration patterns, the template-guide skill at `.claude/skills/template-guide/` will auto-load when you work in this repository.*
