#!/usr/bin/env bash
set -euo pipefail

# Install AI coding agent CLIs:
#   - Claude Code (Anthropic)
#   - OpenAI Codex
#   - pi coding agent (pi.dev)

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

info()  { echo -e "${GREEN}[info]${NC} $*"; }
warn()  { echo -e "${YELLOW}[warn]${NC} $*"; }
error() { echo -e "${RED}[error]${NC} $*"; }

command_exists() { command -v "$1" &>/dev/null; }

# ---------- Claude Code ----------
install_claude() {
  if command_exists claude; then
    info "Claude Code already installed: $(claude --version 2>/dev/null || echo 'unknown version')"
    return 0
  fi

  info "Installing Claude Code..."
  curl -fsSL https://claude.ai/install.sh | bash -s stable
  info "Claude Code installed."
}

# ---------- OpenAI Codex ----------
install_codex() {
  if command_exists codex; then
    info "OpenAI Codex already installed: $(codex --version 2>/dev/null || echo 'unknown version')"
    return 0
  fi

  if ! command_exists npm; then
    error "npm is required to install OpenAI Codex. Install Node.js first."
    return 1
  fi

  info "Installing OpenAI Codex..."
  npm install -g @openai/codex
  info "OpenAI Codex installed."
}

# ---------- pi coding agent ----------
install_pi() {
  if command_exists pi; then
    info "pi coding agent already installed: $(pi --version 2>/dev/null || echo 'unknown version')"
    return 0
  fi

  if ! command_exists npm; then
    error "npm is required to install pi coding agent. Install Node.js first."
    return 1
  fi

  info "Installing pi coding agent..."
  npm install -g @mariozechner/pi-coding-agent
  info "pi coding agent installed."
}

# ---------- Main ----------
main() {
  local tools=("$@")
  local failures=0

  # Default: install all
  if [[ ${#tools[@]} -eq 0 ]]; then
    tools=(claude codex pi)
  fi

  for tool in "${tools[@]}"; do
    case "$tool" in
      claude) install_claude || ((failures++)) ;;
      codex)  install_codex  || ((failures++)) ;;
      pi)     install_pi     || ((failures++)) ;;
      *)
        error "Unknown tool: $tool (valid: claude, codex, pi)"
        ((failures++))
        ;;
    esac
  done

  echo ""
  if [[ $failures -eq 0 ]]; then
    info "All done."
  else
    warn "$failures tool(s) failed to install."
    return 1
  fi
}

main "$@"
