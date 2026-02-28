# ADR 0002: Slido Question Format Specification

**Status**: Accepted
**Date**: 2026-01-22
**Iteration**: 1
**Context**: Creating interactive polling questions for lecture engagement

---

## Decision

All Slido questions must be provided in a **copy-paste ready format** with specific structure for multiple-choice questions, enabling rapid setup before class.

---

## Format Requirements

### For Open Text Questions

```
[Question text exactly as it will appear]
```

**Example**:
```
What algorithm runs your morning routine? Describe it in 3 steps or less.
```

**Usage**: Copy the text, paste directly into Slido "Open Text" question field.

---

### For Multiple Choice Questions

**Critical Requirements**:
1. Question title on first line
2. Options listed one per line
3. **NO prefixes** (no "A)", no "1.", no bullets, no dashes)
4. Correct answer marked with ` ✓` at the end
5. Explanation section follows, separated by blank line

**Format**:
```
[Question Title]

[Option 1]
[Option 2]
[Option 3] ✓
[Option 4]
[Option 5]

**Correct Answer**: [Option 3]
**Why**: [Explanation of why this is correct]

**Why others are wrong**:
- [Option 1]: [Explanation]
- [Option 2]: [Explanation]
- [Option 4]: [Explanation]
- [Option 5]: [Explanation]
```

### COD: Example Multiple Choice

```
What is the time complexity of finding the minimum element in an unsorted array?

O(1)
O(log n)
O(n) ✓
O(n log n)
O(n²)

**Correct Answer**: O(n)
**Why**: You must examine every element to be certain you've found the minimum. There's no way to skip elements without risking missing the actual minimum.

**Why others are wrong**:
- O(1): This would require knowing the minimum's location in advance, which isn't possible for unsorted data.
- O(log n): This is only achievable with sorted or specially structured data (like heaps), not general unsorted arrays.
- O(n log n): This is the complexity of sorting, which is overkill for finding just the minimum.
- O(n²): This would involve unnecessary nested iterations; a single pass suffices.
```

---

## Workflow for Creating Questions

### Step 1: Human Requests Question

**Format**: "Create a Slido question about [topic] for [purpose]"

**Example**: "Create a Slido question about greedy algorithms to check if students understand when greedy approaches fail"

### Step 2: Claude Generates in Specified Format

**Deliverable**: Markdown file with:
- Question text
- Options (if multiple choice) with checkmark on correct answer
- Explanation section
- **All formatted for copy-paste**

### Step 3: Human Copies to Slido

**Process**:
1. Select question title → paste into Slido question field
2. Select options (one line at a time) → paste into Slido option fields
3. When pasting option with `✓`, remove checkmark and mark as correct in Slido
4. Keep explanation section for reference during class discussion

---

## Rationale for This Format

### QST: Why no prefixes on options?

**ANS**: Slido adds its own numbering/lettering. Prefixes would create:
```
A. A) Option 1
B. B) Option 2
```
This is redundant and confusing.

### QST: Why checkmark at end instead of beginning?

**ANS**:
- Easy to spot visually when reviewing
- Easy to delete when pasting into Slido (select, paste, backspace)
- Doesn't interfere with option text if copied accidentally

### QST: Why separate explanation section?

**ANS**:
- During class discussion, instructor needs to explain *why* wrong answers are wrong
- Helps anticipate student misconceptions
- Provides talking points for learning moments
- Not visible to students in Slido (teacher reference only)

---

## Question Types for Different Purposes

### Type 1: Icebreaker / Warm-up

**Purpose**: Build community, lower stakes, get students comfortable

**Format**: Open text

**Example**:
```
What algorithm runs your morning routine? Describe it in 3 steps or less.
```

**Characteristics**:
- Playful, relatable
- No wrong answers
- Connects to daily life
- 2-3 minutes response time

---

### Type 2: Reflection / Metacognition

**Purpose**: Model intellectual humility, belief revision

**Format**: Open text

**Example**:
```
What's one belief you held that turned out to be wrong? What changed your mind?
```

**Characteristics**:
- Philosophical
- Models learning process
- Normalizes being wrong
- 3-4 minutes response time

---

### Type 3: Goals / Aspirations

**Purpose**: Understand student interests for syllabus co-creation

**Format**: Open text

**Example**:
```
If you could guarantee one skill/understanding from this algorithms course, what would it be?
```

**Characteristics**:
- Forward-looking
- Informs course design
- Surfaces student priorities
- 2-3 minutes response time

---

### Type 4: Concept Check / Formative Assessment

**Purpose**: Check understanding during lecture

**Format**: Multiple choice (4-5 options)

**Example**:
```
Which of these problems can be solved optimally with a greedy algorithm?

Coin change with arbitrary denominations
Knapsack problem (0/1 variant)
Activity selection with no overlaps ✓
Traveling salesman problem
Subset sum problem

**Correct Answer**: Activity selection with no overlaps
**Why**: Greedy "earliest finish time" strategy provably gives optimal solution. The greedy choice property holds: selecting the activity that finishes earliest leaves maximum room for remaining activities.

**Why others are wrong**:
- Coin change: Only works for special coin systems (e.g., US coins). For arbitrary denominations, greedy fails (example: coins {1, 3, 4} and amount 6—greedy gives 4+1+1, but optimal is 3+3).
- Knapsack (0/1): Greedy by value/weight ratio fails. Classic counterexample: items with (value, weight) = (60, 10) and (100, 20), knapsack capacity 30. Greedy picks first item but can't fit second; optimal is taking only the second item.
- Traveling salesman: Greedy "nearest neighbor" gives approximation but not optimal solution. This is NP-hard; no greedy algorithm solves it optimally.
- Subset sum: NP-complete problem. Greedy approaches fail—requires dynamic programming or backtracking for exact solutions.
```

**Characteristics**:
- Tests specific concept
- Common misconceptions as wrong answers
- Rich explanations for discussion
- 30-60 seconds response time

---

### Type 5: Algorithm Comparison / Tradeoffs

**Purpose**: Deepen understanding of when to use which approach

**Format**: Multiple choice (3-4 options)

**Example**:
```
You need to find the k-th smallest element in an unsorted array. Which approach has the best average-case time complexity?

Heapsort then index ✓
Quickselect
Full sorting then index
Binary search

**Correct Answer**: Quickselect
**Why**: Quickselect has O(n) average-case time by partitioning like quicksort but only recursing on one side. This is asymptotically faster than any comparison-based sorting.

**Why others are wrong**:
- Heapsort then index: O(n log n) for heapsorting, which is slower than O(n) average case.
- Full sorting then index: O(n log n) for any comparison-based sort, slower than quickselect's O(n) average.
- Binary search: Requires sorted array, doesn't help with unsorted input. Would need O(n log n) sort first, making total time O(n log n).

**Note**: Quickselect has O(n²) worst case but O(n) average. For guaranteed O(n) worst-case, use Median-of-Medians algorithm (though with larger constant factors).
```

---

## Slido Setup Checklist

### Before Class

- [ ] Go to slido.com
- [ ] Create new event: "CIS 5020 - Lecture [N]"
- [ ] Add questions from prepared markdown file
- [ ] Get event code (e.g., #1776)
- [ ] **Update slides with actual event code**
- [ ] Test on phone to verify
- [ ] Have Slido presenter view open on laptop

### During Class

- [ ] Display Slido code on slide
- [ ] Give students time to submit (see question type for timing)
- [ ] Read 4-5 responses aloud
- [ ] For multiple choice: show correct answer, explain why
- [ ] Use incorrect answers as teaching moments (not to shame students)

---

## Anti-Patterns to Avoid

### ✗ Don't: Write options with prefixes

```
A) First option
B) Second option
C) Third option
```

**Why**: Slido will add its own, creating "A. A) First option"

### ✗ Don't: Put checkmark at beginning

```
✓ Correct option
Wrong option
```

**Why**: Harder to remove when pasting, might get copied into Slido text

### ✗ Don't: Include explanation in question itself

**Why**: Explanation is for *after* students answer, not during question presentation

### ✗ Don't: Make all wrong answers obviously wrong

**Why**: Makes question trivial, doesn't teach anything. Good wrong answers should be:
- Common misconceptions
- Partially correct thinking
- Solutions that work in special cases but not generally

---

## Files Created with This Format

- `/lectures/lecture01/SLIDO-QUESTIONS.md` - Lecture 01 questions (icebreakers)

**Future lectures**: Each should have `SLIDO-QUESTIONS.md` with questions ready to copy-paste

---

## Related ADRs

- ADR 0001: Reveal.js Slide Collaboration Workflow (how Slido integrates with slides)
- Future ADR: Formative Assessment Strategy (when to use Slido vs other methods)

---

**Outcome**: Format enables rapid question setup before class while ensuring questions are pedagogically sound with rich explanations for discussion.
