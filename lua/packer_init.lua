-----------------------------------------------------------
-- Plugin manager configuration file {{{
-----------------------------------------------------------

local utils = require("core.utils.plugins")

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
        module = "cmp",
        event = "InsertEnter",
        config = conf("cmp"),
        requires = {
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-nvim-lsp-document-symbol", after = "nvim-cmp" },
            -- { "hrsh7th/cmp-cmdline", after = "nvim-cmp" },
            -- { "f3fora/cmp-spell", after = "nvim-cmp" },
            { "hrsh7th/cmp-path", after = "nvim-cmp" },
            { "hrsh7th/cmp-buffer", after = "nvim-cmp" },
            -- { "hrsh7th/cmp-emoji", after = "nvim-cmp" },
            -- { "rcarriga/cmp-dap", after = "nvim-cmp" },
            { "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" },
            {
                "L3MON4D3/LuaSnip",
                requires = { "rafamadriz/friendly-snippets" },
            },
            -- { "dmitmel/cmp-cmdline-history", after = "nvim-cmp" },
            -- { "lukas-reineke/cmp-rg", tag = "*", after = "nvim-cmp" },
        },
    })

    -- use({
    --     "hrsh7th/nvim-cmp",
    --     requires = {
    --         "hrsh7th/cmp-nvim-lsp",
    --         "hrsh7th/cmp-buffer",
    --         "hrsh7th/cmp-path",
    --         "onsails/lspkind-nvim",
    --         {
    --             "L3MON4D3/LuaSnip",
    --             requires = { "rafamadriz/friendly-snippets" },
    --         },
    --     },
    --     config = conf('cmp2')
    -- })

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

    -- 	--"ray-x/lsp_signature.nvim",
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
        "stevearc/aerial.nvim",
        config = function()
            require("aerial").setup()
        end,
    })

    use({
        "simrat39/rust-tools.nvim",
        config = function()
            local rt = require("rust-tools")

            rt.setup({
                server = {
                    on_attach = function(_, bufnr)
                        -- Hover actions
                        -- vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
                        -- Code action groups
                        -- vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
                    end,
                },
            })
        end,
    })

    -- }}}

    --------------------------------------------------------------------------------
    ---- COLOR SCHEMES {{{
    --------------------------------------------------------------------------------
    use({ "sainnhe/everforest" })
    use({
        "sainnhe/edge",
        config = function()
            vim.g.edge_style = "neon"
            vim.g.edge_better_performance = 1
        end,
    })
    use({ "sam4llis/nvim-tundra" })
    use("olimorris/onedarkpro.nvim")

    use({
        "rafamadriz/neon",
        config = function()
            vim.g.neon_style = "default"
            vim.g.neon_italic_keyword = true
            vim.g.neon_italic_function = true
            vim.g.neon_transparent = true
        end,
    })
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
    use("Th3Whit3Wolf/space-nvim")

    use({ "LunarVim/horizon.nvim" })

    use("marko-cerovac/material.nvim")

    use({
        "catppuccin/nvim",
    })
    use("kaiuri/nvim-juliana")

    use({ "rebelot/kanagawa.nvim" })

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
        config = conf("telescope").config,
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
        config = function()
            require("gitsigns").setup()
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
            local hl = require("core.custom_highlights")
            hl.plugin("treesitter-context", {
                { ContextBorder = { link = "Dim" } },
                { TreesitterContext = { inherit = "Normal" } },
                { TreesitterContextLineNumber = { inherit = "LineNr" } },
            })
            require("treesitter-context").setup({
                multiline_threshold = 4,
                separator = { "▄", "ContextBorder" }, -- alternatives: ▁ ─ ▄
                mode = "topline",
            })
        end,
    })

    use({
        "m-demare/hlargs.nvim",
        config = function()
            require("core.custom_highlights").plugin("hlargs", {
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

    --}}}

    --------------------------------------------------------------------------------
    -- RANDOM STUFF {{{
    --------------------------------------------------------------------------------

    use({ "goolord/alpha-nvim", config = conf("alpha") })

    use({
        "ahmedkhalf/project.nvim",
        config = function()
            require("project_nvim").setup({
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            })
        end,
    })

    use({ "kevinhwang91/nvim-ufo", requires = "kevinhwang91/promise-async" })

    -- TODO: this fixes a bug in neovim core that prevents "CursorHold" from working
    -- hopefully one day when this issue is fixed this can be removed
    -- @see: https://github.com/neovim/neovim/issues/12587
    use("antoinemadec/FixCursorHold.nvim")

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
        config = conf('whichkey_conf')
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
        opt = true,
        event = { "VimEnter" },
        config = function()
            vim.schedule(function()
                require("copilot").setup()
            end)
        end,
    })

    use({
        "zbirenbaum/copilot-cmp",
        requires = { "copilot.lua", opt = true },
        opt = true,
        config = function()
            require("copilot-cmp").setup({
                -- method = "getCompletionsCycling",
                -- force_autofmt = false,
                -- formatters = {
                --     label = require("copilot_cmp.format").format_label_text,
                --     insert_text = require("copilot_cmp.format").format_label_text,
                --     -- insert_text = require("copilot_cmp.format").remove_existing,
                --     preview = require("copilot_cmp.format").deindent,
                -- },
            })
        end,
    })

    use({
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
            require("trouble").setup({
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            })
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
