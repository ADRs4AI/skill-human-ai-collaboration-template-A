# Subskill: Pseudocode and Algorithm Rendering

Load this when presenting algorithms, pseudocode, proofs, or any preformatted text that needs indentation preserved.

---

## The Core Problem

HTML collapses consecutive whitespace by default. Pseudocode written as:

```
Morris Algorithm:
  Initialize: C ← 1
  For each event:
    With probability 1/2^C: C ← C + 1
```

...renders as a single line: `Morris Algorithm: Initialize: C ← 1 For each event: With probability 1/2^C: C ← C + 1`

**The fix**: `white-space: pre-wrap` on the container CSS. Not `<pre>` wrapping.

---

## The Rule

`white-space: pre-wrap` preserves whitespace and indentation, **and wraps long lines** (unlike `white-space: pre` which overflows).

| Property | Preserves whitespace | Wraps long lines | Use for |
|---|---|---|---|
| `white-space: pre` | ✅ | ❌ overflows | Never in slides |
| `white-space: pre-wrap` | ✅ | ✅ | Algorithm boxes, proof boxes |
| `white-space: nowrap` | ❌ | ❌ | Notation labels |
| (none / normal) | ❌ | ✅ | Regular text |

---

## Algorithm Box

```css
.algorithm-box {
  white-space: pre-wrap;        /* ← THE KEY */
  font-family: 'Courier New', monospace;
  background: #f8f8f8;
  padding: 12px 16px;
  border-left: 4px solid #888;
  font-size: 0.85em;
  line-height: 1.5;
  margin: 12px 0;
  border-radius: 2px;
}
```

Usage — write content as plain text, indentation preserved by CSS:
```html
<div class="algorithm-box">
Morris Algorithm:
  Initialize: C ← 1
  For each event:
    With probability 1/2^C: increment C
    Otherwise: do nothing
  Estimate: N̂ = 2^C − 2
</div>
```

**Never** use `<pre>` inside `.algorithm-box` — it conflicts with font sizing and adds double newlines.

---

## Proof Box

Same pattern, slightly different styling for mathematical proofs:

```css
.proof-box {
  white-space: pre-wrap;        /* ← REQUIRED */
  font-family: 'Courier New', monospace;
  background: #f0f6ff;
  padding: 12px 16px;
  border-left: 4px solid #4a90d9;
  font-size: 0.85em;
  line-height: 1.6;
  margin: 12px 0;
}
```

```html
<div class="proof-box">
Base case (N=0): E[2^C_0] = 2^1 = 2 = 0 + 2 ✓

Inductive step: Assume E[2^C_N] = N + 2.
  Show: E[2^C_{N+1}] = N + 3.

  E[2^C_{N+1}] = E[E[2^C_{N+1} | C_N]]   (tower property)
               = E[2^C_N + 1]             (from step law)
               = E[2^C_N] + 1             (linearity)
               = (N + 2) + 1 = N + 3 ✓
</div>
```

Note: `<strong>` inside `white-space: pre-wrap` works normally — HTML tags are still interpreted.

---

## Which Box for Which Content

| Box type | `white-space: pre-wrap`? | Line breaks | Indentation |
|---|---|---|---|
| `.algorithm-box` | YES (in CSS) | Natural | Natural |
| `.proof-box` | YES (in CSS) | Natural | Natural |
| `.code-box` (styled code) | NO — use `<pre>` inside | `<br>` or `<pre>` | CSS padding |
| `.idea-box` | NO | Use `<br/>` | Use `&nbsp;` chains |
| `.math-box` | NEVER — KaTeX handles | KaTeX | KaTeX |

---

## Special Characters for Pseudocode

Use HTML entities or Unicode directly in the HTML:

| Symbol | HTML/Unicode | Meaning |
|---|---|---|
| `←` | `←` or `\u2190` | Assignment |
| `→` | `→` or `\u2192` | Return / implication |
| `≤` | `≤` | Less than or equal |
| `≥` | `≥` | Greater than or equal |
| `≠` | `≠` | Not equal |
| `∈` | `∈` | Element of |
| `∅` | `∅` | Empty set |
| `⌊x⌋` | `⌊x⌋` | Floor |
| `⌈x⌉` | `⌈x⌉` | Ceiling |
| `N̂` | `N&#770;` | N-hat (estimate) |
| `√` | `√` | Square root |

For complex math inside algorithm boxes, mix with KaTeX inline (`\(formula\)`) where needed.

---

## Fragment-Based Algorithm Reveal

To step through algorithm phases with fragments:

```html
<section>
  <h2>Morris Algorithm</h2>
  <div class="algorithm-box">Initialize: C ← 1</div>

  <div class="algorithm-box fragment">
For each event:
  With probability 1/2^C: C ← C + 1
  Otherwise: do nothing
  </div>

  <div class="algorithm-box fragment">
Estimate: N̂ = 2^C − 2
  </div>
</section>
```

Each box is a fragment — algorithm builds up phase by phase.

---

## Highlighted Lines in Code (RevealHighlight)

For actual code (not pseudocode), use `<pre><code>` with RevealHighlight:

```html
<pre><code class="python" data-line-numbers="1-3|4-6|7">
def morris_count():
    C = 1                    # Initialize
    for event in stream:
        if random() < 1/2**C:  # Flip biased coin
            C += 1
    return 2**C - 2          # Estimate
</code></pre>
```

`data-line-numbers="1-3|4-6|7"` steps through line groups with each advance. Requires `RevealHighlight` plugin.
