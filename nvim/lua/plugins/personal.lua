-- Personal plugins carried over from the pre-LazyVim config.
--
-- Deliberately kept for muscle memory or because they have no LazyVim
-- equivalent. What LazyVim already covers was dropped: fzf.vim (snacks
-- picker), airline (lualine), nerdtree (neo-tree), fugitive/rhubarb/gist
-- (lazygit + gitsigns + Snacks.gitbrowse), ack.vim (snacks grep),
-- auto-pairs (mini.pairs), vim-surround (mini.surround), editorconfig
-- (built-in), vim-prettier (conform), treesitter config (LazyVim default).
return {
	-- Pane navigation: herdr first, plain tmux fallback (see lua/herdr_nav.lua)
	{
		"christoomey/vim-tmux-navigator",
		init = function()
			vim.g.tmux_navigator_no_mappings = 1
		end,
	},

	-- Editing
	"tpope/vim-abolish",
	"tpope/vim-characterize",
	"godlygeek/tabular",
	{
		"dhruvasagar/vim-table-mode",
		cmd = { "TableModeToggle", "TableModeEnable", "TableModeRealign", "Tableize" },
		ft = { "markdown" },
		init = function()
			vim.g.table_mode_corner = "|"
		end,
	},
	{
		"dkarter/bullets.vim",
		ft = { "markdown", "text", "gitcommit" },
		init = function()
			vim.g.bullets_enabled_file_types = { "markdown", "text", "gitcommit" }
		end,
	},

	-- Build / test
	"tpope/vim-dispatch",
	{
		"janko-m/vim-test",
		init = function()
			vim.g["test#strategy"] = "neovim"
			vim.g["test#javascript#jest#file_pattern"] =
				[[\v((__tests__|spec|test)/.*\.(js|jsx|coffee|ts|tsx))|(.*\.test\.(js|jsx|coffee|ts|tsx))$]]
		end,
	},

	-- Focus mode
	{
		"folke/zen-mode.nvim",
		cmd = "ZenMode",
		keys = {
			{ "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" },
		},
		opts = {},
	},

	-- Markdown rendering (custom palette, ported from the old setup)
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		ft = "markdown",
		opts = {
			heading = {
				sign = false,
				width = "block",
				left_pad = 1,
				right_pad = 2,
				backgrounds = {
					"RenderMarkdownH1Bg",
					"RenderMarkdownH2Bg",
					"RenderMarkdownH3Bg",
					"RenderMarkdownH4Bg",
					"RenderMarkdownH5Bg",
					"RenderMarkdownH6Bg",
				},
				foregrounds = {
					"RenderMarkdownH1",
					"RenderMarkdownH2",
					"RenderMarkdownH3",
					"RenderMarkdownH4",
					"RenderMarkdownH5",
					"RenderMarkdownH6",
				},
			},
			code = {
				sign = false,
				width = "full",
				left_pad = 2,
				right_pad = 2,
				border = "thin",
				style = "normal",
			},
			bullet = { icons = { "•", "◦", "▪", "▫" } },
			checkbox = {
				enabled = true,
				unchecked = { icon = "󰄱 ", highlight = "RenderMarkdownUnchecked" },
				checked = { icon = "󰄵 ", highlight = "RenderMarkdownChecked" },
			},
			quote = { icon = "▍" },
			dash = { icon = "─" },
			pipe_table = { style = "normal" },
			indent = { enabled = false },
		},
		config = function(_, opts)
			require("render-markdown").setup(opts)
			local set = vim.api.nvim_set_hl
			-- Glow / Charm-inspired palette
			local purple = "#7D56F4"
			local pink = "#F25D94"
			local blue = "#0EBCF2"
			local cream = "#FAFB75"
			local mute1 = "#A0A0A0"
			local mute2 = "#6E6E6E"
			local code_bg = "#161b22"
			local code_fg = "#E5E5E5"
			local hr = "#5C5C5C"
			local warm = "#FAB387" -- bold (peach)
			local cool = "#B4BEFE" -- italic (lavender)
			local green = "#A6E3A1"
			local red = "#F25D94"

			set(0, "RenderMarkdownH1", { fg = "#FFFFFF", bold = true })
			set(0, "RenderMarkdownH1Bg", { bg = purple, fg = "#FFFFFF", bold = true })
			set(0, "RenderMarkdownH2", { fg = pink, bold = true })
			set(0, "RenderMarkdownH2Bg", { bg = "#2A1722", fg = pink, bold = true })
			set(0, "RenderMarkdownH3", { fg = blue, bold = true })
			set(0, "RenderMarkdownH3Bg", { bg = "#0F2530", fg = blue, bold = true })
			set(0, "RenderMarkdownH4", { fg = cream, bold = true })
			set(0, "RenderMarkdownH4Bg", { bg = "#262617", fg = cream, bold = true })
			set(0, "RenderMarkdownH5", { fg = mute1, bold = true })
			set(0, "RenderMarkdownH5Bg", { bg = "NONE", fg = mute1, bold = true })
			set(0, "RenderMarkdownH6", { fg = mute2, bold = true })
			set(0, "RenderMarkdownH6Bg", { bg = "NONE", fg = mute2, bold = true })

			set(0, "RenderMarkdownCode", { bg = code_bg })
			set(0, "RenderMarkdownCodeInline", { fg = "#6CA0DC" })
			set(0, "RenderMarkdownCodeBorder", { fg = hr, bg = code_bg })
			set(0, "RenderMarkdownLanguage", { fg = blue, bg = code_bg, italic = true })

			set(0, "RenderMarkdownBullet", { fg = cream })
			set(0, "RenderMarkdownQuote", { fg = mute1, italic = true })
			set(0, "RenderMarkdownDash", { fg = hr })
			set(0, "RenderMarkdownLink", { fg = blue, underline = true })
			set(0, "RenderMarkdownTableHead", { fg = pink, bold = true })
			set(0, "RenderMarkdownTableRow", { fg = code_fg })

			set(0, "RenderMarkdownChecked", { fg = green })
			set(0, "RenderMarkdownUnchecked", { fg = mute2 })

			set(0, "RenderMarkdownInfo", { fg = blue, bold = true })
			set(0, "RenderMarkdownSuccess", { fg = green, bold = true })
			set(0, "RenderMarkdownHint", { fg = purple, bold = true })
			set(0, "RenderMarkdownWarn", { fg = cream, bold = true })
			set(0, "RenderMarkdownError", { fg = red, bold = true })

			set(0, "@markup.strong.markdown_inline", { fg = warm, bold = true })
			set(0, "@markup.italic.markdown_inline", { fg = cool, italic = true })
		end,
	},

	-- Languages without coverage in the base LazyVim install.
	-- (Treesitter/LSP for mainstream languages come from LazyVim lang extras
	-- if enabled; these are plain syntax/indent plugins for niche filetypes.)
	"hashivim/vim-terraform",
	"posva/vim-vue",
	"digitaltoad/vim-jade",
	"isobit/vim-caddyfile",
	"HerringtonDarkholme/yats.vim",
	"tomlion/vim-solidity",
	"pangloss/vim-javascript",
	"jason0x43/vim-js-indent",
	"chrisbra/csv.vim",
}
