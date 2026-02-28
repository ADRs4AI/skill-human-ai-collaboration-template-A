# ADR-0008: Visual Concept Generation for Algorithm Topics - Critical Learnings

**Status:** Active Learning Document
**Date:** 2026-02-05
**Iteration:** 1 (Post V1 Feedback)
**Context:** Creating visual concepts for CIS 5020 super-syllabus topic discovery

---

## Decision Context

We're creating visual "clip art" illustrations for 21 algorithmic topics to help students discover what interests them in the super-syllabus. These aren't decorative—they're **epistemic tools creating aporia** for problem-posing pedagogy.

### Purpose
- Display one image per topic during class
- Solicit student feedback, questions, observations
- Gauge interest through visual stimulation
- **NOT banking model** - problem-posing philosophy

### Constraints
- Limited time: 3 hours from concept to classroom (2pm → 5:15pm class)
- Must be epistemically perfect (truthful, accurate, meaningful)
- Need to create productive confusion (aporia)
- Students should be able to observe algorithmic principles visually

---

## V1 Attempt - What Failed

### Critical Mistakes

#### 1. **WRONG VISUAL STYLE** ❌
- Used: Photorealistic, cinematic, dramatic lighting, technical precision
- Needed: **Children's book illustration style**
- Needed: **"Where's Waldo" rich intricate drawings**
- Needed: Cartoon aesthetic with rich detail

**User's exact words:** "you're not doing cartoons. Like I'd like you to use like a child book style"

#### 2. **TOO ABSTRACT** ❌
- V1 tried to visualize abstract concepts (optimal substructure, Master Theorem landscapes)
- Result: "nonsensical", "just aesthetics", "no intuition"
- Example failures:
  - 1.5 Master Theorem landscape: "formulas that have no intuition, like CLRS"
  - 2.5 Optimal substructure fractal: "nonsensical, just aesthetics"

**Better approach:** Pick 3-4 **specific algorithms** and visualize them concretely

#### 3. **UNCLEAR EPISTEMIC CONTENT** ❌
- Many images only made sense if you already knew the algorithm
- Examples:
  - 2.1 DP table emergence: "I sort of understand but only because I already know"
  - 1.3 Parallel computation: "not clear what I would explain there"
  - 3.5 DFS low-link: "looks nice but not clear what's going on"

**Key insight:** The image must teach/provoke, not just illustrate known knowledge

#### 4. **TRIED TO DO TOO MUCH WITH COMPOSITION** ❌
- Complex scenes requiring specific spatial ordering
- Image models struggle with precise layouts
- Example: 2.3 Burglar's knapsack with holographic table - "completely nonsensical"

**User's guidance:** "it's hard to lay out things... you want concepts where specific ordering either doesn't matter or if it does you have to be very directive"

### What Actually Worked ✅

Only 4/18 concepts worked well:

1. **1.6 FFT Before/After**: Concrete application, clear comparison, real-world impact
2. **3.1 Articulation Point Catastrophe**: Clear cause-effect, real infrastructure
3. **3.3 Biconnected Communities**: Social network metaphor (needs refinement: "show connectors bridging communities")
4. **3.6 Northeast Blackout Topology**: Real event, clear graph connection

**Pattern of success:**
- Concrete applications (not abstract theory)
- Clear visual cause-and-effect
- Real-world connections
- Social/physical metaphors that work

---

## V2 Strategy - Corrected Approach

### Visual Style Requirements

**MUST USE:**
- Children's book illustration style
- Hand-drawn aesthetic (think Eric Carle, Dr. Seuss, Where's Waldo)
- Rich, intricate, detailed scenes
- Colorful, inviting, exploratory
- Dense with visual information that rewards inspection

**Prompt vocabulary:**
- "children's book illustration style"
- "hand-drawn colorful illustration"
- "Where's Waldo style intricate detailed scene"
- "picture book aesthetic"
- "rich detail, exploratory illustration"
- "storybook illustration with labeled elements"

### Content Strategy

**INSTEAD OF:** 6 abstract concept categories
- Core principle
- Key technique
- Concrete example
- Comparison
- Complexity visualization
- Real-world application

**DO THIS:** Pick 3-4 **specific algorithms** and visualize them
- Show the algorithm actually working
- Make the steps visible and inspectable
- Label key elements
- Create visual puzzles students can decode

### Examples of Better Approach

**Divide and Conquer** - visualize specific algorithms:
1. Mergesort in action (splitting and merging arrays)
2. Binary search halving a sorted array
3. Quicksort partitioning around pivot
4. Closest pair of points geometric divide

**Dynamic Programming** - visualize specific algorithms:
1. Edit distance table being filled for two strings
2. Knapsack table showing item selection decisions
3. Longest common subsequence with matches highlighted
4. Fibonacci with overlapping subproblems visible

**Graph Connectivity** - visualize specific algorithms:
1. DFS finding articulation points (tree + back edges)
2. Biconnected components with connector people bridging communities
3. Karger's random edge contraction sequence
4. Bridge detection showing which edges disconnect

### Ordering and Layout Constraints

**The challenge:** Image models struggle with precise spatial arrangement

**Strategies:**
1. **Avoid requiring specific ordering** - make scenes work regardless of element placement
2. **Be very directive** - use explicit positioning language when ordering matters
3. **Use natural spatial metaphors** - left-to-right for sequences, top-to-bottom for hierarchies
4. **Embrace organic layouts** - Where's Waldo doesn't require grid precision

### Epistemic Accuracy Requirements

**Critical user statement:** "If it's not epistemically accurate, it's garbage. Like literally, it's garbage. And I don't want anything to do with it."

**What this means:**
- Every algorithmic detail must be correct
- No syntactic truth without actual truth
- Students learn from these - misinformation is worse than nothing
- The image must show HOW the algorithm works, not just be pretty

**Verification questions:**
- Can a student decode the algorithmic principle from visual inspection?
- Does the image create productive confusion (aporia)?
- Is every detail defensible algorithmically?
- Would you show this to students knowing they'll try to learn from it?

---

## Technical Details

### Batch Renderer Command

```bash
PIPENV_PIPFILE=/Users/jlumbroso/Programming/batch-renderer/Pipfile \
  pipenv run batch-renderer \
  /Users/jlumbroso/Programming/penn/cis-5020/cis-5020-lectures/syllabus/visual-concepts/prompts/[PROMPT_FILE].md \
  --output /Users/jlumbroso/Programming/penn/cis-5020/cis-5020-lectures/syllabus/visual-concepts/outputs/[OUTPUT_DIR] \
  --skip-existing \
  --model nano-banana-pro
```

### Model Choice
- **Nano Banana Pro**: Best for text rendering, multi-image handling
- Children's book style works well with natural language models
- Pro version has better layout control

### File Organization
```
syllabus/visual-concepts/
├── prompts/          # Markdown files with prompts
└── outputs/          # Rendered images organized by batch
```

---

## Specific V1 Feedback by Concept

### Divide and Conquer
- ❌ 1.1 Recursive tree: "generic"
- ❌ 1.2 Tournament bracket: "generic"
- ❌ 1.3 Parallel computation: "not clear what I would explain"
- ❌ 1.4 Mergesort vs Quicksort: "don't know how to read it"
- ❌ 1.5 Master Theorem: "formulas, no intuition, like CLRS"
- ✅ 1.6 FFT before/after: "pretty good" (only good one!)

### Dynamic Programming
- ❌ 2.1 DP table: "only helpful because I already know"
- ❌ 2.2 DNA helix: "elusive, has nothing"
- ❌ 2.3 Burglar's knapsack: "completely nonsensical"
- ❌ 2.4 Greedy vs DP: "nonsensical despite understanding intent"
- ❌ 2.5 Fractal: "nonsensical, just aesthetics"
- ~ 2.6 Genome project: "more helpful but don't know what image is doing"

### Graph Connectivity
- ✅ 3.1 Articulation catastrophe: "pretty good"
- ❌ 3.2 Bridge: "useless"
- ✅ 3.3 Communities: "very good" but "show connectors bridging communities"
- ❌ 3.4 Karger: "don't understand what the fuck it's doing"
- ❌ 3.5 DFS low-link: "not clear what's going on"
- ✅ 3.6 Blackout: "very good"

**Success rate:** 4/18 (22%) - needs massive improvement

---

## Action Items for V2

### QST: Questions to resolve
- How much labeling/text to include in illustrations?
- Should we add small explanatory captions?
- How to balance "Where's Waldo" density with clarity?

### ANS: Answers (to be filled)
- [Pending V2 user feedback]

### COD: Code/Implementation
- V2 prompt file with corrected style and approach
- Batch render V2
- Compare results

### NOT: Key insights
- **Children's book style is non-negotiable**
- **Specific algorithms > abstract concepts**
- **Epistemic accuracy > aesthetic beauty**
- **Visual aporia is the goal**

---

## Success Criteria for V2

An effective visual concept:
1. Uses children's book illustration style
2. Shows a specific algorithm (not abstract principle)
3. Creates epistemic stimulation/aporia
4. Can be understood through visual inspection
5. Rewards detailed examination
6. Is algorithmically accurate in every detail
7. Provokes questions and observations

**Test:** Show image to user. If response is "I don't understand what's going on" or "nonsensical" → failed. If response is "this creates good questions" → success.

---

## For Next Iteration

When scaling to all 21 topics:
- Start with 3-4 algorithm visualizations per topic (not 6 concepts)
- Maintain children's book aesthetic throughout
- Focus on epistemic clarity
- Test sample batch before full generation
- Remember: better to have 3 excellent visuals than 6 mediocre ones

**Philosophy:** These aren't illustrations OF algorithms. They're **epistemic tools FOR discovering** algorithmic thinking.

---

## V2 Results - Detailed Feedback (2026-02-05 3:25pm)

**Overall Assessment:** "If V1 was 23% there, V2 is 95% there. It's amazing. Much better than algorithmic factory concept."

### What Worked Excellently ✅

**Divide & Conquer:**
- 1.1 Mergesort: "Great, I understand what's going on, so well done"
- 1.2 Binary Search: "Great, colors are really good" (minor: books move vs person)
- 1.3 Quicksort: "Really amazing" (repeated 3x!) ⭐
- 1.4 Closest Pair: "I love, I absolutely love, I know the algorithm so well" ⭐

**Dynamic Programming:**
- 2.2 Knapsack: "Genius, absolutely genius" ⭐
- 2.3 Fibonacci: "Really nice"

**Graph Connectivity:**
- 3.2 Biconnected Components: "Amazing" (repeated 2x!) ⭐

### What Needs Improvement ❌

**2.1 Edit Distance:**
- Issue: "Looks like matching letters that don't match (T and Go)"
- Problem: Visual shows incorrect matches
- Fix: Ensure visual matches show ACTUAL character matches

**2.4 Longest Common Subsequence:**
- Assessment: "Beautiful but I don't quite get the algorithm"
- Problem: Aesthetic success but algorithmic clarity failure
- Fix: Make the sequence alignment more explicit

**3.1 DFS Articulation Points:**
- Assessment: "Great but not very clear what articulation points are"
- Issue: "Houses metaphor doesn't work - you don't enter and exit"
- Problem: Articulation points not visually distinct enough
- Fix: Make articulation points more obviously critical/different

**3.3 Bridge Finding:**
- Issue: "A little bit generic, just about graphs"
- Problem: Could be any graph algorithm
- Fix: Make the bridge-specific properties clearer

**3.4 Karger's Random Edge Contraction:**
- Critical failure: "I know what you mean but I don't see it. Very confusing. If I showed this, nobody would get it"
- Problem: The random contraction process is not visible/understandable
- Fix: Show the sequence more clearly, make randomness and contraction obvious

### Key Success Patterns

**What makes a concept work:**
1. **Specific algorithm steps are visible** (not just end result)
2. **Process/transformation is shown** (splitting→merging, comparing→moving)
3. **Visual metaphor matches algorithmic reality** (pivot children work, house traversal doesn't)
4. **Colors and labels guide understanding** (not just decoration)
5. **Rich detail rewards inspection** (Where's Waldo density)

**The 95% concepts share:**
- Clear cause-and-effect visible
- Algorithmic steps inspectable
- Children's book warmth invites exploration
- Epistemic accuracy in every detail

### Learnings for Remaining 18 Topics

**Do more of:**
- Children actively doing algorithm (sorting helpers, surveyors, elves)
- Sequential steps visible (Quicksort pivot process, Binary Search halving)
- Physical metaphors that match algorithm mechanics
- Warm, inviting, exploratory aesthetic

**Avoid:**
- Metaphors that break under inspection (houses as graph nodes)
- Processes that aren't visually clear (Karger's contraction)
- Generic graph visualizations without algorithm-specific properties
- Aesthetics without epistemic clarity

**User's goal reaffirmed:**
- Give students "flavor" of each topic
- Create visual aporia (productive confusion)
- Prepare quickly for slides
- Each image should stimulate questions and observations

### Action Items from Feedback

**Immediate (for remaining 18 topics):**
- Continue children's book style (validated!)
- 4 specific algorithms per topic
- Ensure each shows HOW the algorithm works
- Make key algorithmic properties visually inspectable

**For final delivery:**
- Create epistemic evaluation report
  - Which images are most epistemically accurate
  - Which best stimulate aporia
- Prepare slide integration guide
- Prioritize images that work (use the 95% as models)

**Success metric:** Can students look at the image and decode the algorithmic principle through visual inspection?
