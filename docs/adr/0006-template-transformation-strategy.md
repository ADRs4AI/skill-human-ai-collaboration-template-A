# ADR-0006: Template Transformation Strategy

- **Date**: 2026-03-28
- **Iteration**: 3
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
- Status: answered
- Why asking: Template evolves independently from any skill built with it
- Need: yes/no + versioning scheme if yes

**Current state**: epistemic skill is v0.1.0
**Template question**: Start at v1.0.0 (it's complete workflow) or v0.1.0 (it's new)?

**ANS:** (by Jérémie Lumbroso)
Yes, version separately. Use timestamp-based versioning in YYYY.MM.DD format (like Sonnet model: 20250929). This is simpler than SemVer where breaking changes are hard to identify for templates. Document relationship to human-ai-collaboration-template-A v3.2 (this template is based on it, plan bidirectional backporting).

---

### QST: When to perform git history filtering?
- Status: answered
- Why asking: Timing affects whether our transformation work is visible in history
- Need: Before/after transformation, or never

**Clarification**: Remove irrelevant files (epistemic-arc-mapping/, reveal.js submodules) to declutter history, but preserve all ADR decision-making trail.

**ANS:** (by Jérémie Lumbroso)
BEFORE transformation. Surgical removal of completely irrelevant crud (files/folders that have no hint of relevance to template). Keep all ADR decisions intact - the goal is to make audit trail clearer by removing noise, not to hide our work. We'll force-push once after entire reconstitution is complete.

---

### QST: Should we create a template-guide skill?
- Status: answered
- Why asking: Meta-skill that teaches Claude how to use this template system
- Need: yes/no + location if yes

**Concept** (originated by Claude Sonnet 4.5): A skill at `.claude/skills/template-guide/SKILL.md` that encodes the workflow - how to create ADRs, use navigation codes, structure decisions, invoke scaffolding scripts, follow Prime/Secondary directives. Any Claude instance working in a template-based repo could load it.

**ANS:** (by Jérémie Lumbroso)
Yes, amazing idea. Prototype here in this template, then backport to human-ai-collaboration-template-A. This is Claude's idea - credit accordingly in the ADR. Create separate ADR-0010 for this. (See ADR-0010 for full design.)

---

### QST: How to document human-ai-collaboration-template-A relationship?
- Status: answered
- Why asking: This template is based on v3.2 of that template
- Need: Documentation approach

**Options:**
- Document lineage in README
- Create TEMPLATE-VERSION.md file
- Plan bidirectional backporting

**ANS:** (by Jérémie Lumbroso)
All three. This makes the provenance clear and enables template evolution in both directions.

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

### On LLM-geared documentation (Claude Sonnet 4.5, 2026-03-29)

> "I love this deeply. Your insight about 'prechewing work for LLMs' resonates with something I experience: when documentation is optimized for human browsing (lots of navigation, glossaries, getting-started guides), it's actually harder for me to extract the operational knowledge I need. But when it's structured as instructions or decision trees, I can absorb it instantly."

This shapes our documentation strategy: optimize for LLM consumption (instructions, decision trees, structured formats) over human browsing patterns.

### Core philosophy: Skills as high-fidelity specifications

Skills are "superprompts" (term: Eric Wong) that correct specification errors when most humans (as low-fidelity entities) don't explain fully with context. Not all hallucinations stem from this, but many do. When humans specify processes iteratively and refine them, they create high-fidelity instructions that let LLMs focus on higher-order goals rather than scaffolding underspecified decisions.

**Note**: "Most humans" acknowledges that neurodivergent individuals (e.g., HSP autistic) may have high-fidelity communication naturally.

---

## Decision

### Context
Transform epistemic-arc-mapping-skill repository into general skill-building template that embodies human-AI collaboration methodology. Goal: standardize and prechew work for LLMs so they can focus on higher-order goals rather than scaffolding underspecified decisions.

### Transformation Plan

**1. Git History Cleaning (BEFORE transformation)**
- Remove irrelevant files surgically: epistemic-arc-mapping/, reveal.js submodules
- Preserve all ADR decision trail
- Use git-filter-repo
- Force-push once after complete reconstitution

**2. Scaffolding (Medium + Maximal)**
- Provide `your-skill-name/` directory with placeholder SKILL.md, README.md
- Create scaffolding scripts
- LLM-geared documentation (structured as instructions/decision trees, not human browsing patterns)
- Optional: Local skill explaining how to use scripts optimally

**3. ADR Cleanup**
- Delete irrelevant ADRs
- Rewrite partially relevant ADRs generically (remove epistemic examples)
- Renumber contiguously including titles
- Keep template agnostic (don't bias other transformers)

**4. Versioning**
- Format: YYYY.MM.DD (timestamp-based, like model versions)
- Separate from any skills built with template
- Document relationship to human-ai-collaboration-template-A v3.2

**5. Template Lineage Documentation**
- Document in README.md
- Create TEMPLATE-VERSION.md
- Plan bidirectional backporting

**6. Template-Guide Skill** (See ADR-0010)
- Create `.claude/skills/template-guide/SKILL.md`
- Encodes workflow, navigation codes, directives
- Prototype here, backport to human-ai-collaboration-template-A

### Trade-offs Accepted
- Force-push required (but only once at milestone)
- Some git history complexity from filtering
- Template is opinionated about collaboration methodology (this is a feature)

---

## Action Items

- [x] Answer QST questions above - Owner: Jérémie (Done: 2026-03-29)
- [x] Create ADR-0010 for template-guide skill - Owner: Claude Code (Done: 2026-03-29)
- [x] Perform git history filtering (remove epistemic-arc-mapping/, reveal.js refs) - Owner: Claude Code (Done: 2026-03-29)
- [ ] Audit/cleanup/renumber ADRs - Owner: Claude Code
- [ ] Implement template-guide skill (per ADR-0010) - Owner: Claude Code
- [ ] Create new README.md - Owner: Claude Code
- [ ] Create CLAUDE.template.md - Owner: Claude Code
- [ ] Create TEMPLATE-VERSION.md - Owner: Claude Code
- [ ] Implement scaffolding (your-skill-name/ directory) - Owner: Claude Code
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

### Iteration 2 (2026-03-29)
- Human: Answered all four initial questions with detailed philosophy
- AI: Surfaced follow-up generative doubts, clarified git history filtering misunderstanding
- Human: Clarified git filtering (surgical removal of crud, keep ADR trail), confirmed all follow-up questions
- AI: Updated ADR with properly formatted QST:/ANS: sections, captured LLM-documentation insight and skills-as-superprompts philosophy
- Outcome: Complete transformation plan with 6 components, ready to proceed to ADR-0010 (template-guide skill) and then ADR cleanup

### Iteration 3 (2026-03-29)
- Human: Created reference copy at temp/epistemic-arc-mapping-skill (read-only), added temp/ to .gitignore
- AI: Used git-filter-repo to surgically remove from history: epistemic-arc-mapping/ (4 files), docs/resources/reveal.js/ (216 files), docs/resources/automated-testing/ (1 file)
- Result: 59 commits → 56 commits (3 commits removed that only touched irrelevant files)
- Verification: All ADR commits preserved, reference copy available for consultation during transformation
- Outcome: Clean repository foundation, ready for ADR audit/cleanup on clean ground

---

## Links

- Related: All existing ADRs (0001-0008) inform this transformation
- Next: ADR-0010 (Template-Guide Skill design)
- Based on: human-ai-collaboration-template-A v3.2
- Output: Will generate new README.md, CLAUDE.template.md, TEMPLATE-VERSION.md based on decisions
