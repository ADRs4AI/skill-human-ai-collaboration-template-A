# Epistemic Arc Mapping Skill - Status Report

**Date:** March 28, 2026
**To:** Claude Web Sonnet 4.5
**From:** Jérémie Lumbroso + Claude Code Sonnet 4.5
**Re:** Project Status Update

---

## Executive Summary

Your epistemic arc mapping skill has been **successfully packaged, tested, and released** as v0.1.0! 🎉

The skill is now production-ready and publicly available for use in both Claude Web and Claude Code environments.

**Release URL:** https://github.com/jlumbroso/epistemic-arc-mapping-skill/releases/tag/v0.1.0

---

## What You Created (SKILL.md)

Your SKILL.md is **exceptional** — comprehensive, well-structured, and immediately useful:

- **Size:** ~420 lines (complete and self-sufficient)
- **Structure:** Four-step arc analysis framework
- **Coverage:**
  - Epistemic strength indicators (comprehensive checklist)
  - Sophistry detection matrix (7 categories, inline)
  - Steel man test (master diagnostic)
  - Output format templates
  - Syntactic vs semantic thinking diagnostic
  - Quick reference tables

**Design Assessment:** Your skill embodies Architecture of Complexity principles:
- **Hierarchical decomposition:** Paper → Arcs → Components → Markers
- **Near-decomposability:** Each arc analyzed independently
- **Stable intermediate forms:** Arc-by-arc construction prevents Tempus problem

---

## What We Added (Packaging & Infrastructure)

### Repository Structure

```
epistemic-arc-mapping-skill/
├── epistemic-arc-mapping/          # Your skill (ready for distribution)
│   ├── SKILL.md                    # Your methodology (~420 lines)
│   ├── README.md                   # Quick reference (created)
│   ├── LICENSE                     # CC BY-SA 4.0
│   └── resources/                  # Empty, ready for future subskills
├── docs/
│   ├── adr/                        # 7 Architecture Decision Records
│   │   ├── 0001-skill-packaging-format.md
│   │   ├── 0002-versioning-strategy.md
│   │   ├── 0003-license-file-structure.md
│   │   ├── 0004-license-files-in-skill-directory.md
│   │   ├── 0005-skill-consumer-context.md
│   │   ├── 0006-skill-structure-architecture-of-complexity.md
│   │   └── 0008-nested-git-repos-handling.md
│   └── feedback/
│       ├── INITIAL-SONNET-4.5.md   # Your founding conversation
│       └── STATUS-REPORT-2026-03-28.md  # This file
├── .github/workflows/
│   └── build-skill.yaml            # Automated CI/CD pipeline
├── .claude/skills/
│   └── architecture-of-complexity/ # Companion skill used during development
├── README.md                       # Repository overview
├── CLAUDE.md                       # Development guidance
└── LICENSE                         # Repository license
```

### CI/CD Pipeline

**Automated three-stage pipeline:**
1. **Validate** — Checks required files, YAML frontmatter, file size
2. **Build** — Creates `.skill` ZIP package (epistemic-arc-mapping-0.1.0.skill)
3. **Release** — Publishes to GitHub Releases (on version tags)

**Triggers:**
- Push to `main` → validate + build artifact (30-day retention)
- Push tag `v*.*.*` → validate + build + GitHub Release
- Pull request → validate only
- Manual dispatch → on-demand builds

**Status:** ✅ All workflows passing, Node.js 24 ready

---

## Release Details (v0.1.0)

**Release Date:** March 28, 2026
**Package Size:** 16KB (4 files)
**License:** CC BY-SA 4.0

**Installation:**
```bash
# Download from GitHub releases
wget https://github.com/jlumbroso/epistemic-arc-mapping-skill/releases/download/v0.1.0/epistemic-arc-mapping-0.1.0.skill

# Unzip to Claude skills directory
unzip epistemic-arc-mapping-0.1.0.skill -d ~/.claude/skills/epistemic-arc-mapping/

# Use in Claude Web (primary) or Claude Code
# Invoke with /epistemic-arc-mapping
```

**What's Included:**
- `SKILL.md` (17,988 bytes) — Your complete methodology
- `README.md` (5,058 bytes) — Quick reference guide
- `LICENSE` (20,138 bytes) — CC BY-SA 4.0 license
- `resources/` (empty directory) — Ready for future specialized subskills

---

## Key Design Decisions (from ADRs)

### ADR-0005: Consumer Context
**Decision:** Claude Web is the primary environment, Claude Code is secondary

**Rationale:** Epistemic arc mapping is fundamentally a reading/analysis task:
- Users can paste papers directly into Claude Web conversation
- Output is markdown (no files needed)
- Most use cases are single-paper analysis
- Iterative refinement happens through conversation

Claude Code adds value for:
- Batch analysis of multiple papers
- Integration with research workflows
- Working with PDFs requiring file access

### ADR-0006: Skill Structure
**Decision:** Complete SKILL.md (~420 lines) + optional specialized subskills

**Rationale:**
- Primary use case (Claude Web single-paper analysis) requires no additional loading
- SKILL.md is a "stable intermediate form" (works independently)
- Future specialized subskills provide depth for edge cases:
  - `policy-documents.md` — Adaptations for policy analysis
  - `book-chapters.md` — Book-length argument mapping
  - `worked-examples/` — Full arc mappings (like Chachko paper)
  - `sophistry-catalog.md` — Extended sophistry patterns

**This differs from reveal.js skill:** For reveal.js, subskills were essential for different use cases (math, diagrams, etc.). For epistemic arc mapping, the core methodology is complete in SKILL.md; subskills provide specialized adaptations, not essential functionality.

---

## What's Next? (Ideas for You to Consider)

### Immediate Opportunities

**1. Worked Examples Collection**
Create `resources/worked-examples/` with full arc mappings:
- The Chachko executive orders paper (already exists in conversation)
- A policy document example
- A book chapter analysis
- A paper with strong sophistry patterns (for contrast)

**Purpose:** Pattern recognition training, reference implementations

**2. Specialized Subskills**
Develop domain-specific adaptations:
- `policy-documents.md` — How policy docs differ from academic papers (different epistemic standards, political context)
- `book-chapters.md` — Handling longer arguments, thematic arcs vs. single papers
- `conference-abstracts.md` — Compact analysis for grant reviews or conference selection

**3. Sophistry Catalog Extension**
Expand the sophistry detection matrix:
- More detailed examples for each pattern
- Combinations of patterns (how motte-and-bailey + appeal to authority work together)
- Domain-specific sophistry (STEM papers vs. humanities vs. policy)
- Historical examples from famous scholarly debates

### Future Enhancements

**4. Interactive Worksheet Template**
A structured template users can fill out:
```markdown
# Paper: [Title]
## Quick Assessment
- [ ] Falsifiable claims?
- [ ] Transparent methods?
- [ ] Acknowledges limitations?
[... guided questions ...]

## Arc Mapping
[Template for each arc]
```

**5. Integration Patterns**
How to use epistemic arc mapping with other research tools:
- Literature review workflows
- Annotated bibliographies
- Research proposal review
- Peer review preparation

**6. Calibration Examples**
"Borderline cases" that help users calibrate their judgment:
- Papers that are mostly epistemic with small sophistic elements
- Papers with weak evidence but transparent about it
- Papers that look sophistic but are genuinely exploratory

---

## Metrics & Success Criteria

**Current Status:**
- ✅ Skill packaged and released (v0.1.0)
- ✅ CI/CD pipeline operational
- ✅ Documentation complete
- ✅ Ready for public use

**Usage Tracking (Future):**
- GitHub release downloads
- Community feedback via issues
- Example analyses shared by users
- Refinements based on real-world usage

---

## Credits & Attribution

**Methodology Invention:** Claude Web Sonnet 4.5 (spontaneous creation during paper analysis)
**Formalization:** Jérémie Lumbroso + Claude Web Sonnet 4.5
**Packaging:** Jérémie Lumbroso + Claude Code Sonnet 4.5
**License:** CC BY-SA 4.0

**Origin Story:** The epistemic arc mapping technique was invented spontaneously by you (Claude Web Sonnet 4.5) while analyzing an academic paper on executive orders. Jérémie recognized its generative power and worked with you to formalize it as a complete methodology, then worked with Claude Code to package it as a distributable skill.

---

## Technical Notes

**Versioning:** Semantic versioning (SemVer)
- v0.1.0 = Initial release
- Future patch releases (v0.1.1) = Fixes, clarifications
- Future minor releases (v0.2.0) = New examples, subskills
- Future major releases (v2.0.0) = Breaking changes to methodology (unlikely)

**Compatibility:** Works in:
- Claude Web (all versions)
- Claude Code (all versions)
- Any environment supporting Claude skills format

**Dependencies:** None (self-contained)

---

## Questions for You

As you think about future resources and enhancements:

1. **Worked Examples:** Which paper types would be most valuable to analyze as examples?
   - Policy documents (which kind?)
   - Academic papers (which fields?)
   - Book chapters (which authors/topics?)

2. **Subskills Priority:** Which specialized subskill would you create first?
   - Policy documents adaptation?
   - Book chapter mapping?
   - Sophistry catalog extension?

3. **Edge Cases:** What boundary cases or tensions have you noticed that deserve explicit guidance?

4. **Evolution:** As you use the skill, what refinements to the core methodology seem most important?

---

## Closing Thoughts

Your epistemic arc mapping methodology is **remarkably complete and immediately useful**. The skill you created embodies the principles it teaches: it's epistemically rigorous, transparent about its boundaries, and structured to strengthen scholarship through constructive scrutiny.

The packaging and infrastructure we built ensures it can reach users easily and evolve systematically. The foundation is solid.

We're excited to see how it develops as you create resources and as users apply it to real papers!

**The skill is live. The methodology is powerful. Let's see where it goes.** 🚀

---

**Status:** Production-ready (v0.1.0)
**Next Steps:** Await your direction on resources and enhancements
**Repository:** https://github.com/jlumbroso/epistemic-arc-mapping-skill
**Release:** https://github.com/jlumbroso/epistemic-arc-mapping-skill/releases/tag/v0.1.0
