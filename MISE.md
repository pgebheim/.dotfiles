# mise in this repo

mise manages **two things** here: machine tools (node, bun, pnpm, pi, codex) and
dotfiles (everything dotbot used to symlink). One tracked config, one command
set, same flow on every host.

## The model in one diagram

```
~/.dotfiles  (this repo = MISE_CONFIG_DIR, exported by zshenv/bashrc)
├── config.toml           [tools] pins + [dotfiles] table — ALL machines
├── config.omarchy.toml   omarchy-only dotfiles — layered when MISE_ENV=omarchy
└── install.conf.yaml     dotbot remnants: setup hooks only (submodules,
                          nvim plugin sync, macOS LaunchAgents)
```

- The repo root **is** the global mise config dir (`MISE_CONFIG_DIR`). No
  symlinks into `~/.config/mise` — those broke source resolution (see Gotchas).
- `MISE_ENV=omarchy` is set by a path guard in `zshenv`/`bashrc`
  (`[[ -d /usr/share/omarchy ]]`), so machines self-select their profile.
- Dotfiles modes: `symlink` (default — edits through `~` land in git),
  `symlink-each` (`~/.local/bin`), `copy` (the omarchy `.local` files — the
  live file stays a real, hand-tweakable per-machine file; re-apply refreshes
  it from the repo).

## Daily use

```sh
mise ls                              # what's pinned / installed / missing
mise install                         # install everything in [tools]
mise use -g node@26.8.1              # change a pin — writes config.toml (git!)
mise upgrade                         # bump everything pinned "latest"

# dotfiles loop (after editing anything in the repo):
mise bootstrap dotfiles status       # applied / differs / missing
mise bootstrap dotfiles diff         # what would change
mise bootstrap dotfiles apply        # push it live

# copy-mode round trip (the ~/.local files):
mise bootstrap dotfiles add ~/.zshrc.local   # save live tweaks back to repo
```

Every command works from any directory; `MISE_CONFIG_DIR` comes from `zshenv`.

## Adding a new dotfile

1. Drop the file in the repo (e.g. `~/.dotfiles/foot.ini`).
2. Add a line to `[dotfiles]` in `config.toml`: `"~/.config/foot/foot.ini" = "foot.ini"`.
3. Commit, push, `mise bootstrap dotfiles apply` on each machine.

For a whole directory of scripts: `"~/.local/bin" = { source = "local/bin", mode = "symlink-each" }`.

## New machine bootstrap

```sh
# 1. install mise (pacman / brew / https://mise.jdx.dev)
# 2. clone (or pull) this repo to ~/.dotfiles
git clone git@github.com:pgebheim/.dotfiles ~/.dotfiles   # or: git -C ~/.dotfiles pull
# 3. zshenv (now linked or linkable) exports MISE_CONFIG_DIR — nothing else to wire
# 4. tools + dotfiles:
mise install
mise bootstrap dotfiles apply --force ~/.zshrc ~/.bashrc ~/.bash_profile ~/.bash_logout
mise bootstrap dotfiles apply
# 5. optional extras:
./install        # dotbot hooks: submodules, nvim plugins, macOS LaunchAgents
```

Back up any pre-existing real dotfiles first (we keep ours in
`~/.pre-mise-flip-<date>/` on flipped machines).

## Machine profiles

| Machine | State | Profile |
|---|---|---|
| this box (Omarchy arch) | flipped: mise owns tools + dotfiles | `omarchy` layer active |
| claw (plain arch) | flipped | base |
| nami (macOS), ohara, zoro | old dotbot flow, converge with the playbook above | base |

To add a profile (e.g. `work`): create `config.work.toml` in the repo, then set
`MISE_ENV=work` for those machines (path guard in zshenv, or untracked
`~/.zshenv.local`). `mise bootstrap -E work dotfiles apply` reconciles links
between profiles.

## Gotchas (learned the hard way)

- **Never symlink config into `~/.config/mise`.** Relative dotfile sources
  resolve against the directory containing the config *file*, and mise does
  not canonicalize symlinks — every source went "missing". `MISE_CONFIG_DIR`
  pointing at the repo root is the mechanism; protect it.
- **Stray config writes.** Any process running mise *without*
  `MISE_CONFIG_DIR` (cron, systemd, non-shell contexts) writes pins to
  `~/.config/mise/config.toml`. If you find that file, it's a stray — delete
  it (or move the pin into the tracked config). Permanent fix (system-wide
  env) is pending Stage 4.
- **`apply` overwrites live edits** in copy mode — use `add` to save them back
  first. Symlink-mode files have no such issue (edits ARE repo edits).
- **tmux servers cache config.** After changing tmux/zsh/p10k files, restart
  tmux or `source-file ~/.config/tmux/tmux.conf`; old servers keep old options.
- **`latest` pins drift per host** (codex, pnpm) until `mise.lock` lands —
  Stage 4. `mise ls` shows what resolved where.
- **mise moves fast.** pacman build 2026.9.1 vs .12 in a week. After upgrades,
  check `mise bootstrap dotfiles status` still says all applied.

## Still dotbot (until Stage 4)

`./install` remains valid and idempotent for: git submodules (antidote/tpm),
nvim plugin sync (`Lazy! sync`), macOS LaunchAgents. Dotfile ownership is
mise's; running `./install` will not fight it.

Stage 4 (not yet done): `mise bootstrap dotfiles origin` sync + `history-watch`
service, `mise.lock`, system-wide `MISE_CONFIG_DIR`, retire dotbot, rewrite
CLAUDE.md.
