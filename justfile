# Seed justfile — the two minting recipes the methodology teaches, plus the honest
# question sweep. Deliberately tiny: the full crew-layer recipe set lives in the
# canonical template (human-ai-collaboration-template-A) and comes in only if your
# project grows multiple participants. (Shipped 2026-10-08 after a cold-pass test
# hit the contradiction: the adr-authoring skill says "mint with `just adr` — never
# hand-number" and this repo had no justfile. Now both sentences are true here.)

# Mint the next-numbered ADR from the template. Usage: just adr "Short title"
adr TITLE:
    #!/usr/bin/env bash
    set -euo pipefail
    # `(grep || true)` so an empty docs/adr/ doesn't abort under pipefail
    LAST=$(ls docs/adr/ 2>/dev/null | { grep -E '^[0-9]{4}-' || true; } | sed 's/-.*//' | sort -n | tail -1)
    NEXT=$(printf "%04d" $(( 10#${LAST:-0} + 1 )))
    SLUG=$(echo {{quote(TITLE)}} | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g; s/--*/-/g; s/^-//; s/-$//')
    FILE="docs/adr/${NEXT}-${SLUG}.md"
    if [[ -e "$FILE" ]]; then echo "Error: $FILE already exists" >&2; exit 1; fi
    if [[ ! -f docs/adr/templates/adr.md ]]; then
        echo "Error: docs/adr/templates/adr.md not found" >&2; exit 1
    fi
    mkdir -p docs/adr
    cp docs/adr/templates/adr.md "$FILE"
    echo "$FILE"
    echo "↪ BEFORE writing: load the adr-authoring skill (Skill tool) — it IS the read-the-template step." >&2
    echo "  Available is not loaded: a skeleton filled without the skill is how QSTs ship unstructured." >&2

# Mint a dated seed for a brain dump. Usage: just seed "topic-slug"
seed SLUG:
    #!/usr/bin/env bash
    set -euo pipefail
    SLUG=$(echo "{{SLUG}}" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g; s/--*/-/g; s/^-//; s/-$//')
    FILE="docs/adr/seed-$(date +%Y-%m-%d)-${SLUG}.md"
    if [[ -e "$FILE" ]]; then echo "Error: $FILE already exists" >&2; exit 1; fi
    if [[ ! -f docs/adr/templates/seed.md ]]; then
        echo "Error: docs/adr/templates/seed.md not found" >&2; exit 1
    fi
    cp docs/adr/templates/seed.md "$FILE"
    echo "$FILE"

# What needs answers — excludes the template skeletons, which carry example
# Status lines that are teaching, not questions (a bare recursive grep overcounts).
unanswered:
    @grep -rn 'Status: unanswered' docs/adr/ --exclude-dir=templates || echo "No open questions."

# ─── inbox recipes (ported from the canonical template, 2026-10-20 — Winnow 5 of
# blathm-hunting found the gap: ONBOARDING mandates these recipes; this justfile
# shipped without them, forcing a hand-stamped UTC workaround on day one.
# Reservation-only: they print a filename and never touch the file.
# wait-for-brief is DELIBERATELY absent — it needs the crew layer's scripts;
# it arrives with the full crew import if this project grows one. That absence
# is legible here instead of silent.) ───

# Example: just brief planner reviewer schema-question
[group('inbox')]
[doc("Create new outgoing brief file: just brief <from> <to> <slug>")]
brief from to slug:
    #!/usr/bin/env bash
    set -euo pipefail
    ts=$(date -u +"%Y-%m-%d-%H%M")
    # quote(): every recipe parameter is DATA — interpolated bare inside shell
    # quotes, `backticks`/$(…) inside it EXECUTE (field incident, porthole
    # 2026-10-12: a commit message naming `just gate` ran the gate; fix by
    # Jérémie + Opus 5.5, ported fleet-wide same day; class audited across
    # this file — every user-string now passes through quote()).
    FROM={{quote(from)}}; TO={{quote(to)}}
    slug=$(echo {{quote(slug)}} | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g; s/--*/-/g; s/^-//; s/-$//')
    file="docs/inbox/${ts}-${FROM}-to-${TO}-${slug}.md"
    if [[ -e "$file" ]]; then echo "Error: $file already exists" >&2; exit 1; fi
    mkdir -p docs/inbox
    # Deliberately do NOT touch the file — this recipe only RESERVES the
    # filename; the author creates the content (e.g. via an AI Write tool).
    # An empty stub traps Write-tool flows into read-before-write errors and
    # causes false wait-for-brief wakes (dogfooded 4+ times, caring-feedback
    # 2026-06-27/28).
    echo "$file"

# Create a new completion brief (response to an earlier dispatch).
# Args: from slug.
#
# Filename: docs/inbox/<UTC-ts>-<from>-completion-<sluggified-slug>.md
#
# Example: just completion implementer schema-question
[group('inbox')]
[doc("Create new completion brief file: just completion <from> <slug>")]
completion from slug:
    #!/usr/bin/env bash
    set -euo pipefail
    ts=$(date -u +"%Y-%m-%d-%H%M")
    FROM={{quote(from)}}
    slug=$(echo {{quote(slug)}} | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g; s/--*/-/g; s/^-//; s/-$//')
    file="docs/inbox/${ts}-${FROM}-completion-${slug}.md"
    if [[ -e "$file" ]]; then echo "Error: $file already exists" >&2; exit 1; fi
    mkdir -p docs/inbox
    # Reservation only — see `brief` recipe note.
    echo "$file"

# Create a new broadcast brief (1:many, group-addressed). Groups are defined
# in docs/inbox/agent-sessions.json ("groups" key); wait-for-brief wakes every
# member of an addressed group. Group defaults to "crew".
#
# Example: just broadcast planner all-hands-schema-change
[group('inbox')]
[doc("Create new broadcast brief: just broadcast <from> <slug> [group=crew]")]
broadcast from slug group='crew':
    #!/usr/bin/env bash
    set -euo pipefail
    ts=$(date -u +"%Y-%m-%d-%H%M")
    FROM={{quote(from)}}; GROUP={{quote(group)}}
    slug=$(echo {{quote(slug)}} | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g; s/--*/-/g; s/^-//; s/-$//')
    file="docs/inbox/${ts}-${FROM}-to-${GROUP}-${slug}.md"
    if [[ -e "$file" ]]; then echo "Error: $file already exists" >&2; exit 1; fi
    mkdir -p docs/inbox
    # Reservation only — see `brief` recipe note.
    echo "$file"

# Archive an acted-upon brief: git mv to docs/inbox/archive/ and commit.
# Closes lifecycle step 4 of INBOX-PROTOCOL.md (write → read → act → archive).
# Opinionated: auto-commits with a `chore(inbox):` message — adapt if your
# project batches archive commits differently.
[group('inbox')]
[doc("Archive an acted-upon brief: just inbox-archive <filename>")]
inbox-archive filename:
    #!/usr/bin/env bash
    set -euo pipefail
    file="docs/inbox/{{filename}}"
    if [[ ! -f "$file" ]]; then echo "❌ Not found: $file" >&2; exit 1; fi
    git restore --staged . 2>/dev/null || true
    mkdir -p docs/inbox/archive
    git mv "$file" "docs/inbox/archive/{{filename}}"
    echo "📦 Archived: {{filename}}"
    git diff --cached --stat
    git commit -m "chore(inbox): archive {{filename}}"

[group('inbox')]
[doc("List recent inbox briefs, newest first")]
inbox:
    @ls -t docs/inbox/*.md 2>/dev/null | head -20 || echo "(no briefs yet)"

[group('inbox')]
[doc("Print current UTC + local timestamps (filenames use UTC)")]
stamp:
    @date -u +"%Y-%m-%d-%H%M (UTC)" && date +"%Y-%m-%d %H:%M (%Z)"
