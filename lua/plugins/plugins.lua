-- Install packer
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	vim.fn.execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
end

local packer_group = vim.api.nvim_create_augroup("Packer", { clear = true })
vim.api.nvim_create_autocmd(
	"BufWritePost",
	{ command = "source <afile> | PackerCompile", group = packer_group, pattern = "init.lua" }
)

return require("packer").startup(function(use)
	-- packer
	use({ "wbthomason/packer.nvim" })

	------------------------------------------------------
	-- THEMES
	------------------------------------------------------

	use({ "navarasu/onedark.nvim" })

	use({ "yashguptaz/calvera-dark.nvim" })
	use({ "shaunsingh/moonlight.nvim" })
	use({ "rebelot/kanagawa.nvim" })
	use({ "catppuccin/nvim" })
	use({ "olimorris/onedarkpro.nvim" })
	use({ "FrenzyExists/aquarium-vim" })
	use({ "folke/tokyonight.nvim" })
	use({
		"sainnhe/sonokai",
		config = function()
			vim.g.sonokai_style = "atlantis"
		end,
	})

	use({
		"marko-cerovac/material.nvim",
		config = function()
			vim.g.material_style = "palenight"
		end,
	})
	use({ "Th3Whit3Wolf/space-nvim" })

	use({
		"sainnhe/edge",
		config = function()
			vim.g.edge_style = "neon"
		end,
	})
	use({
		"NTBBloodbath/doom-one.nvim",
		require("doom-one").setup({
			cursor_coloring = true,
			transparent_background = false,
			terminal_colors = true,
			italic_comments = true,
			enable_treesitter = true,
			plugins_integrations = {
				bufferline = true,
				gitgutter = true,
				gitsigns = true,
				telescope = true,
				neogit = true,
				nvim_tree = true,
				dashboard = true,
				startify = true,
				whichkey = true,
				indent_blankline = true,
				vim_illuminate = true,
				lspsaga = true,
			},
		}),
	})

	------------------------------------------------------
	-- REST
	------------------------------------------------------
	use("numToStr/Comment.nvim")
	use("windwp/nvim-autopairs")
	use({ "rebelot/heirline.nvim" })
	use({ "mfussenegger/nvim-dap" })
	use({
		"stevearc/aerial.nvim",
		config = function()
			require("aerial").setup({})
		end,
	})
	use({
		"nvim-telescope/telescope.nvim",
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	use({ "lukas-reineke/indent-blankline.nvim" })
	use({ "Pocco81/TrueZen.nvim" })
	use({
		"folke/zen-mode.nvim",
		config = function()
			require("zen-mode").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	})

	use({
		"ggandor/leap.nvim",
		config = function()
			require("leap").setup({})
		end,
	})
	use({ "stevearc/dressing.nvim" })

	use("nvim-telescope/telescope-media-files.nvim")
	use("kyazdani42/nvim-web-devicons")
	-- use("nvim-lua/popup.nvim") -- An implementation of the Popup API from vim in Neovim
	use("nvim-lua/plenary.nvim") -- Useful lua functions used ny lots of plugins
	use("kyazdani42/nvim-tree.lua")
	use({ "nvim-pack/nvim-spectre" })

	------------------------------------------------------
	-- LSP RELATED
	------------------------------------------------------
	use({
		"SmiteshP/nvim-gps",
		requires = "nvim-treesitter/nvim-treesitter",

		config = function()
			require("nvim-gps").setup()
		end,
	})
	use({
		"j-hui/fidget.nvim",
		config = function()
			require("fidget").setup({})
		end,
	})

	use({
		"neovim/nvim-lspconfig",
	})
	-- use("williamboman/nvim-lsp-installer")
	use("jose-elias-alvarez/null-ls.nvim") -- for formatters and linters
	use("ray-x/lsp_signature.nvim")

	-----------------------------
	-- COPILOT

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
		after = { "copilot.lua", "nvim-cmp" },
	})

	------------------------------------------------------
	-- COMPLETION
	------------------------------------------------------

	use({
		"hrsh7th/nvim-cmp",
		branch = "main", --float menu
		requires = { "onsails/lspkind-nvim" },
	})
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-cmdline")
	use("saadparwaiz1/cmp_luasnip")
	use("L3MON4D3/LuaSnip")

	------------------------------------------------------
	-- TREESITTER
	------------------------------------------------------
	use({ "ray-x/cmp-treesitter" })
	use("JoosepAlviste/nvim-ts-context-commentstring")
	use("windwp/nvim-ts-autotag")

	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})
	use({
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	})
	use("akinsho/bufferline.nvim")
	use("akinsho/toggleterm.nvim")
	use({
		"goolord/alpha-nvim",
		requires = { "kyazdani42/nvim-web-devicons" },
		config = function()
			require("alpha").setup(require("alpha.themes.dashboard").config)
		end,
	})
	use("folke/which-key.nvim")
	use("ahmedkhalf/project.nvim")

	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})

	use({ "simrat39/rust-tools.nvim" })
	use({ "andymass/vim-matchup" })
	use({ "romgrk/nvim-treesitter-context" })
	-- use({ "machakann/vim-sandwich" })
	use({
		"petertriho/nvim-scrollbar",
		config = function()
			require("scrollbar").setup()
		end,
	})

	-- COPILOT
	-- use({ "github/copilot.vim" })
	-- use({ "hrsh7th/cmp-copilot" })

	-------

	use({
		"beauwilliams/focus.nvim",
		config = function()
			require("focus").setup()
		end,
	})
	use({
		"sindrets/winshift.nvim",

		config = function()
			require("winshift").setup({
				highlight_moving_win = true, -- Highlight the window being moved
				focused_hl_group = "Visual", -- The highlight group used for the moving window
				moving_win_options = {
					-- These are local options applied to the moving window while it's
					-- being moved. They are unset when you leave Win-Move mode.
					wrap = false,
					cursorline = false,
					cursorcolumn = false,
					colorcolumn = "",
				},
				-- The window picker is used to select a window while swapping windows with
				-- ':WinShift swap'.
				-- A string of chars used as identifiers by the window picker.
				window_picker_chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
				window_picker_ignore = {
					-- This table allows you to indicate to the window picker that a window
					-- should be ignored if its buffer matches any of the following criteria.
					filetype = { -- List of ignored file types
						"NvimTree",
					},
					buftype = { -- List of ignored buftypes
						"terminal",
						"quickfix",
					},
				},
			})
		end,
	})
end)
