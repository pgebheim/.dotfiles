# Dotfiles

Paul's personal dotfiles, managed with [dotbot](https://github.com/anishathalye/dotbot).

## Setup

- **Install**: `./install` — runs dotbot to symlink everything into `~`
- **Config mapping**: `install.conf.yaml` defines all symlinks
- Submodules are initialized automatically during install

## Structure

| File/Dir | Purpose |
|---|---|
| `vimrc` | Vim/Neovim config (symlinked to both `~/.vimrc` and `~/.config/nvim/init.vim`) |
| `vim/` | Vim runtime files (colors, autoload, spell) — symlinked to `~/.vim` and neovim site |
| `zshrc` | Zsh config (antidote plugin manager, p10k prompt) |
| `tmux.conf` | Tmux config (prefix is `C-a`, uses tpm for plugins) |
| `gitconfig` | Git config with aliases and color settings |
| `bashrc`, `bash_profile`, `profile` | Legacy bash configs |
| `ssh/` | SSH config |
| `dotbot/` | Dotbot submodule (install framework) |
| `tmux/plugins/` | Tmux plugin submodules (tpm, vim-tmux-navigator, etc.) |

## Key details

- **Editor**: neovim (`nvim`), aliased as `vim`
- **Vim plugin manager**: vim-plug (`plug#begin` / `plug#end` in vimrc)
- **Zsh plugin manager**: antidote (via homebrew at `/opt/homebrew/opt/antidote`)
- **Tmux plugin manager**: tpm
- **Colorscheme**: nightfly
- **Default indentation**: 2 spaces (expandtab)
- **Fuzzy finder**: fzf (with rg/ag backends)
- **Tmux prefix**: `C-a` (not the default `C-b`)

## Working with these files

- After editing `vimrc`, vim auto-sources on save. Otherwise `:source %` or restart.
- After editing `tmux.conf`, reload with `tmux source ~/.tmux.conf` or `prefix + I` for plugins.
- After editing `zshrc`, reload with `source ~/.zshrc` or open a new shell.
- Run `./install` after adding new symlink entries to `install.conf.yaml`.
- Vim plugins: add `Plug '...'` lines in vimrc, then run `:PlugInstall` in vim.
- Tmux plugins: add `set -g @plugin '...'` lines in tmux.conf, then `prefix + I` to install.
