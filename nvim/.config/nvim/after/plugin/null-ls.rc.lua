local null_ls_exists, null_ls = pcall(require, "null-ls")

if not null_ls_exists then
	return
end

local builtins = null_ls.builtins

null_ls.setup({
	sources = {
		-- linters
		-- if pip install isn't working, try reshim asdf
		builtins.formatting.black.with({ extra_args = { "--fast" } }),
		builtins.formatting.isort,
		builtins.formatting.shfmt, -- bash/zsh/etc
		builtins.formatting.fixjson, -- json

		-- diagnostics
		-- builtins.diagnostics.actionlint, -- static checker for GH Actions
		builtins.diagnostics.write_good,
		builtins.diagnostics.flake8,
	},
})
