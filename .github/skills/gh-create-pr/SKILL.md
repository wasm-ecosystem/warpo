---
name: gh-create-pr
description: "Create GitHub pull requests with gh CLI using enforced title format, feature/fix-focused body structure, and issue linking rules (`close #<n>` or `related to #<n>`). Use when opening or updating PRs in this repository."
argument-hint: "Provide title type/domain, summary, and optional issue numbers with relation (close/related)."
---

# Create PR With gh

## When to Use

- Open a new PR from the current branch with a compliant title.
- Prepare a clear PR body that emphasizes high-level intent and architecture.
- Enforce issue linkage language consistency (`close #<issue_number>` vs `related to #<issue_number>`).

## Inputs

- `type`: one of `feat`, `fix`, `break`, `chore`
- `domain`: scope in parentheses in title, for example `frontend`, `optimizer`, `driver`
- `title-summary`: short summary after `: `
- `pr-kind`: either `feature` or `bug-fix`
- `what-changed`: high-level purpose of the change
- `how-implemented`: high-level algorithm or architecture description
- `issues` (optional): list of issue numbers with relation type

## Type Definitions

- `feat`: new feature
- `fix`: bug fix
- `break`: breaking change
- `chore`: refactor/CI/test/... NFC changing

## Procedure

1. Validate title format before creating the PR.
   The title must match this regex:
   `/^(feat|fix|break|chore)\([^)]+\): .+$/`

2. Build a title string.
   Use:
   `<type>(<domain>): <title-summary>`

3. Build PR body based on change kind.
   For `feature`, include:
   - What this feature is for
   - How this feature is implemented (high-level algorithm/architecture)

   For `bug-fix`, include:
   - What bug category or behavior is fixed
   - How the fix works at a high level

4. Add issue references when provided.
   - If the issue will be closed after this PR is merged, add: `close #<issue_number>`
   - If the PR is related but not closing the issue, add: `related to #<issue_number>`

5. Choose and copy a template:
   - Feature: `./assets/feature-pr-body-template.md`
   - Bug fix: `./assets/bugfix-pr-body-template.md`

6. Create a writable temp file for PR body under `.vscode/pr/`.
   This avoids permission limitations when writing inside `.github/skills/...`.
   Example commands:

```bash
mkdir -p ./.vscode/pr
cp ./.github/skills/gh-create-pr/assets/feature-pr-body-template.md \
  ./.vscode/pr/pr-body.md
```

7. Create the PR with gh using the temp file.
   Example command:

```bash
gh pr create \
  --title "feat(optimizer): reduce redundant layout passes" \
  --body-file ./.vscode/pr/pr-body.md
```

8. Open the new PR in browser.
   Run:
   `gh pr view --web`

9. Verify result.
   - Confirm title regex compliance.
   - Confirm body includes required `feature` or `bug-fix` sections.
   - Confirm each related issue line uses only `close #...` or `related to #...`.

## Practical gh Workflow

- Check auth status first:

```bash
gh auth status
```

- If needed, authenticate and select GitHub.com:

```bash
gh auth login
```

- Confirm current branch before PR creation:

```bash
git branch --show-current
```

- Push branch and set upstream (common first-time step):

```bash
git push -u origin "$(git branch --show-current)"
```

- Create a draft PR first when work is not ready for review:

```bash
gh pr create --draft --title "feat(domain): summary" --body-file ./.vscode/pr/pr-body.md
```

- Open the created PR in browser:

```bash
gh pr view --web
```

- Edit title/body later without recreating PR:

```bash
gh pr edit --title "fix(driver): adjust pipeline order" --body-file ./.vscode/pr/pr-body.md
```

- Check PR status and CI summary:

```bash
gh pr status
gh pr checks
```

## Body Templates

### Feature Template

```md
## What

This feature is for <target user/problem/workflow>.

## How

Implemented using <high-level architecture/algorithm>.

## Issues

close #123
or
related to #456
```

### Bug-fix Template

```md
## Bug

Fixes <bug type/behavioral issue at high level>.

## Fix Approach

Resolved by <high-level strategy/change in architecture or flow>.

## Issues

close #123
or
related to #456
```

## Notes

- Keep explanations at architectural level; avoid low-level implementation noise unless necessary.
- If no issues apply, omit the `Issues` section.
- For each issue, use either `close #<issue_number>` (only when merging this PR closes it) or `related to #<issue_number>`, not both.

## Troubleshooting (Common)

- Error: `authentication required` or `HTTP 401`.
  Run `gh auth status`; if not logged in, run `gh auth login` and retry.

- Error: `no git remotes found` or wrong remote target.
  Verify remotes with `git remote -v`.
  Ensure `origin` points to the correct repository before running `gh pr create`.

- Error: `aborted: you must first push the current branch`.
  Push with upstream:
  `git push -u origin "$(git branch --show-current)"`.

- Error: PR created against wrong base branch.
  Create with explicit base:
  `gh pr create --base main ...`
  Or update existing PR base:
  `gh pr edit --base main`.

- Error: title does not match repository convention.
  Re-run with valid format:
  `<type>(<domain>): <summary>` where type is `feat|fix|break|chore`.

- Error: `GraphQL` permission/repository access denied.
  Confirm repo visibility and token scopes.
  Re-authenticate with `gh auth login` and ensure account has PR permissions.

- Need to recover from bad PR body content.
  Save corrected text to a local file, then run:
  `gh pr edit --body-file ./.vscode/pr/pr-body.md`.

- Need to link issue correctly after PR already exists.
  Update PR description and keep only one style per issue line:
  `close #<n>` or `related to #<n>`.
