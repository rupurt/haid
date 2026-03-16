# haid

[![Planning Board](https://img.shields.io/badge/Keel-Board-blue)](.keel/README.md)
[![Release Process](https://img.shields.io/badge/Release-Process-green)](RELEASE.md)

`haid` is a **"hearing aid" for agentic coding environments** such as Claude Code, Codex, and Gemini. It provides a local, high-performance search and retrieval interface designed specifically for LLM-based agents to consume.

By embedding [`sift`](https://github.com/rupurt/sift) as its core engine, `haid` allows agents to:
- **Search** local codebases with intent-driven hybrid retrieval.
- **Recommend** relevant files based on current coding context.
- **Extract** concise, agent-ready information from search hits.

## Current Contract

- **Single Rust Binary:** No external database, daemon, or long-running service.
- **Sift-Powered:** High-performance SIMD-accelerated scoring and hybrid strategy (Lexical + Semantic).
- **Agent-Ready Output:** Structured JSON or formatted text optimized for LLM token efficiency.
- **Local Sovereignty:** All extraction, search, and inference happen locally.

## Installation

### One-liner Install (macOS and Linux)

```bash
curl --proto '=https' --tlsv1.2 -LsSf https://github.com/rupurt/haid/releases/latest/download/haid-installer.sh | sh
```

### Manual Download

Download the latest pre-built binaries and installers for your platform from the [GitHub Releases](https://github.com/rupurt/haid/releases) page.

## Quick Start

```bash
# Search the current directory
haid search "how do I handle authentication?"

# Recommend files related to a specific context
haid recommend src/auth.rs

# Extract information from a specific file with context
haid extract src/main.rs "show the entry point"
```

## Foundational Documents

- **[AGENTS.md](AGENTS.md):** Shared guidance for AI agents working on this project.
- **[CONSTITUTION.md](CONSTITUTION.md):** Repository design and operational principles.
- **[ARCHITECTURE.md](ARCHITECTURE.md):** Deep dive into the hexagonal engine and component boundaries.
- **[INSTRUCTIONS.md](INSTRUCTIONS.md):** Formal workflow and operational guidance (Keel/Missions).
- **[CONFIGURATION.md](CONFIGURATION.md):** Guide to `haid.toml` and environment variables.
- **[EVALUATIONS.md](EVALUATIONS.md):** How to measure retrieval quality and extraction accuracy.
- **[RELEASE.md](RELEASE.md):** The automated release and distribution process.

## License

This project is licensed under the [MIT License](LICENSE).
