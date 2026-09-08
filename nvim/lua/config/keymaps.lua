-- Keymaps are automatically loaded on the VeryLazy event.
--
-- Personal maps ported from the old settings.vim, minus what LazyVim covers:
--   <C-s>          save file (was: leave insert)
--   > / < (visual) reselect after indent (LazyVim)
--   <Esc>          clear hlsearch (LazyVim)
--   ]q / [q        quickfix next/prev (LazyVim)
--   <leader>1-9    buffer switching (LazyVim bufferline — replaces tab numbers)
--   <leader><Space>, <leader>ff, <leader>fb, <leader>sg  snacks picker
--   K              LSP hover (replaces the old split-line-at-cursor)
local map = vim.keymap.set

-- Old <Leader>n habit: toggle relative line numbers
map("n", "<leader>n", function()
	vim.opt.relativenumber = not vim.opt.relativenumber:get()
end, { desc = "Toggle relative line numbers" })

-- Visual mode: keep selection when indenting; Tab/S-Tab as shift
map("v", "<Tab>", ">gv", { desc = "Indent selection" })
map("v", "<S-Tab>", "<gv", { desc = "Dedent selection" })
map("i", "<S-Tab>", "<Esc><<i")

-- Repeat last edit but keep the cursor where it was
map("n", ".", ".`[", { remap = true })

-- One Escape to leave terminal-mode
map("t", "<C-o>", [[<C-\><C-n>]], { desc = "Leave terminal mode" })

-- Search for the visual selection with * (forward) / # (backward)
map("v", "*", [[y/\V<C-R>=substitute(escape(@@,"/\\"),"\n","\\\\n","ge")<CR><CR>]])
map("v", "#", [[y?\V<C-R>=substitute(escape(@@,"?\\"),"\n","\\\\n","ge")<CR><CR>]])

-- vim-test (strategy: neovim — see plugins/personal.lua)
map("n", "<leader>af", "<cmd>TestFile<cr>", { desc = "Test file" })
map("n", "<leader>an", "<cmd>TestNearest<cr>", { desc = "Test nearest" })
map("n", "<leader>al", "<cmd>TestLast<cr>", { desc = "Test last" })
map("n", "<leader>as", "<cmd>TestSuite<cr>", { desc = "Test suite" })
map("n", "<leader>av", "<cmd>TestVisit<cr>", { desc = "Test visit" })

-- vim-dispatch
map("n", "<leader>m", "<cmd>Make<cr>", { desc = "Make" })
