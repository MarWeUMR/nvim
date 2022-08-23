require("lsp.null-ls-conf")
-- require("lspconfig").pyright.setup({})
require("lspconfig").sumneko_lua.setup({})
require("lspconfig").pylsp.setup({
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
