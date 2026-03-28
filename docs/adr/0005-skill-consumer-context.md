# ADR-0005: Skill Consumer Context and Deployment Environment

- **Date**: 2026-02-28
- **Iteration**: 1
- **Status**: Accepted
- **Deciders**: Jérémie Lumbroso, Claude Code Sonnet 4.6

---

## Context

### QST: Who consumes this skill, in what environment, and what does that imply for design?

When building a skill, the deployment context determines everything: token budget, expected iteration style, ability to run tools, access to files, and how dense vs. verbose guidance should be.

Two candidate environments exist:
1. **Claude Code** (the CLI tool / VSCode extension) — has file access, can run shell commands, has MCP tools, long context, works iteratively in a repo
2. **Claude Web** (the web chat interface) — conversational, no file system access, limited context, single-turn or short conversation interactions

The epistemic arc mapping skill will likely be used in both environments. The question is whether the skill should be designed exclusively for Claude Code or aspire to work in both.

---

## Decision

### Primary consumer: Claude Web for analyzing papers and documents

Epistemic arc mapping is primarily a reading/analysis task, which fits naturally in Claude Web:
- Users can paste papers directly into the conversation
- The analysis output is markdown (no files to create)
- Most use cases are single-paper analysis
- Iterative refinement happens through conversation, not file edits

### Secondary consumer: Claude Code for batch analysis or research projects

Claude Code becomes valuable when:
- Analyzing multiple papers systematically
- Building a research database with consistent arc mappings
- Integrating with note-taking systems or literature review workflows
- Working with PDFs or documents that need file access

This means the skill should be self-contained enough to be useful without file system access, but structured so that Claude Code can load depth as needed.

---

## Implications for Skill Design

| Consideration | Claude Code | Claude Web |
|---|---|---|
| Token budget per session | 1M context | ~200K |
| File access | ✅ reads PDFs/papers | ⚠️ requires paste |
| Batch processing | ✅ natural | ❌ |
| Iterative refinement | ✅ natural | ✅ natural (conversational) |
| Output format | Markdown files | Markdown in chat |
| Paper sources | Local PDFs, URLs | Paste text, URLs |
| SKILL.md length | Up to 500 lines | Prefer concise |

**Design principle**: SKILL.md should be complete enough for Claude Web single-paper analysis (the primary use case), with optional subskills providing deeper guidance for specialized analysis types (e.g., policy documents vs. academic papers).

---

## NOT a decision about model capability

Claude Code is a CLI tool (execution environment), not a model. Claude Web is a web interface, not a model. The same Claude Sonnet model runs in both. The difference is in what tools and context are available.

---

### NOT:
- Claude Code = better model → Claude Web = weaker model
- "This skill is only for Claude Web"

### YES:
- Skill is primarily designed for Claude Web conversational analysis
- Skill should work seamlessly in Claude Code for batch/research workflows
- Richer subskills provide specialized guidance (policy docs, book chapters, etc.)

---

## Notes

### NOT: 2026-03-28
Unlike presentation-building skills (reveal.js) which benefit heavily from file access and visual QA tools, epistemic arc mapping is fundamentally a reading/analysis task. Claude Web is the natural primary environment, with Claude Code providing value for systematic research workflows.
