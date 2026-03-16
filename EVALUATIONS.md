# Evaluation Guide

`haid` includes an evaluation harness to measure the quality of its **agent-specific** retrieval and extraction capabilities.

## Evaluation Metrics

In addition to standard Information Retrieval (IR) metrics provided by `sift`, `haid` focuses on:

1.  **Extraction Accuracy:** How well the extracted context matches the information needed by the agent.
2.  **Recommendation Relevance:** The quality of file suggestions based on a given code context.
3.  **Agent Latency:** Total time from query to agent-ready JSON response.

---

## Running Evaluations

The `eval` subcommand is used to measure `haid`'s performance.

### 1. Extraction Evaluation
Measures the quality of text extraction and summarization for agent context.

```bash
just eval extraction
```

### 2. Recommendation Evaluation
Measures the relevance of file recommendations for a set of known coding tasks.

```bash
just eval recommendation
```

### 3. End-to-End Latency
Profiles the entire pipeline from query expansion to final JSON formatting.

```bash
just eval latency
```

---

## Dataset Management

`haid` uses local codebases as its primary evaluation material.

### 1. Preparing Synthetic Tasks
You can generate a set of synthetic coding tasks and ground-truth relevance for a local directory:

```bash
just dataset prepare-tasks ./src
```

### 2. Standard Benchmarks
`haid` also supports standard datasets like SciFact via `sift`:

```bash
just dataset prepare-sift scifact
```

---

## Interpreting Results

- **Context Precision:** The ratio of relevant information in the extracted context.
- **Context Recall:** The percentage of necessary information captured from the source.
- **p95 Latency (ms):** The 95th percentile of response time, critical for maintaining agent flow.
- **Token Efficiency:** The ratio of useful information to total tokens in the output (lower is better for LLM costs).
