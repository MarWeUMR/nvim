require("lsp.null-ls-conf")

-- "connect" the lsp server with nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())


-- LSP settings (for overriding per client)
local handlers = {
    ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = core.style.border.line }),
    ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = core.style.border.line }),
}


-- require("lspconfig").pyright.setup({})
require("lspconfig").sumneko_lua.setup({
    handlers = handlers,
    capabilities = capabilities,
    settings = {
        Lua = {
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { "vim" },
            },
        },
    },
})
require("lspconfig").pylsp.setup({
    handlers = handlers,
    capabilities = capabilities,
    settings = {
        pylsp = {
            plugins = {
                autopep8 = {
                    enabled = true,
                },
                jedi_completion = {
                    fuzzy = true,
                },
                pylint = {
                    enabled = true,
                },
                pycodestyle = {
                    enabled = true,
                },
                pydocstyle = {
                    enabled = false,
                },
                pylsp_mypy = {
                    enabled = true,
                    live_mode = true,
                },
            },
        },
    },
})

require("lsp.lsp-settings")
