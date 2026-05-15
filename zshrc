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

# Aliases
if [[ "$(uname)" == "Darwin" ]]; then
  alias ls='ls -FGa'
else
  alias ls='ls -Fa --color=auto'
fi
alias e='$EDITOR'
alias g='git'
alias ccat='~/.local/bin/pygmentize -g'
alias vim=nvim
alias yaml2js="python -c 'import sys, yaml, json; json.dump(yaml.load(sys.stdin), sys.stdout, indent=4)'"
alias dh="dirs -v" # nicer list for directory history
alias md="glow -p"

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
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.config/linear/config.zsh ] && source ~/.config/linear/config.zsh
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Per-host overrides (untracked). Sourced last so it can override anything above.
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
