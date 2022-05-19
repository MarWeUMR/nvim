-- LSP settings
local lspconfig = require("lspconfig")
local configs = require("lspconfig.configs")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
capabilities.textDocument.completion.completionItem.tagSupport = {
	valueSet = { 1 },
}
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
	properties = { "documentation", "detail", "additionalTextEdits" },
}
capabilities.textDocument.codeAction = {
	dynamicRegistration = false,
	codeActionLiteralSupport = {
		codeActionKind = {
			valueSet = {
				"",
				"quickfix",
				"refactor",
				"refactor.extract",
				"refactor.inline",
				"refactor.rewrite",
				"source",
				"source.organizeImports",
			},
		},
	},
}

local function on_attach(client, bufnr)
	require("plugins.lsp.custom_on_attach").setup(client, bufnr)
end

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- local border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }
-- local border = {
--     { "╔", "FloatBorder" },
--     { "═", "FloatBorder" },
--     { "╗", "FloatBorder" },
--     { "║", "FloatBorder" },
--     { "╝", "FloatBorder" },
--     { "═", "FloatBorder" },
--     { "╚", "FloatBorder" },
--     { "║", "FloatBorder" },
-- }
local function border()
	return {
		{ "╔", "FloatBorder" },
		{ "═", "FloatBorder" },
		{ "╗", "FloatBorder" },
		{ "║", "FloatBorder" },
		{ "╝", "FloatBorder" },
		{ "═", "FloatBorder" },
		{ "╚", "FloatBorder" },
		{ "║", "FloatBorder" },
	}
end

local codes = {
	no_matching_function = {
		message = " Can't find a matching function",
		"redundant-parameter",
		"ovl_no_viable_function_in_call",
	},
	empty_block = {
		message = " That shouldn't be empty here",
		"empty-block",
	},
	missing_symbol = {
		message = " Here should be a symbol",
		"miss-symbol",
	},
	expected_semi_colon = {
		message = " Remember the `;` or `,`",
		"expected_semi_declaration",
		"miss-sep-in-table",
		"invalid_token_after_toplevel_declarator",
	},
	redefinition = {
		message = " That variable was defined before",
		"redefinition",
		"redefined-local",
	},
	no_matching_variable = {
		message = " Can't find that variable",
		"undefined-global",
		"reportUndefinedVariable",
	},
	trailing_whitespace = {
		message = " Remove trailing whitespace",
		"trailing-whitespace",
		"trailing-space",
	},
	unused_variable = {
		message = " Don't define variables you don't use",
		"unused-local",
	},
	unused_function = {
		message = " Don't define functions you don't use",
		"unused-function",
	},
	useless_symbols = {
		message = " Remove that useless symbols",
		"unknown-symbol",
	},
	wrong_type = {
		message = " Try to use the correct types",
		"init_conversion_failed",
	},
	undeclared_variable = {
		message = " Have you delcared that variable somewhere?",
		"undeclared_var_use",
	},
	lowercase_global = {
		message = " Should that be a global? (if so make it uppercase)",
		"lowercase-global",
	},
}

vim.diagnostic.config({
	float = {
		focusable = false,
		border = border(),
		scope = "cursor",
		format = function(diagnostic)
			-- dump(diagnostic)
			if diagnostic.user_data == nil then
				return diagnostic.message
			elseif vim.tbl_isempty(diagnostic.user_data) then
				return diagnostic.message
			end
			local code = diagnostic.user_data.lsp.code
			for _, table in pairs(codes) do
				if vim.tbl_contains(table, code) then
					return table.message
				end
			end
			return diagnostic.message
		end,
		header = { "Cursor Diagnostics:", "DiagnosticHeader" },
		prefix = function(diagnostic, i, total)
			local icon, highlight
			if diagnostic.severity == 1 then
				icon = ""
				highlight = "DiagnosticError"
			elseif diagnostic.severity == 2 then
				icon = ""
				highlight = "DiagnosticWarn"
			elseif diagnostic.severity == 3 then
				icon = ""
				highlight = "DiagnosticInfo"
			elseif diagnostic.severity == 4 then
				icon = ""
				highlight = "DiagnosticHint"
			end
			return i .. "/" .. total .. " " .. icon .. "  ", highlight
		end,
	},
	signs = true,
	underline = true,
	update_in_insert = false,
	virtual_text = false,
	severity_sort = true,
})

-- Enable the following language servers
local servers = {
	tsserver = {},
	jedi_language_server = {},
	emmet_ls = {
		filetypes = { "html", "css", "typescriptreact", "javascriptreact", "jsx", "tsx" },
	},
	tailwindcss = {},
	sumneko_lua = {},
	vimls = {},
}

for server, config in pairs(servers) do
	lspconfig[server].setup(vim.tbl_deep_extend("force", {
		on_attach = on_attach,
		capabilities = capabilities,
		flags = {
			debounce_text_changes = 150,
		},
	}, config))
end

-----------------------------------------------------------
---------------------- RUST SECTION
--------------

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
		inlay_hints = {
			parameter_hints_prefix = "← ",
			other_hints_prefix = "⇒ ",
			highlight = "comment",
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

local dap = require("dap")
dap.adapters.lldb = {
	type = "executable",
	command = "/usr/bin/lldb-vscode", -- adjust as needed
	name = "lldb",
}
-- require("lspconfig").jedi_language_server.setup({})
