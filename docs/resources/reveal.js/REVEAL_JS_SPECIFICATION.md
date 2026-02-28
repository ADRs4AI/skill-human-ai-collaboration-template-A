# reveal.js Format Specification

## Table of Contents
1. [Introduction](#introduction)
2. [Basic Structure](#basic-structure)
3. [Slides](#slides)
4. [Markdown Support](#markdown-support)
5. [Auto-Animate](#auto-animate)
6. [Backgrounds](#backgrounds)
7. [Layout Helpers](#layout-helpers)
8. [Transitions](#transitions)
9. [Fragments](#fragments)
10. [Code Highlighting](#code-highlighting)
11. [Math Support](#math-support)
12. [Media](#media)
13. [Lightbox/Preview](#lightbox-preview)
14. [Configuration](#configuration)
15. [Plugins](#plugins)
16. [Advanced Features](#advanced-features)

---

## Introduction

reveal.js is an open source HTML presentation framework that enables anyone with a web browser to create beautiful presentations. The framework uses standard HTML markup with special attributes to create slides and control presentation behavior.

Key Features:
- Nested slides (horizontal and vertical navigation)
- Markdown support
- Auto-Animate for smooth transitions
- PDF export
- Speaker notes
- LaTeX typesetting
- Syntax highlighted code
- Extensive JavaScript API

---

## Basic Structure

### Minimal HTML Structure

The bare minimum required to create a reveal.js presentation:

```html
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>reveal.js - Presentation Title</title>
    <link rel="stylesheet" href="dist/reveal.css">
  </head>
  <body>
    <div class="reveal">
      <div class="slides">

        <section>
          <h2>Slide 1</h2>
          <p>Content goes here</p>
        </section>

        <section>
          <h2>Slide 2</h2>
          <p>More content</p>
        </section>

      </div>
    </div>

    <script src="dist/reveal.js"></script>
    <script>
      Reveal.initialize();
    </script>
  </body>
</html>
```

### Standard Structure with Theme

```html
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">

    <title>reveal.js</title>

    <link rel="stylesheet" href="dist/reset.css">
    <link rel="stylesheet" href="dist/reveal.css">
    <link rel="stylesheet" href="dist/theme/black.css">

    <!-- Theme used for syntax highlighted code -->
    <link rel="stylesheet" href="plugin/highlight/monokai.css">
  </head>
  <body>
    <div class="reveal">
      <div class="slides">
        <section>Slide 1</section>
        <section>Slide 2</section>
      </div>
    </div>

    <script src="dist/reveal.js"></script>
    <script src="plugin/notes/notes.js"></script>
    <script src="plugin/markdown/markdown.js"></script>
    <script src="plugin/highlight/highlight.js"></script>
    <script>
      Reveal.initialize({
        hash: true,
        plugins: [ RevealMarkdown, RevealHighlight, RevealNotes ]
      });
    </script>
  </body>
</html>
```

---

## Slides

### Horizontal Slides

Each `<section>` element represents a slide. By default, slides are arranged horizontally:

```html
<div class="slides">
  <section>Slide 1</section>
  <section>Slide 2</section>
  <section>Slide 3</section>
</div>
```

### Vertical Slides (Nested)

Nest `<section>` elements to create vertical slides:

```html
<section>
  <section>
    <h2>Vertical Slides</h2>
    <p>Slides can be nested inside of each other.</p>
  </section>
  <section>
    <h2>Basement Level 1</h2>
    <p>Nested slides are useful for adding additional detail.</p>
  </section>
  <section>
    <h2>Basement Level 2</h2>
    <p>That's it, time to go back up.</p>
  </section>
</section>
```

### Slide IDs and Links

Slides can have IDs for navigation:

```html
<section id="my-slide">
  <h2>Slide with ID</h2>
  <p>Link to this slide: <a href="#/my-slide">Go to slide</a></p>
</section>
```

Link to specific slide indices:

```html
<a href="#/2/3">Link to horizontal slide 2, vertical slide 3</a>
```

### Slide Attributes

#### data-id
Used with Auto-Animate to track elements across slides:

```html
<section>
  <h2 data-id="title">Title</h2>
</section>
<section>
  <h2 data-id="title">Same Title, Different Position</h2>
</section>
```

#### data-visibility
Control slide visibility:

```html
<section data-visibility="hidden">
  <h2>Hidden Slide</h2>
  <p>This slide is hidden by default but can be shown with showHiddenSlides config.</p>
</section>
```

#### data-state
Add custom classes to the document element when slide is active:

```html
<section data-state="customevent">
  <h2>State Events</h2>
  <p>Custom events can be triggered on a per slide basis.</p>
</section>
```

---

## Markdown Support

### Inline Markdown

Use `data-markdown` attribute with a `<script type="text/template">` block:

```html
<section data-markdown>
  <script type="text/template">
    ## Markdown Slide

    This is a slide with **markdown** content.

    - Item 1
    - Item 2
    - Item 3
  </script>
</section>
```

### External Markdown Files

Load markdown from external files:

```html
<section data-markdown="markdown.md"
         data-separator="^\n\n\n"
         data-separator-vertical="^\n\n">
</section>
```

Attributes:
- `data-separator`: Regex for horizontal slide separator (default: `^\r?\n---\r?\n$`)
- `data-separator-vertical`: Regex for vertical slide separator (default: `^\r?\n--\r?\n$`)
- `data-separator-notes`: Regex for speaker notes separator (default: `^Note:`)

### Markdown Separators

Custom separators example:

```html
<section data-markdown data-separator="^\n---\n$" data-separator-vertical="^\n--\n$">
  <script type="text/template">
    ## Demo 2
    Slide 1.1

    --

    ## Demo 2
    Slide 1.2

    ---

    ## Demo 2
    Slide 2
  </script>
</section>
```

### Markdown Slide Attributes

Add attributes to slides created from markdown:

```html
<section data-markdown>
  <script type="text/template">
    <!-- .slide: data-background="#000000" -->
    ## Slide with Black Background
  </script>
</section>
```

### Markdown Element Attributes

Add attributes to specific elements:

```html
<section data-markdown>
  <script type="text/template">
    ## Element Attributes
    - Item 1 <!-- .element: class="fragment" data-fragment-index="2" -->
    - Item 2 <!-- .element: class="fragment" data-fragment-index="1" -->
  </script>
</section>
```

### Code in Markdown

Code blocks with line highlighting:

```html
<section data-markdown>
  <script type="text/template">
    ```php [1|3-5]
    public function foo()
    {
        $foo = array(
            'bar' => 'bar'
        )
    }
    ```
  </script>
</section>
```

With line number offset:

```html
<section data-markdown>
  <script type="text/template">
    ```c [287: 2|4,6]
    /* Code here */
    p = arg + 1;
    do {
        if (*p == 'n')
            nflag = 0;
    } while (*++p);
    ```
  </script>
</section>
```

### Images in Markdown

```html
<section data-markdown>
  <script type="text/template">
    ![Sample image](https://example.com/image.png)
  </script>
</section>
```

### Math in Markdown

```html
<section data-markdown>
  ## The Lorenz Equations
  `\[\begin{aligned}
  \dot{x} &amp; = \sigma(y-x) \\
  \dot{y} &amp; = \rho x - y - xz \\
  \dot{z} &amp; = -\beta z + xy
  \end{aligned} \]`
</section>
```

---

## Auto-Animate

Auto-Animate automatically animates matching elements across slides. Elements are matched using `data-id` attributes.

### Basic Auto-Animate

```html
<section data-auto-animate>
  <h3>Auto-Animate Example</h3>
  <p>This will fade out</p>
  <img src="image1.png" style="height: 100px;">
</section>
<section data-auto-animate>
  <h3>Auto-Animate Example</h3>
  <p style="opacity: 0.2; margin-top: 100px;">This will fade out</p>
  <p>This element is unmatched</p>
  <img src="image1.png" style="height: 150px;">
</section>
```

### Auto-Animate with data-id

Match elements explicitly:

```html
<section data-auto-animate>
  <h2 data-id="title">Animate Anything</h2>
  <div data-id="box1" style="background: white; width: 60px; height: 60px;"></div>
</section>
<section data-auto-animate>
  <h2 data-id="title">With Auto Animate</h2>
  <div data-id="box1" style="background: cyan; width: 150px; height: 100px;"></div>
</section>
```

### Auto-Animate Code

Animate code blocks:

```html
<section data-auto-animate>
  <pre data-id="code"><code class="hljs" data-trim>
    function Example() {
      const [count, setCount] = useState(0);
    }
  </code></pre>
</section>
<section data-auto-animate>
  <pre data-id="code"><code class="hljs" data-trim>
    function Example() {
      New line!
      const [count, setCount] = useState(0);
    }
  </code></pre>
</section>
```

### Auto-Animate Lists

```html
<section data-auto-animate>
  <h3>Swapping list items</h3>
  <ul>
    <li>One</li>
    <li>Two</li>
    <li>Three</li>
  </ul>
</section>
<section data-auto-animate>
  <h3>Swapping list items</h3>
  <ul>
    <li>Two</li>
    <li>One</li>
    <li>Three</li>
  </ul>
</section>
```

### Auto-Animate Attributes

- `data-auto-animate`: Enable auto-animate for this slide
- `data-auto-animate-easing`: CSS easing function (e.g., `"cubic-bezier(0.770, 0.000, 0.175, 1.000)"`)
- `data-auto-animate-unmatched`: How to handle unmatched elements (`"fade"`, `"slide"`, etc.)
- `data-auto-animate-delay`: Delay before animation starts (in seconds)
- `data-auto-animate-id`: Group slides with same ID for animation sequences

```html
<section data-auto-animate
         data-auto-animate-easing="cubic-bezier(0.770, 0.000, 0.175, 1.000)"
         data-auto-animate-unmatched="fade">
  <p data-id="text" style="line-height: 1em;">Line Height</p>
</section>
<section data-auto-animate
         data-auto-animate-easing="cubic-bezier(0.770, 0.000, 0.175, 1.000)">
  <p data-id="text" style="line-height: 3em;">Line Height</p>
</section>
```

### Auto-Animate ID Groups

Separate animation sequences with different IDs:

```html
<section data-auto-animate data-auto-animate-id="a">
  <h2>Group A</h2>
  <h3>A1</h3>
</section>
<section data-auto-animate data-auto-animate-id="a">
  <h2>Group A</h2>
  <h3>A2</h3>
</section>
<section data-auto-animate data-auto-animate-id="b">
  <h2>Group B</h2>
  <h3>B1</h3>
</section>
<section data-auto-animate data-auto-animate-id="b">
  <h2>Group B</h2>
  <h3>B2</h3>
</section>
```

---

## Backgrounds

### Color Backgrounds

```html
<!-- Hex color -->
<section data-background="#00ffff">
  <h2>Cyan Background</h2>
</section>

<!-- Named color -->
<section data-background="lightblue">
  <h2>Light Blue Background</h2>
</section>

<!-- RGB/RGBA -->
<section data-background="rgba(0, 100, 100, 0.2)">
  <h2>Semi-transparent Background</h2>
</section>
```

Alternative attribute:

```html
<section data-background-color="lightblue">
  <h2>Light Blue Background</h2>
</section>
```

### Gradient Backgrounds

```html
<section data-background-gradient="linear-gradient(to bottom, #283b95, #17b2c3)">
  <h2>Gradient Background</h2>
</section>
```

### Image Backgrounds

```html
<section data-background="image.png">
  <h2>Image Background</h2>
</section>
```

Image background options:

```html
<section data-background="image.png"
         data-background-size="100px"
         data-background-repeat="repeat"
         data-background-color="#111">
  <h2>Tiled Background</h2>
</section>
```

Attributes:
- `data-background-size`: CSS background-size value (default: `cover`)
- `data-background-position`: CSS background-position value (default: `center`)
- `data-background-repeat`: CSS background-repeat value (default: `no-repeat`)
- `data-background-opacity`: Opacity of the background (0-1, default: 1)

### Video Backgrounds

```html
<section data-background-video="video.mp4,video.webm">
  <h2>Video Background</h2>
</section>
```

Video background options:

```html
<section data-background-video="video.mp4"
         data-background-video-loop
         data-background-video-muted
         data-background-color="#000000">
  <h2>Looped Muted Video</h2>
</section>
```

Attributes:
- `data-background-video-loop`: Loop the video
- `data-background-video-muted`: Mute the video

### Iframe Backgrounds

```html
<section data-background-iframe="https://example.com"
         data-background-interactive>
  <h2>Iframe Background</h2>
</section>
```

`data-background-interactive`: Allow interaction with the iframe content

### Background Transitions

```html
<section data-background="#4d7e65"
         data-background-transition="zoom">
  <h2>Background Transitions</h2>
</section>
```

Available transitions:
- `none`
- `fade` (default)
- `slide`
- `convex`
- `concave`
- `zoom`

### Background on Stacks

Apply background to an entire vertical stack:

```html
<section data-background="rgba(0, 100, 100, 0.2)">
  <section>
    <h2>Background applied to stack</h2>
  </section>
  <section>
    <h2>Same background</h2>
  </section>
  <section data-background="rgb(66, 66, 66)">
    <h2>Override background for this slide</h2>
  </section>
</section>
```

---

## Layout Helpers

reveal.js provides CSS helper classes for common layout patterns.

### r-fit-text

Resizes text to be as large as possible within its container:

```html
<section>
  <h2 class="r-fit-text">FIT</h2>
</section>

<section>
  <h2 class="r-fit-text">HELLO WORLD</h2>
  <h2 class="r-fit-text">BOTH THESE TITLES USE FIT-TEXT</h2>
</section>
```

### r-stretch

Makes an element as tall as possible while remaining within the slide bounds:

```html
<section>
  <h2>Stretch Example</h2>
  <img src="image.png" class="r-stretch">
  <p>Image byline</p>
</section>
```

### r-stack

Stacks multiple elements on top of each other, useful with fragments:

```html
<section>
  <h2>Stack Example</h2>
  <div class="r-stack">
    <img src="kitten1.jpg" class="fragment" width="450" height="300">
    <img src="kitten2.jpg" class="fragment" width="300" height="450">
    <img src="kitten3.jpg" class="fragment" width="400" height="400">
  </div>
</section>
```

Stacking with fade effects:

```html
<div class="r-stack">
  <p class="fragment fade-in-then-out">One</p>
  <p class="fragment fade-in-then-out">Two</p>
  <p class="fragment fade-in-then-out">Three</p>
</div>
```

### r-hstack

Stacks multiple elements horizontally:

```html
<section>
  <h2>HStack Example</h2>
  <div class="r-hstack">
    <p style="padding: 0.50em; background: #eee;">One</p>
    <p style="padding: 0.75em; background: #eee;">Two</p>
    <p style="padding: 1.00em; background: #eee;">Three</p>
  </div>
</section>
```

### r-vstack

Stacks multiple elements vertically:

```html
<section>
  <h2>VStack Example</h2>
  <div class="r-vstack">
    <p style="padding: 0.50em; background: #eee;">One</p>
    <p style="padding: 0.75em; background: #eee;">Two</p>
    <p style="padding: 1.00em; background: #eee;">Three</p>
  </div>
</section>
```

---

## Transitions

### Slide Transitions

Set transitions globally or per-slide:

```html
<!-- Default transition -->
<section>
  <h3>Default</h3>
</section>

<!-- Custom transition for this slide -->
<section data-transition="zoom">
  <h3>data-transition: zoom</h3>
</section>

<!-- Separate in and out transitions -->
<section data-transition="zoom-in fade-out">
  <h3>data-transition: zoom-in fade-out</h3>
</section>
```

Available transitions:
- `none`
- `fade`
- `slide` (default)
- `convex`
- `concave`
- `zoom`

Separate in/out: `convex-in concave-out`, `zoom-in fade-out`, etc.

### Global Transition Configuration

```javascript
Reveal.initialize({
  // Transition style
  transition: 'slide', // none/fade/slide/convex/concave/zoom

  // Transition speed
  transitionSpeed: 'default', // default/fast/slow

  // Transition style for full page slide backgrounds
  backgroundTransition: 'fade' // none/fade/slide/convex/concave/zoom
});
```

---

## Fragments

Fragments are elements that appear/disappear during slide progression.

### Basic Fragments

```html
<section>
  <h2>Fragments</h2>
  <p>Hit the next arrow...</p>
  <p class="fragment">... to step through ...</p>
  <p><span class="fragment">... a</span>
     <span class="fragment">fragmented</span>
     <span class="fragment">slide.</span></p>
</section>
```

### Fragment Styles

```html
<section>
  <h2>Fragment Styles</h2>
  <p class="fragment grow">grow</p>
  <p class="fragment shrink">shrink</p>
  <p class="fragment fade-out">fade-out</p>
  <p class="fragment fade-up">fade-up</p>
  <p class="fragment fade-down">fade-down</p>
  <p class="fragment fade-left">fade-left</p>
  <p class="fragment fade-right">fade-right</p>
  <p class="fragment fade-in-then-out">fade-in-then-out</p>
  <p class="fragment fade-in-then-semi-out">fade-in-then-semi-out</p>
  <p class="fragment highlight-red">highlight-red</p>
  <p class="fragment highlight-green">highlight-green</p>
  <p class="fragment highlight-blue">highlight-blue</p>
  <p class="fragment highlight-current-red">highlight-current-red</p>
</section>
```

Available fragment classes:
- `fade-in` (default)
- `fade-out`
- `fade-up`
- `fade-down`
- `fade-left`
- `fade-right`
- `fade-in-then-out`
- `fade-in-then-semi-out`
- `grow`
- `shrink`
- `strike`
- `highlight-red`
- `highlight-green`
- `highlight-blue`
- `highlight-current-red`
- `highlight-current-green`
- `highlight-current-blue`

### Fragment Index

Control the order fragments appear:

```html
<section>
  <p class="fragment" data-fragment-index="3">Appears last</p>
  <p class="fragment" data-fragment-index="1">Appears first</p>
  <p class="fragment" data-fragment-index="2">Appears second</p>
</section>
```

### Nested Fragments

```html
<section>
  <span class="fragment">
    Fade in first
    <span class="fragment highlight-red">Then highlight red</span>
  </span>
</section>
```

---

## Code Highlighting

### Basic Code Blocks

```html
<section>
  <pre><code class="hljs javascript" data-trim>
    function example() {
      console.log("Hello World");
    }
  </code></pre>
</section>
```

Attributes:
- `class="hljs [language]"`: Specify language for syntax highlighting
- `data-trim`: Remove extra whitespace from code
- `data-noescape`: Don't escape HTML entities

### Line Numbers

```html
<pre><code class="hljs javascript" data-trim data-line-numbers>
  function example() {
    console.log("Hello World");
  }
</code></pre>
```

### Line Highlighting

Highlight specific lines:

```html
<!-- Highlight lines 1 and 3-5 -->
<pre><code class="hljs" data-trim data-line-numbers="1,3-5">
  line 1
  line 2
  line 3
  line 4
  line 5
</code></pre>
```

### Step-by-Step Line Highlighting

Highlight different lines as you step through:

```html
<!-- First show all, then highlight line 1, then lines 3-5 -->
<pre><code class="hljs" data-trim data-line-numbers="|1|3-5">
  line 1
  line 2
  line 3
  line 4
  line 5
</code></pre>
```

### Line Number Offset

Start line numbering at a specific number:

```html
<pre><code class="hljs c" data-trim data-line-numbers="287: 2|4,6">
  /* Line 287 */
  p = arg + 1;
  do {
      if (*p == 'n')
          nflag = 0;
  } while (*++p);
</code></pre>
```

Format: `[offset]: [highlights]`

---

## Math Support

reveal.js supports mathematical typesetting using KaTeX, MathJax 2, or MathJax 3.

### Inline Math

```html
<section>
  <p>The probability of getting \(k\) heads when flipping \(n\) coins is</p>
  \[P(E) = {n \choose k} p^k (1-p)^{n-k}\]
</section>
```

### Block Math

```html
<section>
  <h3>The Lorenz Equations</h3>
  \[\begin{aligned}
  \dot{x} &amp; = \sigma(y-x) \\
  \dot{y} &amp; = \rho x - y - xz \\
  \dot{z} &amp; = -\beta z + xy
  \end{aligned}\]
</section>
```

### MathJax Script Type

Alternative syntax using script tags:

```html
<section>
  <h3>The Cauchy-Schwarz Inequality</h3>
  <script type="math/tex; mode=display">
    \left( \sum_{k=1}^n a_k b_k \right)^2 \leq
    \left( \sum_{k=1}^n a_k^2 \right) \left( \sum_{k=1}^n b_k^2 \right)
  </script>
</section>
```

### Math Configuration

```javascript
Reveal.initialize({
  // MathJax 2 configuration
  mathjax2: {
    config: 'TeX-AMS_HTML-full',
    TeX: {
      Macros: {
        R: '\\mathbb{R}',
        set: [ '\\left\\{#1 \\; ; \\; #2\\right\\}', 2 ]
      }
    }
  },

  // Choose math typesetter
  plugins: [ RevealMath.MathJax2 ] // or MathJax3, KaTeX
});
```

### Math in Fragments

```html
<section>
  <h3>The Lorenz Equations</h3>
  <div class="fragment">
    \[\begin{aligned}
    \dot{x} &amp; = \sigma(y-x) \\
    \dot{y} &amp; = \rho x - y - xz \\
    \dot{z} &amp; = -\beta z + xy
    \end{aligned}\]
  </div>
</section>
```

---

## Media

### Video

```html
<section>
  <h2>Video</h2>
  <video src="video.mp4" data-autoplay></video>
</section>
```

Attributes:
- `data-autoplay`: Play video when slide becomes active
- Standard HTML5 video attributes (controls, loop, muted, etc.)

### Audio

```html
<section>
  <h2>Auto-playing audio</h2>
  <audio src="audio.wav" data-autoplay></audio>
</section>

<section>
  <h2>Audio with controls</h2>
  <audio src="audio.wav" controls></audio>
</section>
```

### Audio in Fragments

```html
<section>
  <h2>Audio inside slide fragments</h2>
  <div class="fragment">
    Beep 1
    <audio src="beeping.wav" data-autoplay></audio>
  </div>
  <div class="fragment">
    Beep 2
    <audio src="beeping.wav" data-autoplay></audio>
  </div>
</section>
```

### Iframes

```html
<section>
  <h2>Iframe</h2>
  <iframe data-autoplay
          width="700"
          height="540"
          src="https://example.com"
          frameborder="0">
  </iframe>
</section>
```

`data-autoplay`: Automatically focus/load iframe when slide becomes active

---

## Lightbox Preview

reveal.js includes lightbox functionality for images, videos, and links.

### Image Preview

```html
<!-- Preview the same image -->
<img src="image.png" data-preview-image>

<!-- Preview a different image -->
<img src="thumbnail.png" data-preview-image="full-image.png">

<!-- Preview from a link -->
<a href="#" data-preview-image="image.png">Click to preview</a>
```

Fit options:

```html
<!-- Contain: entire image visible -->
<img src="image.png" data-preview-image data-preview-fit="contain">

<!-- Cover: fill entire viewport -->
<img src="image.png" data-preview-image data-preview-fit="cover">
```

### Video Preview

```html
<!-- Preview video -->
<img src="video-thumbnail.png" data-preview-video="video.mp4">

<!-- Preview from video element -->
<video src="video.mp4" data-preview-video></video>

<!-- Preview from link -->
<a href="#" data-preview-video="video.mp4">Preview video</a>
```

### Link Preview (Iframe)

```html
<!-- Preview link in iframe -->
<a data-preview-link href="https://example.com">Preview this site</a>

<!-- Disable link preview -->
<a data-preview-link="false" href="https://example.com">Regular link</a>

<!-- Preview link from image -->
<img src="icon.png" data-preview-link="https://example.com">
```

### Global Preview Configuration

```javascript
Reveal.initialize({
  // Enable/disable link previews globally
  previewLinks: false // or true
});
```

---

## Configuration

### Basic Configuration

```javascript
Reveal.initialize({
  // Display presentation control arrows
  controls: true,

  // Help the user learn the controls by providing hints
  controlsTutorial: true,

  // Determines where controls appear
  controlsLayout: 'bottom-right', // edges or bottom-right

  // Visibility rule for backwards navigation arrows
  controlsBackArrows: 'faded', // faded, hidden, or visible

  // Display a presentation progress bar
  progress: true,

  // Display the page number of the current slide
  slideNumber: false, // true, false, 'h.v', 'h/v', 'c', 'c/t'

  // Add the current slide number to the URL hash
  hash: false,

  // Start with 1 for the hash rather than 0
  hashOneBasedIndex: false,

  // Push each slide change to the browser history
  history: false,

  // Enable keyboard shortcuts for navigation
  keyboard: true,

  // Enable slide navigation via mouse wheel
  mouseWheel: false,

  // Opens links in an iframe preview overlay
  previewLinks: false,

  // Transition style
  transition: 'slide', // none/fade/slide/convex/concave/zoom

  // Transition speed
  transitionSpeed: 'default', // default/fast/slow

  // Transition style for full page slide backgrounds
  backgroundTransition: 'fade',

  // Display mode used to show slides
  display: 'block',

  // Center slides on the screen
  center: true,

  // The "normal" size of the presentation
  width: 960,
  height: 700,

  // Factor of the display size that should remain empty around content
  margin: 0.04,

  // Bounds for smallest/largest possible scale to apply to content
  minScale: 0.2,
  maxScale: 2.0
});
```

### Auto-Slide Configuration

```javascript
Reveal.initialize({
  // Number of milliseconds between automatically proceeding to next slide
  autoSlide: 0, // disabled when 0

  // Stop auto-sliding after user input
  autoSlideStoppable: true,

  // Use this method for navigation when auto-sliding
  autoSlideMethod: null,

  // Specify the average time in seconds that you think you will spend
  // presenting each slide
  defaultTiming: null
});
```

### View Modes

```javascript
Reveal.initialize({
  // Display mode: default, scroll, or reader
  view: 'default', // 'scroll' for scroll view, 'reader' for reader view

  // Vertical centering of slides
  center: true,

  // Enables touch navigation on devices with touch input
  touch: true,

  // Loop the presentation
  loop: false,

  // Change the presentation direction to be RTL
  rtl: false,

  // Randomize the order of slides each time presentation loads
  shuffle: false,

  // Turns fragments on and off globally
  fragments: true,

  // Flags whether to include the current fragment in the URL
  fragmentInURL: true,

  // Flags if the presentation is running in an embedded mode
  embedded: false,

  // Flags if we should show a help overlay when the questionmark key is pressed
  help: true,

  // Flags if it should be possible to pause the presentation
  pause: true,

  // Flags if speaker notes should be visible to all viewers
  showNotes: false,

  // Flags if slides with data-visibility="hidden" should be kep visible
  showHiddenSlides: false
});
```

### Multiple Presentations

Create multiple reveal.js instances on one page:

```html
<div class="reveal deck1">
  <div class="slides">
    <section>Deck 1, Slide 1</section>
  </div>
</div>

<div class="reveal deck2">
  <div class="slides">
    <section>Deck 2, Slide 1</section>
  </div>
</div>

<script>
  let deck1 = new Reveal(document.querySelector('.deck1'), {
    embedded: true,
    keyboardCondition: 'focused'
  });
  deck1.initialize();

  let deck2 = new Reveal(document.querySelector('.deck2'), {
    embedded: true,
    keyboardCondition: 'focused'
  });
  deck2.initialize();
</script>
```

---

## Plugins

### Loading Plugins

```javascript
Reveal.initialize({
  plugins: [
    RevealMarkdown,
    RevealHighlight,
    RevealNotes,
    RevealMath.KaTeX,
    RevealSearch,
    RevealZoom
  ]
});
```

### Common Plugins

#### Markdown
Enables markdown support:
```javascript
plugins: [ RevealMarkdown ]
```

#### Highlight
Syntax highlighting for code:
```javascript
plugins: [ RevealHighlight ]
```

#### Notes
Speaker notes support:
```javascript
plugins: [ RevealNotes ]
```

Add notes to slides:
```html
<section>
  <h2>Slide Title</h2>
  <aside class="notes">
    These are speaker notes. Press 'S' to open speaker view.
  </aside>
</section>
```

#### Math
Mathematical typesetting:
```javascript
plugins: [ RevealMath.MathJax2 ] // or MathJax3, KaTeX
```

#### Search
Search functionality (press Ctrl+Shift+F):
```javascript
plugins: [ RevealSearch ]
```

#### Zoom
Zoom into elements (Alt+Click):
```javascript
plugins: [ RevealZoom ]
```

---

## Advanced Features

### Scroll View

Enable scroll view mode where slides scroll vertically:

```javascript
Reveal.initialize({
  view: 'scroll',
  hash: true,
  plugins: [ RevealMarkdown, RevealHighlight, RevealNotes ]
});
```

In scroll view:
- Fragments trigger on scroll
- Auto-animate works with scroll
- Code highlighting steps trigger on scroll

### Speaker Notes

Add notes visible only in speaker view:

```html
<section>
  <h2>Slide Content</h2>
  <aside class="notes">
    These notes will only appear in the speaker view.
    Press 'S' to open speaker view.
  </aside>
</section>
```

Markdown notes:

```html
<section data-markdown>
  <script type="text/template">
    ## Slide Title

    Content here

    Note: These are speaker notes in markdown
  </script>
</section>
```

### Slide State

Apply custom CSS classes to document when slide is active:

```html
<section data-state="customevent">
  <h2>Custom State</h2>
</section>

<script>
  Reveal.on('customevent', function() {
    console.log('"customevent" has fired');
  });
</script>
```

### Slide Visibility

Hide slides:

```html
<section data-visibility="hidden">
  <h2>Hidden Slide</h2>
  <p>Won't appear in navigation unless showHiddenSlides is true.</p>
</section>
```

Show hidden slides:

```javascript
Reveal.initialize({
  showHiddenSlides: true
});
```

### Navigation

Internal links:

```html
<!-- Link to slide by index -->
<a href="#/2/3">Go to slide 2.3</a>

<!-- Link to slide by ID -->
<a href="#/my-slide">Go to named slide</a>

<!-- Link with data-id attribute (for slide links) -->
<a href="#/2" data-id="link-to-slide-2">Go to slide 2</a>
```

### Keyboard Shortcuts

Common keyboard shortcuts:
- Arrow keys: Navigate slides
- Space: Next slide
- Shift+Space: Previous slide
- Esc: Slide overview mode
- S: Speaker notes window
- F: Fullscreen
- B or .: Pause (blackout)
- ?: Help panel

### API Events

Listen to events:

```javascript
Reveal.on('slidechanged', event => {
  // event.previousSlide, event.currentSlide, event.indexh, event.indexv
});

Reveal.on('fragmentshown', event => {
  // event.fragment = the fragment element
});

Reveal.on('fragmenthidden', event => {
  // event.fragment = the fragment element
});

Reveal.on('ready', event => {
  // event.currentSlide, event.indexh, event.indexv
});
```

### Themes

Built-in themes:
- black (default)
- white
- league
- sky
- beige
- simple
- serif
- blood
- night
- moon
- solarized

Load a theme:

```html
<link rel="stylesheet" href="dist/theme/black.css" id="theme">
```

### PDF Export

Add `?print-pdf` to the URL to enable PDF export mode, then print to PDF from the browser.

```
presentation.html?print-pdf
```

---

## Complete Example

Here's a comprehensive example combining multiple features:

```html
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>reveal.js - Complete Example</title>

    <link rel="stylesheet" href="dist/reset.css">
    <link rel="stylesheet" href="dist/reveal.css">
    <link rel="stylesheet" href="dist/theme/black.css">
    <link rel="stylesheet" href="plugin/highlight/monokai.css">
  </head>

  <body>
    <div class="reveal">
      <div class="slides">

        <!-- Title slide -->
        <section data-background-gradient="linear-gradient(to bottom, #283b95, #17b2c3)">
          <h1 class="r-fit-text">My Presentation</h1>
          <p>By Your Name</p>
        </section>

        <!-- Markdown slide -->
        <section data-markdown>
          <script type="text/template">
            ## Agenda

            1. Introduction
            2. Main Content
            3. Conclusion
          </script>
        </section>

        <!-- Vertical slides -->
        <section>
          <section>
            <h2>Main Topic</h2>
            <p>Press down for more details</p>
          </section>
          <section>
            <h2>Detail 1</h2>
            <ul>
              <li class="fragment">First point</li>
              <li class="fragment">Second point</li>
              <li class="fragment">Third point</li>
            </ul>
          </section>
        </section>

        <!-- Auto-animate code -->
        <section data-auto-animate>
          <pre data-id="code"><code class="javascript" data-trim data-line-numbers>
            function hello() {
              console.log("Hello");
            }
          </code></pre>
        </section>
        <section data-auto-animate>
          <pre data-id="code"><code class="javascript" data-trim data-line-numbers="1-5">
            function hello(name) {
              console.log("Hello " + name);
            }

            hello("World");
          </code></pre>
        </section>

        <!-- Math slide -->
        <section>
          <h2>Mathematical Formula</h2>
          \[E = mc^2\]
        </section>

        <!-- Image with background -->
        <section data-background="image.jpg" data-background-opacity="0.3">
          <h2>Image Background</h2>
          <img src="logo.png" class="r-stretch">
        </section>

        <!-- Speaker notes -->
        <section>
          <h2>Summary</h2>
          <p>Key takeaways from this presentation</p>
          <aside class="notes">
            Remember to emphasize the main points and thank the audience.
          </aside>
        </section>

      </div>
    </div>

    <script src="dist/reveal.js"></script>
    <script src="plugin/notes/notes.js"></script>
    <script src="plugin/markdown/markdown.js"></script>
    <script src="plugin/highlight/highlight.js"></script>
    <script src="plugin/math/math.js"></script>

    <script>
      Reveal.initialize({
        hash: true,
        controls: true,
        progress: true,
        center: true,
        transition: 'slide',

        plugins: [
          RevealMarkdown,
          RevealHighlight,
          RevealNotes,
          RevealMath.KaTeX
        ]
      });
    </script>
  </body>
</html>
```

---

## Summary

reveal.js presentations are built using:

1. **HTML Structure**: Nested `<section>` elements inside `<div class="slides">`
2. **Data Attributes**: Control behavior (backgrounds, transitions, animations, etc.)
3. **CSS Classes**: Layout helpers (r-fit-text, r-stack, r-stretch, etc.) and fragments
4. **Markdown**: Optional markdown support for easier content authoring
5. **Plugins**: Extend functionality (highlighting, math, notes, etc.)
6. **JavaScript API**: Initialize and control the presentation programmatically

The format is highly flexible, supporting everything from simple slide decks to complex interactive presentations with animations, media, and custom behavior.
