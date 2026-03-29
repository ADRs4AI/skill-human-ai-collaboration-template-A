# ADR Audit Plan
**Date**: 2026-03-29
**Purpose**: Clean up ADRs for template transformation per ADR-0009

---

## Current ADRs (9 files)

| # | Title | Decision | Template Relevance |
|---|---|---|---|
| 0001 | Skill Packaging Format | ZIP+frontmatter+structure | **REWRITE** - Remove AoC-specific refs, make generic |
| 0002 | Versioning Strategy | SemVer for skills | **REWRITE** - Remove AoC examples, generic principles |
| 0003 | License File Structure | Multiple licenses (CAM/ThirdX) | **DELETE** - AoC/CAM/ThirdX specific, not generic |
| 0004 | LICENSE in Skill Directory | Yes, following Anthropic pattern | **KEEP** - Already generic, minor edits |
| 0005 | Skill Consumer Context | Claude Web vs Code | **REWRITE** - Remove epistemic refs, keep Web/Code principles |
| 0006 | Skill Structure (AoC) | Hierarchical with resources/ | **REWRITE** - Keep AoC principles, remove epistemic examples |
| 0008 | Nested Git Repos | Extract + gitignore | **DELETE** - About reveal.js/playwright (removed from history) |
| 0009 | Template Transformation | This plan | **KEEP** - Current transformation work |
| 0010 | Template-Guide Skill | Meta-skill design | **KEEP** - Current work |

---

## Action Plan

### Phase 1: Delete Obsolete ADRs
- **DELETE ADR-0003**: License structure for AoC/CAM/ThirdX (not generic)
- **DELETE ADR-0008**: Nested repos (reveal.js/playwright removed from history)

### Phase 2: Rewrite ADRs Generically
- **REWRITE ADR-0001**: Make packaging format generic (remove "Architecture of Complexity" mentions)
- **REWRITE ADR-0002**: Make versioning generic (remove AoC-specific increment examples)
- **REWRITE ADR-0005**: Generic Claude Web vs Code principles (remove epistemic arc mapping specifics)
- **REWRITE ADR-0006**: Generic skill structure using AoC (remove epistemic examples, keep AoC framework)

### Phase 3: Minor Edits
- **EDIT ADR-0004**: Already mostly generic, just verify no skill-specific language

### Phase 4: Renumber Contiguously
After deletions, renumber:
- 0001 → 0001 (rewritten)
- 0002 → 0002 (rewritten)
- 0004 → 0003 (edited, was 0004)
- 0005 → 0004 (rewritten, was 0005)
- 0006 → 0005 (rewritten, was 0006)
- 0009 → 0006 (kept, was 0009)
- 0010 → 0007 (kept, was 0010)

**Final count**: 7 ADRs (down from 9)

---

## Key Principles for Rewrites

1. **Remove all skill-specific examples**: No Architecture of Complexity, no epistemic arc mapping, no reveal.js
2. **Keep generic principles**: ZIP format, frontmatter schema, LICENSE placement, Web vs Code trade-offs, AoC framework
3. **Use placeholder language**: "your-skill", "example-skill", generic use cases
4. **Preserve decisions**: The choices (SemVer, ZIP, etc.) stay the same, just contextualized generically
5. **Keep iteration history**: Show the ADR evolution, note when rewrite happened for template

---

## Verification Checklist

After cleanup:
- [ ] No mentions of specific skills (AoC, epistemic, reveal.js) except in historical notes
- [ ] All ADRs numbered contiguously (0001-0007)
- [ ] Filenames match titles
- [ ] Navigation codes preserved (QST:, ANS:, etc.)
- [ ] Decisions still clear and actionable for template users
- [ ] Git history shows transformation (commits for deletions, rewrites, renumbering)

---

## Estimated Work

- Delete 2 ADRs: 5 min
- Rewrite 4 ADRs: 40 min (10 min each)
- Edit 1 ADR: 5 min
- Renumber 7 ADRs: 15 min
- **Total**: ~65 min

---

**Next step**: Present this plan to Jérémie for approval before execution.
