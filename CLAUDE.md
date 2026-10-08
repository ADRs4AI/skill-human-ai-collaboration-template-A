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

**How to actually run the gate** (write your prompt list BEFORE testing, so the test can fail):
1. Install: copy the skill directory into `.claude/skills/` (`diff -r` to confirm the copy is exact)
2. Restart: quit and relaunch Claude Code **from the repo root** — a fresh session, not a continued one
3. Confirm the skill is registered: `/skills`, or ask "what skills are available?"
4. Fire the positives: 5–8 prompts that SHOULD trigger it (write them from your description's own scenarios)
5. Fire the negatives: 5–8 neighboring prompts that should NOT trigger it
6. Score honestly, record the misses, iterate the `description` first (it does most of the triggering work)

An agent or CI running headless cannot do step 2 — label any stand-in verification **"proxy-verified"** and say so in the version's changelog entry rather than claiming the gate ran.

---

## Sixth Directive: Document Metacognitive Gems

When collaboration produces insights about **how you think** (not just what you build), preserve them as vignettes in `docs/vignettes/YYYY-MM-DD-short-title.md` — narrative, with the "aha" and the lesson. Skill-building is unusually rich in these: the skill you are writing is itself a theory of when and how a mind should think differently.

---

## The Workflow

### When you receive a brain dump:

1. **Read** the dump (use bash for large files)
2. **Identify threads** - separate topics/decisions (usually 2-5)
3. **Create ADRs** — **load the `adr-authoring` skill first** (it is installed in this repo; available ≠ loaded — the skill IS the read-the-template step, and a skeleton filled without it ships unstructured questions). Mint with `just adr "Short title"` (the justfile numbers it and copies the template). No `just` on the machine? Copy `docs/adr/templates/adr.md` to `docs/adr/NNNN-short-slug.md` by hand — next number = highest existing + 1.
4. **Seed each** with relevant excerpt from dump (`just seed "topic"`, or copy `docs/adr/templates/seed.md` → `docs/adr/seed-YYYY-MM-DD-topic.md`)
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
grep 'Status: unanswered' -r docs/adr/ --exclude-dir=templates   # What needs answers (the skeletons carry example Status lines)
grep '^### COD:' -r docs/adr/                             # Code examples
```

---

## Building the skill (this repo's actual work)

### The shape

A skill is a directory: `SKILL.md` (the core, ~300–500 lines) + optional `resources/` (deep dives, worked examples) + `LICENSE`. The scaffold lives at `your-skill-name/` — rename the directory to your skill's kebab-case name as one of your first acts.

### The three rules that matter most

1. **The frontmatter `description` is the trigger surface.** It is the ONLY part of the skill Claude sees before deciding to load it — write it in third person, name the concrete scenarios and keywords that should trigger it, and say what it does NOT cover. A beautiful skill with a vague description never fires.
2. **SKILL.md carries the 80%, `resources/` the depth.** Core methodology complete in the main file; escalation pointers (`→ see resources/...`) for the rest. This is the Architecture of Complexity applied to teaching — the `architecture-of-complexity` skill (installed here) explains why.
3. **Version it like the house does**: an HTML comment `<!-- skill version: "your-skill-name 0.1.0" -->` on the first line *below the YAML frontmatter* (frontmatter must stay line 1), bumped deliberately, with an entry per release in **the skill's own changelog** — `your-skill-name/CHANGELOG.md` (the root CHANGELOG.md is the template's and gets replaced by template updates). Markers on past releases are historical truth — never re-stamp them.

### The build loop

1. Draft/revise `SKILL.md` in the scaffold directory
2. Install for testing: copy (or symlink) the skill directory into `.claude/skills/` — project-level; `~/.claude/skills/` makes it personal-global
3. **Fresh session**, try the trigger scenarios (the Verification gate above)
4. Record what you learned — surprising trigger behavior is ADR/vignette material
5. Commit granularly; tag releases when the skill reaches coherent states

### Companions installed in this repo

- **`adr-authoring`** — load before writing any ADR/seed/QST (it will also trigger on its own; let it)
- **`template-guide`** — the methodology's own skill; teaches the collaboration patterns. *(Predates adr-authoring and names some files by older names — where the two disagree, adr-authoring wins.)*
- **`architecture-of-complexity`** — the structural theory behind the SKILL.md + resources/ split

Skills in `.claude/skills/` are discovered when the session **starts at the repo root** — launch Claude Code from inside the clone (`cd your-skill && claude`), and verify with `/skills` or by asking "what skills are available?".

---

## Project Context

### What we're building:

[Describe your skill. What does it do? What problem does it solve? Who is it for?]

### Current focus:

[What you're working on right now]

### Key decisions made:

[List your ADRs here as they're created. The repo ships with ADRs 0001–0007 — the template's OWN decisions about skill packaging, versioning, licensing, and structure. **They are historical: read them for the *decisions*, but copy the *shape* from `docs/adr/templates/adr.md` + the adr-authoring skill** — they predate the current form (no TL;DR, older question dialect) and imitating the nearest ADR instead of the template is the most common way the form breaks. Your decisions start at 0008.]

### Open questions:

```bash
just unanswered                                                              # excludes the template skeletons
grep -E '^### QST(-[A-Za-z0-9-]{1,24})?:' -r docs/adr/ --exclude-dir=templates   # all questions, both canonical forms
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
