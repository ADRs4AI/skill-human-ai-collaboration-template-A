# Installing the Architecture of Complexity Skill

**Quick Start Guide**

---

## What You Have

A complete skill directory ready to install as a Claude user skill:

```
architecture-of-complexity-skill/
├── SKILL.md                      # Main skill file (8KB)
├── README.md                     # Documentation
└── resources/
    ├── simon_1962_full.txt       # Full Simon article
    └── examples/
        ├── vue-react.md          # Framework analysis
        ├── mcp-design.md         # MCP design decisions
        └── cam.md                # CAM framework
```

---

## Installation Steps

### Option 1: Install as User Skill (Recommended)

1. **Download the skill directory** from the outputs
2. **Navigate to your skills directory:**
   ```bash
   cd /path/to/your/claude/skills/user/
   ```
3. **Copy the skill:**
   ```bash
   cp -r /path/to/architecture-of-complexity-skill ./
   ```
4. **Verify installation:**
   ```bash
   ls -la architecture-of-complexity-skill/
   ```

The skill should now be available in your Claude interface under user skills.

### Option 2: Keep as Reference

If you prefer to keep it as a reference without installing:

1. Download the directory to your preferred location
2. Reference files as needed in your conversations
3. Upload `SKILL.md` when doing architectural work

---

## How to Use

### Automatic Triggering

Once installed, Claude will automatically use this skill when:
- Discussing framework choices
- Making architectural decisions
- Analyzing system design
- Teaching modularity concepts
- Evaluating coupling and cohesion

### Manual Invocation

You can also explicitly request:
- "Use the Architecture of Complexity skill to analyze this design"
- "Apply Simon's principles to this framework choice"
- "Show me the near-decomposability of this architecture"

### Examples to Try

**Framework comparison:**
> "Should I use Vue or React for my new project? I need good modularity and want to minimize cognitive load."

**API design:**
> "How should I structure the boundary between my frontend and backend? I want to avoid tight coupling."

**Code organization:**
> "My codebase feels messy. How do I know when to split things into separate modules?"

**Educational design:**
> "I'm teaching a complex topic. How should I structure the learning path?"

---

## What Claude Will Do

When this skill is triggered, Claude will:

1. **Load SKILL.md** (~8KB) automatically
2. **Apply the decision framework** to your question
3. **Reference examples** when relevant (vue-react.md, etc.)
4. **Escalate to full article** if needed for theoretical depth
5. **Provide actionable guidance** based on Simon's principles

---

## Skill Description

You can add this description to the skill if installing manually:

**Name:** Architecture of Complexity

**Description:** Apply Herbert Simon's Architecture of Complexity principles to system design, code architecture, UI decisions, and pedagogical frameworks. Use for understanding hierarchical decomposition, near-decomposability, stable intermediate forms, and process vs. state descriptions. Covers framework selection, API design, module organization, and educational system design.

**Triggers:** 
- Framework choice questions
- Architectural decision-making
- System design analysis
- Modularity evaluation
- Coupling and cohesion discussions
- Educational structure design

---

## Testing the Installation

Try this query after installation:

> "I'm choosing between two frameworks. One mixes HTML/JS/CSS together, the other separates them into distinct sections. Which is better architecturally and why?"

Expected response:
- Claude loads the Architecture of Complexity skill
- Applies near-decomposability test
- References Vue/React example
- Provides clear reasoning based on Simon's principles

---

## File Sizes

- `SKILL.md`: ~8KB (lightweight, always loaded)
- `README.md`: ~4KB (documentation)
- `simon_1962_full.txt`: ~50KB (loaded on demand)
- Examples: ~2-3KB each (loaded when relevant)
- **Total:** ~70KB

---

## Updating the Skill

This skill is versioned and can be updated:

**Current version:** 1.0 (February 2026)

**To update:**
1. Replace the skill directory with new version
2. Check `README.md` for version history
3. Review any new examples or improvements

---

## License & Attribution

**Skill license:** CC BY-SA 4.0  
**Authors:** Jérémie Lumbroso and Claude Sonnet 4.5  
**CAM Framework:** Copyright © Jérémie Lumbroso

When sharing derivatives:
- Attribute original authors
- Use same CC BY-SA 4.0 license
- Note that CAM framework has separate copyright

---

## Support

**For questions about:**
- **Theoretical concepts:** See `resources/simon_1962_full.txt`
- **Practical applications:** See `resources/examples/`
- **Quick reference:** See `SKILL.md`

**For issues or improvements:**
- This is a living document
- Contributions welcome
- Follow CC BY-SA 4.0 license

---

**Created:** February 2026  
**Authors:** Jérémie Lumbroso and Claude Sonnet 4.5  
**License:** CC BY-SA 4.0

Enjoy making better architectural decisions! 🎯
