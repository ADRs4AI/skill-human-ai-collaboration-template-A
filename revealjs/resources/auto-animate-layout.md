# Subskill: Auto-Animate and Layout Helpers

Load this when using smooth element transitions between slides, big-text titles, image stretching, or stacked fragment reveals.

---

## Auto-Animate

Auto-animate smoothly transitions matching elements between consecutive slides. No CSS needed — add `data-auto-animate` to two consecutive sections.

### Basic: elements matched by tag + content

```html
<!-- Elements matched automatically by tag type + content -->
<section data-auto-animate>
  <h2>Step One</h2>
  <p>Initial state</p>
</section>
<section data-auto-animate>
  <h2>Step One</h2>          <!-- matched → animates position/size changes -->
  <p>Updated state</p>       <!-- unmatched → fades in -->
</section>
```

### Explicit matching with data-id

```html
<section data-auto-animate>
  <div data-id="box" style="width: 60px; height: 60px; background: #fff;"></div>
</section>
<section data-auto-animate>
  <div data-id="box" style="width: 200px; height: 200px; background: #4a90d9;"></div>
</section>
<!-- The box smoothly grows and changes color -->
```

### Animating code evolution (most common use case)

```html
<section data-auto-animate>
  <pre data-id="code"><code class="python" data-trim>
def fibonacci(n):
    return n
  </code></pre>
</section>
<section data-auto-animate>
  <pre data-id="code"><code class="python" data-trim>
def fibonacci(n):
    if n <= 1:
        return n
    return fibonacci(n-1) + fibonacci(n-2)
  </code></pre>
</section>
<!-- Code additions animate smoothly — great for teaching algorithm evolution -->
```

### Moving elements to emphasis positions

```html
<section data-auto-animate>
  <h3>Morris Algorithm</h3>
  <p>Initialize: C ← 1</p>
  <p>For each event: flip coin...</p>
  <p>Estimate: 2^C − 2</p>
</section>
<section data-auto-animate>
  <h3>Morris Algorithm</h3>
  <p>Initialize: C ← 1</p>
  <p class="highlight-box" style="font-size: 1.4em; color: #CC7C5E;">
    For each event: flip coin...
  </p>
  <p>Estimate: 2^C − 2</p>
</section>
<!-- The highlighted line scales up in place -->
```

### Auto-animate with fragments

```html
<section data-auto-animate>
  <h2 data-id="title" style="font-size: 1.4em;">Watchmaker Parable</h2>
</section>
<section data-auto-animate>
  <h2 data-id="title" style="font-size: 0.9em; color: #888;">Watchmaker Parable</h2>
  <!-- Title shrinks and dims as content appears -->
  <ul>
    <li class="fragment">Tempus: assemble all 1000 parts directly</li>
    <li class="fragment">Hora: stable subassemblies of 10 parts each</li>
    <li class="fragment">Interruption destroys Tempus; Hora just loses one subassembly</li>
  </ul>
</section>
```

### Key attributes

| Attribute | Effect |
|---|---|
| `data-auto-animate` | Enable on this section |
| `data-id="name"` | Explicitly match this element across slides |
| `data-auto-animate-easing` | CSS easing (e.g. `"cubic-bezier(0.77, 0, 0.18, 1)"`) |
| `data-auto-animate-unmatched` | How unmatched elements appear: `"fade"`, `"slide"` |
| `data-auto-animate-delay` | Delay before animation (seconds) |
| `data-auto-animate-id="group"` | Group slides — only animate within same group |

### Grouping animation sequences

```html
<!-- Group A: only animates with other group-a slides -->
<section data-auto-animate data-auto-animate-id="group-a">...</section>
<section data-auto-animate data-auto-animate-id="group-a">...</section>

<!-- Group B: separate animation sequence -->
<section data-auto-animate data-auto-animate-id="group-b">...</section>
<section data-auto-animate data-auto-animate-id="group-b">...</section>
```

---

## Layout Helpers

Built-in CSS classes that solve common presentation layout problems without custom CSS.

### r-fit-text — fill the container width

Text scales to be as large as possible within the slide width. Perfect for impactful single-word or short-phrase slides.

```html
<section>
  <h1 class="r-fit-text">BIG IDEA</h1>
</section>

<section>
  <h2 class="r-fit-text">The Watchmaker Parable</h2>
  <h2 class="r-fit-text">in Three Steps</h2>
</section>
```

### r-stretch — fill remaining vertical space

Makes one element as tall as possible while leaving room for other slide content. Essential for images you want to maximize without overflow.

```html
<section>
  <h2>Algorithm Flowchart</h2>
  <img src="flowchart.png" class="r-stretch">
  <!-- Image fills all remaining space below the h2 -->
  <p style="font-size: 0.6em;">Figure 1: Morris approximate counting</p>
</section>
```

Only works on one element per slide. Best with images and iframes.

### r-stack — layer elements on top of each other

Positions multiple children at the same location (centered, stacked). Use with fragments for reveal effects where elements replace each other.

```html
<!-- Progressive image reveal: each image fades in over the previous -->
<section>
  <div class="r-stack">
    <img src="step1.png" class="fragment fade-in-then-out" width="600">
    <img src="step2.png" class="fragment fade-in-then-out" width="600">
    <img src="step3.png" class="fragment" width="600">
  </div>
</section>

<!-- Text replacement: one sentence at a time -->
<div class="r-stack">
  <p class="fragment fade-in-then-out">First interpretation</p>
  <p class="fragment fade-in-then-out">Second interpretation</p>
  <p class="fragment">Final synthesis</p>
</div>
```

### r-hstack — horizontal stack (flexbox row)

Arranges children in a horizontal row, centered.

```html
<section>
  <h2>Comparison</h2>
  <div class="r-hstack" style="gap: 2em;">
    <div style="background: #f0f6ff; padding: 1em; border-radius: 8px;">
      <h3>Approach A</h3>
      <p>O(n) space</p>
    </div>
    <div style="background: #f0fff0; padding: 1em; border-radius: 8px;">
      <h3>Approach B</h3>
      <p>O(1) space</p>
    </div>
  </div>
</section>
```

### r-vstack — vertical stack (flexbox column)

Arranges children in a vertical column, centered.

```html
<div class="r-vstack" style="gap: 0.5em; align-items: stretch;">
  <div class="step-box">Step 1: Initialize</div>
  <div class="step-box">Step 2: Iterate</div>
  <div class="step-box">Step 3: Return</div>
</div>
```

---

## Complete Fragment Styles

SKILL.md only shows 4 fragment styles. The full list:

```html
<!-- Appearance -->
<p class="fragment">fade-in (default)</p>
<p class="fragment fade-up">fade-up</p>
<p class="fragment fade-down">fade-down</p>
<p class="fragment fade-left">fade-left</p>
<p class="fragment fade-right">fade-right</p>
<p class="fragment fade-out">fade-out</p>
<p class="fragment fade-in-then-out">fade-in-then-out</p>
<p class="fragment fade-in-then-semi-out">fade-in-then-semi-out</p>

<!-- Size -->
<p class="fragment grow">grow</p>
<p class="fragment shrink">shrink</p>

<!-- Text effects -->
<p class="fragment strike">strike</p>

<!-- Persistent highlights (stay highlighted) -->
<p class="fragment highlight-red">highlight-red</p>
<p class="fragment highlight-green">highlight-green</p>
<p class="fragment highlight-blue">highlight-blue</p>

<!-- Current highlights (only while active, reverts on next fragment) -->
<p class="fragment highlight-current-red">highlight-current-red</p>
<p class="fragment highlight-current-green">highlight-current-green</p>
<p class="fragment highlight-current-blue">highlight-current-blue</p>
```

**Nested fragments** (chain effects):
```html
<span class="fragment">
  Fade in first
  <span class="fragment highlight-red">then highlight red</span>
</span>
```

---

## Backgrounds: Full Reference

The SKILL.md covers `data-background-color`. Complete options:

```html
<!-- Solid color (three equivalent forms) -->
<section data-background="#4a90d9">
<section data-background-color="#4a90d9">
<section data-background="rgba(74, 144, 217, 0.8)">

<!-- Gradient -->
<section data-background-gradient="linear-gradient(140deg, #1B3A6B 0%, #E07340 100%)">

<!-- Image -->
<section data-background-image="image.png"
         data-background-size="cover"        <!-- cover/contain/100px -->
         data-background-position="center"   <!-- CSS position values -->
         data-background-repeat="no-repeat"  <!-- repeat/repeat-x/etc -->
         data-background-opacity="0.3">      <!-- 0-1, dims behind content -->

<!-- Video -->
<section data-background-video="video.mp4"
         data-background-video-loop
         data-background-video-muted>

<!-- Iframe (interactive) -->
<section data-background-iframe="https://example.com"
         data-background-interactive>

<!-- Per-slide background transition (overrides global) -->
<section data-background="#4a90d9" data-background-transition="zoom">

<!-- Apply background to entire stack -->
<section data-background-color="#111">
  <section>All sub-slides share this background</section>
  <section data-background-color="#222">Override for this one</section>
</section>
```
