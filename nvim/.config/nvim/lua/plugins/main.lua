local Util = require("core.config")

local picker_keymaps = function(picker_name, config)
  local desc_prefix = picker_name .. ": "

  return {
    { "<Leader><Leader>", config.files, desc = desc_prefix .. "file picker" },
    { "<C-p>", config.files, desc = desc_prefix .. "file picker" },
    { "<Leader>gw", config.grep_word, desc = desc_prefix .. "[g]rep [w]ords" },
    { "<Leader>nc", config.dotfiles, desc = desc_prefix .. "[n]eovim [c]onfig" },

    { "<Leader>fb", config.buffers, desc = desc_prefix .. "[f]ind [b]uffers" },
    { "<Leader>fc", config.commands, desc = desc_prefix .. "[f]ind [c]ommands" },
    { "<Leader>fd", config.diagnostics_document, desc = desc_prefix .. "[f]ind [d]iagnostics" },
    { "<Leader>fD", config.dotfiles, desc = desc_prefix .. "[f]ind [D]ot[f]iles" },
    { "<Leader>fg", config.live_grep, desc = desc_prefix .. "[f]ind via live [g]rep" },
    { "<Leader>fk", config.keymaps, desc = desc_prefix .. "[f]ind [k]eymaps" },
    { "<Leader>fm", config.man_pages, desc = desc_prefix .. "[f]ind [m]an pages" },
    { "<Leader>fh", config.help_tags, desc = desc_prefix .. "[f]ind [h]elp tags" },
  }
end

return {
  -- General DevEx
  {
    "folke/snacks.nvim",
    opts = {
      picker = { enabled = false },
    },
    keys = function(_, keys)
      return {
        -- { "<C-p>", function() Snacks.picker.files() end, desc = "File picker" },
        -- { "<leader>be", function() Snacks.picker.buffers() end,                                 desc = "[b]uffer [e]xplore" },
        { "<leader>,",  function() Snacks.picker.buffers() end,                                 desc = "Buffers" },
        { "<leader>/",  function() Snacks.picker.grep() end,                                    desc = "Grep" },
        { "<leader>:",  function() Snacks.picker.command_history() end,                         desc = "Command History" },
        { "<leader>n",  function() Snacks.picker.notifications() end,                           desc = "Notification History" },
        { "<leader>e",  function() Snacks.explorer() end,                                       desc = "File Explorer" },
        -- find
        -- { "<leader>fb", function() Snacks.picker.buffers() end,                                 desc = "Buffers" },
        -- { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
        -- { "<leader>ff", function() Snacks.picker.files() end,                                   desc = "Find Files" },
        -- { "<leader>fg", function() Snacks.picker.git_files() end,                               desc = "Find Git Files" },
        -- { "<leader>fp", function() Snacks.picker.projects() end,                                desc = "Projects" },
        -- { "<leader>fr", function() Snacks.picker.recent() end,                                  desc = "Recent" },
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
      }
    end,
  },
  {
    "ibhagwan/fzf-lua",
    event = { "VeryLazy" },
    dependencies = { Util.DefaultIconProvider },
    opts = {},
    keys = function(_, keys)

      return picker_keymaps(
        "fzf-lua",
        {
          dotfiles = function() require("fzf-lua").files({ cwd = vim.fn.stdpath("config") }) end,
          files = function() require("fzf-lua").files() end,
          buffers = function() require("fzf-lua").buffers() end,
          commands = function() require("fzf-lua").commands() end,
          live_grep = function() require("fzf-lua").live_grep() end,
          keymaps = function() require("fzf-lua").keymaps() end,
          man_pages = function() require("fzf-lua").man_pages() end,
          help_tags = function() require("fzf-lua").help_tags() end,
          grep_word = function() require("fzf-lua").grep_cword() end,
          diagnostics_document = function() require("fzf-lua").diagnostics_document() end,
        }
      )
    end
  },
  {
    "benmills/vimux", -- Sends commands to tmux
    ft = { "ruby" },
    dependencies = {
      "vim-test/vim-test", -- Run tests in conjuction with vimux
    },
    keys = {
      { "<Leader>rb", ":wa<CR>:TestFile<CR>",    desc = "Vimux: test file" },
      { "<Leader>rf", ":wa<CR>:TestNearest<CR>", desc = "Vimux: test nearest" },
      { "<Leader>rl", ":wa<CR>:TestLast<CR>",    desc = "Vimux: test last" },
      { "<Leader>AA", ":A<CR>",                  "Vimux: alternate file" },
      { "<Leader>AV", ":AV<CR>",                 "Vimux: alt" },
      { "<Leader>AS", ":AS<CR>",                 "Vimux: alternate" },
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
