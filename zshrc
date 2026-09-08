# Sourced for interactive zsh sessions. Env vars belong in zshenv.

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Lazy-load antidote and regenerate the static bundle only when txt changes.
zsh_plugins=${ZDOTDIR:-$HOME}/.zsh_plugins
antidote_path="${HOME}/.antidote"
if [[ -n "$antidote_path" && ! ${zsh_plugins}.zsh -nt ${zsh_plugins}.txt ]]; then
  (
    source ${antidote_path}/antidote.zsh
    antidote bundle <${zsh_plugins}.txt >${zsh_plugins}.zsh
  )
fi
source ${zsh_plugins}.zsh

autoload -Uz compinit
compinit

# Completion feel — ported from Omarchy's bash inputrc
zmodload zsh/complist
# Tab completes the common prefix, then opens a selectable list
# (arrows/Tab cycle, Shift-Tab reverses)
zstyle ':completion:*' menu select
# Case-insensitive matching
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
# Colored file listings in completions (like readline's colored-stats)
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# ls -F-style suffixes in listings (*/@ markers, like visible-stats)
setopt list_types
# Ask before listing only when there are more than 200 matches
LISTMAX=200

# Aliases
# eza with icons when available (Omarchy-style listing); plain ls fallback
if command -v eza &>/dev/null; then
  alias ls='eza -lh --group-directories-first --icons=auto'
  alias lsa='ls -a'
  alias lt='eza --tree --level=2 --long --icons --git'
  alias lta='lt -a'
elif [[ "$(uname)" == "Darwin" ]]; then
  alias ls='ls -FGa'
else
  alias ls='ls -Fa --color=auto'
fi
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias e='$EDITOR'
alias g='git'
alias ccat='~/.local/bin/pygmentize -g'
alias vim=nvim
alias yaml2js="python -c 'import sys, yaml, json; json.dump(yaml.load(sys.stdin), sys.stdout, indent=4)'"
alias dh="dirs -v" # nicer list for directory history
alias md="glow -p"
# fzf file picker with preview (bat, or kitty image previews in kitty)
if [[ "$TERM" == "xterm-kitty" ]] && command -v bat &>/dev/null; then
  alias ff="fzf --preview 'case \$(file --mime-type -b {}) in image/*) kitty icat --clear --transfer-mode=memory --stdin=no --place=\${FZF_PREVIEW_COLUMNS}x\${FZF_PREVIEW_LINES}@0x0 {} ;; *) bat --style=numbers --color=always {} ;; esac'"
elif command -v bat &>/dev/null; then
  alias ff='fzf --preview "bat --style=numbers --color=always {}"'
fi
n() { if [ "$#" -eq 0 ]; then command nvim .; else command nvim "$@"; fi; }

# Functions
fe() { vim -c ":FZF" }
vack() { vim -c "Ack \"${@}\"" }

# Emacs keybindings (restores ctrl-a)
bindkey -e
bindkey '^[[1;5C' forward-word                    # [Ctrl-RightArrow] - move forward one word
bindkey '^[[1;5D' backward-word                   # [Ctrl-LeftArrow] - move backward one word
bindkey "^[[A" history-search-backward            # start typing + [Up-Arrow] - fuzzy find history forward
bindkey "^[[B" history-search-forward             # start typing + [Down-Arrow] - fuzzy find history backward

# History
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt EXTENDED_HISTORY
setopt sharehistory
export HISTSIZE=1000000
export SAVEHIST=$HISTSIZE
export HISTFILESIZE=1000000
export HISTFILE=~/.zsh_history

# Tool integrations
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.config/linear/config.zsh ] && source ~/.config/linear/config.zsh
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Per-host overrides (untracked). Sourced last so it can override anything above.
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
