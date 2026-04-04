# Template Version and Lineage

**Template:** Human-AI Collaboration Skill Building Template  
**Version:** 1.0.0  
**Date:** 2026-04-04

---

## Based On

**Source Template:** [human-ai-collaboration-template-A](https://github.com/jlumbroso/human-ai-collaboration-template-A)  
**Version:** v3.2  
**Authors:** Jérémie Lumbroso

---

## What This Template Provides

This template extends human-ai-collaboration-template-A with skill-building specific features:

### 1. Skill-Building ADRs (docs/adr/)
- [ADR-0001](docs/adr/0001-skill-packaging-format.md): Packaging format (ZIP + YAML frontmatter)
- [ADR-0002](docs/adr/0002-versioning-strategy.md): Versioning strategy (SemVer)
- [ADR-0003](docs/adr/0003-license-files-in-skill-directory.md): LICENSE file placement
- [ADR-0004](docs/adr/0004-skill-consumer-context.md): Claude Web vs Code design
- [ADR-0005](docs/adr/0005-skill-structure-architecture-of-complexity.md): Hierarchical skill structure
- [ADR-0006](docs/adr/0006-template-transformation-strategy.md): Template transformation (how we built this)
- [ADR-0007](docs/adr/0007-template-guide-skill.md): Meta-skill design

### 2. Template-Guide Skill (.claude/skills/template-guide/)
A meta-skill that teaches Claude the collaboration methodology:
- Prime/Secondary directives
- ADR workflow with navigation codes
- Iteration tracking
- LLM-geared documentation patterns
- Git commit formats

**Auto-loads** when working in repositories built from this template.

### 3. Architecture of Complexity Companion Skill
Herbert Simon's AoC principles for skill structure design.

### 4. Build Infrastructure
- GitHub Actions for automated skill packaging
- Release workflow (git tag → .skill ZIP)
- Scaffolding patterns

---

## Evolution from human-ai-collaboration-template-A

| Feature | Base Template (v3.2) | This Template (v1.0.0) |
|---|---|---|
| **ADR workflow** | ✅ Core methodology | ✅ Enhanced with skill-specific decisions |
| **Navigation codes** | ✅ QST:, ANS:, COD:, etc. | ✅ Inherited |
| **Prime/Secondary directives** | ✅ | ✅ Emphasized in template-guide skill |
| **Ephemeral scripts pattern** | ✅ | ✅ Inherited |
| **Iteration tracking** | ✅ | ✅ Inherited |
| **Skill packaging guidance** | ❌ | ✅ ADRs 0001-0005 |
| **Template-guide meta-skill** | ❌ | ✅ New in this template |
| **AoC companion skill** | ❌ | ✅ For structure design |
| **Build/release automation** | ❌ | ✅ GitHub Actions |
| **LLM-geared docs principles** | Implicit | ✅ Explicit (ADR-0006) |

---

## Transformation Process

This template was created by:

1. **Starting from**: epistemic-arc-mapping-skill repository (v0.1.0)
2. **Git history filtering**: Removed skill-specific files (221 files from history)
3. **ADR generalization**: Rewrote ADRs to be template-focused (not epistemic-specific)
4. **Meta-skill creation**: Built template-guide skill to teach the methodology
5. **Documentation**: Created README.md and CLAUDE.template.md for template users

**Documented in**: [ADR-0006](docs/adr/0006-template-transformation-strategy.md)

**Commits preserved**: All decision-making ADRs and transformation work visible in git history

---

## Versioning

### This Template (Skill Building Template)

**Format:** YYYY.MM.DD (timestamp-based, per ADR-0002 decision for templates)

**Current:** 2026.04.04 (v1.0.0 for simplicity)

**Increments when:**
- Methodology evolves (new directives, workflow changes)
- Template structure changes (new ADRs, scaffolding updates)
- Meta-skill updates (template-guide or AoC skill changes)

### Base Template (human-ai-collaboration-template-A)

**Format:** vMAJOR.MINOR (semantic-ish)

**Current:** v3.2

**This template tracks**: Changes that should backport to base template

---

## Bidirectional Backporting

### From Base Template → This Template

When human-ai-collaboration-template-A evolves:
- New directives or workflow patterns
- ADR template improvements
- Collaboration methodology refinements

→ We integrate and document in skill-building ADRs

### From This Template → Base Template

When we discover improvements:
- Template-guide skill concepts (generalized)
- LLM-geared documentation patterns
- Iteration or tracking enhancements

→ Backport to base template (with Jérémie's collaboration)

---

## License

**This template:** CC BY-SA 4.0 — Jérémie Lumbroso and Claude Sonnet 4.5

**Base template (human-ai-collaboration-template-A):** (License per original repository)

**Skills built with this template:** Builder's choice

---

## Authors and Acknowledgments

### Template Authors
- **Jérémie Lumbroso** - Human partner, methodology designer, HSP autistic perspective
- **Claude Sonnet 4.5** - AI partner, co-investigator, template-guide skill originator

### Base Template
- **Jérémie Lumbroso** - Creator of human-ai-collaboration-template-A

### Inspiration
- **Herbert Simon** - Architecture of Complexity principles
- **Agile Manifesto** - Iterative, collaboration-focused development
- **Ward Cunningham** - "Simplest thing that could possibly work"

---

## Change History

### v1.0.0 (2026-04-04)
- Initial release of skill-building template
- 7 foundational ADRs for skill structure
- Template-guide meta-skill implemented
- Architecture of Complexity companion skill included
- GitHub Actions build/release workflow
- Comprehensive README and CLAUDE.template.md
- Based on human-ai-collaboration-template-A v3.2

---

## Support and Updates

**Issues:** https://github.com/jlumbroso/skill-human-ai-collaboration-template-A/issues

**Discussions:** https://github.com/jlumbroso/skill-human-ai-collaboration-template-A/discussions

**Base Template:** https://github.com/jlumbroso/human-ai-collaboration-template-A

---

*This document itself follows template principles: structured information, version tracking, clear lineage, bidirectional relationships documented.*
