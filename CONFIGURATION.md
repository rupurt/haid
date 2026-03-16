# Configuration Guide

`haid` is designed to be agent-friendly with sensible defaults, but it can be customized via a `haid.toml` file or environment variables.

## Configuration Locations

`haid` looks for configuration in the following order, merging them together (local overrides system):

1.  **System-wide:** `/etc/haid.toml`
2.  **User-specific:** `~/.config/haid/haid.toml` (or platform equivalent)
3.  **Local Project:** `./haid.toml` (in the directory where you run `haid`)

You can view your effective configuration at any time by running:
```bash
haid config
```

---

## Configuration Options (`haid.toml`)

### `[agent]` Section

These settings control the agent-specific features of `haid`.

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| `output_format` | String | `"json"` | Default output format (`json` or `text`). |
| `context_lines` | Integer | `3` | Number of context lines to extract around search hits. |
| `max_extract_size` | Integer | `4096` | Maximum number of characters to extract per file. |

### `[search]` Section (Sift Core)

`haid` embeds `sift`, and these settings are passed directly to the underlying engine.

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| `strategy` | String | `"page-index-hybrid"` | The named search strategy to use. |
| `limit` | Integer | `5` | The maximum number of results to return. |
| `shortlist` | Integer | `10` | The number of candidates passed into reranking. |

#### Available Strategies
- **`page-index-hybrid`** (default): Combines BM25, Phrase matching, and Vector search.
- **`page-index-llm`**: Uses a local LLM for reranking.
- **`bm25`**: Lexical search only.
- **`vector`**: Semantic search only.

### `[embedding]` Section

Controls the local ML model used for semantic vector search.

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| `model_id` | String | `"sentence-transformers/all-MiniLM-L6-v2"` | HuggingFace model ID for embeddings. |

---

## Environment Variables

| Variable | Description |
|----------|-------------|
| `HAID_CONFIG` | Path to a specific `haid.toml` file. |
| `HAID_LOG` | Log level (`error`, `warn`, `info`, `debug`, `trace`). |
| `SIFT_CACHE` | Root directory for `sift`'s internal cache and model storage. |
