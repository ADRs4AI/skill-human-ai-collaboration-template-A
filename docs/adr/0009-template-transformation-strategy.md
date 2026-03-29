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
- Status: answered
- Why asking: This determines whether template includes worked examples or just documentation
- Need: Decision on one of three options

**Options:**
- **A: Delete entirely** - It has its own repo, template should be clean slate
- **B: Move to `examples/epistemic-arc-mapping/`** - Shows what a complete skill looks like
- **C: Separate branch** - Keep git history but not in main template

**ANS:** (by Jérémie Lumbroso)
Excellent question. Option A. This skill has its own repo. In due time (once I've made the ADR4AI methodology public), the repo itself of the skill will be made public, and we can link to it as an example in the `README.md`, but for now, let's wipe the skill. In fact, what would be great is if you used `git` history filtering to remove the existing of the irrelevant files from the repo. Once this template is public it'd be great if little about the epistemic arc mapping were in the history. We cna mention it as an example in the README.md or something, but I don't think having it in the history makes sense for future users—what do you think?

---

### QST: How much scaffolding to provide in the template?
- Status: answered
- Why asking: Affects usability vs. clutter trade-off
- Need: Decision on scaffolding level

**Options:**
- **Minimal**: Just docs explaining structure, users create files themselves
- **Medium**: `your-skill-name/` directory with placeholder SKILL.md, README.md
- **Maximal**: Script that generates skeleton + prompts for metadata

**ANS:** (by Jérémie Lumbroso)
I would say Medium + Maximal. The documentation should be a bit user geared, but mostly LLM geared, maybe with a lot of it hidden in .claude or something. Maybe we write our local skill that explains how to use the scripts optimally. The way this should be used (at least from my point of view is), with a thinking partner like you Sonnet 4.5, the ADR4AI system, and basically the LLM takes care of all of this. Anything we can do to standardize and prechew the work for LLMs is I think something that will help them be responsive to higher order goals of their human. Thoughts on this?

---

### QST: How to handle ADR-0006 (skill structure)?
- Status: answered
- Why asking: It's valuable but uses epistemic examples throughout
- Need: Decision on generalization approach

**Options:**
- **A: Keep as-is** with note: "This ADR uses epistemic-arc-mapping as example"
- **B: Rewrite generically** - Remove specific examples, talk about skill structure abstractly
- **C: Create new ADR-0010** - "How to use this template" and keep 0006 as historical example

**ANS:** (by Jérémie Lumbroso)
Option B: Rewrite generically. Feel free to extend this policy more broadly:
(a) Delete ADRs no longer relevant to this project
(b) Rewrite ADRs partially relevant to this project
(c) At the end, renumber the ADRs contiguously, including the titles
I appreciate the idea of historical example, but for now, I would like this template to be totally agnostic. Since transformers would absorbing the content, I don't want to bias other people's transformers according to my worldview. The epistemic arc mapping is... subversive. Maybe that's a good thing? But right now I want to focus on improving the relationship between humans and transformers, and I don't want to be distracted from that agenda. Skill-building is something that makes the relationship between humans and transformers better. Why? Because humans are low-fidelity entities, they don't explain themselves well, or fully, with all context, and so that leads to transformers having to scaffold many decisions that later turn out to be something the human wish they had specified, but they blame the transformer for mind-reading incorrectly. Not all hallucinations are the result of this, but many are. So skills are a way for humans to focus on specifying a process, on creating what my colleague and friend Eric Wong calls a "superprompt" that has been iterated and refined over time to correct any specification error.

---

### QST: Should we version the template separately?
- Status: unanswered
- Why asking: Template evolves independently from any skill built with it
- Need: yes/no + versioning scheme if yes

**Current state**: epistemic skill is v0.1.0
**Template question**: Start at v1.0.0 (it's complete workflow) or v0.1.0 (it's new)?

**ANS:** (by Jérémie)
Yes, I would say that we should definitely version these things differently. This template should definitely be versioned separately from any skill that it is related to. In terms of the versioning scheme: I am not completely sure. I am not sure I would know how to create a versioning scheme that makes sense for something like a transformer skill. In thinking of SemVer, I am not sure I could identify what is a breaking change vs a patch, etc.. Perhaps what makes sense then is a timestamp/release date based versioning scheme perhaps? It's worth noting that the `https://github.com/jlumbroso/human-ai-collaboration-template-A` has a versioning scheme that is a bit ad-hoc, and currently at v3.2. It seems, even though this template is based in part on that one (and I will backport changes) that we are creating a different versioning. I may also elect to use the same versioning scheme with the `human-ai-collaboration-template-A`. Maybe we can mention which version of that template this one is pegged at.

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
