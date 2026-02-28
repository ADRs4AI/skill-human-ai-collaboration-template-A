# Seed: Topic Curation Skill

**Status**: Seed — ready to become its own repository
**Originated**: 2026-02-28, during revealjs-skill founding session
**Originated by**: Jérémie Lumbroso + Claude Sonnet 4.6
**Note on origin**: The insight that this pattern is generic (not reveal.js-specific) was
observed by Claude Sonnet 4.6 via the Architecture of Complexity skill — as an example
of AoC's generative power. See ADR-0010 in the revealjs-skill repo.

---

## The Core Insight

Preparing talks is a special case of a more general problem:

> You have **deep expertise** in a domain. That expertise is **structured as independent
> subtopics**. For any given audience, occasion, or medium, you need to **select and assemble**
> a subset of those subtopics into a coherent presentation. The selection should be guided by
> audience context, time constraints, and pedagogical goals — but it should NOT require
> rebuilding the material from scratch each time.

This is **not specific to slides**. The same pattern applies to:
- Lecture series / courses
- Blog posts and newsletters
- Podcast episodes
- Workshop modules
- Conference talks of varying lengths (30 min / 60 min / 90 min)
- Memos and briefs for different organizational audiences
- Twitter/LinkedIn threads
- Textbook chapters

The slides are just one **projection format** of the underlying expertise.

---

## Architecture of Complexity Mapping

This pattern maps directly to Simon's "Architecture of Complexity":

| Simon's concept | In this skill |
|---|---|
| Hierarchical system | Expertise domain → subtopics → points → examples |
| Near-decomposability | Subtopic stacks are independent (changing one doesn't break others) |
| Stable intermediate forms | Topic stacks are the "watchmaker's subassemblies" — complete, reusable, testable independently |
| Sparse coupling (empty world hypothesis) | Minimal cross-references between topics (enabling free reordering) |
| Process vs. state | State = accumulated topic content; Process = session assembly |

**The Watchmaker Parable as workflow:**
- ❌ Tempus: Start from scratch for each new audience/occasion
- ✅ Hora: Build topic stacks once (stable subassemblies), assemble per session

---

## The Three-Layer Architecture

```
Layer 1: EXPERTISE DOMAIN
  ↓ structured into
Layer 2: TOPIC LIBRARY (stable subassemblies)
  Each topic: self-contained, long, rich, append-only
  Format: README.md (accumulation) + sources/ + audience-questions/ + projections/
  ↓ projected into
Layer 3: SESSION INSTANCES (curated selections)
  Each session: specific audience × occasion × time constraint × angle
  Format: assembled presentation file (slides, post, memo, etc.)
```

---

## Layer 2: The Topic Stack Model

### The Accumulation Principle
A topic stack is an **append-only knowledge base**, never a final document:
- New case studies, audience questions, and insights are added without removing old ones
- When something is superseded, annotate and keep: `[SUPERSEDED 2026-03-01: ...]`
- The stack grows richer with every encounter
- Git tracks diffs; annotations track why things changed

### Topic Stack Anatomy
```
topics/[slug]/
├── README.md                # Accumulation substrate (APPEND ONLY)
│   ├── Zone 1: Structured (maintained)
│   │   ├── The core claim
│   │   ├── Bad takes we're arguing against
│   │   ├── Key examples and case studies
│   │   ├── What makes audiences anxious/curious
│   │   ├── Content inventory
│   │   ├── Projection history (dated list)
│   │   └── Connected topics
│   └── Zone 2: Free Zone (append only, overflow)
├── sources/                 # Raw materials (articles, excerpts, links)
├── assets/                  # Images, visual prompts, diagrams
├── audience-questions.md    # Questions that actually came up in sessions
├── connections.md           # How this topic links to others
└── projections/             # Output artifacts, one per session/format
    └── YYYY-MM-DD-vN-[context].[ext]
```

### The Long Stack Principle
- Topic stacks should be **rich and long** (8–12 sub-items when fully developed)
- Different angles: overview, deep dive, case study A, case study B, controversy
- **Curation happens at session-assembly time, not creation time**
- For depth session (1–2 topics): pull the full stack
- For breadth session (6–8 topics): select 1–3 items per topic

---

## Layer 3: Session Assembly

### The Assembly Process

1. **Context intake** — establish session parameters:
   - Who is the audience? (experts vs. general; age group; domain background)
   - What is the occasion? (conference, class, workshop, podcast, article)
   - What is the time/space budget? (30 min / 500 words / 5 slides)
   - What is the primary goal? (inspire, teach, persuade, inform)
   - What angle to emphasize? (controversy, practical, historical, technical)

2. **Topic selection** — model + human in dialogue:
   - Model proposes which topics to include and in what order
   - Human reviews, adjusts angles, adds constraints ("emphasize X, skip Y this time")
   - Optional: pre-designed question set to drive the selection (Slido questions as anchors)

3. **Projection generation** — model generates the output format:
   - For slides: generates reveal.js HTML from topic stacks
   - For post: generates markdown from topic stacks
   - Human validates and adjusts

4. **Archive** — record what was used:
   - Log the session config (audience, occasion, topics selected, projection file)
   - Update each used topic's README with what happened (`## Projection history`)
   - Update `audience-questions.md` with questions that came up

### The Human-Model Dialogue Model
This is NOT a fully autonomous model that generates everything. It's a **dialogue**:
- Human brings: expertise, pedagogical position, aesthetic taste, content judgment
- Model brings: structural awareness, pattern matching, projection generation, consistency
- Joint: topic selection, angle calibration, quality validation

The human is **validator and selector**, not generator. The model is **generator and organizer**, not judge.

---

## The Spaghetti → Structure → Projection Pipeline

The practical problem this skill solves:

> You have a brain full of ideas, experiences, case studies, and opinions about a domain.
> They're connected in your head but not systematically organized. When a talk/post/class comes up,
> you improvise — but it's inconsistent, not reusable, and exhausting.

The pipeline:

```
Spaghetti dump     → Raw notes, voice memos, articles, opinions, examples
       ↓
Topic identification → What are the stable clusters? What's one topic vs. another?
       ↓
Topic README seeding → Put each cluster in a README with structured zones
       ↓
Stack enrichment   → Sources, case studies, audience questions added per topic
       ↓
Session assembly   → Model + human select and order for specific occasion
       ↓
Projection         → Slides, post, memo, etc.
       ↓
Archive & learn    → What worked? What questions came up? Feed back into stacks
```

---

## Why This Becomes Its Own Skill

The topic curation pattern is independent of:
- The output format (slides, posts, memos)
- The domain (AI, cooking, history, programming)
- The audience type (students, engineers, general public)
- The model (Claude Sonnet, Claude Opus, any capable LLM)

The reveal.js skill includes a simplified version (`resources/topic-curation.md`) that
instantiates this pattern specifically for slide presentations.

The full skill would:
1. Guide the **spaghetti → structure** transformation (topic identification)
2. Provide **topic stack templates** for different domain types
3. Document the **human-model dialogue protocol** for session assembly
4. Support **multiple output formats** (not just slides)
5. Include **evaluation rubrics** (did this session work? what improved?)

---

## Prezi Connection

Jérémie noted this reminds him of Prezi. The connection:
- Prezi made the "zoom out to see the whole map, zoom in on a topic" interaction visible
- This skill makes the **logical equivalent** explicit: there is a map (the topic library),
  and each session is a path through that map
- The difference: Prezi is a presentation tool; this is a **knowledge architecture**
  that can produce any presentation tool's output (including Prezi, if desired)

---

## Repository Scaffold (for the future skill)

Proposed repository structure when this becomes its own skill:

```
topic-curation-skill/
├── SKILL.md                          # Entry point
├── README.md
├── resources/
│   ├── topic-stack-template.md      # Template for a new topic
│   ├── session-assembly.md          # Assembly dialogue protocol
│   ├── spaghetti-to-structure.md    # Intake and classification
│   ├── projection-formats.md        # Slides, posts, memos, etc.
│   └── aoc-mapping.md              # Full AoC analysis of the pattern
├── examples/
│   ├── course-on-ai/                # Example: academic course
│   ├── company-blog/                # Example: recurring newsletter
│   └── conference-speaker/          # Example: speaker with multiple talks
└── docs/
    └── adr/
```

---

## Open Questions (to resolve when building the full skill)

### QST: How granular should a "topic" be?
Simon's insight suggests: topics should be the size of "stable subassemblies" — independently
testable and reusable. Too large = can't reuse parts. Too small = assembly becomes unwieldy.
Rule of thumb from production use: 8–12 slides when fully developed suggests ~20–40 min of depth content.

### QST: How to handle cross-topic dependencies?
Some topics only make sense after another (prerequisite structure). Document as `connections.md`.
In session assembly: model should flag prerequisite chains.

### QST: What is the right format for the session config?
Currently informal (ADR, README). Could be YAML for machine-readability. Tradeoff: structure
vs. friction.

### QST: How to version projections without overwriting?
Current answer: date-stamped filenames (`YYYY-MM-DD-vN-context.ext`). Never overwrite.
See ADR-0003 from beyond-the-hype course (in revealjs-skill repo).

### QST: Does this skill need a model-invokable tool (MCP)?
A session-assembly MCP tool could read the topic library and generate session configs.
This would be the most powerful form — but requires more infrastructure.

---

## Notes from Founding Conversation

### NOT: 2026-02-28 (Jérémie Lumbroso)
> "I think for now we should pilot it as a subskill and then expand later. [...] This topic
> curation thing could be dumping a lot of ideas, structuring it into subtopics and then using
> it to mint blog posts or addresses or memos or something like that."

### NOT: 2026-02-28 (Jérémie Lumbroso, on the pattern)
> "You should think of the topics as the stable subassemblies of anything that you want to
> explain. So you can always go deeper. It can always be smaller concepts. This is really a
> generic way of teaching a course."

### NOT: 2026-02-28 (Jérémie Lumbroso, on human-model collaboration)
> "It's a model in conversation with the human. The human says, here's what I'd like to do
> and things like that. Maybe the human can help review with the questions and say which
> specific angles they want to push here."

### NOT: 2026-02-28 (Claude Sonnet 4.6, on generativity)
The observation that this pattern is generic came from applying AoC to the slide preparation
workflow and asking: what is the stable intermediate form? The answer (the topic stack) led
immediately to recognizing that the same stable form can be projected into any medium —
not just slides. This is Simon's process/state duality applied to knowledge work.
