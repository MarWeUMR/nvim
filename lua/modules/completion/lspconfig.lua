local lspconfig = require("lspconfig")

local capabilities = vim.lsp.protocol.make_client_capabilities()

local handlers = {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
  ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
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

lspconfig.sumneko_lua.setup({
  handlers = handlers,
  on_attach = function(_, bufnr)
    vim.keymap.set("n", "<space>lf", function()
      vim.lsp.buf.format({ async = true })
    end, { buffer = bufnr })
    vim.api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr()")
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
    vim.api.nvim_buf_set_option(bufnr, "tagfunc", "v:lua.vim.lsp.tagfunc")
  end,
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
      border = {
        { "╭", "FloatBorder" },
        { "─", "FloatBorder" },
        { "╮", "FloatBorder" },
        { "│", "FloatBorder" },
        { "╯", "FloatBorder" },
        { "─", "FloatBorder" },
        { "╰", "FloatBorder" },
        { "│", "FloatBorder" },
      },

      -- whether the hover action window gets automatically focused
      -- default: false
      auto_focus = false,
    },
  },

  -- all the opts to send to nvim-lspconfig
  -- these override the defaults set by rust-tools.nvim
  -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
  server = {
    handlers = handlers,
    capabilities = capabilities,
    on_attach = function(_, bufnr)
      -- Hover actions
      vim.keymap.set("n", "<Leader>lh", rt.hover_actions.hover_actions, { buffer = bufnr })
      vim.keymap.set("n", "<Leader>rr", rt.runnables.runnables, { buffer = bufnr })
      -- Code action groups
      vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
      vim.keymap.set("n", "<space>lf", function()
        vim.lsp.buf.format({ async = true })
      end, { buffer = bufnr })
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
  -- dap = {
  --   adapter = {
  --     type = "executable",
  --     command = "lldb-vscode",
  --     name = "rt_lldb",
  --   },
  -- },
}

rt.setup(rust_opts)


-- It enables tsserver automatically so no need to call lspconfig.tsserver.setup
require("typescript").setup({
  disable_commands = false, -- prevent the plugin from creating Vim commands
  debug = false, -- enable debug logging for commands
  -- LSP Config options
  server = {
    capabilities = require("modules.completion.tsserver").capabilities,
    handlers = require("modules.completion.tsserver").handlers,
    on_attach = require("modules.completion.tsserver").on_attach,
    settings = require("modules.completion.tsserver").settings,
  },
})

-- local servers = {
--   'pyright',
--   'bashls',
--   'zls',
-- }
--
-- for _, server in ipairs(servers) do
--   lspconfig[server].setup({})
-- end
