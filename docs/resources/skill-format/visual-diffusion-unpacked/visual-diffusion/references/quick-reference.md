# Quick Reference: Model Selection & Platform Access

## Image Model Selection

### When to use natural language models (Nano Banana, GPT Image 1, FLUX)
- Complex conversational prompts with nuanced descriptions
- You want to describe naturally without learning syntax
- Need excellent text rendering (Nano Banana Pro, GPT Image 1)
- Fast iteration (Nano Banana: 2.3 seconds)

### When to use Stable Diffusion variants
- Need fine-tuned style control with LoRA training
- Local deployment requirements
- Want full control over negative prompts and weight modifiers
- **SD3.5 Large**: Best open-source option, excellent text rendering
- **SD 1.5/2.1**: Lower VRAM requirements (4-8GB)

### When to use Midjourney
- Want strong artistic interpretation and aesthetic maximalism
- Need style references (--sref) and character references (--cref)
- Photorealism benchmarks (V7 tops commercial options)
- Working in Discord or web interface

### When to use specialized models
- **Ideogram 3.0 / Recraft V3**: 85-90% text accuracy, best for typography
- **FLUX.1 [pro]**: SOTA benchmark performance, 4MP resolution
- **Imagen 3**: SynthID watermarking for authenticity

## Video Model Selection

### When to use Sora 2 / 2 Pro
- **Highest production value**: You have detailed cinematography requirements
- Need production-brief format with lens/grade control
- Want 4K HDR output
- Native audio generation with dialogue/SFX

### When to use Veo 3 / 3.1
- **Native audio/dialogue generation** is critical
- Need multi-shot timestamp-based prompts
- Character consistency across scenes (up to 3 reference images)
- Want synchronized sound effects and ambient noise

### When to use Runway Gen-3
- **Quick iterations** and experimental work
- Need slider controls for precise camera movement
- Want fast generation with Gen-3 Alpha Turbo
- Working with 10-second duration limit

### When to use Runway Gen-2
- Need **Motion Brush** for region-specific motion control
- Want 27+ built-in style presets
- Working with shorter clips (5 seconds)

### When to use Luma Ray2 / Ray3
- **Longest videos**: 30-60 seconds with extend feature
- Need 4K HDR (16-bit) quality
- Visual annotations workflow
- Excellent camera understanding

### When to use Kling 2.0 Master
- **Highest motion quality** and physics simulation
- 2-minute video generation
- Chinese text rendering
- Professional cinematography

## Platform Access Recommendations

### For quick experimentation: **Poe**
- Marketplace with multiple models accessible
- Straightforward model selection (interface could be better)
- Good for trying different models with same prompt
- Pay-per-use or subscription options

### For production work
- **Midjourney**: Discord or web interface ($10-120/mo)
- **Runway**: Web interface (Gen-2/Gen-3)
- **Google AI Studio / ImageFX**: Nano Banana, Imagen 3
- **OpenAI API**: GPT Image 1
- **Luma AI**: Ray2/Ray3 web interface

### For local deployment
- **Stable Diffusion**: AUTOMATIC1111, ComfyUI
- **FLUX.1**: HuggingFace, local inference
- **CogVideoX**: Local video generation (12GB+ VRAM)

## Syntax Quick Reference

### Stable Diffusion Weight Modifiers
```
(keyword)       = 1.1× weight
((keyword))     = 1.21× weight (1.1²)
(keyword:1.5)   = 1.5× weight (explicit)
[keyword]       = 0.9× weight (decrease)
```

**Practical range**: 0.5 to 1.5 (values >2.0 degrade quality)

**BREAK keyword**: Forces new 75-token chunk, prevents color/attribute bleeding
```
impressionist landscape BREAK cyberpunk city
```

### Midjourney Parameters
```
--ar 16:9              Aspect ratio
--stylize 0-1000      Artistic interpretation (0=literal, 1000=max artistry)
--chaos 0-100         Generation consistency
--quality 0.25-2      Speed vs detail balance
--sref [URL]          Style reference
--cref [URL]          Character reference
```

**Multi-prompts**: Use `::` for weight distribution
```
sunset over ocean:: mountains in background::0.5
```

### Runway Gen-3 Camera Sliders
Six directional controls from **-10 to +10**:
- Horizontal, Vertical, Pan, Tilt, Zoom, Roll
- Intensity: 0.1-1 = subtle, 4-6 = noticeable, 7-10 = dramatic

### Veo 3.1 Timestamp Prompting
```
[00:00-00:02] Medium shot from behind explorer
[00:02-00:04] Reverse shot of her face
[00:04-00:06] Tracking shot following her
```

**Audio syntax**:
```
SFX: thunder cracks in distance
The woman says, "We have to leave now."
Ambient noise: quiet hum of starship bridge
accompanied by mellow, soulful hip-hop beat
```

## Text Rendering Hierarchy (2025)

**Best for typography**:
1. Ideogram 3.0 / Recraft V3 (85-90% accuracy)
2. GPT Image 1 (800+ characters multi-line)
3. Nano Banana/Pro (excellent understanding)
4. FLUX.1 variants
5. SD3.5
6. Midjourney V7 (production-quality)

## Critical Universal Rules

**One camera setup + one subject action per shot**

Complex multi-action sequences cause inconsistencies across ALL models. Generate shorter clips and stitch rather than attempting longer complex generations.

**For images**: Front-load most important elements (subject → action → attributes → environment → style)

**For video**: 
- Sora 2: Duration/resolution MUST be API parameters (prose has zero effect)
- Runway Gen-3: 500-character limit, NO negative language
- Veo 3.1: Comma-separated negative terms, not instructions
