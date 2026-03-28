# ADR-0009: Template Transformation Strategy

- **Date**: 2026-03-28
- **Iteration**: 1
- **Status**: Draft
- **Deciders**: Jérémie Lumbroso, Claude Code Sonnet 4.5

---

## Quick Reference

**Navigation codes** (for grep):
- `QST:` Questions
- `ANS:` Answers
- `COD:` Code examples
- `FIL:` Files to examine
- `DOC:` Documentation
- `NOT:` Notes, observations

---

## AI Interpretation

**What I understand you're asking**:

This repository was cloned from `epistemic-arc-mapping-skill` and needs to become a **general template** for building Claude skills. The transformation involves:

1. **Cleaning artifacts** - Remove skill-specific content while preserving useful structure
2. **Generalizing documentation** - Transform README from epistemic-specific to template-explaining
3. **Creating guidance** - Build `CLAUDE.template.md` to help future skill builders
4. **Preserving decisions** - Keep ADRs about generic skill packaging/structure

**Assumptions I'm making**:
- The existing ADRs about packaging (0001), versioning (0002), licensing (0003-0004), and structure (0006) are valuable for template users
- The collaborative workflow (ADR templates, navigation codes) should stay
- The architecture-of-complexity companion skill is useful for template users
- Version should reset to v0.1.0 for the template (separate from epistemic skill versioning)

---

## Questions

### QST: What to do with the epistemic-arc-mapping skill directory?
- Status: unanswered
- Why asking: This determines whether template includes worked examples or just documentation
- Need: Decision on one of three options

**Options:**
- **A: Delete entirely** - It has its own repo, template should be clean slate
- **B: Move to `examples/epistemic-arc-mapping/`** - Shows what a complete skill looks like
- **C: Separate branch** - Keep git history but not in main template

**ANS:** (by Jérémie)
[Fill this in]

---

### QST: How much scaffolding to provide in the template?
- Status: unanswered
- Why asking: Affects usability vs. clutter trade-off
- Need: Decision on scaffolding level

**Options:**
- **Minimal**: Just docs explaining structure, users create files themselves
- **Medium**: `your-skill-name/` directory with placeholder SKILL.md, README.md
- **Maximal**: Script that generates skeleton + prompts for metadata

**ANS:** (by Jérémie)
[Fill this in]

---

### QST: How to handle ADR-0006 (skill structure)?
- Status: unanswered
- Why asking: It's valuable but uses epistemic examples throughout
- Need: Decision on generalization approach

**Options:**
- **A: Keep as-is** with note: "This ADR uses epistemic-arc-mapping as example"
- **B: Rewrite generically** - Remove specific examples, talk about skill structure abstractly
- **C: Create new ADR-0010** - "How to use this template" and keep 0006 as historical example

**ANS:** (by Jérémie)
[Fill this in]

---

### QST: Should we version the template separately?
- Status: unanswered
- Why asking: Template evolves independently from any skill built with it
- Need: yes/no + versioning scheme if yes

**Current state**: epistemic skill is v0.1.0
**Template question**: Start at v1.0.0 (it's complete workflow) or v0.1.0 (it's new)?

**ANS:** (by Jérémie)
[Fill this in]

---

## Files to Transform

### FIL: Core documentation
- `README.md` - Currently 100% epistemic-specific → Rewrite as template explanation
- `CLAUDE.md` - Has workflow but epistemic context → Becomes `CLAUDE.template.md` + generic `CLAUDE.md` for template repo itself

### FIL: Skill directory
- `epistemic-arc-mapping/` - Contains SKILL.md, README.md, LICENSE, resources/ → Decision needed (QST above)

### FIL: ADRs to review
- `0001-skill-packaging-format.md` - ✅ Generic, keep as-is
- `0002-versioning-strategy.md` - ✅ Generic, keep as-is
- `0003-license-file-structure.md` - ✅ Generic, keep as-is
- `0004-license-files-in-skill-directory.md` - ✅ Generic, keep as-is
- `0005-skill-consumer-context.md` - ✅ Generic, keep as-is
- `0006-skill-structure-architecture-of-complexity.md` - ⚠️ Has epistemic examples, needs decision
- `0008-nested-git-repos-handling.md` - ✅ Generic, keep as-is

### FIL: Infrastructure to keep
- `.claude/skills/architecture-of-complexity/` - ✅ Useful for template users
- `docs/adr/templates/` - ✅ Core workflow
- `.github/workflows/` - ✅ Can be adapted for any skill
- `scripts/ephemeral/` - ✅ Pattern to keep

---

## NOT: Observations

### What makes this template valuable

1. **Proven workflow** - The ADR-based collaboration has been tested on real skill development
2. **Architecture principles** - Companion skill helps users structure skills hierarchically
3. **Complete build pipeline** - GitHub Actions for packaging/releasing
4. **Licensing clarity** - Decisions about CC BY-SA 4.0, LICENSE files, attribution

### What's unique about this template

Unlike generic project templates, this one embodies a **human-AI collaboration methodology**:
- Prime Directive: Commit discussions to ADRs immediately
- Secondary Directive: Surface doubts (they're generative)
- Navigation codes for grepping decisions
- Iteration tracking in ADRs
- Ephemeral scripts with timestamps

This isn't just "how to package a skill" - it's "how to co-create a skill with Claude."

---

## Decision

### [To be filled after human answers]

---

## Action Items

- [ ] Answer QST questions above - Owner: Jérémie
- [ ] Implement transformation based on answers - Owner: Claude Code
- [ ] Create new README.md - Owner: Claude Code
- [ ] Create CLAUDE.template.md - Owner: Claude Code
- [ ] Update/generalize ADRs as decided - Owner: Claude Code
- [ ] Test template usability - Owner: Both

---

## Validation

When we both agree:
- [ ] Human: Transformation strategy captured correctly
- [ ] AI: Understood the requirements

**Notes**: This is the foundational decision for converting the repository. All subsequent work depends on answering the QST questions above.

---

## Iterations

### Iteration 1 (2026-03-28)
- Human: Asked if I understand the project and what needs to be done
- AI: Explored repository structure, identified transformation needed, surfaced doubts as generative questions
- Outcome: Created this ADR to capture decision points before proceeding

---

## Links

- Related: All existing ADRs (0001-0008) inform this transformation
- Output: Will generate new README.md, CLAUDE.template.md based on decisions
