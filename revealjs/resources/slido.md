# Subskill: Slido Integration

Load this when generating presentations that include Slido audience interaction (polls, Q&A, surveys).

---

## What Slido Is

Slido (slido.com) is an audience interaction platform for live questions, polls, and surveys.
In reveal.js presentations it is used alongside slides — not embedded in them (mostly).
It has its own event code that audiences join separately.

---

## The Introduction Slide

Every presentation using Slido needs an introduction slide. Use this template:

```html
<section data-menu-title="About Slido">
  <h2>Let's use Slido</h2>

  <div class="slido-intro-box">
    <p><strong>Optional — join at your pace:</strong></p>
    <ol>
      <li>Open a new tab (or your phone): <strong>slido.com</strong></li>
      <li>Enter event code: <strong class="slido-code">#XXXX</strong>
          — or scan the QR code →</li>
      <li>Click the <strong>💬 Questions</strong> tab to ask or upvote</li>
    </ol>
    <p style="margin-top: 0.8em;">
      <em>You can raise your hand or ask out loud too — always welcome.</em>
    </p>
  </div>

  <aside class="notes">
    Slido introduction — give 2–3 minutes.
    Say: "This is completely optional. If you're not interested, this is a good moment
    to check email or step out. In 2–3 minutes we'll move forward."

    Point out the QR code. Mention they can also use the link in the chat if online.

    NAVIGATE: → to continue
  </aside>
</section>
```

```css
.slido-intro-box {
  background: #f8f9fa;
  border: 2px solid #00b3a0;   /* Slido teal */
  border-radius: 8px;
  padding: 16px 24px;
  margin: 12px auto;
  max-width: 700px;
  font-size: 0.95em;
  line-height: 1.5;
}
.slido-code {
  color: #00b3a0;
  font-size: 1.3em;
  font-family: 'Courier New', monospace;
}
```

---

## QR Code (Optional Plugin)

If using the Quarto pointer extension or a standalone QR plugin, you can generate a QR code
for the Slido URL. Otherwise, use a pre-generated QR code image:

```html
<!-- Pre-generated QR code image -->
<img src="assets/slido-qr.png" alt="QR code for slido.com event XXXX"
     style="height: 160px; float: right; margin: 0 0 8px 16px;">
```

Generate QR at: qr-code-generator.com or goqr.me with URL: `https://app.sli.do/event/XXXX`

---

## The Timer Approach

After the Slido intro slide, set a visible timer. Two approaches:

**Approach 1: Countdown plugin** (if RevealCountdown installed)
```html
<section data-countdown="180" data-menu-title="Slido Join Time">
  <!-- slides while people join -->
</section>
```

**Approach 2: Speaker notes with verbal timer**
```html
<aside class="notes">
  SAY: "I'll give you 3 minutes to join. If you're not interested, now's a great
  time to take a break."
  START TIMER: 3 minutes
  ADVANCE WHEN: most hands are on devices or timer done
</aside>
```

---

## Question Format for Slido Copy-Paste

### Critical formatting rule
Slido reads options as a list and auto-numbers them. **Do NOT add prefixes** — no `A)`, no `1.`, no bullets, no dashes.

**Wrong** (Slido will show "A) Dogs" as an option):
```
A) Dogs
B) Cats
C) Neither
```

**Right** (Slido shows "Dogs" as an option):
```
Dogs
Cats
Neither
```

### Correct answer marking
Put a checkmark `✓` at the END of the correct option (easy to remove when pasting):
```
Dogs
Cats ✓
Neither
```
Workflow: paste all options → options populate → remove the `✓` from display → click to mark that option as correct.

### Full template for generating Slido questions

```markdown
[Question text exactly as it will appear in Slido]

Option 1
Option 2
Option 3 ✓
Option 4

Correct: Option 3
Why: [Explanation for instructor reference only — not visible to students]

Why others are wrong:
- Option 1: [Explanation]
- Option 2: [Explanation]
- Option 4: [Explanation]
```

### Question types

| Type | When to use | Slido type |
|---|---|---|
| Icebreaker/warm-up | Session opening | Open text |
| Reflection/metacognition | Philosophical questions | Open text |
| Concept check | Formative assessment | Multiple choice |
| Algorithm comparison | Trade-off analysis | Multiple choice |
| Exit survey | End of session | Rating + open text |

---

## Speaker Notes Roadmap Pattern

When a slide is associated with a Slido question, document it in speaker notes:

```html
<aside class="notes">
  [Content notes...]

  ─────────────────
  SLIDO Q2: "What is the time complexity of binary search?"
  START: after explaining the search algorithm
  DURATION: 60 seconds
  ADVANCE: when results show (or after timeout)

  If time is short: SKIP — mark as optional.
  ─────────────────
</aside>
```

Or more briefly on content slides that precede a question:
```
SLIDO Q3 NEXT → 90 seconds → start after this slide
```

---

## The Three-Question End Survey

Include at the end of every session. This is Jérémie's canonical survey format:

```
Session Feedback Survey (3–4 min)

1. ⭐⭐⭐⭐⭐  How would you rate today's session?
   [Rating 1–5]

2. What is one interesting thing you learned today?
   [Open text]

3. What is one piece of feedback (positive or constructive) you would offer?
   [Open text]
```

Optional additions for adult learner contexts:
```
4. Would you like to be added to the instructor's newsletter/blog?
   Yes / No / Maybe

5. Would you like to be connected with other participants?
   Yes (include my email) / No
```

The survey slide:
```html
<section data-menu-title="Session Feedback">
  <h2>Before you go — 3 minutes</h2>
  <div class="slido-intro-box">
    <p>Your feedback helps make the next session better:</p>
    <ol>
      <li>⭐ Rate today's session</li>
      <li>What's one interesting thing you learned?</li>
      <li>One piece of feedback — positive or critical</li>
    </ol>
    <p><strong>slido.com → #XXXX</strong> — or use the link in chat</p>
  </div>
  <aside class="notes">
    Launch survey in Slido before showing this slide.
    Give 3–4 minutes. Read results aloud for stars; keep written feedback private.
    Thank participants.
  </aside>
</section>
```

---

## Slido in Adult Learner Contexts

Adult learners (non-university audiences) often need more guidance than typical students:
- More explicit navigation: "Click the 💬 tab, not the 📊 tab"
- More time to join: give 3–4 minutes instead of 2
- More explicit permission to not participate: "This is completely optional"
- Name the benefit: "Questions you don't get to ask live will be visible after the session"

The introduction slide template above includes these adaptations.

---

## Pre-Session Slido Checklist

- [ ] Slido event created for this session (new event = new code)
- [ ] All questions loaded in order
- [ ] Introduction slide has correct event code
- [ ] QR code matches event code (test by scanning)
- [ ] Survey configured for end of session
- [ ] Timer approach decided (plugin or verbal)

---

## Slido Question File Format

Keep Slido questions in a separate file per session for easy reference and copy-paste:

```
sessions/YYYY-MM-DD-[audience]/slido-questions.md

## Q1 — Icebreaker
[Question text]
[open text — no options]

## Q2 — Concept check
[Question text]
Option A
Option B ✓
Option C
Correct: B. Why: [explanation]

## Survey — End of session
[Use canonical 3-question format above]
```
