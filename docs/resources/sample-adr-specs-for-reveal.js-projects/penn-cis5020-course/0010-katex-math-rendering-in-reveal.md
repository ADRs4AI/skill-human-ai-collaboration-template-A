# ADR-0010: KaTeX Math Rendering in Reveal.js Slides

**Status**: Accepted
**Date**: 2026-02-19
**Supersedes**: ADR-0009 for math content (ADR-0009 remains valid for pseudocode)
**Canonical example**: `lectures/lecture07/sandbox/math-sandbox-v2.html`

---

## Why This Exists

In lecture 7, we built math-heavy slides twice: once wrong (plain text in `pre`/`proof-box`), once right (KaTeX). The wrong version looked like typewriter output. The right version looked like a textbook. The delta in student comprehension is significant.

This ADR documents how to get to the right version immediately next time.

---

## The One-Line Rule

> **Any slide with a formula uses KaTeX. No exceptions. Plain text math is never acceptable.**

Plain text like `E[2^C] = N + 2` looks amateurish and is harder to read.
KaTeX renders `\(\mathbb{E}[2^C] = N + 2\)` as beautiful typeset math.

---

## Setup (Copy This Every Time)

### 1. Load the plugin (local, no CDN needed)

```html
<script src="../../../plugin/math/math.js"></script>
```

Path varies by slide location relative to repo root. Check `plugin/math/` exists.

### 2. Initialize with KaTeX

```javascript
Reveal.initialize({
    katex: {
        version: 'latest',
        delimiters: [
            { left: '$$',  right: '$$',  display: true  },
            { left: '\\[', right: '\\]', display: true  },
            { left: '$',   right: '$',   display: false },
            { left: '\\(', right: '\\)', display: false }
        ],
        ignoredTags: ['script', 'noscript', 'style', 'textarea', 'pre']
    },
    plugins: [ RevealNotes, RevealMath.KaTeX ]
});
```

**Why KaTeX over MathJax?** Faster render, no flicker on slide change. Sufficient for everything in this course.

---

## Delimiters Quick Reference

| What you write | What renders | When to use |
|---|---|---|
| `\( E[X] \)` | inline math | inside sentences |
| `\[ E[X] = \sum x \cdot P(X=x) \]` | display/block math | standalone equations |
| `$...$` | inline math | shorthand (works but less readable) |
| `$$...$$` | display math | shorthand |

**Note**: `ignoredTags` includes `pre` — math inside `<pre>` or `.algorithm-box` will NOT be rendered. This is correct: pseudocode stays plain text, math gets KaTeX.

---

## The `.math-box` Container

For blocks containing math, use `.math-box` instead of `.proof-box`:

```css
/* Math display box — KaTeX handles spacing, no pre-wrap needed */
.math-box {
    background: #f0f6ff;
    border: 2px solid #4a90d9;
    border-radius: 6px;
    padding: 14px 20px;
    margin: 10px 0;
    line-height: 1.9;
}
.math-box .katex-display { margin: 0.3em 0; }
```

```html
<!-- CORRECT: KaTeX inside math-box -->
<div class="math-box">
    \[ \mathbb{E}[C] = \frac{N}{2} \]
    Therefore:
    \[ \mathbb{E}[2C] = N \checkmark \]
</div>
```

**Never use `white-space: pre-wrap` on `.math-box`** — KaTeX renders its own layout.
**Keep `white-space: pre-wrap` on `.algorithm-box`** — pseudocode still needs it (see ADR-0009).

---

## The Proof Steps Grid Pattern

The single most effective pattern for teaching proofs: a two-column grid with math on the left and justification in grey italic on the right.

```css
.proof-steps {
    display: grid;
    grid-template-columns: 1fr auto;
    gap: 2px 18px;
    align-items: baseline;
    padding: 14px 18px;
    background: #f0f6ff;
    border: 2px solid #4a90d9;
    border-radius: 6px;
    margin: 10px 0;
    font-size: 0.9em;
    line-height: 1.8;
}
.proof-step-math { }
.proof-step-reason {
    color: #888;
    font-style: italic;
    font-size: 0.82em;
    white-space: nowrap;
    text-align: right;
}
.proof-step-hr {
    grid-column: 1 / -1;
    border: none;
    border-top: 1px dashed #aac4e8;
    margin: 4px 0;
}
```

```html
<div class="proof-steps">
    <div class="proof-step-math">
        \(\mathbb{E}\!\left[2^{C_{N+1}}\right]\)
    </div>
    <div class="proof-step-reason"></div>

    <div class="proof-step-math">
        \(= \mathbb{E}\!\bigl[\mathbb{E}[2^{C_{N+1}} \mid C_N]\bigr]\)
    </div>
    <div class="proof-step-reason">[law of total expectation]</div>

    <div class="proof-step-math">
        \(= \mathbb{E}[2^{C_N} + 1]\)
    </div>
    <div class="proof-step-reason">[from previous step]</div>

    <div class="proof-step-math">
        \(= \mathbb{E}[2^{C_N}] + 1\)
    </div>
    <div class="proof-step-reason">[linearity of expectation]</div>

    <div class="proof-step-math">
        \(= (N + 2) + 1 = N + 3 \checkmark\)
    </div>
    <div class="proof-step-reason">[inductive hypothesis]</div>
</div>
```

**Rule**: every math line has a paired reason div (can be empty for headers). The `auto` column makes the reason column only as wide as the widest justification.

---

## Systematic Color Scheme for Math Variables

Pick colors once per lecture and use them consistently across ALL slides. Students track variables by color under cognitive load.

```css
:root {
    --color-N:    #CC7C5E;  /* N = true count (course orange) */
    --color-C:    #4a90d9;  /* C = counter variable (blue) */
    --color-est:  #53B467;  /* estimate / result (green) */
    --color-E:    #8e6bb8;  /* E[·] expectation notation (purple) */
}
.math-N   { color: var(--color-N);   font-weight: bold; }
.math-C   { color: var(--color-C);   font-weight: bold; }
.math-est { color: var(--color-est); font-weight: bold; }
.math-E   { color: var(--color-E);   font-weight: bold; }
```

**In KaTeX**, use `\color{#hex}{symbol}`:
```html
\(\mathbb{E}\!\left[2^{\color{#4a90d9}{C_N}}\right] = \color{#CC7C5E}{N} + 2\)
```

**In HTML text**, use the CSS classes:
```html
<span class="math-N">N</span> is the true count.
```

**Never** introduce a new color mid-proof. If you've used blue for C, every C must be blue on every slide.

---

## The Notation Legend Box

On proof-heavy slides, include a small legend box so students can look up symbols without leaving the slide.

```css
.notation-box {
    position: absolute;
    top: 4px;
    right: 8px;
    background: rgba(255,255,255,0.95);
    border: 1px solid #ccc;
    border-radius: 5px;
    padding: 5px 8px;
    font-size: 0.46em;
    z-index: 1000;
    line-height: 1.65;
}
.notation-box .nt-title {
    font-weight: bold;
    color: #555;
    margin-bottom: 2px;
    border-bottom: 1px solid #ddd;
    padding-bottom: 2px;
}
/* IMPORTANT: use .nt-row divs, NOT spans */
/* span { display: block } would break inner colored spans */
.notation-box .nt-row {
    display: block;
    white-space: nowrap;
}
```

```html
<div class="notation-box">
    <div class="nt-title">Notation</div>
    <div class="nt-row"><span class="math-N">N</span> — events seen so far</div>
    <div class="nt-row"><span class="math-C">C</span> — Morris counter value</div>
    <div class="nt-row"><span class="math-E">E[·]</span> — expected value</div>
</div>
```

**Positioning**: `position: absolute; top: 4px; right: 8px` places it at the top-right of the slide section. This works correctly because Reveal.js uses CSS transforms, making `position: absolute` relative to the slide canvas (not the viewport). Do NOT use `position: fixed` — it interacts badly with Reveal.js transforms.

**Key bug to avoid**: If you write `.notation-box span { display: block }`, it will also apply to the inner `<span class="math-N">` etc., splitting the symbol onto its own line away from the description. Always use `.nt-row` class on `<div>` elements, not bare `<span>`.

---

## Proof Pedagogy: How to Structure a Proof Slide

Learned from student feedback and live teaching. Apply these rules:

### 1. Define before use
Introduce expectation, variance, and standard deviation on dedicated slides **before** the first slide that uses them. Students cannot follow `Var[C] = N/4` if Var was never defined.

### 2. Show symbolic then numeric
For expectation calculations, first write the formula symbolically, then substitute numbers:
```
E[C₁] = 0·P(C₁=0) + 1·P(C₁=1)    [formula]
       = 0·(1/2)   + 1·(1/2)        [substitute]
       = 1/2                          [result]
```
Never skip straight to numbers — students can't distinguish formula-application from magic.

### 3. Split complex inductive proofs into sub-slides
- Slide A: "What happens at event N+1?" — draw the two cases (increment / stay) visually
- Slide B: "Compute the conditional expectation" — the algebra, step by step with justifications
- Slide C: "Close the induction" — the final chain, law of total expectation → linearity → IH

### 4. Name the property being used
Every line of a proof should reference a named property:
- `[linearity of expectation]`
- `[law of total expectation]`
- `[inductive hypothesis]`
- `[definition of conditional expectation]`
- `[algebra: 2^{k+1} = 2·2^k]`

### 5. Explain the design, not just the result
"Beautiful" or "elegant" tells students nothing. Instead, explain the backwards engineering:
> "We chose probability 1/2^k so that P(increment) × jump = (1/2^k)(2^k) = 1. The algorithm was designed to make E[2^C] increase by exactly 1 per event."

### 6. Put the Properties of Expectation on its own slide
Before any proof, dedicate one slide to:
- Linearity: `E[X+Y] = E[X]+E[Y]` (even if dependent)
- Scaling: `E[cX] = cE[X]`
- Law of total expectation: `E[X] = E[E[X|Y]]`

Students forget these. Having the slide makes the proof flow instead of stall.

---

## Common KaTeX Patterns for This Course

```latex
% Expectation
\mathbb{E}[X]
\mathbb{E}\!\left[2^{C_N}\right]   % tighter spacing with \!

% Conditional expectation
\mathbb{E}[X \mid Y]
\mathbb{E}\!\left[2^{C_{N+1}} \mid C_N = k\right]

% Variance / std dev
\text{Var}[X]
\sigma[X] = \sqrt{\text{Var}[X]}

% Probability
P(X = k) = \tfrac{1}{6}    % \tfrac = smaller fraction

% Sums
\sum_{i=1}^{n} x_i \cdot p_i

% Alignment (multiple lines)
\begin{aligned}
\mathbb{E}[C] &= \frac{N}{2} \\
\mathbb{E}[2C] &= N
\end{aligned}

% Underbrace labels (great for proof steps)
\underbrace{\frac{1}{2^k}}_{\text{P(A)}} \cdot \underbrace{2^{k+1}}_{\text{Case A}}

% Colored variables
\color{#4a90d9}{C_N}
\color{#CC7C5E}{N}

% Checkmark, QED
\checkmark
\blacksquare
```

---

## Slide Overflow Prevention

Reveal.js silently clips content that exceeds slide height (960×700px default). Nothing warns you. Rules of thumb for a 700px slide:

| Element | Approximate height |
|---|---|
| H2 title + act-divider | ~65px |
| One `.proof-steps` row | ~28px |
| `.math-box` with 1 display equation | ~80px |
| `.idea-box` (2 lines) | ~65px |
| Paragraph text | ~32px |
| Spacer margin | ~20px |

**Budget**: ~570px usable after title. A 6-row `proof-steps` block + 1 `idea-box` ≈ 168 + 65 = 233px. Two `math-box` blocks ≈ 160px. Total ≈ 393px — fits.

**When in doubt**: open in browser, check if the last element is visible. If the bottom of the last `idea-box` is cut off, either reduce `padding`/`margin` values or split into two slides.

---

## File Template

Minimal starter for a math-heavy slide deck:

```html
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <link rel="stylesheet" href="../../dist/reset.css">
    <link rel="stylesheet" href="../../dist/reveal.css">
    <link rel="stylesheet" href="../../dist/theme/simple.css">
    <style>
        :root {
            --r-background-color: #FAF9F5;
            --r-main-font-size: 26px;
            --color-N: #CC7C5E;
            --color-C: #4a90d9;
            --color-est: #53B467;
            --color-E: #8e6bb8;
        }
        /* paste in: .math-box, .proof-steps, .proof-step-math,
           .proof-step-reason, .proof-step-hr, .notation-box,
           .nt-title, .nt-row, .math-N, .math-C, .math-est, .math-E
           from math-sandbox-v2.html */
    </style>
</head>
<body>
<div class="reveal"><div class="slides">

    <section>
        <h2>Your Slide Title</h2>
        <div class="math-box">
            \[ \text{your equation here} \]
        </div>
        <div class="proof-steps">
            <div class="proof-step-math">\( \text{step} \)</div>
            <div class="proof-step-reason">[justification]</div>
        </div>
    </section>

</div></div>
<script src="../../dist/reveal.js"></script>
<script src="../../plugin/notes/notes.js"></script>
<script src="../../plugin/math/math.js"></script>
<script>
    Reveal.initialize({
        hash: true,
        slideNumber: 'c/t',
        katex: {
            delimiters: [
                { left: '\\[', right: '\\]', display: true },
                { left: '\\(', right: '\\)', display: false }
            ],
            ignoredTags: ['script','noscript','style','textarea','pre']
        },
        plugins: [ RevealNotes, RevealMath.KaTeX ]
    });
</script>
</body>
</html>
```

---

## Relationship to Other ADRs

- **ADR-0007** (CSS Baseline): font sizes, colors, idea-box styles — still applies
- **ADR-0008** (Mermaid): flowcharts use their own plugin, no conflict with KaTeX
- **ADR-0009** (Pseudocode): `.algorithm-box` with `white-space: pre-wrap` for code — still applies. Pseudocode and math coexist on the same slide; they use different containers
- **This ADR (0010)**: `.math-box`, `.proof-steps`, KaTeX delimiters, notation box, color scheme

The pattern for a mixed slide: algorithm in `.algorithm-box` (preformatted), math in `.math-box` or `.proof-steps` (KaTeX), no mixing.
