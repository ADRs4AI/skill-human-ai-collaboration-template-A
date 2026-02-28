# ADR 0004: Two-Version Slide Strategy for Pedagogical Uncertainty

**Status**: Accepted
**Date**: 2026-01-22
**Iteration**: 1
**Context**: Creating Lecture 01 under time pressure with significant design uncertainty

---

## Decision

When facing **significant pedagogical uncertainty** about how to frame content, create **two versions** of slides that explore different approaches, with a comparison document to guide choice.

---

## Context: The Lecture 01 Uncertainty

### QST: How vulnerable should Jérémie be in the first lecture?

The core tension:

**Option A (V1 - Full Narrative)**:
- Explicit HSP/Autistic disclosure
- Detailed CIT 5020 crisis story (banking model damage)
- SIGCSE bullying incident mention
- Very personal mission-driven tone
- Higher emotional intensity

**Option B (V2 - Lighter)**:
- No neurodivergence disclosure
- Brief analytical observation about CIT 5020
- No bullying story
- Professional philosophical tone
- Lower emotional intensity

**Why this matters**:
- First lecture sets tone for entire course
- Vulnerability builds trust BUT might overwhelm
- Professional boundaries vs authentic connection
- No "right answer"—depends on presenter comfort and cohort

---

## When to Use Two-Version Strategy

### Trigger Conditions

Create two versions when ALL of these apply:

1. **Significant design choice** with no clear winner
2. **Trade-offs are real** on both sides (not obviously better/worse)
3. **Time allows** (under extreme pressure, commit to one)
4. **Choice matters** for course outcomes
5. **Presenter uncertainty** about personal comfort level

### NOT Triggers

Don't create two versions when:
- Minor wording differences
- Small content reordering
- Technical details only
- Clear pedagogical consensus

---

## How Versions Should Differ

### Structural Consistency

Both versions must share:
- ✓ Same overall narrative arc
- ✓ Same core content (algorithms, concepts)
- ✓ Same timing structure (acts, transitions)
- ✓ Same visual assets
- ✓ Compatible file structure

### Meaningful Differences

Versions should differ on:
- **Framing**: Personal vs professional
- **Disclosure level**: Vulnerable vs bounded
- **Emotional intensity**: High vs moderate
- **Tone**: Mission-driven vs analytical
- **Length**: Typically 5-15% difference

---

## Lecture 01: Actual Differences

| Element | V1 (Full Narrative) | V2 (Lighter) |
|---------|---------------------|--------------|
| Neurodivergence | HSP/Autistic explicit | Not mentioned |
| CIT 5920 story | Detailed, emotional | Brief, analytical |
| SIGCSE bullying | Included | Removed |
| Banking model damage | Personal examples | Observational critique |
| Two-track framing | Emotional appeal | Structural logic |
| Content time | 52-64 min | 45-55 min |
| Q&A buffer | 20-25 min | 25-30 min |

**What stayed the same**:
- Freire opening (identical)
- Banking model explanation (same content, different examples)
- Two-track system (same structure, different tone)
- Dinner Party algorithm story (identical)
- Algorithms vs ML distinction (identical)
- Slido questions (identical)

---

## Decision Support Document

### Requirements for Comparison Doc

Must include:

1. **Quick Decision Matrix**
   - Key differences in table form
   - Timing comparison
   - "Choose V1 if..." vs "Choose V2 if..." guidance

2. **Tone Samples**
   - Representative slides from each version
   - Highlight contrasts

3. **Technical Notes**
   - File structure
   - How to test both
   - Any version-specific requirements

4. **Pre-Class Checklist**
   - Works for either version
   - Version-specific items flagged

### Example: Lecture 01 Decision Guide

```markdown
## Choose V1 (Full Narrative) if:
- You want to be fully transparent about neurodivergence
- You want to share the CIT 5920 crisis story in detail
- You're comfortable with emotional vulnerability
- You want the course to feel like a personal mission

## Choose V2 (Lighter) if:
- You want to maintain more professional boundaries
- You prefer to focus on pedagogical philosophy over personal narrative
- You want to keep emotional intensity lower
- You're unsure about sharing neurodivergence details in first lecture
```

---

## The Testing Protocol

### Before Deciding

1. **Read both versions completely**
   - Don't skim, actually read as if presenting
   - Note which feels more natural to your voice

2. **Open both HTML files**
   - Check that both render correctly
   - Verify images load in both
   - Test speaker notes in both

3. **Consider the cohort**
   - Read student waitlist data if available
   - Consider what you know about the group
   - Trust your instinct about what they need

4. **Run decision checklist**
   - From comparison document
   - Mark off which criteria fit

5. **Commit by [deadline]**
   - Don't waffle day-of
   - Choose 24 hours before class minimum
   - Practice chosen version

---

## What Happened: Lecture 01 Outcome

**Decision**: Jérémie chose **V1 (Full Narrative)**

**Result**: Lecture went well. Vulnerability landed positively.

**Validation**: The two-version strategy was worth it—gave confidence to choose the riskier option knowing there was a fallback.

---

## Lessons Learned

### ✓ What Worked

1. **Having fallback reduced anxiety** about risky choice
2. **Comparison document** made decision process clear
3. **Structural consistency** meant both versions were viable
4. **Time investment justified** for first lecture (sets tone)
5. **Claude could generate both in parallel** efficiently

### ✗ What Could Improve

1. **Don't create two versions for every lecture** (overkill)
2. **Decision deadline should be explicit** in comparison doc
3. **Test speaker notes in BOTH versions** (caught by this issue)
4. **Consider creating "hybrid" option** for future (mix-and-match slides)

---

## Future Application

### When to Use Again

**High priority candidates**:
- First lecture of course (sets tone)
- Controversial topics (multiple valid framings)
- Guest lecture vs solo teaching
- Technical depth vs intuitive explanation
- Theoretical vs applied focus

**Low priority** (don't bother):
- Standard content lectures (sorting, graphs, DP)
- Mid-semester continuation of established patterns
- Review sessions
- Office hours materials

---

## Cost-Benefit Analysis

### Costs

- **Time**: ~20-30% more time to create two versions
- **Decision fatigue**: Choosing between them
- **Testing overhead**: Both must be verified
- **Risk of confusion**: Accidentally opening wrong version day-of

### Benefits

- **Confidence**: Know you have fallback
- **Exploration**: Can take risks knowing safety net exists
- **Better decision**: Side-by-side comparison clarifies choice
- **Learning**: Process reveals what matters most pedagogically

**Net**: Worth it for high-stakes lectures, not for routine content.

---

## Technical Implementation

### File Naming Convention

```
slides-v1-[descriptor].html
slides-v2-[descriptor].html
README-SLIDES.md (comparison document)
```

**Example**:
```
slides-v1-full-narrative.html
slides-v2-lighter.html
README-SLIDES.md
```

### Git Commit Strategy

**Don't**: Put both versions in same commit

**Do**: Separate commits for tracking
```bash
git add slides-v1-full-narrative.html
git commit -m "feat: lecture 01 slides V1 (full narrative version)"

git add slides-v2-lighter.html
git commit -m "feat: lecture 01 slides V2 (lighter version)"

git add README-SLIDES.md
git commit -m "docs: lecture 01 decision guide for V1 vs V2"
```

**Why**: Clear history of what changed between versions

---

## Anti-Patterns

### ✗ Creating versions for wrong reasons

**Bad reason**: "I couldn't decide on slide ordering"
→ Just pick one, it's not worth two versions

**Good reason**: "I don't know if I should disclose neurodivergence or maintain professional boundaries"
→ This is a significant pedagogical choice

### ✗ Versions that differ trivially

**Bad**:
- V1 has blue background
- V2 has green background

**Good**:
- V1 is personally vulnerable
- V2 is professionally bounded

### ✗ Not documenting decision criteria

If you create two versions but don't explain *how to choose*, you've just created confusion.

### ✗ Creating three+ versions

**Cognitive overload**. Two is maximum. If you need three, you haven't narrowed the design space enough.

---

## Template: Decision Guide Document

```markdown
# Lecture [N] Slides - Decision Guide

## Two Versions Created

1. **V1: [Descriptor]** - [Brief description]
2. **V2: [Descriptor]** - [Brief description]

## Quick Decision

| Aspect | V1 | V2 |
|--------|----|----|
| Key difference | ... | ... |
| Time | X-Y min | X-Y min |
| Tone | ... | ... |

## Choose V1 if:
- [Criterion 1]
- [Criterion 2]
- [Criterion 3]

## Choose V2 if:
- [Criterion 1]
- [Criterion 2]
- [Criterion 3]

## Testing Both

- [ ] Open both HTML files
- [ ] Check images load
- [ ] Test speaker notes
- [ ] Read through completely

## Commit by: [DATE/TIME]

Don't change day-of. Pick 24 hours before class minimum.
```

---

## Related ADRs

- ADR 0001: Reveal.js workflow (how versions are generated)
- ADR 0005: Two-Track System (vulnerability connects to Track 2 opt-in)
- Future ADR: When to Revise vs Recreate Lectures

---

## QST: Should this become standard practice?

**ANS**: No. Use sparingly for high-stakes moments with genuine uncertainty. Most lectures should commit to single version to preserve time and energy for other priorities.

**Estimate**: 1-2 times per semester at most.

---

**Outcome**: Strategy validated for Lecture 01. Provided confidence to choose riskier V1 option. Will use selectively for future high-stakes moments but not routinely.
