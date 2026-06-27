# Gneol Release

Precompiled binaries for the Gneol AI platform.

## Binaries

| Binary | macOS | Linux |
|--------|-------|-------|
| `gneol` (CLI) | `gneol-darwin` | `gneol-linux` |
| `gneol-brain` (Server) | `gneol-brain-darwin` | `gneol-brain-linux` |

## Installation

### Quick install (recommended)

```bash
curl -sSL https://raw.githubusercontent.com/gneol-org/gneol-release/main/install.sh | bash
```

### Install a specific version

```bash
curl -sSL https://raw.githubusercontent.com/gneol-org/gneol-release/main/install.sh | bash -s -- --version v0.2.5
```

### Manual download

Download from the [Releases](https://github.com/Gneol/Gneol/releases) page.

## Releasing

```bash
./release.sh v0.2.5 "Release notes here"
```
