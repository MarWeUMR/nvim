local config = {}

function config.tokyo()
	require("tokyonight").setup({
		transparent = true,
		on_highlights = function(hl, c)
			local prompt = "#2d3149"
			hl.TelescopeNormal = {
				bg = c.bg_dark,
				fg = c.fg_dark,
			}
			hl.TelescopeBorder = {
				bg = c.bg_dark,
				fg = c.bg_dark,
			}
			hl.TelescopePromptNormal = {
				bg = prompt,
			}
			hl.TelescopePromptBorder = {
				bg = prompt,
				fg = prompt,
			}
			hl.TelescopePromptTitle = {
				bg = prompt,
				fg = prompt,
			}
			hl.TelescopePreviewTitle = {
				bg = c.bg_dark,
				fg = c.bg_dark,
			}
			hl.TelescopeResultsTitle = {
				bg = c.bg_dark,
				fg = c.bg_dark,
			}
		end,
	})

	vim.cmd("colorscheme tokyonight-storm")
end

function config.cat()
	require("catppuccin").setup({
		flavour = "frappe", -- latte, frappe, macchiato, mocha
		background = { -- :h background
			light = "latte",
			dark = "frappe",
		},
		compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
		transparent_background = true,
		term_colors = false,
		dim_inactive = {
			enabled = false,
			shade = "dark",
			percentage = 0.15,
		},
		styles = {
			comments = { "italic" },
			conditionals = { "italic" },
			loops = {},
			functions = {},
			keywords = {},
			strings = {},
			variables = {},
			numbers = {},
			booleans = {},
			properties = {},
			types = {},
			operators = {},
		},
		color_overrides = {},
		custom_highlights = {},
		integrations = {
			cmp = true,
			gitsigns = true,
			nvimtree = true,
			telescope = true,
			treesitter = true,
			-- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
		},
	})
end

function config.kanagawa()
	vim.cmd("colorscheme kanagawa")
end

function config.zephyr()
	vim.cmd("colorscheme zephyr")
end

function config.onedark()
	require("onedark").setup({
		style = "warmer",
	})
end

function config.themer()
	require("themer").setup({})
end

function config.neosolarized()
	local NeoSolarized = require("NeoSolarized")

	-- Default Setting for NeoSolarized

	NeoSolarized.setup({
		style = "dark", -- "dark" or "light"
		transparent = true, -- true/false
		terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
		enable_italics = true, -- Italics for different hightlight groups (eg. Statement, Condition, Comment, Include, etc.)
		styles = {
			-- Style for different style groups
			comments = { italic = true },
			keywords = { italic = true },
			functions = { bold = true },
			variables = {},
			string = { italic = true },
			underline = true, -- true/false; for global underline
			undercurl = true, -- true/false; for global undercurl
		},
	})
end

function config.galaxyline()
	require("modules.ui.eviline")
end

function config.alpha()
	local alpha = require("alpha")
	local dashboard = require("alpha.themes.dashboard")

	local heading = {
		type = "text",
		val = {
			"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡰⢄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠀⠀⠀⠀⢀⢄⠀⠀⡴⠁⠈⡆⠀⢀⡤⡀⠀⠀⠀⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⠢⣄⠀⠀⡇⠀⡕⠀⢸⠀⢠⠃⠀⢮⠀⠹⠀⠀⣠⢾⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡇⣞⠀⢀⠇⠀⡇⠀⡸⠀⠈⣆⠀⡸⠀⢰⠀⠀⡇⣸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⠘⢶⣯⣊⣄⡨⠟⡡⠁⠐⢌⠫⢅⣢⣑⣵⠶⠁⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣀⠀⠀⠀⠀⠀⣼⣀⠀⢀⠒⠒⠂⠉⠀⠀⠀⠀⠁⠐⠒⠂⡀⠀⣸⣄⠀⠀⠀⠀⠀⣀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⢮⣵⣶⣦⡩⡲⣄⠀⠀⣿⣿⣽⠲⠭⣥⣖⣂⣀⣀⣀⣀⣐⣢⡭⠵⠖⣿⣿⢫⠀⠀⣠⣖⣯⣶⣶⣮⡷⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⢸⡟⢉⣉⠙⣿⣿⣦⠀⣿⣿⣿⣿⣷⣲⠶⠤⠭⣭⡭⠭⠴⠶⣖⣾⣿⣿⡿⢸⢀⣼⣿⡿⠋⣉⠉⢳⠁⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠮⣳⣴⣫⠂⠘⣿⣿⣇⢷⢻⣿⣿⣿⣿⣿⣷⣶⣶⣶⣶⣿⣿⣿⣿⣿⢿⢃⡟⣼⣿⣿⠁⠸⣘⣢⣚⠜⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⠈⢧⢻ ⣿⣿⣟⠻⣿⣿⣿⣿⠛⣩⣿⣿ ⢟⡞⢀⣿⣿⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⣒⣒⣦⣄⣿⣿⣿⢀⡬⣟⣯  ⣿⢷⣼⡟⢿⣿⡿⣿⣿  ⡻⣤⡀⣿⣿⣸⡠⢔⣒⡒⢤⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⠀⠀⠀⠀⠀⠀⠀⢾⣟⣅⠉⢎⣽⣿⣿⡏⡟⣤⣮⣿⣿  ⡏⣿⠀⠀⣿⢡⣷  ⣿⣟⢎⣷⢻⣿⣿⣾⡟⠉⣽⡇⡇⠀⠀⠀⠀⠀⠀⠀⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⡴⣫⣭⣭⣍⡲⢄⠀⠀⠀⠀⠈⠻⠋⣠⡮⣻⣿⣿⠃⠳⣏⣼⣿⣿⣿⣿⡇⣿⣴⣴⣿⣾⣿⣿⣿⡿⣄⣩⠏⢸⣿⣿⣿⣧⡀⠛⠞⠁⠀⠀⠀⢀⣤⣺⣭⣭⣭⡝⢦⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⢸⢹⡟⠁⠀⠉⢫⡳⣵⣄⠀⠀⢀⠴⢊⣿⣾⣿⣿⣿⠀⠀⠀⠻⣬⣽⣿⣿⣿⣿  ⣿⣿⣿⣿⣯⣵⠏⠀⠀⢸⣿⣿⣿⣿⣿⣗⢤⡀⠀⠀⣠⣿⢟⠟⠉⠀⠈⢻⢸⡆⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠘⢏⢧⣤⡀⠀⠀⣇⢻⣿⣆⢔⢕⣵⠟⣏⣿⣿⣿⠋⣵⠚⠄⣾⣿⣿⣿⡿⠟⣛⣛⣛⣛⠻⣿⣿⣿⣿⣧⢰⠓⣏⠻⣿⣿⣿⢹⠻⣿⣿⢦⣸⣿⡏⡾⠀⠀⢠⣤⠎⡼⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⠈⠑⠂⠁⠀⠀⣿⠸⣿⢏⢂⣾⠇⠀⣿⣿⣿⡇⡆⠹⢷⣴⣿⡿⠟⠉⣐⡀⠄⣠⡄⡠⣁⡠⠙⠻⢿⣿⣴⡾⠃⢠⢹⣿⣿⢸⠀⢹⣿⣷⢹⣿⢃⡇⠀⠀⠈⠒⠋⠀⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⡀⣿⢀⣿⣿⡀⠀⢫⣿⣿⣷⣙⠒⠀⠄⠐⠂⣼⠾⣵⠾⠟⣛⣛⠺⢷⣮⠷⣢⠐⠂⠀⠀⠒⣣⣾⣿⡿⡎⠀⢠⣿⣿⡄⣿⣸⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣟⣿⢸⣿⣿⣷⣄⡈⣾⣿⣿⣿⣿⣿⠻⡷⢺⠃⠠⠁⠈⠋⠀⠀⠉⠁⠙⡀⠘⡗⣾⠿⣿⣿⣿⣿⣿⡿⢀⣴⣿⣿⡿⢃⣯⣽⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⣿⡆⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣵⡞⠀⠁⠐⢁⠎⠄⣠⠀⠀⡄⠀⢳⠈⠆⠈⠈⢳⣯⣿⣿⣿⣿⣿⣿⣿⣿⣿⡏⣸⡷⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠻⣌⠛⢿⣿⣿⣿⣿⣿⣿⠿⠋⣠⣢⠂⠀⢂⠌⠀⠃⠀⠀⠘⠀⢢⡑⠀⠰⣵⡀⠻⢿⣿⣿⣿⣿⣿⣿⡿⠋⣰⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠳⣤⣭⢛⣻⠿⣿⣷⣶⢞⡟⡁⢀⢄⠎⠀⠀⠀⠀⠀⡀⠁⠀⠳⢠⠀⢈⢿⢳⣶⣾⣿⠿⣟⣛⣅⡴⠞⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠙⠛⠻⠿⠿⡟⢜⠔⡠⢊⠔⠀⡆⠀⡆⠀⠀⢡⢰⢠⠀⢢⠱⣌⢂⠃⢿⠿⠿⠟⠛⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⢤⣊⡰⠵⢺⠉⠸⠀⢰⢃⠀⠀⠀⠀⠀⠸⢸⠀⠀⡇⡞⡑⠬⢆⣑⢤⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠁⠀⠀⠀⠘⣾⡸⢀⡜⡾⡀⡇⠀⠀⡴⢠⢻⢦⠀⢃⡿⠀⠀⠀⠀⠈⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠳⡎⠀⠱⡡⠐⠀⠠⠃⢢⠋⠀⢧⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⢤⡀⢀⠔⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠱⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
		},
		opts = {
			position = "center",
			hl = "AlphaHeading",
		},
	}

	local buttons = {
		type = "group",
		val = {
			{ type = "padding", val = 1 },
			dashboard.button("SPC r u", "  Recently used", "<cmd>Telescope oldfiles<CR>"),
			dashboard.button("SPC f f", "  Find file", "<cmd>Telescope find_files<CR>"),
			dashboard.button("SPC f g", "  Live grep"),
			dashboard.button("p", "  Projects", "<cmd>Telescope projects<CR>"),
			dashboard.button("s", "  Sessions", "<cmd>Telescope persisted<CR>"),
		},
		position = "center",
	}

	local conf = {
		layout = {
			{ type = "padding", val = 2 },
			heading,
			{ type = "padding", val = 1 },
			buttons,
			{ type = "padding", val = 1 },
			--loaded,
			{ type = "padding", val = 1 },
			-- footing,
			{ type = "padding", val = 2 },
		},
		opts = {
			margin = 5,
		},
	}

	alpha.setup(conf)
end

function config.nvim_bufferline()
	require("bufferline").setup({
		options = {
			debug = { logging = true },
			mode = "buffers", -- tabs
			sort_by = "insert_after_current",
			right_mouse_command = "vert sbuffer %d",
			show_buffer_close_icons = true,
			indicator = { style = "underline" },
			diagnostics = "nvim_lsp",
			diagnostics_update_in_insert = false,
			hover = { enabled = true, reveal = { "close" } },
			modified_icon = "✥",
			-- buffer_close_icon = "",
			always_show_bufferline = false,
		},
	})
end

function config.neo_tree()
	if not packer_plugins["plenary.nvim"].loaded then
		vim.cmd([[packadd plenary.nvim]])
	end
	-- vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
	require("neo-tree").setup({
		close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
		popup_border_style = "rounded",
		enable_git_status = true,
		enable_diagnostics = true,
		sort_case_insensitive = false, -- used when sorting files and directories in the tree
		sort_function = nil, -- use a custom function for sorting files and directories in the tree
		default_component_configs = {
			container = {
				enable_character_fade = true,
			},
			indent = {
				indent_size = 2,
				padding = 1, -- extra padding on left hand side
				-- indent guides
				with_markers = true,
				indent_marker = "│",
				last_indent_marker = "└",
				highlight = "NeoTreeIndentMarker",
				-- expander config, needed for nesting files
				with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
				expander_collapsed = "",
				expander_expanded = "",
				expander_highlight = "NeoTreeExpander",
			},
			icon = {
				folder_closed = "",
				folder_open = "",
				folder_empty = "ﰊ",
				-- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
				-- then these will never be used.
				default = "*",
				highlight = "NeoTreeFileIcon",
			},
			modified = {
				symbol = "[+]",
				highlight = "NeoTreeModified",
			},
			name = {
				trailing_slash = false,
				use_git_status_colors = true,
				highlight = "NeoTreeFileName",
			},
			git_status = {
				symbols = {
					-- Change type
					added = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
					modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
					deleted = "✖", -- this can only be used in the git_status source
					renamed = "", -- this can only be used in the git_status source
					-- Status type
					untracked = "",
					ignored = "",
					unstaged = "",
					staged = "",
					conflict = "",
				},
			},
		},
		window = {
			position = "left",
			width = 40,
			mapping_options = {
				noremap = true,
				nowait = true,
			},
			mappings = {
				["<space>"] = {
					"toggle_node",
					nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
				},
				["<2-LeftMouse>"] = "open",
				["<cr>"] = "open",
				["<esc>"] = "revert_preview",
				["P"] = { "toggle_preview", config = { use_float = true } },
				["S"] = "open_split",
				["s"] = "open_vsplit",
				-- ["S"] = "split_with_window_picker",
				-- ["s"] = "vsplit_with_window_picker",
				["t"] = "open_tabnew",
				-- ["<cr>"] = "open_drop",
				-- ["t"] = "open_tab_drop",
				["w"] = "open_with_window_picker",
				--["P"] = "toggle_preview", -- enter preview mode, which shows the current node without focusing
				["C"] = "close_node",
				["z"] = "close_all_nodes",
				--["Z"] = "expand_all_nodes",
				["a"] = {
					"add",
					-- some commands may take optional config options, see `:h neo-tree-mappings` for details
					config = {
						show_path = "none", -- "none", "relative", "absolute"
					},
				},
				["A"] = "add_directory", -- also accepts the optional config.show_path option like "add".
				["d"] = "delete",
				["r"] = "rename",
				["y"] = "copy_to_clipboard",
				["x"] = "cut_to_clipboard",
				["p"] = "paste_from_clipboard",
				["c"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
				-- ["c"] = {
				--  "copy",
				--  config = {
				--    show_path = "none" -- "none", "relative", "absolute"
				--  }
				--}
				["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
				["q"] = "close_window",
				["R"] = "refresh",
				["?"] = "show_help",
				["<"] = "prev_source",
				[">"] = "next_source",
			},
		},
		nesting_rules = {},
		filesystem = {
			filtered_items = {
				visible = false, -- when true, they will just be displayed differently than normal items
				hide_dotfiles = true,
				hide_gitignored = true,
				hide_hidden = true, -- only works on Windows for hidden files/directories
				hide_by_name = {
					--"node_modules"
				},
				hide_by_pattern = { -- uses glob style patterns
					--"*.meta",
					--"*/src/*/tsconfig.json",
				},
				always_show = { -- remains visible even if other settings would normally hide it
					--".gitignored",
				},
				never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
					".DS_Store",
					--"thumbs.db"
				},
				never_show_by_pattern = { -- uses glob style patterns
					--".null-ls_*",
				},
			},
			follow_current_file = true, -- This will find and focus the file in the active buffer every
			-- time the current file is changed while the tree is open.
			group_empty_dirs = false, -- when true, empty folders will be grouped together
			hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
			-- in whatever position is specified in window.position
			-- "open_current",  -- netrw disabled, opening a directory opens within the
			-- window like netrw would, regardless of window.position
			-- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
			use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
			-- instead of relying on nvim autocmd events.
			window = {
				mappings = {
					["<bs>"] = "navigate_up",
					["."] = "set_root",
					["H"] = "toggle_hidden",
					["/"] = "fuzzy_finder",
					["D"] = "fuzzy_finder_directory",
					["f"] = "filter_on_submit",
					["<c-x>"] = "clear_filter",
					["[g"] = "prev_git_modified",
					["]g"] = "next_git_modified",
				},
			},
		},
		git_status = {
			window = {
				position = "float",
				mappings = {
					["A"] = "git_add_all",
					["gu"] = "git_unstage_file",
					["ga"] = "git_add_file",
					["gr"] = "git_revert_file",
					["gc"] = "git_commit",
					["gp"] = "git_push",
					["gg"] = "git_commit_and_push",
				},
			},
		},
	})
end

function config.fidget()
	require("fidget").setup()
end

function config.notify()
	require("notify").setup({})
end

function config.noice()
	require("noice").setup({
		view = {
			mini = {
				win_options = {
					winblend = 100,
				},
			},
		},
		lsp = {
			-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				-- ["cmp.entry.get_documentation"] = true,
			},
		},
		-- you can enable a preset for easier configuration
		presets = {
			bottom_search = true, -- use a classic bottom cmdline for search
			command_palette = true, -- position the cmdline and popupmenu together
			long_message_to_split = true, -- long messages will be sent to a split
			inc_rename = false, -- enables an input dialog for inc-rename.nvim
			lsp_doc_border = false, -- add a border to hover docs and signature help
		},
	})
end

function config.hydra()
	local Hydra = require("hydra")

	local splits = require("smart-splits")

	local cmd = require("hydra.keymap-util").cmd
	local pcmd = require("hydra.keymap-util").pcmd

	local window_hint = [[
 ^^^^^^^^^^^^     Move      ^^    Size   ^^   ^^     Split
 ^^^^^^^^^^^^-------------  ^^-----------^^   ^^---------------
 ^ ^ _k_ ^ ^  ^ ^ _K_ ^ ^   ^   _<C-k>_   ^   _s_: horizontally 
 _h_ ^ ^ _l_  _H_ ^ ^ _L_   _<C-h>_ _<C-l>_   _v_: vertically
 ^ ^ _j_ ^ ^  ^ ^ _J_ ^ ^   ^   _<C-j>_   ^   _q_, _c_: close
 focus^^^^^^  window^^^^^^  ^_=_: equalize^   _z_: maximize
 ^ ^ ^ ^ ^ ^  ^ ^ ^ ^ ^ ^   ^^ ^          ^   _o_: remain only
]]

	Hydra({
		name = "Windows",
		hint = window_hint,
		config = {
			invoke_on_body = true,
			hint = {
				border = "rounded",
				offset = -1,
			},
		},
		mode = "n",
		body = "<Space>w",
		heads = {
			{ "h", "<C-w>h" },
			{ "j", "<C-w>j" },
			{ "k", pcmd("wincmd k", "E11", "close") },
			{ "l", "<C-w>l" },

			{ "H", cmd("WinShift left") },
			{ "J", cmd("WinShift down") },
			{ "K", cmd("WinShift up") },
			{ "L", cmd("WinShift right") },

			{
				"<C-h>",
				function()
					splits.resize_left(2)
				end,
			},
			{
				"<C-j>",
				function()
					splits.resize_down(2)
				end,
			},
			{
				"<C-k>",
				function()
					splits.resize_up(2)
				end,
			},
			{
				"<C-l>",
				function()
					splits.resize_right(2)
				end,
			},
			{ "=", "<C-w>=", { desc = "equalize" } },

			{ "s", pcmd("split", "E36") },
			{ "<C-s>", pcmd("split", "E36"), { desc = false } },
			{ "v", pcmd("vsplit", "E36") },
			{ "<C-v>", pcmd("vsplit", "E36"), { desc = false } },

			{ "w", "<C-w>w", { exit = true, desc = false } },
			{ "<C-w>", "<C-w>w", { exit = true, desc = false } },

			{ "z", cmd("WindowsMaximaze"), { exit = true, desc = "maximize" } },
			{ "<C-z>", cmd("WindowsMaximaze"), { exit = true, desc = false } },

			{ "o", "<C-w>o", { exit = true, desc = "remain only" } },
			{ "<C-o>", "<C-w>o", { exit = true, desc = false } },

			{ "c", pcmd("close", "E444") },
			{ "q", pcmd("close", "E444"), { desc = "close window" } },
			{ "<C-c>", pcmd("close", "E444"), { desc = false } },
			{ "<C-q>", pcmd("close", "E444"), { desc = false } },

			{ "<Esc>", nil, { exit = true, desc = false } },
		},
	})

	local hint_opts = {
		position = "bottom",
		-- border = border,
		type = "window",
	}

	local ok_git, gitsigns = pcall(require, "gitsigns")
	if ok_git then
		local hint = [[
 _J_: next hunk   _s_: stage hunk        _d_: show deleted   _b_: blame line
 _K_: prev hunk   _u_: undo stage hunk   _p_: preview hunk   _B_: blame show full 
 _R_: reset hunk  _S_: stage buffer      ^ ^                 _/_: show base file
 ^ ^              _h_: file history      _v_: diff view                       ^ ^
 ^
 ^ ^                            _q_: exit
]]

		Hydra({
			name = "Git Mode",
			hint = hint,
			config = {
				color = "pink",
				invoke_on_body = true,
				hint = hint_opts,
				on_enter = function()
					gitsigns.toggle_linehl(true)
					gitsigns.toggle_deleted(true)
				end,
				on_exit = function()
					gitsigns.toggle_linehl(false)
					gitsigns.toggle_deleted(false)
				end,
			},
			mode = { "n", "x" },
			body = "<Space>vc",
			heads = {
				{
					"J",
					function()
						if vim.wo.diff then
							return "]c"
						end
						vim.schedule(function()
							gitsigns.next_hunk()
						end)
						return "<Ignore>"
					end,
					{ expr = true },
				},
				{
					"K",
					function()
						if vim.wo.diff then
							return "[c"
						end
						vim.schedule(function()
							gitsigns.prev_hunk()
						end)
						return "<Ignore>"
					end,
					{ expr = true },
				},
				{ "s", ":Gitsigns stage_hunk<CR>", { silent = true } },
				{ "u", gitsigns.undo_stage_hunk },
				{ "S", gitsigns.stage_buffer },
				{ "R", gitsigns.reset_hunk },
				{ "p", gitsigns.preview_hunk },
				{ "h", ":DiffviewFileHistory %<CR>", { exit = true } },
				{ "v", ":DiffviewOpen<CR>", { exit = true } },
				{ "d", gitsigns.toggle_deleted, { nowait = true } },
				{ "b", gitsigns.blame_line },
				{
					"B",
					function()
						gitsigns.blame_line({ full = true })
					end,
				},
				{ "/", gitsigns.show, { exit = true } }, -- show the base of the file
				{ "q", nil, { exit = true, nowait = true } },
			},
		})
	end

	local function run(method, args)
		return function()
			local dap = require("dap")
			if dap[method] then
				dap[method](args)
			end
		end
	end

	local dap_hint = [[
                  DAP
  _<CR>_: Dap UI
  _i_: step in
  _n_: step over
  _o_: step out
  _c_: continue
  _b_: toggle breakpoint
  _x_: close
  _K_: hover
^
  _q_: Exit
  ]]

	Hydra({
		name = "DAP",
		hint = dap_hint,
		mode = { "n", "x" },
		body = "<Space>d",
		config = {
			color = "pink",
			invoke_on_body = true,
		},
		heads = {
			{ "<CR>", "<CMD>lua require('dapui').toggle()<CR>", { exit = true, nowait = true } },
			{ "n", run("step_over"), { silent = true } },
			{ "o", run("step_out"), { silent = true } },
			{ "x", "<CMD>lua require('dap').close()<CR>" },
			{ "b", run("toggle_breakpoint"), { silent = true } },
			{ "c", "<CMD>lua require('dap').continue()<CR>" },
			{ "i", run("step_into"), { silent = true } },
			{ "K", "<CMD>lua require('dap.ui.widgets').hover()<CR>", { exit = true, nowait = true } },
			{ "q", "", { exit = true, nowait = true } },
		},
	})
end

function config.onedark_pro()
	require("onedarkpro").setup({
		dark_theme = "onedark", -- The default dark theme
		styles = {
			comments = "italic",
			conditionals = "italic",
			keywords = "italic",
			virtual_text = "italic",
		},
		options = {
			transparency = true,
			bold = true, -- Use bold styles?
			italic = true, -- Use italic styles?
			underline = true, -- Use underline styles?
			undercurl = true, -- Use undercurl styles?

			cursorline = true, -- Use cursorline highlighting?
			terminal_colors = false, -- Use the theme's colors for Neovim's :terminal?
			window_unfocused_color = true, -- When the window is out of focus, change the normal background?
		},
		-- highlights = {
		--   -- Neotree
		--   NeoTreeRootName = { fg = "${red}", style = "bold" },
		--   NeoTreeFileNameOpened = { fg = "${purple}", style = "italic" },
		--   -- Telescope
		--   TelescopeBorder = {
		--     fg = "${telescope_results}",
		--     bg = "${telescope_results}",
		--   },
		--   TelescopePromptBorder = {
		--     fg = "${telescope_prompt}",
		--     bg = "${telescope_prompt}",
		--   },
		--   TelescopePromptCounter = { fg = "${fg}" },
		--   TelescopePromptNormal = { fg = "${fg}", bg = "${telescope_prompt}" },
		--   TelescopePromptPrefix = {
		--     fg = "${purple}",
		--     bg = "${telescope_prompt}",
		--   },
		--   TelescopePromptTitle = {
		--     fg = "${telescope_prompt}",
		--     bg = "${purple}",
		--   },
		--
		--   TelescopePreviewTitle = {
		--     fg = "${telescope_results}",
		--     bg = "${green}",
		--   },
		--   TelescopeResultsTitle = {
		--     fg = "${telescope_results}",
		--     bg = "${telescope_results}",
		--   },
		--
		--   TelescopeMatching = { fg = "${blue}" },
		--   TelescopeNormal = { bg = "${telescope_results}" },
		--   TelescopeSelection = { bg = "${telescope_prompt}" },
		-- },
	})
end

function config.nightfox()
	require("nightfox").setup({
		options = {
			transparent = true,
			styles = {
				comments = "italic",
				keywords = "bold",
				types = "italic,bold",
			},
		},
	})
end

function config.material()
	require("material").setup({

		contrast = {
			terminal = false, -- Enable contrast for the built-in terminal
			sidebars = false, -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
			floating_windows = false, -- Enable contrast for floating windows
			cursor_line = false, -- Enable darker background for the cursor line
			non_current_windows = false, -- Enable darker background for non-current windows
			filetypes = {}, -- Specify which filetypes get the contrasted (darker) background
		},

		styles = { -- Give comments style such as bold, italic, underline etc.
			comments = { --[[ italic = true ]]
			},
			strings = { --[[ bold = true ]]
			},
			keywords = { --[[ underline = true ]]
			},
			functions = { --[[ bold = true, undercurl = true ]]
			},
			variables = {},
			operators = {},
			types = {},
		},

		plugins = { -- Uncomment the plugins that you use to highlight them
			-- Available plugins:
			-- "dap",
			-- "dashboard",
			-- "gitsigns",
			-- "hop",
			-- "indent-blankline",
			-- "lspsaga",
			-- "mini",
			-- "neogit",
			-- "nvim-cmp",
			-- "nvim-navic",
			-- "nvim-tree",
			-- "nvim-web-devicons",
			-- "sneak",
			-- "telescope",
			-- "trouble",
			-- "which-key",
		},

		disable = {
			colored_cursor = false, -- Disable the colored cursor
			borders = false, -- Disable borders between verticaly split windows
			background = false, -- Prevent the theme from setting the background (NeoVim then uses your terminal background)
			term_colors = false, -- Prevent the theme from setting terminal colors
			eob_lines = false, -- Hide the end-of-buffer lines
		},

		high_visibility = {
			lighter = false, -- Enable higher contrast text for lighter style
			darker = false, -- Enable higher contrast text for darker style
		},

		lualine_style = "default", -- Lualine style ( can be 'stealth' or 'default' )

		async_loading = true, -- Load parts of the theme asyncronously for faster startup (turned on by default)

		custom_colors = nil, -- If you want to everride the default colors, set this to a function

		custom_highlights = {}, -- Overwrite highlights with your own
	})
end

function config.ccc()
	local ccc = require("ccc")
	local mapping = ccc.mapping
	ccc.setup({ mappings = mapping })
end

function config.zen()
	require("true-zen").setup({
		modes = { -- configurations per mode
			ataraxis = {
				shade = "dark", -- if `dark` then dim the padding windows, otherwise if it's `light` it'll brighten said windows
				backdrop = 0, -- percentage by which padding windows should be dimmed/brightened. Must be a number between 0 and 1. Set to 0 to keep the same background color
				minimum_writing_area = { -- minimum size of main window
					width = 70,
					height = 44,
				},
				quit_untoggles = true, -- type :q or :qa to quit Ataraxis mode
				padding = { -- padding windows
					left = 52,
					right = 52,
					top = 0,
					bottom = 0,
				},
				callbacks = { -- run functions when opening/closing Ataraxis mode
					open_pre = nil,
					open_pos = nil,
					close_pre = nil,
					close_pos = nil,
				},
			},
			minimalist = {
				ignored_buf_types = { "nofile" }, -- save current options from any window except ones displaying these kinds of buffers
				options = { -- options to be disabled when entering Minimalist mode
					number = false,
					relativenumber = false,
					showtabline = 0,
					signcolumn = "no",
					statusline = "",
					cmdheight = 1,
					laststatus = 0,
					showcmd = false,
					showmode = false,
					ruler = false,
					numberwidth = 1,
				},
				callbacks = { -- run functions when opening/closing Minimalist mode
					open_pre = nil,
					open_pos = nil,
					close_pre = nil,
					close_pos = nil,
				},
			},
			narrow = {
				--- change the style of the fold lines. Set it to:
				--- `informative`: to get nice pre-baked folds
				--- `invisible`: hide them
				--- function() end: pass a custom func with your fold lines. See :h foldtext
				folds_style = "informative",
				run_ataraxis = true, -- display narrowed text in a Ataraxis session
				callbacks = { -- run functions when opening/closing Narrow mode
					open_pre = nil,
					open_pos = nil,
					close_pre = nil,
					close_pos = nil,
				},
			},
			focus = {
				callbacks = { -- run functions when opening/closing Focus mode
					open_pre = nil,
					open_pos = nil,
					close_pre = nil,
					close_pos = nil,
				},
			},
		},
		integrations = {
			tmux = false, -- hide tmux status bar in (minimalist, ataraxis)
			kitty = { -- increment font size in Kitty. Note: you must set `allow_remote_control socket-only` and `listen_on unix:/tmp/kitty` in your personal config (ataraxis)
				enabled = true,
				font = "+3",
			},
			twilight = false, -- enable twilight (ataraxis)
			lualine = false, -- hide nvim-lualine (ataraxis)
		},
	})
end

function config.aerial()
	require("aerial").setup()
end

function config.colorizer()
	require("colorizer").setup()
end

function config.penumbra()
	require("penumbra").setup({
		italic_comment = true, -- default: false
		transparent = true, -- default: false
		light = false, -- default: false
		contrast = "plus", --nil | 'plus' | 'plusplus' -- default: nil
		-- customize colors
		-- colors = {
		--   sun_p = '#FFFDFB',
		--   sun = '#FFF7ED',
		--   sun_m = '#F2E6D4',
		--   sky_p = '#BEBEBE',
		--   sky = '#8F8F8F',
		--   sky_m = '#636363',
		--   shade_p = '#3E4044',
		--   shade = '#303338',
		--   shade_m = '#24272B',
		--
		--   red = '#CA736C',
		--   orange = '#BA823A',
		--   yellow = '#8D9741',
		--   green = '#47A477',
		--   cyan = '#00A2AF',
		--   blue = '#5794D0',
		--   purple = '#9481CC',
		--   magenta = '#BC73A4',
		-- },
		overrides = {
			-- example:
			-- NonText = { fg = '#00A2AF' }
			GitSignsCurrentLineBlame = { fg = "#A49AC1" },
		},
	})
end

function config.winshift()
	-- Lua
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
		keymaps = {
			disable_defaults = false, -- Disable the default keymaps
			win_move_mode = {
				["h"] = "left",
				["j"] = "down",
				["k"] = "up",
				["l"] = "right",
				["H"] = "far_left",
				["J"] = "far_down",
				["K"] = "far_up",
				["L"] = "far_right",
				["<left>"] = "left",
				["<down>"] = "down",
				["<up>"] = "up",
				["<right>"] = "right",
				["<S-left>"] = "far_left",
				["<S-down>"] = "far_down",
				["<S-up>"] = "far_up",
				["<S-right>"] = "far_right",
			},
		},
		---A function that should prompt the user to select a window.
		---
		---The window picker is used to select a window while swapping windows with
		---`:WinShift swap`.
		---@return integer? winid # Either the selected window ID, or `nil` to
		---   indicate that the user cancelled / gave an invalid selection.
		window_picker = function()
			return require("winshift.lib").pick_window({
				-- A string of chars used as identifiers by the window picker.
				picker_chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
				filter_rules = {
					-- This table allows you to indicate to the window picker that a window
					-- should be ignored if its buffer matches any of the following criteria.
					cur_win = true, -- Filter out the current window
					floats = true, -- Filter out floating windows
					filetype = {}, -- List of ignored file types
					buftype = {}, -- List of ignored buftypes
					bufname = {}, -- List of vim regex patterns matching ignored buffer names
				},
				---A function used to filter the list of selectable windows.
				---@param winids integer[] # The list of selectable window IDs.
				---@return integer[] filtered # The filtered list of window IDs.
				filter_func = nil,
			})
		end,
	})
end

function config.smart_splits()
	require("smart-splits").setup({
		-- Ignored filetypes (only while resizing)
		ignored_filetypes = {
			"nofile",
			"quickfix",
			"prompt",
		},
		-- Ignored buffer types (only while resizing)
		ignored_buftypes = { "NvimTree" },
		-- the default number of lines/columns to resize by at a time
		default_amount = 3,
		-- when moving cursor between splits left or right,
		-- place the cursor on the same row of the *screen*
		-- regardless of line numbers. False by default.
		-- Can be overridden via function parameter, see Usage.
		move_cursor_same_row = false,
		-- resize mode options
		resize_mode = {
			-- key to exit persistent resize mode
			quit_key = "<ESC>",
			-- keys to use for moving in resize mode
			-- in order of left, down, up' right
			resize_keys = { "h", "j", "k", "l" },
			-- set to true to silence the notifications
			-- when entering/exiting persistent resize mode
			silent = false,
			-- must be functions, they will be executed when
			-- entering or exiting the resize mode
			hooks = {
				on_enter = nil,
				on_leave = nil,
			},
		},
		-- ignore these autocmd events (via :h eventignore) while processing
		-- smart-splits.nvim computations, which involve visiting different
		-- buffers and windows. These events will be ignored during processing,
		-- and un-ignored on completed. This only applies to resize events,
		-- not cursor movement events.
		ignored_events = {
			"BufEnter",
			"WinEnter",
		},
		-- enable or disable the tmux integration
		tmux_integration = true,
	})
end

function config.windows()
	require("windows").setup()
end

return config
