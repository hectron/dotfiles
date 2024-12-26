local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local Util = require "utils"
local lsp_handlers = require "lsp_handlers"

require("lazy").setup({
  -- UI
  {
    "TaDaa/vimade", -- dim/fade/tint unfocused windows
    opts = {
      ncmode = "windows",
    },
  },
  {
    "nvim-tree/nvim-web-devicons",
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    opts = {
      flavour = "mocha",
      transparent_background = true,
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme "catppuccin"
    end,
  },
  {
    "lewis6991/gitsigns.nvim", -- show line diffs inline
    event = Util.LazyFileEvents,
    opts = {},
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      {
        "stevearc/aerial.nvim",
        opts = {
          filter_kind = false,
        },
      },
    },
    opts = {
      winbar = {
        lualine_b = { "aerial" },
      },
    },
  },
  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    -- Optional dependencies
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    keys = {
      { "-", "<cmd>Oil<CR>", { desc = "Open parent directory" } },
    },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
  },

  -- General DevEx
  {
    "echasnovski/mini.surround", -- Surrounds text
    event = "InsertEnter",
    opts = {},
  },
  {
    "echasnovski/mini.pairs", -- Allows for automatic open/close pairs
    event = "InsertEnter",
    opts = {},
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = Util.LazyFileEvents,
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "nvim-treesitter/nvim-treesitter-context",
      "RRethy/nvim-treesitter-endwise",
      {
        "MeanderingProgrammer/render-markdown.nvim",
        ft = { "markdown" },
        opts = {},
        dependencies = {
          "nvim-tree/nvim-web-devicons",
        },
      },
    },
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "diff",
        "dockerfile",
        "git_config",
        "git_rebase",
        "gitcommit",
        "gitignore",
        "go",
        "hcl",
        "javascript",
        "json",
        "lua",
        "make",
        "markdown",
        "markdown_inline",
        "python",
        "puppet",
        "query",
        "ruby",
        "rust",
        "yaml",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
      },                   -- this is available in the list of official parsers
      ignore_install = {}, -- list of parsers to ignore installing
      highlight = {
        enable = true,
      },
      incremental_selection = {
        enable = true
      },
      textobjects = {
        select = {
          enable = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["av"] = "@block.outer",
            ["iv"] = "@block.inner",
          },
        },
      },
      endwise = {
        enable = true,
      },
    },
    config = function(_, opts)
      local configs = require("nvim-treesitter.configs")
      configs.setup(opts)
    end,
  },
  {
    "nvim-telescope/telescope.nvim", -- UI to browse through basically anything
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
    },
    keys = {
      { "<C-p>",            "<cmd>Telescope find_files find_command=rg,--files,--iglob,!.git,--hidden<CR>", desc = "Telescope: File picker" },
      { "<LocalLeader>fb",  "<cmd>Telescope buffers<CR>",                                                   desc = "Telescope: [f]ind [b]uffers" },
      { "<LocalLeader>fc",  "<cmd>Telescope commands<CR>",                                                  desc = "Telescope: [f]ind [c]ommands" },
      { "<LocalLeader>fg",  "<cmd>Telescope live_grep<CR>",                                                 desc = "Telescope: [f]uzzy [g]rep" },
      { "<LocalLeader>fm",  "<cmd>Telescope keymaps<CR>",                                                   desc = "Telescope: [f]ind key[m]aps" },
      { "<LocalLeader>mp",  "<cmd>Telescope man_pages<CR",                                                  desc = "Telescope: [m]an [p]ages" },
      { "<LocalLeader>gh",  "<cmd>Telescope help_tags<CR>",                                                 desc = "Telescope: [g]et [h]elp" },
      { "<Leader>gw",       "<cmd>Telescope grep_string<CR>",                                               desc = "Telescope: [g]rep highlighted [w]ord" },
      { "<LocalLeader>gq",  "<cmd>Telescope diagnostics<CR>",                                               desc = "Telescope: workspace diagnostics" },
      { "<LocalLeader>bd",  "<cmd>Telescope diagnostics bufnr=0<CR>",                                       desc = "Telescope: [b]uffer [d]iagnostics" },

      --  git navigation
      { "<LocalLeader>gco", "<cmd>Telescope git_commits<CR>",                                               desc = "Telescope: Show [g]it [c][o]mmits" },
      { "<LocalLeader>ggs", "<cmd>Telescope git_status<CR>",                                                desc = "Telescope: Show [g]it [g][s]tatus" },
      { "<LocalLeader>ggc", "<cmd>Telescope git_bcommits<CR>",                                              desc = "Telescope: Show buffer's [g]it [g][c]ommits" },
    },
    opts = {
      pickers = {
        live_grep = {
          additional_args = function(_)
            -- show hidden files, respect the .gitignore, and ignore .git dir
            return { "--hidden", "-g", "!.git/" }
          end,
        },
      },
    },
  },
  {
    "benmills/vimux", -- Sends commands to tmux
    ft = { "ruby" },
    dependencies = {
      "vim-test/vim-test", -- Run tests in conjuction with vimux
    },
    keys = {
      { "<Leader>rb", ":wa<CR>:TestFile<CR>" },
      { "<Leader>rf", ":wa<CR>:TestNearest<CR>" },
      { "<Leader>rl", ":wa<CR>:TestLast<CR>" },
      { "<Leader>rx", ":wa<CR>:VimuxCloseRunner<CR>" },
      { "<Leader>ri", ":wa<CR>:VimuxInspectRunner<CR>" },
      { "<Leader>rs", ":!ruby -c %<CR>" },
      { "<Leader>AA", ":A<CR>" },
      { "<Leader>AV", ":AV<CR>" },
      { "<Leader>AS", ":AS<CR>" },
    },
  },
  {
    "echasnovski/mini.comment", -- comments out strings
    event = Util.LazyFileEvents,
    dependencies = {
      {
        "JoosepAlviste/nvim-ts-context-commentstring",
        opts = {
          enable_autocmd = false,
        }
      }
    },
    opts = {
      custom_commentstring = function()
        return require("ts_context_commentstring").calculate_commentstring() or vim.bo.commentstring
      end,
    },
  },
  {
    "hrsh7th/nvim-cmp", -- auto-completion when typing
    version = false,
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "onsails/lspkind.nvim",
    },
    ---@module "cmp"
    ---@type cmp.Config
    opts = function()
      local cmp = require("cmp")
      local defaults = require("cmp.config.default")()
      local lspkind = require("lspkind")

      return {
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<S-CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }),
          ["<C-CR>"] = function(fallback)
            cmp.abort()
            fallback()
          end,
          ["<Tab>"] = function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end,
          ["<S-Tab>"] = function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end,
        }),
        sources = cmp.config.sources({
          { name = "lazydev", group_index = 0 },
          { name = "nvim_lsp" },
        }, {
          { name = "path" },
          { name = "buffer" },
        }),
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol_text",
          }),
        },
        sorting = defaults.sorting,
        window = {
          documentation = cmp.config.window.bordered(),
        },
      }
    end,
  },
  {
    "rgroli/other.nvim", -- projectionist/a.vim alternative
    ft = { "ruby" },
    opts = {
      mappings = {
        "rails",
      },
    },
    config = function(_, opts)
      require("other-nvim").setup(opts)
    end,
    keys = {
      { "<Leader>OF", "<cmd>Other<CR>" },
    },
  },

  -- Language plugins
  {
    "vim-ruby/vim-ruby",
    ft = { "ruby" }
  },
  {
    "tpope/vim-rails",
    ft = { "ruby" }
  },
  {
    "leafgarland/typescript-vim",
    ft = { "typescript" }
  },
  {
    "fatih/vim-go",
    ft = { "go" },
    build = ":GoUpdateBinaries"
  },

  -- LSP setup
  {
    "neovim/nvim-lspconfig",
    event = Util.LazyFileEvents,
    dependencies = {
      {
        "folke/lazydev.nvim",
        ft = { "lua" },
        opts = {
          library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
      "SmiteshP/nvim-navic", -- breadcrumbs
      {
        "williamboman/mason-lspconfig.nvim",
        opts = {
          automatic_installation = true,
          ensure_installed = lsp_handlers.lsp_servers,
        },
        dependencies = {
          {
            "williamboman/mason.nvim",
            opts = {},
          },
        },
        lazy = true,
      },
      {
        "j-hui/fidget.nvim",
        opts = {
          notification = {
            window = {
              winblend = 0, -- transparent background LSP loading
            },
          },
        },
      },
    },
    config = function(_, _)
      local lspconfig = require "lspconfig"

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      for _, server_name in pairs(lsp_handlers.lsp_servers) do
        local opts = {
          on_attach = lsp_handlers.on_attach,
          capabilities = capabilities,
        }

        lspconfig[server_name].setup(opts)
      end
    end,
  },
})
