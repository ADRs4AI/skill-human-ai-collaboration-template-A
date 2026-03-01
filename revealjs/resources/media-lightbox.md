# Subskill: Media and Lightbox

Load this when embedding video, audio, iframes, or lightbox image/video previews in slides.

---

## Video

### Video slide

```html
<section>
  <h2>Demo</h2>
  <video src="demo.mp4" data-autoplay controls width="800"></video>
</section>
```

`data-autoplay` plays the video when the slide becomes active. Without it, the video waits for user interaction.

### Video as background

```html
<section data-background-video="demo.mp4"
         data-background-video-loop
         data-background-video-muted>
  <h2>Content over video</h2>
</section>
```

Multiple formats (fallback):
```html
<section data-background-video="demo.mp4, demo.webm">
```

### Video in fragments

```html
<section>
  <div class="fragment">
    <p>Step 1 complete</p>
    <audio src="chime.wav" data-autoplay></audio>
  </div>
  <div class="fragment">
    <p>Step 2 complete</p>
    <audio src="chime.wav" data-autoplay></audio>
  </div>
</section>
```

---

## Audio

```html
<!-- Auto-plays when slide is active -->
<audio src="narration.mp3" data-autoplay></audio>

<!-- With controls (manual play) -->
<audio src="recording.mp3" controls></audio>

<!-- Loop background music -->
<audio src="ambient.mp3" data-autoplay loop></audio>
```

For per-slide narration, the rajgoel **Audio Slideshow** plugin provides a more complete solution (record, playback, sync with slides). See `plugins-reference.md`.

---

## Iframes

```html
<!-- Standard iframe -->
<section>
  <iframe src="https://example.com"
          width="800" height="500"
          frameborder="0">
  </iframe>
</section>

<!-- Auto-focuses when slide activates (for interactive content) -->
<section>
  <iframe src="https://editor.example.com"
          data-autoplay
          width="960" height="600">
  </iframe>
</section>

<!-- As background (full-slide iframe) -->
<section data-background-iframe="https://example.com"
         data-background-interactive>
  <div style="position: absolute; top: 0; right: 0; background: rgba(0,0,0,0.7); padding: 8px;">
    <h3 style="color: white; margin: 0;">Slide title</h3>
  </div>
</section>
```

`data-background-interactive`: lets the audience click/interact with the iframe content.
Without it, the iframe is visible but not interactive (useful for backgrounds).

### Useful iframe embeds

```html
<!-- Live code editor -->
<iframe src="https://replit.com/@user/project?embed=1" width="800" height="500"></iframe>

<!-- Observable notebook -->
<iframe src="https://observablehq.com/embed/@user/notebook?cells=chart" width="800" height="500"></iframe>

<!-- YouTube (no autoplay on embed) -->
<iframe src="https://www.youtube.com/embed/VIDEO_ID" width="800" height="450" allowfullscreen></iframe>
```

---

## Lightbox / Preview

reveal.js has built-in lightbox functionality for clicking images/links to see them enlarged.

### Image lightbox

```html
<!-- Click to preview the same image full-screen -->
<img src="diagram.png" data-preview-image>

<!-- Click to preview a different (higher-res) image -->
<img src="diagram-thumb.png" data-preview-image="diagram-full.png">

<!-- Link that opens image preview -->
<a href="#" data-preview-image="diagram.png">View diagram</a>
```

Fit options:
```html
<!-- Entire image visible (letterboxed) -->
<img src="diagram.png" data-preview-image data-preview-fit="contain">

<!-- Fill entire viewport (cropped) -->
<img src="photo.jpg" data-preview-image data-preview-fit="cover">
```

### Video lightbox

```html
<!-- Click to preview video -->
<img src="video-thumbnail.png" data-preview-video="demo.mp4">

<!-- From a video element -->
<video src="demo.mp4" data-preview-video></video>

<!-- From a link -->
<a href="#" data-preview-video="demo.mp4">Watch demo</a>
```

### Link preview (iframe)

```html
<!-- Click to open link in an iframe overlay -->
<a data-preview-link href="https://docs.example.com">View docs</a>

<!-- Disable preview for a specific link -->
<a data-preview-link="false" href="https://example.com">Regular link</a>

<!-- Image that opens a website preview -->
<img src="screenshot.png" data-preview-link="https://example.com">
```

Enable link previews globally:
```javascript
Reveal.initialize({
  previewLinks: true  // all links open as preview by default
});
```

---

## Data-autoplay behavior

`data-autoplay` on `<video>`, `<audio>`, and `<iframe>` elements triggers when:
- The slide containing the element becomes the active slide
- The element is inside a fragment: when the fragment becomes visible

Does **not** trigger:
- On PDF export
- When advancing fragments on the same slide (only on slide entry or fragment reveal)
