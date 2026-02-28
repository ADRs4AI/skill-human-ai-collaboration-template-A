# Architecture of Complexity Skill: Meta-Architecture

**How this skill demonstrates the principles it teaches**

---

## Hierarchical Structure

```
SKILL (Top Level)
│
├── Level 1: Core Concepts (SKILL.md - 8KB)
│   ├── Complexity as Hierarchy
│   ├── Watchmaker Parable
│   ├── Near-Decomposability
│   ├── Empty World Hypothesis
│   ├── Process vs. State
│   └── Decision Framework
│
├── Level 2: Applied Examples (2-3KB each)
│   ├── vue-react.md
│   │   └── Framework choice using Simon's test
│   ├── mcp-design.md
│   │   └── Tool architecture decisions
│   └── cam.md
│       └── Pedagogical framework design
│
└── Level 3: Theoretical Foundation (50KB)
    └── simon_1962_full.txt
        └── Complete original paper
```

**Property:** Each level independently comprehensible (near-decomposable)

---

## Near-Decomposability Analysis

### Strong Coupling (Within Levels)

**Within SKILL.md:**
- Sections build on each other
- Examples reinforce concepts
- Decision framework synthesizes all principles
- High internal coherence

**Within each example:**
- Problem → Analysis → Decision → Lessons
- Tight narrative flow
- Concepts deeply integrated

### Weak Coupling (Between Levels)

**SKILL.md ← → Examples:**
- Can read SKILL.md without examples ✅
- Can read examples with just SKILL.md summary ✅
- Examples *reference* concepts, don't *require* them

**SKILL.md ← → Full Article:**
- Can use SKILL.md without ever reading full article ✅
- Full article provides theoretical grounding (optional)
- Clear escalation points: "→ Need full article when..."

**Examples ← → Full Article:**
- Examples standalone (practical decisions)
- Full article standalone (theoretical foundations)
- No direct dependency

---

## Progressive Disclosure Map

```
USER NEED → LOAD THIS → IF NEED MORE → THEN LOAD

Quick decision        SKILL.md         More depth        Example (2KB)
Framework choice      SKILL.md         Vue specific      vue-react.md
API design           SKILL.md         MCP case          mcp-design.md
Teaching strategy    SKILL.md         CAM details       cam.md
Formal proof         SKILL.md         Theory            simon_1962_full.txt
Academic research    Full article     Applications      SKILL.md + Examples
```

**Optimization:** 80% of use cases satisfied by 8KB file (SKILL.md)

---

## Stable Intermediate Forms

**Development stages (Hora approach):**

1. ✅ **Concept summary** (SKILL.md alone) - WORKS
   - Can make basic architectural decisions
   - Understand core principles
   - Apply decision framework

2. ✅ **+ Real examples** (SKILL.md + examples/) - WORKS BETTER
   - See principles applied to actual decisions
   - Learn from concrete cases
   - Understand nuance and trade-offs

3. ✅ **+ Theoretical foundation** (+ full article) - WORKS BEST
   - Build formal models
   - Understand mathematical proofs
   - Publish academic work

**Each stage is independently valuable.** Not all users need stage 3.

---

## Empty World Application

**Sparse coupling design:**

```
SKILL.md
  ↓ weak reference
Examples (vue-react, mcp-design, cam)
  ↓ weak reference  
Full Article
```

**Not:**
```
SKILL.md ←→ Examples ←→ Full Article
  (tight coupling, must load all)
```

**Why sparse?**
- Most questions don't need full article
- Some questions don't need examples
- Minimal dependencies = lower cognitive load

---

## Process vs. State Descriptions

### SKILL.md as Process Description

**Not:** "Here are all the architectural patterns" (state)  
**But:** "Here's how to analyze architectural decisions" (process)

**Evidence:**
- Decision framework (how to evaluate)
- Anti-patterns and patterns (how to recognize)
- Escalation points (how to know when to dig deeper)

### Examples as Process Description

**vue-react.md:**
- Not just "Vue is better"
- But "Here's the analysis process that led to Vue"
- Shows the reasoning, not just the conclusion

**mcp-design.md:**
- Not just "Design decisions for MCP"
- But "How we applied Simon's principles to make each decision"

**cam.md:**
- Not just "What CAM is"
- But "How CAM implements hierarchical metacognition"

---

## File Size Distribution

```
Total: ~70KB

┌─────────────────────────────────────────┐
│ SKILL.md                    11% (8KB)   │ ← 80% of use cases
├─────────────────────────────────────────┤
│ Examples (3 × 2.5KB)         11% (8KB)  │ ← 15% of use cases
├─────────────────────────────────────────┤
│ Full Article               71% (50KB)   │ ← 5% of use cases
├─────────────────────────────────────────┤
│ README + Installation       7% (5KB)    │ ← Meta-documentation
└─────────────────────────────────────────┘
```

**Pareto principle:** 11% of content (SKILL.md) handles 80% of use cases.

**Design implication:** Default to loading only SKILL.md, escalate as needed.

---

## Coupling Strength Analysis

### Internal Coupling (Strong)

**Within SKILL.md sections:**
```
Hierarchy → Watchmaker → Near-Decomp → Empty World → Process/State
    ↓           ↓             ↓              ↓             ↓
  Examples   Examples      Examples       Examples     Examples
```
Concepts build on each other, examples reinforce.

### External Coupling (Weak)

**Between files:**
```
SKILL.md · · · → vue-react.md
         · · · → mcp-design.md
         · · · → cam.md
         · · · → simon_1962_full.txt
```
Dotted lines = weak coupling, optional references.

---

## Decision Tree for Loading

```
User asks architectural question
    │
    ├─ Basic decision? → Load SKILL.md
    │       │
    │       ├─ Framework choice? → + vue-react.md
    │       ├─ API design? → + mcp-design.md
    │       └─ Teaching? → + cam.md
    │
    ├─ Theoretical question? → Load simon_1962_full.txt
    │       │
    │       └─ Application unclear? → + SKILL.md for bridge
    │
    └─ Meta question? → README.md
```

**Property:** Minimal loading at each decision point (empty world)

---

## Version Evolution (Stable Intermediate Forms)

**v1.0 (Current):**
- ✅ SKILL.md (core concepts)
- ✅ 3 examples (Vue/React, MCP, CAM)
- ✅ Full article included
- ✅ Installation guide

**Possible v1.1:**
- Add example: "Refactoring legacy code using Simon"
- Improve decision framework with flowchart
- Add troubleshooting section

**Possible v2.0:**
- Interactive decision wizard
- More domain examples (databases, networking, etc.)
- Connection to other complexity frameworks

**Each version is independently valuable.** v1.0 → v1.1 → v2.0 are stable intermediate forms.

---

## Meta-Insight: Recursive Application

**This skill is itself a complex system:**
- Hierarchical structure ✅
- Nearly decomposable ✅
- Stable intermediate forms ✅
- Empty world (sparse coupling) ✅
- Process description (how to use) ✅

**Key realization:** Good architecture at content level requires good architecture at meta level.

**Simon would approve.** The tool demonstrates the principles it teaches.

---

## Comparison: What If We Violated These Principles?

### Anti-Pattern Version (Tempus Approach)

**Bad design:**
```
single-file-skill.md (70KB)
  - All concepts
  - All examples
  - Full article
  - No sections
  - No progressive disclosure
```

**Problems:**
- ❌ Must load entire 70KB every time
- ❌ Can't understand parts independently
- ❌ No stable checkpoints
- ❌ Tight coupling throughout
- ❌ Cognitive overload

**Result:** Useful for research papers, terrible for day-to-day architectural decisions.

### Our Design (Hora Approach)

**Good design:**
```
Hierarchical structure with clear levels
Nearly-decomposable sections
Stable intermediate forms (can use just SKILL.md)
Sparse coupling (weak references)
Progressive disclosure (escalate as needed)
```

**Result:** Lightweight, accessible, extensible, comprehensible.

---

## Lessons for Other Skills

**Principles demonstrated here apply to any skill:**

1. **Hierarchy matters** - Don't flatten everything into one file
2. **Near-decomposability enables understanding** - Weak coupling between sections
3. **Stable intermediate forms allow iteration** - Each version is independently valuable
4. **Empty world reduces load** - Sparse references, minimal dependencies
5. **Process > State** - Teach how to think, not what to think

**Meta-architecture = Architecture**

The same principles that make good code, good APIs, good UIs also make good documentation, good skills, good frameworks for thinking.

---

**Created:** February 2026  
**Authors:** Jérémie Lumbroso and Claude Sonnet 4.5  
**License:** CC BY-SA 4.0

**This document itself is nearly-decomposable:**
- Can read any section independently
- Weak coupling between sections
- Hierarchical structure
- Process description of meta-principles

🎯 **Architecture all the way down.**
