return {

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      require "configs.lspconfig"
    end,
  },
  { 
    "mg979/vim-visual-multi", 
      branch = "master" 
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
  {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    -- or if using mini.icons/mini.nvim
    -- dependencies = { "echasnovski/mini.icons" },
    opts = {}
  },
  {
    'nvim-lua/plenary.nvim'
  },
  {
    'stevearc/dressing.nvim',
    opts = {},
  },
  -- Load DAP first
  {
    "mfussenegger/nvim-dap",
    config = function()
      require("configs.dap") 
    end,
    priority = 1000
  },
  {
    'nvim-flutter/flutter-tools.nvim',
    lazy = false,
    dependencies = {
        'nvim-lua/plenary.nvim',
        'stevearc/dressing.nvim', -- optional for vim.ui.select
        'mfussenegger/nvim-dap',
        'rcarriga/nvim-dap-ui',
    },
    config = function()  
      require("flutter-tools").setup {
        debugger = {
          enabled = true,
          run_via_dap = true
        }
      }
    end
  },
  {
    'simrat39/symbols-outline.nvim',
    config = function() 
      require("symbols-outline").setup()      
    end
  },
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config= function()
      local todo_comments = require("todo-comments")
  
      todo_comments.setup()
      end,
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next Todo Comment" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous Todo Comment" },
    },
  },
  {
    "Mofiqul/vscode.nvim",
    opts = {
      style = "dark", -- Options: "dark" or "light"
      transparent = false, -- Set to true if you want a transparent background
    }
  },
  {
    "navarasu/onedark.nvim",
    config= function()
      require('onedark').setup {
          style = 'darker'
      }
      require('onedark').load()
    end,
  },
  { "nvim-neotest/nvim-nio" },
  {
    "lukas-reineke/indent-blankline.nvim",
    opts = {
      indent = { char = "│" }, -- Set a valid indent character
    },
    config = function()
      require("ibl").setup()
    end,
  },
  
  {
  	"nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
  	opts = {
  		ensure_installed = {
  			"vim", "lua", "vimdoc",
       "html", "css", "dart"
  		},
  	},
  },
  {
    'goolord/alpha-nvim',
    config = function ()
        require'alpha'.setup(require'alpha.themes.dashboard'.config)
    end
  },
  {
  "ahmedkhalf/project.nvim",
    opts = {
      manual_mode = true,  -- Set to false for automatic root detection
      detection_methods = { "lsp", "pattern" },
      patterns = { ".git", "Makefile", "package.json" },
      datapath = vim.fn.stdpath("data") .. "/project_nvim",
    },
    config = function(_, opts)
      require("project_nvim").setup(opts)
      local history = require("project_nvim.utils.history")
      history.delete_project = function(project)
        for k, v in pairs(history.recent_projects) do
          if v == project.value then
            history.recent_projects[k] = nil
            return
          end
        end
      end
      -- Optional: Integrate with Telescope for project navigation
      if vim.fn.exists(":Telescope") then
        require("telescope").load_extension("projects")
      end
    end,
  },
  {
      'goolord/alpha-nvim',
      dependencies = { 'echasnovski/mini.icons' },
      config = function ()
          local alpha = require("alpha")
          local startify = require("alpha.themes.startify")

          -- Set header
          startify.section.header.val = {
            "Welcome to Neovim",
            -- Add your ASCII art or text here
          }

          -- Set menu
          startify.section.top_buttons.val = {
            startify.button("e", "New File", ":ene <CR>"),
            startify.button("p", "Projects", ":Telescope projects <CR>"),
          }

          -- Set footer
          startify.section.footer.val = {
            "Happy Coding!",
          }

          alpha.setup(startify.config)
      end
  },
  {
    "folke/persistence.nvim",
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
    opts = {
      -- add any custom options here
    }
  },
  { 'echasnovski/mini.nvim', version = '*' },
  {
    "vimwiki/vimwiki",
    init = function()
      vim.g.vimwiki_list = {
        {
          path = "~/vimwiki/",
          syntax = "markdown",
          ext = ".md",
        },
      }
      vim.g.vimwiki_global_ext = 0
    end,
  },
  { "stevanmilic/nvim-lspimport", lazy = false },
  {'akinsho/toggleterm.nvim', 
    lazy = false,version = "*", config = true},
  {
    'stevearc/conform.nvim',
    event = "BufWritePre",
    lazy = false,
    opts = {},
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua" },
          python = { "isort", "black" },
          rust = { "rustfmt", lsp_format = "fallback" },
          javascript = { "prettierd", "prettier", stop_after_first = true },
          dart = { "dart_format" },
        },
        format_on_save = {
          timeout_ms = 3000,
          lsp_format = "fallback",
        },
      })
    end,
  },
  { 'wakatime/vim-wakatime', lazy = false },
 --{
  --"jose-elias-alvarez/null-ls.nvim",
  --config = function()
    --require("plugins.null-ls")
  --end
--}
 

  
}
