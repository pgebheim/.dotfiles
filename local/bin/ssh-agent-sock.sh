# Share SSH agent socket via a stable path so mosh/tmux sessions can reuse
# forwarded agents from a prior SSH connection.

if [ -n "$SSH_AUTH_SOCK" ] && [ "$SSH_AUTH_SOCK" != "$HOME/.ssh/agent_sock" ]; then
  mkdir -p "$HOME/.ssh"
  rm -f "$HOME/.ssh/agent_sock"
  ln -s "$SSH_AUTH_SOCK" "$HOME/.ssh/agent_sock"
  export SSH_AUTH_SOCK="$HOME/.ssh/agent_sock"
fi

if [ -z "$SSH_AUTH_SOCK" ]; then
  export SSH_AUTH_SOCK="$HOME/.ssh/agent_sock"
fi
