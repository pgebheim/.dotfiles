# Fall back to the carrier-maintained agent socket when this shell doesn't
# already have a live forwarded socket (e.g. mosh sessions, tmux panes spawned
# while detached). The symlink is maintained by ssh-carrier on the laptop —
# see local/bin/ssh-carrier and the matching macos/LaunchAgents/*.plist.
#
# We deliberately don't repoint the symlink ourselves: short-lived SSH
# connections (mosh handshakes, ssh host cmd) would otherwise overwrite the
# carrier's stable target with their own about-to-die socket.

if [ -z "$SSH_AUTH_SOCK" ] && [ -S "$HOME/.ssh/agent_sock" ]; then
  export SSH_AUTH_SOCK="$HOME/.ssh/agent_sock"
fi
