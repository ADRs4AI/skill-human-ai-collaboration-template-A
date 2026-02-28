# ADR 0003: Algorithmic Storytelling via Dinner Party Narrative

**Status**: Accepted
**Date**: 2026-01-22
**Iteration**: 1
**Context**: Teaching "what algorithms really are" through relatable narrative

---

## Decision

We use **relatable, everyday scenarios** as narrative vehicles for teaching algorithmic thinking, with the "Dinner Party" story as the canonical example for introducing scheduling problems, constraints, and the critical path concept.

---

## Core Philosophy

### The Problem with Traditional Algorithm Teaching

**Banking model approach**:
1. "Here's the algorithm" (definition)
2. "Here's the proof it works" (theorem)
3. "Here's the complexity analysis" (big-O)
4. "Memorize this for the exam"

**What's missing**: *How do you even think of the algorithm in the first place?*

### Problem-Posing Alternative

**Algorithmic storytelling approach**:
1. Start with familiar, relatable problem
2. Show naive approach failing
3. Moment of insight: "This is actually a [X] problem!"
4. Build solution systematically
5. Generalize to algorithmic principles
6. Connect to real-world applications

---

## The Dinner Party Story: Canonical Example

### Setup (Relatability)

**Scenario**: You're hosting a dinner party tomorrow for 8 people.

**Menu**:
- Roasted chicken (90 min at 375°F)
- Roasted vegetables (45 min at 425°F)
- Risotto (30 min constant stirring)
- Chocolate soufflés (15 min at 375°F, serve immediately)

**Constraints**:
- Guests arrive at 7:00 PM
- One oven, one stove
- Everything should be hot and ready at 7:00 PM

**Why this works**: Everyone has experienced timing constraints in cooking, hosting, or meal prep. It's viscerally relatable.

---

### Act 1: Naive Approach (The Failure)

**Visual**: Edward Gorey-style chaotic kitchen illustration

**Narrative**:
> "Your first instinct: 'I'll just start cooking when I get home from work at 4pm and figure it out as I go.'"

**What goes wrong**:
- Start chicken at 4:00 → done at 5:30, now getting cold by 7:00
- Vegetables need different temperature—take chicken out early?
- Risotto needs constant attention—when to start?
- Soufflés collapse if not served immediately

**Result**: Lukewarm chicken, raw vegetables, no soufflés, stressed host

**Pedagogical purpose**: Students *feel* the problem before seeing the solution. The pain is real.

---

### Act 2: The Revelation (Reframing)

**Visual**: Edward Gorey-style "lightbulb moment" illustration

**Narrative**:
> "Wait—this isn't just random chaos. This is a **scheduling problem with constraints!**"

**The reframe**:
- **Precedence constraints**: Some things must finish before others start
- **Resource constraints**: One oven, one stove
- **Temporal constraints**: Everything must converge at exactly 7:00pm

**Pedagogical purpose**: Recognition of problem *structure* is the first step in algorithmic thinking. Once you see the pattern, you can apply systematic tools.

---

### Act 3: Systematic Solution (Working Backwards)

**Visual**: Edward Gorey-style Gantt chart

**Narrative**:
> "Work backwards from 7:00 PM. What *must* be happening at 7:00?"

**The Schedule**:
1. **Soufflés**: 6:45-7:00 (finish at 7:00, can't wait)
2. **Vegetables**: 6:00-6:45 (45 min at 425°F, before soufflés)
3. **Chicken**: 4:30-6:00 (90 min at 375°F, same temp as soufflés!)
4. **Risotto**: 6:30-7:00 (30 min at stove while soufflés bake)

**The insight**: Soufflés are the **critical path**—everything schedules around them.

**Pedagogical purpose**: Systematic reasoning leads to solution. This is *discoverable*, not magic.

---

### Act 4: Optimization & Trade-offs

**Narrative**:
> "But wait—we've been optimizing for 'everything hot at 7pm.' What if we reframe?"

**Alternative strategies**:
- Make room-temperature dish instead of soufflés? → *Relaxing constraints*
- Get help with risotto? → *Adding resources*
- Prep soufflé batter in advance? → *Preprocessing*
- Serve appetizers, delay dinner to 7:30? → *Changing deadlines*

**Pedagogical purpose**: There are *multiple valid solutions* depending on what you're optimizing for. Algorithmic thinking isn't one-size-fits-all.

---

## Generalized Algorithmic Principles

### What This Story Teaches

1. **Recognize problem structure** (it's a scheduling problem)
2. **Identify constraints** (resources, time, dependencies)
3. **Work strategically** (backwards from goal)
4. **Find the critical path** (what determines success/failure)
5. **Optimize deliberately** (know *what* you're optimizing)
6. **Consider trade-offs** (relax constraints, add resources)

**NOT**: "Memorize the algorithm for scheduling problems"

**INSTEAD**: "Here's how to *think* about problems with constraints"

---

## Why This Works: Cognitive Science Backing

### Schema Activation

Students already have "hosting dinner party" schema. By anchoring algorithm concepts to existing knowledge, we:
- Reduce cognitive load
- Make abstract concrete
- Enable transfer to other domains

### Narrative Structure

Human brains are wired for stories:
- **Setup** → **Complication** → **Resolution** follows narrative arc
- Emotional engagement (stress of cooking) increases retention
- Failure → insight → success mimics actual problem-solving process

### Inductive Learning

Rather than deductive "here's the algorithm, here's proof," we go inductive:
- Concrete example first
- Pattern recognition
- Generalization to principle

This matches how humans naturally learn.

---

## Design Patterns for Algorithmic Storytelling

### Pattern 1: Everyday Scenario

**Requirements**:
- Relatable to students (cooking, travel, shopping, gaming)
- Clear constraints
- Visceral failure mode
- Non-technical vocabulary

**Examples**:
- Packing a suitcase → Knapsack problem
- Choosing courses → Constraint satisfaction
- Finding shortest route on map → Graph algorithms
- Organizing study schedule → Time management / Greedy

---

### Pattern 2: Three-Act Structure

**Act 1: Naive Approach Fails**
- Show intuitive but wrong approach
- Let students feel the pain
- Build motivation for better solution

**Act 2: Reframe & Recognition**
- "Aha! This is actually a [type] problem"
- Name the structure
- Identify constraints

**Act 3: Systematic Solution**
- Work through solution methodically
- Explain *why* each step
- Show it actually works

---

### Pattern 3: Visual Progression

**Three illustrations minimum**:
1. **Chaos**: Visual representation of naive approach failing
2. **Insight**: Moment of recognition (lightbulb, diagram sketch)
3. **System**: Clean solution (Gantt chart, flowchart, graph)

**Style note**: Edward Gorey crosshatching style chosen for:
- Sophistication (not childish)
- Clarity (high contrast, detailed)
- Personality (memorable, distinctive)

---

### Pattern 4: Generalization Bridge

**After the story**, explicit bridge to formal concepts:

> "What we just did—that's algorithmic thinking:
> 1. Recognize structure
> 2. Identify constraints
> 3. Solve systematically
> 4. Optimize deliberately"

**Then**: "Now let's see this in action with other problems..."

---

## Anti-Patterns to Avoid

### ✗ Don't: Start with formal definition

```
BAD: "A scheduling problem is defined as..."
GOOD: "You're hosting a dinner party. Guests arrive at 7pm..."
```

### ✗ Don't: Make story too perfect

**Bad story**: Solution is obvious, no struggle

**Good story**: Naive approach is intuitive but fails, forcing reframe

### ✗ Don't: Skip the failure

**Why failure matters**: Without experiencing failure, solution feels arbitrary

### ✗ Don't: Over-explain the metaphor

**Bad**: "You see, the chicken is like Process A in an operating system scheduler..."

**Good**: Let students make connections themselves, or ask "Where else do you see problems like this?"

---

## Catalog of Algorithmic Stories (Future)

### Priority: High (Core Curriculum)

- [x] **Dinner Party** → Scheduling, constraints, critical path
- [ ] **Packing Suitcase** → Knapsack, greedy vs optimal
- [ ] **GPS Navigation** → Shortest path, Dijkstra's
- [ ] **Social Network Friend Suggestions** → Graph connectivity, BFS
- [ ] **Netflix Recommendations** → Collaborative filtering, similarity

### Priority: Medium (Enrichment)

- [ ] **Sorting Books on Shelf** → Comparison sorts, lower bounds
- [ ] **Organizing Tournament** → Tree structures, brackets
- [ ] **File Compression** → Huffman coding, information theory
- [ ] **Change Making** → Greedy algorithms, counterexamples

### Priority: Low (Advanced Topics)

- [ ] **Cryptographic Puzzles** → Complexity theory, P vs NP
- [ ] **Traveling Salesman** → NP-hardness, approximation
- [ ] **PageRank** → Random walks, eigenvectors

---

## FIL: Story Development Process

### Phase 1: Identify Core Concept

What algorithmic principle are you teaching?

### Phase 2: Find Relatable Scenario

- What everyday experience maps to this?
- Do students have schema for this?
- Can failure be visceral?

### Phase 3: Design Three Acts

- Naive approach (what goes wrong?)
- Insight moment (reframe)
- Systematic solution

### Phase 4: Create Visuals

- Commission or generate 3 illustrations
- Edward Gorey style for consistency
- Chaos → Insight → System progression

### Phase 5: Build Generalization Bridge

- Extract algorithmic principles
- Connect to formal concepts
- Provide transfer examples

---

## COD: Story Template

```markdown
# [Algorithm/Concept]: [Story Title]

## Setup
[Relatable scenario with constraints]

## Naive Approach
[Intuitive but wrong approach]
[What goes wrong?]

## The Revelation
[Reframe: "This is actually a [type] problem!"]
[Identify constraints and structure]

## Systematic Solution
[Work through solution step by step]
[Explain reasoning]

## Algorithmic Principles
1. [Principle 1]
2. [Principle 2]
3. [Principle 3]

## Generalization
[Where else do you see this pattern?]
```

---

## Related ADRs

- ADR 0001: Reveal.js workflow (how stories integrate into slides)
- ADR 0005: Two-Track System (engagement depends on narrative quality)
- Future ADR: Visual Storytelling Standards (illustration guidelines)

---

## NOT: Connection to Holocaust Example

Jérémie mentioned using "Holocaust example" for measuring algorithmic length/complexity. This suggests:

- **Historical narratives** can carry algorithmic weight
- **Ethical dimensions** of efficiency (what gets optimized, for whom?)
- **Human cost** of algorithmic thinking applied without wisdom

Future ADR should explore: When do stories need ethical framing?

---

**Outcome**: Dinner Party story successfully conveyed scheduling concepts in Lecture 01. Students engaged with relatable scenario, experienced failure viscerally, and extracted generalizable principles. Pattern validated for future algorithmic storytelling.
