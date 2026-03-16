# Architecture

`haid` is a Rust-first, local-first search and retrieval tool designed specifically for **agentic coding workflows**. It is built on top of the `sift` core engine, embedding it as a library to provide high-performance, intent-driven information retrieval without the need for an external database or long-running daemon.

## Core Tenets

1. **Agent-Centric Retrieval:** Information is extracted and formatted specifically to be consumed by Large Language Model (LLM) agents.
2. **Local Sovereignty:** No code or data leaves the local machine during extraction or search.
3. **Sift-Powered Performance:** Uses `sift`'s SIMD-accelerated scoring and hybrid search strategy (Lexical + Semantic).
4. **Single-Binary Distribution:** Compiled to a single, static Rust executable for easy deployment in any environment.

## Hexagonal Boundaries

`haid` follows a hexagonal architecture, isolating its agent-specific features from the underlying search engine and distribution mechanism.

### 1. The Domain (`src/haid/domain.rs`)

The domain logic focused on the agent's "hearing aid" capabilities.

- **Ports (Traits):**
  - `AgentRetriever`: Extends `sift::Retriever` to specialize in agentic queries.
  - `RecommendationEngine`: Analyzes code context to suggest relevant files or patterns.
  - `InformationExtractor`: Summarizes search hits into agent-ready context.

### 2. The Sift Adapter (`src/sift_adapter/mod.rs`)

`haid` embeds `sift` and implements its own strategies by composing `sift`'s building blocks.

- **Sift Embedded Library:** Consumes `Sift`, `SearchInput`, and `SearchResponse`.
- **Search Logic:** Orchestrates the `Expansion -> Retrieval -> Fusion -> Reranking` pipeline provided by `sift`.

### 3. The CLI Interface (`src/main.rs`)

The CLI provides the primary entry point for both humans and agents (via shell execution).

- **Commands:** `search`, `recommend`, `extract`, `telemetry`.
- **Formatting:** Supports structured JSON output for tool-calling agents and colorized text for humans.

## Data Flow

```mermaid
flowchart TD
  A[Agent Query] --> B[haid CLI]
  B --> C[AgentRetriever]
  C --> D[Sift Engine (Embedded)]
  
  subgraph Sift ["Sift Core Pipeline"]
    D --> E[Expansion]
    E --> F[Retrieval (BM25 + Vector)]
    F --> G[Fusion & Reranking]
  end

  G --> H[SearchResponse]
  H --> I[InformationExtractor]
  I --> J[Agent-Ready Context (JSON/Text)]
```

## Performance & Scalability

As an embedder of `sift`, `haid` inherits its performance characteristics:
- **SIMD Acceleration:** High-speed vector similarity for semantic search.
- **Mapped I/O:** Efficient document loading via `mmap`.
- **Heuristic Caching:** Fast incremental updates using filesystem metadata.
