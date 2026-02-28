# ADR-0007: Plugin Reference Table Format

- **Date**: 2026-02-28
- **Iteration**: 1
- **Status**: Accepted
- **Deciders**: Jérémie Lumbroso, Claude Code Sonnet 4.6

---

## Context

### QST: Why does a plugin reference table need to exist at all?

The reveal.js plugin ecosystem is decentralized with no official marketplace. Plugins are discovered through GitHub, npm, CDN, and community wikis. In practice, when a Claude model is asked to "add a menu" or "add math support", it may stutter — inventing plausible-sounding package names, guessing CDN URLs, or producing initialization snippets that don't match the actual plugin API.

The "no more stuttering" goal: a lookup table that gives Claude the exact strings needed (npm package name, CDN URL, initialization object key, registration name) so it can produce correct code on the first attempt.

### QST: What format — markdown table or CSV?

The skill lives in markdown files. The primary consumers are Claude models reading these files as context. The secondary consumer is humans browsing the repo.

**Markdown table**:
- Rendered inline in the skill file
- Immediately readable by the model without format conversion
- GitHub renders it as HTML (human-legible)
- Pipe-delimited, no external tooling needed
- Supports inline code formatting (\`backticks\`)

**CSV**:
- Machine-parseable, importable into spreadsheets
- Requires separate loading step or file reference
- No inline code formatting in standard CSV
- Harder to read in raw form

---

## Decision

### Use markdown table format, organized by use case category

Rationale:
- Markdown tables are directly readable in the skill context window without transformation
- The primary consumer (Claude) reads markdown natively
- Inline code blocks (`backticks`) allow exact strings without ambiguity
- Categorization by use case (not alphabetically) matches how Claude looks things up: "I need math" → math section

### Schema

Each row has:
| Use Case | Plugin Name | CDN URL | npm package | JS init key | Notes |
|---|---|---|---|---|---|

Where:
- **Use Case**: What problem it solves (e.g., "Math rendering", "Navigation menu")
- **Plugin Name**: The human-readable name
- **CDN URL**: Direct `<script src="">` URL (or `bundled` if ships with reveal.js)
- **npm package**: `npm install` string (or `bundled`)
- **JS init key**: The identifier used in `Reveal.initialize({ plugins: [...] })`
- **Notes**: Version pins, known bugs, critical config keys

### Inline vs. separate file

A summary table (10-15 rows, most common plugins) lives inline in SKILL.md. The full table (30+ rows) lives in `resources/plugins-reference.md`. This is the stable-intermediate-form principle: SKILL.md gives the most common cases, `plugins-reference.md` gives the complete lookup.

---

## Alternatives Considered

### JSON/YAML registry
- Pro: machine-parseable, could be used in scripts
- Con: Not directly readable as skill context
- Rejected: Over-engineering for a documentation use case

### Narrative prose with plugin descriptions
- This already exists in `REVEAL_JS_PLUGINS.md` (the research report)
- The research report is too narrative for quick lookup
- Table complements it, doesn't replace it

---

## Notes

### NOT: 2026-02-28
The existence of `docs/resources/reveal.js/REVEAL_JS_PLUGINS.md` (the comprehensive research report) means the narrative background is already written. The plugin table is a different artifact: it's the quick-reference lookup, not the explanation. These serve different purposes and should both exist.

Version pinning is important (per ADR-0008 from penn-cis5020): only update between projects, never mid-project. The table should note versions that are known-stable rather than always pointing to `@latest`.
