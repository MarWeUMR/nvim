local lspconfig = require("lspconfig")

local border = {
  { "🭽", "FloatBorder" },
  { "▔", "FloatBorder" },
  { "🭾", "FloatBorder" },
  { "▕", "FloatBorder" },
  { "🭿", "FloatBorder" },
  { "▁", "FloatBorder" },
  { "🭼", "FloatBorder" },
  { "▏", "FloatBorder" },
}

local on_attach = function(_, bufnr)
  -- vim.keymap.set("n", "<space>lf", function()
  --   vim.lsp.buf.format({ async = true })
  -- end, { buffer = bufnr })
  vim.api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr()")
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
  vim.api.nvim_buf_set_option(bufnr, "tagfunc", "v:lua.vim.lsp.tagfunc")
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
  vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local handlers = {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
  ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {}), -- could also be like '{border="rounded"}'
  ["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    { virtual_text = true }
  ),
}

if not packer_plugins["cmp-nvim-lsp"].loaded then
  vim.cmd([[packadd cmp-nvim-lsp]])
end
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local signs = {
  Error = " ",
  Warn = " ",
  Info = " ",
  Hint = " ",
}
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
  signs = true,
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  virtual_text = {
    prefix = "🔥",
    source = true,
  },
})

-- lspconfig.pylsp.setup({
-- 	on_attach = on_attach,
-- 	capabilities = capabilities,
-- 	settings = {
-- 		pylsp = {
-- 			plugins = {
-- 				jedi = {
-- 					enabled = true,
-- 					environment = "/Users/marcus/.pyenv/versions/venv3915/bin/python",
-- 					-- extra_paths = { "/home/username/extra/path" },
-- 				},
-- 				pycodestyle = {
-- 					enabled = true,
-- 				},
-- 				pydocstyle = {
-- 					enabled = false,
-- 				},
-- 				autopep8 = {
-- 					enabled = true,
-- 				},
-- 				pylint = {
-- 					enabled = true,
-- 				},
-- 				pyls_mypy = {
-- 					enabled = true,
-- 					live_mode = true,
-- 				},
-- 			},
-- 		},
-- 	},
-- })

-- lspconfig.julials.setup({
--   on_attach = on_attach,
--   handlers = handlers,
-- })

lspconfig.pyright.setup({
  on_attach = on_attach,
  settings = {
    pyright = {
      pythonVersion = "3.9",
      disableOrganizeImports = false,
      analysis = {
        useLibraryCodeForTypes = true,
        autoSearchPaths = true,
        diagnosticMode = "workspace",
        autoImportCompletions = true,
      },
      inlayHints = {
        variableTypes = true,
        functionReturnTypes = true,
      },
    },
  },
})

lspconfig.intelephense.setup({
  capabilities = capabilities,
  handlers = handlers,
  on_attach = on_attach,
  settings = {
    intelephense = {
      files = {
        maxSize = 5000000,
      },
    },
  },
})

lspconfig.sumneko_lua.setup({
  handlers = handlers,
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        enable = true,
        globals = { "vim", "packer_plugins" },
      },
      runtime = { version = "LuaJIT" },
      workspace = {
        library = vim.list_extend({ [vim.fn.expand("$VIMRUNTIME/lua")] = true }, {}),
      },
    },
  },
})

local rt = require("rust-tools")

local extension_path = "/Users/marcus/.vscode-insiders/extensions/vadimcn.vscode-lldb-1.8.1/"
local codelldb_path = extension_path .. "adapter/codelldb"
local liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"

local rust_opts = {
  tools = { -- rust-tools options

    -- how to execute terminal commands
    -- options right now: termopen / quickfix
    executor = require("rust-tools/executors").termopen,

    -- callback to execute once rust-analyzer is done initializing the workspace
    -- The callback receives one parameter indicating the `health` of the server: "ok" | "warning" | "error"
    on_initialized = nil,

    -- automatically call RustReloadWorkspace when writing to a Cargo.toml file.
    reload_workspace_from_cargo_toml = true,

    -- These apply to the default RustSetInlayHints command
    inlay_hints = {
      -- automatically set inlay hints (type hints)
      -- default: true
      auto = true,

      -- Only show inlay hints for the current line
      only_current_line = false,

      -- whether to show parameter hints with the inlay hints or not
      -- default: true
      show_parameter_hints = true,

      -- prefix for parameter hints
      -- default: "<-"
      parameter_hints_prefix = "<- ",

      -- prefix for all the other hints (type, chaining)
      -- default: "=>"
      other_hints_prefix = "=> ",

      -- whether to align to the length of the longest line in the file
      max_len_align = false,

      -- padding from the left if max_len_align is true
      max_len_align_padding = 1,

      -- whether to align to the extreme right or not
      right_align = false,

      -- padding from the right if right_align is true
      right_align_padding = 7,

      -- The color of the hints
      highlight = "Comment",
    },

    -- options same as lsp hover / vim.lsp.util.open_floating_preview()
    hover_actions = {

      -- the border that is used for the hover window
      -- see vim.api.nvim_open_win()
      -- border = {
      -- 	{ "╭", "FloatBorder" },
      -- 	{ "─", "FloatBorder" },
      -- 	{ "╮", "FloatBorder" },
      -- 	{ "│", "FloatBorder" },
      -- 	{ "╯", "FloatBorder" },
      -- 	{ "─", "FloatBorder" },
      -- 	{ "╰", "FloatBorder" },
      -- 	{ "│", "FloatBorder" },
      -- },

      -- whether the hover action window gets automatically focused
      -- default: false
      auto_focus = false,
    },
  },

  -- all the opts to send to nvim-lspconfig
  -- these override the defaults set by rust-tools.nvim
  -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
  server = {
    settings = {
      ["rust-analyzer"] = {
        cargo = {
          -- features = { "pro" },
          -- extraArgs = { "--all-features" },
        },
        checkOnSave = {
          -- features = { "pro" },
          -- extraArgs = { "--all-features" },
        },
      },
    },

    handlers = handlers,
    capabilities = capabilities,
    on_attach = function(_, bufnr)
      local bufopts = { noremap = true, silent = true, buffer = bufnr }
      -- Hover actions
      vim.keymap.set("n", "<Leader>lh", rt.hover_actions.hover_actions, { buffer = bufnr })
      vim.keymap.set("n", "<Leader>rr", rt.runnables.runnables, { buffer = bufnr })
      -- Code action groups
      vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
      vim.keymap.set("n", "<space>lf", function()
        vim.lsp.buf.format({ async = true })
      end, { buffer = bufnr })
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
      vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
      vim.api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr()")
      vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
      vim.api.nvim_buf_set_option(bufnr, "tagfunc", "v:lua.vim.lsp.tagfunc")
    end,
    -- standalone file support
    -- setting it to false may improve startup time
    standalone = false,
  }, -- rust-analyzer options

  -- debugging stuff
  dap = {
    adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
  },
}

rt.setup(rust_opts)

local ts = require("typescript")
local ts_opts = {
  capabilities = require("modules.completion.tsserver").capabilities,
  handlers = require("modules.completion.tsserver").handlers,
  on_attach = require("modules.completion.tsserver").on_attach,
  settings = require("modules.completion.tsserver").settings,
}

-- It enables tsserver automatically so no need to call lspconfig.tsserver.setup
ts.setup({ server = ts_opts })
lspconfig.angularls.setup({})

lspconfig.eslint.setup({
  capabilities = capabilities,
  handlers = handlers,
  on_attach = require("modules.completion.eslint").on_attach,
  settings = require("modules.completion.eslint").settings,
})

local servers = {
  julials = {
    cmd = {
      "julia",
      "--project=@nvim-lspconfig",
      "-J" .. vim.fn.getenv("HOME") .. "/.julia/environments/nvim-lspconfig/languageserver.so",
      "--sysimage-native-code=yes",
      "--startup-file=no",
      "--history-file=no",
      "-e",
      [[
		# just in case
		import Pkg;
		function recurse_project_paths(path::AbstractString)
			isnothing(Base.current_project(path)) && return
			tmp = path
			CUSTOM_LOAD_PATH = []
			while !isnothing(Base.current_project(tmp))
					pushfirst!(CUSTOM_LOAD_PATH, tmp)
					tmp = dirname(tmp)
			end
			# push all to LOAD_PATHs
			pushfirst!(Base.LOAD_PATH, CUSTOM_LOAD_PATH...)
			return joinpath(CUSTOM_LOAD_PATH[1], "Project.toml")
    end
		buffer_file_path = "]]
          .. vim.fn.expand("%:p:h")
          .. '";'
          .. [[
    project_path = let 
			dirname(something(
				# 1. Check if there is an explicitly set project
				# 2. Check for Project.toml in current working directory
				# 3. Check for Project.toml from buffer's full file path exluding the file name
				# 4. Fallback to global environment
				Base.load_path_expand((
                p = get(ENV, "JULIA_PROJECT", nothing);
                p === nothing ? nothing : isempty(p) ? nothing : p
        )),
				Base.current_project(strip(buffer_file_path)),
				Base.current_project(pwd()),
				Pkg.Types.Context().env.project_file,
				Base.active_project()
			))
		end
    ls_install_path = joinpath(get(DEPOT_PATH, 1, joinpath(homedir(), ".julia")), "environments", "nvim-lspconfig");
    pushfirst!(LOAD_PATH, ls_install_path);
    using LanguageServer;
    popfirst!(LOAD_PATH);
		@info "LOAD_PATHS: $(Base.load_path())"
    depot_path = get(ENV, "JULIA_DEPOT_PATH", "");
    symbol_server_path = joinpath(homedir(), ".cache", "nvim", "julia_lsp_symbol_store")
    mkpath(symbol_server_path)
		@info "LanguageServer has started with buffer $project_path or $(pwd())"
    server = LanguageServer.LanguageServerInstance(stdin, stdout, project_path, depot_path, nothing, symbol_server_path, true);
    server.runlinter = true;
    run(server);
		]]   ,
    },
    settings = {
      julia = {
        symbolCacheDownload = true,
        lint = {
          missingrefs = "all",
          iter = true,
          lazy = true,
          modname = true,
        },
      },
    },
  },
}

for lsp, setup in pairs(servers) do
  setup.on_attach = on_attach
  setup.capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
  if lsp == "julials" then
    capabilities.textDocument.completion.completionItem.preselectSupport = true
    capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
    capabilities.textDocument.completion.completionItem.deprecatedSupport = true
    capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
    capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
    capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
    capabilities.textDocument.completion.completionItem.resolveSupport = {
      properties = { "documentation", "detail", "additionalTextEdits" },
    }
    capabilities.textDocument.completion.completionItem.documentationFormat = { "markdown" }
    capabilities.textDocument.codeAction = {
      dynamicRegistration = true,
      codeActionLiteralSupport = {
        codeActionKind = {
          valueSet = (function()
            local res = vim.tbl_values(vim.lsp.protocol.CodeActionKind)
            table.sort(res)
            return res
          end)(),
        },
      },
    }

    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
      virtual_text = false,
      underline = false,
      signs = true,
      update_in_insert = false,
    })
  end
  lspconfig[lsp].setup(setup)
end

-- local servers = {
--   "pyright",
-- }
--
-- for _, server in ipairs(servers) do
--   lspconfig[server].setup({})
-- end
