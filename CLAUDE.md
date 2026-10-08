# CLAUDE.md - Project Guidance

- **Project**: [Your Skill Name] — a Claude skill built with the ADRs4AI methodology
- **Human**: [Your Name]
- **AI**: [Claude model(s) you work with — sign your work; attribution is part of the method]
- **Last Updated**: [YYYY-MM-DD]

---

## Prime Directive

**COMMIT DISCUSSIONS TO ADRs IMMEDIATELY**

Never let decisions stay only in conversation. Our thinking is valuable - preserve it.

### Corollary: commit substrate changes immediately

When you create or modify an ADR, seed, or the skill itself, *commit it* before moving on. An uncommitted decision is no different from one sitting only in conversation.

---

## Secondary Directive

**SURFACE DOUBTS; THE HUMAN CONSIDERS YOUR DOUBTS TO BE GENERATIVE**

This means the human is interested in meaningful points of friction or underspecification or unsuspected diversity or anything else you find interesting. These doubts are the cornerstone of the human-LLM conversations.

---

## Verification (in place of the canonical Third–Fifth Directives)

A skill repo has no test suite; its gate is behavioral: **load the skill in a fresh session and try its triggers**. Before calling a SKILL.md revision done: (1) does a session with the skill installed actually load it when the trigger scenarios occur? (2) does it stay unloaded for unrelated asks? (3) does the output follow the methodology the skill teaches? Record surprising answers as ADR material — a trigger that misfires is a finding, not an embarrassment.

---

## Sixth Directive: Document Metacognitive Gems

When collaboration produces insights about **how you think** (not just what you build), preserve them as vignettes in `docs/vignettes/YYYY-MM-DD-short-title.md` — narrative, with the "aha" and the lesson. Skill-building is unusually rich in these: the skill you are writing is itself a theory of when and how a mind should think differently.

---

## The Workflow

### When you receive a brain dump:

1. **Read** the dump (use bash for large files)
2. **Identify threads** - separate topics/decisions (usually 2-5)
3. **Create ADRs** — **load the `adr-authoring` skill first** (it is installed in this repo; available ≠ loaded — the skill IS the read-the-template step, and a skeleton filled without it ships unstructured questions). Then copy `docs/adr/templates/adr.md` to `docs/adr/NNNN-short-slug.md` with the next sequential number — check `ls docs/adr/` first; never reuse a number.
4. **Seed each** with relevant excerpt from dump (`docs/adr/templates/seed.md` → `docs/adr/seed-YYYY-MM-DD-topic.md`)
5. **Add navigation codes** (QST:, ANS:, COD:, etc.)
6. **Ask clarifying questions** with context — every question as a `### QST:` block with options and a recommendation, so answering degrades to accept/override

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
grep -E '^### QST(-[A-Za-z0-9-]{1,24})?:' -r docs/adr/   # All questions — both canonical forms; a bare '^### QST:' grep silently misses every handled question
grep 'Status: unanswered' -r docs/adr/                    # What needs answers
grep '^### COD:' -r docs/adr/                             # Code examples
```

---

## Building the skill (this repo's actual work)

### The shape

A skill is a directory: `SKILL.md` (the core, ~300–500 lines) + optional `resources/` (deep dives, worked examples) + `LICENSE`. The scaffold lives at `your-skill-name/` — rename the directory to your skill's kebab-case name as one of your first acts.

### The three rules that matter most

1. **The frontmatter `description` is the trigger surface.** It is the ONLY part of the skill Claude sees before deciding to load it — write it in third person, name the concrete scenarios and keywords that should trigger it, and say what it does NOT cover. A beautiful skill with a vague description never fires.
2. **SKILL.md carries the 80%, `resources/` the depth.** Core methodology complete in the main file; escalation pointers (`→ see resources/...`) for the rest. This is the Architecture of Complexity applied to teaching — the `architecture-of-complexity` skill (installed here) explains why.
3. **Version it like the house does**: a first-line HTML comment `<!-- skill version: "your-skill-name 0.1.0" -->`, bumped deliberately, with a CHANGELOG entry per release. Markers on past releases are historical truth — never re-stamp them.

### The build loop

1. Draft/revise `SKILL.md` in the scaffold directory
2. Install for testing: copy (or symlink) the skill directory into `.claude/skills/` — project-level; `~/.claude/skills/` makes it personal-global
3. **Fresh session**, try the trigger scenarios (the Verification gate above)
4. Record what you learned — surprising trigger behavior is ADR/vignette material
5. Commit granularly; tag releases when the skill reaches coherent states

### Companions installed in this repo

- **`adr-authoring`** — load before writing any ADR/seed/QST (it will also trigger on its own; let it)
- **`template-guide`** — the methodology's own skill; teaches the collaboration patterns
- **`architecture-of-complexity`** — the structural theory behind the SKILL.md + resources/ split

---

## Project Context

### What we're building:

[Describe your skill. What does it do? What problem does it solve? Who is it for?]

### Current focus:

[What you're working on right now]

### Key decisions made:

[List your ADRs here as they're created. The repo ships with ADRs 0001–0007 — the template's OWN decisions about skill packaging, versioning, licensing, and structure. Read them as worked examples; your decisions start at 0008.]

### Open questions:

```bash
grep -E '^### QST(-[A-Za-z0-9-]{1,24})?:' -r docs/adr/
```

---

## File Structure

```
your-skill-name/                        # the repo (rename to your skill)
├── .claude/skills/                     # installed companions + your skill when testing
├── your-skill-name/                    # THE SKILL (rename me) — SKILL.md, README.md, LICENSE, resources/
├── docs/
│   ├── adr/                            # your decisions (0008+) atop the template's (0001–0007)
│   │   └── templates/                  # adr.md (full), adr-madr.md (simple), seed.md (dump), debrief.md
│   ├── feedback/                       # field reports on the skill, friction notes
│   └── METHODOLOGY.md                  # why the system works (read once)
├── scripts/ephemeral/                  # dated one-off diagnostic scripts
├── CLAUDE.md                           # this file
├── QUICK-START.md                      # the 30-second card
└── README.md                           # the template's docs — becomes YOUR skill's story over time
```

---

## Temporary Scripts / Ephemeral Scripts / One-Off Diagnostic Scripts

Create all temporary scripts in `./scripts/ephemeral` with a `yyyy-mm-dd` filename prefix, committed separately with `chore: script for ...`.

- Don't use `cat` or interpreter heredocs; use `Read()` + `Write()` (the permission model favors them)
- Don't use `/tmp`; use `scripts/ephemeral`
- Document the tool's context briefly in its header; if successfully used, append how and the outcome as comments

---

## Git Commits

- **IMPORTANT:** granular and ongoing; commit ADR drafts before asking for human feedback, so the iteration has a record
- Stage by explicit path, never `git add -A`

Format: `type: subject` (lowercase). Types: `feat`, `fix`, `docs`, `refactor`, `test`, `chore`, `style`, `perf`, `meta` (`meta:` = CLAUDE.md, `.claude` settings, repo meta-configuration; `docs:` = ADRs, seeds, vignettes).

---

## Handoff Protocol

If the context window fills mid-work, create `docs/HANDOFF-datetime.md`:

```markdown
# Handoff
**Working on**: [Current ADR/task]
**Last completed**: [What's done]
**Next step**: [What to do next]
**Watch for**: [Any gotchas]
```

Commit it — an uncommitted handoff is no handoff.

---

## Project-Specific Notes

[Yours to fill: domain terminology, rigor standards, output formats, pedagogical stance — whatever your skill's domain demands.]

- It's possible the user uses `asdf` for Node.js/Python runtimes. `source .claude/agent.env` before calling runtimes to access them through asdf's shims.

---

## Give back what the template taught you

When instantiating this template surprises you — a missing explanation, a file that contradicts another, a step you had to invent — record it in a `TEMPLATE-FEEDBACK.md` at the repo root while it is still fresh: **Observation** (what you verified, and how) / **Perception** (what you believed or doubted at that moment) / **Suggestion**. Friction is only perceivable before habituation erases it, and these reports are how the template actually improves (this practice, and several of this template's recent fixes, came from exactly such a report).

---

*For methodology and philosophy, see: `docs/METHODOLOGY.md` (read once, reference as needed)*
