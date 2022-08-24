-----------------------------------------------------------
-- Plugin manager configuration file {{{
-----------------------------------------------------------


local utils = require('core.utils.plugins')

local conf = utils.conf

-- Automatically install packer
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })
    vim.o.runtimepath = vim.fn.stdpath("data") .. "/site/pack/*/start/*," .. vim.o.runtimepath
end

-- Autocommand that reloads neovim whenever you save the packer_init.lua file
-- vim.cmd([[
-- augroup packer_user_config
-- autocmd!
-- autocmd BufWritePost packer_init.lua source <afile> | PackerSync
-- augroup end
-- ]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end
-- }}}

-----------------------------------------------------------
-- Install plugins
return packer.startup(function(use)
    -- Add you plugins here:
    use("wbthomason/packer.nvim") -- packer can manage itself
    use("nvim-lua/plenary.nvim") -- Useful lua functions used ny lots of plugins

    -- File explorer
    use({
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        config = conf("neo-tree"),
        keys = { "<C-N>" },
        cmd = { "NeoTree" },
        requires = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "kyazdani42/nvim-web-devicons",
            { "mrbjarksen/neo-tree-diagnostics.nvim", module = "neo-tree.sources.diagnostics" },
            { "s1n7ax/nvim-window-picker", tag = "v1.*", config = conf("window-picker") },
        },
    })

    -- use({
    --     "kyazdani42/nvim-tree.lua",
    --     requires = {
    --         "kyazdani42/nvim-web-devicons", -- optional, for file icons
    --     },
    --     tag = "nightly", -- optional, updated every week. (see issue #1193)
    -- })

    use({
        "hrsh7th/nvim-cmp",
        requires = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "onsails/lspkind-nvim",
            {
                "L3MON4D3/LuaSnip",
                requires = { "rafamadriz/friendly-snippets" },
            },
        },
    })

    --------------------------------------------------------------------------------
    -- LSP {{{
    --------------------------------------------------------------------------------

    use("neovim/nvim-lspconfig")
    use("jose-elias-alvarez/null-ls.nvim")
    -- use({
    -- 	"williamboman/mason.nvim",
    -- 	"williamboman/mason-lspconfig.nvim",
    -- 	"neovim/nvim-lspconfig",
    -- 	"folke/lua-dev.nvim",
    -- 	--"ray-x/lsp_signature.nvim",
    -- 	-- {"simrat39/rust-tools.nvim", branch = "modularize_and_inlay_rewrite" },
    -- 	"jose-elias-alvarez/null-ls.nvim",
    -- })

    use({ "j-hui/fidget.nvim" })
    --"SmiteshP/nvim-navic",
    -- use({
    --     "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    --     config = function()
    --         require("lsp_lines").setup()
    --         vim.diagnostic.config({
    --             virtual_text = false,
    --         })
    --     end,
    -- })

    use({
        "lvimuser/lsp-inlayhints.nvim",
        config = function()
            require("lsp-inlayhints").setup({
                inlay_hints = {
                    highlight = "Comment",
                    labels_separator = " ⏐ ",
                    parameter_hints = {
                        prefix = "",
                    },
                    type_hints = {
                        prefix = "=> ",
                        remove_colon_start = true,
                    },
                },
            })
        end,
    })

    -- }}}

    --------------------------------------------------------------------------------
    ---- COLOR SCHEMES {{{1
    --------------------------------------------------------------------------------

    use({ "Shadorain/shadotheme" })

    use({ "LunarVim/horizon.nvim" })

    use("marko-cerovac/material.nvim")

    use({
        "catppuccin/nvim",
    })
    use("kaiuri/nvim-juliana")

    use({ "rebelot/kanagawa.nvim" })
    -- use({
    --     "navarasu/onedark.nvim",
    --     config = function()
    --         require("onedark").setup({
    --             style = "warmer",
    --         })
    --         require("onedark").load()
    --     end,
    -- })
    use("EdenEast/nightfox.nvim")

    -- use({
    --     "NTBBloodbath/doom-one.nvim",
    --     setup = function()
    --         -- Add color to cursor
    --         vim.g.doom_one_cursor_coloring = false
    --         -- Set :terminal colors
    --         vim.g.doom_one_terminal_colors = true
    --         -- Enable italic comments
    --         vim.g.doom_one_italic_comments = false
    --         -- Enable TS support
    --         vim.g.doom_one_enable_treesitter = true
    --         -- Color whole diagnostic text or only underline
    --         vim.g.doom_one_diagnostics_text_color = true
    --         -- Enable transparent background
    --         vim.g.doom_one_transparent_background = false
    --
    --         -- Pumblend transparency
    --         vim.g.doom_one_pumblend_enable = false
    --         vim.g.doom_one_pumblend_transparency = 20
    --
    --         -- Plugins integration
    --         vim.g.doom_one_plugin_neorg = true
    --         vim.g.doom_one_plugin_barbar = false
    --         vim.g.doom_one_plugin_telescope = true
    --         vim.g.doom_one_plugin_neogit = true
    --         vim.g.doom_one_plugin_nvim_tree = true
    --         vim.g.doom_one_plugin_dashboard = true
    --         vim.g.doom_one_plugin_startify = true
    --         vim.g.doom_one_plugin_whichkey = true
    --         vim.g.doom_one_plugin_indent_blankline = true
    --         vim.g.doom_one_plugin_vim_illuminate = true
    --         vim.g.doom_one_plugin_lspsaga = false
    --     end,
    --     config = function()
    --         vim.cmd("colorscheme doom-one")
    --     end,
    -- })
    -- }}}

    --------------------------------------------------------------------------------
    -- TELESCOPE {{{
    --------------------------------------------------------------------------------

    use({
        "nvim-telescope/telescope.nvim",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-project.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
        },
    })
    -- }}}

    --------------------------------------------------------------------------------
    -- Git {{{
    --------------------------------------------------------------------------------

    use({
        "TimUntersberger/neogit",
        requires = "nvim-lua/plenary.nvim",
    })

    use({
        "lewis6991/gitsigns.nvim",
        event = "CursorHold",
        config = function()
            require("gitsigns")
        end,
    })

    use({
        "sindrets/diffview.nvim",
        requires = "nvim-lua/plenary.nvim",

        config = function()
            require("diffview").setup({
                enhanced_diff_hl = true,
                key_bindings = {
                    file_panel = { q = "<Cmd>DiffviewClose<CR>" },
                    view = { q = "<Cmd>DiffviewClose<CR>" },
                },
            })
        end,
    })

    -- }}}

    --------------------------------------------------------------------------------
    -- Syntax {{{
    --------------------------------------------------------------------------------
    use({
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        --config = conf('treesitter'),
        --local_path = 'contributing',
        requires = {
            {
                "nvim-treesitter/playground",
                cmd = { "TSPlaygroundToggle", "TSHighlightCapturesUnderCursor" },
            },
        },
    })

    use({ "p00f/nvim-ts-rainbow" })
    use({ "nvim-treesitter/nvim-treesitter-textobjects" })

    use({
        "nvim-treesitter/nvim-treesitter-context",
        config = function()
            local hl = require("core.highlights")
            hl.plugin("treesitter-context", {
                { ContextBorder = { link = "Dim" } },
                { TreesitterContext = { inherit = "Normal" } },
                { TreesitterContextLineNumber = { inherit = "LineNr" } },
            })
            require("treesitter-context").setup({
                multiline_threshold = 4,
                separator = { "─", "ContextBorder" }, -- alternatives: ▁ ─ ▄
                mode = "topline",
            })
        end,
    })

    use({
        "m-demare/hlargs.nvim",
        config = function()
            require("core.highlights").plugin("hlargs", {
                theme = {
                    ["*"] = { { Hlargs = { italic = true, foreground = "#A5D6FF" } } },
                    ["horizon"] = { { Hlargs = { italic = true, foreground = { from = "Normal" } } } },
                },
            })
            require("hlargs").setup({
                excluded_argnames = {
                    declarations = { "use", "use_rocks", "_" },
                    usages = {
                        go = { "_" },
                        lua = { "self", "use", "use_rocks", "_" },
                    },
                },
            })
        end,
    })

    --------------------------------------------------------------------------------
    -- RANDOM STUFF {{{
    --------------------------------------------------------------------------------

    use({
        "norcalli/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup({ "lua", "vim", "kitty", "conf" }, {
                RGB = false,
                mode = "background",
            })
        end,
    })

    -- Autopair
    use({
        "windwp/nvim-autopairs",
        event = "InsertCharPre",
        after = "nvim-cmp",
        config = function()
            require("nvim-autopairs").setup({})
        end,
    })

    use("numToStr/Comment.nvim")

    use({
        "folke/which-key.nvim",
    })

    use({ "ggandor/leap.nvim" })
    use({ "ggandor/flit.nvim" })

    use({ "lukas-reineke/indent-blankline.nvim" })

    use({ "numToStr/FTerm.nvim" })

    use({ "akinsho/bufferline.nvim", tag = "v2.*", requires = "kyazdani42/nvim-web-devicons" })

    use({
        "nvim-lualine/lualine.nvim",
        requires = { "kyazdani42/nvim-web-devicons" },
    })

    use({
        "lewis6991/satellite.nvim",
        config = function()
            require("satellite").setup()
        end,
    })

    -- }}}

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require("packer").sync()
    end
end)
-----------------------------------------------------------
