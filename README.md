# Opencode Custom Commands

A curated collection of custom slash commands for the [Opencode CLI](https://docs.opencode.ai). Enhance your AI-assisted development workflow with specialized agents for git, system monitoring, and entertainment.

## Table of Contents

- [Quick Start](#quick-start)
- [Available Commands](#available-commands)
  - [Development](#development)
  - [Utility & System](#utility--system)
  - [Entertainment](#entertainment)
- [Installation](#installation)
- [Custom Commands Guide](#custom-commands-guide)
- [Configuration](#configuration)
- [Troubleshooting](#troubleshooting)
- [License](#license)

---

## Quick Start

Install all commands with a single command:

```bash
curl -fsSL https://raw.githubusercontent.com/rahul1raman/opencode-custom-commands/main/install.sh | bash
```

---

## Available Commands

### Development

#### `/commit-msg`
Automatically generates a high-quality commit message based on your staged changes following the **Conventional Commits** specification.

- **Features:**
  - Analyzes `git diff --staged` to determine change type (feat, fix, etc.).
  - Follows best practices for subject lines and body context.
  - Interactive approval process before committing.
- **Usage:**
  ```
  /commit-msg
  ```

### Utility & System

#### `/credits`
Monitor your remaining OpenRouter credits directly from the CLI.

- **Features:**
  - Real-time balance display in USD.
  - Visual progress indicator.
  - Zero-config: Automatically detects keys from Opencode's auth settings.
- **Usage:**
  ```
  /credits
  ```

### Entertainment

#### `/recommend-movie`
Get personalized movie recommendations based on a high-quality cinema taste profile.

- **Features:**
  - Excludes already-watched movies via `~/movie_watched.md`.
  - Focuses on Sci-Fi, Crime, Thrillers, and Indie gems.
  - Interactive feedback loop to swap recommendations.
- **Usage:**
  ```
  /recommend-movie
  ```

#### `/recommend-anime`
Get personalized anime recommendations tailored to mature, psychological, and high-stakes action genres.

- **Features:**
  - Tracks watched history via `~/anime_watched.md`.
  - Supports both Movies and Series.
  - Continuously refines results based on user preferences.
- **Usage:**
  ```
  /recommend-anime
  ```

---

## Installation

### Prerequisites
- [Opencode CLI](https://docs.opencode.ai)
- `curl`, `bc`, `python3` (Installer will attempt to auto-install these)

### Automated Installation (Recommended)
```bash
curl -fsSL https://raw.githubusercontent.com/rahul1raman/opencode-custom-commands/main/install.sh | bash
```

### Manual Installation
1. Clone the repository.
2. Copy `.md` files from `commands/` to `~/.config/opencode/commands/`.
3. Copy scripts from `scripts/` to `~/.local/bin/` and make them executable.

---

## Custom Commands Guide

This repository is designed to be a framework for your own commands. To create a new command:

1. Create a markdown file in `~/.config/opencode/commands/`.
2. Use the frontmatter format to define the description.
3. Use instructions to guide the AI's behavior.

**Example Command Structure:**
```markdown
---
description: Brief description
---
## Instructions
1. Analyze X
2. Execute Y
## Rules
- Avoid Z
```

---

## Configuration

### OpenRouter API Key
The `/credits` command reads from `~/.local/share/opencode/auth.json`. Ensure you have configured OpenRouter in your Opencode settings.

### Watched Lists
Recommendation commands use the following files to avoid duplicates:
- **Anime:** `~/anime_watched.md`
- **Movies:** `~/movie_watched.md`

Format example:
```markdown
## Watched
- Title A
- Title B
```

---

## Troubleshooting

- **Commands not appearing:** Restart Opencode and verify the files exist in `~/.config/opencode/commands/`.
- **Permission denied:** Ensure `~/.local/bin` is in your `PATH` and scripts are executable (`chmod +x`).

---

## License
MIT License. See [LICENSE](LICENSE) for details.
