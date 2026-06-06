# AGENTS.md — Homebrew Tap

Personal Homebrew tap at `computeralex92/homebrew-tap`.

## Structure

- `Formula/<name>.rb` — formula files (Ruby DSL)
- `Casks/<name>.rb` — casks (not yet used)
- No formula files exist yet; add them as needed.

## Commands

```sh
brew install computeralex92/tap/<formula>
brew install Formula/<name>.rb        # test locally from path
```

## Conventions

- Follow Homebrew's Ruby style: two-space indent, no tabs, no trailing whitespace.
- Use `brew style Formula/<name>.rb` to lint a formula.
- Run `brew audit --strict --online Formula/<name>.rb` before committing new formulas.
- Every formula must have a `desc`, `homepage`, `url`, `sha256`, `version` (or use `url`-inferred), and a `bottle :unneeded` or bottle block.
- `url` should point to GitHub releases tarballs or rubygems; prefer source over prebuilt when possible.
- For `go` or `node` based tools, use the appropriate resource/.build patterns (e.g., `go_resource`, `resource` blocks for npm deps).
- Keep `brew audit` clean; suppress only unavoidable warnings with an inline comment.
- `brew test Formula/<name>.rb` to run a formula's test block.
