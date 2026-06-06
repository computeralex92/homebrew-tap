# AGENTS.md — Homebrew Tap

Personal Homebrew tap at `computeralex92/homebrew-tap`.

## Structure

- `Formula/<name>.rb` — formula files (Ruby DSL)
- `Casks/<name>.rb` — casks (not yet used)
- `.github/workflows/ci.yml` — CI: style + audit on push/PR touching `Formula/` or `Casks/`
- `.github/renovate.json` — Renovate config (extends `config:recommended`)

## Local testing

```sh
brew tap computeralex92/tap "$PWD"      # register the local checkout as a tap
brew style Formula/<name>.rb            # lint (still accepts file paths)
brew audit --strict --online computeralex92/tap/<name>  # audit by tap name
brew test computeralex92/tap/<name>     # test after installing
brew install computeralex92/tap/<name>  # install locally
```

**Known quirks:**
- `brew audit [path]` is disabled — always use `computeralex92/tap/<name>` syntax.
- `brew install Formula/<name>.rb` is also disabled — tap the local dir first.
- Prebuilt Go binaries with universal Mach-O (x86_64 + arm64 in one binary) need no arch-specific conditionals.
- `fleetctl --version` exits 0 in shell but its startup log line can interfere with `shell_output`; redirect stderr via `2>&1` in test blocks.

## Conventions

- Follow Homebrew's Ruby style: two-space indent, no tabs, no trailing whitespace.
- Every formula must have `desc`, `homepage`, `url`, `sha256`, `version` (or inferred from URL), and `license`.
- `url` should point to GitHub releases tarballs or rubygems; prefer source over prebuilt when possible.
- For Go or Node tools, use the appropriate resource/build patterns (`go_resource`, `resource` blocks).
- Keep `brew audit` clean; suppress only unavoidable warnings with an inline comment.
