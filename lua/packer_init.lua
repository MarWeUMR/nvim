-----------------------------------------------------------
-- Plugin manager configuration file
-----------------------------------------------------------

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
        -- "hrsh7th/nvim-cmp",
        "williamboman/nvim-cmp",
        branch = "feat/docs-preview-window",
        requires = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-calc",
            "hrsh7th/cmp-path",
            "andersevenrud/cmp-tmux",
            "saadparwaiz1/cmp_luasnip",
            "petertriho/cmp-git",
            "onsails/lspkind-nvim",
            {
                "L3MON4D3/LuaSnip",
                requires = { "rafamadriz/friendly-snippets" },
            },
        },
    })

    --------------------------------------------------------------------------------
    -- LSP
    --------------------------------------------------------------------------------

    use({
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
        "folke/lua-dev.nvim",
        --"ray-x/lsp_signature.nvim",
        -- {"simrat39/rust-tools.nvim", branch = "modularize_and_inlay_rewrite" },
        "jose-elias-alvarez/null-ls.nvim",
    })

    use({
        "lvimuser/lsp-inlayhints.nvim",
        config = function()
            require("lsp-inlayhints").setup()
        end,
    })
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

    ----------------------------------------------------------------------------------
    -- COLOR SCHEMES
    --------------------------------------------------------------------------------
    use("marko-cerovac/material.nvim")

    use({
        "catppuccin/nvim",
    })
    use({ "sthendev/mariana.vim", run = "make" })
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

    --------------------------------------------------------------------------------
    -- TELESCOPE
    --------------------------------------------------------------------------------

    use({
        "nvim-telescope/telescope.nvim",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-project.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
        },
    })

    --------------------------------------------------------------------------------
    -- Git
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

    -- Autopair
    use({
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup({})
        end,
    })

    --------------------------------------------------------------------------------
    -- TREESITTER
    --------------------------------------------------------------------------------

    use({
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        requires = {
            "nvim-treesitter/nvim-treesitter-textobjects",
            "p00f/nvim-ts-rainbow",
            "JoosepAlviste/nvim-ts-context-commentstring",
            "windwp/nvim-ts-autotag",
        },
    })

    use("numToStr/Comment.nvim")

    use({
        "folke/which-key.nvim",
    })

    use({ "ggandor/leap.nvim" })
    use({ "ggandor/flit.nvim" })

    use({ "lukas-reineke/indent-blankline.nvim" })

    use({ "numToStr/FTerm.nvim" })
    use({
        "m-demare/hlargs.nvim",
        requires = { "nvim-treesitter/nvim-treesitter" },
        config = function()
            require("hlargs").setup()
        end,
    })

    use({ "akinsho/bufferline.nvim", tag = "v2.*", requires = "kyazdani42/nvim-web-devicons" })

    use({
        "glepnir/lspsaga.nvim",
        branch = "main",
        config = function()
            local saga = require("lspsaga")

            saga.init_lsp_saga({
                -- your configuration
            })
        end,
    })

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

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require("packer").sync()
    end
end)
