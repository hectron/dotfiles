local nvim_lsp_installed, nvim_lsp = pcall(require, "lspconfig")

if not nvim_lsp_installed then
  print("nvim-lsp is not installed! Aborting")
  return
end

local mason_installed, mason_config = pcall(require, "mason")

if not mason_installed then
  print("Unable to install LSP servers because mason is not installed")
  return
end

local mason_lspconfig_installed, mason_lspconfig = pcall(require, "mason-lspconfig")

if not mason_lspconfig_installed then
  print("Unable to install LSP servers because mason-lspconfig is not installed")
  return
end

-- Automatically install these LSP servers and set them up with proper 'on_attach' functions
local lsp_servers = {
  'bashls',
  'dockerls',
  'gopls',
  'jsonnet_ls',
  'pyright',
  'puppet',
  'rust_analyzer',
  'solargraph',
  'lua_ls',
  'terraformls',
  'tsserver',
  'vimls',
  'yamlls',
}

mason_config.setup({})
mason_lspconfig.setup({
  automatic_installation = true,
  ensure_installed = lsp_servers,
})

-- Specify any custom settings for an LSP server here
local server_specific_opts = {
  ['solargraph'] = function(opts)
    opts.settings = {
      filetypes = { 'ruby', 'rake' }
    }
  end,
  ['gopls'] = function(opts)
    opts.cmd = { 'gopls', '-remote=auto' }
  end,
  ['lua_ls'] = function(opts)
    opts.on_init = function(client)
      local path = client.workspace_folders[1].name
      if not vim.loop.fs_stat(path .. '/.luarc.json') and not vim.loop.fs_stat(path .. '/.luarc.jsonc') then
        client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
          Lua = {
            runtime = {
              -- Tell the language server which version of Lua you're using
              -- (most likely LuaJIT in the case of Neovim)
              version = 'LuaJIT',
            },
            -- Make the server aware of Neovim runtime files
            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME,
              },
            },
            telemetry = {
              enable = false,
            },
            hint = {
              enable = true,
            },
          },
        })

        client.notify('workspace/didChangeConfiguration', { settings = client.config.settings })
      end
      return true
    end
  end,
}

local lsp_handlers = require("lsp/handlers")

for _, server_name in pairs(lsp_servers) do
  local opts = {
    on_attach = lsp_handlers.on_attach,
    capabilities = lsp_handlers.capabilities,
  }

  if server_specific_opts[server_name] then
    server_specific_opts[server_name](opts)
  end

  nvim_lsp[server_name].setup(opts)
end
