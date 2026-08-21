# ADR-0004: Skill Consumer Context and Deployment Environment

- **Date**: 2026-02-28
- **Iteration**: 2 (Rewritten 2026-03-29)
- **Status**: Accepted
- **Deciders**: Jérémie Lumbroso, Claude Code Sonnet 4.6

---

## Context

### QST: Who consumes skills, in what environment, and what does that imply for design?

When building a skill, the deployment context determines everything: token budget, expected iteration style, ability to run tools, access to files, and how dense vs. verbose guidance should be.

Two primary environments exist:
1. **Claude Code** (the CLI tool / VSCode extension) — has file access, can run shell commands, has MCP tools, long context, works iteratively in a repo
2. **Claude Web** (the web chat interface) — conversational, no file system access, limited context, single-turn or short conversation interactions

Skills may be used in both environments. The question is which environment should be the primary design target.

**ANS:** (by Jérémie Lumbroso)
The skill should be built for a model that is in a Claude Code like environment, in which it has file access, can run shell commands, and has MCP tools, long context, and works iteratively. We could make `kintsugi` have an MCP server, through `stdio`, and probably do it for cheap? But I think transformers like the ability to group commands together in shell, using the `&&` and `;` and so on. They tend to make many calls at once to see a lot in a single turn. (Which is so neat!)

---

## Decision

### Design for primary consumer, support secondary gracefully

Most skills will fit one of these patterns:

**Pattern A: Claude Web Primary (analysis/guidance skills)**
- Skills that primarily analyze, explain, or guide
- Users paste content directly into conversation
- Output is markdown in chat
- File access is not essential

Examples: Document analysis, argument mapping, code review guidance

**Pattern B: Claude Code Primary (generation/tooling skills)**
- Skills that generate files, run commands, or integrate with tools
- Require file system access or shell commands
- Work iteratively across multiple files
- Often batch-process content

Examples: Presentation builders, code generators, test framework setup

### Implications for Skill Design

| Consideration | Claude Code | Claude Web |
|---|---|---|
| Token budget per session | 1M context | ~200K |
| File access | ✅ reads/writes files | ⚠️ requires paste/copy |
| Batch processing | ✅ natural | ❌ manual |
| Iterative refinement | ✅ file edits | ✅ conversational |
| Output format | Files on disk | Markdown in chat |
| Content sources | Local files, PDFs, URLs | Paste text, URLs |
| SKILL.md length | Up to 500 lines | Prefer concise |

**Design principle**: SKILL.md should be complete enough for the primary use case, with optional subskills providing deeper guidance for specialized scenarios.

---

## NOT a decision about model capability

Claude Code is a CLI tool (execution environment), not a model. Claude Web is a web interface, not a model. The same Claude model runs in both. The difference is in what tools and context are available to that model.

---

### NOT:
- Claude Code = better model → Claude Web = weaker model
- "This skill works only in one environment"

### YES:
- Skill is primarily designed for [environment] based on task nature
- Skill should work in both environments when possible
- Subskills can provide environment-specific optimizations

---

## Examples

### Claude Web Primary
- **Document analysis skills**: Users paste papers, skill analyzes
- **Code review skills**: Users paste code, skill provides feedback
- **Writing guidance skills**: Users share drafts, skill suggests improvements

These work in Claude Code too, but don't require its file/tool capabilities.

### Claude Code Primary
- **Presentation builders**: Generate HTML/reveal.js from outlines, preview in browser
- **Test scaffolding**: Create test files, run test framework, check coverage
- **Migration tools**: Read existing files, transform, write new files

These can provide guidance in Claude Web, but full power requires Claude Code.

---

## Notes

### NOT: 2026-03-29
The primary environment choice affects skill structure. Claude Web-primary skills can be self-contained in SKILL.md. Claude Code-primary skills may reference tools, file patterns, and workflow automation that assume access to the local environment.

Both are valid. Choose based on what the skill fundamentally does.

---

## Iterations

### Iteration 1 (2026-02-28)
- Established framework for thinking about skill deployment contexts
- Identified key differences between Claude Web and Claude Code environments
- Created decision matrix for environment-specific trade-offs
- Outcome: Clear guidance for choosing primary vs secondary consumer

### Iteration 2 (2026-03-29) - Template Transformation
- AI: Rewrote ADR generically for skill-building template
- Removed epistemic arc mapping specific references
- Added Pattern A/Pattern B framework
- Provided generic examples across both patterns
- Clarified that environment choice is task-dependent

---

## Links

- Related: ADR-0001 (Skill Packaging Format)
- Related: ADR-0005 (Skill Structure) - hierarchical design accommodates both environments
