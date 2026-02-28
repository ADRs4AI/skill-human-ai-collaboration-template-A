# ADR-0002: Versioning Strategy

- **Date**: 2026-02-27
- **Iteration**: 1
- **Status**: Accepted
- **Deciders**: Jérémie Lumbroso, Claude Code Sonnet 4.5

---

## Context

The skill needs a versioning system that:
1. Communicates compatibility and changes clearly
2. Enables automated release management
3. Works well with Git tags and GitHub Releases
4. Follows community standards

From conversation:
> **Jérémie**: "The versioning preference, I said Semver as you recommended"

---

## Decision

### Chosen: Semantic Versioning (SemVer)

**Format**: `MAJOR.MINOR.PATCH` (e.g., `1.0.0`, `1.1.0`, `2.0.0`)

**Increment rules for this skill**:

- **MAJOR**: Breaking changes to skill principles or framework
  - Example: Fundamentally different interpretation of Simon's architecture
  - Example: Removing core concepts (near-decomposability, etc.)
  - Example: Changing skill invocation behavior in incompatible ways

- **MINOR**: New examples, enhanced explanations, additional concepts
  - Example: Adding new example (e.g., database-design.md)
  - Example: Expanding existing sections with more detail
  - Example: Adding new but related principles from complexity theory

- **PATCH**: Fixes, typos, clarifications, formatting
  - Example: Fixing typos or grammatical errors
  - Example: Improving code examples for clarity
  - Example: Better formatting of markdown

**Initial version**: `1.0.0`
- Rationale: Skill is complete and functional, ready for production use

---

## Alternatives Considered

### Option A: Date-Based Versioning (2026.02.27)
- **Pros**: Clear temporal ordering, simple to generate
- **Cons**: No semantic information about changes, harder to assess compatibility
- **Verdict**: Less suitable for a teaching skill where content stability matters

### Option B: Hybrid (1.0-20260227)
- **Pros**: Both semantic and temporal information
- **Cons**: More complex, non-standard format
- **Verdict**: Unnecessary complexity for our use case

### Option C: Single Number (v1, v2, v3)
- **Pros**: Extremely simple
- **Cons**: No granularity for minor updates vs breaking changes
- **Verdict**: Too coarse-grained

---

## Implementation

### Where Version Appears

1. **SKILL.md frontmatter** (metadata):
   ```markdown
   **Version:** 1.0.0
   ```

2. **Git tags** (for releases):
   ```bash
   git tag v1.0.0
   git tag v1.1.0
   ```

3. **GitHub Releases** (automatically from tags):
   - Release title: `v1.0.0 - Architecture of Complexity Skill`
   - Asset name: `architecture-of-complexity-1.0.0.skill`

4. **ZIP filename** (packaged skill):
   - Format: `architecture-of-complexity-{version}.skill`
   - Example: `architecture-of-complexity-1.0.0.skill`

### Version Bumping Process

**Manual (initial approach)**:
1. Decide change type (major/minor/patch)
2. Update version in SKILL.md
3. Commit: `chore: bump version to X.Y.Z`
4. Tag: `git tag vX.Y.Z`
5. Push: `git push && git push --tags`
6. CI creates release automatically

**Future automation options**:
- Conventional commits + auto-bump
- Manual workflow dispatch with version input
- Not implementing now - YAGNI

---

## Consequences

### Benefits
- Clear compatibility signaling
- Standard format (widely understood)
- Works well with Git tags and GitHub Releases
- CI/CD can extract version from tag (`v1.0.0` → `1.0.0`)

### Trade-offs
- Requires discipline to follow increment rules
- Manual version bumping (for now)
- Need to document versioning semantics for contributors

### Examples of Future Versions

**v1.0.0** → Initial release (current)
**v1.0.1** → Fix typo in watchmaker parable explanation
**v1.1.0** → Add new example: kubernetes-architecture.md
**v1.2.0** → Expand "Empty World Hypothesis" section with more detail
**v2.0.0** → Restructure around different organizational framework (unlikely)

---

## Action Items

- [x] Decide on SemVer format - Owner: Both
- [ ] Update SKILL.md to version 1.0.0 - Owner: Claude Code
- [ ] Document versioning rules in CONTRIBUTING.md - Owner: Claude Code
- [ ] Configure CI/CD to use version from git tags - Owner: Claude Code

---

## Validation

- [x] Human: Agreed to SemVer
- [x] AI: Confirmed suitability for teaching/reference skill

---

## Supporting Materials

### NOT: Versioning Semantics for This Skill

Teaching skills are different from code:
- **Breaking change** means: incompatible interpretation of theory
- **Minor change** means: enhanced understanding, new examples
- **Patch** means: corrections, clarifications

This differs from API versioning where MAJOR = breaking API changes.

### NOT: Git Tag Format

Use `v` prefix for tags:
- ✅ `v1.0.0`, `v1.1.0`, `v2.0.0`
- ❌ `1.0.0` (no prefix)
- ❌ `release-1.0.0` (too verbose)

Rationale: Standard Git convention, CI parsing is easier

---

## Iterations

### Iteration 1 (2026-02-27)
- Human: Expressed preference for SemVer based on AI recommendation
- AI: Analyzed options, confirmed SemVer suitability
- AI: Defined increment rules specific to teaching skill
- AI: Specified implementation locations
- Outcome: SemVer adopted with initial version 1.0.0

---

## Links

- Supersedes: Initial conversation preference for SemVer
- Related: ADR-0001 (Skill Packaging Format)
- Related: ADR-0003 (License File Structure) - to be created
- Reference: [Semantic Versioning](https://semver.org/)
