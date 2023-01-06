local null_ls = require("null-ls")

null_ls.setup({
	sources = {
		null_ls.builtins.formatting.phpcsfixer,
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.black,
		-- null_ls.builtins.formatting.autopep8,
		null_ls.builtins.formatting.prettier,
		null_ls.builtins.diagnostics.flake8,
		null_ls.builtins.diagnostics.ruff,
		null_ls.builtins.diagnostics.mypy,
		null_ls.builtins.code_actions.gitsigns,
		null_ls.builtins.code_actions.eslint,
	},
})
