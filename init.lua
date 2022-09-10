if vim.g.vscode then
    require("core/options")
    -- VSCode extension
    -- vim.cmd([[source XXXXX.vim]])
else

    -- Ensure all autocommands are cleared
    vim.api.nvim_create_augroup("vimrc", {})

    ----------------------------------------------------------------------------------------------------
    -- NEOVIDE SPECIFICS
    ----------------------------------------------------------------------------------------------------

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
    require("core/globals")
    require("core/styles")
    require("core/options")
    require("core/custom_highlights")
    require("packer_init")
    require("core/externals")
    require("core/keymaps")
    require("plugins/alpha")
    require("plugins/cat")
    require("plugins/cmp")
    require("plugins/comments")
    require("plugins/nvim-tree")
    require("plugins/whichkey_conf")
    -- require("plugins/mason")
    require("plugins/neogit")
    require("plugins/bufferline")
    require("plugins/leap")
    require("plugins/material")
    require("plugins/ufo")
    require("plugins/lualine")
    require("plugins/indent_blankline")
    require("plugins/telescope")
    require("plugins/treesitter")
    require("plugins/gitsigns_conf")
    require("plugins/fterm")
    require("lsp")

if vim.g.neovide then
    vim.g.gui_font_default_size = 18
    vim.g.gui_font_size = vim.g.gui_font_default_size
    vim.g.gui_font_face = "JetbrainsMono Nerd Font"
    -- vim.opt.guifont = { "JetbrainsMono Nerd Font", ":h18" }
    -- vim.g.neovide_refresh_rate_idle = 60
    vim.g.neovide_no_idle= true


    vim.g.neovide_remember_window_size = true

    RefreshGuiFont = function()
        vim.opt.guifont = {
            string.format("%s", vim.g.gui_font_face),
            string.format(":h%s", vim.g.gui_font_size),
        }
    end

    ResizeGuiFont = function(delta)
        vim.g.gui_font_size = vim.g.gui_font_size + delta
        RefreshGuiFont()
    end

    ResetGuiFont = function()
        vim.g.gui_font_size = vim.g.gui_font_default_size
        RefreshGuiFont()
    end

    -- Call function on startup to set default value
    ResetGuiFont()

    -- Keymaps

    local opts = { noremap = true, silent = true }
    --
    vim.keymap.set({ "n", "i" }, "<C-+>", function()
        ResizeGuiFont(1)
    end, opts)
    vim.keymap.set({ "n", "i" }, "<C-->", function()
        ResizeGuiFont(-1)
    end, opts)
end
end
