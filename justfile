# Justfile for haid

# Build the project
build:
    cargo build

# Run tests
test:
    cargo nextest run
    cargo fmt --check
    cargo clippy -- -D warnings

# Run the search command
search path query:
    cargo run -- search {{path}} {{query}}

# Run the recommend command
recommend path:
    cargo run -- recommend {{path}}

# Run evaluations
eval:
    cargo run -- eval all
