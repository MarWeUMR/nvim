-- LSP settings
local lspconfig = require("lspconfig")
local on_attach = function(_, bufnr)
	local opts = { buffer = bufnr }

	vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
	vim.keymap.set("n", "<leader>so", require("telescope.builtin").lsp_document_symbols, opts)
	vim.api.nvim_create_user_command("Format", vim.lsp.buf.formatting, {})
end

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

-- Enable the following language servers
local servers = { "tsserver", "jedi_language_server" }
for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		on_attach = on_attach,
		capabilities = capabilities,
	})
end

-- SETUP RUST LSP USING SPECIAL LSP PLUGIN
require("rust-tools").setup({
	tools = {
		hover_actions = {
			auto_focus = true,
		},
	},
})
require("rust-tools.hover_actions").hover_actions()

require("null-ls").setup({
	sources = {
		require("null-ls").builtins.formatting.stylua,
		require("null-ls").builtins.diagnostics.pylint,
	},
})

-- require("lspconfig").jedi_language_server.setup({})
