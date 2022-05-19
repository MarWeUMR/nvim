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
	-- themes
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
	-- rest

	use({
		"SmiteshP/nvim-gps",
		requires = "nvim-treesitter/nvim-treesitter",

		config = function()
			require("nvim-gps").setup()
		end,
	})

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
	-- LSP
	------------------------------------------------------

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
	use({ "ray-x/cmp-treesitter" })
	use("saadparwaiz1/cmp_luasnip")
	use("L3MON4D3/LuaSnip")
	use("numToStr/Comment.nvim")
	use("JoosepAlviste/nvim-ts-context-commentstring")
	use("windwp/nvim-ts-autotag")
	use("windwp/nvim-autopairs")
	-- Treesitter
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
	-- use({
	--   "sudormrfbin/cheatsheet.nvim",
	--
	--   requires = {
	--     { "nvim-telescope/telescope.nvim" },
	--     { "nvim-lua/popup.nvim" },
	--     { "nvim-lua/plenary.nvim" },
	--   },
	--
	--   config = function()
	--     local keys = require("which-key.keys")
	--
	--     local user_maps = {}
	--     for _, tree in pairs(keys.mappings) do
	--       tree.tree:walk(function(node)
	--         if -- node.mapping -- only include real mappings
	--         node.mapping.label -- with a label
	--             -- and not node.mapping.group -- no groups
	--             -- and not node.mapping.preset -- no presets
	--             and node.mapping.label ~= "which_key_ignore" -- no ignored keymaps
	--         then
	--           table.insert(user_maps, {
	--             keys = table.concat(node.mapping.keys.nvim, ""),
	--             mode = node.mapping.mode,
	--             label = node.mapping.label,
	--             buf = node.mapping.buf,
	--             group = node.mapping.group,
	--             real_mapping = node.mapping
	--                 and node.mapping.label
	--                 and not node.mapping.group
	--                 and not node.mapping.preset
	--                 and node.mapping.label ~= "which_key_ignore",
	--           })
	--         end
	--       end)
	--     end
	--
	--     local cheatsheet = require("cheatsheet")
	--
	--     -- This loop goes over the table (generated at the top of this file) of all user which-key mappings.
	--     -- It then adds these mappings to the list of cheatsheet entries.
	--
	--     local last_grp = ""
	--
	--     for _, data in pairs(user_maps) do
	--       if data["group"] == true then
	--         last_grp = data["label"]
	--       end
	--
	--       if data["real_mapping"] == true then
	--         -- print(string.format("group: %s\nlabel: %s\nkeys: %s", last_grp, data["label"], data["keys"]))
	--
	--         cheatsheet.add_cheat(data["label"], data["keys"], string.format("WK-%s", last_grp))
	--       end
	--     end
	--   end,
	-- })
	--

	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})
	-- use({ "matze/rust-tools.nvim", branch = "fix-175-migrate-to-lsp-hints" })
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
