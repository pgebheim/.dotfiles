
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# .zshrc
# Lazy-load antidote and generate the static load file only when needed
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

# [[ $TMUX != "" ]] && export TERM="tmux-256color"
COLORTERM="truecolor"

# fzf binary, completion, and zsh key bindings
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git --ignore node_modules -g ""'
export FZF_DEFAULT_OPTS='
    --height 40% --reverse --border
    --color=bg+:#3a3f5c,bg:#1a1d2e,fg:#c3ccdc,fg+:#ffffff
    --color=hl:#82aaff,hl+:#82aaff,info:#a1cd5e
    --color=prompt:#82aaff,pointer:#FAB387,marker:#A6E3A1
    --color=spinner:#FAB387,header:#7c8898,border:#3a3f5c'

export EDITOR='nvim'
export VISUAL='nvim'

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

fe() { vim -c ":FZF" }
vack() { vim -c "Ack \"${@}\"" }

# Set emacs mode to restore ctrl-a
bindkey -e
#bindkey '^[[1;9C' forward-word
#bindkey '^[[1;9D' backward-word

# eval "$(rbenv init -)" 

setopt hist_ignore_all_dups
setopt hist_ignore_space

export HISTSIZE=1000000
export SAVEHIST=$HISTSIZE
export HISTFILESIZE=1000000
export HISTFILE=~/.zsh_history
#append into history file
setopt INC_APPEND_HISTORY
#save only one command if 2 common are same and consistent
setopt HIST_IGNORE_DUPS
#add timestamp for each entry
setopt EXTENDED_HISTORY 

export pager='less -FRX'
export DOCKERCLOUD_NAMESPACE=augurproject

# Rust
[ -r $HOME/.cargo/env ] && . $HOME/.cargo/env

setopt sharehistory

bindkey '^[[1;5C' forward-word                    # [Ctrl-RightArrow] - move forward one word
bindkey '^[[1;5D' backward-word                   # [Ctrl-LeftArrow] - move backward one word 
bindkey "^[[A" history-search-backward            # start typing + [Up-Arrow] - fuzzy find history forward  
bindkey "^[[B" history-search-forward             # start typing + [Down-Arrow] - fuzzy find history backward

function ipfs() {
    docker exec ipfs_host ipfs "$@"
}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

[ -f ~/.config/linear/config.zsh ] && source ~/.config/linear/config.zsh

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export GO_HOME="$HOME/go"
export PATH="$GO_HOME/bin:$BUN_INSTALL/bin:$HOME/.local/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export RTK_TELEMETRY_DISABLED=1

# Added by flyctl installer
export FLYCTL_INSTALL="/home/arch/.fly"
export PATH="$FLYCTL_INSTALL/bin:$PATH"
