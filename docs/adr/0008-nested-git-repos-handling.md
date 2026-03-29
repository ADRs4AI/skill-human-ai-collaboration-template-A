# ADR-0008: Handling Nested Git Repositories (Source Material)

- **Date**: 2026-02-28
- **Iteration**: 1
- **Status**: Accepted
- **Deciders**: Jérémie Lumbroso, Claude Code Sonnet 4.6

---

## Context

### QST: What to do with the nested git repos?
- Status: answered
Four git repositories were cloned as reference material inside this project's working directory:

| Path | Repository | Purpose |
|---|---|---|
| `docs/resources/reveal.js/reveal.js/` | `hakimel/reveal.js` | Core library source, plugin APIs |
| `docs/resources/reveal.js/reveal.js-plugins/` | `rajgoel/reveal.js-plugins` | rajgoel plugin collection source |
| `docs/resources/reveal.js/revealjs.com/` | reveal.js website | Official documentation, examples |
| `docs/resources/automated-testing/playwright-mcp/` | `microsoft/playwright-mcp` | Playwright MCP server source |

These show up as untracked in `git status` because git detects the nested `.git` directories. They are not tracked by the outer repository.

### Options considered

**Option A: Add to `.gitignore`**
- Treats them as ephemeral, local-only
- Anyone cloning this repo gets nothing
- No documentation of what was consulted or what version
- Rejected: loses provenance record

**Option B: Convert to git submodules**
- Links specific commits in the outer repo
- `git clone --recurse-submodules` gets them all
- Pro: reproducible
- Con: Overhead of maintaining submodule pointers; can break if upstream deletes branches
- Not preferred by the user

**Option C: Extract key files, document provenance in ADR, gitignore the repos**
- Extract the subset of files that are actually useful for the skill
- Document: what repo, what commit hash, what date fetched, why this content
- Add nested `.git` directories to `.gitignore`
- The outer repo stays self-contained
- Preferred by the user as most sustainable

### Answer

I tried to delete those folders. We should remove them from this repository, they are not relevant to this project. Please purge. If you can remove from whole history like everything else you remove.

If you find anything useful, feel free to keep, but I don't think there's anything relevant and I had already deleted the folders (sure you can retrieve them through the git history if you really are curious).

---

## Decision

### Option C: Extract key files, gitignore nested repos, document provenance here

**Rationale**: The 1M context model can benefit from having key source files available inline (e.g., the plugin source code for chalkboard, the reveal.js API). But full repositories include thousands of irrelevant files. Selective extraction keeps the repo clean and self-contained.

The ADR documents provenance so that:
- Future maintainers know where to get the latest versions
- AI agents know the vintage of the reference material
- Anyone can verify the source

---

## Provenance Records

### reveal.js (core library)

- **Source**: https://github.com/hakimel/reveal.js
- **Fetched**: 2026-02-27 (approximate, based on commit history)
- **Version**: v5.x (confirmed by `package.json` in cloned repo)
- **Why fetched**: Provides ground truth for plugin API (`Reveal.initialize`, plugin format), built-in plugin source code, CSS variable reference
- **Key files of interest**:
  - `plugin/` directory (6 bundled plugins: highlight, markdown, notes, math, search, zoom)
  - `dist/reveal.css`, `dist/reveal.js`
  - `js/reveal.js` (core API)

### rajgoel/reveal.js-plugins

- **Source**: https://github.com/rajgoel/reveal.js-plugins
- **Fetched**: 2026-02-27 (approximate)
- **Version**: Corresponds to npm `reveal.js-plugins` v4.6.0
- **Why fetched**: Source code for chalkboard, chart, animate, audio-slideshow, anything, customcontrols, fullscreen, loadcontent, poll, questions, seminar plugins
- **Key directories**:
  - `chalkboard/`, `chart/`, `animate/`, `audio-slideshow/`

### Martinomagnifico plugins (HTML reference)

- **Source**: Captured as `docs/resources/reveal.js/misc/REVEAL_JS_MARTINO_MAGNIFICO.html` (martinomagnifico.github.io)
- **Fetched**: 2026-02-27 (approximate)
- **Why fetched**: Browsable index of all Martinomagnifico plugins with demos and CDN links

### revealjs.com website

- **Source**: https://revealjs.com (official documentation)
- **Fetched**: 2026-02-27 (approximate)
- **Why fetched**: Official documentation, configuration reference, API docs

### playwright-mcp

- **Source**: https://github.com/microsoft/playwright-mcp
- **Fetched**: 2026-02-28
- **Why fetched**: Source for the Playwright MCP server used in visual quality checking

---

## Implementation

### Files to add to `.gitignore`

```gitignore
# Nested git repositories (source reference material, see ADR-0008)
docs/resources/reveal.js/reveal.js/
docs/resources/reveal.js/reveal.js-plugins/
docs/resources/reveal.js/revealjs.com/
docs/resources/automated-testing/playwright-mcp/
```

### Key files to extract

The following extractions are recommended (not yet done — future task):
- `docs/resources/reveal.js/reveal.js/plugin/` → keep as-is (small, useful)
- `docs/resources/reveal.js/reveal.js-plugins/chalkboard/` → keep for reference
- No extraction needed from revealjs.com (website HTML not directly useful for skill)

For now, the nested repos are gitignored but locally present. The extracted research reports (`REVEAL_JS_SPECIFICATION.md`, `REVEAL_JS_PLUGINS.md`, `REVEAL_JS_PLUGIN_WIKI.md`) serve as the distilled reference material.

---

## Notes

### NOT: 2026-02-28
The "most sustainable" option per Jérémie: Option C avoids submodule maintenance overhead while keeping the repo self-contained and portable. The key insight is that we don't need the entire git history of reveal.js — we need specific reference files. The distilled research reports already capture most of the useful knowledge.
