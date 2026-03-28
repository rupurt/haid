# AGENTS.md

Shared guidance for AI agents working with haid.

## Downstream Contract

This repository uses Keel as its project-management engine. This file is downstream from Keel and should remain recognizable when upstream engine guidance changes.

`AGENTS.md` and `INSTRUCTIONS.md` are the sync-sensitive files in this repo. When you absorb a newer Keel version, preserve the `PROJECT-SPECIFIC` blocks instead of rewriting the whole file from memory.

## Operational Lifecycle

1. **Bootstrap**: Enter `nix develop`. If the repo does not already have `keel.toml` and `.keel/`, scaffold it with `keel new .`. Use `just keel doctor` to confirm the board is coherent before delivery work.
2. **Execution**: Follow the repo turn loop and hygiene rules in [INSTRUCTIONS.md](INSTRUCTIONS.md).
3. **Finalize**: `just keel doctor --status` and `just keel flow --scene` should reflect a coherent board before final synthesis.

## Read This First

1. `INSTRUCTIONS.md` for the repo's procedural turn loop and exact command surface.
2. `CONSTITUTION.md` for collaboration philosophy and product constraints.
3. `ARCHITECTURE.md`, `CONFIGURATION.md`, and `README.md` for system and runtime context.
4. `just keel turn`, `just keel mission next --status`, and `just keel doctor --status` for the live board state.

## Core Principles

- Use Keel as the canonical planning and lifecycle surface.
- Prefer explicit proof over chat-only claims.
- Close loop debt with sealing commits instead of leaving dirty work behind.
- Escalate only when the work requires human product, design, or behavior judgment.

## Canonical Turn Loop

Keel's operator rhythm is the `Orient -> Inspect -> Pull -> Ship -> Close` loop surfaced by `keel turn`.

- **Orient**: Inspect charge and board stability with `just keel heartbeat`, `just keel health --scene`, `just keel flow --scene`, and `just keel doctor`.
- **Inspect**: Read current demand with `just keel mission next --status`, `just keel pulse`, `just keel roles`, and `just keel next --role <role> --explain` when routing is unclear.
- **Pull**: Select one role-scoped slice with `just keel next --role <role>`.
- **Ship**: Execute the slice, record proof, and advance lifecycle state.
- **Close**: Land the relevant transition and the sealing commit that clears open-loop energy.

### Session Start & Human Interaction

When a human user opens the chat or pokes the repo, immediately perform the `Orient` and `Inspect` halves of the turn loop by following the **Human Interaction & Pokes** workflow in [INSTRUCTIONS.md](INSTRUCTIONS.md):

1. **Heartbeat**: Run `just keel heartbeat` to inspect current charge and whether the worktree is carrying uncommitted energy.
2. **Pulse**: Run `just keel health --scene` to check subsystem stability.
3. **Scan**: Run `just keel mission next --status` and `just keel pulse`.
4. **Confirm**: Run `just keel flow --scene` to verify whether the light is on or the board is idle waiting for fresh repository activity.
5. **Diagnose**: Run `just keel doctor` to ensure board integrity before proceeding.

## Keel Upgrade Workflow

When updating the pinned `keel` version for this repository, use this sequence:

1. **Update The Nix Pin**: Change the flake input that pins `keel`, then refresh `flake.lock` in the same change slice.
2. **Build The New Version**: Enter `nix develop` and confirm the new binary resolves from the dev shell before touching board state.
3. **Diff And Sync The Contract**: Compare upstream `AGENTS.md` and `INSTRUCTIONS.md`, absorb new engine guidance, and preserve the `PROJECT-SPECIFIC` seams that describe this repo.
4. **Refresh Hooks And Re-run Board Surfaces**: Use `just keel hooks install`, then run `just keel heartbeat`, `just keel doctor`, `just keel flow --scene`, `just keel mission next --status`, and `just keel pulse`.
5. **Ask Before Executing Suggested Work**: After the upgrade settles, summarize `just keel mission next --status` for the user and ask before executing any newly recommended mission work.
6. **Commit After Verification**: Once the upgrade and contract sync are coherent, land one atomic Conventional Commit that captures the toolchain and board changes together.

## Project-Specific Conventions

<!-- BEGIN PROJECT-SPECIFIC -->
- Start work from `nix develop`; the pinned `keel`, Rust toolchain, and cargo helpers live there.
- Use `just keel ...` for board operations, `just build` / `just quality` / `just test` for repo verification, and `just search`, `just recommend`, or `just eval` for product-facing CLI evidence.
- Keep the root Markdown docs truthful about `haid` as a local retrieval CLI. When syncing from upstream Keel, preserve the repo overview, command table, and any local proof expectations.
<!-- END PROJECT-SPECIFIC -->

## Project Overview

This repository is `haid` — a "hearing aid" for agentic coding environments like Claude Code, Codex, and Gemini.

`haid` provides a single, local executable that lets agents search, recommend, and evaluate information in local codebases without shipping entire corpora to a remote model. It embeds `sift` as its core retrieval engine.

### Core Commands

| Path | Purpose |
|------|---------|
| `nix develop` | Repository shell and pinned tooling |
| `just keel ...` | Planning, execution, and verification |
| `just build` | Build the CLI |
| `just quality` | Run formatting and clippy |
| `just test` | Run the test suite |
| `just search <path> <query>` | Exercise local search |
| `just recommend <path>` | Exercise recommendation flow |
| `just eval` | Run evaluation suites |

### Board Directory (`.keel/`)

| Path | Contents |
|------|----------|
| `.keel/adrs/` | Architecture decision records |
| `.keel/bearings/` | Research artifacts and evidence |
| `.keel/epics/` | Strategic planning documents |
| `.keel/missions/` | Long-running objectives and charters |
| `.keel/stories/` | Implementable units and evidence |
| `.keel/routines/` | Scheduled strategic work |
| `.keel/knowledge/` | Reusable institutional memory |

## Foundational Documents

These define the binding constraints and workflow:

- `CONSTITUTION.md` — collaboration philosophy and non-negotiable product constraints.
- `INSTRUCTIONS.md` — canonical workflow and operating surface.
- `ARCHITECTURE.md` — current system architecture and component boundaries.
- `CONFIGURATION.md` — runtime, build, and environment configuration guidance.
- `EVALUATIONS.md` — evaluation datasets and methodology.
- `RELEASE.md` — release-readiness and distribution status.
- `README.md` — repository intent and product positioning.
- `flake.nix` — Nix development environment and shared tooling.
- `keel.toml` — Keel workflow topology and board configuration.

## Decision Resolution Hierarchy

When faced with ambiguity, resolve decisions in this descending order:

1. **ADRs**: Binding architectural constraints in `.keel/adrs/` when present.
2. **CONSTITUTION**: The philosophy and product constraints in `CONSTITUTION.md`.
3. **ARCHITECTURE**: Source layout and technical boundaries.
4. **CONFIGURATION**: Runtime and environment contracts.
5. **PLANNING**: Mission, epic, voyage, and story artifacts for the active work.

## Sync Notes

- Upstream source: Keel's `AGENTS.md`
- Preserve the `PROJECT-SPECIFIC` block above during syncs.
- Push detailed workflow rules into `INSTRUCTIONS.md`, not this file.
