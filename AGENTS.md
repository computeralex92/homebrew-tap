# AGENTS.md — Homebrew Tap

Personal Homebrew tap at `computeralex92/homebrew-tap`.

## Workflow

- Develop on feature branches, merge to `main` via PR.
- CI runs on every PR and on push to `main`. Manual runs via `workflow_dispatch` with `formula` input.
  ```sh
  gh workflow run tests.yml --ref main -f formula=fleetctl
  ```
- Do **not** push directly to `main`.

## CI / bottle pipeline (`tests.yml`)

- Both jobs start with `actions/checkout` (`fetch-depth: 0`) — required for `git diff` to work.
- **Formula detection** is centralized in a `Determine changed formulae` step that outputs `steps.formulae.outputs.formulae`:
  - **PR**: `git diff origin/${{ github.base_ref }}...HEAD -- Formula/`
  - **Push**: `git diff HEAD~1 -- Formula/`
  - **workflow_dispatch**: uses `inputs.formula` directly
- **PR**: runs `brew test-bot --only-formulae <name> --root-url=...` (no `--publish`), uploads artifacts.
- **Push / workflow_dispatch**: runs `brew test-bot --only-formulae <name> --root-url=... --publish`, uploads artifacts.
- **merge-commit** job (macOS only, runs after `test-bot`):
  - Downloads all bottle artifacts (`bottles_*`).
  - Merges bottle JSONs via `brew bottle --merge --write --no-commit`.
  - Extracts formula name from `git diff HEAD~1`.
  - Commits and pushes with a 3-retry loop to handle race conditions.

## Structure

- `Formula/<name>.rb` — formula files (Ruby DSL)
- `Casks/<name>.rb` — casks (not yet used)
- `.github/workflows/tests.yml` — CI: brew test-bot on ARM Mac + Linux
- `.github/renovate.json` — Renovate config (extends `config:recommended`)

**Note:** `auto-approve.yml` was deleted (obsolete) — Renovate uses `platformAutomerge` instead.

## Local testing

```sh
git checkout -b <branch>
# make changes
brew tap computeralex92/tap "$PWD"      # register the local checkout as a tap
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
- Only ARM macOS (macos-26) and Linux CI runners are used; Intel macOS was dropped.
- Go is a build dependency; bottles are built by `brew test-bot` in CI and published on push to `main`.
- `fleetctl --version` triggers go-prompt history init (`~/.goquery/history`) which fails in brew test sandbox. Use `assert_predicate bin/"fleetctl", :executable?` in tests to avoid this.

## Conventions

- Follow Homebrew's Ruby style: two-space indent, no tabs, no trailing whitespace.
- Every formula must have `desc`, `homepage`, `url`, `sha256`, `version` (or inferred from URL), and `license`.
- Build from Go source using `depends_on "go" => :build` and `std_go_args`.
- Keep `brew audit` clean; suppress only unavoidable warnings with an inline comment.
