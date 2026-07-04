# AGENTS.md — Homebrew Tap

Personal Homebrew tap at `computeralex92/homebrew-tap`.

## Workflow

- Develop on feature branches, merge to `main` via PR.
- CI runs on every PR and on push to `main`. Manual runs via `workflow_dispatch` with `formula` input.
  ```sh
  gh workflow run tests.yml --ref main -f formula=fleetctl
  ```
- Do **not** push directly to `main`.

## CI pipeline (`tests.yml`)

- Matrix with 3 runners: `macos-26` (macOS ARM), `macos-26-intel` (macOS Intel), `ubuntu-24.04` (Linux x86_64).
- `fail-fast: false` so other arches continue if one fails.
- Starts with `actions/checkout` (`fetch-depth: 0`) — required for `git diff`.
- **Formula detection**: outputs `steps.formula.outputs.formula`:
  - **PR**: `git diff origin/${{ github.base_ref }}...HEAD -- Formula/`
  - **Push**: `git diff HEAD~1 -- Formula/`
  - **workflow_dispatch**: uses `inputs.formula` directly
- On PR: runs `brew test-bot --only-formulae <name> --root-url=...` (test only).
- On push / workflow_dispatch: also runs `brew test-bot --only-formulae <name> --root-url=... --publish` (test + publish bottles).
- Uses `HOMEBREW_DOCKER_REGISTRY_TOKEN` (base64-encoded `GITHUB_TOKEN`) for publishing.

## Auto-bump pipeline (`bump.yml`)

- Runs daily at 06:00 UTC and on `workflow_dispatch`.
- Uses `Homebrew/actions/bump-packages` which calls `brew bump --open-pr` under the hood.
- Auto-detects new versions via `livecheck` — no manual version comparison needed.
- With `fork: false`, commits and opens a PR directly in this repo.
- Commits use a dedicated bot identity (`computeralex92-bot` / `computeralex92+bot@users.noreply.github.com`) to distinguish pipeline commits from manual ones.
- After creating a PR, auto-merge (`--squash`) is enabled so the PR merges as soon as CI passes.
- For auto-merge to wait for CI, all three matrix jobs (`test (macos-26)`, `test (macos-26-intel)`, `test (ubuntu-24.04)`) must be configured as **required checks** in branch protection rules on `main`.
- Manual trigger: `gh workflow run bump.yml --ref main`

## Structure

- `Formula/<name>.rb` — formula files (Ruby DSL)
- `.github/workflows/tests.yml` — CI
- `.github/renovate.json` — Renovate config (GitHub Actions updates only; Homebrew disabled)
- `.github/workflows/bump.yml` — Scheduled auto-bump via `brew bump-formula-pr`

## Local testing

```sh
git checkout -b <branch>
# make changes
brew tap computeralex92/tap "file://$PWD"  # register the local checkout as a tap
brew style Formula/<name>.rb            # lint (still accepts file paths)
brew audit --strict --online computeralex92/tap/<name>  # audit by tap name
brew test computeralex92/tap/<name>     # test after installing
brew install computeralex92/tap/<name>  # install locally
git add -A && git commit -m "..."
git push -u origin <branch>
# open PR via https://github.com/computeralex92/homebrew-tap/pulls
```

**Known quirks:**
- `brew audit [path]` is disabled — always use `computeralex92/tap/<name>` syntax.
- `brew install Formula/<name>.rb` is also disabled — tap the local dir first.
- Uses prebuilt CLI binaries from Fleet's GitHub releases (no Go build dependency).
- `fleetctl --version` triggers go-prompt history init (`~/.goquery/history`) which fails in brew test sandbox. Use `assert_predicate bin/"fleetctl", :executable?` in tests to avoid this.

## Conventions

- Follow Homebrew's Ruby style: two-space indent, no tabs, no trailing whitespace.
- Every formula must have `desc`, `homepage`, `url`, `sha256`, and `license`.
- Use prebuilt binaries from GitHub releases (macOS universal, Linux amd64, Linux arm64).
- Keep `brew audit` clean; suppress only unavoidable warnings with an inline comment.
