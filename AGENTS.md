# AGENTS.md — Homebrew Tap

Personal Homebrew tap at `computeralex92/homebrew-tap`.

## Workflow

- Develop on feature branches, merge to `main` via PR.
- CI runs on every PR and on push to `main`. Manual runs via `workflow_dispatch`.
- Do **not** push directly to `main`.

## Renovate auto-update flow

Formulas build from Go source (single URL + SHA), so Renovate can auto-update.

1. Renovate opens a PR with the version + SHA bump.
2. `tests.yml` runs `brew test-bot` on ARM macOS and Linux, which compiles the formula and builds bottles.
3. On CI success, `auto-label-pr-pull.yml` adds the `pr-pull` label.
4. `publish.yml` triggers on the label and runs `brew pr-pull`, which pulls the bottle artifacts from CI and merges everything into `main` (via a merge commit that includes both the formula change and the bottle revisions).
5. The PR branch is deleted automatically.

For human PRs that modify a formula: CI will fail with a reminder to add the `pr-pull` label manually after tests pass.

## Structure

- `Formula/<name>.rb` — formula files (Ruby DSL)
- `Casks/<name>.rb` — casks (not yet used)
- `.github/workflows/tests.yml` — CI: brew test-bot on ARM Mac + Linux
- `.github/workflows/publish.yml` — `brew pr-pull` for labeled PRs
- `.github/workflows/auto-approve.yml` — auto-approves Renovate PRs
- `.github/renovate.json` — Renovate config (extends `config:recommended`, adds `pr-pull` label)

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
- Go is a build dependency; bottles are built by `brew test-bot` in CI and published via `pr-pull`.
- `fleetctl --version` triggers go-prompt history init (`~/.goquery/history`) which fails in brew test sandbox. Use `assert_predicate bin/"fleetctl", :executable?` in tests to avoid this.

## Conventions

- Follow Homebrew's Ruby style: two-space indent, no tabs, no trailing whitespace.
- Every formula must have `desc`, `homepage`, `url`, `sha256`, `version` (or inferred from URL), and `license`.
- Build from Go source using `depends_on "go" => :build` and `std_go_args`.
- Keep `brew audit` clean; suppress only unavoidable warnings with an inline comment.
