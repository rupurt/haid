# Haid Policy

This document is downstream from Keel and should describe the operational invariants that govern Haid. Keel supplies the board engine and lifecycle discipline; this file defines the repo-specific rules that must remain true.

## Engine Contract

Haid uses Keel as its project-management engine.

- The board lives in `.keel/`.
- The canonical tactical rhythm is the Turn Loop exposed by `keel turn`.
- Board mutations, proof, and lifecycle closure happen through the CLI, not manual file edits.

## Repo Invariants

Hydrate the rules that should always be true in this repository.

- What must pass before a change can land?
- What kinds of changes require explicit human review?
- What evidence is required for code, product, UX, legal, or operational claims?

## Safety Rails

- Define release and rollback expectations.
- Define how secrets, production systems, or customer data may be touched.
- Define what should block autonomous execution.

## Local Exceptions

If Haid needs exceptions from the default Keel operating model, document them explicitly here rather than letting them live in habit or chat memory.
