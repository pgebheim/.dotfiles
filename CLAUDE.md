# Dotfiles

Paul's personal dotfiles, managed with [dotbot](https://github.com/anishathalye/dotbot).

## Setup

- **Install**: `./install` — runs dotbot to symlink everything into `~`
- **Config mapping**: `install.conf.yaml` defines all symlinks
- Submodules are initialized automatically during install

## Structure

| File/Dir | Purpose |
|---|---|
| `nvim/` | Neovim config directory — symlinked to `~/.config/nvim` |
| `nvim/init.lua` | Neovim entry point (sources `init.vim` for now) |
| `nvim/init.vim` | Cleaned VimScript config (active neovim config) |
| `nvim/lua/` | Future Lua modules (options, keymaps, plugins) |
| `vimrc` | Legacy vim config — symlinked to `~/.vimrc` (may become stale) |
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

- **Neovim config lives in `nvim/`** — edit `nvim/init.vim` for VimScript changes. The Lua entry point (`nvim/init.lua`) sources it automatically.
- Future Lua migration: move chunks from `nvim/init.vim` into `nvim/lua/*.lua` files and `require()` them from `init.lua`.
- After editing neovim config, `:source %` or restart nvim.
- After editing `tmux.conf`, reload with `tmux source ~/.tmux.conf` or `prefix + I` for plugins.
- After editing `zshrc`, reload with `source ~/.zshrc` or open a new shell.
- Run `./install` after adding new symlink entries to `install.conf.yaml`.
- Vim plugins: add `Plug '...'` lines in `nvim/init.vim`, then run `:PlugInstall` in nvim.
- Tmux plugins: add `set -g @plugin '...'` lines in tmux.conf, then `prefix + I` to install.
