# The complete guide to Reveal.js plugins

Reveal.js ships with **6 built-in plugins** and supports an ecosystem of **100+ community plugins** spanning drawing, diagrams, remote control, live coding, accessibility, and more. There is no official plugin marketplace — the canonical directory is the community-maintained [GitHub wiki page](https://github.com/hakimel/reveal.js/wiki/Plugins,-Tools-and-Hardware) with 220+ revisions. Two major plugin collections — **rajgoel/reveal.js-plugins** and **Martinomagnifico's suite** — cover most common use cases and remain actively maintained through 2026. The Quarto scientific publishing framework has also spawned a parallel extension ecosystem with 30+ Reveal.js-specific packages.

---

## The 8 official plugins maintained by the core team

Reveal.js (v5.2.1, npm package `reveal.js`) bundles six plugins in its `plugin/` directory. Two additional plugins were extracted into separate repositories under the `reveal` GitHub organization starting with v4.0.

**RevealHighlight** powers syntax highlighting via highlight.js, supporting line numbers, step-through line animations (using `|` delimiters), and custom themes. **RevealMarkdown** lets authors write slides in Markdown using the marked parser, with support for external `.md` files, custom slide separators, and HTML comment-based slide attributes. **RevealNotes** opens a speaker view (press `S`) with current notes, next-slide preview, elapsed timer, and a pacing system with color-coded feedback. These three ship in the default boilerplate.

Three more require manual addition: **RevealMath** renders LaTeX via KaTeX, MathJax 2, or MathJax 3 — KaTeX is recommended for speed. **RevealSearch** provides full-text search across all slides with `Ctrl+Shift+F`. **RevealZoom** lets presenters `Alt+click` any element to zoom in.

Two formerly bundled plugins now live in separate repos. **Multiplex** (`reveal-multiplex` on npm) uses Socket.io to let audiences follow the presenter's slides in real-time on their own devices. **Notes Server** (`reveal-notes-server` on npm) enables networked speaker notes across devices, including QR code generation for quick access.

| Plugin | ID | Bundled | Primary function |
|---|---|---|---|
| RevealHighlight | `highlight` | ✅ Default | Syntax-highlighted code blocks |
| RevealMarkdown | `markdown` | ✅ Default | Write slides in Markdown |
| RevealNotes | `notes` | ✅ Default | Speaker view with timer |
| RevealMath | `math` | ✅ Manual add | LaTeX math (KaTeX/MathJax) |
| RevealSearch | `search` | ✅ Manual add | Full-text slide search |
| RevealZoom | `zoom` | ✅ Manual add | Alt+click element zoom |
| Multiplex | `multiplex` | ❌ Separate | Real-time audience sync |
| Notes Server | — | ❌ Separate | Remote speaker notes |

---

## Two plugin collections dominate the ecosystem

**rajgoel/reveal.js-plugins** (⭐789, npm `reveal.js-plugins` v4.6.0) is the single largest collection, packaging **11 plugins** under one roof. Its standout is **Chalkboard** — a whiteboard and slide annotation tool that lets presenters draw directly on slides and record drawings for replay. **Audio Slideshow** adds per-slide audio playback and recording. **Chart** integrates Chart.js for embedding data visualizations. **Seminar** enables real-time multi-user interaction via Socket.io, powering two companion plugins: **Poll** for live audience voting and **Questions** for upvotable Q&A. The collection also includes **Animate** (SVG.js animations), **Anything** (arbitrary JS-rendered content), **Custom Controls**, **Fullscreen**, and **Load Content** for pulling in external HTML.

**Martinomagnifico's collection** (hosted at martinomagnifico.github.io) offers a dozen high-quality, individually packaged plugins — many rewritten in TypeScript as recently as February 2026. **Appearance** (⭐127) brings PowerPoint-style sequential element animations using Animate.css. **Simplemenu** (⭐57) auto-generates a menubar with chapter-based navigation. **Verticator** (⭐49) adds vertical slide position indicators inspired by fullPage.js. **CopyCode** (⭐43) automatically attaches copy buttons to code blocks. Other plugins in this suite handle internationalization (**Internation**), font loading (**FontsFirst**), dynamic section visibility (**Tagteam**), fullscreen effects (**FsFx**), and CSS counter fixes (**CounterAct**).

---

## Navigation, menus, and presentation flow

The most popular standalone plugin is **reveal.js-menu** by Greg Denehy (⭐286, npm `reveal.js-menu`), which adds a slideout navigation panel with title-based slide navigation, theme switching, and transition selection. Denehy also maintains **reveal.js-toolbar**, a companion that provides quick-access buttons for fullscreen, notes, and pause.

For progress visualization, **TOC-Progress** by e-gor creates a LaTeX Beamer-style progress indicator based on a table of contents, while **elapsed-time-bar** by tkrkt shows a color-coded bar tracking elapsed presentation time. **reveal-countdown** (npm `reveal.js-countdown`) adds per-slide countdown timers useful for exercises and breaks.

Navigation helpers include **jump-plugin** (type a slide number + Enter to jump), **Skip Fragments** (bypass all fragments on a slide with a shortcut), and **zero-index-main** (sets the first vertical slide as the main deck on horizontal navigation). **reveal.js-tableofcontents** auto-generates a TOC slide from your presentation structure.

---

## Drawing, pointers, and annotation tools

Beyond the Chalkboard plugin in the rajgoel collection, several standalone drawing tools exist. **tldreveal** (⭐40) integrates the popular tldraw canvas library with save/load support — updated September 2025 with a TypeScript rewrite. **reveal.js-drawer** (⭐29) lets presenters draw over slides with drawings persisting between slide transitions. **handwriting** provides simple mouse, pen, and touch drawing.

Pointer and spotlight plugins help audiences follow the presenter's focus. **Spotlight** (⭐28) creates a configurable spotlight effect around the mouse cursor. **reveal.js-pointer** (⭐20) toggles the cursor into a pointer with a keybinding. The **Quarto Pointer** extension (⭐37) has gained traction in the data science community. **notes-pointer** adds a laser pointer effect that works within the speaker view.

---

## Diagrams, data visualization, and code

Reveal.js has rich options for technical content. **reveal.js-mermaid-plugin** (npm v11.6.0, actively maintained) renders Mermaid diagrams — flowcharts, sequence diagrams, class diagrams, and more — directly in the browser. Multiple D3.js integration plugins exist: **reveald3** supports D3, Vega, Vega-lite, and Semiotic visualizations with fragment support, while **RevealVizScroll** brings scrollytelling-style transitions. **reveal-plantuml** renders PlantUML's text-based UML diagrams, and **reveal.js-railroad** handles syntax/railroad diagrams.

For code-heavy presentations, the ecosystem extends well beyond the built-in highlight plugin. **code-focus** highlights specific code lines on demand. **sampler** and **EmbedCode** let you pull code directly from source files rather than copy-pasting. **reveal-compiler-explorer** (updated December 2024) lets audiences click code to open it in Compiler Explorer. Several live coding plugins exist: **livecode** integrates CodeMirror with a preview pane and console, **reveal.js-ace** embeds the ACE editor, and **css-snippet** enables live CSS editing. **run-in-terminal** (⭐44) allows executing code examples directly during presentations.

---

## Remote control, interactivity, and novel inputs

Beyond the official Multiplex plugin, **remeal** (⭐28) offers a fully customizable remote control interface. **notell** allows controlling presentations from another browser tab, while **reveal.js-remote** adds smartphone remote control with QR code pairing and multiplexing.

For unconventional input, the ecosystem gets creative: **speech** enables voice-command navigation, **wave-plugin** advances slides by waving at a webcam, **gamepad-plugin** and **joycon-plugin** repurpose game controllers as remotes, and **leap-motion** (⭐33) adds Leap Motion controller support with a virtual laser pointer.

Audience engagement plugins include the rajgoel **Poll** and **Questions** plugins (built on Seminar's Socket.io infrastructure), a standalone **poll-plugin** by jschildgen with bar chart results, and a **Quizzes** plugin for embedded assessments. **reveal.js-tracking** provides advanced analytics — dwell times, link clicks, quiz responses, and transition patterns.

---

## Accessibility, export, and utility plugins

**reveal-a11y** by accessibility expert Marcy Sutton addresses presentation accessibility. **tts_basics** adds text-to-speech so slides can be read aloud. **revealjs-subtitles** provides real-time captioning via the Web Speech API. **Internation** enables full multilingual presentation support with language switching.

For export, **PdfExport** by McShelby toggles between screen and PDF export mode via a shortcut key. **DeckTape** (external tool) produces high-quality PDFs from any HTML5 presentation framework including Reveal.js. The built-in Notes plugin supports `showNotes: "separate-page"` for PDF export with notes.

Utility plugins round out the ecosystem: **ThemeOverride** and **AltMode** handle theme and configuration switching, **HelpButton** adds a help screen trigger, **reveal-ga** integrates Google Analytics, **mqtt-plugin** streams real-time IoT data, and **FontsFirst** ensures web fonts load before the presentation initializes.

---

## Where to find plugins and how to install them

There is **no centralized plugin marketplace** for Reveal.js. Instead, plugins are discovered and distributed through several channels:

- **The official wiki** at github.com/hakimel/reveal.js/wiki/Plugins,-Tools-and-Hardware — the definitive community directory with 80+ plugins, 30+ tools, and hardware integrations
- **GitHub Topics** — repositories tagged `reveal-js-plugin` (34 repos) or `revealjs-plugin`
- **npm** — key packages include `reveal.js-plugins`, `reveal.js-menu`, `reveal.js-mermaid-plugin`, `reveal.js-countdown`, and `reveal.js-simplemenu`
- **Quarto extensions** — quarto.org/docs/extensions/listing-revealjs.html lists 30+ Reveal.js extensions installable via `quarto add`, including pointer, spotlight, attribution, roughnotation, code-fullscreen, webcam, confetti, and auto-agenda
- **Martinomagnifico's site** at martinomagnifico.github.io provides a browsable index of that author's plugins

Installation follows three patterns. The simplest is **script tags** pointing to local or CDN-hosted files. **npm install** works for packaged plugins (`npm i reveal.js-menu`). **ES modules** enable tree-shaking with `import Plugin from 'plugin/myplugin/myplugin.esm.js'`. Registration is uniform: pass plugins to `Reveal.initialize({ plugins: [MyPlugin] })` or call `Reveal.registerPlugin(MyPlugin)` at runtime. The plugin API itself is minimal — just an object with an `id` string and an `init(deck)` function that optionally returns a Promise.

---

## Frameworks extending the Reveal.js plugin ecosystem

Several major tools build on Reveal.js and expand its reach. **Quarto** (quarto.org) — the scientific publishing system from Posit — uses Reveal.js as its primary presentation format and wraps plugins as installable extensions, creating the fastest-growing Reveal.js plugin ecosystem today. **reveal-md** (npm `reveal-md`) provides a CLI for creating presentations from Markdown files with live reload and static export. **RISE** integrates Reveal.js into Jupyter notebooks for live data science presentations. **Slides.com**, built by Reveal.js creator Hakim El Hattab, is the official commercial graphical editor. **Asciidoctor reveal.js** converts AsciiDoc to presentations, and **reveal-hugo** provides a complete Hugo theme. The **VuePress revealjs plugin** embeds presentations in VuePress sites with built-in support for highlight, math, search, notes, and zoom plugins.

## Conclusion

The Reveal.js plugin ecosystem is **decentralized but surprisingly comprehensive**, with the community wiki serving as the de facto directory. The rajgoel collection and Martinomagnifico's suite together cover roughly 80% of common needs — drawing, charts, menus, animations, audience interaction, and code enhancement. The most significant recent development is **Quarto's rapid adoption**, which has effectively created a second plugin distribution channel specifically for academic and data science users. For anyone building a Reveal.js presentation today, the practical starting point is the rajgoel collection for interactive features, Martinomagnifico for polish and navigation, and the official wiki for everything else. The lightweight plugin API (just `id` + `init`) keeps the barrier to creating new plugins extremely low, which explains why the ecosystem continues to grow even as competitors like Slidev gain traction.