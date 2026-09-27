#!/usr/bin/env bash
set -euo pipefail

echo "=== AI Dev Stack installer (Linux/macOS) ==="

# Detect OS
if [[ "$OSTYPE" == "darwin"* ]]; then
  OS=mac
  echo "Detected: macOS"
else
  OS=linux
  echo "Detected: Linux"
fi

# --- Git & GitHub CLI ---
if ! command -v git &>/dev/null; then
  echo "Installing git..."
  if [[ "$OS" == "mac" ]]; then
    brew install git
  else
    sudo apt-get update -y && sudo apt-get install -y git
  fi
fi

if ! command -v gh &>/dev/null; then
  echo "Installing GitHub CLI..."
  if [[ "$OS" == "mac" ]]; then
    brew install gh
  else
    sudo apt-get install -y gh
  fi
fi

# --- Node.js 22 (via nvm) ---
if ! command -v node &>/dev/null; then
  echo "Installing Node.js 22 via nvm..."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
  export NVM_DIR="$HOME/.nvm"
  # shellcheck disable=SC1091
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
  nvm install 22
  nvm use 22
  nvm alias default 22
fi

# --- Python 3.12 ---
if ! command -v python3 &>/dev/null; then
  echo "Installing Python 3.12..."
  if [[ "$OS" == "mac" ]]; then
    brew install python@3.12
  else
    sudo apt-get install -y python3.12 python3.12-venv python3-pip
  fi
fi

# --- pnpm ---
if ! command -v pnpm &>/dev/null; then
  echo "Installing pnpm..."
  corepack enable
  corepack prepare pnpm@latest --activate
fi

# --- Docker ---
if ! command -v docker &>/dev/null; then
  echo "Installing Docker..."
  if [[ "$OS" == "mac" ]]; then
    echo "Install Docker Desktop from https://www.docker.com/products/docker-desktop/"
  else
    curl -fsSL https://get.docker.com | sudo sh
    sudo usermod -aG docker "$USER"
  fi
fi

# --- Ollama (local LLMs) ---
if ! command -v ollama &>/dev/null; then
  echo "Installing Ollama..."
  curl -fsSL https://ollama.com/install.sh | sh
fi

# --- VS Code ---
if ! command -v code &>/dev/null; then
  echo "VS Code not found. Install from https://code.visualstudio.com/"
fi

# --- Claude Code CLI ---
if ! command -v claude &>/dev/null; then
  echo "Installing Claude Code CLI..."
  npm install -g @anthropic-ai/claude-code
fi

# --- Aider ---
if ! command -v aider &>/dev/null; then
  echo "Installing Aider..."
  pip3 install aider-chat
fi

# --- JupyterLab ---
pip3 install --user jupyterlab

echo ""
echo "=== Done! ==="
echo "Next steps:"
echo "  1. Copy .env.example to .env and add your API keys"
echo "  2. Run: ollama pull llama3.2   (or your preferred model)"
echo "  3. Open VS Code and install the recommended extensions (see stack/vscode-extensions.txt)"
