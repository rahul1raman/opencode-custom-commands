# Opencode Custom Commands

A collection of custom slash commands for [opencode](https://docs.opencode.ai), including anime recommendations and credit monitoring.

## 🚀 Quick Install

\`\`\`bash
curl -fsSL https://raw.githubusercontent.com/YOUR_USERNAME/opencode-custom-commands/main/install.sh | bash
\`\`\`

## 📋 Prerequisites

- [opencode CLI](https://docs.opencode.ai) - The AI coding assistant
- \`curl\` - For API calls
- \`bc\` - For calculations (credit display)
- \`python3\` - For JSON parsing

The installer will automatically detect and install missing dependencies on supported systems (Ubuntu, Debian, Fedora, Arch, macOS with Homebrew).

## 📦 Available Commands

### \`/recommend-anime\`

Get personalized anime recommendations based on your taste profile.

**Features:**
- Reads from \`~/anime_watched.md\` to avoid recommending already-watched shows
- Supports both Movies and Series
- Uses intelligent search across multiple angles
- Continuously refines recommendations based on your feedback

**Usage:**
\`\`\`
/recommend-anime
\`\`\`

**First-time setup:**
Create \`~/anime_watched.md\` with this format:
\`\`\`markdown
## Watched
- Attack on Titan
- Death Note
- Steins;Gate
\`\`\`

### \`/credits\`

Check your remaining credits for OpenRouter (and other configured providers).

**Features:**
- Visual progress indicator
- Shows remaining balance in USD
- Reads API keys from opencode's auth.json automatically

**Usage:**
\`\`\`
/credits
\`\`\`

## 🛠️ Manual Installation

If you prefer not to use the automated installer:

1. **Clone the repository:**
   \`\`\`bash
   git clone https://github.com/YOUR_USERNAME/opencode-custom-commands.git
   cd opencode-custom-commands
   \`\`\`

2. **Create directories:**
   \`\`\`bash
   mkdir -p ~/.config/opencode/commands
   mkdir -p ~/.local/bin
   \`\`\`

3. **Copy command files:**
   \`\`\`bash
   cp commands/*.md ~/.config/opencode/commands/
   \`\`\`

4. **Copy and make scripts executable:**
   \`\`\`bash
   cp scripts/* ~/.local/bin/
   chmod +x ~/.local/bin/check-credits.sh
   \`\`\`

5. **Verify installation:**
   \`\`\`bash
   opencode --version  # Should show opencode is installed
   ls ~/.config/opencode/commands/  # Should show recommend-anime.md and credits.md
   \`\`\`

## 📝 Adding Custom Commands

Want to extend this with your own commands? Here's how:

### Basic Command Structure

Create a file in \`~/.config/opencode/commands/\` with the following format:

\`\`\`markdown
---
description: Brief description of what this command does
---

Your instruction text here.

## Instructions
1. First step
2. Second step

## Rules
- Rule 1
- Rule 2
\`\`\`

### Example: Simple Command

\`\`\`markdown
---
description: Show current weather
---

Ask the user for their city, then use the weather tool to get and display current weather information.
\`\`\`

### Example: Command with Shell Script

For commands that need external tools, create a helper script:

**\`~/.config/opencode/commands/my-command.md\`:**
\`\`\`markdown
---
description: Run my custom tool
---

Call the shell script to execute my custom tool:

!~/.local/bin/my-script.sh
\`\`\`

**\`~/.local/bin/my-script.sh\`:**
\`\`\`bash
#!/bin/bash
# Your script logic here
echo "Hello from custom script!"
\`\`\`

Make it executable:
\`\`\`bash
chmod +x ~/.local/bin/my-script.sh
\`\`\`

### Best Practices

1. **Use descriptive names:** \`command-name.md\` format
2. **Write clear descriptions:** Shown in \`/help\` command
3. **Include examples:** Show users how to use your command
4. **Handle errors gracefully:** Provide helpful error messages
5. **Document dependencies:** List any external tools needed

## 🔧 Configuration

### OpenRouter Credits

The \`/credits\` command reads your API keys from opencode's auth file:

**Location:** \`~/.local/share/opencode/auth.json\`

**Format:**
\`\`\`json
{
  "openrouter": {
    "key": "your-api-key-here"
  }
}
\`\`\`

Configure your OpenRouter key in opencode settings, and the credits command will automatically detect it.

### Anime Watched List

The \`/recommend-anime\` command maintains a watched list to avoid duplicates:

**Location:** \`~/anime_watched.md\`

Add titles you've already watched, and the recommendation engine will exclude them automatically.

## 🐛 Troubleshooting

### Commands not appearing in opencode

1. Restart opencode after installation
2. Check that files are in the correct location:
   \`\`\`bash
   ls ~/.config/opencode/commands/
   \`\`\`
3. Verify the commands directory is in your opencode configuration

### Scripts not found

Ensure \`~/.local/bin\` is in your PATH:
\`\`\`bash
echo \$PATH | grep ".local/bin"
\`\`\`

If not, add it to your shell configuration:
\`\`\`bash
# Add to ~/.bashrc, ~/.zshrc, or equivalent
export PATH="\$HOME/.local/bin:\$PATH"
\`\`\`

### Permission denied on scripts

Make scripts executable:
\`\`\`bash
chmod +x ~/.local/bin/check-credits.sh
\`\`\`

### Dependencies not found

The installer attempts to install \`curl\`, \`bc\`, and \`python3\` automatically. If it fails:

**Ubuntu/Debian:**
\`\`\`bash
sudo apt-get install curl bc python3
\`\`\`

**macOS (with Homebrew):**
\`\`\`bash
brew install curl coreutils python3
\`\`\`

**Arch Linux:**
\`\`\`bash
sudo pacman -S curl bc python
\`\`\`

## 📄 License

MIT License - Feel free to use, modify, and distribute.

## 🤝 Contributing

Contributions are welcome! If you have a custom command you'd like to share:

1. Fork the repository
2. Add your command to the \`commands/\` directory
3. If it needs a script, add it to \`scripts/\`
4. Update this README with documentation
5. Submit a pull request

## 📞 Support

- **Issues:** [GitHub Issues](https://github.com/YOUR_USERNAME/opencode-custom-commands/issues)
- **Opencode Docs:** [https://docs.opencode.ai](https://docs.opencode.ai)

---

Made with ❤️ for the opencode community
