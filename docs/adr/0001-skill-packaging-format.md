# ADR-0001: Skill Packaging Format and Frontmatter Schema

- **Date**: 2026-02-27
- **Iteration**: 2 (Rewritten 2026-03-29)
- **Status**: Accepted
- **Deciders**: Jérémie Lumbroso, Claude Code Sonnet 4.5

---

## Quick Reference

**Navigation codes** (for grep):
- `QST:` Questions
- `ANS:` Answers
- `COD:` Code examples
- `FIL:` Files to examine
- `DOC:` Documentation

---

## Context

Skills need to be packaged in a format that:
1. Works with Claude Code's skill system
2. Follows the Agent Skills open standard
3. Can be distributed as a single `.skill` file
4. Includes proper metadata for discovery and invocation

Key questions for any skill:
- How to write the license correctly?
- How to link the license to the right content?
- What frontmatter to add to the SKILL.md so it will compile?

---

## Research Conducted

### FIL: Documentation examined
- `/docs/resources/extend-claude-with-skills.md` - Official Anthropic skill documentation
- `/docs/resources/visual-diffusion.skill` - Working example skill (unpacked and analyzed)
- `/docs/resources/agentskills/` - Agent Skills open standard specification

### COD: Visual Diffusion Skill Structure
```
visual-diffusion.skill (ZIP file)
└── visual-diffusion/
    ├── SKILL.md (with YAML frontmatter)
    └── references/
        ├── image-prompting.md
        ├── model-taxonomy.md
        ├── quick-reference.md
        └── video-prompting.md
```

### COD: Frontmatter Format (from visual-diffusion/SKILL.md)
```yaml
---
name: visual-diffusion
description: Expert prompting for image and video diffusion models (Nano Banana, GPT Image 1, DALL-E 3, Midjourney, Stable Diffusion, FLUX, Sora, Runway, Veo, Kling). Use when creating high-fidelity visual content - album art, concept art, creative visuals - where technical vocabulary and model-specific syntax dramatically improve output quality. Specializes in iterative dialogic refinement, multi-concept generation, and model-specific optimization.
---

# Visual Diffusion Model Prompting

[Markdown content follows...]
```

---

## Decision

### Packaging Format: ZIP Archive

**Chosen**: ZIP file containing skill directory with proper structure

**Generic Structure**:
```
your-skill-name.skill (ZIP file)
└── your-skill-name/
    ├── SKILL.md (required - with YAML frontmatter)
    ├── README.md (optional but recommended)
    ├── LICENSE (optional but recommended)
    └── resources/ (optional - for supporting files)
        ├── reference-material.md
        ├── examples/
        │   ├── example-1.md
        │   └── example-2.md
        └── subskills/
            └── specialized-guidance.md
```

**Why**:
- Matches Claude Code's expected format
- Follows Agent Skills open standard
- Enables single-file distribution
- Supports directory of supporting files

**Trade-offs accepted**:
- Slightly more complex than single file
- Requires build step to create ZIP
- Users must unzip to modify

---

### Frontmatter Schema: YAML at Top

**Chosen**: YAML frontmatter between `---` markers at the very beginning of SKILL.md

**Required fields**:
```yaml
---
name: your-skill-name
description: [One-line description that helps Claude decide when to load the skill]
---
```

**Optional fields**:
- `disable-model-invocation: false` (default - allow Claude to auto-invoke)
- `user-invocable: true` (default - show in `/` menu)
- `license: Complete terms in LICENSE` (if LICENSE file included)

**Why**:
- Matches Anthropic specification exactly
- Enables Claude's automatic skill discovery
- Description drives when skill is loaded
- Name becomes the `/your-skill-name` slash command

**Common Problem**:
```markdown
# Your Skill Name

**Authors:** Your Name
**License:** CC BY-SA 4.0
**Version:** 1.0.0

---

## When to Use This Skill
[...]
```

This is **WRONG** because:
1. Frontmatter must come BEFORE any markdown content
2. Frontmatter must be YAML, not markdown
3. The `---` separator is currently in the wrong place

**Correct Format**:
```yaml
---
name: your-skill-name
description: Brief description of what the skill does and when to use it. Should help Claude decide when to load automatically.
---

# Your Skill Name

**Authors:** Your Name
**License:** [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/)
**Version:** 1.0.0

---

## When to Use This Skill
[...]
```

---

## Consequences

### Immediate Actions Needed
1. Fix SKILL.md to have proper YAML frontmatter at top
2. Move attribution/license info below frontmatter (but keep it visible)
3. Create build script that ZIPs the skill directory
4. Test that Claude Code can load the skill correctly

### Long-term Benefits
- Skill will be auto-discovered by Claude when relevant
- Users can invoke with `/your-skill-name` command
- Distribution as single .skill file
- Follows standard that other AI tools can adopt

### Documentation Impact
- README and INSTALLATION should reference the frontmatter
- CI/CD must validate frontmatter syntax
- Release process creates properly formatted ZIP

---

## Action Items

- [x] Document packaging format decision - Owner: Claude Code
- [x] Document frontmatter schema decision - Owner: Claude Code
- [ ] Fix SKILL.md frontmatter - Owner: Skill builder
- [ ] Create build/packaging script - Owner: Skill builder (CI/CD task)
- [ ] Validate skill loads correctly - Owner: Both (testing)

---

## Supporting Materials

### DOC: Anthropic Skill Specification

From extend-claude-with-skills.md:

> Every skill needs a `SKILL.md` file with two parts: YAML frontmatter (between `---` markers) that tells Claude when to use the skill, and markdown content with instructions Claude follows when the skill is invoked. The `name` field becomes the `/slash-command`, and the `description` helps Claude decide when to load it automatically.

Key fields:
- **name** (optional, defaults to directory name): Lowercase, hyphens, max 64 chars
- **description** (recommended): What the skill does and when to use it
- **disable-model-invocation** (optional, default false): Set true to prevent auto-invoke
- **user-invocable** (optional, default true): Set false to hide from menu

### DOC: File Size Recommendations

From extend-claude-with-skills.md:

> Keep `SKILL.md` under 500 lines. Move detailed reference material to separate files.

This encourages hierarchical decomposition: core skill in SKILL.md, specialized guidance in resources/.

---

## Validation

- [x] Human: Decision matches Claude Code specification
- [x] AI: Understood the requirements from documentation
- [x] Verified against working example (visual-diffusion.skill)

**Notes**: This ADR establishes the foundational packaging format for all skills built with this template.

---

## Iterations

### Iteration 1 (2026-02-27)
- Human: Provided extend-claude-with-skills.md documentation
- Human: Provided visual-diffusion.skill as working example
- AI: Analyzed both sources, identified common SKILL.md formatting problem
- AI: Documented correct format with specific frontmatter schema
- Outcome: Clear specification for SKILL.md formatting and packaging

### Iteration 2 (2026-02-27) - Folder Naming Decision

**Issue:** Should skill directory match skill name exactly?

**Options considered:**

1. **Directory matches skill name** (e.g., `your-skill/` for `name: your-skill`)
   - Pro: Matches skill name exactly
   - Pro: Slash command stays concise
   - Pro: Follows official Anthropic pattern (directory = skill identity)

2. **Directory has `-skill` suffix** (e.g., `your-skill-skill/`)
   - Pro: No file moves needed
   - Con: Redundant `-skill` suffix
   - Con: Longer slash command

3. **Generic `build/` directory, rename at compile-time**
   - Pro: Short directory name
   - Con: Not immediately obvious what's inside
   - Con: **Doesn't match official Anthropic pattern**

**Investigation:**
- AI: Examined official Anthropic skills repository structure
- AI: Found skills are named after themselves: `algorithmic-art/`, `pdf/`, `xlsx/`
- AI: No examples of generic `build/` or `dist/` directories
- Observation: Skill directory name = skill identity, not just "build output"

**Decision:** Option 1 - Directory name matches skill name

**Rationale:**
- Matches official Anthropic convention (verified by examining real skills)
- Directory name should reflect skill identity, not be a generic build label
- The `-skill` suffix is redundant (everything in skills/ is a skill)
- Cleaner, more maintainable, matches slash command

**Outcome:**
- Pattern documented: `your-skill-name/` directory, `name: your-skill-name` frontmatter
- CI/CD workflow should use this pattern
- Pattern applies to all skills built with this template

### Iteration 3 (2026-03-29) - Template Transformation

- AI: Rewrote ADR generically for skill-building template
- Removed specific skill references (Architecture of Complexity)
- Used placeholder `your-skill-name` throughout
- Preserved all decisions and patterns
- Updated Links section (removed deleted ADR-0003)

---

## Links

- Related: ADR-0002 (Versioning Strategy)
- Related: ADR-0003 (LICENSE Files in Skill Directory)
- Reference: `/docs/resources/extend-claude-with-skills.md`
- Reference: `/docs/resources/skills/` - Official Anthropic skills (folder naming pattern)
- Example: `/docs/resources/visual-diffusion.skill`
