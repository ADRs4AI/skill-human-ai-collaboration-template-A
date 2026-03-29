# ADR-0002: Versioning Strategy

- **Date**: 2026-02-27
- **Iteration**: 2 (Rewritten 2026-03-29)
- **Status**: Accepted
- **Deciders**: Jérémie Lumbroso, Claude Code Sonnet 4.5

---

## Context

Skills need a versioning system that:
1. Communicates compatibility and changes clearly
2. Enables automated release management
3. Works well with Git tags and GitHub Releases
4. Follows community standards

---

## Decision

### Chosen: Semantic Versioning (SemVer)

**Format**: `MAJOR.MINOR.PATCH` (e.g., `1.0.0`, `1.1.0`, `2.0.0`)

**Increment rules for skills**:

- **MAJOR**: Breaking changes to skill principles or behavior
  - Example: Fundamentally different approach to the skill's domain
  - Example: Removing core concepts or techniques
  - Example: Changing skill invocation behavior in incompatible ways
  - Example: Restructuring that makes previous guidance obsolete

- **MINOR**: New examples, enhanced explanations, additional concepts
  - Example: Adding new example files or use cases
  - Example: Expanding existing sections with more detail
  - Example: Adding new but related techniques or guidance
  - Example: New subskills in resources/ directory

- **PATCH**: Fixes, typos, clarifications, formatting
  - Example: Fixing typos or grammatical errors
  - Example: Improving code examples for clarity
  - Example: Better formatting of markdown
  - Example: Fixing broken links or references

**Initial version**: `1.0.0`
- Rationale: Use 1.0.0 when skill is complete and functional, ready for production use
- Alternative: Start at 0.1.0 for early/experimental skills, bump to 1.0.0 when stable

---

## Alternatives Considered

### Option A: Date-Based Versioning (2026.02.27)
- **Pros**: Clear temporal ordering, simple to generate
- **Cons**: No semantic information about changes, harder to assess compatibility
- **Verdict**: Less suitable for teaching skills where content stability matters

### Option B: Hybrid (1.0-20260227)
- **Pros**: Both semantic and temporal information
- **Cons**: More complex, non-standard format
- **Verdict**: Unnecessary complexity for most use cases

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
   - Release title: `v1.0.0 - Your Skill Name`
   - Asset name: `your-skill-name-1.0.0.skill`

4. **ZIP filename** (packaged skill):
   - Format: `your-skill-name-{version}.skill`
   - Example: `your-skill-name-1.0.0.skill`

### Version Bumping Process

**Manual (recommended initial approach)**:
1. Decide change type (major/minor/patch)
2. Update version in SKILL.md
3. Commit: `chore: bump version to X.Y.Z`
4. Tag: `git tag vX.Y.Z`
5. Push: `git push && git push --tags`
6. CI creates release automatically

**Future automation options**:
- Conventional commits + auto-bump
- Manual workflow dispatch with version input
- Not implementing now - YAGNI (You Aren't Gonna Need It)

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

**v1.0.0** → Initial release
**v1.0.1** → Fix typo in explanation or example
**v1.1.0** → Add new example or expand existing section
**v1.2.0** → Add new subskill in resources/
**v2.0.0** → Restructure around different framework or remove core concepts

---

## Action Items

- [x] Decide on SemVer format - Owner: Template designers
- [ ] Set initial version in SKILL.md - Owner: Skill builder
- [ ] Document versioning rules in CONTRIBUTING.md - Owner: Skill builder
- [ ] Configure CI/CD to use version from git tags - Owner: Skill builder

---

## Validation

- [x] Decision matches community standards (SemVer)
- [x] Format works with Git tags and GitHub Releases

---

## Supporting Materials

### NOT: Versioning Semantics for Skills

Teaching skills are different from code libraries:
- **Breaking change** means: incompatible interpretation or methodology
- **Minor change** means: enhanced understanding, new examples, additional techniques
- **Patch** means: corrections, clarifications, formatting

This differs from API versioning where MAJOR = breaking API changes. For skills, "breaking" means the guidance fundamentally changes or contradicts previous versions.

### NOT: Git Tag Format

Use `v` prefix for tags:
- ✅ `v1.0.0`, `v1.1.0`, `v2.0.0`
- ❌ `1.0.0` (no prefix)
- ❌ `release-1.0.0` (too verbose)

Rationale: Standard Git convention, CI parsing is easier

---

## Iterations

### Iteration 1 (2026-02-27)
- Human: Expressed preference for SemVer
- AI: Analyzed options, confirmed SemVer suitability for skills
- AI: Defined increment rules specific to teaching/guidance skills
- AI: Specified implementation locations
- Outcome: SemVer adopted with initial version 1.0.0 recommendation

### Iteration 2 (2026-03-29) - Template Transformation
- AI: Rewrote ADR generically for skill-building template
- Removed skill-specific examples
- Used placeholder `your-skill-name` throughout
- Preserved all decisions and increment rules
- Clarified that increment rules apply to teaching/guidance skills generally

---

## Links

- Related: ADR-0001 (Skill Packaging Format)
- Reference: [Semantic Versioning](https://semver.org/)
