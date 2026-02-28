# ADR 0006: Parallel Agent Strategy for Super Syllabus Creation

**Status**: Accepted
**Date**: 2026-01-26 (documented 2026-01-31)
**Iteration**: 1
**Context**: Creating 22 comprehensive topic modules efficiently using parallel sub-agents

---

## Decision

We use **parallel sub-agents** (5 agents working simultaneously) to create large document sets like topic modules, with each agent handling a themed subset of topics and following a shared template and style guide.

---

## The Problem

We needed to create 22 detailed topic modules (~10-20KB each) for a super syllabus. A single agent approach failed due to:
- Context window limitations
- PDF size limits ("maximum of 100 PDF pages")
- Sequential processing taking too long

---

## The Solution: Parallel Agent Pattern

### Agent Distribution

**5 agents, each handling 4-5 related topics:**

| Agent | Category | Topics |
|-------|----------|--------|
| 1 | Foundational Paradigms | divide-and-conquer, dynamic-programming, greedy-algorithms, graph-traversal |
| 2 | Graph Algorithms | shortest-paths, network-flow-matchings, minimum-spanning-trees, strongly-connected-components, graph-connectivity |
| 3 | Complexity & Hardness | np-completeness-and-reductions, approximation-algorithms, parameterized-complexity, lower-bounds-and-adversary-arguments |
| 4 | Specialized Techniques | randomized-algorithms, online-algorithms, streaming-algorithms, parallel-distributed-algorithms |
| 5 | Applied Domains | string-algorithms, computational-geometry, linear-programming, advanced-data-structures, algorithms-for-machine-learning |

---

## Reconstructed Prompts

### COD: Master Prompt Template

Each agent received a prompt following this structure:

```markdown
You are helping create topic modules for a graduate algorithms course super syllabus.

## Your Assignment
Create detailed topic modules for the following topics in the [CATEGORY NAME] category:
1. [topic-1]
2. [topic-2]
3. [topic-3]
4. [topic-4]
(5. [topic-5] if applicable)

## Context
- Course: CIS 5020 Critical Analysis of Algorithms (Penn)
- Pedagogy: Problem-posing (Freire), NOT banking model
- Audience: Graduate students with varying backgrounds
- Purpose: Students explore this catalog with Claude to find topics matching their interests, then vote on what to cover

## Source Materials
Use the Deep Research report (provided below) as your primary source for:
- Topic descriptions and scope
- Difficulty assessments
- Key algorithms and concepts
- Real-world applications and war stories

## Output Format
For EACH topic, create a markdown file with this structure:

# [Topic Name]

## Overview
[1-2 paragraph description of what this topic covers]

## Difficulty Level
**[Introductory/Intermediate/Advanced/Research]**
- Basic concepts: [level]
- Core algorithms: [level]
- Advanced applications: [level]

## Why This Matters

**[Compelling hook - why should anyone care?]**

**War Story 1 - [Title]:**
[Real-world application with quantified impact if possible]

**War Story 2 - [Title]:**
[Another real-world application]

## Core Algorithms

### Essential
1. **[Algorithm 1]** - [one-line description]
2. **[Algorithm 2]** - [one-line description]
...

### Intermediate
[...]

### Advanced
[...]

## Prerequisites
- **Required:**
  - [Prerequisite 1]
  - [Prerequisite 2]
- **Helpful:**
  - [Nice-to-have 1]

## Problem-Posing Approaches

### Story 1: [Narrative Title]
**Setup:** [Relatable scenario students might encounter]

**Naive approaches students try:**
- [Approach 1] — [Why it fails]
- [Approach 2] — [Why it fails]

**Guided discovery:**
- [Socratic question 1]
- [Socratic question 2]

**The breakthrough:** [Key insight that leads to the algorithm]

**Why this matters:** [Connection to the broader topic]

### Story 2: [Narrative Title]
[Similar structure]

### Story 3: [Narrative Title]
[Similar structure]

## Cognitive Applications (from *Algorithms to Live By*)
[How this algorithmic thinking applies to everyday life and decision-making]

## Key Resources

### Textbooks
- **Kleinberg & Tardos §X** - [Description]
- **Skiena §Y** - [Description]
- **CLRS Ch Z** - [Description]
- **Erickson Chapter N** - [Description]

### Specialized Resources
[...]

### Videos & Lectures
[...]

### Papers & Advanced
[...]

## Connections to Other Topics
- **[Topic A]**: [How they relate]
- **[Topic B]**: [How they relate]

## Possible Projects
1. **[Project 1 Title]**
   - [Description]
   - [What students will learn]

2. **[Project 2 Title]**
   [...]

[3-5 projects total]

## Estimated Coverage Time
**[N-M lectures depending on depth]**
- X lectures: [Minimal coverage]
- Y lectures: [Standard coverage]
- Z lectures: [Deep dive]

## Common Misconceptions
1. **"[Misconception 1]"**
   - [Why it's wrong]

2. **"[Misconception 2]"**
   - [Why it's wrong]

[3-5 misconceptions]

## What Makes This Problem-Posing?

Traditional (banking model):
> "[Example of how traditional courses teach this topic]"

Problem-posing approach:
> "[How we approach it differently - discovery-based]"

**The difference:** [Explain the pedagogical distinction]

## When to Cover This

**Curriculum placement:**
- [Week range] for graduate courses
- [Week range] for advanced undergraduate

**Prerequisites check:** Students should understand:
- [Prerequisite 1]
- [Prerequisite 2]

**Why [early/mid/late]:** [Rationale for placement]

**Pedagogical note:** [Teaching advice]

---

**Ready for students?** ✓ Yes - [Brief quality statement]
```

### COD: Example Agent 1 Prompt (Foundational Paradigms)

```markdown
You are helping create topic modules for a graduate algorithms course super syllabus.

## Your Assignment
Create detailed topic modules for the following topics in the FOUNDATIONAL PARADIGMS category:
1. divide-and-conquer
2. dynamic-programming
3. greedy-algorithms
4. graph-traversal

## Context
- Course: CIS 5020 Critical Analysis of Algorithms (Penn)
- Pedagogy: Problem-posing (Freire), NOT banking model
- Audience: Graduate students with varying backgrounds
- Purpose: Students explore this catalog with Claude to find topics matching their interests, then vote on what to cover

## Key Emphases for Foundational Topics
- These are the building blocks - make sure prerequisites are minimal
- Emphasize intuition-building before formalism
- Include contrasts (e.g., when does greedy fail? That's when you need DP)
- War stories should be accessible and memorable

## Source Materials
[DEEP RESEARCH REPORT CONTENT INSERTED HERE]

## Output
Create 4 markdown files following the template structure. Each should be 10-20KB with rich detail. Focus on:
- Multiple problem-posing stories (2-3 per topic)
- Real war stories with quantified impact
- Clear difficulty gradations
- Connections between these foundational topics
- 3-5 concrete project ideas per topic

Write the content for each topic now.
```

### COD: Example Agent 5 Prompt (Applied Domains)

```markdown
You are helping create topic modules for a graduate algorithms course super syllabus.

## Your Assignment
Create detailed topic modules for the following topics in the APPLIED DOMAINS category:
1. string-algorithms
2. computational-geometry
3. linear-programming
4. advanced-data-structures
5. algorithms-for-machine-learning

## Context
- Course: CIS 5020 Critical Analysis of Algorithms (Penn)
- Pedagogy: Problem-posing (Freire), NOT banking model
- Audience: Graduate students with varying backgrounds
- Purpose: Students explore this catalog with Claude to find topics matching their interests, then vote on what to cover

## Key Emphases for Applied Topics
- Emphasize real-world applications and industry relevance
- These topics attract students with different backgrounds (bioinformatics, graphics, ML, systems)
- War stories should be concrete (company names, quantified impact)
- Projects should feel practical and portfolio-worthy
- Higher difficulty variance expected (intro to research-level content)

## Source Materials
[DEEP RESEARCH REPORT CONTENT INSERTED HERE]

## Output
Create 5 markdown files following the template structure. Each should be 10-20KB with rich detail. Focus on:
- Industry applications and career relevance
- Connections to other fields (biology, physics, economics, ML)
- Multiple difficulty entry points
- Modern developments and active research areas
- Practical project ideas that could go on a portfolio

Write the content for each topic now.
```

---

## Why This Works

### 1. Parallel Execution
- 5 agents run simultaneously
- Total wall-clock time reduced by ~5x
- No waiting for sequential completion

### 2. Themed Groupings
- Related topics handled together
- Agent can make cross-references within category
- Consistent difficulty calibration within category

### 3. Shared Template
- All agents use identical output structure
- Ensures consistency across 22 modules
- Easy to merge outputs

### 4. Category-Specific Guidance
- Each agent gets tailored emphasis
- Foundational topics: intuition-first
- Applied topics: industry relevance
- Complexity topics: proof techniques

---

## Implementation Notes

### Launching Parallel Agents

```
Task tool with subagent_type="general-purpose"

Launch all 5 agents in a SINGLE message with multiple Task tool calls.
Do NOT launch sequentially - use parallel tool calls.
```

### Source Material Handling

**What worked:**
- Deep Research report (text) passed to each agent
- Template structure included in prompt

**What failed:**
- Passing full PDF files (size limit)
- Single agent handling all 22 topics (context limit)

### Quality Control

After agents complete:
1. Spot-check 2-3 modules per category
2. Verify template structure followed
3. Check cross-references make sense
4. Ensure consistent difficulty ratings

---

## Metrics

| Metric | Value |
|--------|-------|
| Total topics created | 22 |
| Total content size | ~300KB |
| Agents used | 5 |
| Wall-clock time | ~15 minutes |
| Sequential equivalent | ~60+ minutes |

---

## When to Use This Pattern

**Good fit:**
- Creating multiple similar documents (topic modules, API docs, test cases)
- Content can be logically grouped into themes
- Shared template/structure exists
- Independence between groups (minimal cross-references needed)

**Poor fit:**
- Highly interdependent content (needs sequential refinement)
- Unique structure per document
- Small number of documents (<5)
- Documents that need iterative human feedback

---

## Lessons Learned

### What Worked Well

1. **Themed groupings** - Agents could make sensible cross-references within category
2. **Detailed template** - Ensured consistent output structure
3. **Category-specific guidance** - Each agent understood its emphasis
4. **Deep Research as source** - Provided comprehensive foundation

### What Could Improve

1. **Prompt preservation** - Should have saved exact prompts to ADR during creation
2. **Progress monitoring** - Could add structured progress updates
3. **Cross-category references** - Post-merge step to add connections between categories
4. **Quality rubric** - Explicit checklist for spot-checking

---

## Reproducibility Checklist

To recreate this pattern:

1. [ ] Define categories and topic assignments
2. [ ] Create detailed output template
3. [ ] Prepare source materials (text, not large PDFs)
4. [ ] Write category-specific prompt variations
5. [ ] Launch all agents in parallel (single message, multiple Task calls)
6. [ ] Monitor completion
7. [ ] Spot-check outputs
8. [ ] Commit results

---

## Related ADRs

- ADR 0001: Reveal.js Slide Collaboration Workflow
- ADR 0005: Two-Track Course System

---

## References

### FIL: Files Created by This Process

- `/syllabus/meta/super-syllabus.md` - Master catalog
- `/syllabus/meta/student-guide.md` - How students use the syllabus
- `/syllabus/topics/covered/*.md` - 20 topic modules (covered in course)
- `/syllabus/topics/not-covered/*.md` - 2 topic modules (not covered)

### DOC: Process Documentation

- `/syllabus/meta/SUPER-SYLLABUS-INGESTION-STRATEGY.md` - Original planning document
- `/syllabus/meta/HANDOFF-SESSION-1-COMPLETE.md` - Session summary

---

**Outcome**: Successfully created 22 comprehensive topic modules (~300KB total) in ~15 minutes using 5 parallel agents. Pattern validated for similar large-scale document generation tasks.
