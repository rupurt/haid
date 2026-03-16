# AGENTS.md

Shared guidance for AI agents working with this repository.

## Operational Lifecycle

1. **Bootstrap**: `nix develop` followed by `keel init` (if new) and `keel doctor`.
2. **Execution**: Follow the **[INSTRUCTIONS.md](INSTRUCTIONS.md)** for Mission, Planning, and Delivery loops.
3. **Finalize**: `keel doctor` must show a healthy heartbeat before any final synthesis.

## Foundational Documents

These define the binding constraints and workflow:

- `INSTRUCTIONS.md` — canonical workflow and operational guidance.
- `ARCHITECTURE.md` — current system architecture and component boundaries.
- `CONFIGURATION.md` — runtime, build, and environment configuration guidance.
- `EVALUATIONS.md` — evaluation datasets and methodology.
- `RELEASE.md` — release-readiness and distribution status.
- `README.md` — repository intent and product positioning.
- `flake.nix` — Nix development environment and shared tooling.

## Project Overview

This repository is `haid` — a "hearing aid" for agentic coding environments like Claude Code, Codex, and Gemini. 

`haid` provides a single, local executable that allows agents to search, recommend, and extract information from local codebases without the overhead of shipping entire corpora to remote LLMs. It embeds `sift` as its core retrieval engine.

### Core Commands

| Path | Purpose |
|------|---------|
| `nix develop` | repository shell and shared tooling |
| `keel ...` | planning, execution, and verification |
| `just search` | run a local search |
| `just test` | run the full verification suite (fmt, clippy, nextest) |

### Board Directory (`.keel/`)

| Path | Contents |
|------|----------|
| `.keel/adrs/` | architecture decision records |
| `.keel/epics/` | strategic planning and PRDs |
| `.keel/missions/` | long-running objectives and charters |
| `.keel/stories/` | implementable units and evidence |
