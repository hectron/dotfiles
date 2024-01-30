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

require("lazy").setup({
  -- "airblade/vim-gitgutter",
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
    event = "VeryLazy",
  },
  {
    "benmills/vimux",
    event = "VeryLazy",
  },
  {
    "vim-test/vim-test", -- Run tests in conjuction with vimux
    event = "VeryLazy",
  },

  "pgr0ss/vim-github-url",
  "SmiteshP/nvim-navic",
  "glepnir/galaxyline.nvim",
  "glepnir/lspsaga.nvim",

  -- (Optional) Multi-entry selection UI.
  -- { "junegunn/fzf", build = vim.fn["fzf#install"] },

  -- Language plugins
  "L3MON4D3/LuaSnip",
  "rafamadriz/friendly-snippets",
  "vim-ruby/vim-ruby",
  "tpope/vim-rails",
  { "fatih/vim-go",                    build = ":GoUpdateBinaries" },
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
  "neovim/nvim-lspconfig",
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  --
  -- TODO Plug "williamboman/nvim-lsp-installer" -- auto-install LSP servers
  --
  "jose-elias-alvarez/null-ls.nvim", -- any missing LSP features can be implemented with other tools

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
  },
  --Plug("j-hui/fidget.nvim", { tag = "legacy" })
  --Plug "lewis6991/impatient.nvim"
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
    },
  },
  "kyazdani42/nvim-tree.lua",
  --
  -- TODO Plug "stevearc/aerial.nvim"
  --
  {
    "stevearc/aerial.nvim",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
  },
  "gfanto/fzf-lsp.nvim",
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  "rgroli/other.nvim", -- projectionist/a.vim alternative
  "mfussenegger/nvim-dap",
  "lukas-reineke/indent-blankline.nvim",
  "echasnovski/mini.indentscope", -- complimentary to ^
  "ellisonleao/glow.nvim",

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
              -- elseif luasnip.expand_or_jumpable() then
              --   luasnip.expand_or_jump()
            else
              fallback()
            end
          end,
          ["<S-Tab>"] = function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
              -- elseif luasnip.jumpable(-1) then
              --   luasnip.jump(-1)
            else
              fallback()
            end
          end,
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" }, -- TODO why isn't this working?
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
}, { defaults = { lazy = true } })
