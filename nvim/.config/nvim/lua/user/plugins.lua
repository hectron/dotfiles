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
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

        -- stylua: ignore start
        map("n", "]h", gs.next_hunk, "Next Hunk")
        map("n", "[h", gs.prev_hunk, "Prev Hunk")
        map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
        map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
        map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
        map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
        map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
        map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview Hunk Inline")
        map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
        map("n", "<leader>ghd", gs.diffthis, "Diff This")
        map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
      end,
    },
  },
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    opts = {
      config = {
        week_header = {
          enable = true
        },
      },
    },
    config = function(_, opts)
      require("dashboard").setup(opts)
    end,
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
    },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {},
  },
  {
    "tpope/vim-commentary", -- Easily comment
    event = "VeryLazy",
  },
  "tpope/vim-fugitive", -- Git blame, diff, browse, etc
  "tpope/vim-rhubarb",  -- View github commit using :GBrowse
  "tpope/vim-endwise",
  {
    "echasnovski/mini.pairs",
    event = { "VeryLazy" },
    version = false,
    opts = {},
  },
  {
    "benmills/vimux",
    event = "VeryLazy",
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
    "vim-test/vim-test", -- Run tests in conjuction with vimux
    event = "VeryLazy",
  },

  "pgr0ss/vim-github-url",
  "SmiteshP/nvim-navic",
  {
    "glepnir/lspsaga.nvim",
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
  "L3MON4D3/LuaSnip",
  "rafamadriz/friendly-snippets",
  "vim-ruby/vim-ruby",
  "tpope/vim-rails",
  {
    "fatih/vim-go",
    build = ":GoUpdateBinaries"
  },
  "leafgarland/typescript-vim",

  -- Icons/Colors
  "ryanoasis/vim-devicons",
  "nvim-tree/nvim-web-devicons",
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme "catppuccin"
    end,
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
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
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  --
  -- TODO Plug "williamboman/nvim-lsp-installer" -- auto-install LSP servers
  --
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
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
        additional_vim_regex_highlighting = true,
        use_languagetree = true,
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
      { "nvim-lua/plenary.nvim" },
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
    "stevearc/aerial.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
    },
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    keys = {
      { "<Leader>at", "<cmd>AerialToggle!<CR>" },
      { "{",          "<cmd>AerialPrev<CR>" },
      { "}",          "<cmd>AerialNext<CR>" },
      { "[[",         "<cmd>AerialPrevUp<CR>" },
      { "]]",         "<cmd>AerialNextUp<CR>" },
    },
    opts = {},
  },
  "gfanto/fzf-lsp.nvim",
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
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
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    dependencies = {
      "echasnovski/mini.indentscope",
    },
    opts = {
      exclude = {
        filetypes = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "lazy",
          "mason",
        },
      },
    },
  },
  {
    "ellisonleao/glow.nvim",
    keys = {
      { "<leader>mp", "<cmd>Glow<CR>", ft = "markdown" },
    },
    opts = {
      width = 250,
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
