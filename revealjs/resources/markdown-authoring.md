# Subskill: Markdown Authoring

Load this when writing slides in Markdown instead of HTML, or when using external `.md` files.

---

## Inline Markdown (single section)

```html
<section data-markdown>
  <script type="text/template">
    ## Slide Title

    - Item one
    - Item two
    - **Bold** and *italic*

    Note: This is a speaker note (only in speaker view)
  </script>
</section>
```

`RevealMarkdown` plugin must be loaded and registered.

---

## External Markdown File

Load an entire presentation from a `.md` file:

```html
<section data-markdown="slides.md"
         data-separator="^\n---\n$"
         data-separator-vertical="^\n--\n$"
         data-separator-notes="^Note:">
</section>
```

**`slides.md`**:
```markdown
## Slide 1

Content here.

---

## Slide 2 (new horizontal slide, separated by ---)

--

## Slide 2b (vertical sub-slide, separated by --)

Note: Speaker notes for slide 2b
```

### Separator attributes

| Attribute | Default | Effect |
|---|---|---|
| `data-separator` | `^\r?\n---\r?\n$` | Horizontal slide separator |
| `data-separator-vertical` | `^\r?\n--\r?\n$` | Vertical slide separator |
| `data-separator-notes` | `^Note:` | Speaker notes separator |

Custom separators (any regex):
```html
<section data-markdown="slides.md"
         data-separator="^\n\n\n"
         data-separator-vertical="^\n\n">
```
(Three blank lines = new horizontal slide, two blank lines = new vertical slide.)

---

## Slide Attributes in Markdown

Add `data-*` attributes to slides created from markdown using HTML comments:

```markdown
<!-- .slide: data-background="#ff0000" -->
## Red Background Slide

<!-- .slide: data-transition="zoom" -->
## Zoom Transition

<!-- .slide: data-background-gradient="linear-gradient(140deg, #1B3A6B, #E07340)" -->
## Gradient Background
```

The comment must be on its own line, directly in the slide content.

---

## Element Attributes in Markdown

Add attributes to specific elements:

```markdown
## Fragment List

- Normal item
- Fragment item <!-- .element: class="fragment" -->
- Highlight item <!-- .element: class="fragment highlight-red" -->
- Third fragment <!-- .element: class="fragment" data-fragment-index="3" -->
```

Note: the comment comes **after** the element on the same line.

---

## Code Highlighting in Markdown

````markdown
```python
def fibonacci(n):
    if n <= 1:
        return n
    return fibonacci(n-1) + fibonacci(n-2)
```
````

With line numbers and step-through highlighting:

````markdown
```python [1|3-4|5]
def fibonacci(n):          # step 1: function signature
    if n <= 1:             # step 2: base case
        return n
    return fibonacci(n-1) + fibonacci(n-2)  # step 3: recursive case
```
````

Format: `language [lines|to|highlight|on|each|step]`

With line offset (for showing excerpt of larger file):

````markdown
```c [287: 2|4,6]
/* Starting at line 287 */
p = arg + 1;
do {
    if (*p == 'n') nflag = 0;
} while (*++p);
```
````

---

## Speaker Notes in Markdown

Using the `Note:` separator (or custom `data-separator-notes`):

```markdown
## My Slide

Content here.

Note:
These are speaker notes. Everything after "Note:" until the next slide separator
is treated as notes, not rendered in the presentation.

You can use **markdown** in notes too.
```

---

## Math in Markdown

KaTeX/MathJax delimiters work inside markdown sections:

```markdown
## The Binomial Theorem

The probability of exactly $k$ successes in $n$ trials:

\[ P(X = k) = \binom{n}{k} p^k (1-p)^{n-k} \]

For large $n$, this approximates a normal distribution.
```

---

## Images in Markdown

```markdown
## Diagram

![Alt text](images/diagram.png)

<!-- Sized image -->
<img src="images/diagram.png" width="400" class="r-stretch">
```

For `r-stretch`, `r-fit-text`, and other CSS classes, use inline HTML within the markdown template.

---

## Mixing HTML and Markdown

You can use inline HTML inside markdown sections:

```markdown
## Mixed Content

Standard markdown content.

<div class="math-box">
\[ E[X] = \sum x \cdot P(X=x) \]
</div>

<aside class="notes">
Speaker notes can also be written as HTML if preferred.
</aside>
```

---

## When to use Markdown vs. HTML

| Use Markdown when | Use HTML when |
|---|---|
| Content is primarily text/lists | You need custom CSS classes |
| External file for easy editing | Complex layout (two-col, grid) |
| Authoring speed matters | Math boxes, algorithm boxes |
| Content collaborators prefer Markdown | Fine-grained fragment control |
| Simple slides | Slides.com import/export |
