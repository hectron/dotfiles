local Util = require("util")

return {
  -- neovim API docs in Lua
  { "folke/neodev.nvim" },

  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme tokyonight]])
    end,
  },

  {
     "nvim-telescope/telescope.nvim",
     cmd = "Telescope",
     dependencies = {
       { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
     },
     version = false,
     keys = {
        { "<C-p>", "<cmd>Telescope find_files find_command=rg,--files,--iglob,!.git,--hidden<CR>", desc = "Find files" },
        { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "[f]ind [b]uffers" },
        { "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "[f]ind using [g]rep" },
        { "<leader>ff", Util.telescope("files"), desc = "[f]ind [f]iles (root dir)" },
        { "<leader>fF", Util.telescope("files", { cwd = false }), desc = "[f]ind [F]iles (cwd)" },

        { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "[g]it [c]ommits" },
        { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "[g]it [s]tatus" },

        -- search
      { "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
      { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
      { "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "Command History" },
      { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
      { "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document diagnostics" },
      { "<leader>sD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace diagnostics" },
      { "<leader>sg", Util.telescope("live_grep"), desc = "Grep (root dir)" },
      { "<leader>sG", Util.telescope("live_grep", { cwd = false }), desc = "Grep (cwd)" },
      { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
      { "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
      { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
      { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
      { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
      { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
      { "<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },
      { "<leader>sw", Util.telescope("grep_string"), desc = "Word (root dir)" },
      { "<leader>sW", Util.telescope("grep_string", { cwd = false }), desc = "Word (cwd)" },
      { "<leader>uC", Util.telescope("colorscheme", { enable_preview = true }), desc = "Colorscheme with preview" },
      {
        "<leader>ss",
        Util.telescope("lsp_document_symbols", {
          symbols = {
            "Class",
            "Function",
            "Method",
            "Constructor",
            "Interface",
            "Module",
            "Struct",
            "Trait",
            "Field",
            "Property",
          },
        }),
        desc = "Goto Symbol",
      },
      {
        "<leader>sS",
        Util.telescope("lsp_dynamic_workspace_symbols", {
          symbols = {
            "Class",
            "Function",
            "Method",
            "Constructor",
            "Interface",
            "Module",
            "Struct",
            "Trait",
            "Field",
            "Property",
          },
        }),
        desc = "Goto Symbol (Workspace)",
      },
     },
   },

   { "nvim-tree/nvim-web-devicons", lazy = true },

}
