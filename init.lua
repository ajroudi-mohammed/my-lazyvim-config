vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)


require("dapui").setup({})

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require("nvim-tree").setup({
  renderer = {
    highlight_git = true,
    highlight_opened_files = "all",
    icons = {
      show = {
        git = false,
        folder = true,
        file = true,
      },
    },
  },
  update_focused_file = {
    enable = true,
    update_cwd = false,  -- Prevent automatic cwd updates
    ignore_list = { '*.org' },
  },
  sync_root_with_cwd = true,  -- Align tree root with Neovim's cwd
  view = {
    width = 40,
  }
})

-- require('lspconfig').dartls.setup({})
require('mini.ai').setup({
  custom_textobjects = {
    f = require('mini.ai').gen_spec.treesitter({
      a = '@function.outer',
      i = '@function.inner',
    }),
  },
})
 -- use defaults

require "options"
require "nvchad.autocmds"

local flutter_errors = require("custom.flutter_errors")

vim.api.nvim_create_user_command("FlutterErrors", function()
  flutter_errors.flutter_errors()
end, {})

vim.schedule(function()
  require "mappings"
end)
