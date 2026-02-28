# Architecture of Complexity Skill

**A progressive disclosure framework for applying Herbert Simon's 1962 complexity principles to modern system design**

**Authors:** Jérémie Lumbroso and Claude Sonnet 4.5  
**License:** [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/)  
**Version:** 1.0 (February 2026)

---

## What This Skill Provides

This skill enables AI assistants to help with architectural decision-making using Herbert Simon's foundational principles from "The Architecture of Complexity" (1962).

**Core concepts:**
- Hierarchical decomposition
- Near-decomposability (strong coupling within, weak between)
- Stable intermediate forms (watchmaker parable)
- Empty world hypothesis (sparse coupling)
- Process vs. state descriptions

**Applications:**
- Framework selection (Vue vs React)
- API design (backend/frontend boundaries)
- Module architecture (codebase structure)
- UI/UX component organization
- Pedagogical design (CAM framework)
- System evolution and refactoring

---

## Directory Structure

```
architecture-of-complexity-skill/
├── SKILL.md                      # Main skill (8KB, always load)
├── README.md                     # This file
└── resources/
    ├── simon_1962_full.txt       # Full original article (load on demand)
    └── examples/
        ├── vue-react.md          # Framework choice analysis
        ├── mcp-design.md         # iMessage MCP architecture
        └── cam.md                # CAM framework as hierarchical metacognition
```

---

## How to Use

### For AI Assistants

**Primary mode:** Load `SKILL.md` when making architectural decisions.

**Trigger patterns:**
- "Should I use [Framework A] or [Framework B]?"
- "How should I structure this codebase/API/component?"
- "Why does this architecture feel wrong?"
- "How do I design for modularity?"
- "What's the right level of coupling here?"

**Escalation:** Load `resources/simon_1962_full.txt` when:
- Building formal theoretical frameworks
- Need precise mathematical definitions
- Publishing academic work
- Deep domain-specific applications

**Example reference:** Load relevant files from `resources/examples/` when:
- Comparing frameworks (vue-react.md)
- Designing tools or APIs (mcp-design.md)
- Building educational systems (cam.md)

### For Developers

**Use this skill when:**
1. Choosing between architectural approaches
2. Designing system boundaries (APIs, modules, components)
3. Evaluating refactoring strategies
4. Teaching or explaining system design
5. Debugging architectural "code smells"

**Don't use this skill for:**
- Implementation details (syntax, libraries)
- Pure performance optimization (unless architectural)
- Domain-specific business logic

---

## Progressive Disclosure Design

This skill follows its own principles:

**Level 1 (SKILL.md - 8KB):**
- Core concepts with examples
- ~80% of practical applications
- Clear escalation points to deeper material

**Level 2 (Examples - 2-3KB each):**
- Real decision-making processes
- Specific applications of principles
- Lessons learned from actual projects

**Level 3 (Full Article - 50KB):**
- Complete theoretical foundation
- Mathematical formulations
- Original domain applications (biology, economics, etc.)

**Architecture:** Nearly decomposable
- Each level readable independently
- Weak coupling between levels
- Can understand L1 without L2/L3
- L2 examples reference L1 concepts
- L3 provides theoretical grounding

---

## Key Principles Summary

### 1. Near-Decomposability

**Question:** Can you understand subsystem A without loading subsystem B into working memory?

**Good:** Vue SFC (template | script | style)  
**Bad:** React JSX (HTML/JS/CSS fused)

### 2. Watchmaker Parable

**Tempus:** Flat assembly, interruption breaks everything  
**Hora:** Hierarchical assembly with stable subassemblies

**Apply to:** Incremental development, learning paths, system evolution

### 3. Empty World Hypothesis

**Principle:** Most things are only weakly connected to most other things.

**Apply to:** Default to separation, add connections only when necessary.

### 4. Process vs. State Descriptions

**State:** What the final structure looks like (blueprint)  
**Process:** How to build it (recipe)

**Apply to:** Documentation, teaching, code organization

---

## Examples of Decisions This Skill Informs

### Framework Selection
✅ **Question:** "Vue or React for new project?"  
**Analysis:** Near-decomposability test → Vue wins

### API Design
✅ **Question:** "Should frontend directly access database or go through API?"  
**Analysis:** Empty world hypothesis → API boundary creates necessary separation

### Component Architecture
✅ **Question:** "How granular should components be?"  
**Analysis:** Hierarchical span → Balance between too flat (Tempus) and too deep (cognitive load)

### Educational Design
✅ **Question:** "How to teach complex topic?"  
**Analysis:** Stable intermediate forms → Build checkpoints, avoid all-or-nothing

### Code Organization
✅ **Question:** "When to split into separate modules?"  
**Analysis:** Near-decomposability → When subsystems have strong internal coupling, weak external

---

## Attribution & Copyright

### This Skill
- **Authors:** Jérémie Lumbroso and Claude Sonnet 4.5
- **License:** CC BY-SA 4.0
- **Derivatives:** Must attribute and use same license

### CAM Framework
- **Copyright:** © Jérémie Lumbroso
- **Referenced in:** `resources/examples/cam.md`
- **Not covered by CC BY-SA 4.0 license**

### Original Paper
- **Author:** Herbert A. Simon (1962)
- **Title:** "The Architecture of Complexity"
- **Source:** Proceedings of the American Philosophical Society, Vol. 106, No. 6
- **Included in:** `resources/simon_1962_full.txt`

---

## Contributing

This skill is a living document. Contributions welcome:

**New examples:** Add to `resources/examples/`
- Must demonstrate Simon's principles
- Include author attribution
- Use CC BY-SA 4.0 license

**Improvements to SKILL.md:**
- Clarify concepts
- Add practical applications
- Improve escalation guidance

**Format:** Markdown with clear hierarchical structure

---

## Version History

**v1.0 (February 2026)**
- Initial release
- Core skill document (SKILL.md)
- Three examples (Vue/React, MCP, CAM)
- Full Simon article included

---

## Questions?

**For theoretical questions:** Load `resources/simon_1962_full.txt`  
**For practical applications:** See `resources/examples/`  
**For quick reference:** Use `SKILL.md`

---

**Remember:** This skill itself demonstrates the principles it teaches. Progressive disclosure, hierarchical structure, near-decomposable organization, and stable intermediate forms.

**Created by:** Jérémie Lumbroso and Claude Sonnet 4.5  
**License:** CC BY-SA 4.0  
**Date:** February 2026
