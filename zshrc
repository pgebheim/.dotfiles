
eval "$(keychain --eval --agents ssh github_rsa id_rsa)"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

local -A ZPLGM
ZPLGM[HOME_DIR]="${ZDOTDIR:-$HOME}/.zplugin"
if [[ ! -d "${ZPLGM[HOME_DIR]}" ]]; then
  mkdir -p "${ZPLGM[HOME_DIR]}"
  git clone https://github.com/zdharma/zplugin.git "${ZPLGM[HOME_DIR]}/bin"
fi
source "${ZPLGM[HOME_DIR]}/bin/zplugin.zsh"
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin

[[ $TMUX != "" ]] && export TERM="screen-256color"

###################################################
# zplugin
#

# zplugin customization goes here
zplugin light zdharma/zui
zplugin light zdharma/zplugin-crasis

# Powerlevel 10k for awesome prompts
zplugin ice depth=1; zplugin light romkatv/powerlevel10k

# nvm (auto detects .nvmrc)
export NVM_LAZY_LOAD=false
export NVM_AUTO_USE=true
zplugin light lukechilds/zsh-nvm

# npm
zplugin light 'lukechilds/zsh-better-npm-completion'

# fzf binary, completion, and zsh key bindings
export FZF_DEFAULT_OPTS='--height 40% --reverse --border --preview="~/go/bin/chroma --style=solarized-dark {}"'
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git --ignore node_modules -g ""'
zplugin ice from"gh-r" as"program"; zplugin load junegunn/fzf-bin
zplugin snippet 'https://github.com/junegunn/fzf/blob/master/shell/key-bindings.zsh'
zplugin snippet 'https://github.com/junegunn/fzf/blob/master/shell/completion.zsh'

# diff-so-fancy
zplugin ice as"program" pick"bin/git-dsf" wait"0" lucid
zplugin light zdharma/zsh-diff-so-fancy

# completions from prezto
zplugin snippet PZT::modules/completion/init.zsh

# autojump for `j` support
zplugin snippet OMZ::plugins/autojump/autojump.plugin.zsh

# needs to be run before last plugin is loaded
zplugin ice atinit"autoload compinit; mkdir -p $HOME/.cache/zsh; compinit -d $HOME/.cache/zsh/zcompdump-$ZSH_VERSION; zpcdreplay" wait"1" silent
zplugin light zdharma/fast-syntax-highlighting

# User configuration

export EDITOR='nvim'

alias ls='ls -FGa --color=auto --group-directories-first'
alias e='$EDITOR'
alias g='git'
alias ccat='~/.local/bin/pygmentize -g'
alias vim=nvim
alias yaml2js="python -c 'import sys, yaml, json; json.dump(yaml.load(sys.stdin), sys.stdout, indent=4)'"
alias dh="dirs -v" # nicer list for directory history
alias in3='docker run slockit/in3'

fe() { vim -c ":FZF" }
vack() { vim -c "Ack \"${@}\"" }

# bindkey -e
#bindkey '^[[1;9C' forward-word
#bindkey '^[[1;9D' backward-word

# eval "$(rbenv init -)" 

export HISTFILE=~/.zsh_history
export GOPATH=$HOME/go
export PATH="$HOME/.yarn/bin:$PATH:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/snap/bin:$HOME/.local/bin:$HOME/.rvm/bin:$GOROOT/bin:$GOPATH/bin"

export pager='less -FRX'
export DOCKERCLOUD_NAMESPACE=augurproject

# Rust
source $HOME/.cargo/env

setopt sharehistory

bindkey '^[[1;5C' forward-word                    # [Ctrl-RightArrow] - move forward one word
bindkey '^[[1;5D' backward-word                   # [Ctrl-LeftArrow] - move backward one word 
bindkey "^[[A" history-search-backward            # start typing + [Up-Arrow] - fuzzy find history forward  
bindkey "^[[B" history-search-forward             # start typing + [Down-Arrow] - fuzzy find history backward

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh