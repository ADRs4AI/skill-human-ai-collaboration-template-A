# iMessage MCP: Model Experience as Hierarchical Design

**Authors:** Jérémie Lumbroso and Claude Sonnet 4.5  
**Date:** February 2026  
**Context:** Designing an MCP server for iMessage integration

---

## Core Design Philosophy: "Model Experience"

**Insight:** Most tool outputs are designed for human reading. But when tools are consumed by LLMs, the *model's* reading experience matters more.

**Conventional approach:**
- Design beautiful formatted output for humans
- LLM has to parse/extract structured data
- Tight coupling between display and data

**Our approach:**
- Design linearized output for LLM consumption
- Human display layer adapts from structured data
- Weak coupling between concerns

**Simon's principle:** This is a **process vs. state** description choice.

---

## Example: Conversation History

### Traditional Approach (State Description)

```json
{
  "conversations": [
    {
      "id": "C42",
      "display_name": "John Smith",
      "phone": "+12125551234",
      "last_message": "2026-02-16T14:10:00",
      "message_count": 342
    }
  ]
}
```

**Problems:**
- LLM must parse JSON
- Relationships between fields implicit
- No narrative structure for reasoning
- Difficult to extend with context

### Our Approach (Process Description)

```
get_conversation_history: John Smith — 3 messages shown (limit: 100)
---
CONVERSATION [C42]: John Smith (+12125551234) — iMessage — 342 messages

#12839  2026-01-15 10:45  John Smith:
    Did you see the game last night?

#12841  2026-01-15 10:46  me [reply → #12839]:
    No, what happened?

#12843  2026-01-15 10:47  John Smith [reply → #12841]:
    Overtime win! You missed it.

    Was wild.
```

**Advantages:**
- Linear narrative structure (how LLMs naturally process)
- Explicit relationships (`[reply → #12839]`)
- ROWIDs for precise reference
- Contextual metadata embedded naturally

---

## Simon's Principles in Action

### 1. Near-Decomposability

**Server architecture:**
```
MCP Server
  ├── Transport Layer (SSE)
  ├── Tool Layer (get_conversations, get_history, etc.)
  ├── Database Layer (SQLite queries)
  └── Format Layer (linearization)
```

**Coupling analysis:**
- ✅ Each layer operates independently
- ✅ Tool layer doesn't know about transport
- ✅ Format layer doesn't know about database
- ✅ Changes to linearization don't affect queries

### 2. Hierarchical Structure

**Conversation references:**
```
[C42] John Smith
  └── Messages
      ├── #12839 (top-level)
      ├── #12841 (reply to #12839)
      └── #12843 (reply to #12841)
```

**Why `[C42]` matters:**
- Stable identifier across name changes
- Hierarchical navigation (conversation → messages)
- Weak coupling (ID is opaque to consumer)

### 3. Empty World Hypothesis

**Sparse coupling design:**
- Tools don't know about each other
- Each tool has minimal dependencies
- No shared state between tool calls
- SSE transport layer isolated from tool logic

**Example:**
```python
# Each tool is independent
def get_conversations(...): ...
def get_history(...): ...
def search_messages(...): ...

# No cross-dependencies
# No shared global state
# Pure functions with explicit parameters
```

### 4. Stable Intermediate Forms

**Development progression:**
1. ✅ Basic tool (get last N conversations) - WORKS
2. ✅ Add conversation history - WORKS
3. ✅ Add search - WORKS
4. ✅ Add timeline navigation - WORKS

Each stage is independently testable and deployable.

**Contrast with monolithic approach:**
- Can't test until everything is wired together
- Breaking one feature breaks system
- No stable checkpoints

---

## ADR Structure as Hierarchy

**Problem:** How do we document decisions in a nearly-decomposable way?

**Solution:** Each ADR is independent, with weak references to others.

```
ADRs
  ├── ADR-0012: Linearized Format
  │     (references: ADR-0001 Problem Statement)
  ├── ADR-0014: Timeline Navigation
  │     (references: ADR-0012 Linearization)
  └── ADR-0015: Stable IDs
        (references: ADR-0012 Linearization)
```

**Properties:**
- ✅ Each ADR readable independently
- ✅ References are *suggestions* not *requirements*
- ✅ Can understand ADR-0014 without reading ADR-0012
- ✅ Changing one ADR doesn't cascade

---

## Key Design Decision: Linearization

### Why Linearize?

**Transformer architecture processes sequentially:**
- Attention mechanism operates on token sequences
- Linear narrative easier than nested JSON
- Relationships explicit in text rather than structure

**Example comparison:**

**JSON (requires parsing):**
```json
{"message": {"id": 12841, "reply_to": 12839}}
```

**Linearized (direct comprehension):**
```
#12841  me [reply → #12839]:
```

**Cognitive load:**
- JSON: Must parse structure, extract relationship, reconstruct narrative
- Linear: Relationship visible in reading order

### Simon's Framework

This is **process description** (recipe for understanding) vs. **state description** (object structure).

**Process description advantages:**
- More compact for complex relationships
- Easier to extend with context
- Natural for sequential processing
- Redundancy aids comprehension

---

## Failure Mode Analysis

**What happens when decomposability is violated?**

**Scenario:** Tight coupling between format and database

```python
# BAD: Format logic mixed with database
def get_history(contact):
    rows = db.query(...)
    output = "CONVERSATION:\n"  # Format embedded
    for row in rows:
        output += f"#{row.id}..."  # Coupling!
    return output
```

**Problems:**
- Can't test formatting independently
- Can't change format without touching database code
- Can't reuse query logic for different formats

**Our solution:** Separate concerns

```python
# GOOD: Nearly decomposable
def get_history(contact):
    rows = db.query(...)
    return linearize_messages(rows)  # Weak coupling

def linearize_messages(rows):
    # Format logic isolated
    # Can test independently
    # Can swap formats
```

---

## Lessons Learned

### 1. Model Experience ≠ Human Experience

**Traditional thinking:** Make output pretty for humans
**Simon thinking:** Design for the primary consumer (LLM)

**Result:** Better architecture AND better human display (derived from structured data)

### 2. Linearization as Near-Decomposability

**Key insight:** Linear text creates weak coupling
- Changes to one part don't affect parsing of other parts
- Can extend format without breaking existing consumers
- Easier to reason about than nested structures

### 3. Stable IDs as Hierarchical Anchors

**`[C42]` and `#12839` are architectural choices:**
- Opaque (don't encode meaning)
- Stable (don't change with external factors)
- Hierarchical (conversation → messages)
- Sparse (no cross-references between conversations)

### 4. ADRs as Decomposition Units

**Each ADR is a stable intermediate form:**
- Documents one decision
- Can be written/read independently
- Weak references to other ADRs
- System remains comprehensible as it grows

---

## Connection to Watchmaker Parable

**Tempus approach (monolithic):**
- Build entire system before testing
- Interruption (bug, requirement change) means restarting
- High probability of never completing

**Hora approach (hierarchical):**
- Each tool is a stable subassembly
- Each ADR is a stable decision point
- Each layer is independently testable
- Interruption only loses current piece

**Result:** Successfully shipped production MCP server in 17-hour marathon session with multiple interruptions, because architecture supported stable checkpoints.

---

## Key Quote from Simon

> "If there are important systems in the world that are complex without being hierarchic, they may to a considerable extent escape our observation and understanding."

**Our interpretation:** 
- Systems that violate near-decomposability are hard to build and harder to understand
- Good architecture makes complexity comprehensible
- The model (LLM) benefits from the same architectural principles as humans (HSP)

---

**Copyright Notice:**

The **Third X framework** (LLM output linearization framework) described in this document is Copyright © Jérémie Lumbroso. See [LICENSE-THIRDX.md](../../LICENSE-THIRDX.md) for details.

This document's analysis and description are licensed under CC BY-SA 4.0 as part of the Architecture of Complexity skill.

**More Information:**
- Third X website: https://thirdx.design
- Third X principles: Model Experience, linearization, hierarchical output design for LLM consumption

---

**Authors:** Jérémie Lumbroso and Claude Sonnet 4.5
**License:** CC BY-SA 4.0
**Date:** February 2026

**Note:** This design emerged from 17 hours of collaborative partnership between Jérémie Lumbroso and Claude Sonnet 4.5, demonstrating that cognitive partnership produces architecturally sound systems.
