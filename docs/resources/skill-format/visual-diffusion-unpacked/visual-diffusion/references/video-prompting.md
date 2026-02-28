# Text-to-Video Prompt Engineering: A Complete Technical Taxonomy

**Video generation models respond to prompts like briefing a cinematographer who has never seen your storyboard.** The difference between amateur and professional AI video output lies in precise technical vocabulary, model-specific syntax, and understanding what can—and cannot—be controlled through text. This comprehensive taxonomy covers Sora 2, Runway Gen-2/Gen-3, and Google Veo/VO 3.1, documenting every controllable parameter, camera movement, temporal dynamic, and artifact-prevention technique available through prompting.

---

## Three fundamentally different prompting philosophies

Each major video generation platform approaches prompts differently. **Sora 2** treats prompts like production briefs, expecting cinematography specs and shot lists. **Runway Gen-3** thrives on "temporally dense captions"—rich descriptions with camera movement as the lead element. **Veo 3.1** uses a five-part formula (cinematography + subject + action + context + style) and uniquely generates synchronized native audio from prompt descriptions.

The most critical distinction: Sora 2 separates API parameters (duration, resolution) from prose entirely—writing "make it longer" does nothing. Runway uses slider-based camera controls alongside text. Veo accepts timestamp-based multi-shot prompts that other models cannot parse.

---

## Model-specific syntax and parameters

### Sora 2 prompt architecture

Sora 2's official template separates prose from technical specifications:

```
[Scene description in prose. Characters, costumes, scenery, weather.]

Cinematography:
Camera shot: [framing and angle]
Mood: [overall tone]

Actions:
- [Action 1: specific beat]
- [Action 2: distinct action]

Dialogue:
[Speaker]: "Line"
```

**Non-negotiable API parameters** (cannot be set via prose):
| Parameter | Options | Notes |
|-----------|---------|-------|
| `model` | `sora-2`, `sora-2-pro` | Pro adds 1024×1792 resolution |
| `size` | 1280×720, 720×1280 | Must match input_reference |
| `seconds` | "4", "8", "12" | Shorter clips = more reliable |

**What works in Sora prose**: Lens specs ("50mm spherical primes"), color grading ("teal-orange grade"), lighting ("4×4 ultrabounce silver from trackside"), audio exclusions ("no score, diegetic only"), negative elements ("avoid Dutch angles").

**What doesn't work**: Duration requests, resolution changes, quality settings—these require API parameters.

### Runway Gen-3 Alpha syntax

Runway's recommended structure places camera first:

```
[camera movement]: [establishing scene]. [additional details].
```

Or the two-part alternative:
```
Visual: [scene description]
Camera motion: [movements and transitions]
```

**Critical constraints**: 500-character maximum, no negative prompts ("no" or "don't" may trigger the opposite), no conversational language.

**Camera Control Sliders** (Gen-3 Alpha Turbo): Six directional controls from **-10 to +10**:
- Horizontal (move left/right)
- Vertical (move up/down)  
- Pan (rotate left/right)
- Tilt (tilt up/down)
- Zoom (in/out)
- Roll (clockwise/counter-clockwise)

Intensity guide: 0.1–1 = subtle, 4–6 = noticeable, 7–10 = dramatic.

**Gen-2 vs Gen-3 key differences**: Gen-2 has 27+ built-in style presets (Claymation, Anime, 80s Vaporwave) and Motion Brush for painting motion onto regions. Gen-3 Alpha removes these features but supports more complex prompts and 10-second durations.

### Veo 3.1 prompt structure

Google's five-part formula:
```
[Cinematography] + [Subject] + [Action] + [Context] + [Style & Ambiance]
```

**Unique to Veo—timestamp prompting**:
```
[00:00-00:02] Medium shot from behind explorer pushing aside vines
[00:02-00:04] Reverse shot of her face, expression filled with awe
[00:04-00:06] Tracking shot following her into ruins
[00:06-00:08] Wide crane shot revealing temple complex
```

**Native audio syntax** (Veo 3+ only):
- Dialogue: `The woman says, "We have to leave now."`
- SFX: `SFX: thunder cracks in the distance`
- Ambient: `Ambient noise: quiet hum of a starship bridge`
- Music: `accompanied by a mellow, soulful hip-hop beat`

**Negative prompt syntax**: Avoid instructive language. Use `wall, frame` (comma-separated exclusions), not "no walls."

**Key API parameters**:
| Parameter | Values |
|-----------|--------|
| `aspectRatio` | "16:9", "9:16" |
| `durationSeconds` | 4, 6, 8 |
| `resolution` | "720p", "1080p" |
| `generateAudio` | true/false |
| `referenceType` | "asset" (character), "style" (aesthetic) |

---

## Camera movement vocabulary that models understand

### Pan and tilt movements

| Movement | Prompt Phrasing | Effect |
|----------|-----------------|--------|
| **Pan** | "camera pans slowly left to right" | Horizontal sweep revealing scene |
| **Whip pan** | "whip pan to the subject" | Fast, blurred horizontal motion |
| **Tilt up** | "tilt up from ground level" | Vertical reveal of height/scale |
| **Slow tilt** | "camera slowly tilts upward to reveal" | Deliberate vertical discovery |

### Dolly, tracking, and crane shots

| Movement | Prompt Phrasing | Effect |
|----------|-----------------|--------|
| **Dolly in** | "dolly in on the subject's face" | Physical approach building tension |
| **Pull back** | "camera pulls back to reveal the landscape" | Context revelation |
| **Tracking shot** | "tracking shot following the runner" | Parallel movement with subject |
| **Truck left/right** | "truck left alongside the protagonist" | Lateral follow |
| **Crane shot** | "crane shot rising above the city" | Dramatic vertical elevation |
| **Pedestal up** | "pedestal up from ground level to eye level" | Camera rises vertically |

### Complex and compound movements

| Movement | Prompt Phrasing | Effect |
|----------|-----------------|--------|
| **Dolly zoom** | "dolly zoom creating vertigo effect" | Psychological distortion (Hitchcock) |
| **Arc/orbit** | "camera orbits 360° around the subject" | Circular movement |
| **FPV** | "continuous hyperspeed FPV through canyon" | Immersive first-person drone |
| **Push + pan** | "push in while panning left" | Combined approach with rotation |

### Stabilization and style descriptors

- **Steadicam**: "Steadicam following character through crowd"—smooth, polished
- **Handheld**: "handheld, shaky cam following"—raw, documentary feel
- **Gimbal**: "gimbal-stabilized tracking"—modern smooth follow
- **Static/locked**: "static camera, no movement" or "immobile camera position"

**Note**: For static shots, "immobile" often achieves better AI adherence than "static."

---

## Shot types and framing terminology

### Shot sizes (distance from subject)

| Shot Type | Prompt Term | Shows |
|-----------|-------------|-------|
| **Extreme wide (EWS)** | "extreme wide shot of landscape" | Vast environment, tiny subject |
| **Wide/long shot** | "wide shot showing full environment" | Full body + surroundings |
| **Cowboy shot** | "cowboy shot from thighs up" | Knees/thighs to head |
| **Medium shot** | "medium shot waist up" | Waist to head (dialogue standard) |
| **Close-up** | "close-up of the face" | Face fills frame |
| **Extreme close-up** | "extreme close-up of eyes" | Single feature |

### Camera angles and their psychological effects

| Angle | Effect | Prompt Term |
|-------|--------|-------------|
| **Eye level** | Neutral, natural | "eye level shot" |
| **Low angle** | Subject appears powerful | "low angle shot looking up" |
| **High angle** | Subject appears vulnerable | "high angle shot looking down" |
| **Dutch angle** | Disorientation, unease | "Dutch angle with tilted horizon" |
| **Bird's eye** | God's-eye strategic view | "overhead shot looking straight down" |
| **Worm's eye** | Extreme drama | "worm's eye view from ground" |

---

## Lens specifications and depth control

### Focal length vocabulary

| Focal Length | Prompt Term | Visual Effect |
|--------------|-------------|---------------|
| **15-18mm** | "15mm fisheye lens" | Extreme distortion, warped edges |
| **24mm** | "24mm wide-angle lens" | Broad view, dramatic depth |
| **35mm** | "35mm lens" | Natural perspective |
| **50mm** | "50mm prime lens" | Documentary feel, minimal distortion |
| **85mm** | "85mm portrait lens" | Flattering compression, subject isolation |
| **135mm+** | "135mm lens, creamy background" | Strong compression, telephoto |

### Depth of field control

| Term | Prompt Phrasing | Effect |
|------|-----------------|--------|
| **Shallow DOF** | "shallow depth of field, blurred background" | Subject isolation |
| **Deep focus** | "deep focus, everything sharp" | Full scene clarity |
| **Rack focus** | "rack focus from foreground to background" | Shifting attention |
| **Bokeh** | "beautiful bokeh in background" | Pleasing blur quality |
| **Anamorphic** | "anamorphic lens, horizontal flare" | Cinematic oval bokeh, 2.39:1 feel |

---

## Motion control parameters

### Speed descriptors

| Category | Keywords |
|----------|----------|
| **Slow motion** | "slow-motion," "0.25x speed," "languid," "unhurried" |
| **Real-time** | "real-time," "natural pace," "1x speed" |
| **Fast/timelapse** | "time-lapse," "hyperspeed," "2x-4x speed," "frenetic" |
| **Speed transitions** | "speed ramp," "gradual acceleration," "ease-in-ease-out" |

### Direction and physics vocabulary

**Trajectory terms**: forward, backward, left to right, diagonal, ascending, descending, orbit, arc, spiral, zigzag, oscillating, pendulum swing

**Physics keywords**: "falling naturally," "settling with weight," "wind-blown," "momentum," "collision," "realistic water physics," "cloth simulation," "fluid dynamics"

**Force modifiers**: "gently swaying" vs "violently swaying," "smoothly rotating" vs "explosively bursting"

### Object motion vs camera motion

Distinguish clearly in prompts:
- **Subject motion**: "hair flowing gently in wind," "eyes darting slightly," "natural breathing motion"
- **Camera motion**: "camera dollies in slowly," "slow pan revealing," "tracking alongside"

Combining both: "The dancer spins (subject) while the camera orbits counterclockwise (camera)."

---

## Temporal consistency and artifact prevention

### Common artifacts and solutions

| Artifact | Cause | Prevention |
|----------|-------|------------|
| **Flickering** | Details appear/disappear across frames | Simplify scenes; use consistency-focused models |
| **Morphing/drift** | Identity changes between shots | Strong reference images; identical prompt language |
| **Jitter** | Unstable motion | "smooth," "fluid," "steady" descriptors; avoid contradictory motion |
| **Blocking artifacts** | Compression | Higher resolution; proper encoding |

### Prompt techniques for stable output

**Identity anchoring**: Repeat exact phrases. Use "brown trench coat" consistently—not "coat" then "jacket." Specify immutable traits first (age, ethnicity, hair length/color, signature features).

**Stability keywords**: "maintains consistent appearance throughout," "smooth transitions," "fluid motion," "stable identity," "coherent movement"

**Structural best practices**:
1. Start simple; add elements one at a time
2. Describe what SHOULD happen, never what shouldn't
3. One clear scene per 5–10 second generation
4. Use "the man extends his arm" not "make him wave"

### Character consistency techniques

**Reference image method**: Upload 1–4 high-quality images. AI uses cross-frame keypoint tracking. Face, outfit, body shape locked frame-by-frame.

**Last-frame chaining**: Export final frame of each clip; use as reference for next generation. Creates continuous visual thread.

**Character sheet technique**: Generate single image showing character from multiple angles (front, full body, back, profile). Use as master reference for all generations.

**LoRA training** (advanced): Train Low-Rank Adapter on 30–50 reference images for permanent character embedding.

---

## Scene composition and staging

### Depth staging terminology

| Layer | Prompt Approach |
|-------|-----------------|
| **Foreground** | "foreground elements framing subject," "blurred foreground plants" |
| **Midground** | "subject positioned in midground" |
| **Background** | "background activity behind subject," "distant mountains" |
| **Layered** | "layered depth with foreground foliage and background city" |

### Blocking vocabulary

Describe character positioning relative to camera and environment:
- "Character enters frame left"
- "Two figures face each other, medium two-shot"
- "Subject positioned on rule of thirds, camera right"
- "Over-the-shoulder framing, protagonist in foreground"

### Environmental storytelling terms

Include narrative-rich setting details: "cluttered detective's desk with coffee-stained papers," "pristine laboratory with humming equipment," "weathered fishing boat with peeling paint"

---

## Lighting control over time

### Time-of-day progression vocabulary

| Time | Keywords |
|------|----------|
| **Dawn** | "sunrise," "first light," "morning mist," "soft morning light" |
| **Golden hour** | "golden hour," "warm golden glow," "long shadows," "sun-kissed" |
| **Midday** | "harsh noon sunlight," "minimal shadows," "overhead lighting" |
| **Blue hour** | "twilight," "dusk," "cool blue tones," "city lights emerging" |
| **Night** | "moonlit," "neon glow," "sodium vapor lights," "deep shadows" |

### Lighting mood descriptors

| Type | Prompt Phrasing |
|------|-----------------|
| **Soft/diffused** | "soft, diffused shadows," "gentle flattering light" |
| **Hard** | "hard light, bold shadows, high contrast" |
| **Rim** | "rim light defining edges," "golden rim light" |
| **Backlit** | "backlit silhouette effect," "halo backlighting" |
| **Volumetric** | "volumetric lighting with visible rays through fog" |
| **Chiaroscuro** | "chiaroscuro, strong contrast between light and dark" |

### Weather transitions

Static weather: "misty," "fog-shrouded," "rain-soaked," "snow-covered," "crisp and clear"

Dynamic prompts: "clouds moving across time-lapse sky," "rain beginning to fall, wet surfaces reflecting light," "fog slowly rolling in across the valley"

---

## Multi-scene and narrative techniques

### Scene transition vocabulary

| Transition | Prompt Usage |
|------------|--------------|
| **Direct cut** | Separate prompts; edit together |
| **Fade** | "fade to black," "fade to white" |
| **Dissolve** | "cross-dissolve to next scene" |
| **Morphing** | "morphing through wall of water," "dissolving into particles" |

**Hunyuan multi-shot syntax**: `[Scene 1] + Camera Switch to + [Scene 2]`

### Timestamp-based scene control (Veo 3.1 exclusive)

```
[00:00-00:02] Wide establishing shot of city at dawn
[00:02-00:04] Medium shot, protagonist walks into frame
[00:04-00:06] Close-up on face, expression shifts to concern
[00:06-00:08] POV shot of what they're seeing
```

### Storyboarding workflow

1. **Script analysis**: Define characters, scenes, actions
2. **Keyframe generation**: Create reference images for each shot
3. **Shot list creation**: Shot size, camera movement, lens, duration
4. **Sequential generation**: Generate clips maintaining consistency
5. **Assembly**: Edit with transitions, audio, color grading

**Consistency across scenes**: Maintain identical character descriptors, consistent lighting vocabulary, same aspect ratio, last-frame chaining between clips.

---

## Style and aesthetic control

### Visual style keywords

| Category | Keywords |
|----------|----------|
| **Photorealistic** | "photorealistic," "hyperrealistic," "8K resolution" |
| **Cinematic** | "cinematic," "film noir," "anamorphic," "shallow DOF" |
| **Era-specific** | "1970s film," "90s documentary," "vintage 16mm" |
| **Animation** | "3D cartoon render," "anime," "claymation," "stop-motion" |
| **Genre** | "cyberpunk," "steampunk," "fantasy," "sci-fi" |

### Color grading vocabulary

- **Teal and orange**: Hollywood blockbuster look
- **Cool blue**: Sterile, sci-fi atmosphere
- **Warm film tones**: Nostalgic, organic feel
- **Desaturated/muted**: Serious, dramatic weight
- **High contrast**: Bold, punchy impact

### Film stock emulations

"Shot on Kodak Portra 400," "35mm film grain," "Cinestill 800T," "film halation, subtle bloom," "vintage light leaks"

---

## Audio prompting (Veo 3+ exclusive)

Veo 3.1 uniquely generates synchronized native audio. Other models require post-production audio.

### Audio element syntax

**Dialogue**: Use quotation marks or colons
```
The detective says, "You're lying."
The woman says: We have to leave now
```

**Sound effects**: Prefix with SFX
```
SFX: thunder cracks in distance
SFX: phone ringing, footsteps on gravel
```

**Ambient noise**: Describe atmosphere
```
Ambient noise: quiet hum of starship bridge
Sounds of distant bands, noisy crowd
```

**Music**: Describe style and mood
```
accompanied by mellow, soulful hip-hop beat
swelling orchestral score begins to play
```

**Best practices**: Keep dialogue short (fits 8-second window), use phonetic spelling for pronunciation, add `(no subtitles)` if needed, specify ambient sounds to avoid unwanted "live studio audience" artifacts.

---

## Model comparison: when to use each

| Use Case | Best Model | Reason |
|----------|------------|--------|
| **Highest production value** | Sora 2 Pro | Production-brief format, lens/grade control |
| **Native audio generation** | Veo 3.1 | Only model with dialogue/SFX synthesis |
| **Quick iterations** | Runway Gen-3 Alpha Turbo | Fast generation, slider controls |
| **Motion brush/painting** | Runway Gen-2 | Region-specific motion control |
| **Multi-shot timestamps** | Veo 3.1 | Native timestamp prompting |
| **Character consistency** | Veo 3.1 + asset refs | Up to 3 reference images |
| **Experimental styles** | Short Sora prompts | Model improvises creatively |

---

## Complete prompt formula

The universal structure that works across models:

```
[Subject + distinctive consistent features] + 
[Action with timing/pacing] + 
[Camera: shot type, movement, lens] + 
[Lighting setup] + 
[Atmosphere/mood] + 
[Style/quality descriptors]
```

**Example combining all elements**:

"A woman in a red jacket with silver pendant, brown hair in ponytail, maintains consistent appearance throughout. She walks through a sunlit forest path, leaves drifting past her face. Medium tracking shot, 50mm lens, shallow depth of field, camera moves alongside at walking pace. Golden hour lighting, warm tones, volumetric light rays through canopy. Cinematic quality, subtle film grain, 4K resolution."

---

## Key technical constraints by model

**Sora 2**: Duration (4/8/12s), resolution, and model selection MUST be set via API—prose has zero effect. Shorter clips (4s) dramatically outperform longer ones for reliability.

**Runway Gen-3**: 500-character limit. Never use negative language. Camera sliders range -10 to +10. Motion Brush removed in Gen-3.

**Veo 3.1**: Supports up to 3 asset reference images + 1 style reference. Timestamp prompting works; negative prompts must be comma-separated terms, not instructions. `generateAudio` parameter required for sound.

**Universal rule**: One camera setup + one subject action per shot. Complex multi-action sequences cause inconsistencies across all models. Generate shorter clips and stitch rather than attempting longer complex generations.

This taxonomy represents the current state of controllable parameters in text-to-video generation. As models evolve, new control mechanisms emerge—but the foundational cinematography vocabulary, temporal consistency techniques, and structural principles documented here form the stable foundation of professional AI video prompting.