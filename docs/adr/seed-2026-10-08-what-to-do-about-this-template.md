# Seed: What to do about this template — the long run

- **Date**: 2026-10-08
- **Author**: Shipwright 5 (Claude Fable 5), at Jérémie's ask ("gather some thoughts in a markdown file for 'what to do about this template' in the long run"), written during the same-day workshop TLC
- **Status**: Seed — one QST, strategy-grade; nothing here blocks tonight's class use

---

## What this repo actually is, as of today

Two layers with different metabolisms:

1. **The propagated layer** — ADR templates, the adr-authoring skill, scripts, QUICK-START, CHANGELOG — is a **kintsugi-adopted instance** of template-A and is *healthy*: fleet campaigns carried it to v3.11.4 while nobody was watching. The sync problem that made this repo feel "always a bit behind" is solved machinery now; it was never this layer that lagged.
2. **The local layer** — CLAUDE.md, README, TEMPLATE-VERSION, the `your-skill-name/` scaffold, ADRs 0001–0007 — is the repo's own flesh, and it was frozen at April–July. Today's TLC (commit `9dc8d32`) brought it current, but the diagnosis matters more than the fix: **the local layer had no heartbeat because no lane owns it.** The twin-CLAUDE design (CLAUDE.md for bootstrap + CLAUDE.template.md for the user) rotted into both files pointing at template filenames the heal had replaced — drift between two hand-maintained twins, the exact class kintsugi exists to kill, in the one repo layer kintsugi doesn't cover.

## What changed in the world since this repo was designed (April 2026)

- **Kintsugi exists.** "Keep a derived template in sync" went from manual despair to one `update` away.
- **The plugin era opened** (HQ ADR-0041, Accepted): skills are the plugin's primary cargo; `ADRs4AI/plugins` ships `adr-authoring` and `adrs4ai-tooling` to strangers; `claude plugin eval` can *measure* a skill with/without ablation. Distribution and evaluation — the two things this repo's ADRs 0001/0002 had to invent (ZIP packaging, SemVer discipline) — now have first-party answers.
- **An open Agent Skills standard** emerged (skills as plain Markdown directories), plus Anthropic's own skill-creator tooling. The format bet in ADR-0001 (`.skill` ZIP + frontmatter) predates both; HQ ADR-0001's packaging QST is still formally open and probably moots toward the standard.
- **The marker family** (version markers + teaching map) gives skills a co-versioning and up-link grammar this repo's scaffold only gained today.
- **The house shipped many real skills** — adr-authoring, adrs4ai-tooling, question-tours, template-guide's successors in spirit — and here is the honest observation this seed exists to stake: **none of them were born from this template.** They were born in canonical's `.claude/skills/`, taught by the house's own conventions. The factory the house *uses* is not the factory it *ships*. That gap is either a to-fix or a to-embrace, and that is the long-run question.

## The long-run question

### QST-SKILL-TEMPLATE-FATE: What is this repo's end state?
- Status: unanswered
- Why asking: The repo has real, proven value (Jérémie: "I've gotten a lot of good use out of that template") and real identity debt (unowned local layer; conventions diverging from the house's actual skill-making practice; packaging bets predating the standards). Tonight's class use is unaffected — this is about where the value should live in a year.
- Need: pick a letter (or override — any shape answers; staged combinations welcome, the recommendation proposes one)

Options:
- **A — A profile of the main template**: the skill layer (scaffold, skill-build teaching, ADRs 0001–0007 as worked examples) becomes a `skill-project` **profile** in canonical's manifest (the mechanism just gained its first include-mode customer via the plugin's `plugin-operator` profile). Instantiators take canonical with `--profile skill-project`; this repo becomes the profile's reference instance. One source of truth; the local-layer orphanhood ends structurally.
- **B — A standalone sibling, now owned**: keep the repo as-is (TLC'd), give the local layer an explicit owner/cadence (template-release lane sweeps it at each canonical minor). Preserves the classroom-ready front door and separate identity; accepts permanent two-layer maintenance.
- **C — Extract the teaching into a `skill-authoring` skill**: the repo's real cargo is a *curriculum* (how to build a skill: trigger surface, 80/20 split, versioning, testing loop). The house's delivery grammar for curricula is skills — ship `skill-authoring` in canonical + the plugin, next to adr-authoring; this repo archives into honored-ancestor status or persists as a demo instance.
- **D — Dissolve into the plugin**: C plus an `/adrs4ai:new-skill` command that scaffolds the directory — the plugin era's native shape; no repo-shaped template at all.

**Recommendation**: (by Shipwright 5, Claude Fable 5, 2026-10-08)
**B now, converging deliberately on C + A.** *Rationale*: B is already true as of tonight (the TLC made it class-ready; the owner gap is one assignment) and nothing strategic should move the week of a live workshop. But the gap observation — the house's own skills are not born here — says the teaching wants to be a *skill* (C): skills are how this house delivers curricula at the moment of need, and `skill-authoring` belongs beside `adr-authoring` in the plugin's cargo where strangers actually are. The repo-shape then stops being a fork and becomes a *profile* (A) of canonical, which ends the unowned-local-layer disease structurally rather than by vigilance. D's command is a later convenience riding C, not a fork of its own. *Confidence*: 0.65 — because this is founder-taste-heavy strategy (the standalone classroom identity may be worth more than the maintenance it costs — tonight's class is itself evidence either way), and it interlocks with three open decisions elsewhere: HQ ADR-0001 (`.skill` ZIP packaging — likely mooted by the Agent Skills standard + plugin), ADR-0033 (the CC BY-SA skill-repos QST), and the 0024 public/private ladder. *If wrong*: if the classroom front door proves to be the template's core value (students need a repo to clone, not a skill to load), this flips to **B hardened** — and C still happens compatibly, because a `skill-authoring` skill and a classroom repo are not rivals; only A's dissolution would be dropped.

## NOT: threads, deliberately not QSTs yet

- **Tonight is a field study** — ~20 cold instantiations in one room is the largest first-boot corpus event this ecosystem has had. The TLC'd CLAUDE.md and README now ask every instantiator to file a root `TEMPLATE-FEEDBACK.md` (Observation / Perception / Suggestion — Reveille 5's instrument, muster 2026-10-06). For a *metacognition* class this is not just our intake: noticing your own epistemic state at the moment of friction IS the course material. Suggest making the feedback file an explicit workshop deliverable.
- **Packaging**: `.github/workflows/release.yml` still builds `.skill` ZIPs on tags (ADR-0001-here); HQ ADR-0001's QST ("do packaged artifacts remain wanted?") is still open and the Agent Skills standard + plugin likely answer it. Don't delete the workflow before that ANS; don't advertise it either.
- **`resources/` vs `references/`**: this repo's ADR-0006 chose `resources/`; canonical house skills use `references/`. One word, cosmetic until the day a tool keys on it; harmonization belongs to whichever option wins above (a profile or extracted skill would inherit canonical's word).
- **Crew machinery without its driver**: fleet campaigns delivered `scripts/` (groups-lookup, tmux, hooks) but the repo has no justfile — recipes referenced nowhere, machinery inert. Either the seed justfile rows come in (if B hardens, for multi-participant skill projects) or the scripts prune to solo-scale. Harmless tonight; untidy forever.
- **`template-guide` skill audit**: it predates adr-authoring, ORRCF, and the marker family; it still teaches from the v3.2-era worldview. If B hardens it needs a freshening pass; under C it merges into `skill-authoring`'s lineage with attribution.
- **Org home & visibility**: `jlumbroso/` + PRIVATE today. Class access tonight is a logistics decision (his hands); *permanent* public is gated by ADR-0033's skill-repo licensing QST and the 0024 ladder — the repo already declares CC BY-SA throughout, so the license posture is consistent whenever the ladder says go. The org-home question is ADR-0022's twin (codetour asked the same).
- **The three-ADR debt this seed does NOT open**: scaffold `description` grammar as a lintable rule; a `skill version` marker joining the teaching-map family formally (Mint/Ensign own those word surfaces); `claude plugin eval` cases for skills born here. All live under whichever fate wins.

---

*Staked by Shipwright 5 (Claude Fable 5), 2026-10-08, the afternoon before the CAM workshop — the template's first class of cold instantiators is also its first measured field study. The example is not the teaching, but twenty examples with friction reports come close. ⚓*
