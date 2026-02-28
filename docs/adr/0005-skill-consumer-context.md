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

The reveal.js skill has only been used in Claude Code to date. The question is whether the skill should be designed exclusively for that context or aspire to work in both.

---

## Decision

### Primary consumer: Claude Code operating inside a presentation repository

So far, all reveal.js presentations with Jérémie have been built in the Claude Code environment, specifically because:
- The iteration required to get CSS right (line-height, overflow) is more natural in Claude Code
- Aggregating sources (lecture notes, diagrams, external content) benefits from file system access
- The MCP Playwright tool for visual quality checking requires tool access
- Fine-tuning plugins and debugging requires reading the actual HTML files

### Secondary aspiration: Claude Web for simple/standalone requests

A clean multi-layered skill (SKILL.md + loadable subskills) could make reveal.js generation feasible in Claude Web for simpler use cases:
- Converting a topic outline to a standalone presentation
- Generating a single-file talk from notes
- Answering questions about reveal.js configuration

This means the skill should be self-contained enough to be useful without file system access, but structured so that Claude Code can load depth as needed.

---

## Implications for Skill Design

| Consideration | Claude Code | Claude Web |
|---|---|---|
| Token budget per session | 1M context | ~200K |
| File access | ✅ reads project files | ❌ |
| MCP tools (Playwright) | ✅ | ❌ |
| Iterative refinement | ✅ natural | ⚠️ requires back-and-forth |
| CDN vs. local paths | Either | CDN preferred (self-contained HTML) |
| Plugin management | Local files feasible | CDN required |
| SKILL.md length | Up to 500 lines | Prefer concise |

**Design principle**: SKILL.md must be dense enough to be useful in one shot (Claude Web), but the subskill resources allow Claude Code sessions to load deeper context when needed.

**NOT:** I think "one shot" is underselling what is possible in the Claude Web environment. It's more that, multi-file flows are less likely. It's less likely for a user to be able to include a lot of assets, unless they give absolute links. In fact we should give absolute links to CDNs for Claude Web, whereas Claude Code could also install them. Things like that, which you mentioned, yes, self contained HTML. But I could see Claude Web allowing for iteration.

---

## NOT a decision about model capability

Claude Code is a CLI tool (execution environment), not a model. Claude Web is a web interface, not a model. The same Claude Sonnet model runs in both. The difference is in what tools and context are available.

---

### NOT:
- Claude Code = better model → Claude Web = weaker model
- "This skill is only for Claude Code"

### YES:
- Skill is primarily battle-tested in Claude Code
- Skill should be readable standalone for Claude Web use
- Richer subskills are bonus depth for Claude Code sessions

---

## Notes

### NOT: 2026-02-28
The two-track distinction (Claude Code for complex iterative work, Claude Web for simple standalone requests) maps onto the broader insight from the penn-cis5020 course ADRs: the same content can be consumed at different depth levels depending on context. Long stacks + selective projection.
