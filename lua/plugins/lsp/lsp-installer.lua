local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
	return
end

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)
	local opts = {
		on_attach = require("plugins.lsp.handlers").on_attach,
		capabilities = require("plugins.lsp.handlers").capabilities,
	}

	if server.name == "rust_analyzer" then
		-- Initialize the LSP via rust-tools instead
		require("rust-tools").setup({
			-- The "server" property provided in rust-tools setup function are the
			-- settings rust-tools will provide to lspconfig during init.            --
			-- We merge the necessary settings from nvim-lsp-installer (server:get_default_options())
			-- with the user's own settings (opts).
			server = vim.tbl_deep_extend("force", server:get_default_options(), opts),
		})
		server:attach_buffers()
		-- Only if standalone support is needed
		require("rust-tools").start_standalone_if_required()

		-- if server.name == "jsonls" then
		-- 	local jsonls_opts = require("plugins.lsp.settings.jsonls")
		-- 	opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
		-- end
		--
	elseif server.name == "sumneko_lua" then
		local sumneko_opts = require("plugins.lsp.settings.sumneko_lua")
		opts = vim.tbl_deep_extend("force", sumneko_opts, opts)

		--
		-- if server.name == "pyright" then
		-- 	local pyright_opts = require("plugins.lsp.settings.pyright")
		-- 	opts = vim.tbl_deep_extend("force", pyright_opts, opts)
		-- end
		--
		-- if server.name == "angularls" then
		-- 	local angularls_opts = require("plugins.lsp.settings.angularls")
		-- 	opts = vim.tbl_deep_extend("force", angularls_opts, opts)
		-- end

		-- This setup() function is exactly the same as lspconfig's setup function.
		-- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
	else
	end

		server:setup(opts)
end)
