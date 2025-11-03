return {
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>",            desc = "Toggle Pin" },
      { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
      { "<leader>br", "<Cmd>BufferLineCloseRight<CR>",           desc = "Delete Buffers to the Right" },
      { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>",            desc = "Delete Buffers to the Left" },
      { "<S-h>",      "<cmd>BufferLineCyclePrev<cr>",            desc = "Prev Buffer" },
      { "<S-l>",      "<cmd>BufferLineCycleNext<cr>",            desc = "Next Buffer" },
      { "[b",         "<cmd>BufferLineCyclePrev<cr>",            desc = "Prev Buffer" },
      { "]b",         "<cmd>BufferLineCycleNext<cr>",            desc = "Next Buffer" },
      { "[B",         "<cmd>BufferLineMovePrev<cr>",             desc = "Move buffer prev" },
      { "]B",         "<cmd>BufferLineMoveNext<cr>",             desc = "Move buffer next" },
    },
    opts = {
      options = {
        diagnostics = "nvim_lsp",
        always_show_bufferline = false,
        offsets = {
          {
            filetype = "neo-tree",
            text = "Neo-tree",
            highlight = "Directory",
            text_align = "left",
          },
          {
            filetype = "snacks_layout_box",
          },
        },
      },
    },
    config = function(_, opts)
      require("bufferline").setup(opts)
      -- Fix bufferline when restoring a session
      vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
        callback = function()
          vim.schedule(function()
            pcall(nvim_bufferline)
          end)
        end,
      })
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = {
      {
        "nvim-mini/mini.icons",
        config = function(_, opts)
          require("mini.icons").setup(opts)
          MiniIcons.mock_nvim_web_devicons()
        end,
      },
    },
    opts = function()
      local opts = {
        options = {
          theme = "auto",
          globalstatus = vim.o.laststatus == 3,
          disabled_filetypes = { statusline = { "dashboard" } },
          section_separators = { left = '', right = '' },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff" },
          lualine_c = {
            { "filetype", icon_only = true, separator = '', padding = { left = 1, right = 0 } },
            { "filename", path = 1, separator = '', padding = { left = 0, right = 0 } },
            { "diagnostics", sources = { "nvim_diagnostic", "nvim_lsp" } },
          },
          lualine_x = {
            {
              function()
                return require("noice").api.status.command.get()
              end,
              cond = function()
                return package.loaded["noice"] and require("noice").api.status.command.has()
              end,
              color = function()
                return { fg = require("snacks").util.color("Statement") }
              end,
            },
            {
              function()
                return require("noice").api.status.mode.get()
              end,
              cond = function()
                return package.loaded["noice"] and require("noice").api.status.mode.has()
              end,
              color = function()
                return { fg = require("snacks").util.color("Constant") }
              end,
            },
          },
          lualine_y = {
            {
              "progress",
              separator = ' ',
              padding = { left = 1, right = 0 },
            },
            {
              "location",
              padding = { left = 0, right = 1 },
            },
          },
          lualine_z = {
            function()
              return "  " .. os.date("%R")
            end,
          },
        },
        extensions = { "neo-tree", "lazy", "fzf" },
      }

      return opts
    end,
    init = function()
      vim.g.lualine_laststatus = vim.o.laststatus
      if vim.fn.argc(-1) > 0 then
        -- set an empty statusline till lualine loads
        vim.o.statusline = " "
      else
        -- hide the statusline on the starter page
        vim.o.laststatus = 0
      end
    end,
  },
  {
    "folke/zen-mode.nvim",
    opts = {
      plugins = { tmux = { enabled = true } },
    },
    dependencies = {
      { "folke/snacks.nvim" },
    },
    keys = {
      {
        "<leader>uZ",
        function()
          require("zen-mode").toggle()
          require("snacks").zen()
        end,
        desc = "[u]i [Z]en mode",
      },
    },
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
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
}
