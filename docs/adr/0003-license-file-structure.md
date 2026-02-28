# ADR-0003: License File Structure

- **Date**: 2026-02-27
- **Iteration**: 1
- **Status**: Accepted
- **Deciders**: Jérémie Lumbroso, Claude Code Sonnet 4.5

---

## Context

This project has multiple copyright holders and licenses that need clear separation:

1. **Skill content** (SKILL.md, examples, documentation): CC BY-SA 4.0
2. **CAM framework** (Computationally-Assisted Metacognition): Copyright © Jérémie Lumbroso
3. **Third X framework** (LLM output linearization): Copyright © Jérémie Lumbroso

From CLAUDE.md:
> CC for the skill, and copyright Jérémie Lumbroso for the Computationally-Assisted Metacognition framework that is mentioned, and possibly the LLM output linearization framework.

From conversation:
> **Jérémie**: "And then the LLM output linearization framework it's in the MCP design example. [...] And yes, keep a separate license-scale.md and license-cam and mx, I guess, or ax or third x is really what we call it. Third X, exactly like that. T-H-I-R-D-X and I have a website thirdx.design."

---

## Decision

### File Structure

```
architecture-of-complexity-skill/
├── LICENSE                          # Main license (CC BY-SA 4.0) for skill
├── LICENSE-CAM.md                   # CAM framework copyright notice
├── LICENSE-THIRDX.md                # Third X framework copyright notice
└── licenses/
    └── legalcode.txt                # Full CC BY-SA 4.0 legal text
```

**Rationale**:
- `LICENSE` (no extension) is Git/GitHub convention for main license
- Separate `-CAM` and `-THIRDX` files clearly delineate ownership
- Full legalcode in `licenses/` directory for reference
- This structure is included in the `.skill` ZIP file

---

## License Details

### 1. Skill Content (CC BY-SA 4.0)

**Applies to**:
- `SKILL.md` - Main skill instructions
- `README.md` - Documentation
- `INSTALLATION.md` - Setup guide
- `META-ARCHITECTURE.md` - Design analysis
- `resources/examples/vue-react.md` - Framework comparison
- `resources/examples/mcp-design.md` - MCP design (structure, not framework itself)
- `resources/examples/cam.md` - CAM analysis (description, not framework itself)
- `resources/simon_1962_full.txt` - Full paper (educational use)
- `resources/simon_architecture_summary.md` - Summary

**Authors**: Jérémie Lumbroso and Claude Sonnet 4.5

**License**: [Creative Commons Attribution-ShareAlike 4.0 International](https://creativecommons.org/licenses/by-sa/4.0/)

**Permissions**:
- ✅ Share and adapt freely
- ✅ Commercial use allowed
- **Must**: Attribute authors (Jérémie Lumbroso and Claude Sonnet 4.5)
- **Must**: Use same CC BY-SA 4.0 license for derivatives

**LICENSE file content**:
```markdown
# Architecture of Complexity Skill - License

Copyright © 2026 Jérémie Lumbroso and Claude Sonnet 4.5

This work is licensed under the Creative Commons Attribution-ShareAlike 4.0
International License.

## What This Covers

This license applies to:
- The skill documentation and instructions (SKILL.md)
- All supporting documentation (README.md, INSTALLATION.md, META-ARCHITECTURE.md)
- Example analyses (resources/examples/*.md)
- Summary materials

## What This Does NOT Cover

- CAM (Computationally-Assisted Metacognition) framework - see LICENSE-CAM.md
- Third X (LLM output linearization) framework - see LICENSE-THIRDX.md
- Herbert Simon's original work (cited for educational purposes)

## Terms

You are free to:
- Share — copy and redistribute the material in any medium or format
- Adapt — remix, transform, and build upon the material for any purpose,
  even commercially

Under the following terms:
- Attribution — You must give appropriate credit, provide a link to the
  license, and indicate if changes were made
- ShareAlike — If you remix, transform, or build upon the material, you
  must distribute your contributions under the same license

## Full License Text

For the complete legal text, see:
- licenses/legalcode.txt (included in this distribution)
- https://creativecommons.org/licenses/by-sa/4.0/legalcode

## Attribution

When using or adapting this work, please attribute as follows:

"Architecture of Complexity Skill" by Jérémie Lumbroso and Claude Sonnet 4.5,
licensed under CC BY-SA 4.0. Available at: [repository URL]
```

---

### 2. CAM Framework (Copyright)

**What it is**: Computationally-Assisted Metacognition - a pedagogical framework

**Copyright holder**: Jérémie Lumbroso

**Explained in**: `resources/examples/cam.md`

**LICENSE-CAM.md content**:
```markdown
# CAM Framework - Copyright Notice

## Computationally-Assisted Metacognition (CAM)

Copyright © Jérémie Lumbroso. All rights reserved.

## What is CAM?

CAM (Computationally-Assisted Metacognition) is a pedagogical framework for
external metacognitive support through computational partnership.

## Intellectual Property

The CAM framework, including but not limited to:
- The concept of "System 3" as external metacognitive layer
- The methodology for human-AI cognitive partnership
- The pedagogical principles and practices

...are the intellectual property of Jérémie Lumbroso.

## What This Skill Contains

This Architecture of Complexity skill includes:
- **Description of CAM**: How the framework works (cam.md)
- **Analysis using Simon's principles**: Applying complexity theory to CAM

These descriptions are licensed under CC BY-SA 4.0 (see LICENSE), but the
CAM framework itself remains Copyright © Jérémie Lumbroso.

## Contact

For information about CAM or licensing inquiries:
- Website: [To be provided]
- Contact: Jérémie Lumbroso

---

Copyright © Jérémie Lumbroso
```

---

### 3. Third X Framework (Copyright)

**What it is**: LLM output linearization framework

**Copyright holder**: Jérémie Lumbroso

**Website**: https://thirdx.design

**Explained in**: `resources/examples/mcp-design.md`

**LICENSE-THIRDX.md content**:
```markdown
# Third X Framework - Copyright Notice

## LLM Output Linearization Framework

Copyright © Jérémie Lumbroso. All rights reserved.

## What is Third X?

Third X is a framework for designing LLM-consumable output formats through
linearization and hierarchical structuring.

## Intellectual Property

The Third X framework, including but not limited to:
- The "Model Experience" design philosophy
- Linearization as near-decomposability principle
- Process vs. state description choices for LLM consumption
- Stable identifier hierarchies (C42, #12839 patterns)

...are the intellectual property of Jérémie Lumbroso.

## What This Skill Contains

This Architecture of Complexity skill includes:
- **Explanation of Third X**: How the framework applies to MCP design (mcp-design.md)
- **Analysis using Simon's principles**: Applying complexity theory to linearization

These explanations are licensed under CC BY-SA 4.0 (see LICENSE), but the
Third X framework itself remains Copyright © Jérémie Lumbroso.

## More Information

- Website: https://thirdx.design
- Contact: Jérémie Lumbroso

---

Copyright © Jérémie Lumbroso
```

---

## In-Document Attribution

### SKILL.md Header (after frontmatter)

```markdown
# Architecture of Complexity Skill

**Authors:** Jérémie Lumbroso and Claude Sonnet 4.5
**License:** [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/)
**Version:** 1.0.0

**Copyright Notices:**
- **CAM framework** (Computationally-Assisted Metacognition): Copyright © Jérémie Lumbroso. See [LICENSE-CAM.md](LICENSE-CAM.md)
- **Third X framework** (LLM output linearization): Copyright © Jérémie Lumbroso. See [LICENSE-THIRDX.md](LICENSE-THIRDX.md)
- **Skill content**: Licensed under CC BY-SA 4.0. See [LICENSE](LICENSE)
```

### mcp-design.md Footer (add)

```markdown
---

**Copyright Notice:**

The Third X framework (LLM output linearization framework) described in this
document is Copyright © Jérémie Lumbroso. See [LICENSE-THIRDX.md](../../LICENSE-THIRDX.md)
for details.

This document's analysis and description are licensed under CC BY-SA 4.0 as
part of the Architecture of Complexity skill.

**Authors:** Jérémie Lumbroso and Claude Sonnet 4.5
**License:** CC BY-SA 4.0
**Date:** February 2026
```

### cam.md - Update existing footer

Current:
```markdown
**Authors:** Jérémie Lumbroso and Claude Sonnet 4.5
**License:** CC BY-SA 4.0
**Date:** February 2026
```

Add:
```markdown
---

**Copyright Notice:**

The CAM (Computationally-Assisted Metacognition) framework described in this
document is Copyright © Jérémie Lumbroso. See [LICENSE-CAM.md](../../LICENSE-CAM.md)
for details.

This document's analysis and description are licensed under CC BY-SA 4.0 as
part of the Architecture of Complexity skill.

**Authors:** Jérémie Lumbroso and Claude Sonnet 4.5
**License:** CC BY-SA 4.0
**Date:** February 2026
```

---

## Consequences

### Clarity
- ✅ Each license/copyright clearly delineated
- ✅ No confusion about what's CC BY-SA 4.0 vs. copyrighted
- ✅ Proper attribution to Jérémie for his frameworks

### Distribution
- ✅ All license files included in .skill ZIP
- ✅ GitHub displays LICENSE file automatically
- ✅ Users understand what they can/cannot do

### Legal Protection
- ✅ CAM and Third X frameworks protected as IP
- ✅ Skill content shareable under CC BY-SA 4.0
- ✅ Clear attribution requirements

---

## Action Items

- [x] Document license file structure - Owner: Claude Code
- [ ] Create LICENSE file (CC BY-SA 4.0) - Owner: Claude Code
- [ ] Create LICENSE-CAM.md - Owner: Claude Code
- [ ] Create LICENSE-THIRDX.md - Owner: Claude Code
- [ ] Update SKILL.md header with copyright notices - Owner: Claude Code
- [ ] Add copyright footer to mcp-design.md - Owner: Claude Code
- [ ] Update copyright footer in cam.md - Owner: Claude Code

---

## Validation

- [x] Human: Specified three separate licenses/copyrights
- [x] Human: Provided framework names (CAM, Third X)
- [x] AI: Structured license files for clarity

---

## Iterations

### Iteration 1 (2026-02-27)
- Human: Clarified CAM and Third X as separate copyrighted frameworks
- Human: Confirmed "Third X" (not "mx" or "ax") with website thirdx.design
- AI: Created three-license structure with clear scope for each
- AI: Specified in-document attribution requirements
- Outcome: Clear license separation with proper attribution

---

## Links

- Related: ADR-0001 (Skill Packaging Format)
- Related: ADR-0002 (Versioning Strategy)
- Reference: `licenses/legalcode.txt` (CC BY-SA 4.0 full text)
- Reference: https://creativecommons.org/licenses/by-sa/4.0/
- Reference: https://thirdx.design
