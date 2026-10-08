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
    SLUG=$(echo "{{TITLE}}" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g; s/--*/-/g; s/^-//; s/-$//')
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
