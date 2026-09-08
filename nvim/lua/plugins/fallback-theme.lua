-- Fallback colorscheme for machines without Omarchy. The theme.lua delegator
-- returns nothing there, so nightfly steps in. On Omarchy machines the state
-- directory exists and this spec is skipped entirely.
return {
	{
		"bluz71/vim-nightfly-colors",
		name = "nightfly",
		lazy = false,
		priority = 1000,
		cond = function()
			return vim.uv.fs_stat(vim.fn.expand("~/.local/state/omarchy")) == nil
		end,
		config = function()
			vim.cmd.colorscheme("nightfly")
		end,
	},
}
