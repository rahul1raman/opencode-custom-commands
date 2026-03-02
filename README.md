# Opencode Custom Commands

A collection of custom slash commands for [opencode](https://docs.opencode.ai), including anime recommendations and credit monitoring.

## Table of Contents

- [Quick Start](#quick-start)
- [Prerequisites](#prerequisites)
- [Available Commands](#available-commands)
- [Installation](#installation)
- [Custom Commands Guide](#custom-commands-guide)
- [Configuration](#configuration)
- [Troubleshooting](#troubleshooting)
- [License](#license)

## Quick Start

Install all commands with one line:

```bash
curl -fsSL https://raw.githubusercontent.com/rahul1raman/opencode-custom-commands/main/install.sh | bash
```

## Prerequisites

- [opencode CLI](https://docs.opencode.ai) - The AI coding assistant
- `curl` - For API calls
- `bc` - For calculations (credit display)
- `python3` - For JSON parsing

The installer automatically detects and installs missing dependencies on supported systems (Ubuntu, Debian, Fedora, Arch, macOS with Homebrew).

## Available Commands

### /recommend-anime

Get personalized anime recommendations based on your taste profile.

**Features:**
- Reads from `~/anime_watched.md` to avoid recommending already-watched shows
- Supports both Movies and Series
- Uses intelligent search across multiple angles
- Continuously refines recommendations based on your feedback

**Usage:**
```
/recommend-anime
```

**First-time setup:**
Create `~/anime_watched.md` with this format:
```markdown
## Watched
- Attack on Titan
- Death Note
- Steins;Gate
```

### /credits

Check your remaining credits for OpenRouter.

**Features:**
- Visual progress indicator
- Shows remaining balance in USD
- Reads API keys from opencode's auth.json automatically

**Usage:**
```
/credits
```

## Installation

### Automated Installation (Recommended)

Run the install script:

```bash
curl -fsSL https://raw.githubusercontent.com/rahul1raman/opencode-custom-commands/main/install.sh | bash
```

The installer will:
1. Check for opencode CLI
2. Install missing dependencies (`curl`, `bc`, `python3`)
3. Create required directories
4. Copy command files to `~/.config/opencode/commands/`
5. Copy helper scripts to `~/.local/bin/`
6. Verify the installation

### Manual Installation

If you prefer to install manually:

1. **Clone the repository:**
   ```bash
   git clone https://github.com/rahul1raman/opencode-custom-commands.git
   cd opencode-custom-commands
   ```

2. **Create directories:**
   ```bash
   mkdir -p ~/.config/opencode/commands
   mkdir -p ~/.local/bin
   ```

3. **Copy command files:**
   ```bash
   cp commands/*.md ~/.config/opencode/commands/
   ```

4. **Copy and make scripts executable:**
   ```bash
   cp scripts/* ~/.local/bin/
   chmod +x ~/.local/bin/check-credits.sh
   ```

5. **Verify installation:**
   ```bash
   opencode --version
   ls ~/.config/opencode/commands/
   ```

## Custom Commands Guide

This repository is designed for extensibility. You can easily add your own custom commands.

### Command Structure

Create a file in `~/.config/opencode/commands/` with this format:

```markdown
---
description: Brief description of what this command does
---

Your instruction text here. This content guides the AI on how to handle the command.

## Instructions
1. First step
2. Second step

## Rules
- Rule 1
- Rule 2
```

### Examples

**Simple command without external dependencies:**
```markdown
---
description: Show current weather
---

Ask the user for their city, then use the weather tool to get and display current weather information.
```

**Command with shell script helper:**

Create the command file (`~/.config/opencode/commands/my-command.md`):
```markdown
---
description: Run my custom tool
---

Call the shell script to execute my custom tool:

!~/.local/bin/my-script.sh
```

Create the script (`~/.local/bin/my-script.sh`):
```bash
#!/bin/bash
echo "Hello from custom script!"
```

Make it executable:
```bash
chmod +x ~/.local/bin/my-script.sh
```

### Best Practices

- Use descriptive filenames (e.g., `command-name.md`)
- Write clear descriptions (shown in `/help` command)
- Include usage examples
- Handle errors gracefully
- Document any external dependencies

## Configuration

### OpenRouter API Key

The `/credits` command reads your API key from opencode's auth file:

**File location:** `~/.local/share/opencode/auth.json`

**Format:**
```json
{
  "openrouter": {
    "key": "your-api-key-here"
  }
}
```

Configure your OpenRouter key in opencode settings, and the credits command will automatically detect it.

### Anime Watched List

The `/recommend-anime` command tracks watched anime to avoid duplicates:

**File location:** `~/anime_watched.md`

Add titles you have already watched, and the recommendation engine will exclude them from future suggestions.

## Troubleshooting

### Commands not appearing in opencode

1. Restart opencode after installation
2. Verify files are in the correct location:
   ```bash
   ls ~/.config/opencode/commands/
   ```
3. Check opencode configuration for the commands directory path

### Scripts not found

Ensure `~/.local/bin` is in your PATH:
```bash
echo $PATH | grep ".local/bin"
```

If not present, add to your shell configuration:
```bash
# Add to ~/.bashrc, ~/.zshrc, or equivalent
export PATH="$HOME/.local/bin:$PATH"
```

### Permission denied on scripts

Make scripts executable:
```bash
chmod +x ~/.local/bin/check-credits.sh
```

### Missing dependencies

The installer attempts to install `curl`, `bc`, and `python3` automatically. If this fails:

**Ubuntu/Debian:**
```bash
sudo apt-get update
sudo apt-get install curl bc python3
```

**macOS (with Homebrew):**
```bash
brew install curl coreutils python3
```

**Arch Linux:**
```bash
sudo pacman -S curl bc python
```

**Fedora/RHEL:**
```bash
sudo dnf install curl bc python3
```

## License

MIT License - See LICENSE file for details.

## Contributing

Contributions are welcome. To add a new command:

1. Fork the repository
2. Add your command to the `commands/` directory
3. Add any helper scripts to `scripts/`
4. Update this README with documentation
5. Submit a pull request

## Support

- **Issues:** [GitHub Issues](https://github.com/rahul1raman/opencode-custom-commands/issues)
- **Documentation:** [https://docs.opencode.ai](https://docs.opencode.ai)
