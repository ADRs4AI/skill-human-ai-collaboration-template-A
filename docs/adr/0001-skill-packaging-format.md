# ADR-0001: Skill Packaging Format and Frontmatter Schema

- **Date**: 2026-02-27
- **Iteration**: 1
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

The Architecture of Complexity skill needs to be packaged in a format that:
1. Works with Claude Code's skill system
2. Follows the Agent Skills open standard
3. Can be distributed as a single `.skill` file
4. Includes proper metadata for discovery and invocation

From CLAUDE.md open questions:
- How to write the license correctly?
- How to link the CC license to the right content?
- What frontmatter to add to the SKILL.md so it will compile?

---

## Research Conducted

### FIL: Documentation examined
- `/docs/resources/extend-claude-with-skills.md` - Official Anthropic skill documentation
- `/docs/resources/visual-diffusion.skill` - Working example skill (unpacked and analyzed)
- `/docs/resources/agentskills/` - Agent Skills standard specification

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

**Structure**:
```
architecture-of-complexity.skill (ZIP file)
└── architecture-of-complexity/
    ├── SKILL.md (required - with YAML frontmatter)
    ├── README.md
    ├── INSTALLATION.md
    ├── META-ARCHITECTURE.md
    └── resources/
        ├── simon_1962_full.txt
        ├── simon_architecture_summary.md
        └── examples/
            ├── cam.md
            ├── mcp-design.md
            └── vue-react.md
```

**Why**:
- Matches Claude Code's expected format
- Follows Agent Skills standard
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
name: architecture-of-complexity
description: [One-line description that helps Claude decide when to load the skill]
---
```

**Optional fields we'll use**:
- `disable-model-invocation: false` (default - allow Claude to auto-invoke)
- `user-invocable: true` (default - show in `/` menu)

**Why**:
- Matches Anthropic specification exactly
- Enables Claude's automatic skill discovery
- Description drives when skill is loaded
- Name becomes the `/architecture-of-complexity` command

**Current Problem in SKILL.md**:
```markdown
# Architecture of Complexity Skill

**Authors:** Jérémie Lumbroso and Claude Sonnet 4.5
**License:** [CC BY-SA 4.0](...)
**Version:** 1.0 (February 2026)

**Note:** CAM framework is Copyright © Jérémie Lumbroso

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
name: architecture-of-complexity
description: Apply Herbert Simon's Architecture of Complexity principles to system design, code architecture, and UI decisions. Use for understanding hierarchical decomposition, near-decomposability, stable intermediate forms, and architectural trade-offs. Helps analyze modularity, coupling, and complexity in software systems.
---

# Architecture of Complexity Skill

**Authors:** Jérémie Lumbroso and Claude Sonnet 4.5
**License:** [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/)
**Version:** 1.0.0 (February 2026)

**Note:** The CAM (Computationally-Assisted Metacognition) framework and Third X (LLM output linearization framework) referenced herein are Copyright © Jérémie Lumbroso. This skill document itself is licensed under CC BY-SA 4.0.

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
- Users can invoke with `/architecture-of-complexity`
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
- [ ] Fix SKILL.md frontmatter - Owner: Claude Code (next task)
- [ ] Create build/packaging script - Owner: Claude Code (CI/CD task)
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

**Current status**:
- SKILL.md: 408 lines ✅ (under limit)
- Supporting files properly separated ✅

---

## Validation

- [x] Human: Decision matches Claude Code specification
- [x] AI: Understood the requirements from documentation
- [x] Verified against working example (visual-diffusion.skill)

**Notes**: This ADR establishes the foundational packaging format. Subsequent ADRs will cover versioning (ADR-0002) and licensing (ADR-0003).

---

## Iterations

### Iteration 1 (2026-02-27)
- Human: Provided extend-claude-with-skills.md documentation
- Human: Provided visual-diffusion.skill as working example
- AI: Analyzed both sources, identified current SKILL.md formatting problem
- AI: Documented correct format with specific frontmatter schema
- Outcome: Clear specification for fixing SKILL.md and packaging skill

---

## Links

- Related: ADR-0002 (Versioning Strategy) - to be created
- Related: ADR-0003 (License File Structure) - to be created
- Reference: `/docs/resources/extend-claude-with-skills.md`
- Example: `/docs/resources/visual-diffusion.skill`
