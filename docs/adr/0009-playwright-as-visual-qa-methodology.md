# ADR-0009: Playwright MCP as Visual Quality Assurance Methodology

- **Date**: 2026-02-28
- **Iteration**: 1
- **Status**: Accepted
- **Deciders**: Jérémie Lumbroso, Claude Code Sonnet 4.6

---

## Context

### QST: Why is visual QA by Playwright better than human review?

A recurring problem across all reveal.js presentations built with Claude Code is that certain errors are visually obvious but epistemically invisible in code:

1. **Content overflow**: A slide has too much text and the bottom cuts off at the viewport edge. In the HTML, every element looks fine. Only when rendered does the overflow appear.

2. **Line wrapping in pseudocode**: A code block or algorithm written with `verbatim` or missing `white-space: pre-wrap` wraps mid-expression, making it illegible. Not detectable from HTML source alone.

3. **Style interplay**: Two CSS rules interact unexpectedly (e.g., `.strong` inside `<ol> li` breaks inline flow). The visual result is immediately obvious; the cause requires inspection.

4. **Plugin rendering**: Mermaid diagrams render asynchronously. Did it render or is it a raw text block? Cannot tell from HTML alone.

5. **Fragment state**: Are fragments hidden correctly on slide load? Are they revealed in the right sequence?

These are **judgments that require rendered visual output** — they cannot be made from HTML source alone. This is epistemic transfer that should happen between the presentation and Claude, not between the human and Claude. The human should not be doing what a machine can do.

### QST: BrowserMCP vs. Playwright MCP?

BrowserMCP was initially available but is unreliable for reveal.js work:
- Drops connections on animations
- WebSocket timeout issues
- No JavaScript execution (`evaluate()`)
- Unreliable with localhost
- Race conditions on screenshots

Playwright MCP is decisively superior for this use case (per beyond-the-hype ADR-0006):
- `evaluate()` gives full Reveal.js JavaScript API access
- Deterministic screenshot timing
- Console log access (catches JavaScript errors)
- Fragment control via JS
- Rock-solid localhost connection
- Full navigation API via `Reveal.slide(h, v)`

---

## Decision

### Use Playwright MCP for visual quality checking during and after presentation generation

**The methodology**:
1. Start a local HTTP server (`python3 -m http.server PORT --directory /path/to/repo`)
2. Navigate Playwright to the presentation URL
3. Use `Reveal.slide(h, v)` to visit each slide programmatically
4. Take screenshots and inspect for overflow, layout issues, rendering failures
5. Check console for JavaScript errors
6. Archive screenshots as documentation when appropriate

**This is a skill subskill**: The full workflow (navigation API, fragment control, Mermaid check, error patterns) is documented in `resources/playwright-review.md`. The SKILL.md entry point carries a concise checklist.

---

## What Playwright Can and Cannot Catch

### Can catch (visual QA tasks for Claude):
- Slide content overflowing the viewport
- Text wrapping in code/algorithm blocks
- Mermaid diagrams failing to render (raw text visible)
- Font loading failures
- CSS collision artifacts
- Fragment visibility errors
- Plugin initialization failures (console errors)
- Color contrast issues (by inspection)

### Cannot catch (still requires human):
- Pedagogical quality (is this slide teaching the right thing?)
- Aesthetic preferences (does this color feel right?)
- Content accuracy (is this algorithm correct?)
- Speaker performance fit (does this flow well when spoken?)

---

## Screenshot Archiving as Documentation

Screenshots can be saved as documentation:
- Before/after a major style change
- When a bug is found and fixed (visual record of the fix)
- As reference for "what the deck looked like on session date"

Store in `docs/screenshots/` with date prefix: `YYYY-MM-DD-[slide-description].png`

This creates a visual history that complements the git history of HTML changes.

---

## The 10th Directive Connection

The CLAUDE.md 10th Directive specifically grants Claude access to Playwright MCP and instructs dogfooding it as a methodology to document. This ADR is that documentation — the subskill `resources/playwright-review.md` is the implementation.

The directive notes that this methodology should become a documented subskill of the reveal.js skill itself. The implication: any future Claude Code session working with this skill should use Playwright to self-check rather than relying on the human to catch visual errors.

---

## Local Server Setup (required)

Playwright MCP operates over HTTP, not the file:// protocol. The reveal.js plugin system and some CDN features require HTTP headers that file:// doesn't provide.

**Quick start**:
```bash
# From the repo root:
python3 -m http.server 8765 --directory .
# Then navigate to: http://localhost:8765/path/to/presentation.html
```

Or for a specific directory:
```bash
python3 -m http.server 8765 --directory /path/to/slides
```

This must be running before Playwright can load the presentation.

---

## Notes

### NOT: 2026-02-28
Jérémie's framing: "The transfer of knowledge between human and model should be high quality. This is the kind of thing you can check with Playwright — the human shouldn't be doing what a machine can do." This is a principle of good human-AI collaboration: AI should self-check the things it can check, reserving human attention for judgments that genuinely require human perception and values.

The screenshot archiving idea is worth developing: a visual changelog could be a valuable artifact for courses that iterate across semesters.
