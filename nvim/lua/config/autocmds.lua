-- Autocmds are automatically loaded on the VeryLazy event.
--
-- Filetype tweaks ported from the old settings.vim. (The old TSRename map and
-- npm makeprg went away in favor of LSP rename and conform/lint.)

local augroup = vim.api.nvim_create_augroup("paul_filetypes", { clear = true })

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	group = augroup,
	pattern = "*.vhost",
	callback = function()
		vim.bo.filetype = "nginx"
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = augroup,
	pattern = "python",
	callback = function()
		vim.bo.shiftwidth = 4
		vim.bo.tabstop = 4
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = augroup,
	pattern = "gitcommit",
	callback = function()
		vim.bo.spell = true
		vim.bo.textwidth = 72
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = augroup,
	pattern = "markdown",
	callback = function()
		vim.bo.spell = true
		vim.bo.textwidth = 120
		vim.wo.wrap = true
		vim.wo.linebreak = true
		vim.wo.number = false
		vim.wo.relativenumber = false
	end,
})

-- Marker folding for C/C++
vim.api.nvim_create_autocmd("FileType", {
	group = augroup,
	pattern = { "c", "cpp" },
	callback = function()
		vim.bo.foldmethod = "marker"
	end,
})
