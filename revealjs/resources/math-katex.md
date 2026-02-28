# Subskill: Math with KaTeX

Load this when building presentations with proofs, formulas, or mathematical notation.

---

## Full KaTeX Setup

```html
<script src="https://cdn.jsdelivr.net/npm/reveal.js@5/plugin/math/math.js"></script>
```

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
  plugins: [ RevealMath.KaTeX ]
});
```

---

## Common KaTeX Patterns

```latex
\mathbb{E}[X]                          % Expectation
\mathbb{E}\!\left[2^{C_N}\right]       % \! = tighter spacing before bracket
\mathbb{E}[X \mid Y]                   % Conditional expectation
\text{Var}[X]                          % Variance
P(X = k) = \tfrac{1}{6}               % \tfrac = smaller inline fraction
\sum_{i=1}^{n} x_i \cdot p_i          % Sum with limits
\color{#4a90d9}{C_N}                   % Colored variable
\checkmark                             % ✓
\blacksquare                           % ■ (QED)
\binom{n}{k}                           % Binomial coefficient
\lfloor x \rfloor, \lceil x \rceil    % Floor/ceil
\approx, \leq, \geq, \neq             % Comparison operators
```

---

## Math Box CSS

```css
.math-box {
  background: #f0f6ff;
  border: 2px solid #4a90d9;
  border-radius: 6px;
  padding: 14px 20px;
  margin: 10px 0;
  line-height: 1.9;
}
.math-box .katex-display { margin: 0.3em 0; }
/* NEVER add white-space: pre-wrap — KaTeX handles its own layout */
```

Usage:
```html
<div class="math-box">
  \[ E[X] = \sum_{x} x \cdot P(X = x) \]
</div>
```

---

## Proof Steps Grid Pattern

Most effective teaching pattern for step-by-step proofs. Two-column: math steps on left, justification on right.

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
  <div>\(\mathbb{E}\!\left[2^{C_{N+1}}\right]\)</div>
  <div class="proof-step-reason"></div>

  <div>\(= \mathbb{E}\!\bigl[\mathbb{E}[2^{C_{N+1}} \mid C_N]\bigr]\)</div>
  <div class="proof-step-reason">[law of total expectation]</div>

  <div>\(= \mathbb{E}[2^{C_N} + 1]\)</div>
  <div class="proof-step-reason">[from previous step]</div>

  <div>\(= \mathbb{E}[2^{C_N}] + 1\)</div>
  <div class="proof-step-reason">[linearity of expectation]</div>

  <div class="proof-step-hr"></div>

  <div>\(= (N + 2) + 1 = N + 3 \checkmark\)</div>
  <div class="proof-step-reason">[inductive hypothesis]</div>
</div>
```

**Proof pedagogy rules:**
1. Name the property used in every proof line (`[linearity]`, `[law of total expectation]`)
2. Define before use — put definitions on a preceding slide
3. Show symbolic → numeric (formula → substitute → result)
4. Split complex inductive proofs across sub-slides
5. Explain the backwards engineering, not just the result

---

## Color-Coded Math Variables

Pick a color scheme per presentation and use it consistently across all slides. Never re-use a color for a different variable.

```css
:root {
  --color-N:   #CC7C5E;  /* true count / main variable */
  --color-C:   #4a90d9;  /* counter / secondary variable */
  --color-est: #53B467;  /* estimate / result */
  --color-E:   #8e6bb8;  /* E[·] expectation notation */
}
.math-N   { color: var(--color-N);   font-weight: bold; }
.math-C   { color: var(--color-C);   font-weight: bold; }
.math-est { color: var(--color-est); font-weight: bold; }
.math-E   { color: var(--color-E);   font-weight: bold; }
```

Usage: `<span class="math-N">\(N\)</span>` outside of KaTeX, or `\color{#CC7C5E}{N}` inside KaTeX.

---

## Notation Legend Box

Floating reference box positioned in corner — stays visible across multiple slides about the same topic.

```css
.notation-box {
  position: absolute;
  top: 4px; right: 8px;
  background: rgba(255,255,255,0.95);
  border: 1px solid #ccc;
  border-radius: 5px;
  padding: 5px 8px;
  font-size: 0.46em;
  z-index: 1000;
  line-height: 1.65;
}
.notation-box .nt-title {
  font-weight: bold; color: #555;
  margin-bottom: 2px;
  border-bottom: 1px solid #ddd; padding-bottom: 2px;
}
/* IMPORTANT: use <div class="nt-row">, NOT <span>, to avoid
   affecting inner <span class="math-N"> elements */
.notation-box .nt-row { display: block; white-space: nowrap; }
```

```html
<section style="position: relative;">
  <div class="notation-box">
    <div class="nt-title">Notation</div>
    <div class="nt-row"><span class="math-N">\(N\)</span> = true event count</div>
    <div class="nt-row"><span class="math-C">\(C\)</span> = counter value</div>
    <div class="nt-row"><span class="math-est">\(\hat{N}\)</span> = estimate</div>
  </div>
  <!-- slide content -->
</section>
```

**Bug to avoid:** `notation-box span { display: block }` also applies to inner `<span class="math-N">`, splitting symbols. Always use `div.nt-row`, not bare `span`.

---

## Slide Overflow Budget (700px slide)

| Element | Height |
|---|---|
| H2 title + bottom margin | ~65px |
| One `.proof-steps` row | ~28px |
| `.math-box` with 1 display equation | ~80px |
| `.idea-box` (2 lines) | ~65px |
| Paragraph text (1 line) | ~32px |
| Spacer / margin between elements | ~20px |
| **Usable total** | **~570px** |

If your slide exceeds budget: split into sub-slides. Never reduce font below 0.8em for math content.
