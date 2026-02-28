# Architecture of Complexity Skill

**Authors:** Jérémie Lumbroso and Claude Sonnet 4.5  
**License:** [Creative Commons Attribution-ShareAlike 4.0 International](https://creativecommons.org/licenses/by-sa/4.0/)  
**Based on:** Herbert A. Simon, "The Architecture of Complexity" (1962)  
**Version:** 1.0 (February 2026)

**Note:** The CAM (Computationally-Assisted Metacognition) framework referenced herein is Copyright © Jérémie Lumbroso. This skill document itself is licensed under CC BY-SA 4.0.

---

## When to Use This Skill

**Trigger this skill when:**
- Making architectural decisions (choosing frameworks, designing systems)
- Analyzing modularity and coupling in codebases
- Evaluating UI/UX component structure
- Designing APIs or system boundaries
- Teaching or explaining complexity and system design
- Debugging why a system feels "wrong" architecturally
- Planning how to evolve or refactor complex systems

**Key concepts this skill provides:**
- Hierarchical decomposition principles
- Near-decomposability (strong coupling within, weak coupling between)
- Stable intermediate forms (the "watchmaker parable")
- Empty world hypothesis (sparse coupling by default)
- Process vs. state descriptions
- When to escalate to full theoretical treatment

---

## Core Principles Summary

### I. Complexity as Hierarchy

Complex systems in nature (physical, biological, social, computational) are **almost always hierarchical**: systems composed of subsystems, which contain smaller subsystems, continuing down to some elementary level.

**"Hierarchical" means:**
- NOT just authority structures
- BUT any system where the whole is built from interrelated subsystems
- Each subsystem can be understood partly independently
- There are clear levels of organization

**Examples:**
- **Codebases:** Modules → Classes → Functions → Statements
- **UI Design:** Application → Pages → Components → Elements  
- **Vue SFC:** Component → Template/Script/Style → Elements
- **MCP Servers:** Server → Tools → Functions → API calls

**Good architecture means:**
1. You can understand parts without loading the whole into working memory
2. Changes to one part don't cascade unpredictably
3. You can test components independently
4. Learning happens one layer at a time

**→ Escalate to full article for:** Mathematical formulation of hierarchy, theoretical proofs about evolution, formal definitions.

---

### II. The Watchmaker Parable: Why Hierarchies Evolve Faster

Simon's famous thought experiment comparing two watchmakers:

**Tempus (flat assembly):**
- Assembles all 1000 parts directly
- Interruption means starting completely over
- Almost never finishes a watch

**Hora (hierarchical assembly):**  
- Creates stable subassemblies of ~10 parts
- Combines subassemblies into modules
- Interruption loses only current subassembly
- Completes watches ~4,000x faster

**The insight:** With interruptions every 1/100 steps:
- Flat assembly: probability of completion ≈ 0
- Hierarchical: probability of completion ≈ 1/1,000,000 (manageable)

**Applications:**

**Pedagogical scaffolding:**
- Students need "stable intermediate forms"
- Can't jump from basics to complex without milestones
- CAM provides metacognitive checkpoints

**Codebase evolution:**
- Build features incrementally with working MVPs
- Monolithic rewrites usually fail (Tempus problem)
- Why Vue's SFC structure > React's flat JSX

**Learning complex topics:**
- Can't teach quantum without classical first
- Curriculum "recapitulates" field development
- Good documentation has progressive disclosure

**→ Escalate to full article for:** Precise probability calculations, biological applications (protein folding), formal evolutionary models.

---

### III. Near-Decomposability: The Key Dynamic Property

**Definition:** In a nearly decomposable system:
- **Strong interactions** within subsystems (high internal coupling)
- **Weak interactions** between subsystems (low external coupling)
- Short-term: each subsystem behaves independently
- Long-term: slow weak coupling to other subsystems

**The test:** Can you reason about subsystem A without loading subsystem B into working memory?

**Simon's heat distribution analogy:**
- House with rooms and thick walls
- Heat distributes quickly within each room (strong local)
- Heat transfers slowly between rooms (weak global)
- Two timescales: fast local equilibrium, slow global equilibrium

**Why this matters:**

**For comprehension:**
- Understand one module without understanding all modules
- Documentation can focus on components independently
- Bugs stay localized

**For evolution:**
- Modify one part with limited impact on others
- Refactoring doesn't require changing everything
- Teams work on different components in parallel

**For testing:**
- Unit tests verify components independently
- Integration tests check weak boundaries only
- Failures easier to isolate

**Applications:**

**Vue vs React:**
- Vue SFC: Near-decomposable (template | script | style weakly coupled)
- React JSX: Tightly coupled (HTML/JS/CSS fused)
- Result: Vue aligns better with both HSP cognition and transformer architecture

**iMessage MCP design:**
- Linearized tool responses (weak coupling to display)
- "Model Experience" prioritizes LLM-readable structure
- Each ADR is nearly independent
- Component failure doesn't corrupt system

**Organizational drift:**
- Systems start with near-separable structure
- Cross-boundary dependencies accumulate over time
- System becomes tightly coupled
- Can't adapt without breaking everything
- Example: Apple's evolution from Steve Jobs (clear hierarchy) to Tim Cook era (committee-driven tight coupling across product lines)

**CAM framework:**
- System 3 provides metacognitive separation from System 1/2
- Allows examining thinking without being inside thinking
- Creates weak coupling between automatic and reflective cognition

**→ Escalate to full article for:** Mathematical proof of aggregation, formal coupling analysis, domain-specific models (economics, biology).

---

### IV. Empty World Hypothesis: Why Sparse Coupling Matters

**The claim:** Most things in the universe are only weakly connected to most other things.

**Implications:**
- If everything were tightly connected, no stable subsystems could form
- No hierarchy could emerge
- Evolution would be impossible (Tempus problem)
- Comprehension would require understanding all reality at once

**Architectural principle:** Good architecture exploits sparsity. Default to separation, add connections only when necessary.

**Applications:**

**API design:**
- Backend/Frontend communicate only through official API
- Each evolves independently within contract
- "Fail closed" authorization (security as sparse connection)

**Scoped CSS:**
- Styles isolated to components by default
- Only shared when explicitly needed (CSS variables)
- Avoids "everything affects everything" problem

**Module boundaries:**
- Minimal dependencies between modules
- When everything imports everything, decomposability is lost
- Most modules shouldn't know about most other modules

**→ Escalate to full article for:** Information-theoretic foundations, statistical mechanics implications, biological examples.

---

### V. Process vs. State Descriptions

**State description (blueprint):**
- What the final structure looks like
- Complete enumeration of components and relationships
- Example: Architectural drawings

**Process description (recipe):**
- How to build the structure step by step
- Sequence of operations and transformations
- Example: Construction manual

**Key insight:** For complex systems, process descriptions are often dramatically more compact than state descriptions.

**Why this matters:**

**Genetic code:**
- DNA is a recipe (process) for building proteins
- NOT a blueprint of the organism
- Extremely compressed vs. describing every cell

**Education:**
- Teaching historical development (process) often more effective than just presenting results (state)
- Students reconstruct understanding through similar process
- "Ontogeny recapitulates phylogeny" in learning

**Code:**
- Functions (process) vs. data structures (state)
- Algorithms describe how, not what
- Compression through redundancy exploitation

**Applications:**

**CAM framework:**
- Traditional education = state description (deposit facts)
- Problem-posing pedagogy = process description (develop thinking)  
- AI as System 3 = process scaffolding for metacognition

**Documentation:**
- Tutorial (process): "How to build feature X"
- Reference (state): "Complete API specification"
- Both needed, process often more learnable

**Vue components:**
- Template (state): What UI looks like
- Script (process): How it transforms data
- Lifecycle (process): How it evolves over time

**→ Escalate to full article for:** Information theory connection, genetic mechanisms detail, description complexity formalization.

---

## Decision Framework: Applying Simon to Real Choices

### Questions to Ask

When evaluating a technical decision:

1. **Does this respect natural decomposition boundaries?**
   - Or create arbitrary divisions that resist evolution?

2. **Does this create stable intermediate forms?**
   - Or force all-or-nothing assembly (Tempus problem)?

3. **Is coupling strong where it should be, weak where it should be?**
   - Or does everything affect everything?

4. **Can I understand components independently?**
   - Or must I load entire system into working memory?

5. **Does this exploit sparsity (empty world)?**
   - Or create unnecessary connections?

6. **Is this a state or process description?**
   - Which is more appropriate for this use case?

### Anti-Patterns (Red Flags)

**Tight coupling everywhere:**
- React's JSX mixing HTML/JS/CSS without boundaries
- Supabase's service_role backdoors bypassing authorization
- Global CSS affecting components unpredictably

**Forced hierarchy (not natural joints):**
- Organization charts that don't match information flow
- Module boundaries misaligned with change patterns
- Divisions that ignore structural similarities

**No stable subassemblies:**
- Monolithic rewrites with no incremental milestones
- Features that only work when 100% complete
- Learning paths with no intermediate validation

**State description where process would be better:**
- Dumping complete API docs without usage examples
- Teaching final theorems without derivation
- Presenting conclusions without reasoning path

### Good Architecture Patterns

**Natural near-decomposability:**
- Vue SFC: Template | Script | Style sections
- API boundaries matching team boundaries
- Documentation organized by user mental models

**Stable intermediate forms:**
- Working MVPs at each iteration
- Testable milestones in development
- Educational scaffolding with checkpoints

**Sparse coupling (empty world):**
- Minimal imports between modules
- Explicit, narrow interfaces
- "Fail closed" security patterns

**Right description type:**
- Tutorials for learning (process)
- References for lookup (state)
- Both available when needed

---

## When to Escalate to Full Article

### Situations Requiring Full Paper

**Theoretical development:**
- Building formal models of complex systems
- Proving theorems about hierarchical structure
- Publishing academic work requiring primary sources

**Deep technical detail:**
- Understanding mathematical proofs
- Examining specific domain applications
- Studying information-theoretic foundations

**Historical context:**
- How Simon influenced later systems thinking
- Evolution of complexity theory
- Connection to cybernetics and general systems theory

**Precise definitions:**
- Exact mathematical meaning of "nearly decomposable"
- Formal definition of hierarchic span
- Quantitative aggregation analysis

**Domain-specific applications:**
- Biological examples (protein folding, evolution)
- Economic models (firm organization)
- Physical systems (thermodynamics, statistical mechanics)

### Situations Where This Summary Suffices

**Architectural decision-making:**
- Choosing frameworks (Vue vs React)
- Designing API boundaries
- Structuring codebases or documentation

**Explaining concepts:**
- Teaching modularity to students
- Justifying design choices to teams
- Understanding why patterns work

**Pattern recognition:**
- Identifying tight vs loose coupling
- Recognizing stable vs unstable intermediate forms
- Spotting forced vs natural hierarchies

**Quick reference:**
- Reminding yourself of key principles
- Checking intuition about decomposition
- Refreshing mental models before design

---

## Resources

**Full article:** See `resources/simon_1962_full.txt` for complete paper  
**Examples:** See `resources/examples/` for detailed applications:
- `vue-react.md` - Framework comparison using Simon's principles
- `mcp-design.md` - iMessage MCP architectural decisions
- `cam.md` - CAM framework as metacognitive decomposition

**Related frameworks:**
- Unix philosophy: "Do one thing well" = nearly decomposable modules
- Clean Architecture: Dependency inversion = managing coupling
- Domain-Driven Design: Bounded contexts = subsystem boundaries
- Microservices: Near-decomposability at service level

---

## Meta-Note: This Skill's Structure

This skill itself follows Simon's principles:

- **Hierarchical:** Sections → Subsections → Points → Examples
- **Nearly decomposable:** Each section readable independently
- **Stable intermediate forms:** Core idea → Examples → Applications
- **Process description:** Explains HOW to apply, not just WHAT
- **Progressive disclosure:** Summary first, escalation points to full detail

**Size:** ~8KB (manageable for context window)  
**Coverage:** ~80% of practical applications, ~30% of theoretical depth  
**Purpose:** Lightweight always-available reference with clear escalation to deep theory

---

*This skill is a living document. It can evolve as we discover new applications of Simon's framework in code architecture, pedagogy, and system design.*

**Authors:** Jérémie Lumbroso and Claude Sonnet 4.5  
**License:** CC BY-SA 4.0  
**CAM Framework:** Copyright © Jérémie Lumbroso  
**Created:** February 2026
