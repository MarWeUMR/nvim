local ok, null_ls = pcall(require, "null-ls")
if not ok then
    return
end

    null_ls.setup({
        sources = {
            null_ls.builtins.formatting.stylua,
            null_ls.builtins.formatting.autopep8,
            null_ls.builtins.diagnostics.pylint,
            null_ls.builtins.diagnostics.mypy.with({
                extra_args = {"--config-file", ".mypyrc"}
            })
        },
        on_attach = require("lsp.on-attach"),
    })
