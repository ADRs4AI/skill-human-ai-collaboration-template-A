# ADR Workflow Example: Simple Decision

This example shows a complete ADR lifecycle for a straightforward decision.

---

## Initial Context (from conversation)

**User says:**
> "We need to decide whether to use SQLite or PostgreSQL for the skill database. It'll store skill metadata and usage stats."

---

## Step 1: AI Creates Draft ADR

**File:** `docs/adr/0015-database-choice.md`

```markdown
# ADR-0015: Database Choice for Skill Metadata

- **Date**: 2026-04-04
- **Iteration**: 1
- **Status**: Draft
- **Deciders**: [User Name], Claude Code Sonnet 4.5

---

## Context

Need to store skill metadata and usage statistics. Requirements:
- Skill names, descriptions, versions
- Usage counts, last-used timestamps
- Possibly skill dependencies or ratings later

## Questions

### QST: SQLite or PostgreSQL?
- Status: unanswered
- Why asking: Determines deployment complexity vs. scalability
- Need: Scale expectations, deployment environment

**Options:**
- **SQLite**: File-based, zero-config, single-user friendly
- **PostgreSQL**: Client-server, production-grade, multi-user

**ANS:** (by [User Name])
[Fill this in]

### QST: Schema versioning strategy?
- Status: unanswered
- Why asking: Skills will evolve, need migration plan
- Need: Preferred migration tool or approach

**ANS:** (by [User Name])
[Fill this in]

---

## Decision

### [To be filled after answers]

---

## Iterations

### Iteration 1 (2026-04-04)
- AI: Created draft ADR with two questions about database choice and migrations
- Outcome: Ready for human feedback
```

---

## Step 2: AI Commits Draft

```bash
git add docs/adr/0015-database-choice.md
git commit -m "docs: create ADR-0015 for skill database choice

Two questions:
- SQLite vs PostgreSQL (deployment vs scale)
- Schema migration strategy

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>"
```

**Why commit before answers:** Preserves the question formulation, shows iteration

---

## Step 3: Human Answers

**User edits the file:**

```markdown
### QST: SQLite or PostgreSQL?
- Status: answered
- Why asking: Determines deployment complexity vs. scalability
- Need: Scale expectations, deployment environment

**ANS:** (by Jérémie)
SQLite. This is a local tool, not a web service. Simplicity > scalability here.

### QST: Schema versioning strategy?
- Status: answered  
- Why asking: Skills will evolve, need migration plan
- Need: Preferred migration tool or approach

**ANS:** (by Jérémie)
Use Alembic. It's Python-standard and handles SQLite migrations fine.
```

---

## Step 4: AI Processes Answers

**AI updates the Decision section:**

```markdown
## Decision

### Chosen: SQLite with Alembic migrations

**Context**: Local CLI tool, not web service. Deployment simplicity matters more than multi-user scalability.

**Why SQLite:**
- Zero configuration for end users
- File-based (portable, backup-friendly)
- Sufficient for single-user local tools
- Python stdlib support

**Why Alembic:**
- Standard Python migration tool
- Works with SQLite
- Supports future migration to PostgreSQL if needed

**Trade-offs accepted:**
- No built-in multi-user support (not needed)
- File locking limits to single process (acceptable)

---

## Action Items

- [ ] Install `alembic` and `sqlalchemy` dependencies
- [ ] Create initial schema migration  
- [ ] Add database initialization to setup
- [ ] Document schema in README

---

## Iterations

### Iteration 1 (2026-04-04)
- AI: Created draft with database and migration questions
- Outcome: Ready for answers

### Iteration 2 (2026-04-04)
- Human: Chose SQLite + Alembic, emphasized simplicity
- AI: Filled decision section, noted action items
- Outcome: Decision finalized, ready to implement
```

---

## Step 5: AI Commits Completion

```bash
git add docs/adr/0015-database-choice.md
git commit -m "docs: complete ADR-0015 - chose SQLite with Alembic

Decision: SQLite for simplicity (local tool, not web service)
Migration: Alembic (Python standard, SQLite-compatible)

Iteration 2 complete, ready for implementation

Co-Authored-By: Jérémie Lumbroso <lumbroso@example.com>"
```

---

## Result

**Total time:** ~10 minutes  
**Commits:** 2 (draft + completion)  
**Outcome:** Clear decision with reasoning preserved  
**Future benefit:** Anyone can grep for "database" and find this ADR explaining the choice

**Greppable:**
```bash
grep "SQLite" docs/adr/*.md
# Returns: ADR-0015 with complete rationale

grep "Status: answered" docs/adr/0015-database-choice.md  
# Shows both questions were answered
```

---

## Key Patterns Demonstrated

1. **Create ADR before deciding** (not after)
2. **Commit draft separately** (shows iteration)
3. **QST/ANS structure** makes filling in easy
4. **Decision section** captures "why" not just "what"
5. **Action items** bridge decision → implementation
6. **Iteration history** shows evolution of thinking