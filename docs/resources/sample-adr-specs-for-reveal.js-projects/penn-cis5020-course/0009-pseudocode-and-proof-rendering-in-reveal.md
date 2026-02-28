# ADR-0009: Pseudocode and Proof Rendering in Reveal.js

**Status**: Accepted
**Date**: 2026-02-17
**Context**: Lecture 7 slide construction revealed a recurring rendering issue with algorithm and proof boxes.

---

## Problem

Content inside custom CSS boxes (`.algorithm-box`, `.proof-box`) was collapsing into a single unreadable line because HTML ignores whitespace by default. The symptom: multi-line pseudocode and step-by-step math proofs displayed on one line. The user had to manually add `<pre>` tags inside boxes after the fact.

---

## Root Cause

Custom CSS box classes (with `font-family: monospace`) do NOT preserve whitespace unless explicitly told to. HTML's default is to collapse all consecutive whitespace (spaces, newlines, tabs) into a single space.

This means content written naturally like:

```html
<div class="algorithm-box">
Initialize: C ← 1
For each event:
  With probability 1/2^C: C ← C + 1
Estimate: 2^C - 2
</div>
```

renders as a single unbroken line.

---

## Solution: CSS `white-space: pre-wrap`

**Add to any box class that needs to display preformatted text:**

```css
.algorithm-box {
    white-space: pre-wrap;  /* ← THIS IS THE KEY */
    font-family: 'Courier New', monospace;
    /* ... other styles ... */
}

.proof-box {
    white-space: pre-wrap;  /* ← THIS IS THE KEY */
    font-family: 'Courier New', monospace;
    /* ... other styles ... */
}
```

### `pre-wrap` vs `pre` vs `nowrap`:
- `pre`: preserves whitespace, **no wrapping** (lines can overflow the slide)
- `pre-wrap`: preserves whitespace, **wraps long lines** ← use this for slides
- `nowrap`: collapses whitespace, never wraps (worst of both worlds)

---

## What NOT To Do

### ❌ Do NOT wrap content in `<pre>` inside a styled box:

```html
<div class="algorithm-box">
  <pre>
  Initialize: C ← 1
  For each event:
    With probability 1/2^C: C ← C + 1
  </pre>
</div>
```

**Why this is bad:**
1. `<pre>` renders in browser's default monospace at default sizing (may clash with box font-size)
2. The newline after `<pre>` and before `</pre>` adds extra blank lines
3. Any indentation of the `<pre>` tag itself appears in the rendered output
4. `<strong>`, `<em>` still work inside `<pre>`, but it's fragile
5. It's a band-aid, not a fix — the next box you create will have the same problem

### ❌ Do NOT use `<pre>` inside regular HTML boxes (idea-box, etc.):

```html
<!-- BAD: idea-box content uses <br/> for line breaks, not preformatted text -->
<div class="idea-box">
  <pre>
    <strong>Die roll:</strong><br/>
    E[X] = 3.5<br/>
  </pre>
</div>
```

This makes the content monospaced and adds leading whitespace from the `<pre>` tag's indentation.

---

## Rules by Box Type

| Box type | Has `white-space: pre-wrap`? | Line breaks | Indentation |
|---|---|---|---|
| `.algorithm-box` | YES (set in CSS) | Natural (in source) | Natural (in source) |
| `.proof-box` | YES (set in CSS) | Natural (in source) | Natural (in source) |
| `.idea-box` | NO | Use `<br/>` | Use `&nbsp;` chains |
| `.student-quote` | NO | Use `<br/>` or `<p>` | Use `&nbsp;` |
| Regular `<p>` | NO | Use `<br/>` | Use `&nbsp;` or CSS padding |

---

## Indentation in Regular HTML Boxes

For `.idea-box` and similar non-`pre-wrap` elements, indentation must be explicit:

```html
<div class="idea-box">
    <strong>Die roll:</strong><br/>
    E[X] = 3.5<br/>
    You never observe 3.5.<br/>
    &nbsp;&nbsp;&nbsp;&nbsp;(It's a long-run average)
</div>
```

- Line breaks: `<br/>`
- Indentation: `&nbsp;` (one per space width) or CSS `padding-left`
- Bold/italic: `<strong>`, `<em>` work normally

---

## The Algorithm Box Pattern (Canonical Example)

```html
<!-- CORRECT: CSS handles whitespace, content is just plain text -->
<div class="algorithm-box">
Morris Algorithm:
  Initialize: C ← 1
  For each event:
    With probability 1/2^C: C ← C + 1
  Estimate: N̂ = 2^C − 2
</div>
```

```html
<!-- CORRECT: Proof box with math, mixed bold -->
<div class="proof-box">
<strong>Claim:</strong> E[2^{C_N}] = N + 2

<strong>Base case (N = 0):</strong>
  C_0 = 1  (initial value)
  E[2^{C_0}] = 2^1 = 2 = 0 + 2  ✓
</div>
```

Note: `<strong>` inside a `white-space: pre-wrap` div still renders bold correctly. HTML tags are still interpreted.

---

## Checklist for New Slides

When creating pseudocode or proof boxes:

- [ ] Does the CSS class have `white-space: pre-wrap`? If not, add it.
- [ ] Is the content plain text with natural indentation? (Good)
- [ ] Is there a `<pre>` inside the box? Remove it.
- [ ] For idea-boxes needing indentation: using `&nbsp;` or `<br/>`?
- [ ] Test by viewing the slide — does the content display as multiple lines?

---

## Related

- ADR-0007: Reveal.js CSS Baseline (font sizes, line heights)
- ADR-0008: Mermaid Plugin for Reveal.js
