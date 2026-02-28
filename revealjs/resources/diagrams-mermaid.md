# Subskill: Diagrams with Mermaid

Load this when adding flowcharts, state diagrams, sequence diagrams, or decision trees.

---

## Setup

```html
<!-- In <head> or just before closing </body> before Reveal.initialize -->
<script src="https://cdn.jsdelivr.net/npm/reveal.js-mermaid-plugin@11.12.2/plugin/mermaid/mermaid.js"></script>
```

```javascript
Reveal.initialize({
  mermaid: {
    theme: 'default',
    themeVariables: {
      primaryColor: '#CC7C5E',      // matches heading color
      primaryTextColor: '#333',
      primaryBorderColor: '#CC7C5E',
      lineColor: '#CC7C5E',
      secondaryColor: '#E8F4F8',    // light blue: heuristic/cheap ops
      tertiaryColor: '#53B467'      // green: success states
    }
  },
  plugins: [ RevealMermaid ]
});
```

**Version pin: `@11.12.2`** — do not use `@latest` mid-project. Update only between semesters/projects.

---

## Slide Markup

**Always wrap Mermaid syntax in `<pre>` tags inside the `.mermaid` div:**

```html
<section>
  <h2>Decision Flow</h2>
  <div class="mermaid">
    <pre>
graph TD
  A[Start] --> B{Condition?}
  B -->|Yes| C[Fast Path]
  B -->|No| D[Slow Path]

  style A fill:#ffffff
  style B fill:#E8F4F8
  style C fill:#d4edda
  style D fill:#f8d7da
    </pre>
  </div>
  <aside class="notes">Walk through the decision logic...</aside>
</section>
```

---

## Mermaid Diagram Types

### Flowchart (most common for algorithms)
```
graph TD          TD = top-down; LR = left-right; TB = top-bottom
  A[Box]
  B{Diamond decision}
  C((Circle))
  D>Asymmetric]
  A --> B
  B -->|label| C
  B -->|other| D
```

### Sequence Diagram
```
sequenceDiagram
  participant Client
  participant Server
  Client->>Server: Request
  Server-->>Client: Response
  Note right of Server: Processing
```

### State Diagram
```
stateDiagram-v2
  [*] --> Idle
  Idle --> Running: start
  Running --> Idle: stop
  Running --> Error: fail
  Error --> Idle: reset
```

### Class Diagram (for data structures)
```
classDiagram
  class Node {
    +int value
    +Node next
    +append(val)
  }
  class LinkedList {
    +Node head
    +insert(val)
    +delete(val)
  }
  LinkedList --> Node : contains
```

---

## Color Coding for Algorithmic Concepts

Use consistently across diagrams in the same presentation:

| Color | Hex | Meaning |
|---|---|---|
| Light blue | `#E8F4F8` | Cheap/fast/heuristic operations |
| Light red | `#f8d7da` | Expensive/slow/expensive operations |
| Light green | `#d4edda` | Success states, correct outcomes |
| White | `#ffffff` | Neutral/start states |
| Light yellow | `#fff3cd` | Warning / intermediate states |

Apply with `style NodeId fill:#COLOR`:
```
graph TD
  A[Check cache] --> B{Hit?}
  B -->|Yes| C[Return cached]
  B -->|No| D[Fetch from DB]
  style A fill:#ffffff
  style B fill:#E8F4F8
  style C fill:#d4edda
  style D fill:#f8d7da
```

---

## Diagram Complexity Guidelines

- **Good**: 3–7 nodes, 1–2 decision points
- **Too complex**: >10 nodes → split across slides or use sub-slides
- Test at https://mermaid.live/ before adding to slides

---

## Async Rendering (Important)

Mermaid renders asynchronously. After navigating to a Mermaid slide:
- Wait 2 seconds before taking a screenshot
- Verify rendering with Playwright:

```javascript
() => {
  const divs = document.querySelectorAll('.mermaid');
  return Array.from(divs).map(d => ({
    hasSvg: !!d.querySelector('svg'),
    text: d.textContent.substring(0, 50)
  }));
}
```

If `hasSvg: false`, the diagram failed to render — check syntax at mermaid.live.

---

## Fallback for PDF Export

Mermaid may not render in PDF export. For important diagrams:

```html
<div class="mermaid">
  <pre>graph TD ...</pre>
  <noscript>
    <img src="images/diagram-fallback.png" alt="Decision flow">
  </noscript>
</div>
```

Or: screenshot the rendered diagram and use as image for PDF version.

---

## Performance

- < 5 diagrams per deck: negligible performance impact
- > 10 diagrams: noticeable load time
- For heavy diagram decks: consider lazy-loading or splitting into multiple files
