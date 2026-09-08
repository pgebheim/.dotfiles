-- Options are automatically loaded before lazy.nvim startup.

-- Omarchy defaults
vim.opt.relativenumber = false
vim.g.autoformat = false

-- OSC 52 clipboard bridging for sessions whose yanks may need to reach
-- another machine (tmux/Wayland/SSH). Linux-only (/proc-based), so skip it
-- elsewhere; every failure mode inside is already pcall'd as well.
if vim.uv.fs_stat("/proc") then
	pcall(function()
		require("config.remote_clipboard").setup()
	end)
end

-- Personal preferences, ported from the old settings.vim. Anything LazyVim
-- already covers (indent, splits, clipboard, undofile, search, wildmode,
-- inccommand, mouse, cursorline, completeopt, ...) is intentionally absent.
vim.opt.whichwrap:append("<,>,[,]")
vim.opt.scrolloff = 8 -- LazyVim default is 4; keep the old 8-line margin
vim.opt.sidescrolloff = 15
vim.opt.sidescroll = 1
vim.opt.spellfile = vim.fn.expand("~/.vim/spellfile.en.add")
vim.opt.foldenable = false -- open all folds by default
vim.opt.title = true -- herdr/hyprland pick this up for window titles
vim.opt.titlestring = [[%t%(\ %M%)%(\ (%{expand("%:~:.:h")})%)%(\ %a%)]]
vim.opt.wildignore:append({
	"*.o",
	"*.obj",
	".git",
	"*.swp",
	"*.pyc",
	"*vim/backups*",
	"*sass-cache*",
	"*DS_Store*",
	"*.gem",
	"vendor/rails/**",
	"vendor/cache/**",
	"log/**",
	"tmp/**",
	"*.png",
	"*.jpg",
	"*.gif",
})
