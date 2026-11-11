# Sourced for login shells, after zshenv and before zshrc.
# Most env setup lives in zshenv; reserve this for login-only side effects.

[ -f ~/.zprofile.local ] && source ~/.zprofile.local

# Hermes Agent command
case ":$PATH:" in *":$HOME/.local/bin:"*) ;; *) export PATH="$HOME/.local/bin:$PATH" ;; esac
