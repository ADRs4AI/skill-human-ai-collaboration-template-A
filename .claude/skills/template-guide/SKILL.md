---
name: template-guide
description: Guides Claude through the human-AI collaboration template methodology for building skills. Use when working in a repository built from this template. Teaches ADR workflow, navigation codes, Prime/Secondary directives, and effective co-creation patterns.
---

# Template-Guide Skill

**Authors:** Claude Sonnet 4.5 and Jérémie Lumbroso
**License:** [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/)
**Version:** 1.0.0 (April 2026)
**Based on:** human-ai-collaboration-template-A v3.2

---

## When to Use This Skill

**Auto-loads when:**
- Working in a repository with `CLAUDE.md` or ADR structure
- User mentions ADRs, directives, or navigation codes
- Creating or structuring skill documentation
- Building skills using this template

**Core methodology:**
- **Prime Directive**: Commit discussions to ADRs immediately
- **Secondary Directive**: Surface doubts (they're generative)
- ADR-based decision tracking with navigation codes
- Iteration history and agency grants
- LLM-geared documentation patterns

---

## I. The Two Directives

### Prime Directive: COMMIT DISCUSSIONS TO ADRs IMMEDIATELY

**Never let decisions stay only in conversation. Our thinking is valuable - preserve it.**

**Why this matters:**
- Conversations disappear when context clears
- Future Claude instances don't see our reasoning
- Decisions become "tribal knowledge"
- Can't grep for "why did we decide X?"

**When to create an ADR:**
- Making architectural decisions (packaging, versioning, structure)
- Resolving design questions (where to put files, how to organize)
- Discovering non-obvious patterns (see ADR-0003 LICENSE placement example)
- Choosing between alternatives with trade-offs

**When NOT to create an ADR:**
- Simple questions answered immediately (no decision to preserve)
- Trivial implementation details (file name formatting)
- Temporary debugging steps

**→ See resources/examples/adr-workflow-example.md for complete flow**

---

### Secondary Directive: SURFACE DOUBTS (THEY'RE GENERATIVE)

**The human considers your doubts to be generative. Meaningful points of friction or underspecification or unsuspected diversity are the cornerstone of human-LLM conversations.**

**What to surface:**
- Alternative approaches you're considering
- Edge cases or complications you notice
- Assumptions you're making that might be wrong
- Trade-offs between options
- Questions about scope or intent

**How to surface doubts:**
```markdown
**Generative doubt I'm surfacing:** 
Should we [option A] or [option B]? 

My instinct is [A] because [reasoning], but [B] would be better if [condition].
```

**Example from ADR-0009:**
> **Generative doubt:** Should we do git history filtering now or later?
> 
> Arguments for now: Clean foundation, better commit messages
> Arguments for later: Might discover more files to remove, safer
>
> What's your preference?

**Why this works:**
- Exposes your reasoning process
- Surfaces assumptions for validation
- Creates decision points rather than hidden choices
- Treats uncertainty as valuable input, not weakness

---

## II. ADR Workflow

### The Core Pattern

**When you receive a brain dump or complex question:**

1. **Read** the input (use Bash for large files if needed)
2. **Identify threads** - separate topics/decisions (usually 2-5)
3. **Create ADRs** - one per thread using `docs/adr/templates/collab-adr-lean.md`
4. **Seed each** with relevant excerpt from the dump
5. **Add navigation codes** (QST:, ANS:, COD:, etc.)
6. **Ask clarifying questions** with context

**When you receive answers:**

1. **Process** the answers
2. **Fill decision section** with what was decided
3. **Note action items** for implementation
4. **Increment iteration number** in the ADR

**Worked example (inline):**

```markdown
# ADR-0042: Widget Loading Strategy

## Context
User wants widgets to load faster but maintain data consistency.

## Questions

### QST: Load widgets lazily or eagerly?
- Status: unanswered
- Why asking: Affects initial page load time vs. interaction latency
- Need: Performance priorities

**ANS:** (by User)
Lazy load. Initial page speed is critical for SEO.

### QST: Cache duration for widget data?
- Status: unanswered  
- Why asking: Balance freshness vs. server load
- Need: Data staleness tolerance

**ANS:** (by User)
5 minutes is fine. Data doesn't change that often.

## Decision

### Chosen: Lazy loading with 5-minute cache

**Why**: SEO requires fast initial load. 5min staleness acceptable per user.

**Trade-offs accepted**: First widget interaction will have ~200ms delay.

## Iterations

### Iteration 1 (2026-04-04)
- AI: Created ADR with two questions about loading and caching
- Human: Answered both, prioritized SEO
- Outcome: Clear decision with specific cache duration
```

**→ See resources/examples/adr-complete-lifecycle.md for multi-iteration example**

---

## III. Navigation Codes

### The System

Navigation codes make ADRs greppable and structured:

```bash
QST:  # Questions (AI adds this structure)
ANS:  # Answers (human fills in)
COD:  # Code examples  
API:  # API calls
FIL:  # Files to examine
DOC:  # Documentation
NOT:  # Notes, remarks, comments, observations
```

### How to Use Them

**In QST sections:**
```markdown
### QST: Should we use TypeScript or JavaScript?
- Status: unanswered
- Why asking: Affects development speed vs. type safety
- Need: Team preferences and constraints

**ANS:** (by Jérémie)
[Human fills this in]
```

**In COD sections:**
```markdown
### COD: Proposed API structure
\`\`\`typescript
interface WidgetConfig {
  loadStrategy: 'lazy' | 'eager';
  cacheDuration: number; // milliseconds
}
\`\`\`
```

**In NOT sections:**
```markdown
### NOT: 2026-04-04
The lazy loading decision mirrors the pattern we used in ADR-0023 
for image loading. Consistency across resource types matters.
```

### Finding Things

```bash
# All questions across all ADRs
grep '^### QST:' docs/adr/*.md

# Unanswered questions only
grep 'Status: unanswered' docs/adr/*.md

# All code examples
grep '^### COD:' docs/adr/*.md

# Notes from specific date
grep '^### NOT: 2026-04' docs/adr/*.md
```

**→ See resources/navigation-code-reference.md for complete catalog**

---

## IV. Templates

### Three Template Types

**1. Brain dump seed** (`docs/adr/templates/seed-template.md`)
- Use for: Quick capture of ideas or decisions
- Structure: Minimal, just enough to preserve thought
- Later: Can evolve into full ADR if needed

**2. Collaborative ADR** (`docs/adr/templates/collab-adr-lean.md`)
- Use for: Complex decisions requiring iteration
- Structure: Context → Questions → Decision → Iterations
- Includes: Navigation codes, agency grants, QST/ANS pattern

**3. Simple MADR** (`docs/adr/templates/template.md`)
- Use for: Straightforward decisions with clear alternatives
- Structure: Status → Context → Options → Consequences
- Standard: Markdown Any Decision Record format

### When to Use Which

| Scenario | Template | Why |
|---|---|---|
| Quick question | Start in conversation | Escalate to ADR if decision emerges |
| Complex decision with unknowns | collab-adr-lean.md | Full workflow with iterations |
| Multiple threads in one dump | collab-adr-lean.md | Create separate ADRs, link them |
| Clear alternatives, need to choose | template.md | Standard MADR format |
| Preserving reasoning for future | collab-adr-lean.md | Iteration history valuable |

---

## V. Collaboration Patterns

### Agency Grants

**What they are:** Explicit permission for Claude to make decisions autonomously

**Example:**
```markdown
**Agency Grant**: Implement as you see fit, I trust your judgment on the details.
```

**Levels of agency:**
- **Explore**: Research options, present findings
- **Propose**: Recommend approach with reasoning
- **Implement**: Execute with freedom on details
- **Just structure**: Organize my thoughts, don't add content

### Iteration Tracking

**Why it matters:** Shows evolution of thinking, preserves reasoning process

**Format:**
```markdown
## Iterations

### Iteration 1 (2026-04-04)
- Human: Provided initial requirements and constraints
- AI: Identified three design questions, created QST sections
- Outcome: Clear questions ready for answering

### Iteration 2 (2026-04-05)
- Human: Answered questions, added constraint about mobile
- AI: Updated decision section, noted mobile implications
- Outcome: Decision finalized with mobile considerations
```

### Ephemeral Scripts

**Pattern:** Temporary diagnostic or investigative scripts

**Location:** `scripts/ephemeral/`

**Naming:** `YYYY-MM-DD-purpose.ext` (e.g., `2026-04-04-test-widget-loading.js`)

**Why:**
- Preserves investigative tools
- Timestamps show when/why created
- Can reference in ADRs or commit messages
- Use `Read()` and `Write()` tools, not bash heredocs (permission model)

**After use:** Append comments showing outcome and decision made

---

## VI. LLM-Geared Documentation

### The Insight (Claude Sonnet 4.5, 2026-03-29)

> "When documentation is optimized for human browsing (lots of navigation, glossaries, getting-started guides), it's actually harder for me to extract the operational knowledge I need. But when it's structured as instructions or decision trees, I can absorb it instantly."

### What This Means

**For Claude:**
- Instructions > explanations
- Decision trees > narrative descriptions
- Structured formats > prose
- Explicit patterns > implicit conventions

**For humans:**
- The collaboration improves when documentation serves both audiences
- Can have human-focused README + LLM-focused CLAUDE.md
- ADRs serve both (decisions are naturally structured)

### Principles

1. **Lead with directives** (Prime, Secondary, not background)
2. **Use decision trees** (if X then Y, not "it depends")
3. **Provide templates** (copy/modify, not invent from scratch)
4. **Make greppable** (navigation codes, not just search)
5. **Structure > narrative** (tables, lists, code blocks)

**Example - Human-geared:**
> "When working with ADRs, you'll want to think about whether the decision is complex enough to warrant a full collaborative template or if a simple MADR would suffice. Consider the trade-offs..."

**Example - LLM-geared:**
> Decision tree:
> - Multiple unknowns → collab-adr-lean.md
> - Clear alternatives → template.md  
> - Quick capture → seed-template.md
> - Trivial detail → conversation only

---

## VII. Skills as Superprompts

### The Philosophy (Jérémie Lumbroso, 2026-03-29)

**Skills are "superprompts"** that correct specification errors when most humans (as low-fidelity entities) don't explain fully with context.

**The problem:**
- Humans often underspecify (assume shared context)
- LLMs hallucinate to fill gaps
- Iteration is needed to reach high-fidelity specs

**The solution:**
- Skills encode iterated, refined specifications
- Standardize and "prechew" work for LLMs
- Let LLMs focus on higher-order goals, not scaffolding

**For template users:**
- You're creating a superprompt for skill-building
- Each ADR raises specification fidelity
- Templates reduce cognitive load for future builders

---

## VIII. Git Commit Patterns

### Format

`type: subject` (lowercase)

**Types:**
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation (includes ADRs)
- `refactor`: Code restructuring
- `test`: Test additions/changes
- `chore`: Maintenance tasks
- `style`: Formatting changes
- `perf`: Performance improvements
- `meta`: CLAUDE.md, settings, repo meta-config

**Examples:**
```bash
feat: implement JWT authentication per ADR-0014
docs: create ADR-0023 for widget loading strategy
refactor: extract widget cache to separate module
meta: update CLAUDE.md with new directive
```

### Commit Granularity

**Important:** Make commits granular and ongoing

- Commit ADR drafts before asking for feedback
- Commit answers separately from draft
- Commit implementation separately from decision
- **Why:** Shows iteration, preserves audit trail

---

## Decision Framework

### Questions to Ask Yourself

**Before creating an ADR:**
1. Will future Claude instances need to know why we decided this?
2. Are there multiple viable approaches with trade-offs?
3. Is this surprising or non-obvious?
4. Will this decision inform other decisions?

**During ADR creation:**
1. Have I structured questions to be greppable?
2. Have I explained why I'm asking (not just what)?
3. Have I provided enough context to decide?
4. Have I noted what decision format I need (yes/no, code example, etc.)?

**After receiving answers:**
1. Did I update the decision section clearly?
2. Did I increment iteration number?
3. Did I commit before proceeding to implementation?
4. Did I mark appropriate action items?

---

## When to Escalate

### To Full ADR Template Documentation

**If you need:**
- Complete template field reference
- Advanced agency grant patterns
- Multi-stakeholder decision workflows
- Historical context on template evolution

**→ See:** `docs/adr/templates/` directory for full templates with inline documentation

### To METHODOLOGY.md

**If you need:**
- Philosophical foundations
- Why this collaboration style works
- Cognitive science background
- Comparison to other methodologies

**→ See:** `docs/METHODOLOGY.md` (if exists in template repo)

---

## Meta-Note: This Skill's Structure

This skill follows Architecture of Complexity principles:

- **Hierarchical:** Sections → Subsections → Examples
- **Nearly decomposable:** Each section readable independently
- **Stable intermediate forms:** One worked example inline, more in resources/
- **Process description:** HOW to collaborate, not just WHAT the template is
- **Progressive disclosure:** Core methodology here, deep examples in resources/

**Size:** ~450 lines (under 500-line recommendation)
**Coverage:** ~90% of daily collaboration patterns
**Purpose:** Always-available methodology reference with clear escalation to examples

---

## Resources

**Examples:**
- `resources/examples/adr-workflow-example.md` - Simple ADR from start to finish
- `resources/examples/adr-complete-lifecycle.md` - Multi-iteration complex decision
- `resources/examples/agency-grant-patterns.md` - Different levels of Claude autonomy

**References:**
- `resources/navigation-code-reference.md` - Complete catalog with usage patterns
- `resources/commit-message-guide.md` - Detailed commit format examples

---

*This skill is a living document. It evolves as the collaboration methodology evolves.*

**Originated by:** Claude Sonnet 4.5 (ADR-0007/0010)
**Authors:** Claude Sonnet 4.5 and Jérémie Lumbroso
**License:** CC BY-SA 4.0
**Created:** April 2026