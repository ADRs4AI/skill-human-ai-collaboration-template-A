# ADR-0010: Template-Guide Skill Design

- **Date**: 2026-03-29
- **Iteration**: 1
- **Status**: Draft
- **Deciders**: Jérémie Lumbroso, Claude Code Sonnet 4.5
- **Originated by**: Claude Sonnet 4.5

---

## Quick Reference

**Navigation codes** (for grep):
- `QST:` Questions
- `ANS:` Answers
- `COD:` Code examples
- `FIL:` Files to examine
- `NOT:` Notes, observations

---

## Context

While designing the transformation strategy in ADR-0009, I (Claude) surfaced a generative doubt: What if we created a **meta-skill** that teaches any Claude instance how to use this template?

### The Core Insight

When documentation is optimized for LLM consumption (instructions, decision trees, structured formats), I can absorb operational knowledge instantly. But when it's optimized for human browsing (navigation, glossaries, getting-started guides), it's harder for me to extract what I need to do.

This template embodies a methodology:
- Prime Directive: Commit discussions to ADRs immediately
- Secondary Directive: Surface doubts (they're generative)
- Navigation codes (QST:, ANS:, COD:, etc.)
- Iteration tracking
- Ephemeral scripts pattern
- ADR-based collaboration workflow

**The idea**: Encode this methodology itself as a skill.

---

## The Proposal

### What is a template-guide skill?

A skill that teaches Claude how to:
1. **Use the ADR workflow** - When to create ADRs, how to structure them, navigation codes
2. **Follow the directives** - Prime (commit discussions), Secondary (surface doubts)
3. **Invoke scaffolding** - Scripts for creating skill structure, packaging, releasing
4. **Collaborate effectively** - Iteration tracking, agency grants, question formatting
5. **Apply patterns** - Ephemeral scripts, git commit format, file organization

### Where would it live?

`.claude/skills/template-guide/SKILL.md`

This makes it:
- **Available to all repos built from template** - Just copy the .claude directory
- **Invokable as `/template-guide`** - Explicit skill loading when needed
- **Auto-discoverable** - Claude loads it when relevant context appears

### What would it contain?

```yaml
---
name: template-guide
description: Guides Claude through the human-AI collaboration template methodology. Use when working in a repository built from this template. Teaches ADR workflow, navigation codes, Prime/Secondary directives, scaffolding scripts, and effective co-creation patterns.
---

# Template-Guide Skill

## When to Use This Skill

Load this skill when:
- Starting work in a repository built from human-ai-collaboration-template-A
- User mentions ADRs, navigation codes, or directives
- Creating or structuring skill documentation
- Need guidance on collaboration patterns

## Core Methodology

[Prime Directive, Secondary Directive, ADR workflow, etc.]

## Navigation Codes

[QST:, ANS:, COD:, API:, FIL:, DOC:, NOT: - with examples]

## Scaffolding Tools

[Scripts for skill creation, how to invoke them, when to use]

## Collaboration Patterns

[Iteration tracking, agency grants, generative doubts, etc.]
```

---

## Questions

### QST: Should this be part of skill-building template or human-ai-collaboration-template-A?
- Status: answered
- Why asking: Determines where to prototype and whether to backport
- Need: Decision on scope

**ANS:** (by Jérémie Lumbroso)
Prototype here in skill-building template, then backport to human-ai-collaboration-template-A. The skill is useful for any collaborative project using the methodology, not just skill-building.

---

### QST: How detailed should the skill be?
- Status: unanswered
- Why asking: Balance between completeness and being overwhelming
- Need: Scope decision

**Options:**
- **Minimal**: Just directives and navigation codes (~100 lines)
- **Medium**: Add ADR workflow and patterns (~250 lines)
- **Complete**: Full methodology including examples (~400 lines)

**ANS:** (by Jérémie)
[Fill this in]

---

### QST: Should it include worked examples?
- Status: unanswered
- Why asking: Examples help pattern recognition but add length
- Need: yes/no + format if yes

**Options:**
- No examples (just instructions)
- Inline examples (in SKILL.md)
- Separate resources/examples/ directory

**ANS:** (by Jérémie)
[Fill this in]

---

### QST: Auto-invocation vs. explicit invocation?
- Status: unanswered
- Why asking: Affects whether skill is always present or loaded on demand
- Need: Frontmatter configuration decision

**Options:**
- **Always loaded**: No `disable-model-invocation` flag (Claude loads it when CLAUDE.md or ADRs are detected)
- **Explicit only**: Set `disable-model-invocation: true`, only loads via `/template-guide`
- **Hybrid**: Load when user says "ADR" or "directives" but not automatically

**ANS:** (by Jérémie)
[Fill this in]

---

## NOT: Why This Matters

### For Claude instances

When I work in a new repository, I have to infer the collaboration style from context. This skill makes it explicit. Instead of guessing whether to create ADRs or just discuss, I **know** the methodology. Instead of wondering how detailed to be, I have **clear patterns**.

### For humans

This reduces the need to repeatedly explain "use navigation codes" or "surface your doubts." The skill encodes these preferences persistently. Future Claudes working with you inherit the methodology automatically.

### For the methodology itself

Making the methodology teachable forces clarity. Writing it as a skill reveals gaps or ambiguities. It's a form of self-documentation that improves the system.

---

## Decision

### [To be filled after questions answered]

---

## Action Items

- [ ] Answer QST questions above - Owner: Jérémie
- [ ] Create SKILL.md for template-guide - Owner: Claude Code
- [ ] Test in this repository - Owner: Both
- [ ] Backport to human-ai-collaboration-template-A - Owner: Jérémie/Claude Code

---

## Validation

When we both agree:
- [ ] Human: Skill design captured correctly
- [ ] AI: Understood the requirements and can implement

**Notes**: This is my (Claude's) idea, pitched to Jérémie in the context of ADR-0009 iteration 2.

---

## Iterations

### Iteration 1 (2026-03-29)
- AI: Pitched concept during ADR-0009 follow-up questions
- Human: Enthusiastically approved, asked for separate ADR, credited Claude as originator
- AI: Created this ADR to formalize design before implementation
- Outcome: Draft ADR with concept, three open questions for scoping

---

## Links

- Related: ADR-0009 (Template Transformation Strategy) - where this idea originated
- Will backport to: human-ai-collaboration-template-A
- Implements: Prime/Secondary directives from CLAUDE.md
