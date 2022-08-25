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
--
-- Install plugins
return packer.startup(function(use)
    -- Add you plugins here:
    use("wbthomason/packer.nvim") -- packer can manage itself
    use("nvim-lua/plenary.nvim") -- Useful lua functions used ny lots of plugins

    -- File explorer
    use({
        "kyazdani42/nvim-tree.lua",
        requires = {
            "kyazdani42/nvim-web-devicons", -- optional, for file icons
        },
        tag = "nightly", -- optional, updated every week. (see issue #1193)
    })

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
    use({
        "ray-x/lsp_signature.nvim",
        config = function()
            require("lsp_signature").setup({
                bind = true,
                fix_pos = false,
                auto_close_after = 15, -- close after 15 seconds
                hint_enable = false,
                handler_opts = { border = core.style.current.border },
                toggle_key = "<C-K>",
                select_signature_key = "<M-N>",
            })
        end,
    })
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
    ---- COLOR SCHEMES {{{
    --------------------------------------------------------------------------------

    use({
        "folke/tokyonight.nvim",
        config = function()
            vim.g.tokyonight_style = "night"
            vim.g.tokyonight_italic_functions = true
            vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }

            -- Change the "hint" color to the "orange" color, and make the "error" color bright red
            vim.g.tokyonight_colors = { hint = "orange", error = "#ff0000" }
        end,
    })
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

    use({
        "NTBBloodbath/doom-one.nvim",
    })
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
        config = conf('telescope').config
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
    -- Syntax {{{1
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

    -- use("github/copilot.vim")

    use({
        "zbirenbaum/copilot.lua",
        event = { "VimEnter" },
        config = function()
            vim.defer_fn(function()
                require("copilot").setup()
            end, 100)
        end,
    })

    use({
        "zbirenbaum/copilot-cmp",
        module = "copilot_cmp",
    })

    -- }}}

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require("packer").sync()
    end
end)
-----------------------------------------------------------
