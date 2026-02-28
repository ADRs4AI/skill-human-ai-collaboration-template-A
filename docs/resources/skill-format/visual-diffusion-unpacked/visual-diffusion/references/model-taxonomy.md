# Diffusion Models Reference Taxonomy (2021-2025)

This longitudinal reference documents the evolution of publicly available diffusion models for image and video generation from inception through December 2025. Designed for AI systems to understand user queries about specific models and make informed recommendations, this taxonomy tracks **architectural innovations, capability progressions, and syntax shifts** across the field's rapid development.

## Key evolutionary findings

The diffusion model landscape underwent four major architectural transitions between 2021-2025. **U-Net dominance (2021-2023)** established latent diffusion as the standard, with Stable Diffusion's 890M parameter models democratizing image generation. **The DiT revolution (2023-2024)** replaced U-Nets with transformers—FLUX.1 and SD3's MMDiT architecture delivered dramatic quality improvements with 8-12B parameters. **Flow Matching emergence (2024)** introduced rectified flow for faster, more efficient training. **Native multimodality (2025)** culminated in models like GPT Image 1, Nano Banana, and Sora 2 generating content directly within language model architectures.

Text rendering evolved from "essentially broken" in 2022 to production-ready by 2025—Ideogram and Recraft led this charge, while Midjourney V7, GPT Image 1, and Nano Banana achieved excellent typography through architectural innovations. Video generation compressed from research curiosity to **4K HDR with synchronized audio** in just 18 months, with native audio generation (Veo 3, Sora 2, LTX-2) representing the field's most significant 2025 breakthrough.

---

## Table 1: Image diffusion models

### Foundational and historical models (2021-2023)

| Model | Organization | Release | Architecture | Params | Status | Open Source | Open Weights | Access | License | Text Rendering | Prompt Limit | Hands | Faces | Photorealism | Inpainting | ControlNet | Negative Prompts | Max Resolution | VRAM |
|-------|-------------|---------|--------------|--------|--------|-------------|--------------|--------|---------|----------------|--------------|-------|-------|--------------|------------|------------|------------------|----------------|------|
| **GLIDE** | OpenAI | 2021-12 | U-Net + CFG | 3.5B (300M public) | Deprecated | Yes | Partial | GitHub | MIT (code) | Poor | 77 tokens | Poor | Poor | Basic | ✓ | None | ✗ | 256×256 | ~8GB |
| **Disco Diffusion** | Community | 2022-01 | CLIP-guided | 270-550M | Deprecated | Yes | Yes | Colab | MIT | None | Variable | Poor | Poor | Basic | Basic | None | ✗ | 512×512 | 12-16GB |
| **DALL-E 2** | OpenAI | 2022-04 | Cascaded (unCLIP) | 3.5B | Deprecated | No | No | API, Web | Commercial | Poor | 400 chars | Poor | Good | Good | ✓ | None | ✗ | 1024×1024 | N/A |
| **Imagen** | Google | 2022-05 | Cascaded + T5 | ~2B+ | Research | No | No | None | Proprietary | Basic | Long (T5) | Good | Good | Excellent | ✓ | None | Unknown | 1024×1024 | N/A |
| **Parti** | Google | 2022-06 | Autoregressive | 350M-20B | Research | No | No | None | Proprietary | Good | Long | Good | Good | Excellent | Unknown | None | Unknown | 256×256+ | N/A |
| **SD 1.4** | Stability AI | 2022-08 | Latent Diffusion U-Net | 890M | Deprecated | Yes | Yes | HuggingFace | OpenRAIL-M | Poor | 77 tokens | Poor | Basic | Good | Extension | Compatible | ✓ | 512×512 | 4-8GB |
| **SD 1.5** | Runway/Stability | 2022-10 | Latent Diffusion U-Net | 890M | Production | Yes | Yes | HuggingFace | OpenRAIL-M | Poor | 77 tokens | Poor | Good | Good | ✓ | Full ecosystem | ✓ | 512×512 | 4-8GB |
| **Midjourney v4** | Midjourney | 2022-11 | Proprietary | Unknown | Deprecated | No | No | Discord | Commercial | Poor | ~60 words | Basic | Good | Excellent | ✗ | None | ✓ (--no) | 1024×1024 | N/A |
| **SD 2.0** | Stability AI | 2022-11 | LDM + OpenCLIP | 865M | Deprecated | Yes | Yes | HuggingFace | OpenRAIL++-M | Poor | 77 tokens | Basic | Basic | Good | ✓ | Compatible | ✓ | 768×768 | 6-10GB |
| **SD 2.1** | Stability AI | 2022-12 | LDM + OpenCLIP | 865M | Production | Yes | Yes | HuggingFace | OpenRAIL++-M | Poor | 77 tokens | Basic | Good | Good | ✓ | Compatible | ✓ | 768×768 | 6-10GB |
| **Midjourney v5** | Midjourney | 2023-03 | Proprietary | Unknown | Deprecated | No | No | Discord | Commercial | Poor | ~60 words | Good | Excellent | Excellent | ✗ | None | ✓ | 4096×4096 | N/A |
| **DeepFloyd IF** | Stability AI | 2023-04 | Cascaded Pixel + T5 | 400M-4.3B | Research | Yes | Yes | HuggingFace | Non-commercial | Excellent | 512+ tokens | Good | Good | Excellent | ✓ | None | ✓ | 1024×1024 | 14GB+ |
| **SDXL Base 1.0** | Stability AI | 2023-07 | U-Net LDM (3x larger) | 3.5B | Production | Yes | Yes | HuggingFace | OpenRAIL++-M | Good | 2048 context | Good | Good | Excellent | ✓ | Native | ✓ | 1024×1024 | 8GB+ |
| **DALL-E 3** | OpenAI | 2023-09 | Diffusion + GPT-4 | Unknown | Production | No | No | API, ChatGPT | Commercial | Good | Very long | Good | Excellent | Excellent | Limited | None | ✗ | 1792×1024 | N/A |
| **PixArt-α** | Huawei | 2023-10 | DiT + T5 | 600M | Production | Yes | Yes | HuggingFace | OpenRAIL++ | Good | Long | Good | Good | Excellent | ✗ | None | ✓ | 1024×1024 | ~8GB |
| **Playground v2** | Playground AI | 2023-12 | SDXL-based | 2.6B | Production | Yes | Yes | HuggingFace | Community | Good | Standard | Good | Good | Excellent | ✗ | Compatible | ✓ | 1024×1024 | 8GB |
| **Kandinsky 3.0** | Sber | 2023-12 | BigGAN U-Net + T5 | ~3B | Production | Yes | Yes | HuggingFace | Apache 2.0 | Good | Long | Good | Good | Good | ✓ | ✗ | ✓ | 1024×1024 | 10GB |
| **Midjourney v6** | Midjourney | 2023-12 | Proprietary | Unknown | Deprecated | No | No | Discord, Web | Commercial | Good | Long | Good | Excellent | Excellent | ✓ | None | ✗ | 4096×4096 | N/A |

### Modern models (2024-2025)

| Model | Organization | Release | Architecture | Params | Status | Open Source | Open Weights | Access | License | Pricing | Text Rendering | Prompt Limit | Hands | Faces | Photorealism | Inpainting | ControlNet | SREF | CREF | Negative Prompts | Max Resolution | VRAM | Notable Features |
|-------|-------------|---------|--------------|--------|--------|-------------|--------------|--------|---------|---------|----------------|--------------|-------|-------|--------------|------------|------------|------|------|------------------|----------------|------|------------------|
| **Playground v2.5** | Playground AI | 2024-02 | SDXL + EDM | 2.6B | Production | Yes | Yes | HuggingFace | Community | Free | Good | Standard | Good | Good | Excellent | ✓ | Compatible | ✗ | ✗ | ✓ | 1024×1024 | 8GB | 4.8x preferred over SDXL |
| **Ideogram 1.0** | Ideogram | 2024-02 | Proprietary | Unknown | Superseded | No | No | Web | Commercial | Free-$60/mo | Excellent | Standard | Good | Good | Excellent | ✓ | None | ✗ | ✗ | ✗ | Various | N/A | First text-focused model |
| **PixArt-Σ** | Huawei | 2024-03 | DiT + KV Compression | 600M | Production | Yes | Yes | HuggingFace | OpenRAIL++ | Free | Excellent | Long | Good | Good | Excellent | ✗ | None | ✗ | ✗ | ✓ | 4K native | ~8GB | 4K generation at 600M params |
| **SD3 Medium** | Stability AI | 2024-06 | MMDiT + Rectified Flow | 2B | Production | Yes | Yes (gated) | HuggingFace | Community | Free | Excellent | Extended (T5) | Good | Good | Excellent | Separate | Compatible | ✗ | ✗ | ✓ | 1024×1024 | ~5GB | First MMDiT architecture |
| **Midjourney v6.1** | Midjourney | 2024-07 | Proprietary | Unknown | Superseded | No | No | Discord, Web | Commercial | $10-120/mo | Good | Long | Excellent | Excellent | Excellent | ✓ | None | ✓ | ✓ | ✓ | 4096×4096 | N/A | 25% faster, web UI launch |
| **FLUX.1 [schnell]** | Black Forest Labs | 2024-08 | Rectified Flow Transformer | 12B | Production | Yes | Yes | HuggingFace | Apache 2.0 | Free | Excellent | 256 tokens | Excellent | Excellent | Excellent | Via Tools | Native | ✓ | ✓ | ✗ | Variable | 24GB | 4-step generation |
| **FLUX.1 [dev]** | Black Forest Labs | 2024-08 | Rectified Flow Transformer | 12B | Production | Yes | Yes | HuggingFace | Non-commercial | Free | Excellent | 256 tokens | Excellent | Excellent | Excellent | Via Tools | Native | ✓ | ✓ | ✗ | Variable | 24GB | Best open-weights quality |
| **FLUX.1 [pro]** | Black Forest Labs | 2024-08 | Rectified Flow Transformer | 12B | Production | No | No | API | Commercial | API pricing | Excellent | 256 tokens | Excellent | Excellent | Excellent | ✓ | Native | ✓ | ✓ | ✗ | Variable | N/A | SOTA benchmark performance |
| **Imagen 3** | Google | 2024-08 | Latent Diffusion | Unknown | Production | No | No | Gemini, ImageFX | Commercial | Free-$20/mo | Good | Long | Good | Good | Excellent | ✗ | None | ✗ | ✗ | ✗ | 1024×1024 | N/A | SynthID watermarking |
| **Ideogram 2.0** | Ideogram | 2024-08 | Proprietary | Unknown | Production | No | No | Web, API | Commercial | Free-$60/mo | Excellent | Standard | Good | Good | Excellent | ✓ | None | ✗ | ✗ | ✗ | Various | N/A | 85-90% text accuracy |
| **Playground v3** | Playground AI | 2024-09 | LLM Integration (Llama3-8B) | Unknown | Production | No | No | Web | Commercial | Free-Pro | Excellent | Extended | Good | Good | Excellent | ✓ | Unknown | ✗ | ✗ | ✗ | Various | N/A | 82% text synthesis, graphic design focus |
| **SD3.5 Large** | Stability AI | 2024-10 | MMDiT + QK Norm | 8.1B | Production | Yes | Yes | HuggingFace | Community | Free (<$1M) | Excellent | Extended | Excellent | Excellent | Excellent | Separate | Native | ✗ | ✗ | ✓ | 2MP | 12GB+ | Largest open SD model |
| **SD3.5 Large Turbo** | Stability AI | 2024-10 | Distilled MMDiT | 8.1B | Production | Yes | Yes | HuggingFace | Community | Free | Excellent | Extended | Excellent | Excellent | Excellent | ✗ | Native | ✗ | ✗ | ✓ | 2MP | 12GB+ | 4-step generation |
| **SD3.5 Medium** | Stability AI | 2024-10 | MMDiT-X | 2.5B | Production | Yes | Yes | HuggingFace | Community | Free | Good | Extended | Good | Good | Good | ✗ | Native | ✗ | ✗ | ✓ | 2MP | 10GB | Consumer hardware optimized |
| **Recraft V3** | Recraft AI | 2024-10 | Proprietary | Unknown | Production | No | No | Web, API | Commercial | Free-$10+/mo | Excellent | Long | Excellent | Excellent | Excellent | ✓ | None | ✓ | ✗ | ✗ | High | N/A | #1 HF benchmark, SVG output, text positioning |
| **FLUX.1.1 [pro]** | Black Forest Labs | 2024-10 | Improved Rectified Flow | 12B | Production | No | No | API | Commercial | API pricing | Excellent | 256 tokens | Excellent | Excellent | Excellent | ✓ | Native | ✓ | ✓ | ✗ | 4MP (Ultra) | N/A | Ultra mode, Raw mode |
| **FLUX.1 Tools** | Black Forest Labs | 2024-11 | Rectified Flow | 12B | Production | Yes | Yes | HuggingFace | Various | Free-API | Excellent | 256 tokens | Excellent | Excellent | Excellent | ✓ (Fill) | Native (Depth, Canny) | ✓ | ✓ | ✗ | Variable | 24GB | Redux, Fill, Depth, Canny |
| **GPT Image 1** | OpenAI | 2025-03 | Native Multimodal GPT-4 | Unknown | Production | No | No | ChatGPT, API | Commercial | ~$0.02-0.19/img | Excellent | Very long | Good | Excellent | Excellent | ✓ | None | ✗ | ✗ | ✗ | 1536×1024 | N/A | 800+ char text, multi-turn consistency |
| **Ideogram 3.0** | Ideogram | 2025-03 | Proprietary | Unknown | Production | No | No | Web, API | Commercial | Free-$60/mo | Excellent | Long | Excellent | Excellent | Excellent | ✓ | None | ✓ | ✗ | ✗ | Various | N/A | 4.3B style presets, Style Codes |
| **HiDream-I1** | HiDream.ai | 2025-04 | Sparse DiT + Llama 3.1 | 17B | Production | Yes | Yes | HuggingFace | MIT | Free | Excellent | Long | Good | Good | Excellent | ✗ | Unknown | ✗ | ✗ | ✓ | 1024×1024 | 60GB | SOTA HPS v2.1 score |
| **Midjourney v7** | Midjourney | 2025-04 | New architecture | Unknown | Production | No | No | Discord, Web | Commercial | $10-120/mo | Excellent | Long | Excellent | Excellent | Excellent | Separate | None | ✗ | ✓ (Omni) | ✓ | 4096×4096 | N/A | Draft mode 10x faster, Omni Reference |
| **FLUX.1 Kontext** | Black Forest Labs | 2025-06 | In-context editing | 12B | Production | Yes | Yes | HuggingFace | Non-commercial | Free | Excellent | 256 tokens | Excellent | Excellent | Excellent | ✓ | Compatible | ✓ | ✓ | ✗ | Variable | 24GB | Natural language image editing |
| **Nano Banana** (Gemini 2.5 Flash Image) | Google | 2025-08 | Multimodal DiT | 80B (13B active) | Production | No | No | Gemini API | Commercial | API pricing | Excellent | Long | Good | Excellent | Excellent | Unknown | None | ✗ | ✗ | Unknown | 1024×1024 native | N/A | 2.3s gen time, 40% better text understanding, LMArena codename |
| **Hunyuan Image 3.0** | Tencent | 2025-09 | Autoregressive 80B | 80B | Production | Yes | Yes | HuggingFace | Commercial | Free | Excellent | 1000 chars | Good | Good | Excellent | ✗ | Unknown | ✗ | ✗ | Unknown | Variable | High | Largest open image model |
| **Firefly Image 5** | Adobe | 2025-10 | Proprietary | Unknown | Production | No | No | CC Apps, Web | Commercial | CC subscription | Good | Standard | Good | Good | Excellent | ✓ | None | ✗ | ✗ | ✗ | 4MP native | N/A | Commercially safe training |
| **Nano Banana Pro** (Gemini 3 Pro Image) | Google | 2025-11 | Enhanced Multimodal DiT | Unknown | Production | No | No | Gemini API | Commercial | API pricing | Excellent | Long | Good | Excellent | Excellent | Unknown | None | ✗ | ✗ | Unknown | 4K native | N/A | 4K support, advanced text rendering |

### Extended feature matrix for major models

| Model | IP-Adapter | Regional Prompting | Transparency | Prompt Syntax | Aspect Ratios | Typical Steps | Batch Gen | LoRA | DreamBooth | Fine-tune |
|-------|------------|-------------------|--------------|---------------|---------------|---------------|-----------|------|------------|-----------|
| SD 1.5 | ✓ | Extension | ✗ | Weighted ((word:1.2)) | Variable | 20-50 | ✓ | ✓ | ✓ | ✓ |
| SDXL | ✓ | Extension | ✗ | Weighted | Multiple trained | 25-50 | ✓ | ✓ | ✓ | ✓ |
| SD3.5 Large | ✓ | Extension | ✗ | Natural + Weighted | 0.25-2MP | 28-40 | ✓ | ✓ | ✓ | ✓ |
| FLUX.1 [dev] | ✓ | Via Redux | ✗ | Natural language | Flexible | 20-50 | ✓ | ✓ | ✓ | ✓ |
| FLUX.1 [schnell] | ✓ | Limited | ✗ | Natural language | Flexible | 4 | ✓ | ✓ | Limited | Limited |
| Midjourney v7 | ✗ | Vary Region | ✗ | Natural + params | Any (--ar) | Unknown | ✓ | ✗ | ✗ | ✗ |
| GPT Image 1 | ✗ | ✗ | ✗ | Natural language | 3 options | Unknown | ✓ | ✗ | ✗ | ✗ |
| Nano Banana | ✗ | Unknown | ✗ | Natural language | Unknown | Unknown | ✓ | ✗ | ✗ | ✗ |
| Ideogram 3.0 | ✗ | ✗ | Unknown | Natural language | Custom | Unknown | ✓ | ✗ | ✗ | ✗ |
| Recraft V3 | ✗ | ✓ | ✗ | Natural + position | Custom | <10s | ✓ | ✗ | ✗ | ✗ |

---

## Table 2: Video diffusion models

### Commercial video models (2023-2025)

| Model | Organization | Release | Architecture | Params | Status | Open Source | Open Weights | Access | Pricing | Max Duration | Max Resolution | FPS | Aspect Ratios | Motion Coherence | Temporal Consistency | Anatomy (Motion) | Camera Controls | Native Audio | Img2Vid | Vid2Vid | Physics | Generation Time |
|-------|-------------|---------|--------------|--------|--------|-------------|--------------|--------|---------|--------------|----------------|-----|---------------|------------------|---------------------|------------------|-----------------|--------------|---------|---------|---------|-----------------|
| **Runway Gen-1** | Runway | 2023-03 | Diffusion | Unknown | Deprecated | No | No | Web | Subscription | 4s | 720p | 24 | Limited | Good | Good | Basic | Basic | ✗ | ✗ | ✓ | Basic | ~60s |
| **Runway Gen-2** | Runway | 2023-06 | Diffusion | Unknown | Superseded | No | No | Web, API | $12-76/mo | 18s | 768×448 | 24 | 16:9, 1:1, 9:16 | Good | Good | Good | Presets | ✗ | ✓ | ✓ | Good | ~90s |
| **Pika 1.0** | Pika Labs | 2023-11 | Diffusion | Unknown | Superseded | No | No | Web, Discord | Free-$28/mo | 4s | 1080p | 24 | Multiple | Good | Good | Good | Prompt-based | ✗ | ✓ | ✓ | Good | ~60s |
| **Sora (Preview)** | OpenAI | 2024-02 | DiT (Spacetime Patches) | Unknown | Preview | No | No | Invite only | N/A | 60s | 1080p | Unknown | Multiple | Excellent | Excellent | Good | Prompt-based | ✗ | ✓ | ✓ | Good | Unknown |
| **Kling 1.0** | Kuaishou | 2024-06 | DiT + 3D VAE | Unknown | Superseded | No | No | Web, App | ¥66-666/mo | 120s | 1080p | 30 | Multiple | Excellent | Excellent | Good | Basic | ✗ | ✓ | ✓ | Good | ~120s |
| **Luma Dream Machine** | Luma AI | 2024-06 | Proprietary | Unknown | Superseded | No | No | Web, iOS | Free-Paid | 5s | 1080p | Unknown | 16:9, 9:16, 1:1 | Good | Good | Good | Camera concepts | ✗ | ✓ | ✓ | Good | ~60s |
| **Runway Gen-3 Alpha** | Runway | 2024-07 | DiT (Multimodal) | Unknown | Production | No | No | Web | $12-76/mo | 10s | 1280×768 | 24 | 16:9, 9:16, 1:1, 21:9 | Excellent | Excellent | Good | Advanced (Motion Brush) | ✗ | ✓ | ✓ | Good | ~90s |
| **Hailuo Video-01** | MiniMax | 2024-09 | Proprietary | Unknown | Superseded | No | No | Web, Discord | Tiered | 6s | 720p | Unknown | Multiple | Excellent | Excellent | Excellent | Basic | ✗ | ✓ | ✗ | Good | ~60s |
| **Runway Gen-3 Alpha Turbo** | Runway | 2024-09 | DiT (Optimized) | Unknown | Production | No | No | Web, API | 5 credits/s | 10s | 1280×768 | 24 | Multiple | Excellent | Excellent | Good | Advanced | ✗ | ✓ | ✓ | Good | ~13s |
| **Pika 1.5** | Pika Labs | 2024-11 | Diffusion | Unknown | Superseded | No | No | Web, Discord | Free-$28/mo | 5s | 1080p | Unknown | Multiple | Good | Good | Good | Prompt-based | ✗ | ✓ | ✓ | Good | ~60s |
| **Sora Turbo** | OpenAI | 2024-12 | DiT (Optimized) | Unknown | Production | No | No | sora.com, ChatGPT | $20-200/mo | 20s | 1080p | Unknown | 16:9, 9:16, 1:1 | Excellent | Good | Good | Prompt-based | ✗ | ✓ | ✓ | Struggles | ~120s |
| **Pika 2.0** | Pika Labs | 2024-12 | Enhanced Diffusion | Unknown | Production | No | No | Web, Discord | Free-$28/mo | 8s | 1080p | Unknown | Multiple | Excellent | Excellent | Good | Prompt-based | Separate | ✓ | ✓ | Good | ~60s |
| **Kling 1.6 Pro** | Kuaishou | 2024-12 | Enhanced DiT | Unknown | Production | No | No | Web, API | Tiered | 10s | 1080p | 30 | Multiple | Excellent | Excellent | Good | Professional | ✗ | ✓ | ✓ | Good | ~90s |
| **Veo 2** | Google | 2024-12 | Transformer Diffusion | Unknown | Production | No | No | VideoFX, Vertex | Enterprise | 8s | 4K | Unknown | Multiple | Excellent | Excellent | Good | Prompt-based | ✗ | ✓ | ✗ | Good | Unknown |
| **Luma Ray2** | Luma AI | 2025-01 | 10x compute scale | Unknown | Production | No | No | Web, API | Free-Paid | 9s | 1080p (4K upscale) | Unknown | 16:9, 9:16, 1:1 | Excellent | Excellent | Good | Camera concepts | ✗ | ✓ | ✓ | Good | ~60s |
| **Pika 2.2** | Pika Labs | 2025-02 | Enhanced | Unknown | Production | No | No | Web | Free-$28/mo | 10s | 1080p | Unknown | Multiple | Excellent | Excellent | Good | Prompt-based | ✗ | ✓ | ✓ | Good | ~60s |
| **Runway Gen-4** | Runway | 2025-03 | Enhanced DiT | Unknown | Production | No | No | Web | ~15-20% more | 34s | 1280×768 | 24 | Multiple | Excellent | Excellent | Good | Refined | ✗ | ✓ | ✓ | Good | ~100s |
| **Kling 2.0 Master** | Kuaishou | 2025-04 | NCR Architecture | Unknown | Production | No | No | Web, API | Tiered | 10s | 1080p | 30 | Multiple | Excellent | Excellent | Excellent | Professional | ✗ | ✓ | ✓ | Excellent | ~90s |
| **Veo 3** | Google | 2025-05 | Advanced + Audio | Unknown | Production | No | No | Vertex, Gemini | Enterprise | 8s | 1080p | Unknown | 9:16, 16:9, 1:1 | Excellent | Excellent | Good | Prompt-based | **✓** | ✓ | ✗ | Good | Unknown |
| **Hailuo 02** | MiniMax | 2025-06 | NCR (2.5x efficient) | 3x larger | Production | No | No | Web, API | Maintained | 10s | 1080p | Unknown | Multiple | Excellent | Excellent | Excellent | Enhanced | ✗ | ✓ | ✗ | Excellent | ~60s |
| **Luma Ray3** | Luma AI | 2025-09 | Reasoning Video | Unknown | Production | No | No | Web, Firefly | Tiered | 10s | 4K HDR | Unknown | Multiple | Excellent | Excellent | Excellent | Visual annotations | ✗ | ✓ | ✓ | SOTA | ~90s |
| **Kling 2.5 Turbo** | Kuaishou | 2025-09 | Optimized NCR | Unknown | Production | No | No | Web, API | 30% cheaper | 5s | 1080p | 30 | Multiple | Excellent | Excellent | Excellent | Professional | ✗ | ✓ | ✓ | Excellent | ~45s |
| **Sora 2** | OpenAI | 2025-09 | Enhanced DiT | Unknown | Production | No | No | iOS App, Web | Free tier + | ~10s | 1080p+ | Unknown | Multiple | Excellent | Excellent | Good | Enhanced | **✓** | ✓ | ✓ | Excellent | Unknown |
| **Veo 3.1** | Google | 2025-10 | Enhanced + Audio | Unknown | Production | No | No | Flow, Gemini, Vertex | Enterprise | 60s+ | 1080p+ | Unknown | Multiple | Excellent | Excellent | Good | Enhanced | **✓** | ✓ | ✗ | Good | Unknown |
| **Hailuo 2.3** | MiniMax | 2025-11 | Enhanced NCR | Unknown | Production | No | No | Web, Mobile, API | Value-focused | 10s | 1080p | Unknown | Multiple | Excellent | Excellent | Excellent | Motion commands | ✗ | ✓ | ✗ | Excellent | ~60s |

### Open-source video models (2023-2025)

| Model | Organization | Release | Architecture | Params | Status | Open Source | Open Weights | Access | License | Max Duration | Max Resolution | FPS | Motion Coherence | Temporal Consistency | Img2Vid | Vid2Vid | VRAM | Notable Features |
|-------|-------------|---------|--------------|--------|--------|-------------|--------------|--------|---------|--------------|----------------|-----|------------------|---------------------|---------|---------|------|------------------|
| **ModelScope T2V** | Alibaba DAMO | 2023-03 | 3D U-Net (VideoFusion) | 1.7B | Legacy | Yes | Yes | HuggingFace | CC-BY-NC | 4s | 256×256 | Unknown | Basic | Basic | ✗ | ✗ | 16GB | First widely available open T2V |
| **Zeroscope v2** | Community | 2023-06 | 3D U-Net | 1.7B | Legacy | Yes | Yes | HuggingFace | CC-BY-NC | 3s | 1024×576 | Unknown | Good | Good | ✗ | ✓ | 15GB | Watermark-free ModelScope |
| **AnimateDiff v1** | Shanghai AI Lab | 2023-07 | Motion Modules + SD | ~400M | Production | Yes | Yes | HuggingFace | Research | 16 frames | SD resolution | 8 | Good | Good | ✗ | ✗ | 13GB | Works with any SD model |
| **AnimateDiff v2** | Shanghai AI Lab | 2023-08 | Enhanced Motion | ~400M | Production | Yes | Yes | HuggingFace | Research | 16 frames | SD resolution | 8 | Good | Good | ✗ | ✗ | 13GB | Improved motion quality |
| **AnimateDiff SDXL Beta** | Shanghai AI Lab | 2023-11 | Motion Modules + SDXL | ~400M | Beta | Yes | Yes | HuggingFace | Research | 16 frames | 1024×1024 | 8 | Good | Good | ✗ | ✗ | 16GB | SDXL compatibility |
| **SVD (Stable Video Diffusion)** | Stability AI | 2023-11 | 3D U-Net (Temporal) | 1.5B | Production | Yes | Yes | HuggingFace | Community | 2s (14 frames) | 1024×576 | 3-30 | Good | Good | ✓ | ✗ | 23GB | First major open SVD model |
| **SVD-XT** | Stability AI | 2023-11 | 3D U-Net (Extended) | 1.5B | Production | Yes | Yes | HuggingFace | Community | 4s (25 frames) | 1024×576 | 3-30 | Good | Good | ✓ | ✗ | 23GB | Extended duration |
| **AnimateDiff-Lightning** | ByteDance | 2024-03 | Distilled Motion | ~400M | Production | Yes | Yes | HuggingFace | Research | 16 frames | SD resolution | 8 | Good | Good | ✗ | ✗ | 13GB | 1-8 step inference, 10x faster |
| **SVD-XT 1.1** | Stability AI | 2024-03 | Fixed conditioning | 1.5B | Production | Yes | Yes | HuggingFace | Community | 4s | 1024×576 | 6 fixed | Good | Good | ✓ | ✗ | 23GB | Improved consistency |
| **Open-Sora 1.0** | HPC-AI Tech | 2024-03 | STDiT | Variable | Research | Yes | Yes | GitHub | Apache 2.0 | 2s | 512×512 | Unknown | Basic | Basic | ✗ | ✗ | High | First Open-Sora release |
| **Open-Sora 1.1** | HPC-AI Tech | 2024-04 | STDiT | Variable | Research | Yes | Yes | GitHub | Apache 2.0 | 15s | 720p | Unknown | Good | Good | ✓ | ✓ | High | Any aspect ratio |
| **Open-Sora 1.2** | HPC-AI Tech | 2024-06 | 3D-VAE + Rectified Flow | Variable | Research | Yes | Yes | GitHub | Apache 2.0 | 16s | 720p | Unknown | Good | Good | ✓ | ✓ | High | Score conditioning |
| **CogVideoX-2B** | THUDM | 2024-08 | Expert Transformer DiT | 2B | Production | Yes | Yes | HuggingFace | Apache 2.0 | 6s | 720×480 | 8 | Good | Good | ✗ | ✗ | 6GB opt | T4 GPU compatible |
| **CogVideoX-5B** | THUDM | 2024-08 | Expert Transformer DiT | 5B | Production | Yes | Yes | HuggingFace | CogVideoX | 6s | 720×480 | 8 | Good | Good | ✓ | ✗ | 12GB opt | Higher quality |
| **Mochi 1** | Genmo | 2024-10 | AsymmDiT | 10B | Production | Yes | Yes | HuggingFace | Apache 2.0 | 5.4s | 480p | 30 | Excellent | Excellent | ✗ | ✗ | 60GB | Largest open video model (at release) |
| **LTX-Video 2B** | Lightricks | 2024-11 | DiT | 2B | Production | Yes | Yes | HuggingFace | Open | 5s | 768×512 | 24 | Good | Good | ✓ | ✓ | RTX 4090 | Real-time generation |
| **CogVideoX1.5-5B** | THUDM | 2024-10 | Enhanced Expert DiT | 5B | Production | Yes | Yes | HuggingFace | CogVideoX | 10s | Higher | Unknown | Good | Good | ✓ | ✗ | 12GB+ | Longer duration |
| **HunyuanVideo** | Tencent | 2024-12 | Dual-stream Transformer | 13B | Production | Yes | Yes | HuggingFace | Hunyuan | 16s | 720p | Unknown | Excellent | Excellent | ✓ | ✓ | 48GB+ | Outperforms Gen-3 in evals |
| **Open-Sora 2.0** | HPC-AI Tech | 2025-03 | Enhanced STDiT | 11B | Production | Yes | Yes | GitHub | Apache 2.0 | 15s+ | 720p | Unknown | Excellent | Excellent | ✓ | ✓ | High | $200K training cost |
| **LTXV-13B** | Lightricks | 2025-05 | Multiscale DiT | 13B | Production | Yes | Yes | GitHub | Open (<$10M) | 5s+ | 4K | 50 | Excellent | Excellent | ✓ | ✓ | H100/4090 | 4K + 50fps + audio in one model |
| **LTX-2 (Autoregressive)** | Lightricks | 2025-07 | Autoregressive | 13B+ | Production | Yes | Yes | GitHub | Open | 10s | 4K | 50 | Excellent | Excellent | ✓ | ✓ | Varies | Livestreaming generation |

### Video model capability comparison

| Model | Character Consistency | Text in Video | Multi-shot | Timestamp Control | Camera Vocabulary | Transitions | Object Permanence |
|-------|----------------------|---------------|------------|-------------------|-------------------|-------------|-------------------|
| Runway Gen-3 Alpha | Partial | Poor | ✗ | ✗ | Pan, dolly, zoom, crane, FPV | Cut only | Good |
| Sora Turbo | Good | Poor | ✓ | ✗ | Via prompt | Blend, extend | Good |
| Kling 2.0 Master | Excellent | Good | ✓ | ✗ | Professional cinema | Multiple | Excellent |
| Veo 3 | Good | Good | ✓ | ✗ | Cinema terminology | Via prompt | Good |
| Pika 2.0 | Excellent (Ingredients) | Poor | ✗ | ✗ | Dolly, zoom, pan | Pikaframes | Good |
| Luma Ray3 | Excellent | Good | ✓ | ✗ | Visual annotations | Via extend | Excellent |
| Hailuo 02 | Excellent | Good | ✗ | ✗ | Motion commands | Limited | Excellent |
| HunyuanVideo | Good | Poor | ✗ | ✗ | Basic | Limited | Good |
| Mochi 1 | Good | Poor | ✗ | ✗ | Basic | ✗ | Good |
| SVD-XT | N/A (Img2Vid) | None | ✗ | ✗ | Motion Bucket | ✗ | Good |
| AnimateDiff | Depends on base | None | ✗ | ✗ | MotionLoRA | ✗ | Basic |

---

## Architectural evolution timeline

### 2021-2022: U-Net foundations
The field began with **GLIDE's classifier-free guidance** (December 2021), establishing the core paradigm. **DALL-E 2's unCLIP architecture** (April 2022) introduced CLIP-guided diffusion at scale. **Stable Diffusion 1.x** (August-October 2022) democratized access with the **latent diffusion model (LDM)** paradigm—compressing images to latent space before diffusion reduced compute requirements by ~100x.

### 2023: Scale and specialization
**SDXL** (July 2023) tripled U-Net size to 3.5B parameters with dual CLIP encoders. **DeepFloyd IF** pioneered **cascaded pixel-space diffusion** with T5 text encoding, achieving the first reliable text rendering. **AnimateDiff** proved motion modules could extend image models to video. **Stable Video Diffusion** brought diffusion video generation to open source.

### 2024: The transformer transition
**SD3/SD3.5** introduced **MMDiT (Multimodal Diffusion Transformer)**, replacing U-Nets with transformers and achieving dramatic quality improvements. **FLUX.1** from Black Forest Labs (ex-Stability founders) debuted **rectified flow** training, producing the highest-quality open-weights model at 12B parameters. **Kling 1.0** became the first accessible **DiT-based video model**, generating 2-minute videos. **CogVideoX** and **Mochi 1** (10B) pushed open video generation forward.

### 2025: Native multimodality and audio
**GPT Image 1** (March 2025) represented a paradigm shift: **native multimodal generation** within GPT-4's transformer architecture rather than invoking separate models. **Google's Nano Banana** (Gemini 2.5 Flash Image, August 2025) introduced a **multimodal diffusion transformer with separate weight sets** for image and language, achieving 40% better text understanding and 2.3-second generation speeds—its codename originated from internal LMArena testing. **Veo 3** and **Sora 2** (May-September 2025) achieved **synchronized native audio generation**—dialogue, sound effects, and ambient noise generated alongside video. **Luma Ray3** introduced **4K HDR (16-bit)** and claimed "reasoning" video capabilities. **Hunyuan Image 3.0** scaled to **80B parameters** using autoregressive rather than diffusion approaches. **Nano Banana Pro** (Gemini 3 Pro Image, November 2025) added **4K resolution support** with further text rendering improvements.

---

## Critical findings for model selection

### Text rendering hierarchy (2025)
For applications requiring reliable text in images: **Ideogram 3.0** and **Recraft V3** lead with 85-90% accuracy on complex typography. **GPT Image 1** excels at multi-line text (800+ characters). **Nano Banana/Pro** provides excellent text understanding with fast generation. **FLUX.1 variants** and **SD3.5** provide strong open-source alternatives. Midjourney V7 achieved production-quality text, a significant improvement from V6.

### Photorealism benchmarks
**FLUX.1 [pro]** and **Midjourney V7** top commercial benchmarks. **SD3.5 Large** and **FLUX.1 [dev]** lead open-weights options. **Recraft V3** has held #1 on HuggingFace's text-to-image leaderboard for 5+ consecutive months as of late 2024.

### Video duration and quality trade-offs
Longer videos (30s-60s) require **Luma Ray2/Ray3** (extend feature), **Sora** variants, or **Kling** series. For highest motion quality, **Kling 2.0 Master** and **Hailuo 02** excel at physics simulation. For open-source local deployment, **HunyuanVideo** (13B, 48GB VRAM) or **CogVideoX-5B** (12GB optimized) provide best quality-to-resource ratios.

### Native audio generation (major 2025 breakthrough)
As of late 2025, only **Veo 3/3.1**, **Sora 2**, and **LTX-2** generate synchronized audio natively. This represents the field's most significant capability expansion—prior to 2025, all video models required separate audio generation and manual synchronization.

### Local deployment requirements
| Capability | Minimum VRAM | Recommended Models |
|------------|--------------|-------------------|
| SD 1.5 quality | 4GB | SD 1.5, SD 2.1 |
| SDXL quality | 8GB | SDXL, Playground v2.5 |
| SD3/FLUX quality | 12-24GB | SD3.5 Medium, FLUX.1 [schnell] |
| Best open quality | 24GB+ | FLUX.1 [dev], SD3.5 Large |
| Video (basic) | 6-12GB | CogVideoX-2B, AnimateDiff |
| Video (high quality) | 24-48GB | SVD-XT, LTX-Video |
| Video (best open) | 48-60GB+ | HunyuanVideo, Mochi 1 |

### Licensing considerations
**Fully open (Apache 2.0/MIT)**: FLUX.1 [schnell], Kandinsky 3.0, Mochi 1, Open-Sora series, HiDream-I1
**Non-commercial research**: FLUX.1 [dev], DeepFloyd IF, CogVideoX-5B
**Commercial with restrictions**: SD3/3.5 (free under $1M revenue), Stability Community License models
**Proprietary/API only**: Midjourney, DALL-E, Imagen, Nano Banana, Runway, Sora, Kling, Veo, Pika
