# ~/.bash_profile

[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

# Omarchy relies on bashrc for env setup even in login shells.
[[ -f ~/.bashrc ]] && . ~/.bashrc

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

export PATH="$HOME/.cargo/bin:$PATH"
