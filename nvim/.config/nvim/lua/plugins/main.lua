return {
  -- General DevEx

  {
    "folke/snacks.nvim",
    opts = {
      picker = { enabled = true },
    },
    keys = {
      -- { "<C-p>", function() Snacks.picker.files() end, desc = "File picker" },
      { "<leader>be", function() Snacks.picker.buffers() end, desc = "[b]uffer [e]xplore" },
      { "<leader>,", function() Snacks.picker.buffers() end, desc = "Buffers" },
      { "<leader>/", function() Snacks.picker.grep() end, desc = "Grep" },
      { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
      { "<leader>n", function() Snacks.picker.notifications() end, desc = "Notification History" },
      { "<leader>e", function() Snacks.explorer() end, desc = "File Explorer" },
      -- find
      { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
      { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
      { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
      { "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
      { "<leader>fp", function() Snacks.picker.projects() end, desc = "Projects" },
      { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent" },
      {
        "<leader>N",
        desc = "Neovim News",
        function()
          Snacks.win({
            file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
            width = 0.6,
            height = 0.6,
            wo = {
              spell = false,
              wrap = false,
              signcolumn = "yes",
              statuscolumn = " ",
              conceallevel = 3,
            },
          })
        end,
      },
    },
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
      {
        "<C-p>",
        "<cmd>Telescope find_files find_command=rg,--files,--iglob,!.git,--hidden<CR>",
        desc = "Telescope: File picker",
      },
      {
        "<LocalLeader>fb",
        "<cmd>Telescope buffers<CR>",
        desc = "Telescope: [f]ind [b]uffers",
      },
      {
        "<LocalLeader>fc",
        "<cmd>Telescope commands<CR>",
        desc = "Telescope: [f]ind [c]ommands",
      },
      {
        "<LocalLeader>fg",
        "<cmd>Telescope live_grep<CR>",
        desc = "Telescope: [f]uzzy [g]rep",
      },
      {
        "<LocalLeader>fm",
        "<cmd>Telescope keymaps<CR>",
        desc = "Telescope: [f]ind key[m]aps",
      },
      {
        "<LocalLeader>mp",
        "<cmd>Telescope man_pages<CR",
        desc = "Telescope: [m]an [p]ages",
      },
      {
        "<LocalLeader>gh",
        "<cmd>Telescope help_tags<CR>",
        desc = "Telescope: [g]et [h]elp",
      },
      {
        "<Leader>gw",
        "<cmd>Telescope grep_string<CR>",
        desc = "Telescope: [g]rep highlighted [w]ord",
      },
      {
        "<LocalLeader>gq",
        "<cmd>Telescope diagnostics<CR>",
        desc = "Telescope: workspace diagnostics",
      },
      {
        "<LocalLeader>bd",
        "<cmd>Telescope diagnostics bufnr=0<CR>",
        desc = "Telescope: [b]uffer [d]iagnostics",
      },

      --  git navigation
      {
        "<LocalLeader>gco",
        "<cmd>Telescope git_commits<CR>",
        desc = "Telescope: Show [g]it [c][o]mmits",
      },
      {
        "<LocalLeader>ggs",
        "<cmd>Telescope git_status<CR>",
        desc = "Telescope: Show [g]it [g][s]tatus",
      },
      {
        "<LocalLeader>ggc",
        "<cmd>Telescope git_bcommits<CR>",
        desc = "Telescope: Show buffer's [g]it [g][c]ommits",
      },
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
  -- Language plugins
  {
    "vim-ruby/vim-ruby",
    ft = { "ruby" },
  },
  {
    "tpope/vim-rails",
    ft = { "ruby" },
  },
  {
    "leafgarland/typescript-vim",
    ft = { "typescript" },
  },
  {
    "fatih/vim-go",
    ft = { "go" },
    build = ":GoUpdateBinaries",
  },
}
