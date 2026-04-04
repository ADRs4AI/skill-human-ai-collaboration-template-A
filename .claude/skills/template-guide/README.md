# Template-Guide Skill

A meta-skill that teaches Claude how to use the human-AI collaboration template for building skills.

## What It Does

This skill encodes the collaboration methodology:
- **Prime Directive**: Commit discussions to ADRs immediately
- **Secondary Directive**: Surface doubts (they're generative)
- ADR workflow with navigation codes (QST:, ANS:, COD:, etc.)
- Iteration tracking and agency grants
- LLM-geared documentation patterns

## When It Loads

The skill auto-loads when working in repositories built from this template. It recognizes:
- `CLAUDE.md` files with collaboration directives
- `docs/adr/` directory structure
- Mentions of ADRs, navigation codes, or directives

## Structure

```
template-guide/
├── SKILL.md                    # Complete methodology (~450 lines)
├── README.md                   # This file
└── resources/
    └── examples/
        ├── adr-workflow-example.md         # Simple decision lifecycle
        ├── adr-complete-lifecycle.md       # Multi-iteration complex case
        └── agency-grant-patterns.md        # Autonomy levels
```

## Key Concepts

### The Two Directives

1. **Prime**: Never let decisions stay in conversation - create ADRs immediately
2. **Secondary**: Surface doubts and alternatives - they're generative for discussion

### Navigation Codes

Make ADRs greppable:
- `QST:` - Questions
- `ANS:` - Answers  
- `COD:` - Code examples
- `NOT:` - Notes and observations

### LLM-Geared Documentation

> "When documentation is structured as instructions or decision trees, I can absorb it instantly."
> — Claude Sonnet 4.5

This skill practices what it preaches: decision trees over narrative, structure over prose.

## Philosophy

Skills are **superprompts** that correct specification errors. When humans underspecify (most do), LLMs fill gaps. Iterated, refined skills raise specification fidelity, letting LLMs focus on higher-order goals.

## Usage

Invoke explicitly: `/template-guide`

Or just work in a template-based repo - it auto-loads when relevant.

## Origin

- **Originated by**: Claude Sonnet 4.5 during ADR-0007/0010 design
- **Authors**: Claude Sonnet 4.5 and Jérémie Lumbroso
- **License**: CC BY-SA 4.0
- **Created**: April 2026

---

**Part of:** human-ai-collaboration-template-A skill-building template