# ADR 0004: What Goes in ADRs (and What Doesn't)

- **Date**: 2026-02-28
- **Iteration**: 1
- **Status**: Accepted
- **Deciders**: Jérémie Lumbroso, Claude Sonnet 4.6

---

## The Core Principle

ADRs and topic folders address **completely different concerns**. They are fully decoupled.

```
ADRs                               Topic Folders
────────────────────────           ─────────────────────────────
HOW we make and deliver            WHAT we say and teach
the course                         (content, arguments, examples)

Stable across all topics           Specific to one domain
and sessions                       Grows with each session

Operational specs for the          Source material for
AI co-creator                      the AI to draw from
```

**ADRs are never about content.** They are about the apparatus that produces content.

---

## What BELONGS in ADRs

### 1. Technical decisions
- Which presentation framework (reveal.js, version, CDN vs. local)
- Which plugins and why
- Which fonts, CDN sources
- How to set up speaker notes plugin (the notorious one we learned the hard way)

### 2. Aesthetic decisions
- The color palette and what each color means
- Typography choices (Crimson Text for headings, Inter for body — and why)
- Number of sentences per slide (what density feels right)
- How much whitespace
- When to use fragments vs. static content
- What the topic header slide looks like (lowercase title, pastel, no busy content)

### 3. Pedagogical structural decisions
- The vertical stack format — why stacks, not linear slides
- The question-scaffolded session pattern (v3 pattern: question card → topic stack)
- The speaker note TOC format (stack header shows what's inside — ADR 0001)
- How long stacks should be and why (ADR 0003: long rich stacks, selection at session time)
- The opening sequence every session must have (Slido setup, cybernetic/epistemic lens, eager intern)

### 4. Process decisions
- How slides get generated (human accumulates → AI projects → human validates)
- How feedback loops back into topics
- The session archive structure
- How the inbox works
- The naming conventions (ADR 0003: `YYYY-MM-DD-vN-[context].html`)

### 5. Branding and identity
- Princeton Adult School color scheme
- How Jérémie presents himself (credentials, HSP/autistic framing — when and how much)
- How Slido is introduced and its code displayed

### 6. The collaboration model itself
- That Jérémie accumulates, AI projects, Jérémie validates (ADR 0002)
- That ADRs are operational specs, not content specs
- How to read the repo as a new agent (this ADR and ADR 0001-0003)

---

## What does NOT belong in ADRs

### Content — even when it feels like a principle
- "Always mention the ATM example when talking about labor automation" → NO. That's topic content. Belongs in `topics/labor-automation/README.md`.
- "Use the Jevons paradox before the Hinton quote" → NO. That's a session-level sequencing decision, not an architectural one.
- "The 'eager intern' metaphor should come early" → MAYBE. If it's about session structure, it belongs in ADR. If it's about which content to include, it's a topic decision.

### Pedagogical content positions
- "AI doesn't really understand" — that's a content claim. Belongs in `topics/hallucinations/`.
- "The banking model is the core problem in education" — content. Belongs in `topics/education-thinking/`.
- "We believe X about AI and creativity" — content. Belongs in `topics/creativity/`.

**The test**: If a future AI agent could use this ADR to make correct formatting/structural/process decisions without knowing anything about AI content, it belongs in an ADR. If it requires knowing what Jérémie believes about AI, it's topic content.

---

## The Sophist/Statesman Analogy for ADRs

Jérémie's framing: ADRs handle "the sophistic aspects of what we're doing" — not in a pejorative sense, but in the sense of *execution and craft*.

The philosopher knows what to say (topic content).
The sophist knows how to say it effectively (the ADRs).
The statesman holds both (Jérémie: owns both the content and the delivery apparatus).

ADRs are how Jérémie communicates his **craft** to the AI co-creator, so the AI can execute with the right aesthetic and structural sensibility without needing to re-invent it each session.

---

## Agent Reading Instructions

If you are a Claude instance reading this repo for the first time, read the ADRs in this order:

1. **ADR 0001** — Speaker notes format (immediate practical constraint)
2. **ADR 0002** — What the repo is and how sessions work
3. **ADR 0003** — How topic folders are structured and named
4. **ADR 0004** (this file) — What ADRs govern and what they don't
5. **ADR 0001 from unrelated course** (`docs/sources/adrs-for-unrelated-course/`) — Historical precedent for reveal.js workflow

Then read `CLAUDE.md` for project-level directives.

Topic folder content is NOT part of agent onboarding — you read it when you need to generate content for a specific topic.

---

## Examples: Edge Cases

| Question | Where it goes |
|----------|--------------|
| "How many bullet points per slide?" | ADR (aesthetic decision) |
| "What examples illustrate Jevons Paradox?" | topic/labor-automation/README.md |
| "Should we use fragments or show all at once?" | ADR (structural decision) |
| "What is the cybernetic vs. epistemic distinction?" | topic/cybernetic-epistemic/README.md |
| "How do we introduce Slido at the start of a session?" | ADR (session structure) |
| "What does Ted Chiang argue about creativity?" | topic/creativity/README.md |
| "What color background for topic header slides?" | ADR (aesthetic) |
| "What is the 'eager intern' mental model?" | topic/eager-intern/README.md |
| "How do we format the session config file?" | ADR (process) |
| "Why does stochastic parrot metaphor have problems?" | topic/stochastic-parrots/README.md |

---

## Validation

- [x] Jérémie: The HOW/WHAT split — correct
- [x] Jérémie: ADRs as operational specs for AI (process, aesthetics, structure — not content)
- [x] Jérémie: Content belongs in topics, not ADRs

---

## Action Items

- [ ] As new aesthetic/structural decisions are made in conversation, create ADRs immediately (don't let them live only in chat) — both Jérémie and Sonnet
- [ ] Review existing `docs/sources/adrs-for-unrelated-course/` and identify which decisions apply here — Sonnet 4.6

---

## Iterations

### Iteration 1 (2026-02-28)
- Human: Articulated the distinction in conversation ("It's not AI philosophy, it's how do we teach, what's the actual color or styling")
- AI: Drafted ADR; added the edge case table and sophist/statesman analogy
- Outcome: Accepted

---

## Links

- Related ADRs: 0001, 0002, 0003
- Related source: `docs/sources/adrs-for-unrelated-course/` (precedent from unrelated course)
