# Release Process

`haid` uses [cargo-dist](https://opensource.axodotdev.com/cargo-dist/) to automate cross-platform releases. Binaries and installers for Linux, macOS, and Windows are automatically built and uploaded to GitHub Releases when a version tag is pushed.

---

## How to Perform a Release

Follow these steps to release a new version of `haid`:

### 1. Update Version
Bump the version number in `Cargo.toml`. We follow [Semantic Versioning](https://semver.org/).

```toml
# Cargo.toml
[package]
name = "haid"
version = "0.1.0"
```

### 2. Commit and Push
Commit the version bump to the `main` branch.

```bash
git add Cargo.toml
git commit -m "chore: bump version to 0.1.0"
git push origin main
```

### 3. Create and Push a Tag
Create a git tag corresponding to the new version (must start with `v`).

```bash
git tag v0.1.0
git push origin v0.1.0
```

---

## Supported Platforms & Artifacts

| Platform | Target Triple | Artifacts |
|----------|---------------|-----------|
| **Linux (x86_64, glibc)** | `x86_64-unknown-linux-gnu` | `.tar.gz`, shell installer |
| **Linux (ARM64)** | `aarch64-unknown-linux-gnu` | `.tar.gz`, shell installer |
| **macOS (Intel)** | `x86_64-apple-darwin` | `.tar.gz`, shell installer |
| **macOS (Apple Silicon)** | `aarch64-apple-darwin` | `.tar.gz`, shell installer |
| **Windows (x86_64)** | `x86_64-pc-windows-msvc` | `.zip`, `.msi`, PowerShell installer |

---

## Local Testing

You can simulate the release plan locally (if `cargo-dist` is installed):

```bash
# See what would be built
cargo dist plan

# Build artifacts locally (outputs to target/dist)
cargo dist build
```
