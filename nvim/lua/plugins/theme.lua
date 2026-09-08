-- Colorscheme bridge.
--
-- On Omarchy machines, the active theme's neovim spec is generated at
-- ~/.local/state/omarchy/current/theme/neovim.lua (rendered from Omarchy's
-- themed templates on every `omarchy theme set`). We delegate to it here so
-- live theme switching keeps working — omarchy-theme-hotreload.lua
-- pcall-requires "plugins.theme" on LazyReload and re-applies whatever this
-- module returns.
--
-- On machines without Omarchy (macOS etc.) the file does not exist and this
-- returns nothing; lua/plugins/fallback-theme.lua then applies nightfly.
local omarchy_theme = vim.fn.expand("~/.local/state/omarchy/current/theme/neovim.lua")

if vim.uv.fs_stat(omarchy_theme) then
	return dofile(omarchy_theme)
end

return {}
