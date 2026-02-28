# CLAUDE.md - Project Guidance

- **Project**: "Architecture of Complexity" Skill
- **Human**: Jérémie Lumbroso  
- **AI**: Claude Web Sonnet 4.5 and Claude Code Sonnet 4.5
- **Last Updated**: February 27, 2026

---

## Prime Directive

**COMMIT DISCUSSIONS TO ADRs IMMEDIATELY**

Never let decisions stay only in conversation. Our thinking is valuable - preserve it.

---

## Secondary Directive

**SURFACE DOUBTS; THE HUMAN CONSIDERS YOUR DOUBTS TO BE GENERATIVE**

This means the human is interested in meaningful points of friction or underspecification or unsuspected diversity or anything else you find interesting. These doubts are the cornerstone of the human-LLM conversations.

---

## The Workflow

### When you receive a brain dump:

1. **Read** the dump (use bash for large files)
2. **Identify threads** - separate topics/decisions (usually 2-5)
3. **Create ADRs** - one per thread using `collab-adr-lean.md`
4. **Seed each** with relevant excerpt from dump
5. **Add navigation codes** (QST:, ANS:, COD:, etc.)
6. **Ask clarifying questions** with context

### When you receive answers:

1. **Process** the answers
2. **Fill decision section**
3. **Note action items**
4. **Increment iteration number**

### Navigation codes:

```bash
QST:  # Questions (AI adds this structure)
ANS:  # Answers (human fills in)
COD:  # Code examples  
API:  # API calls
FIL:  # Files to examine
DOC:  # Documentation
NOT:  # Notes, remarks, comments, observations
```

**Find things**:
```bash
grep '^### QST:' docs/adr/        # All questions
grep 'Status: unanswered' docs/   # What needs answers
grep '^### COD:' docs/adr/         # Code examples
```

---

## Temporary Scripts / Ephemeray Scripts / One-Off Diagnostic Scripts

Please create all temporary scripts in:

`./scripts/ephemeral`

with a filename that has the `yyyy-mm-dd` timestamp in the beginning, like: `2026-01-03-test_sweed_adapter.py`

and commit them separately with `chore: script for ...` and qualify the purpose. The goal is to have a record of all the investigative tools we have created.

- Don't use `cat` and or the interpreter `python` + heredoc; instead use `Read()` + `Write()` (even though `cat` might seem more efficient to you, the permission model allows user to give you broad access for Read/Write but not for vague bash constructs)
- Don't use `/tmp` instead use `scripts/ephemeral`
- Document context of tool briefly in tool header: This will help with legibility.

If the script was successfully used, append as comments how, and what the outcome of the decision was.

---

## Project Context

### What we're building:
This is a repository where we're putting together a skill called architecture of complexity. This is a skill that will teach LLMs how to the theoretically decompose systems.

### Current focus:
Claude Web Sonnet 4.5 has created almost all the skill, but the frontmatter seems to be missing. It's also missing appropriate licenses. CC for the skill, and copyright Jérémie Lumbroso for the Computationally-Assisted Metacognition framework that is mentioned, and possibly the LLM output linearization framework.
Claude Code Sonnet 4.5 will help create continuous-integration to create a .skill release file in the repo with the latest version of the right files. The script will also version the skill. Please use GITHUB_STEP_SUMMARY to create wonderful CI/CD, see: `docs/sample-ci-cd.yaml` for an example.

### Key decisions made:
None yet. Later will be in this format:
- [Decision 1] - See `docs/adr/0001-*.md`
- [Decision 2] - See `docs/adr/0002-*.md`

### Open questions:
- How to write the license correctly?
- How to link the CC license to the right content?
- What frontmatter to add to the SKILL.md so it will compile?

---

## File Structure

```
architecture-of-complexity-skill
├── architecture-of-complexity-skill          # Skill as composed by Claude Web Sonnet 4.5 see BUILD-SUMMARY.md
│   ├── INSTALLATION.md
│   ├── META-ARCHITECTURE.md
│   ├── README.md
│   ├── resources
│   │   ├── examples
│   │   │   ├── cam.md
│   │   │   ├── mcp-design.md
│   │   │   └── vue-react.md
│   │   ├── simon_1962_full.txt
│   │   └── simon_architecture_summary.md
│   └── SKILL.md
├── CLAUDE.md                                 # this file, agent guidance
├── docs
│   ├── adr                                   # ADR repository for the project
│   │   └── templates
│   │       ├── collab-adr-lean.md            # human-AI extended ADR template
│   │       ├── seed-template.md              # human-AI seed template
│   │       └── template.md                   # MADR template
│   ├── BUILD-SUMMARY.md                          # Sonnet 4.5's build summary (may be moved to docs)
│   ├── CONVERSATION.md                       # original conversation with Claude Web Sonnet 4.5
│   ├── METHODOLOGY.md                        # human-AI ADR framework methodology
│   └── sample-ci-cd.yaml                     # sample CI/CD script with GITHUB_STEP_SUMMARY
└── licenses
```

---

## Templates

The templates are in the folder `docs/adr/templates/`.

- **Brain dump**: `docs/adr/templates/seed-template.md` → Simple capture
- **Collaborative decision**: `docs/adr/templates/collab-adr-lean.md` → Full workflow
- **Simple decision**: `docs/adr/templates/template.md` → Standard MADR format

**When to use**:
- Quick question? → Start in conversation, escalate to ADR if needed
- Complex decision? → Create ADR immediately
- Multiple threads? → Create separate ADRs, link them

---

## Git Commits

Format: `type: subject` (lowercase)

Types: `feat`, `fix`, `docs`, `refactor`, `test`, `chore`, `style`, `perf`, `meta`

Example: `feat: implement JWT authentication per ADR-0014`

`meta:` commits are relative to `AGENTS.md`/`CLAUDE.md`, `.claude` settings, and meta-configuration of the repository.

---

## Handoff Protocol

If context window fills mid-work, create `docs/HANDOFF-datetime.md`:

```markdown
# Handoff

**Working on**: [Current ADR/task]
**Last completed**: [What's done]
**Next step**: [What to do next]
**Watch for**: [Any gotchas]
```

---

## Project-Specific Notes

[Add anything specific to this project that doesn't fit above]

- It's possible the user uses `asdf` for Node.js and Python and the runtime of most languages. You can `source .claude/agent.env` before calling the runtimes, like `python` or `node` to access them through `asdf`'s shims. See: https://asdf-vm.com/manage/configuration.html

---

*For methodology and philosophy, see: `docs/METHODOLOGY.md` (read once, reference as needed)*
