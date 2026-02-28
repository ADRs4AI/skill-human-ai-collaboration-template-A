# ADR-0007: Reveal.js CSS Baseline for Tight Slides

- **Date**: 2026-02-04
- **Iteration**: 1
- **Status**: Accepted
- **Deciders**: Jérémie Lumbroso, Claude Sonnet 4.5

---

## Context

After creating slides for Lectures 2 and 3, we discovered that content frequently overflows slides when using default or intuitive CSS values. This creates a poor presentation experience where text runs off the bottom of slides.

**Problem**: Initial slide generation uses font sizes and spacing that look reasonable in isolation but don't account for reveal.js's fixed viewport constraints.

**Impact**:
- Lecture 2 initially had overflow issues, requiring emergency fixes before presentation
- Lecture 3 had the same issues until we applied the learned baseline
- Without documented standards, each new lecture will repeat this problem

---

## Decision

### CSS Baseline for All Reveal.js Slides

We've established a CSS baseline through trial and error across multiple lectures. This baseline ensures content fits within slides while maintaining readability.

### COD: Complete CSS Baseline

```css
:root {
	--r-background-color: #FAF9F5;
	--r-main-font: 'Lato', sans-serif;
	--r-heading-color: #CC7C5E;
	--r-link-color: #53B467;
	--r-main-font-size: 28px;        /* CRITICAL: Base size */
	--r-heading1-size: 2.2em;
	--r-heading2-size: 1.4em;
	--r-heading3-size: 1.2em;
}

.reveal h1, .reveal h2, .reveal h3 {
	color: #CC7C5E;
	font-weight: 700;
	margin-bottom: 0.3em;            /* Tight margins */
}

.reveal .slides {
	text-align: left;
}

.reveal ul, .reveal ol {
	margin-left: 1em;
	line-height: 1.3;                /* CRITICAL: Not 1.6 */
}

.reveal p {
	line-height: 1.3;                /* CRITICAL: Not 1.6 */
	margin-bottom: 0.4em;
}

.reveal li {
	line-height: 1.3;                /* CRITICAL: Not 1.6 */
	margin-bottom: 0.2em;
}

.large-text {
	font-size: 1.05em;               /* CRITICAL: Not 1.2em */
}

.code-box {
	background: #f5f5f5;
	padding: 15px;                   /* Not 20px */
	border-left: 4px solid #CC7C5E;
	font-family: 'Courier New', monospace;
	font-size: 0.85em;               /* CRITICAL: Smaller */
	margin: 15px 0;                  /* Not 20px */
	line-height: 1.4;
}

.centered {
	text-align: center !important;
}

.spacer {
	margin-top: 30px;                /* CRITICAL: Not 40px */
}
```

---

## Key Principles Learned

### 1. Line Height is Critical
**Never use 1.6 line-height** - it creates too much vertical space. Use **1.3** consistently.

**Before (broken)**:
```css
.reveal p, .reveal li { line-height: 1.6; }
```

**After (working)**:
```css
.reveal p { line-height: 1.3; margin-bottom: 0.4em; }
.reveal li { line-height: 1.3; margin-bottom: 0.2em; }
```

### 2. Font Size Multipliers
**`.large-text` at 1.2em is too large** - use **1.05em** instead.

This seems minor but compounds across multiple text elements on a slide.

### 3. Spacing Must Be Tight
- **Spacer margins**: 30px not 40px
- **Code box padding**: 15px not 20px
- **Heading margins**: 0.3em bottom margin
- **Paragraph margins**: 0.4em bottom
- **List item margins**: 0.2em bottom

### 4. Code Boxes Need Special Treatment
```css
.code-box {
	font-size: 0.85em;    /* Smaller than body text */
	padding: 15px;        /* Reduced padding */
	line-height: 1.4;     /* Slightly more than body for readability */
}
```

---

## Testing Strategy

When creating new slides:

1. **Build with baseline CSS first** - don't start with "intuitive" values
2. **Test densest slides** - find the slide with most content and verify it fits
3. **Check code boxes** - these are most likely to overflow
4. **Review on actual display** - local browser preview at presentation resolution

### Warning Signs of Overflow
- Code boxes with more than 8-10 lines
- Slides with 5+ bullet points
- Slides mixing text + code + spacing elements
- Any slide that "feels full" in the editor

---

## Integration with ADR-0001

This ADR complements [ADR-0001 (Reveal.js Workflow)](0001-reveal-js-slide-collaboration-workflow.md).

**ADR-0001 covers**: Speaker notes setup, workflow, collaboration patterns
**ADR-0007 covers**: CSS baseline, font sizing, spacing standards

Both are required reading before creating new lecture slides.

---

## Consequences

### Positive
- Future slides will fit properly on first generation
- Consistent visual style across all lectures
- Reduced iteration time for slide fixes
- Documented knowledge prevents re-learning

### Negative
- Slides feel "tighter" than typical reveal.js presentations
- Less whitespace than design best practices suggest
- May need adjustment for different projector/screen ratios

### Trade-offs Accepted
We're optimizing for **content density over breathing room** because:
- These are technical lectures with substantial material
- 90-minute format requires efficient information presentation
- Students can pause/review slides later (they're on critical.systems)

---

## Action Items

- [x] Create ADR-0007 documenting CSS baseline
- [ ] Update ADR-0001 to cross-reference this ADR
- [ ] Create CSS template file for rapid lecture creation
- [ ] Add pre-flight checklist to CLAUDE.md for new slides

---

## Links

- Related ADRs: [ADR-0001](0001-reveal-js-slide-collaboration-workflow.md)
- Implementation:
  - [lecture02/slides-lecture02.html](../../lectures/lecture02/slides-lecture02.html)
  - [lecture03/lecture03-slides.html](../../lectures/lecture03/lecture03-slides.html)

---

## Iterations

### Iteration 1 (2026-02-04)
- **Context**: After fixing overflow in both Lecture 2 and Lecture 3, patterns became clear
- **Decision**: Document the working CSS baseline as standard
- **Validation**: Applied to Lecture 3 with immediate success
