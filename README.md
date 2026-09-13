# computeralex92/homebrew-tap

[![CI](https://github.com/computeralex92/homebrew-tap/actions/workflows/tests.yml/badge.svg)](https://github.com/computeralex92/homebrew-tap/actions/workflows/tests.yml)
[![License](https://img.shields.io/github/license/computeralex92/homebrew-tap)](LICENSE)
[![Last commit](https://img.shields.io/github/last-commit/computeralex92/homebrew-tap)](https://github.com/computeralex92/homebrew-tap/commits/main)
[![Repo size](https://img.shields.io/github/repo-size/computeralex92/homebrew-tap)](https://github.com/computeralex92/homebrew-tap)
[![Renovate](https://img.shields.io/badge/renovate-enabled-brightgreen?logo=renovate)](https://docs.renovatebot.com)

Personal Homebrew tap.

## Usage

```sh
brew tap computeralex92/tap
brew trust --formula computeralex92/tap/fleetctl
brew trust --formula computeralex92/tap/ingress-nginx-migration
brew install fleetctl
brew install ingress-nginx-migration
```

Or directly (trusts only the formula being installed):

```sh
brew install computeralex92/tap/fleetctl
brew install computeralex92/tap/ingress-nginx-migration
```

> **Note:** Homebrew 6.0.0+ requires non-official taps to be explicitly trusted
> before their code is loaded. Installing a fully qualified formula
> (`user/tap/formula`) trusts only that formula; installing by short name after
> `brew tap` requires `brew trust` first. To trust the whole tap instead, run
> `brew trust computeralex92/tap`.

## Available formulae

| Formula | Description |
|---------|-------------|
| `fleetctl` | CLI tool for Fleet Device Management |
| `ingress-nginx-migration` | Tool to migrate from ingress-nginx to Traefik |

## Disclaimers

This repository is a personal project and is **not affiliated with, endorsed by, or sponsored by any of the upstream projects.** Formulae reference official binaries from their respective projects, which are the property of their respective owners.

This repository was created with assistance from [OpenCode](https://opencode.ai), an AI-powered coding assistant.
