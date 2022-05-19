-- LSP settings
local lspconfig = require("lspconfig")
local on_attach = function(_, bufnr)
	local opts = { buffer = bufnr }

	vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
	vim.keymap.set("n", "<leader>so", require("telescope.builtin").lsp_document_symbols, opts)
	vim.api.nvim_create_user_command("Format", vim.lsp.buf.formatting, {})
end

local signs = {
	{ name = "DiagnosticSignError", text = "" },
	{ name = "DiagnosticSignWarn", text = "" },
	{ name = "DiagnosticSignHint", text = "" },
	{ name = "DiagnosticSignInfo", text = "" },
}

for _, sign in ipairs(signs) do
	vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

local config = {
	-- disable virtual text
	virtual_text = true,
	-- show signs
	signs = {
		active = signs,
	},
	update_in_insert = true,
	underline = true,
	severity_sort = true,
}

lspconfig.emmet_ls.setup({
	filetypes = { "html", "css", "typescriptreact", "javascriptreact", "jsx", "tsx" },
})

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

-- Enable the following language servers
local servers = { "tsserver", "jedi_language_server", "emmet_ls", "tailwindcss", "sumneko_lua", "vim-language-server" }
for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		on_attach = on_attach,
		capabilities = capabilities,
	})
end

---------------------- RUST SECTION

local extension_path = vim.env.HOME .. "/home/arch/.vscode-server-insiders/extensions/vadimcn.vscode-lldb-1.7.0/"
local codelldb_path = extension_path .. "adapter/codelldb"
local liblldb_path = extension_path .. "lldb/lib/liblldb.so"

local opts = {
	-- ... other configs
	dap = {
		adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
	},
}

-- SETUP RUST LSP USING SPECIAL LSP PLUGIN
require("rust-tools").setup({
	tools = {
		hover_actions = {
			auto_focus = true,
		},
	},
}, opts)
require("rust-tools.hover_actions").hover_actions()

------------------- NULL-LS
require("null-ls").setup({
	sources = {
		require("null-ls").builtins.formatting.stylua,
		require("null-ls").builtins.diagnostics.pylint,
		require("null-ls").builtins.formatting.black,
	},
})

---------- DAP

local dap = require('dap')
dap.adapters.lldb = {
  type = 'executable',
  command = '/usr/bin/lldb-vscode', -- adjust as needed
  name = "lldb"
}
-- require("lspconfig").jedi_language_server.setup({})
