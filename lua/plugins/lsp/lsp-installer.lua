local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
	return
end

opts = {
	on_attach = require("plugins.lsp.handlers").on_attach,
	capabilities = require("plugins.lsp.handlers").capabilities,
}

local enhance_server_opts = {
	-- Provide settings that should only apply to the "eslintls" server
	["eslintls"] = function(opts)
		opts.settings = {
			format = {
				enable = true,
			},
		}
	end,

	["emmet_ls"] = function(opts)
		local emmet_opts = require("plugins.lsp.settings.emmet")
		opts.filetypes = emmet_opts.filetypes
	end,

	["sumneko_lua"] = function(opts)
		local sumneko_opts = require("plugins.lsp.settings.sumneko_lua")
		opts.settings = sumneko_opts.settings
	end,
}

lsp_installer.on_server_ready(function(server)
	-- Specify the default options which we'll use to setup all servers
	local opts = {
		on_attach = on_attach,
		capabilities = capabilities,
	}

	if enhance_server_opts[server.name] then
		-- Enhance the default opts with the server-specific ones
		enhance_server_opts[server.name](opts)
	end

	if server.name == "rust_analyzer" then
		local rustopts = {
			tools = {
				autoSetHints = true,
				hover_with_actions = false,
				executor = require("rust-tools/executors").termopen,
				inlay_hints = {
					show_parameter_hints = true,
					parameter_hints_prefix = "<- ",
					other_hints_prefix = "=> ",
					highlight = "comment",
				},
				hover_actions = {
					auto_focus = true,
				},
			},
			server = vim.tbl_deep_extend("force", server:get_default_options(), opts, {
				-- settings = {
				-- 	["rust-analyzer"] = {
				-- 		completion = {
				-- 			postfix = {
				-- 				enable = true,
				-- 			},
				-- 		},
				-- 		checkOnSave = {
				-- 			command = "clippy",
				-- 		},
				-- 	},
				-- },
			}),
		}
		require("rust-tools").setup(rustopts)
		server:attach_buffers()
	else
		--

		server:setup(opts)
	end
end)
