local null_ls_exists, null_ls = pcall(require, "null-ls")

if not null_ls_exists then
	return
end

local builtins = null_ls.builtins
local au_group = vim.api.nvim_create_augroup("LspFormatting", {})

-- many formatters need to be pre-installed, while others are packaged with null-ls.
-- Check out the null-ls documentation for more details
null_ls.setup({
	sources = {
		-- linters
		-- if pip install isn't working, try reshim asdf
		builtins.formatting.black.with({ extra_args = { "--fast" } }),
		builtins.formatting.isort,

		-- format shell scripts, configured via $HOME/.editorconfig
		-- @see https://github.com/mvdan/sh/blob/65cf6660506dec6b9e736b955640a605387606bb/cmd/shfmt/shfmt.1.scd
		builtins.formatting.shfmt, -- bash/zsh/etc, configured via $HOME/.editoconfig
		builtins.formatting.fixjson, -- json
		builtins.formatting.lua_format,
		-- builtins.formatting.rubocop, -- ruby

		-- diagnostics
		-- builtins.diagnostics.actionlint, -- static checker for GH Actions
		-- builtins.diagnostics.write_good,
		builtins.diagnostics.flake8,
	},
	on_attach = function(client, bufnr)
		if not client.supports_method("textDocument/formatting") then
			return
		end

		vim.api.nvim_clear_autocmds({ group = au_group, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = au_group,
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.format({
					bufnr = bufnr,
					timeout_ms = 5000,
					filter = function(callback_client)
						return callback_client.name == "null-ls"
					end,
				})
			end,
		})
	end,
})
