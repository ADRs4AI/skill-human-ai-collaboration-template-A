# Your Skill Name

Brief tagline describing what your skill does.

- **Authors:** [Your Name] and Claude [Model Version]
- **Version:** 0.1.0
- **License:** [CC BY-SA 4.0, MIT, Apache 2.0, etc.]
- **Created:** [Date]

---

## What It Does

[2-3 sentence description of what the skill provides and who it's for]

---

## Quick Start

### Install the Skill

```bash
# Download from releases
# https://github.com/[your-username]/[your-skill-repo]/releases

# Unzip to Claude skills directory
unzip your-skill-name-0.1.0.skill -d ~/.claude/skills/your-skill-name/
```

Or reference manually in your project's `CLAUDE.md`:
```markdown
Load the [your skill name] skill from `.claude/skills/your-skill-name/SKILL.md`.
```

### Use It

The skill activates when you:
- [Trigger condition 1]
- [Trigger condition 2]
- [Trigger condition 3]

Works in **Claude Web** [or **Claude Code** - specify primary environment per ADR-0004].

---

## What's Included

### The Skill (`your-skill-name/`)

```
your-skill-name/
├── SKILL.md                      # Complete methodology (~X lines)
├── README.md                     # This file
├── LICENSE                       # License file
└── resources/                    # Optional: specialized guidance
    ├── [specialized-topic].md
    └── examples/
        └── [worked-example].md
```

**SKILL.md** is complete and self-sufficient. Resources provide depth for specialized contexts.

---

## Core Methodology

[Brief overview of your skill's approach]

### Key Concepts

1. **[Concept 1]**: [Brief explanation]
2. **[Concept 2]**: [Brief explanation]
3. **[Concept 3]**: [Brief explanation]

---

## When to Use

Use this skill when:
- [Scenario 1]
- [Scenario 2]
- [Scenario 3]

Don't use when:
- [Anti-pattern 1]
- [Anti-pattern 2]

---

## Examples

[Provide 1-2 brief examples of the skill in action]

**Example 1:**
```
[Show input/output or usage pattern]
```

**Example 2:**
```
[Show another scenario]
```

---

## Development

### Building from Source

```bash
# Clone repository
git clone https://github.com/[username]/[repo] your-skill-name
cd your-skill-name

# Make changes to SKILL.md

# Package (see repository root for build script)
cd your-skill-name
zip -r ../your-skill-name-0.1.0.skill . -x "*.git*" -x "*.DS_Store"
```

### Contributing

See [CLAUDE.md](../CLAUDE.md) for collaboration methodology.

Contributions welcome! This skill follows:
- **Prime Directive**: Commit discussions to ADRs immediately
- **Secondary Directive**: Surface doubts (they're generative)

---

## License

**Skill content:** [License Name] — [Authors]

---

## Acknowledgments

[Any acknowledgments, inspirations, or credits]

---

**Built using:** [human-ai-collaboration-template-A](https://github.com/jlumbroso/skill-human-ai-collaboration-template-A) skill-building template

**Status:** [Alpha/Beta/Stable] — [Current state description]
