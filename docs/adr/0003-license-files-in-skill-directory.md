# ADR-0003: LICENSE Files Belong in Skill Directory (Not Repo Root)

- **Date**: 2026-02-27
- **Iteration**: 2 (Minor edits 2026-03-29)
- **Status**: Accepted
- **Deciders**: Jérémie Lumbroso, Claude Code Sonnet 4.5

---

## Context

We needed to determine where LICENSE files should be placed:
- In the skill directory (included in .skill ZIP)?
- In the repository root (excluded from .skill ZIP)?

This decision was **not intuitive** - initial analysis suggested licenses shouldn't be in the ZIP since they'd add token overhead without being loaded by Claude.

---

## Initial (Wrong) Assumption

**First hypothesis:** LICENSE files should be in repository root only, not in .skill ZIP

**Reasoning:**
- LICENSE files aren't referenced in SKILL.md body
- Claude won't load them into context
- They'd just add bloat to the ZIP
- License info in SKILL.md header should be sufficient

**Evidence for this view:**
- visual-diffusion.skill (user-created example) had NO LICENSE files
- Seemed like unnecessary overhead

---

## Discovery: Official Anthropic Skills Pattern

User provided official Anthropic skills repository: `docs/resources/skills/`

### FIL: What we found

```bash
# 15 out of 18 official Anthropic skills have LICENSE.txt
skills/algorithmic-art/LICENSE.txt
skills/theme-factory/LICENSE.txt
skills/xlsx/LICENSE.txt
skills/pdf/LICENSE.txt
# ... etc
```

### COD: Frontmatter pattern from algorithmic-art

```yaml
---
name: algorithmic-art
description: Creating algorithmic art using p5.js...
license: Complete terms in LICENSE.txt
---
```

**Key finding:** The `license:` frontmatter field points to the LICENSE file!

### NOT: Repository structure

```
skills/                          (repo root)
├── THIRD_PARTY_NOTICES.md       ← Third-party deps (FFmpeg, etc.)
├── skills/
│   ├── algorithmic-art/
│   │   ├── LICENSE.txt          ← In skill directory!
│   │   └── SKILL.md
│   ├── theme-factory/
│   │   ├── LICENSE.txt          ← In skill directory!
│   │   └── SKILL.md
```

---

## Decision

### Chosen: LICENSE Files IN Skill Directory

**All license files go in the skill directory and are included in the .skill ZIP:**

```
your-skill-name/                   (skill directory → packaged in ZIP)
├── LICENSE                        ← Primary license (e.g., CC BY-SA 4.0, MIT, Apache 2.0)
├── LICENSE-FRAMEWORK.md           ← Optional: specific framework/content copyright
├── SKILL.md
└── resources/
```

**NOT in repository root** (unless you want a separate repo LICENSE, which is optional)

---

## Rationale

### Why Include License Files in ZIP?

1. **Legal distribution requirement**
   - When users download/share the .skill file, they get the license
   - Fulfills legal obligation to provide license terms with the work
   - Self-contained package includes all legal notices

2. **Official Anthropic pattern**
   - 15/18 official skills include LICENSE.txt
   - This is the established convention
   - Aligns with community expectations

3. **Metadata, not content**
   - LICENSE files are NOT referenced in SKILL.md body
   - Claude won't load them into context (they're not reading material)
   - They don't consume tokens during skill execution
   - Similar to README.md - included for humans, not Claude

4. **Frontmatter integration**
   - The `license:` frontmatter field provides discoverability
   - Users know where to find complete license terms
   - Makes licensing explicit and accessible

### Why This Was Non-Intuitive

**The confusion arose from mixing two concepts:**

1. **Files Claude loads** (SKILL.md, referenced supporting files)
   - These consume tokens and must be efficient
   - Should be under 500 lines (SKILL.md)
   - Referenced explicitly in SKILL.md

2. **Files for distribution** (LICENSE, README, etc.)
   - Legal and documentation requirements
   - Not loaded into context
   - Included for human users, not Claude

**The "magic":** LICENSE files serve legal/distribution purposes, not LLM consumption purposes.

---

## Implementation

### SKILL.md Frontmatter

```yaml
---
name: your-skill-name
description: Brief description of your skill...
license: Complete terms in LICENSE
---
```

If multiple licenses:
```yaml
---
name: your-skill-name
description: Brief description of your skill...
license: Complete terms in LICENSE. See also LICENSE-FRAMEWORK.md for specific content copyrights.
---
```

### File Placement

**✅ Correct:**
```
your-skill-name/
├── LICENSE
├── LICENSE-FRAMEWORK.md    (optional, if needed)
└── SKILL.md
```

**❌ Wrong:**
```
repository-root/
├── LICENSE                 ← Don't put here (unless separate repo license)
├── your-skill-name/
│   └── SKILL.md
```

### CI/CD Impact

The build workflow should **include** LICENSE files in the ZIP:

```bash
cd your-skill-name
zip -r "../your-skill-name-1.0.0.skill" . \
  -x "*.git*" \
  -x "*.DS_Store"
  # LICENSE files are NOT excluded!
```

---

## Consequences

### Benefits

- ✅ Follows official Anthropic convention
- ✅ Legally compliant distribution
- ✅ Self-contained skill package
- ✅ Clear licensing via frontmatter metadata
- ✅ No token overhead (files not loaded)

### Trade-offs

- Slightly larger ZIP file (~50KB for full CC BY-SA legalcode)
- Three separate LICENSE files (due to our multi-license situation)
- But: necessary for legal compliance and follows community standard

### User Experience

**When user downloads skill:**
1. Sees `license:` field in frontmatter
2. Can read LICENSE, LICENSE-CAM.md, LICENSE-THIRDX.md
3. Knows exactly what terms apply
4. Has all legal notices in one package

**When Claude loads skill:**
1. Reads frontmatter (including license field)
2. Loads SKILL.md content
3. Does NOT load LICENSE files (not referenced)
4. Zero token overhead from licenses

---

## Lessons Learned

### The "Magic" Explained

**Why it's not obvious:**
- Developer instinct: minimize package size
- LICENSE files seem like "metadata" that belongs in repo root
- Initial example (visual-diffusion.skill) didn't have licenses

**Why it's correct:**
- Skills are *distributed artifacts*, not just code
- Legal requirements trump size optimization
- Official pattern established by Anthropic
- Frontmatter `license:` field makes it discoverable

### Pattern Recognition

This follows the **"distribution manifest" pattern:**
- npm packages include LICENSE (even though not executed)
- Python packages include LICENSE (even though not imported)
- Skills include LICENSE (even though not loaded by Claude)

**The pattern:** Distributed artifacts carry their legal terms with them.

---

## Questions & Answers

### QST: Why not just put license info in SKILL.md header?

**ANS:** We do BOTH:
- SKILL.md header: Attribution and quick reference
- LICENSE files: Complete legal terms (required for compliance)
- Frontmatter: Discovery mechanism pointing to full terms

### QST: Doesn't this bloat the ZIP?

**ANS:**
- Apache 2.0 LICENSE.txt: ~11KB
- Our LICENSE (CC BY-SA): ~50KB
- Total all three: ~70KB
- Skill total: ~200KB
- **Verdict:** Acceptable overhead for legal compliance

### QST: What about THIRD_PARTY_NOTICES.md?

**ANS:**
- That's for DEPENDENCIES the skill uses (like FFmpeg)
- Only needed if we bundle third-party code/libraries
- We don't currently have any, so we don't need it
- If we add dependencies later, create THIRD_PARTY_NOTICES.md

---

## Action Items

- [x] Keep LICENSE files in skill directory - Owner: Both
- [x] Add `license:` field to SKILL.md frontmatter - Owner: Claude Code
- [x] Update docs/resources/README.md with this finding - Owner: Claude Code
- [x] Document the decision in ADR - Owner: Claude Code
- [x] Update CI/CD to include LICENSE files in ZIP - Owner: Claude Code

---

## Validation

- [x] Human: Confirmed non-intuitive but correct via official skills
- [x] AI: Verified against 15/18 official Anthropic skills
- [x] Pattern matches: Algorithmic-art, theme-factory, pdf, xlsx

**Notes:** This was a collaborative discovery that corrected an initial misunderstanding. The official Anthropic skills repository was the key evidence that changed our approach.

---

## Iterations

### Iteration 1 (2026-02-27)

**Initial hypothesis:**
- AI: Analyzed visual-diffusion.skill (no LICENSE files)
- AI: Concluded licenses shouldn't be in ZIP
- AI: Recommended repo root placement

**Correction:**
- Human: Provided official Anthropic skills repository
- Both: Examined algorithmic-art and other skills
- Both: Discovered LICENSE.txt pattern in 15/18 skills
- Both: Found `license:` frontmatter field
- Outcome: Reversed decision, documented the learning

**Key quote from human:** "This was not intuitive at all. It's a little bit magic so I'm glad that we figured it out together."

### Iteration 2 (2026-03-29) - Template Transformation

- AI: Minor edits for skill-building template
- Updated examples from AoC-specific to generic (`your-skill-name`)
- Removed reference to deleted ADR-0003
- All principles and patterns remain unchanged

---

## Links

- Related: ADR-0001 (Skill Packaging Format)
- Supersedes: Initial analysis that suggested excluding LICENSE from ZIP
- Reference: `/docs/resources/skills/skills/algorithmic-art/`
- Reference: `/docs/resources/skills/THIRD_PARTY_NOTICES.md` (for dependency attribution pattern)

---

## Epilogue: Why Document This?

This ADR preserves a **non-obvious decision** that emerged from collaborative investigation.

**Future us:** When you wonder "why are LICENSE files in the ZIP?", read this.
**Future contributors:** When you think "this seems wasteful," understand the legal and conventional reasons.
**The magic:** Sometimes the right answer isn't the obvious one - that's why we write ADRs.
