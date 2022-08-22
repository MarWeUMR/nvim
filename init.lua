if vim.g.vscode then
    require("core/options")
    -- VSCode extension
    -- vim.cmd([[source XXXXX.vim]])
else
    -- Import Lua modules
    require("packer_init")
    require("core/options")
    -- require('core/autocmds')
    require("core/keymaps")
    -- require('core/colors')
    -- require('core/statusline')
    require("plugins/nvim-tree")
    require("plugins/telescope")
    require("plugins/whichkey")
    require("plugins/mason")
    require("plugins/leap")
    require("plugins/cat")
    require("plugins/cmp")
    require("plugins/comments")
    require("plugins/indent_blankline")
    require("plugins/gitsigns")
    require("plugins/fterm")
    require("lsp")
end
