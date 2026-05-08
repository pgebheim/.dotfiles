return {
  -- Navigation
  "christoomey/vim-tmux-navigator",
  "scrooloose/nerdtree",
  "Xuyuanp/nerdtree-git-plugin",

  -- UI / colors
  {
    "bluz71/vim-nightfly-colors",
    name = "nightfly",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("nightfly")
    end,
  },
  {
    "bling/vim-airline",
    init = function()
      vim.g.airline_theme = "dark"
      vim.g["airline#extensions#tabline#enabled"] = 1
    end,
  },

  -- Editing
  {
    "jiangmiao/auto-pairs",
    init = function()
      vim.g.AutoPairsFlyMode = 0
    end,
  },
  "tpope/vim-abolish",
  "tpope/vim-surround",
  "tpope/vim-characterize",
  {
    "editorconfig/editorconfig-vim",
    init = function()
      vim.g.EditorConfig_exclude_patterns = { "fugitive://.*", "scp://.*" }
    end,
  },

  -- Git
  "tpope/vim-fugitive",
  "tpope/vim-rhubarb",
  "mattn/webapi-vim",
  "mattn/gist-vim",

  -- Build / test / dispatch
  "tpope/vim-dispatch",
  {
    "janko-m/vim-test",
    init = function()
      vim.g["test#strategy"] = "neovim"
      vim.g["test#javascript#jest#file_pattern"] =
        [[\v((__tests__|spec|test)/.*\.(js|jsx|coffee|ts|tsx))|(.*\.test\.(js|jsx|coffee|ts|tsx))$]]
    end,
  },
  {
    "mileszs/ack.vim",
    init = function()
      if vim.fn.executable("rg") == 1 then
        vim.g.ackprg = "rg --column"
      elseif vim.fn.executable("ag") == 1 then
        vim.g.ackprg = "ag --nogroup --nocolor --column"
      end
    end,
  },

  -- Search / files
  {
    "junegunn/fzf",
    build = "./install --bin",
  },
  {
    "junegunn/fzf.vim",
    dependencies = { "junegunn/fzf" },
    init = function()
      vim.g.fzf_buffers_jump = 1
      vim.g.fzf_commits_log_options =
        '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'
      vim.g.fzf_tags_command = "ctags -R"
      vim.g.fzf_commands_expect = "alt-enter,ctrl-x"
      if vim.fn.executable("rg") == 1 then
        vim.env.FZF_DEFAULT_COMMAND = "rg --files -S"
      elseif vim.fn.executable("ag") == 1 then
        vim.env.FZF_DEFAULT_COMMAND = 'ag -g ""'
      end
    end,
  },

  -- Languages
  "godlygeek/tabular",
  "hashivim/vim-terraform",
  "posva/vim-vue",
  "digitaltoad/vim-jade",
  "isobit/vim-caddyfile",
  "HerringtonDarkholme/yats.vim",
  "tomlion/vim-solidity",
  "pangloss/vim-javascript",
  "jason0x43/vim-js-indent",
  "chrisbra/csv.vim",

  -- Formatting
  {
    "prettier/vim-prettier",
    build = "yarn install",
    ft = { "javascript", "typescript", "css", "less", "scss", "json", "graphql" },
  },

  -- Focus mode
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    keys = {
      { "<leader>z", "<cmd>ZenMode<cr>", desc = "Toggle Zen Mode" },
    },
    opts = {},
  },

  -- Markdown editing
  {
    "dkarter/bullets.vim",
    ft = { "markdown", "text", "gitcommit" },
    init = function()
      vim.g.bullets_enabled_file_types = { "markdown", "text", "gitcommit" }
    end,
  },

  -- Markdown / treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").install({
        "markdown", "markdown_inline",
        "bash", "c", "cpp", "css", "go", "html", "javascript", "json",
        "lua", "python", "ruby", "rust", "sql", "terraform", "tsx",
        "typescript", "vim", "vimdoc", "vue", "yaml",
      })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "markdown" },
        callback = function() vim.treesitter.start() end,
      })
    end,
  },
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
      checkbox = { enabled = true },
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
      local pink   = "#F25D94"
      local blue   = "#0EBCF2"
      local cream  = "#FAFB75"
      local mute1  = "#A0A0A0"
      local mute2  = "#6E6E6E"
      local code_bg = "#1F1F1F"
      local code_fg = "#E5E5E5"
      local hr      = "#5C5C5C"

      set(0, "RenderMarkdownH1",   { fg = "#FFFFFF", bold = true })
      set(0, "RenderMarkdownH1Bg", { bg = purple, fg = "#FFFFFF", bold = true })
      set(0, "RenderMarkdownH2",   { fg = pink,   bold = true })
      set(0, "RenderMarkdownH2Bg", { bg = "#2A1722", fg = pink, bold = true })
      set(0, "RenderMarkdownH3",   { fg = blue,   bold = true })
      set(0, "RenderMarkdownH3Bg", { bg = "#0F2530", fg = blue, bold = true })
      set(0, "RenderMarkdownH4",   { fg = cream,  bold = true })
      set(0, "RenderMarkdownH4Bg", { bg = "#262617", fg = cream, bold = true })
      set(0, "RenderMarkdownH5",   { fg = mute1,  bold = true })
      set(0, "RenderMarkdownH5Bg", { bg = "NONE", fg = mute1, bold = true })
      set(0, "RenderMarkdownH6",   { fg = mute2,  bold = true })
      set(0, "RenderMarkdownH6Bg", { bg = "NONE", fg = mute2, bold = true })

      set(0, "RenderMarkdownCode",         { bg = code_bg })
      set(0, "RenderMarkdownCodeInline",   { fg = "#6CA0DC" })
      set(0, "RenderMarkdownCodeBorder",   { fg = hr, bg = code_bg })
      set(0, "RenderMarkdownLanguage",     { fg = blue, bg = code_bg, italic = true })

      set(0, "RenderMarkdownBullet",   { fg = cream })
      set(0, "RenderMarkdownQuote",    { fg = mute1, italic = true })
      set(0, "RenderMarkdownDash",     { fg = hr })
      set(0, "RenderMarkdownLink",     { fg = blue, underline = true })
      set(0, "RenderMarkdownTableHead",{ fg = pink, bold = true })
      set(0, "RenderMarkdownTableRow", { fg = code_fg })
    end,
  },
}
