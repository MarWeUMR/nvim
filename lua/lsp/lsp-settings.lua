-- vim.cmd([[autocmd! ColorScheme * highlight NormalFloat guibg=#1f2335]])
-- vim.cmd([[autocmd! ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]])

--------------------------------------------------------------------------------
-- HANDLE GUTTER AND INLINE LSP STUFF {{{1
--------------------------------------------------------------------------------

vim.diagnostic.config({
    virtual_text = {
        source = "always",
        prefix = "■",
    },
    float = {
        source = "always",
        border = core.style.border.line,
    },
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
})

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- }}}

--vim.cmd([[autocmd CursorHold,CursorHoldI * lua require('lsp.code_action_utils').code_action_listener()]])
