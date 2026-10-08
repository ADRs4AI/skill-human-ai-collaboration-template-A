<!-- Staked into the template's own intake by Shipwright 5 (Claude Fable 5),
     2026-10-08, from the cold-pass instantiation run the same afternoon: a
     memory-bounded Sonnet agent ("Cold Hand") cloned this template at b40ac5b,
     built the dictation-cleanup skill end to end (37 local commits, proxy-
     verified 7/7 positive + 0/11 negative triggers), and filed this report per
     the template's own instruction. The full worked instance is preserved at
     ~/Programming/adrs4ai/dictation-cleanup-coldpass. Same-day fixes shipped
     for F-01/02/03/04/09(README half)/10/11/13(partial)/19/20/22/23/24/27/28;
     canonical-surface findings (F-07/14/16/17/18) routed to the canonical
     template's v3.12 crate via HQ ADR-0042 It-3. Verbatim below; never edit. -->
# TEMPLATE-FEEDBACK — first instantiation (building `dictation-cleanup`)

- **Filed by**: Cold Hand (human) with Claude Sonnet 5
- **Date**: 2026-10-08
- **Template state**: `skill-human-ai-collaboration-template-A` at `b40ac5b` (`kintsugi.lock` says canonical v3.11.4)
- **Format**: README Step 6 / CLAUDE.md "Give back what the template taught you" — **Observation** (what I verified, and how) / **Perception** (what I believed or doubted at that moment) / **Suggestion**. Entries are appended as friction occurs, phase by phase, not reconstructed at the end.

## Context of this report (read first — it bounds what the entries can claim)

- I am a newcomer who was handed this repo with one goal (build a small skill) and the instruction to let the repo teach me its own method.
- **I am an AI agent running in a harness, not a person at a Claude Code prompt inside the clone.** Consequences, each noted again where it bites: I could not "open a FRESH session" in the clone (F-23); the clone's `.claude/skills/` were not in my session's skill registry, so `Skill(template-guide)` returned *Unknown skill* (F-22); and `Skill(adr-authoring)` resolved to an identical copy outside the clone (F-22).
- **Ambient knowledge — read this before trusting any "Perception".** The agent running this instantiation was not memory-less: its harness had loaded a *parent project's* instructions (a different repo that uses this methodology and names `kintsugi`, `just` recipes, crew roles, and the Prime and Secondary Directives), and a skill-load result echoed that project's copy of this template's `CLAUDE.md` (byte-identical to this one; checked with `diff -q`). I tried to learn only from this clone's files and to let the repo's own text be the only authority, and every **Observation** below was re-verified in the clone (the command or file is named). But where a **Perception** says what I "believed" or "doubted" a term meant (F-05, F-06 above all), read it as *what this repo's text leaves a cold reader to infer*, not as a literal report of my ignorance: I already knew what `kintsugi` was. Where a Perception describes something I *did* or *tried* (F-02, F-03, F-09, F-22, F-23), it is literal.
- **Citations refer to the template as cloned.** Observations that quote `README.md`, `CLAUDE.md`, or any other file describe commit `b40ac5b`. This repo has since replaced `README.md` and edited `CLAUDE.md`, so to re-verify an Observation use `git show b40ac5b:<path>` (for example `git show b40ac5b:README.md | grep -n QUICK-START`).
- Nothing here was pushed. CI behaviour (F-09) is read from the YAML, not run.

---

## Phase 1 — Reading (README → CLAUDE.md → QUICK-START → scaffold → skills → templates → ADRs 0001–0007)

### F-01 — The path is clear; the *reading order* around it is not stated

**Observation**: README.md "Your first session — the instantiation path" (six numbered steps) is clear and was the most useful passage in the repo. But nothing says which of the other ~60 files to read, in what order, or which to skip. README never links `QUICK-START.md` (`grep -n QUICK-START README.md` → no match); CLAUDE.md mentions it only as a line in the File Structure tree. `docs/METHODOLOGY.md` is "read once" per CLAUDE.md's last line, but step 2 of the path (fill CLAUDE.md) does not need it.
**Perception**: I believed README → CLAUDE.md was the order because step 2 sends you to CLAUDE.md. I found QUICK-START.md only by listing the root, and for a while doubted whether that "30-second card" was the real front door. I over-read (METHODOLOGY, template-guide, three reference files, seven ADRs) because I could not tell which reading was optional.
**Suggestion**: Add a "Read these, in this order (≈15 min)" line to README Step 1: README → CLAUDE.md → the `adr-authoring` skill; "skip: docs/inbox/, kintsugi.*, docs/resources/, ADR-0006".

### F-02 — `just adr` / `just seed` are taught as THE way to mint, but there is no justfile

**Observation**: `adr-authoring` SKILL.md §2 ends "Mint new ADRs with `just adr "<title>"` — never hand-number."; `docs/adr/AGENTS.md` says "mint with `just adr "<title>"` rather than hand-numbering"; `docs/adr/templates/AGENTS.md` and `references/depth.md` D1 name `just adr` and `just seed <slug>`. CLAUDE.md step 3 and README Step 2 teach the opposite: copy `adr.md` by hand, "check `ls docs/adr/` first; never reuse a number". `ls justfile` → *No such file*; `just adr "probe"` → `error: no justfile found` (`just` itself is installed on my machine). `TEMPLATE-UPDATES.md` carries "Flagged (untouched, need attention): `justfile`" in four consecutive entries.
**Perception**: I read "never hand-number" as binding, tried the recipe first, hit the error, and had to pick between two loud, contradictory rules. I followed CLAUDE.md because it is the one that can be executed. I also noticed the irony that docs/adr/AGENTS.md blames "octal parsing" for hand-numbering collisions, and this repo's own first free number is `0008` — the first octal-invalid one in any shell arithmetic.
**Suggestion**: Ship a ~15-line seed `justfile` with only `adr` and `seed` recipes, or make the sentence conditional everywhere: "if a justfile exists, `just adr`; otherwise copy by hand — next number = highest + 1."

### F-03 — The "worked examples" (ADRs 0001–0007) do not have the shape the repo says is mandatory

**Observation**: `grep -c 'TL;DR' docs/adr/0001-*.md … 0007-*.md` → 0 for all seven, while `adr-authoring` calls TL;DR "Mandatory — if you can't write it in one line, the ADR isn't done" and says 76% of wild ADRs skip it. `grep -c '\*\*Recommendation\*\*'` → 0 and `grep -c '^- \*\*A —'` → 0 for all seven; the QSTs that exist (0003–0007) use the older `Status / Why asking / Need` dialect, 0006 with unlettered `Options:` lists. Cross-references use the *donor repo's* numbering: ADR-0006 sends you to "ADR-0010" for the template-guide design (it is file 0007) and ADR-0007 says it was born in "ADR-0009" (the transformation strategy is file 0006); ADR-0005's own title reads "# ADR-0004: Skill Structure…" and its Links cite "ADR-0004 (Skill Consumer Context)" as a *related* ADR. ADR-0001 and ADR-0003 cite `/docs/resources/agentskills/` and `/docs/resources/skills/` as evidence; both are **empty directories** (`git ls-files -s` shows mode 160000 gitlinks and there is no `.gitmodules`, so `git submodule update --init` cannot fetch them).
**Perception**: CLAUDE.md says "Read them as worked examples". I believed they would show me the target shape; they show the pre-v3.9 shape. adr-authoring §1 describes exactly this trap ("the template file was sitting right there"). I chose the skill + `templates/adr.md` over the examples, but a newcomer who copies the nearest ADR inherits no TL;DR and no Options.
**Suggestion**: Relabel in CLAUDE.md: "ADRs 0001–0007 are historical — read for the *decisions*; copy the *shape* from `templates/adr.md`." Or retrofit a TL;DR + Options to each. Fix the 0005 header and the dangling references (or drop the gitlinks).

### F-04 — The maintainers' own unanswered question lives in the newcomer's `docs/adr/`

**Observation**: `docs/adr/seed-2026-10-08-what-to-do-about-this-template.md` contains `### QST-SKILL-TEMPLATE-FATE` with `- Status: unanswered`. It is the **only** hit for CLAUDE.md's open-questions command (`grep 'Status: unanswered' -r docs/adr/`), is dated the same day as my session, and talks about "tonight's class", "PRIVATE today", and a workshop.
**Perception**: My first reaction was to ask whether it was mine to answer: it matched the repo's own "what needs answers" command, sat in my ADR directory, and was dated today. I then doubted whether reading template-strategy internals was part of instantiation at all. It is also oddly intimate: it tells a stranger how the maintainers feel about the template's future.
**Suggestion**: Move maintainer-only seeds out of the instance-visible `docs/adr/` (e.g. `docs/maintainers/`), or mark `Status: deferred — template maintainers, not an instantiator question`.

### F-05 — The crew layer ships with a "READ BEFORE ANYTHING ELSE" banner and no "skip if solo" banner

**Observation**: `docs/inbox/ONBOARDING.md` opens "Crew Onboarding — read this first if you've been recruited" and §0 says "READ BEFORE ANYTHING ELSE … Register your seat in `agent-sessions.json`". `docs/inbox/` has no `agent-sessions.json` (listing: CONVENTIONS, ENCODING-MAP, INBOX-PROTOCOL, ONBOARDING); recipes it names (`just launch`) don't exist. The only hint that it is optional is one line in QUICK-START.md ("when more than one participant works the repo"). I was also told a name to sign with ("Cold Hand"), which maps onto ONBOARDING's "coin your identity" step, with no file to record it in.
**Perception**: Because I had been given a name to sign with, I paused to check whether ONBOARDING's "coin your identity … register your seat" applied to me. README and CLAUDE.md never mention it, so I concluded it did not. That check was a deliberate act of judgment that a newcomer with a deadline should not have to make.
**Suggestion**: A two-line banner at the top of each `docs/inbox/*.md`: "Crew layer — for projects with more than one AI/human participant. Solo skill-builder? Skip this directory."

### F-06 — House vocabulary appears undefined at the front door

**Observation**: README's first screen says "kintsugi-adopted instance", "canonical", "fleet campaigns"; `kintsugi.yaml` and `kintsugi.lock` sit at the root. `grep -rIl -i kintsugi` lists seven files and the only definition is a parenthetical in a v3.10.x CHANGELOG entry ("*kintsugi — a porcelain for evolving templates*", CHANGELOG.md:89). ADR-0004's ANS says "We could make `kintsugi` have an MCP server" without context. Skill footers cite "Rubricator 5", "Shipwright 5", "Sherd 5", "the tours field guide" (not in this repo).
**Perception**: Read cold, `kintsugi.yaml` and `kintsugi.lock` are two unexplained root files that README names twice on its first screen, and nothing says "maintain", "ignore", or "delete". (I already knew the tool from my harness's context — see the caveat in the Context section — so this is the cold reader's puzzle, reconstructed, not my own.) I left them untouched.
**Suggestion**: One README sentence: "`kintsugi.yaml` / `kintsugi.lock` are bookkeeping for pulling template updates later; leave them alone."

### F-07 — Four different document-level Status vocabularies

**Observation**: `adr-authoring` §2 and `adr.md`: `Draft | Accepted | Partially Implemented | Implemented | Superseded` ("the frozen five", "no annotations here"). `docs/adr/AGENTS.md`: `Draft | Proposed | Accepted | Implemented | Superseded`. `adr.md`'s own Iterations example: "Outcome: `Draft → Proposed`". `adr-madr.md`: `proposed | rejected | accepted | deprecated | superseded`.
**Perception**: I needed a status for "decision made by me, but the ANS still pending a second reader" and wanted `Proposed`, which one document allows and the skill omits. I used `Draft` because the skill calls its five "frozen".
**Suggestion**: Make `docs/adr/AGENTS.md` and the `adr.md` Iterations example agree with the frozen five; add one sentence saying which status an ADR with unanswered QSTs carries.

### F-08 — `template-guide` is stale and still advertised as an auto-loading companion

**Observation**: `.claude/skills/template-guide/SKILL.md` (v1.0.0, "based on v3.2") names seven files that do not exist — `collab-adr-lean.md`, `seed-template.md`, `templates/template.md`, `adr-complete-lifecycle.md`, `agency-grant-patterns.md`, `navigation-code-reference.md`, `commit-message-guide.md` (only `resources/examples/adr-workflow-example.md` exists) — and teaches the bare `grep '^### QST:'` that CLAUDE.md warns "silently misses every handled question". README says it "auto-loads when you work in a repository built from this template". CLAUDE.md lists it under "Companions installed" with no caveat. (The 2026-10-08 seed lists "template-guide skill audit" as a known debt — the newcomer is not told.)
**Perception**: I read it after `adr-authoring` (v3.11.4) and trusted the newer skill. But the repo itself gave me no signal which of two companions wins when they disagree.
**Suggestion**: Add "(predates adr-authoring; where they disagree, adr-authoring wins)" to the CLAUDE.md companion list, or refresh the skill.

### F-09 — The release workflow and README Step 4 describe the donor skill, not this template

**Observation**: README lists `.github/workflows/release.yml`; the file is `.github/workflows/build-skill.yaml`. It hardcodes `SKILL_DIR="epistemic-arc-mapping"` and `epistemic-arc-mapping/SKILL.md` in the required-files check, frontmatter validation, size check, packaging step, and release-notes text. `ls epistemic-arc-mapping` → *No such file or directory*: the `validate` job fails on the pristine template, and after README Step 1 (rename the directory) README Step 4's promise "GitHub Actions will automatically … package skill as ZIP" cannot hold. **Read, not run** — I did not push.
**Perception**: I believed Step 4 would simply work after the rename; the YAML says otherwise. I did not fix it (the instantiation path does not ask me to), but it is a landmine for the first `git tag`.
**Suggestion**: Derive the skill directory (`dirname "$(ls */SKILL.md | head -1)"`) or use one `SKILL_DIR` env var at the top; fix the README filename; or add "Step 4 requires editing build-skill.yaml" to the README.

### F-10 — "CHANGELOG entry per release" — in which CHANGELOG?

**Observation**: CLAUDE.md rule 3: "bumped deliberately, with a CHANGELOG entry per release". Root `CHANGELOG.md` is the *template's* (337 lines, "All notable changes to the `human-ai-collaboration-template`") and a kintsugi `stencil` row (`kintsugi.yaml`; `TEMPLATE-UPDATES.md` records "replace: CHANGELOG.md" on each canonical release).
**Perception**: I first believed I should append my skill's releases to it, then doubted: the next template update would replace or flag my entries. No file in the repo tells me where a *skill* changelog goes.
**Suggestion**: Say "the skill's changelog lives at `<skill>/CHANGELOG.md`" in CLAUDE.md rule 3 (and ship an empty stub in the scaffold).

### F-11 — "A first-line HTML comment" vs "frontmatter must be line 1"

**Observation**: CLAUDE.md rule 3 says "a first-line HTML comment `<!-- skill version: … -->`". The scaffold `SKILL.md` has YAML frontmatter on lines 1–10 and the version comment on line 11; ADR-0001 states "Frontmatter must come BEFORE any markdown content".
**Perception**: Taken literally the two conflict; I resolved it with the scaffold's actual placement (the evidence of intent) and edited my CLAUDE.md to say "directly under the frontmatter".
**Suggestion**: "first line *below the frontmatter*".

### F-12 — Two homes for "friction notes", and the existing one holds the donor's chat logs

**Observation**: CLAUDE.md's File Structure says `docs/feedback/ # field reports on the skill, friction notes`. Its actual contents are `INITIAL-SONNET-4.5.md` (a pasted conversation about the donor "epistemic arc mapping" skill) and `STATUS-REPORT-2026-03-28.md` (donor status report). README and CLAUDE.md both direct friction to a *root* `TEMPLATE-FEEDBACK.md`.
**Perception**: I followed the explicit instruction (root file) but wondered for a moment whether `docs/feedback/` was where the repo's own tooling would look.
**Suggestion**: Fix the tree comment ("donor-skill history"), or move the two files to `docs/history/`.

### F-13 — Donor-repo residue at the edges

**Observation**: `.gitignore` ignores `docs/resources/reveal.js/`, `slides.com`, `playwright-mcp` and cites "docs/adr/0008-nested-git-repos-handling.md" (no such file — and 0008 is exactly the number the README gives a newcomer's first ADR). `docs/resources/README.md` is titled for "building the Architecture of Complexity skill", says "NEEDS UPDATING AFTER REFACTORING", and lists files that do not exist (`sample-ci-cd.yaml`, `simon 1962 architecture.pdf`). `.claude/settings.json` allowlists `docs/inbox/agent-sessions.json` and `just brief|safe-commit|discover-sessions|stamp|aliases` recipes that do not exist here.
**Perception**: None of it blocks; each stray reference makes me re-verify whether *I* am missing something (a hidden ADR-0008? a missing PDF?). The cost is trust, not time.
**Suggestion**: Prune `.gitignore` and `docs/resources/README.md` to what ships; drop the dead allowlist rows.

### F-14 — `adr.md` is 263 lines; the skill says the load-bearing core is ~15

**Observation**: CLAUDE.md step 3 says copy `adr.md`. The template has ~14 section types (Quick Reference, Originating Context, Explicitation, Questions, Supporting Materials, Decision, Open Follow-ups, Action Items, Validation, Iterations, Glossary, Links…), with "delete unused sections" stated only for Supporting Materials. `adr-authoring` §2 calls "frontmatter + one QST + one catch-the-author Recommendation" the "load-bearing 80%".
**Perception**: I did not know whether a pruned ADR still counts as well-formed, or whether deleting a section would silently break a parser. I kept: header, TL;DR, Originating Context, Explicitation (short), Questions, Decision, Action Items, Validation, Iterations, Links; and deleted the rest.
**Suggestion**: State in `adr.md`'s header comment which sections are safe to delete (e.g. "required: header, TL;DR, one QST; everything else prunable"). Also say whether the ~20 lines of protocol prose that open the template's Questions section (Protocol, ORRCF form, Status tokens, Question identity, Answering) are for the author to read or to copy — I read them and left them out of my ADRs.

---

## Phase 2 — Instantiation: CLAUDE.md fill, seed, ADR-0008..0012

### F-15 — The seed's lifecycle machinery is parser-significant but its life-cycle is unstated

**Observation**: `seed.md` carries a "Model Response Request" sensor block with three checkboxes ("tooling reads these exact checkbox labels as the seed's declared lifecycle state"), a `## Derived Into` placeholder ("replace the line with the ADR list when chunking"), and an instruction at the bottom: "Copy everything from 'Model Response Request' through the final `---` to the end of your response." Nowhere does it say what the checkbox state should be *after* chunking, or whether the copied block goes before or after my own `### Cold Hand - date` reply. The typo "what has note been processed yet" sits in a MODEL INSTRUCTIONS comment.
**Perception**: I did the work in a defensible order (tick "Chunk this into ADRs" → write the Thread response → copy the unchecked block → human reply → fill Derived Into) but could not tell whether a parser would read my final state as "chunked", "iterating", or "in progress". I committed the seed *before* touching Derived Into so the commit history shows un-chunked → chunked.
**Suggestion**: One sentence under the sensor block: "After chunking, leave 'Chunk this into ADRs' checked and replace Derived Into; the next model response copies the unchecked block."

### F-16 — Confidence action bands have gaps, and "route to another mind" has no route

**Observation**: `adr.md`: "≥0.90 act · 0.60–0.85 your call · ≤0.55 route to another mind". Values 0.56–0.59 and 0.86–0.89 fall in no band. Two of my QSTs genuinely landed at 0.55 (question budget, license).
**Perception**: At 0.55 I believed I was supposed to hand the question to someone else, but the only other mind available in a solo run was the person answering the QST anyway; I wrote "I would welcome an override" in the rationale and moved on. I avoided 0.56–0.59 and 0.86–0.89 deliberately, which means the bands shaped my numbers rather than my numbers shaping the bands.
**Suggestion**: Make the bands contiguous (`≥0.90 act · 0.60–0.89 your call · <0.60 route`) and say what "route" means when no other mind exists (e.g. "mark the QST `answered — provisional` and say what would settle it").

### F-17 — The method presumes a separate answerer; self-answered QSTs have no convention

**Observation**: The QST/ANS loop is described as AI asks, human answers (CLAUDE.md: "ANS: Answers (human fills in)"). In this run the human persona ("Cold Hand") and the AI were driven by the same agent, and the original brief fixed some answers but not others. Nothing in `adr-authoring` or `questions-reference.md` covers "the author answered their own question".
**Perception**: I worried that filling `**ANS:** (by Cold Hand, …)` myself would look like fabricating a human's consent. I resolved it by (a) writing in the ANS only what the brief or the persona's own seed already supported, (b) adding a condition or refinement only where I actually had one (several ANS blocks) rather than rubber-stamping every recommendation, and (c) marking the one answer I had no basis for (license) `answered — provisional`. I am not sure that is what the method intends.
**Suggestion**: Teach one line in the Answering paragraph: "If the same party asked and answered, say so — `(by X, self-answered)` — and prefer `answered — provisional` to a confident-looking close."

### F-18 — When does a document Status change?

**Observation**: The frozen five (`Draft | Accepted | Partially Implemented | Implemented | Superseded`) are taught, but not the transitions. `adr.md`'s Iterations example shows "`Draft → Proposed`", which is not in the five (see F-07).
**Perception**: I decided that `Draft` = questions open, `Accepted` = questions answered and Decision filled, and I would flip to `Implemented` when `SKILL.md` realizes it. I believe that is the intent, but I had to infer it.
**Suggestion**: Add the three-line lifecycle to `adr-authoring` §2, right under the frozen-five sentence.

### F-19 — No sizing guidance: a "small" skill produced 1 seed, 5 ADRs, 15 QSTs before a line of `SKILL.md`

**Observation**: README Step 3 says "let Claude chunk it into ADRs"; CLAUDE.md says "Identify threads — usually 2-5". My brain dump yielded five threads; each ADR with the template's parts (TL;DR, Originating Context, Explicitation, QSTs with Options + ORRCF Recommendation + ANS, Decision, Action Items, Validation, Iterations, Links) came to 150–210 lines. `wc -l docs/adr/0008-*.md … 0012-*.md docs/adr/seed-2026-10-08-dictation-cleanup.md` → 1,045 lines in total when I wrote this entry (1,137 now, after the iteration-3 results and two follow-up questions were added). For scale, the skill's `SKILL.md` is 230 lines and all five skill files together are about 800.
**Perception**: Every ADR was useful — writing them surfaced decisions I would otherwise have made silently (e.g. the CLAUDE.md keyword collision in ADR-0008, the "no signal, no touch" rule in ADR-0009, the pre-registered test matrix in ADR-0012). But QUICK-START's Core Principle is "Preserve them without ceremony", and a newcomer with an evening to spare will not write 1,000 lines before touching `SKILL.md`. Nothing says which ADRs a small skill can skip.
**Suggestion**: Add a sizing line to the instantiation path: "A small skill needs three ADRs — scope & trigger, behavior policy, verification. Fold packaging/license/versioning into one `NOT:` list unless something is actually contested."

### F-20 — "SKILL.md ~300–500 lines" can be read as a floor, a target, or a ceiling

**Observation**: CLAUDE.md: "SKILL.md (the core, ~300–500 lines)". README Step 3: "SKILL.md (~300-500 lines): Core methodology, complete and self-sufficient". The scaffold: "**Size:** ~[X] lines (recommended: under 500)". ADR-0005: "Target: ~300-500 lines (under 500 line recommendation)".
**Perception**: Three of four statements sound like a range to aim for; the scaffold says "under 500". For a small, judgement-heavy skill I chose "under 300" and recorded the reading as ADR-0010 QST-SIZE-TARGET, answered "ceiling". I could not tell whether that is acceptable or a misreading.
**Suggestion**: Say "under 500 lines; most skills land at 150–400. Length is cost: the whole file loads every time the skill triggers."

### F-21 — ADR-0003 says add a `license:` frontmatter field; the scaffold and the bundled format reference omit it

**Observation**: ADR-0003 (Accepted): "Add `license:` field to SKILL.md frontmatter" with an Action Item ticked `[x]`. The scaffold `SKILL.md` frontmatter has only `name` and `description`. The "Frontmatter reference" table in `docs/resources/skill-format/extend-claude-with-skills.md` lists name, description, argument-hint, disable-model-invocation, user-invocable, allowed-tools, model, context, agent, hooks — no `license`.
**Perception**: The ADR and the scaffold disagree, and the official reference the repo bundles as "the canonical reference for skill format" sides with the scaffold. I followed the ADR (`license: Complete terms in LICENSE`, recorded in ADR-0011) because it is the recorded decision, but I could not verify that the field is read by anything — it may simply be ignored.
**Suggestion**: Either add `license:` to the scaffold frontmatter or amend ADR-0003 to say it is optional and not in the bundled reference. (Evidence that the field is at least tolerated: the installed `architecture-of-complexity` skill's own frontmatter carries `license: Complete terms in LICENSE. See also LICENSE-CAM.md and LICENSE-THIRDX.md …`.)

---

## Phase 3 — Building the skill, installing it, testing it

### F-22 — "Load the `adr-authoring` skill first" depends on where the session was started

**Observation**: CLAUDE.md step 3: "load the `adr-authoring` skill first (it is installed in this repo; available ≠ loaded)". I invoked the Skill tool for it: it loaded, but from a copy **outside the clone** (my session was not started in the clone); `diff -q` showed the loaded `SKILL.md` and all three `references/*.md` byte-identical to the clone's installed copies. `Skill(template-guide)` returned `Unknown skill: template-guide` although `.claude/skills/template-guide/` is installed in the clone. I read both skills' files directly instead.
**Perception**: I believed "installed in this repo" meant any session working on this repo would see these skills. It means a session **launched at the repo root** will. I could not tell, from inside my session, whether the file I was following was the one the repo ships — I had to diff to know.
**Suggestion**: Add to README Step 2: "Launch Claude Code from the repo root (`cd your-skill && claude`) — skills in `.claude/skills/` are discovered at launch from the working directory. Check with `/skills` (or ask 'what skills are available?')."

### F-23 — The verification gate has no non-interactive recipe, so an agent or CI cannot run it

**Observation**: README Step 5 and CLAUDE.md "Verification" both say "open a FRESH session" in the repo. I could not do that from inside an agent run, and the repo offers no other way to run the gate. I did not try `claude -p` from a shell, because a nested session writes its transcript outside the clone and my brief said to touch nothing outside it. The bundled `extend-claude-with-skills.md` says edits to skills in `--add-dir` directories are "picked up by live change detection … without restarting", which sits oddly beside "fresh session".
**Perception**: I felt the gate was the repo's most important instruction and the one I was least able to follow. I built a proxy (ADR-0012: 18 trigger prompts and 6 behavior trials run through stand-in agents, scored by independent judge agents) and labeled it "proxy-verified" and kept the version at 0.1.0. That is the best I could do; it is not what the repo asked for.
**Suggestion**: Put a 10-line "run the gate" recipe in CLAUDE.md that works for both humans and agents (a prompt list, the expected `/skills` listing, and — if it works — a headless one-liner). Say whether editing an installed `SKILL.md` needs a restart, citing the bundled doc.

### F-24 — `template-guide`'s description claims every session in every instance repo

**Observation**: Its frontmatter: "Use when working in a repository built from this template." That is true in every session in this repo, so a router should load it all the time — while its body is stale (F-08). My trigger proxy could not test this (the stand-ins were told nothing about the repo, and none loaded `template-guide`, one reasoning "only applies if the repo is known to be built from its template (not indicated)").
**Perception**: I worried that in a real fresh session `template-guide` would be loaded alongside every skill I was testing, adding stale instructions I could not observe from here. I scored only whether `dictation-cleanup` loaded, not what else did.
**Suggestion**: Narrow it ("Use when the user asks how this repo's ADR/seed method works") or set `disable-model-invocation: true` so it is a deliberate `/template-guide` call; refresh the body (F-08).

### F-25 — The scaffold `SKILL.md` carries sections that instruct the author, not the model

**Observation**: The scaffold has "Meta-Note: This Skill's Structure" (AoC bullets, `**Size:** ~[X] lines`, `**Coverage:** ~[X]%`), a "Decision Framework" and a "Quick Reference" that overlap, and a trailing duplicate of the Authors/License/Created block. Everything in `SKILL.md` is loaded into context every time the skill fires.
**Perception**: I treated each section as optional because of the under-300 target and omitted the Meta-Note, the duplicate footer, and the Decision Framework (its content became the decision tree). I could not tell whether omitting them was permitted.
**Suggestion**: Mark the author-facing sections with a comment ("delete before shipping — not for the model") or move the AoC meta-note to the scaffold README.

### F-26 — There is no complete worked instance to copy from

**Observation**: README "Examples": "`temp/epistemic-arc-mapping-skill/` - Complete worked example (if present)". It is not present. The only example skill in the tree (`docs/resources/skill-format/visual-diffusion-unpacked/`) was not built with this method and has no ADRs. The scaffold shows the *shape* of a skill but no finished ADR → SKILL.md arc.
**Perception**: The adr-authoring skill itself says "Exemplars beat prose … match its shape" (depth.md D2). I had no exemplar instance of the template's own output and wrote five ADRs from the abstract template plus ADR-0001–0007, which I had already found do not match (F-03).
**Suggestion**: Ship one tiny finished instance (a seed, two ADRs, a 60-line skill) under `docs/examples/`. This repo, after this run, is arguably that.

### F-27 — Small papercuts

**Observation**: (a) README's tree and CLAUDE.md both direct temporary scripts to `scripts/ephemeral/`, but the directory does not exist after cloning (no `.gitkeep`) — I improvised a path, and in doing so wrote one temp file to the wrong directory outside the clone (noticed at once and removed). (b) CLAUDE.md's Sixth Directive points at `docs/vignettes/`, also absent. (c) The scaffold `your-skill-name/README.md` ends "**Built using:** [human-ai-collaboration-template-A](https://github.com/jlumbroso/skill-human-ai-collaboration-template-A)" — the link text names a different repo from the URL. (d) The scaffold README's install line `unzip your-skill-name-0.1.0.skill -d ~/.claude/skills/your-skill-name/` presumes a release that no workflow can currently produce (F-09).
**Perception**: Each is a two-second fix and a two-minute doubt: after (a) I wondered whether the directory was meant to be created by a recipe I did not have.
**Suggestion**: Add `.gitkeep` to `scripts/ephemeral/` and `docs/vignettes/`; fix the link text; add "(no release exists yet)" to the install snippet.

### F-28 — The "Open questions" command overcounts: it matches the templates' skeleton lines

**Observation**: CLAUDE.md "Open questions" (and README, QUICK-START, `adr.md`'s Quick Reference) give `grep 'Status: unanswered' -r docs/adr/`. In the finished repo it returns 8 lines: 2 real open questions of mine, 1 of the maintainers' (F-04), and 5 from `docs/adr/templates/` (`adr.md` 4 — two skeleton questions plus two lines of the template's own prose about the grep — and `debrief.md` 1). `grep -rn 'Status: unanswered' docs/adr --exclude-dir=templates` returns the 3 real ones. (`git grep -c` on the pristine commit `b40ac5b`: 4 + 1 in the templates, 1 in the maintainers' seed.)
**Perception**: At the point of writing my README's "Open questions" paragraph I nearly reported eight. A newcomer who runs the documented command on a fresh clone sees six matches — five from the templates and the maintainers' seed — in a repo with no open question of their own.
**Suggestion**: Add `--exclude-dir=templates` to every copy of that command (CLAUDE.md, README, QUICK-START, `docs/adr/AGENTS.md`).

---

## What worked (please keep these)

Friction is what the instrument asks for, but a maintainer also needs to know which parts carried the weight. Each item names the evidence.

- **The six-step path in README "Your first session"** — I followed it in order and it never sent me in a circle (steps 1–6 → `9731e3d`, `ad757fb`, the seed and five ADRs, `SKILL.md`, install, this file).
- **"The frontmatter `description` is the trigger surface … say what it does NOT cover" (CLAUDE.md, rule 1; the scaffold's bracketed comment)** — I used it as a checklist for the description contract in ADR-0008, and the resulting description fired on 7 of 7 should-fire prompts and 0 of 11 should-not-fire prompts in the proxy run (`docs/feedback/2026-10-08-dictation-cleanup-proxy-run.md`). The keyword-collision catch (keeping `CLAUDE.md` out of the description) came from reading the description against this repo's own vocabulary.
- **`adr-authoring`'s never/always pairs** — seventeen QSTs across five ADRs with no malformed heading; the documented `grep -E '^### QST(-[A-Za-z0-9-]{1,24})?:'` matched every one on the first try, and an `awk` check found every `- Status:` line directly under its heading.
- **The ORRCF `If wrong:` clause** — a falsifier that must name an observation and a flip-to letter made me say, before the skill existed, what would change each recommendation. For the trigger and verification questions that observation *was* a test, so ADR-0012's matrix was written first and fixed (ADR-0008's `If wrong:` pointed at a matrix that did not yet exist). It later gave two post-gate doubts a place to live as checkable questions (ADR-0009, `docs/vignettes/2026-10-08-green-rubric-six-commas.md`).
- **`questions-reference.md`'s `answered — <annotation>` and the structured `**Awaiting**` / `**Scope Remaining**` fields** — they let me close the license question honestly as provisional and mark ADR-0012 `Partially Implemented` without decorating the frozen status enum.
- **"File your friction … while it's fresh"** — I filed in three phases (reading, instantiation, build and test) and each phase's perceptions are ones I could not have reconstructed at the end.
