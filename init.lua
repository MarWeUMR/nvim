if vim.g.vscode then
    require("core/options")
    -- VSCode extension
    -- vim.cmd([[source XXXXX.vim]])
else
    vim.api.nvim_create_augroup("vimrc", {})

----------------------------------------------------------------------------------------------------
-- Global namespace
----------------------------------------------------------------------------------------------------
local namespace = {
  -- for UI elements like the winbar and statusline that need global references
  ui = {
    winbar = { enable = true },
  },
  -- some vim mappings require a mixture of commandline commands and function calls
  -- this table is place to store lua functions to be called in those mappings
  mappings = {},
}

_G.core = core or namespace

    -- Import Lua modules
    require("packer_init")
    require("core/options")
    require("core/globals")
    require("core/styles")
    require("core/highlights")
    require("core/externals")
    require("core/keymaps")
    require("plugins/nvim-tree")
    require("plugins/telescope")
    require("plugins/whichkey_conf")
    -- require("plugins/mason")
    require("plugins/neogit")
    require("plugins/bufferline")
    require("plugins/leap")
    -- require("plugins/cat")
    -- require("plugins/material")
    require("plugins/cmp")
    require("plugins/comments")
    require("plugins/lualine")
    require("plugins/indent_blankline")
    require("plugins/treesitter")
    require("plugins/gitsigns")
    require("plugins/fterm")
    require("lsp")
end
