# Justfile for haid

# Build the project
build:
    cargo build

# Run formatting and lint checks
quality:
    cargo fmt --check
    cargo clippy -- -D warnings

# Run tests
test:
    cargo nextest run --no-tests pass

# Run the pinned Keel binary from the active dev shell
keel *args:
    keel {{args}}

# Run all commit-boundary checks
pre-commit: quality test

# Run the search command
search path query:
    cargo run -- search {{path}} {{query}}

# Run the recommend command
recommend path:
    cargo run -- recommend {{path}}

# Run evaluations
eval:
    cargo run -- eval all
