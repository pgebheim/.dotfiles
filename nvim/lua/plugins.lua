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

  -- Markdown / treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").install({ "markdown", "markdown_inline" })
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
    opts = {},
  },
}
