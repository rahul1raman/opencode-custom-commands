#!/bin/bash
set -e

echo "Opencode Custom Commands Installer"
echo "====================================="
echo ""

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to install dependencies based on OS
install_dependencies() {
    echo "Installing missing dependencies..."
    
    SUDO=""
    if [ "$EUID" -ne 0 ]; then
        if command_exists sudo; then
            SUDO="sudo"
        else
            echo -e "${YELLOW}Warning: Installation may fail because 'sudo' is not available.${NC}"
        fi
    fi
    
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        # Linux
        if command_exists apt-get; then
            # Debian/Ubuntu
            $SUDO apt-get update -qq
            $SUDO apt-get install -y -qq curl bc python3
        elif command_exists yum; then
            # RHEL/CentOS/Fedora
            $SUDO yum install -y curl bc python3
        elif command_exists pacman; then
            # Arch Linux
            $SUDO pacman -S --noconfirm curl bc python
        elif command_exists dnf; then
            # Fedora
            $SUDO dnf install -y curl bc python3
        else
            echo -e "${YELLOW}Warning: Could not detect package manager. Please install curl, bc, and python3 manually.${NC}"
            exit 1
        fi
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        if command_exists brew; then
            brew install curl coreutils python3
        else
            echo -e "${YELLOW}Warning: Homebrew not found. Please install Homebrew first: https://brew.sh${NC}"
            echo -e "${YELLOW}   Then run: brew install curl coreutils python3${NC}"
            exit 1
        fi
    else
        echo -e "${YELLOW}Warning: Unknown OS. Please install curl, bc, and python3 manually.${NC}"
        exit 1
    fi
    
    echo -e "${GREEN}[OK] Dependencies installed${NC}"
}

# 1. Check opencode CLI
if ! command_exists opencode; then
    echo -e "${RED}[ERROR] opencode CLI not found${NC}"
    echo ""
    echo "Please install opencode first:"
    echo "  https://docs.opencode.ai"
    exit 1
fi
echo -e "${GREEN}[OK] opencode CLI found${NC}"

# 2. Check and install dependencies
MISSING_DEPS=()

if ! command_exists curl; then
    MISSING_DEPS+=("curl")
fi

if ! command_exists bc; then
    MISSING_DEPS+=("bc")
fi

if ! command_exists python3; then
    MISSING_DEPS+=("python3")
fi

if [ ${#MISSING_DEPS[@]} -gt 0 ]; then
    echo -e "${YELLOW}Warning: Missing dependencies: ${MISSING_DEPS[*]}${NC}"
    
    read -p "Install automatically? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        install_dependencies
    else
        echo "Please install the missing dependencies manually and re-run."
        exit 1
    fi
else
    echo -e "${GREEN}[OK] All dependencies found${NC}"
fi

# 3. Create directories
OPENCODE_CMD_DIR="$HOME/.config/opencode/commands"
LOCAL_BIN_DIR="$HOME/.local/bin"

echo ""
echo "Creating directories..."
mkdir -p "$OPENCODE_CMD_DIR"
mkdir -p "$LOCAL_BIN_DIR"
echo -e "${GREEN}[OK] Directories created${NC}"

# 4. Get the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# 5. Copy or Download commands
echo ""
echo "Installing commands..."
if [ -d "$SCRIPT_DIR/commands" ]; then
    cp "$SCRIPT_DIR/commands/"*.md "$OPENCODE_CMD_DIR/" 2>/dev/null || true
    echo -e "${GREEN}[OK] Commands installed from local source${NC}"
else
    echo "Local source not found, downloading commands from GitHub..."
    for cmd in recommend-anime.md recommend-movie.md credits.md commit-msg.md code-review.md; do
        curl -fsSL "https://raw.githubusercontent.com/rahul1raman/opencode-custom-commands/main/commands/$cmd" -o "$OPENCODE_CMD_DIR/$cmd" || echo -e "${YELLOW}Warning: Failed to download $cmd${NC}"
    done
    echo -e "${GREEN}[OK] Commands downloaded and installed${NC}"
fi

# 6. Copy or Download scripts
echo ""
echo "Installing helper scripts..."
if [ -d "$SCRIPT_DIR/scripts" ]; then
    cp "$SCRIPT_DIR/scripts/"* "$LOCAL_BIN_DIR/" 2>/dev/null || true
    chmod +x "$LOCAL_BIN_DIR/check-credits.sh" 2>/dev/null || true
    echo -e "${GREEN}[OK] Scripts installed from local source${NC}"
else
    echo "Local source not found, downloading scripts from GitHub..."
    curl -fsSL "https://raw.githubusercontent.com/rahul1raman/opencode-custom-commands/main/scripts/check-credits.sh" -o "$LOCAL_BIN_DIR/check-credits.sh" || echo -e "${YELLOW}Warning: Failed to download check-credits.sh${NC}"
    chmod +x "$LOCAL_BIN_DIR/check-credits.sh" 2>/dev/null || true
    echo -e "${GREEN}[OK] Scripts downloaded and installed${NC}"
fi

# 7. Verify installation
echo ""
echo "Verifying installation..."

INSTALLED_CMDS=0
if [ -f "$OPENCODE_CMD_DIR/recommend-anime.md" ]; then
    echo -e "${GREEN}[OK] recommend-anime${NC}"
    INSTALLED_CMDS=$((INSTALLED_CMDS + 1))
fi

if [ -f "$OPENCODE_CMD_DIR/recommend-movie.md" ]; then
    echo -e "${GREEN}[OK] recommend-movie${NC}"
    INSTALLED_CMDS=$((INSTALLED_CMDS + 1))
fi

if [ -f "$OPENCODE_CMD_DIR/credits.md" ]; then
    echo -e "${GREEN}[OK] credits${NC}"
    INSTALLED_CMDS=$((INSTALLED_CMDS + 1))
fi

if [ -f "$OPENCODE_CMD_DIR/commit-msg.md" ]; then
    echo -e "${GREEN}[OK] commit-msg${NC}"
    INSTALLED_CMDS=$((INSTALLED_CMDS + 1))
fi

if [ -f "$OPENCODE_CMD_DIR/code-review.md" ]; then
    echo -e "${GREEN}[OK] code-review${NC}"
    INSTALLED_CMDS=$((INSTALLED_CMDS + 1))
fi

if [ -f "$LOCAL_BIN_DIR/check-credits.sh" ]; then
    echo -e "${GREEN}[OK] check-credits.sh${NC}"
fi

echo ""
echo "====================================="
if [ $INSTALLED_CMDS -gt 0 ]; then
    echo -e "${GREEN}Installation complete!${NC}"
    echo ""
    echo "Installed $INSTALLED_CMDS custom command(s):"
    echo "  - /recommend-anime - Get personalized anime recommendations"
    echo "  - /recommend-movie - Get personalized movie recommendations"
    echo "  - /code-review    - Perform comprehensive code reviews"
    echo "  - /commit-msg     - Generate conventional commit messages"
    echo "  - /credits         - Check OpenRouter credits"
    echo ""
    echo "Usage:"
    echo "  Type /recommend-anime, /recommend-movie, /code-review, /commit-msg or /credits in opencode"
    echo ""
    echo "To add your own commands:"
    echo "  1. Create a .md file in ~/.config/opencode/commands/"
    echo "  2. See README.md for command format examples"
else
    echo -e "${YELLOW}Warning: No commands were installed. Please check the source files.${NC}"
    exit 1
fi
