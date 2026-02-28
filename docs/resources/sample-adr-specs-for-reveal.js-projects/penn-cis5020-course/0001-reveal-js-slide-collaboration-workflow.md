# ADR 0001: Reveal.js Slide Collaboration Workflow

**Status**: Accepted
**Date**: 2026-01-22 (updated 2026-01-29)
**Iteration**: 2
**Context**: Creating Lecture 01 slides under extreme time pressure (T-35); updated with Lecture 02 lessons learned

---

## Decision

We use **Reveal.js** for lecture slides with a specific human-AI collaboration workflow where the human provides high-level narrative structure and timing, and Claude generates complete HTML slides with speaker notes.

---

## Context

### QST: Why Reveal.js over PowerPoint/Keynote/Google Slides?

**ANS**:
- Version control via git (track changes, collaborate, revert)
- Programmatic generation by AI (Claude can write HTML directly)
- Speaker notes built-in (press 'S' key during presentation)
- Web-based (works on any platform, no software installation)
- Free and open-source
- Supports code syntax highlighting natively
- Can embed images, customize CSS for brand colors

### NOT: Technical Issue Discovered & Resolved

**Lecture 01 delivery (2026-01-22)**: Speaker notes failed to open during presentation.

**Lecture 02 delivery (2026-01-29)**: Speaker notes worked correctly after explicit plugin configuration.

**Root cause identified**: The speaker notes plugin must be **explicitly loaded and initialized**. Simply having `<aside class="notes">` tags is not enough.

**Solution**: See "Speaker Notes Plugin Setup" section below.

---

## Workflow That Worked

### Phase 1: Human Provides Structure (Jérémie)

**Input format**:
- Outline document with acts/sections
- Algorithmic story narrative
- Timing targets (e.g., "50-60 min content, 20-30 min Q&A")
- Key concepts to emphasize
- Desired emotional beats (e.g., "aporia opening," "crisis moment")
- Asset locations (images in `assets/` folder)

**Example from Lecture 01**:
```
ACT 1: APORIA OPENING (5-7 min)
- Pre-class: Freire image, no text
- "Do you know who this is?"
- Reveal: Paulo Freire, Pedagogy of the Oppressed
- Transition: "This person changed how I think about teaching"
```

### Phase 2: Claude Generates Complete Slides

**Output format**:
- Full HTML file with Reveal.js structure
- Speaker notes in `<aside class="notes">` tags with:
  - Timing markers (e.g., "[5:15]")
  - Delivery guidance
  - Transitions and pacing notes
- CSS styling matching brand colors (from CLAUDE.md):
  - Background: #FAF9F5 (beige)
  - Headings: #CC7C5E (orange)
  - Accents: #53B467 (green)
- Fragment animations for progressive reveal
- Two versions created based on design choice uncertainty

### Phase 3: Human Reviews and Refines

**Iteration cycle**:
- Human tests slides (double-click HTML file)
- Identifies missing images or incorrect paths
- Requests additions (e.g., "add Self-Determination Theory graphic after banking model section")
- Claude updates both versions in parallel

---

## Key Design Patterns

### 1. Speaker Notes Are Critical

Every slide should have `<aside class="notes">` with:
- **Timing markers** for pacing
- **What to say** (not script, but guidance)
- **Why this slide matters** pedagogically
- **Delivery notes** (e.g., "pause here," "wait for responses")

Example:
```html
<aside class="notes">
  [5:22] Part A: My neurodivergence (3 min).
  Be vulnerable here but not apologetic. This is who you are.
</aside>
```

### 2. Two-Version Strategy for Uncertainty

When there's a **significant design choice** (e.g., how vulnerable to be, how detailed to go), create two versions:
- V1: Full narrative (more personal, longer)
- V2: Streamlined (more professional, shorter)

Include a README comparing them with decision guide.

### 3. Local Images, Not External URLs

**Prefer**: `<img src="images/freire.jpg">`
**Avoid**: `<img src="https://wikipedia.org/...">`

Reason: No internet dependency, faster loading, complete control

### 4. Progressive Reveal with Fragments

Use `class="fragment"` for list items and concepts that should appear incrementally:
```html
<ul>
  <li class="fragment">First point (appears on click)</li>
  <li class="fragment">Second point (appears on next click)</li>
</ul>
```

This controls pacing and prevents overwhelming students.

---

## Technical Setup

### File Structure

```
lectures/
  lecture01/
    slides-v1-full-narrative.html    # Complete version
    slides-v2-lighter.html            # Streamlined version
    images/                           # Local images
      freire.jpg
      pedagogy-book.jpg
      ...
    assets/                           # Generated graphics
      dinner-party-chaos.png
      ...
    README-SLIDES.md                  # Decision guide
```

### Reveal.js Installation

**Location**: Project root (`/dist/`, `/plugin/`)
**Version**: 5.1.0
**Relative paths from lecture**: `../../dist/reveal.js`

**Why root-level?** Multiple lectures can share one Reveal.js installation.

### Speaker Notes Plugin Setup (CRITICAL)

**The speaker notes plugin must be explicitly loaded.** This is not automatic.

**Required code at end of HTML file:**
```html
<script src="../../dist/reveal.js"></script>
<script src="../../plugin/notes/notes.js"></script>  <!-- MUST ADD THIS -->
<script>
  Reveal.initialize({
    hash: true,
    slideNumber: 'c/t',
    showNotes: false,
    transition: 'slide',
    backgroundTransition: 'fade',
    plugins: [RevealNotes]  <!-- MUST ADD THIS -->
  });
</script>
```

**Common mistake**: Omitting either the script tag OR the plugins array. Both are required.

### Opening Speaker Notes

**During presentation**: Press **'S'** key

**What opens**:
- Separate window with:
  - Current slide + notes
  - Next slide preview
  - Timer
  - Slide numbers

**Setup**: Keep speaker notes window on laptop, main presentation on projector.

---

## Lessons Learned

### ✓ What Worked Well

1. **High-level narrative → complete slides** workflow is extremely efficient
2. **Timing markers in speaker notes** helped maintain pacing
3. **Two-version strategy** gave presenter choice and confidence
4. **Color scheme from CLAUDE.md** created visual consistency
5. **Fragment animations** controlled information flow effectively
6. **Local images** avoided internet dependency issues

### ✗ What Needs Improvement

1. **Speaker notes plugin must be explicitly loaded** - RESOLVED. See "Speaker Notes Plugin Setup" section above.
2. **Initial font sizes too large** - Claude's default slide generation uses font sizes that overflow. RESOLVED by:
   - Setting `--r-main-font-size: 28px` (smaller base)
   - Using `line-height: 1.3` instead of 1.5-1.6
   - Reducing `.large-text` from 1.3em to 1.05em
   - Reducing margins and padding globally
3. **No practice run** with speaker notes ahead of time
4. **Image file extensions inconsistent** (.jpg vs .png) caused initial path issues
5. **No backup plan** if technology fails completely

### COD: Recommended CSS Baseline for Tight Slides

```css
:root {
  --r-main-font-size: 28px;
  --r-heading1-size: 2.2em;
  --r-heading2-size: 1.4em;
}
.reveal ul, .reveal ol {
  line-height: 1.3;
}
.reveal p {
  margin-bottom: 0.4em;
}
.reveal li {
  margin-bottom: 0.2em;
}
.large-text {
  font-size: 1.05em;
  line-height: 1.35;
}
```

This prevents text from overflowing slides while remaining readable.

---

## Future Improvements

### FIL: Files to Create

- [ ] `docs/REVEAL_JS_TROUBLESHOOTING.md` - Common issues and fixes
- [ ] `lectures/template-lecture.html` - Boilerplate for new lectures
- [ ] `scripts/ephemeral/check-slide-images.py` - Verify all image paths exist

### COD: Code Patterns to Standardize

```html
<!-- Standard slide with timing -->
<section>
  <h2>Slide Title</h2>
  <p>Content here</p>
  <aside class="notes">
    [HH:MM] Section name (X min).
    Speaker guidance here.
  </aside>
</section>

<!-- Progressive reveal pattern -->
<section>
  <h2>Title</h2>
  <ul>
    <li class="fragment">First point</li>
    <li class="fragment">Second point</li>
    <li class="fragment">Third point</li>
  </ul>
  <aside class="notes">
    Let each fragment sink in. Don't rush.
  </aside>
</section>

<!-- Image-focused slide -->
<section class="center">
  <h3>Concept Name</h3>
  <img src="images/diagram.png"
       alt="Description for accessibility"
       class="r-stretch">
  <aside class="notes">
    Explain what they're seeing in the image.
  </aside>
</section>
```

---

## Decision Rationale

**Why this workflow over alternatives?**

| Alternative | Why Not Chosen |
|-------------|----------------|
| PowerPoint/Keynote | No version control, not AI-generatable, platform-specific |
| Google Slides | Limited AI generation, less customization, requires Google account |
| LaTeX Beamer | Overkill for lecture slides, harder to iterate quickly |
| Markdown → Slides | Less control over layout and styling |

**Why human provides outline, Claude generates slides?**

- Human has narrative intuition, emotional beats, pedagogical goals
- Claude has speed, consistency, attention to detail (e.g., closing tags)
- Human iterates on structure, Claude handles implementation
- Preserves human creativity while leveraging AI efficiency

---

## Related ADRs

- ADR 0002: Slido Question Format (interactive elements)
- ADR 0003: Algorithmic Storytelling via Dinner Party Narrative
- ADR 0004: Two-Version Slide Strategy for Pedagogical Uncertainty
- ADR 0005: Two-Track Course System

---

## References

### DOC: Documentation

- Reveal.js docs: `/docs/REVEAL_JS_SPECIFICATION.md`
- Setup guide: `/lectures/lecture01/SETUP-COMPLETE.md`
- Decision guide: `/lectures/lecture01/README-SLIDES.md`

### API: Key Reveal.js Features Used

- `class="fragment"` - Progressive reveal
- `class="r-stretch"` - Responsive image sizing
- `<aside class="notes">` - Speaker notes
- `data-background="#color"` - Slide background colors
- `class="center"` - Center-aligned slides

---

**Outcome**: Successfully delivered 90-minute lecture with 60+ slides generated in ~2 hours under extreme time pressure. Workflow validated for future lectures.
