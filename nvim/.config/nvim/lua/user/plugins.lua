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

local Util = require("user.utils")

require("lazy").setup({
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    opts = {},
  },
  {
    "nvimdev/dashboard-nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons"
    },
    event = "VimEnter",
    opts = {
      config = {
        week_header = {
          enable = true
        },
      },
    },
  },
  "tpope/vim-rhubarb", -- View github commit using :GBrowse
  "tpope/vim-endwise",
  { "echasnovski/mini.surround",  event = { "BufReadPost", "BufNewFile", "BufWritePre" }, opts = {} },
  {
    "echasnovski/mini.pairs",
    event = { "VeryLazy" },
    version = false,
    opts = {},
  },
  {
    "benmills/vimux",
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
  "SmiteshP/nvim-navic",
  {
    "glepnir/lspsaga.nvim",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    dependencies = {
      'nvim-treesitter/nvim-treesitter', -- optional
      'nvim-tree/nvim-web-devicons',     -- optional
    },
    keys = {
      -- Actions
      { "<leader>ca", "<cmd>Lspsaga code_action<CR>",           desc = "[c]ode [a]ction" },

      -- Diagnostics
      { "<leader>e",  "<cmd>Lspsaga show_line_diagnostics<CR>", desc = "[e]xplain diagnostics" },
      { "<leader>be", "<cmd>Lspsaga show_buf_diagnostics<CR>",  desc = "[b]uffer [e]xplain diagnostics" },
      { "[d",         "<cmd>Lspsaga diagnostic_jump_prev<CR>" },
      { "]d",         "<cmd>Lspsaga diagnostic_jump_next<CR>" },

      -- Navigation
      { "<leader>fr", "<cmd>Lspsaga lsp_finder<CR>",            desc = "[f]ind symbol [r]eference" },
      { "<leader>o",  "<cmd>Lspsaga outline<CR>",               desc = "[o]pen outline" },
      { "gd",         "<cmd>Lspsaga goto_definition<CR>",       desc = "[g]o to [d]efinition" },
      { "gp",         "<cmd>Lspsaga peek_definition<CR>",       desc = "[g]o [p]eek definition" },

      -- Terminal
      { "<leader>tt", "<cmd>Lspsaga term_toggle<CR>",           desc = "[t]erminal [t]oggle" },
      { "K",          "<cmd>Lspsaga hover_doc ++keep<CR>" },
    },
    opts = {},
  },
  {
    "echasnovski/mini.comment",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
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

  -- Language plugins
  { "vim-ruby/vim-ruby",          ft = { "ruby" } },
  { "tpope/vim-rails",            ft = { "ruby" } },
  { "leafgarland/typescript-vim", ft = { "typescript" } },
  { "fatih/vim-go",               ft = { "go" },                                          build = ":GoUpdateBinaries" },

  -- Icons/Colors
  "ryanoasis/vim-devicons",
  "nvim-tree/nvim-web-devicons",
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
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    dependencies = {
      { "folke/neoconf.nvim", cmd = "Neoconf", config = false, dependencies = { "nvim-lspconfig" } },
      { "folke/neodev.nvim",  opts = {} },
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function(_, _)
      if Util.has("neoconf.nvim") then
        local plugin = require("lazy.core.config").spec.plugins["neoconf.nvim"]
        local plugin_opts = require("lazy.core.plugin").values(plugin, "opts", false)
        require("neoconf").setup(plugin_opts)
      end
    end,
  },
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
    },
  },
  --
  -- TODO Plug "williamboman/nvim-lsp-installer" -- auto-install LSP servers
  --
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      {
        "rcarriga/nvim-notify",
        opts = {
          background_colour = "#1a1b26",
        },
      },
    },
    opts = {
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
        },
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = true,         -- use a classic bottom cmdline for search
        command_palette = true,       -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false,           -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false,       -- add a border to hover docs and signature help
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-context",
    },
    opts = {
      ensure_installed = {
        "bash",
        "c",
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
        enable = true
      },
    },
    config = function(_, opts)
      local configs = require("nvim-treesitter.configs")
      configs.setup(opts)
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    keys = {
      { "<C-p>",            "<cmd>Telescope find_files find_command=rg,--files,--iglob,!.git,--hidden<CR>" },
      { "<LocalLeader>fb",  "<cmd>Telescope buffers<CR>" },
      { "<LocalLeader>fc",  "<cmd>Telescope commands<CR>" },
      { "<LocalLeader>fg",  "<cmd>Telescope live_grep<CR>" },
      { "<LocalLeader>fm",  "<cmd>Telescope keymaps<CR>" },
      { "<LocalLeader>mp",  "<cmd>Telescope man_pages<CR" },
      { "<LocalLeader>gh",  "<cmd>Telescope help_tags<CR>" },
      { "<Leader>gw",       "<cmd>Telescope grep_string<CR>" },
      { "<LocalLeader>gq",  "<cmd>Telescope diagnostics<CR>" },
      { "<LocalLeader>bd",  "<cmd>Telescope diagnostics bufnr=0<CR>" },

      --  git navigation

      { "<LocalLeader>gco", "<cmd>Telescope git_commits<CR>" },
      { "<LocalLeader>ggs", "<cmd>Telescope git_status<CR>" },
      { "<LocalLeader>ggc", "<cmd>Telescope git_bcommits<CR>" },
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
    "kyazdani42/nvim-tree.lua",
    opts = {
      view = {
        adaptive_size = true,
      },
      update_focused_file = {
        enable = true,
        update_root = true,
      },
    },
    keys = {
      { '<Leader>nt', '<cmd>NvimTreeToggle<CR>' },
      { '<Leader>nf', '<cmd>NvimTreeFindFile<CR>' },
    },
  },
  {
    "rgroli/other.nvim", -- projectionist/a.vim alternative
    ft = { "ruby" },
    opts = {
      mappings = {
        "rails",
      },
    },
    keys = {
      { "<Leader>OF", "<cmd>Other<CR>" },
    },
  },
  -- Autocomplete for lsp
  {
    "hrsh7th/nvim-cmp",
    version = false,
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "onsails/lspkind.nvim",
    },
    opts = function()
      vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
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
          { name = "nvim_lsp" },
          { name = "path" },
        }, {
          { name = "buffer" },
        }),
        formatting = {
          format = lspkind.cmp_format(),
        },
        experimental = {
          ghost_text = {
            hl_group = "CmpGhostText",
          },
        },
        sorting = defaults.sorting,
      }
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      options = {
        theme = "catppuccin",
      },
    },
  },
})
