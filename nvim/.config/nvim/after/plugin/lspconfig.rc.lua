local lspconfig_installed, _ = pcall(require, "lspconfig")

if not lspconfig_installed then
	return
end

local lsp_installer_installed, nvim_lsp_installer = pcall(require, "nvim-lsp-installer")

if not lsp_installer_installed then
	return
end

-- Automatically install these LSP servers and set them up with proper 'on_attach' functions
local lsp_servers = {
	'bashls',
	'dockerls',
	'gopls',
	'jsonnet_ls',
	'pyright',
	'solargraph',
	'sumneko_lua',
	'terraformls',
	'vimls',
	'yamlls',
}

nvim_lsp_installer.setup({
	automatic_installation = true,
	ensure_installed = lsp_servers
})

local navic = require('nvim-navic')

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

	if client.server_capabilities.documentFormattingProvider then
		vim.cmd([[
        augroup FORMATTING
          autocmd! * <buffer>
          autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()
        augroup END
      ]])
	end

	navic.attach(client, bufnr)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

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
	['sumneko_lua'] = function(opts)
		opts.settings = {
			Lua = {
				diagnostics = {
					-- make the server recognize the vim global
					globals = { 'vim' },
				},
				workspace = {
					-- make the server aware of neovim runtime files
					library = vim.api.nvim_get_runtime_file("", true),
				},
				telemetry = {
					enable = false,
				},
			}
		}
	end,
}

for _, server_name in pairs(lsp_servers) do
	local opts = {
		on_attach = on_attach,
		capabilities = capabilities,
	}

	if server_specific_opts[server_name] then
		server_specific_opts[server_name](opts)
	end

	local server = require('lspconfig')[server_name]
	server.setup(opts)
end
