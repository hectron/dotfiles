if !exists("g:lspconfig")
  finish
endif

lua << EOF
local status, nvim_lsp = pcall(require, 'lspconfig')

if status then
  local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = { noremap = true, silent = true }

    -- Inspired by https://github.com/neovim/nvim-lspconfig/#keybindings-and-completion,
    -- but with <leader> instead of <space>

    -- Navigation
    buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', '<Leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)

    -- Information
    buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<Leader>ds', '<cmd>lua vim.lsp.buf.document_symbol()<CR>', opts)

    -- Diagnostics
    buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<Leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    buf_set_keymap('n', '<Leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

    -- Refactoring
    buf_set_keymap('n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<Leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)

    -- Workspaces
    buf_set_keymap('n', '<Leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<Leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<Leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', '<Leader>ws', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>', opts)
  end

  local lsp_installer_servers = require('nvim-lsp-installer.servers')

  local servers = {
    'gopls',
    'solargraph',
  }

  local server_specific_opts = {
    ["solargraph"] = function(opts)
      opts.settings = {
        filetypes = { "ruby", "rake" }
      }
    end,
  }

  for _, server_name in pairs(servers) do
    local server_available, server = lsp_installer_servers.get_server(server_name)

    if server_available then
      server:on_ready(function()
        local opts = {
          on_attach = on_attach,
        }

        if server_specific_opts[server_name] then
          server_specific_opts[server_name](opts)
        end

        server:setup(opts)
      end)

      if not server:is_installed() then
        server:install()
      end
    end
  end

  -- nvim_lsp.solargraph.setup{
  --   on_attach = on_attach,
  --   settings = {
  --     filetypes = { "ruby", "rake" }
  --   }
  -- }

  -- nvim_lsp.gopls.setup{
  --   on_attach = on_attach,
  -- }
end
EOF

