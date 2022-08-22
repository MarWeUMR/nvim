if vim.g.vscode then
    require("core/options")
    -- VSCode extension
    -- vim.cmd([[source XXXXX.vim]])
else
    -- Import Lua modules
    require("packer_init")
    require("core/options")
    require("core/keymaps")
    require("plugins/nvim-tree")
    require("plugins/telescope")
    require("plugins/whichkey_conf")
    require("plugins/mason")
    require("plugins/bufferline")
    require("plugins/leap")
    -- require("plugins/cat")
    -- require("plugins/material")
    require("plugins/cmp")
    require("plugins/comments")
    require("plugins/lualine")
    require("plugins/indent_blankline")
    require("plugins/gitsigns")
    require("plugins/fterm")
    require("lsp")
end
