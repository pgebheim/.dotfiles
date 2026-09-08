# Sourced for every zsh invocation (scripts, cron, ssh host cmd, interactive).
# Keep this lightweight — env vars only, nothing that touches the prompt or
# does heavy I/O.

export EDITOR='nvim'
export VISUAL='nvim'
#export TERM="tmux-256color"
export COLORTERM="truecolor"
export pager='less -FRX'

# PATH
export GO_HOME="$HOME/go"
export PATH="$GO_HOME/bin:$HOME/.local/bin:$HOME/.cargo/bin:$PATH"

# mise shims (managed tools: node, bun, pnpm, pi, codex). Static entry —
# populated by `mise install`, no eval cost. Precedes /usr/bin so managed
# tools win over pacman/brew copies on every host.
export PATH="$HOME/.local/share/mise/shims:$PATH"

# Rust toolchain env (sets PATH defensively if cargo is installed)
[ -r "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

# mise: the dotfiles repo doubles as the global mise config dir (tracked
# config.toml = tool pins + dotfiles table), so no symlinks are needed and
# relative dotfile sources resolve against the repo root.
export MISE_CONFIG_DIR="$HOME/.dotfiles"
# mise: Omarchy machines opt into the `omarchy` config layer
# (config.omarchy.toml: Omarchy-only dotfiles). Path-guarded so other machines
# silently use the base config only.
[ -d /usr/share/omarchy ] && export MISE_ENV=omarchy

# Color man pages with bat when available (Omarchy-style)
if command -v bat &>/dev/null; then
    export MANROFFOPT="-c"
    export MANPAGER="sh -c 'col -bx | bat -l man -p'"
fi

# fzf defaults
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git --ignore node_modules -g ""'
export FZF_DEFAULT_OPTS='
    --height 40% --reverse --border
    --color=bg+:#3a3f5c,bg:#1a1d2e,fg:#c3ccdc,fg+:#ffffff
    --color=hl:#82aaff,hl+:#82aaff,info:#a1cd5e
    --color=prompt:#82aaff,pointer:#FAB387,marker:#A6E3A1
    --color=spinner:#FAB387,header:#7c8898,border:#3a3f5c'

export RTK_TELEMETRY_DISABLED=1

# Persist forwarded SSH agent socket so mosh/tmux reattaches can reuse it.
[ -f ~/.local/bin/ssh-agent-sock.sh ] && source ~/.local/bin/ssh-agent-sock.sh

[ -f ~/.zshenv.local ] && source ~/.zshenv.local
