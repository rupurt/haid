# Constitution

This document defines the unyielding principles that guide the development and design of `haid`. When making architectural decisions, evaluating PRs, or planning new features, these rules must be satisfied.

## 1. Agent-First Design
`haid` is built specifically for **agentic coding environments**. 
- **LLM-Ready Context:** Search results and extractions must be formatted to maximize LLM comprehension while minimizing token cost.
- **Structured Output:** High-fidelity JSON output is the primary interface for tool-calling agents.
- **Context Preservation:** Extraction must preserve structural context (file paths, line numbers, surrounding symbols) to allow agents to accurately navigate the codebase.

## 2. Zero-Infrastructure Footprint
`haid` must remain a lightweight, single-binary utility.
- **No Long-Running Daemons:** No background processes or resident services.
- **No External Databases:** All search, indexing, and retrieval happen locally without requiring external dependencies (e.g., Postgres, Redis, Vector DBs).
- **Stateless Execution:** `haid` operates directly on directories, with transparent caching in standard user directories.

## 3. Sift-Powered Retrieval
`haid` embeds and extends the `sift` engine.
- **Hybrid Search:** Always leverage both lexical (BM25) and semantic (Vector) retrieval to bridge the vocabulary gap.
- **Local Inference:** Embeddings and reranking models must run locally (e.g., via `candle`) to ensure data privacy and offline capability.
- **SIMD Performance:** Utilize hardware acceleration for all scoring hot-paths inherited from `sift`.

## 4. Local Sovereignty
Source code is a sensitive asset.
- **No Data Exfiltration:** No code, documents, or metadata leave the local machine during extraction or search.
- **Offline Capability:** `haid` must remain fully functional without an internet connection (after initial model download).

## 5. Hexagonal Isolation
The "Hearing Aid" logic must stay decoupled from the underlying search engine.
- `haid` defines its own agent-specific traits (`AgentRetriever`, `InformationExtractor`).
- `sift` is treated as an embedded adapter fulfilling these traits.
- The CLI is a thin layer at the edge of the architecture.

## 6. Determinism and Reproducibility
Agent workflows depend on stable environments.
- Search rankings and extraction summaries must be deterministic for a given codebase and query.
- Tie-breaking must be stable and follow documented rules (e.g., lexicographical sorting).

## 7. Verification-Driven Quality
Performance and quality must be measured empirically.
- Every functional change must be verified against a test, an agent-specific benchmark, or an empirical CLI proof.
- If a change degrades extraction accuracy or retrieval quality, it must be justified with evidence from the `eval` harness.
