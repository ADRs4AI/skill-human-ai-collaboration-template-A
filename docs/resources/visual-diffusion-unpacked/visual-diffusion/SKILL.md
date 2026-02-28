---
name: visual-diffusion
description: Expert prompting for image and video diffusion models (Nano Banana, GPT Image 1, DALL-E 3, Midjourney, Stable Diffusion, FLUX, Sora, Runway, Veo, Kling). Use when creating high-fidelity visual content - album art, concept art, creative visuals - where technical vocabulary and model-specific syntax dramatically improve output quality. Specializes in iterative dialogic refinement, multi-concept generation, and model-specific optimization.
---

# Visual Diffusion Model Prompting

## Overview

This skill enables professional-quality prompting for major image and video diffusion models. The core principle: **precise technical vocabulary transforms output quality dramatically**. Where generic prompts produce bland results, cinematography terminology, lighting specifications, and artistic references unlock the full expressivity of these models.

**Critical insight from field testing**: Prompts using this skill's technical framework produce results described as "an embarrassment of riches" compared to conversational attempts without proper vocabulary.

## When to Use This Skill

Trigger this skill for:
- **High-concept creative work**: Album art, concept art, visual narratives
- **Iterative creative development**: Songs, stories, themes requiring visual expression
- **Multi-concept generation**: Generate 10+ diverse visual directions, then refine
- **Model-specific optimization**: Same concept adapted for Sora vs Midjourney vs FLUX
- **Quality-critical applications**: Where technical precision matters over quick drafts

**Do NOT use** for simple, generic image requests ("a cat sitting"). This skill is for high-fidelity creative work.

## The Dialogic Workflow

The killer app of this skill is **iterative refinement through conversation**:

### Stage 1: Concept Diversity (First Pass)
1. User provides rich creative input (song lyrics, narrative, theme)
2. Generate 10+ dramatically different visual concepts
3. Each concept uses full technical vocabulary from the guides
4. Concepts explore different artistic approaches, compositions, moods

**Example prompt structure**:
```
"Generate 10 album cover concepts for [song/theme].
Target models: Nano Banana and GPT Image 1.
Use full cinematography vocabulary, artistic movements,
lighting techniques from the guides."
```

### Stage 2: Patchwork Preview (Optional)
For initial concept evaluation:
- Request single image showing all concepts in patchwork/grid
- Enables coarse-grained comparison
- Helps identify most promising directions

### Stage 3: Refinement Through Dialogue
1. User provides specific feedback on concepts
2. Iterate on promising concepts with technical adjustments
3. Adapt prompts for different models as needed
4. Refine until achieving desired result

**Feedback examples**:
- "The chiaroscuro concept is haunting - can you create variations?"
- "Concept 3 is too busy, needs more universal appeal"
- "Love the carnival energy but needs more Caribbean scenery"

## Model Selection Strategy

**Before generating prompts, determine optimal model(s)**:

Load `references/quick-reference.md` for fast model selection based on:
- Content type (image vs video)
- Duration requirements (video)
- Text rendering needs
- Artistic style requirements
- Platform access

Load `references/model-taxonomy.md` for comprehensive model capabilities, benchmarks, and specifications.

## The Technical Vocabulary Advantage

**The single most important principle**: Models respond to precise technical language.

### Instead of vague descriptions:
❌ "moody atmosphere with nice lighting"
❌ "make it look artistic"
❌ "good quality image"

### Use specific cinematography vocabulary:
✅ "chiaroscuro lighting with tenebrism-style dramatic darkness, single spotlight creating Caravaggio-like contrast"
✅ "70s Rio samba-jazz aesthetic, analog film grain, Kodachrome color palette, warm tungsten lighting with slight yellow cast"
✅ "volumetric lighting with visible rays through atmospheric haze, 85mm portrait lens at f/1.4 creating creamy bokeh"

**This specificity is what transforms output from bland to exceptional.**

## Loading the Comprehensive Guides

**When to load full guides**:
- User requests high-fidelity creative work
- Quality and expressivity are priorities
- Multiple concepts or iterations needed
- Model-specific optimization required

**How to use guides**:

1. **Start with quick-reference.md** for model selection
2. **Load image-prompting.md** when crafting image prompts
   - Universal prompt structure patterns
   - Syntax systems (SD, Midjourney, natural language)
   - Artistic movements and style vocabulary
   - Lighting, composition, camera specifications
3. **Load video-prompting.md** when crafting video prompts
   - Model-specific syntax (Sora, Runway, Veo)
   - Camera movement vocabulary
   - Shot types and framing
   - Temporal dynamics and scene transitions
4. **Load model-taxonomy.md** for specific model capabilities and constraints

**Critical**: Load these guides INTO CONTEXT at the start of high-fidelity work. Don't try to use RAG or reference them externally - the full vocabulary needs to be available for prompt construction.

## Prompt Construction Framework

Follow these patterns for maximum quality:

### Image Prompts (Universal Structure)
```
[Medium/Frame] + [Subject] + [Action/Pose] + [Attributes] + 
[Environment] + [Lighting] + [Camera] + [Style] + 
[Artist Reference] + [Quality Modifiers]
```

**Example**:
"A cinematic photograph of a warrior in ornate armor, sword raised high, long red hair flowing, standing in ancient ruins at sunset, dramatic volumetric lighting through fog, 85mm lens with shallow depth of field, in the style of Frank Frazetta, highly detailed, 8K, sharp focus."

### Video Prompts (Model-Dependent)

**Sora 2**:
```
[Scene description in prose]

Cinematography:
Camera shot: [framing and angle]
Mood: [tone]

Actions:
- [Specific beat 1]
- [Specific beat 2]

Dialogue:
[Speaker]: "Line"
```

**Runway Gen-3**:
```
[camera movement]: [establishing scene]. [additional details].
```

**Veo 3.1**:
```
[00:00-00:02] [Shot type] [action]
[00:02-00:04] [Shot type] [action]

SFX: [sound effects]
[Character] says, "dialogue"
```

See full guides for complete specifications.

## Multi-Model Strategy

**For maximum creative exploration**: Generate prompts optimized for multiple models.

**Example workflow**:
1. Generate 10 concepts using natural language (Nano Banana/GPT Image 1)
2. Identify 3 favorite concepts
3. Adapt those 3 for Midjourney (add parameters, adjust syntax)
4. Adapt those 3 for FLUX.1 (emphasize technical photography vocabulary)
5. Compare results across models

**Why this works**: Different models excel at different aesthetics. Midjourney's artistic interpretation may transform a concept differently than Nano Banana's precision.

## Common Failure Patterns to Avoid

Based on field testing:

❌ **Overcomplicated compositions**: Multiple actions/scenes in one prompt
❌ **Vague qualifiers**: "good," "nice," "interesting"
❌ **Missing context**: For concept art, provide full creative context
❌ **Wrong model selection**: Using Sora for still images, DALL-E for complex prompts
❌ **Ignoring model constraints**: Sora duration must be API parameter, not prose
❌ **Generic style requests**: "make it artistic" vs "chiaroscuro lighting, tenebrism"

✅ **One camera setup + one subject action per generation**
✅ **Front-load critical elements** (subject → action → environment)
✅ **Use specific technical vocabulary** from the guides
✅ **Provide rich creative context** for concept work
✅ **Iterate through dialogue** rather than expecting perfection first try

## Example: Song to Concept Art Workflow

**User provides**: Song lyrics with style/mood
**Claude's response**:
1. Loads image-prompting.md
2. Analyzes song themes, mood, imagery
3. Generates 10 distinct visual concepts
4. Each concept uses full technical vocabulary:
   - Specific lighting techniques
   - Camera angles and lenses
   - Artistic movement references
   - Color palettes and grading
   - Compositional elements
5. Optimizes for target models (Nano Banana, GPT Image 1)

**User provides feedback**: "Love concept 3, can you make it more [specific request]?"
**Claude iterates**: Refines concept 3 with technical adjustments

**Result**: Professional-quality album art concepts ready for generation.

## Resources

### references/
- **image-prompting.md**: Comprehensive guide to image diffusion models
- **video-prompting.md**: Complete video generation taxonomy
- **model-taxonomy.md**: All models 2021-2025 with capabilities and benchmarks
- **quick-reference.md**: Fast model selection and syntax reminders

**Usage**: Load comprehensive guides into context at start of high-fidelity work. Use quick-reference for fast decisions.
