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

- On **PR**: `brew test-bot --only-formulae` detects changed formulae, builds bottles, uploads as artifacts.
- On **push to main** (merge commit): extracts formula name via `git diff HEAD~1`, runs `brew test-bot --only-formulae <formula> --publish`.
- On **workflow_dispatch**: uses `formula` input, runs same publish command.
- After publish, **macOS runner only** commits the bottle block to the repo via `git commit + push`.
- Linux runner's bottle is uploaded to registry but *not* committed (race condition prevention). If both platforms need bottle blocks, run twice or merge manually.
- Use `--only-formulae <formula>` explicitly (not relying on git diff) because `origin/main == HEAD` on push events.

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
