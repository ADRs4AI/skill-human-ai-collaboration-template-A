# Resources Directory

This directory contains reference materials for building the Architecture of Complexity skill.

## Contents

### 📚 Skill Documentation

- **[extend-claude-with-skills.md](extend-claude-with-skills.md)** - Official Anthropic documentation for Claude Code skills
  - Frontmatter schema (YAML between `---` markers)
  - ZIP packaging format
  - Skill invocation patterns
  - Supporting files structure
  - **KEY**: This is the canonical reference for skill format

- **[agentskills/](agentskills/)** - Full Agent Skills standard specification
  - Open standard that Claude Code extends
  - Comprehensive but possibly overkill for our needs
  - Use extend-claude-with-skills.md for Claude-specific details

### 🔍 LLM Documentation Indices

- **[claude-ai-llms-docs-index.md](claude-ai-llms-docs-index.md)** - Index of Claude Web documentation
- **[claude-code-llms-docs-index.md](claude-code-llms-docs-index.md)** - Index of Claude Code documentation

### 🛠️ CI/CD Reference

- **[sample-ci-cd.yaml](sample-ci-cd.yaml)** - Example GitHub Actions workflow from a Ghost theme project
  - **NOT our vision** but shows useful patterns:
  - GITHUB_STEP_SUMMARY usage for rich output
  - Concurrency control
  - Multi-job validation + build + release workflow
  - Conditional execution (tags vs branches)
  - Extract patterns, not logic

### 📦 Example Skills

- **[visual-diffusion.skill](visual-diffusion.skill)** - Complete packaged skill (ZIP format)
  - Created by Jérémie + Claude Web Sonnet 4.5
  - Shows proper structure and packaging
  - **Unpacked version**: [visual-diffusion-unpacked/](visual-diffusion-unpacked/)

- **[skills/](skills/)** - Official Anthropic skills repository
  - **CRITICAL**: Shows that LICENSE files ARE included in skill directories
  - Each skill has LICENSE.txt in its directory (included in ZIP)
  - Frontmatter includes `license:` field pointing to LICENSE file
  - See [skills/skills/algorithmic-art/](skills/skills/algorithmic-art/) for example
  - THIRD_PARTY_NOTICES.md is separate (for third-party dependencies)

Study these to understand:
- Frontmatter format (including `license:` field)
- Directory structure
- LICENSE file placement (**inside** skill directory, not repo root)
- Supporting files organization
- ZIP packaging

### 📄 Original Paper

- **[simon 1962 architecture.pdf](simon%201962%20architecture.pdf)** - Herbert Simon's original paper
  - Full text also in `../architecture-of-complexity-skill/resources/simon_1962_full.txt`

## Quick Navigation

### Building the Skill

1. **Understand format**: Read [extend-claude-with-skills.md](extend-claude-with-skills.md)
2. **See example**: Examine [visual-diffusion-unpacked/](visual-diffusion-unpacked/)
3. **Build CI/CD**: Reference patterns from [sample-ci-cd.yaml](sample-ci-cd.yaml)

### License Information

- **Skill content**: CC BY-SA 4.0
- **CAM framework**: Copyright © Jérémie Lumbroso
- **Third X framework** (LLM output linearization): Copyright © Jérémie Lumbroso
  - Explained in `../../architecture-of-complexity-skill/resources/examples/mcp-design.md`

## Notes

- **LICENSE files belong IN the skill directory** (not repo root) - see ADR-0004
  - Initially non-intuitive, but confirmed by official Anthropic skills
  - LICENSE files are included in the .skill ZIP for legal distribution
  - They're NOT loaded into Claude's context (not referenced in SKILL.md body)
  - Frontmatter `license:` field points to them for user reference

- The visual-diffusion skill and official Anthropic skills serve as reference implementations
- Always prefer extend-claude-with-skills.md over agentskills/ for Claude-specific details
- Third X (thirdx.design) is the framework for LLM output linearization
- GITHUB_STEP_SUMMARY is the secret sauce for beautiful CI/CD output

---

**Last Updated**: 2026-02-27
**Maintainer**: Jérémie Lumbroso and Claude Code Sonnet 4.5