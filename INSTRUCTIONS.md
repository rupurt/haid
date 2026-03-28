# INSTRUCTIONS.md

Procedural instructions and workflow guidance for humans and agents working with haid through Keel.

## Downstream Contract

This file is downstream from Keel and should keep the engine's turn-loop discipline recognizable while describing how haid actually operates.

When syncing from a newer Keel version, preserve the `PROJECT-SPECIFIC` block instead of re-authoring the local operating surface from scratch.

## The Turn Loop

`keel turn` is the canonical reference surface for the `Orient -> Inspect -> Pull -> Ship -> Close` rhythm. Every session follows this deterministic cycle:

1. **Orient**: Run `just keel heartbeat`, `just keel health --scene`, `just keel flow --scene`, and `just keel doctor`. This tells you whether the board is energized, healthy, and structurally coherent.
2. **Inspect**: Run `just keel mission next --status` and `just keel pulse`. If routing is unclear, inspect `just keel roles` or `just keel next --role <role> --explain`.
3. **Pull**: Choose the correct lane and role (`manager`, `operator`, or a configured role family) and pull exactly one slice of work.
4. **Ship**: Execute the move, record proof while the work is fresh, and land the relevant lifecycle transition (`story submit`, `voyage plan`, `bearing lay`, and so on).
5. **Close**:
   - Record the move in the mission `LOG.md`.
   - **Heartbeat Check**: Use `just keel heartbeat` if you need to inspect the current activity source or confirm the circuit is still energized before the commit boundary.
   - **Commit**: Execute `git commit`. The installed hooks run `just quality`, `just test`, and append `doctor --status` to the commit message. Resolve any issues if the commit is rejected.
6. **Re-orient**: After the commit lands, run `just keel doctor --status` and `just keel flow --scene` to see what the board needs next. If the delivery lane still has ready work, start the next turn immediately.

## Repo-Specific Turn Surfaces

<!-- BEGIN PROJECT-SPECIFIC -->
- Bootstrap with `nix develop`. If `keel.toml` or `.keel/` is missing, run `keel new .` before relying on board commands.
- Use `just build` for a debug compile, `just quality` for `cargo fmt --check` and `cargo clippy -- -D warnings`, and `just test` for `cargo nextest run --no-tests pass`.
- Use `just search <path> <query>`, `just recommend <path>`, and `just eval` as the product-facing proof surfaces for retrieval, ranking, and evaluation changes.
- Use `just keel ...` for board work so the repo follows the active Keel workflow surface from the dev shell.
<!-- END PROJECT-SPECIFIC -->

## Primary Workflows

### Operator (Implementation)

Focus on evidence-backed delivery.

- **Context**: `just keel story show <id>`, `just keel voyage show <id>`, and `just keel next --role operator`
- **Action**: Implement requirements, record proofs with `just keel story record`, and submit
- **Constraint**: Every acceptance criterion needs proof

### Manager (Planning)

Focus on strategic alignment and unblocking.

- **Context**: `just keel epic show <id>`, `just keel roles`, `just keel next --role manager --explain`, and `just keel flow`
- **Action**: Author `PRD.md`, `SRS.md`, and `SDD.md`; resolve routing; decompose stories; and attach mission children explicitly with `just keel mission attach <mission-id> --epic <epic-id>`, `--bearing <bearing-id>`, or `--adr <adr-id>`
- **Constraint**: Move voyages from `draft` to `planned` only when requirements are coherent

### Explorer (Research)

Focus on technical discovery and fog reduction.

- **Context**: `just keel bearing list`
- **Action**: Fill `BRIEF.md`, collect `EVIDENCE.md`, and assess
- **Constraint**: Graduate to epics only when research is conclusive

## Human Interaction & Pokes

Keel's autonomous flow is governed by a physical battery metaphor, but the charge is derived from real repository activity rather than a synthetic wake file.

If a human user pokes you (for example, "I'm poking you" or "Wake up"), you MUST:

1. **Orient**: Execute `just keel heartbeat`, `just keel health --scene`, `just keel flow --scene`, and `just keel doctor`.
2. **Inspect**: Run `just keel mission next --status` and `just keel pulse` to identify any new work that has become ready or materialized.
3. **Route if Needed**: Use `just keel roles` or `just keel next --role <role> --explain` when lane selection or queue behavior needs clarification.

## Autonomous Backlog Discharge

As long as the system is **AUTONOMOUS (LIGHT ON)** and the circuit is healthy, you are responsible for discharging the delivery backlog during the `Pull` and `Ship` phases of the turn loop.

1. **Identify Ready Work**: Scan the delivery lane for stories in `backlog` that are not blocked by dependencies.
2. **Autonomous Start**: For each ready story, execute `just keel story start <id>`.
3. **Rube Goldberg Loop**: Transitioning a story to `in-progress` mutates the repository, which refreshes the derived heartbeat and keeps the circuit closed while you continue moving work.
4. **Priority**: Discharging the backlog is the primary tactical objective once energized. Continue until the backlog is empty or the circuit trips.
5. **Loop Closure**: After every successful implementation or transition, land a sealing commit that captures the resulting board and code changes. This applies to all work, including storyless gardening or engine changes. The pacemaker warning is cleared by committing the dirty worktree, not by touching a synthetic heartbeat file.

## Global Hygiene Checklist

Apply these checks to every change before finalizing work:

1. **Doctor First**: `just keel doctor` is the ultimate source of truth for board integrity. Run it at the start of every session. If the doctor reports errors or short circuits, prioritize fixing those diagnostic orders before attempting any other work or architectural changes.
2. **The Health Loop**: Use `just keel health --scene` for high-level triage. Subsystems are mapped as follows:
   - **NEURAL**: Stories (ID consistency, AC completion)
   - **MOTOR**: Voyages (structure, SRS or SDD authorship)
   - **STRATEGIC**: Epics (PRD and goal lineage)
   - **SENSORY**: Bearings (research and evidence quality)
   - **SKELETAL**: ADRs (architecture decisions)
   - **VITAL**: Missions (strategic achievement)
   - **AUTONOMIC**: Routines (cadence and materialization)
   - **CIRCULATORY**: Workflow (graph integrity and topology)
   - **PACEMAKER**: Heartbeat (derived repository activity and open-loop warning state)
   - **KINETIC**: Delivery (backlog liquidity and execution capacity)
3. **Pacemaker Protocol**: The system's heartbeat is derived from Git and worktree activity and inspected with `just keel heartbeat`. A clean repo falls back to the latest commit; a dirty repo uses the freshest changed path it can observe. `doctor` warns when the worktree carries uncommitted energy, and the sealing commit is what clears that warning. The installed pre-commit hook keeps `just quality` and `just test` tied to the commit boundary, and the commit-msg hook appends `doctor --status` to the message body.
4. **Gardening First**: Fix `doctor` errors, discharge automated backlog, and resolve structural drift before notifying the human operator or requesting input.
5. **Notification Threshold**: Only request human intervention when you reach a manual lane that requires design direction or a decision on application behavior.
6. **Automated Guardrails**: Keep the git hooks installed via `just keel hooks install`. They assume `just quality` and `just test` stay truthful about the repo's verification bar.
7. **Lifecycle Before Commit**: Run board-mutating lifecycle commands before the atomic commit when they generate or rewrite `.keel` artifacts (for example `story submit`, `voyage plan`, `voyage done`, `bearing assess`, `bearing lay`). After the transition, inspect `git status` and include the resulting `.keel` churn in the same commit.
8. **Atomic Commits**: Commit once per logical unit of work. Use Conventional Commits such as `feat:`, `fix:`, `docs:`, `refactor:`, `test:`, or `chore:`.
9. **Mission Loop Discipline**: For mission-driven work, return to the mission steward loop after every completed story, planning unit, or bearing instead of continuing ad hoc from the last worker context.
10. **Hard Cutover**: Replace legacy patterns immediately. Do not bridge or add aliases.
11. **Command Surface Completeness**: When you add or rename local workflow commands, update `justfile`, `AGENTS.md`, and `INSTRUCTIONS.md` together so the repo contract stays truthful.

## Compatibility Policy (Hard Cutover)

At this stage of development, this repository uses a hard cutover policy by default.

1. **No Backward Compatibility by Default**: Do not add compatibility aliases, dual-write logic, soft-deprecated schema fields, or fallback parsing for legacy formats unless a story explicitly requires it.
2. **Replace, Don't Bridge**: When introducing a new canonical token, field, command behavior, or document contract, remove the old path in the same change slice.
3. **Fail Fast In Validation**: `just keel doctor` and transition gates should treat legacy or unfilled scaffold patterns as hard failures when they violate the new contract.
4. **Single Canonical Path**: Keep one source of truth for rendering, parsing, and validation; avoid parallel implementations meant only to preserve old behavior.
5. **Migration Is Explicit Work**: If existing board artifacts need updates, handle that in a dedicated migration pass or story instead of embedding runtime compatibility logic.

## Commands

### Command execution model

Use one path for each concern:

- `just ...` for repo build, test, and product workflows.
- `just keel ...` for all board and workflow operations.

### `just` workflow commands

| Command | Purpose |
|---------|---------|
| `just build` | Build the CLI |
| `just quality` | Run formatting and clippy |
| `just test` | Run the nextest suite |
| `just search <path> <query>` | Run a local search |
| `just recommend <path>` | Run the recommendation flow |
| `just eval` | Run evaluation suites |

### `just keel` board workflow commands

Run `just keel --help` for the full command tree. The core commands you should rely on:

| Category | Commands |
|----------|----------|
| Orientation | `just keel turn` `just keel heartbeat` `just keel health --scene` `just keel flow --scene` `just keel doctor` |
| Inspection | `just keel mission next [<id>]` `just keel pulse` `just keel roles` `just keel next --role manager --explain` |
| Discovery | `just keel bearing new <name>` `just keel bearing research <id>` `just keel bearing assess <id>` `just keel bearing list` |
| Planning | `just keel epic new <name> --problem <problem>` `just keel voyage new <name> --epic <epic-id> --goal <goal>` |
| Execution | `just keel story new "<title>" [--type <type>] [--epic <epic-id> [--voyage <voyage-id>]]` |
| Board Ops | `just keel next --role manager` `just keel next --role operator` `just keel generate` `just keel config show` `just keel mission show <id>` `just keel mission attach <mission-id> --epic <epic-id>` `just keel mission attach <mission-id> --bearing <bearing-id>` `just keel mission attach <mission-id> --adr <adr-id>` |
| Lifecycle | Story, voyage, bearing, and mission transitions through the CLI |

## Story And Milestone State Changes

Use CLI commands only; do not move `.keel` files manually.

| Action | Command |
|--------|---------|
| Start | `just keel story start <id>` |
| Reflect | `just keel story reflect <id>` |
| Submit | `just keel story submit <id>` |
| Reject | `just keel story reject <id> "reason"` |
| Accept | `just keel story accept <id> --role manager` |
| Ice | `just keel story ice <id>` |
| Thaw | `just keel story thaw <id>` |
| Voyage done | `just keel voyage done <id>` |
