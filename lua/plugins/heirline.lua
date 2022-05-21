-- M.separators = {--{{{
--   vertical_bar       = '┃',
--   vertical_bar_thin  = '│',
--   left               = '',
--   right              = '',
--   block              = '█',
--   left_filled        = '',
--   right_filled       = '',
--   slant_left         = '',
--   slant_left_thin    = '',
--   slant_right        = '',
--   slant_right_thin   = '',
--   slant_left_2       = '',
--   slant_left_2_thin  = '',
--   slant_right_2      = '',
--   slant_right_2_thin = '',
--   left_rounded       = '',
--   left_rounded_thin  = '',
--   right_rounded      = '',
--   right_rounded_thin = '',
--   circle             = '●',
--   github_icon        = " ﯙ ",
--   folder_icon        = " ",
-- }

local utils = require("heirline.utils")
local colors = {
	red = utils.get_highlight("DiagnosticError").fg,
	dev_icon_tex = utils.get_highlight("DevIconTex").fg,
	pastel_green = utils.get_highlight("DevIconStyl").bg,
	blue = utils.get_highlight("Function").fg,
	gray = utils.get_highlight("NonText").fg,
	special_fg = utils.get_highlight("Special").fg,
	special_bg = utils.get_highlight("Special").bg,
	orange = utils.get_highlight("DiagnosticWarn").fg,
	purple = utils.get_highlight("Statement").fg,
	cyan = utils.get_highlight("Special").fg,
	wild_fg = utils.get_highlight("WildMenu").fg,
	wild_bg = utils.get_highlight("WildMenu").bg,
	diag = {
		warn = utils.get_highlight("DiagnosticWarn").fg,
		error = utils.get_highlight("DiagnosticError").fg,
		hint = utils.get_highlight("DiagnosticHint").fg,
		info = utils.get_highlight("DiagnosticInfo").fg,
	},
}

local themer = require("themer.modules.core.api").get_cp("doom_one")

local conditions = require("heirline.conditions")
local align = { provider = "%=", hl = { fg = themer.accent } }




local use_dev_icons = false

local file_icons = {
	typescript = " ",
	tex = "ﭨ ",
	ts = " ",
	python = " ",
	py = " ",
	java = " ",
	html = " ",
	css = " ",
	scss = " ",
	javascript = " ",
	js = " ",
	javascriptreact = " ",
	markdown = " ",
	md = " ",
	sh = " ",
	zsh = " ",
	vim = " ",
	rust = " ",
	rs = " ",
	cpp = " ",
	c = " ",
	go = " ",
	lua = " ",
	conf = " ",
	haskel = " ",
	hs = " ",
	ruby = " ",
	norg = " ",
	txt = " ",
}

local mode_colors = {
	n = vim.g.terminal_color_1,
	i = vim.g.terminal_color_2,
	v = vim.g.terminal_color_5,
	V = vim.g.terminal_color_5,
	["^V"] = colors.blue,
	c = colors.blue,
	s = vim.g.terminal_color_3,
	S = vim.g.terminal_color_3,
	["^S"] = colors.yellow,
	R = colors.purple,
	r = vim.g.terminal_color_4,
	["!"] = vim.g.terminal_color_1,
	t = vim.g.terminal_color_1,
}

----------------------------------------------------------------------------------------
--------------------------------------------
--
--      FILE PATH AND WORKDIR
--
--------------------------------------------
----------------------------------------------------------------------------------------

local FileIconSurroundF = {
	{
		provider = function()
			return ""
		end,
		hl = function(_)
			return { fg = colors.blue, bg = "none" }
		end,
		condition = function()
			return vim.tbl_contains(vim.tbl_keys(file_icons), vim.bo.ft)
		end,
	},
}

local FileIconSurroundB = {
	{
		provider = function()
			return " "
		end,
		hl = function(_)
			return { bg = themer.syntax.conditional, fg = themer.search_result.bg }
		end,
		condition = function()
			return vim.tbl_contains(vim.tbl_keys(file_icons), vim.bo.ft)
		end,
	},
}

local FileIcon = {
	init = function(self)
		self.mode = vim.fn.mode(1)
		local filename = self.filename
		local extension = vim.fn.fnamemodify(filename, ":e")
		if use_dev_icons then
			self.icon, self.icon_color = require("nvim-web-devicons").get_icon_color(
				filename,
				extension,
				{ default = true }
			)
		else
			self.icon = file_icons[extension] or ""
		end
	end,
	provider = function(self)
		return self.icon and (" " .. self.icon)
	end,
	hl = function(self)
		if use_dev_icons then
			return { fg = self.icon_color }
		else
			return { fg = themer.bg.selected, bg = themer.search_result.bg }
		end
	end,
	condition = function()
		return vim.tbl_contains(vim.tbl_keys(file_icons), vim.bo.ft)
	end,
}

local FileNameBlock = {
	init = function(self)
		self.filename = vim.api.nvim_buf_get_name(0)
		self.mode = vim.fn.mode(1)
	end,
}

local FileName = {
	provider = function(self)
		local filename = vim.fn.pathshorten(vim.fn.fnamemodify(self.filename, ":."))
		if filename == "" then
			return ""
		end
		return filename .. " "
	end,
	hl = function()
		return { fg = themer.bg.selected, bg = themer.syntax.conditional }
	end,
}

local FileFlags = {
	{
		provider = function()
			if vim.bo.modified then
				return " "
			end
		end,
		hl = function()
			return { fg = themer.bg.selected }
		end,
	},
	{
		provider = function()
			if not vim.bo.modifiable or vim.bo.readonly then
				return ""
			end
		end,
		hl = function(self)
			local mode = self.mode:sub(1, 1)
			return { fg = mode_colors[mode] or colors.blue }
		end,
	},
}

local FileNameSurround = {
	{
		provider = function()
			return ""
		end,
		hl = function(_)
			return { fg = colors.blue, bg = colors.blue }
		end,
		condition = function()
			return not vim.tbl_contains(vim.tbl_keys(file_icons), vim.bo.ft)
		end,
	},
}

FileNameBlock = utils.insert(
	FileNameBlock,
	FileIconSurroundF,
	FileIcon,
	FileIconSurroundB,
	FileNameSurround,
	FileName,
	unpack(FileFlags),
	{
		provider = "%<",
	}
)
FileNameBlock = utils.surround({ "", "" }, themer.syntax.conditional, FileNameBlock)

FileNameBlock[1]["condition"] = function()
	return not conditions.buffer_matches({
		filetype = { "dashboard" },
	})
end
FileNameBlock[2]["condition"] = function()
	return not conditions.buffer_matches({
		filetype = { "dashboard" },
	})
end
FileNameBlock[3]["condition"] = function()
	return not conditions.buffer_matches({
		filetype = { "dashboard" },
	})
end

local WorkDirIcon = {
	{
		provider = function()
			return "  "
		end,
		hl = function(_)
			return { fg = themer.bg.selected, bg = colors.dev_icon_tex }
		end,
	},
	{
		provider = function()
			return ""
		end,
		hl = { fg = colors.dev_icon_tex, bg = themer.syntax.string },
	},
	{
		provider = function()
			local cwd = vim.fn.getcwd(0)
			cwd = vim.fn.fnamemodify(cwd, ":~")
			cwd = vim.fn.pathshorten(cwd)
			local trail = cwd:sub(-1) == "/" and "" or "/"
			return " " .. cwd .. trail
		end,
		hl = { bg = themer.syntax.string, fg = themer.bg.selected },
	},
	{
    -- right margin of cwd path
		provider = function()
			return ""
		end,
		hl = function(self)
			if
				conditions.buffer_matches({
					filetype = { "startup", "Telescope", "NvimTree", "toggleterm" },
				})
			then
				return { fg = colors.blue, bg = colors.vibrant_green }
			else
				return {fg = themer.search_result.bg, bg = themer.syntax.string,  }
			end
		end,
	},
	{
		FileNameBlock,
	},
}

----------------------------------------------------------------------------------------
--------------------------------------------
--
--      GPS INDICATOR
--
--------------------------------------------
----------------------------------------------------------------------------------------

local gps_lsp = {
	condition = require("nvim-gps").is_available,
	-- left enclosing
	{
		provider = function()
			if #require("nvim-gps").get_data() > 0 then
				return "  "
			else
				return ""
			end
		end,
		hl = { fg = themer.syntax.string },
	},
	-- actual content
	{
		provider = require("nvim-gps").get_location,
		hl = function()
			return { fg = themer.syntax.string}
		end,
	},
	-- right enclosing
	{
		provider = function()
			if #require("nvim-gps").get_data() > 0 then
				return " "
			else
				return ""
			end
		end,
		hl = { fg = themer.syntax.string },
	},
}

----------------------------------------------------------------------------------------
--------------------------------------------
--
--      DIAGNOSTICS
--
--------------------------------------------
----------------------------------------------------------------------------------------

local diagnostics = {

	condition = conditions.has_diagnostics,

	static = {
		error_icon = " ",
		warn_icon = " ",
		info_icon = " ",
		hint_icon = " ",
	},

	init = function(self)
		self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
		self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
		self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
		self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
	end,

	{
		provider = function(self)
			return self.errors > 0 and (self.error_icon .. self.errors .. " ")
		end,
		hl = { fg = themer.diagnostic.error },
	},
	{
		provider = function(self)
			return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ")
		end,
		hl = { fg = themer.diagnostic.warn },
	},
	{
		provider = function(self)
			return self.info > 0 and (self.info_icon .. self.info .. " ")
		end,
		hl = { fg = themer.diagnostic.info },
	},
	{
		provider = function(self)
			return self.hints > 0 and (self.hint_icon .. self.hints)
		end,
		hl = { fg = themer.diagnostic.hint },
	},
}

----------------------------------------------------------------------------------------
--------------------------------------------
--
--      GIT
--
--------------------------------------------
----------------------------------------------------------------------------------------

local git = {
	condition = conditions.is_git_repo,

	init = function(self)
		self.status_dict = vim.b.gitsigns_status_dict
		self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
	end,

	hl = { fg = themer.orange },

	{
		provider = function(self)
			return "ﯙ  " .. self.status_dict.head .. " "
		end,
	},
	{
		provider = function(self)
			local count = self.status_dict.added or 0
			return count > 0 and ("  " .. count)
		end,
		hl = { fg = themer.diff.add},
	},
	{
		provider = function(self)
			local count = self.status_dict.removed or 0
			return count > 0 and ("  " .. count)
		end,
		hl = { fg = themer.diff.remove },
	},
	{
		provider = function(self)
			local count = self.status_dict.changed or 0
			return count > 0 and ("  " .. count)
		end,
		hl = { fg = themer.diff.change },
	},
}


----------------------------------------------------------------------------------------
--------------------------------------------
--
--      LSP ACTIVE INDICATOR
--
--------------------------------------------
----------------------------------------------------------------------------------------

local LSPActive = {
	condition = conditions.lsp_attached,
	{ provider = "  ", hl = { fg = themer.accent, bold = true } },
	
}

----------------------------------------------------------------------------------------
--------------------------------------------
--
--      MODE INDICATOR
--
--------------------------------------------
----------------------------------------------------------------------------------------

local mode_icon = {
	{
		init = function(self)
			self.mode = vim.fn.mode(1)
		end,
		hl = function(self)
			local mode = self.mode:sub(1, 1)
			return { fg = mode_colors[mode] or colors.blue }
		end,
	},
	{
		init = function(self)
			self.mode = vim.fn.mode(1)
		end,

		static = {
			mode_icons = {
				["n"] = "  ",
				["i"] = "  ",
				["s"] = "  ",
				["S"] = "  ",
				[""] = "  ",

				["v"] = "  ",
				["V"] = "  ",
				[""] = "  ",
				["r"] = " ﯒ ",
				["r?"] = "  ",
				["c"] = "  ",
				["t"] = "  ",
				["!"] = "  ",
				["R"] = "  ",
			},
			mode_names = {
				n = "N",
				no = "N?",
				nov = "N?",
				noV = "N?",
				["no"] = "N?",
				niI = "Ni",
				niR = "Nr",
				niV = "Nv",
				nt = "Nt",
				v = "V",
				vs = "Vs",
				V = "V_",
				Vs = "Vs",
				[""] = "",
				["s"] = "",
				s = "S",
				S = "S_",
				[""] = "",
				i = "I",
				ic = "Ic",
				ix = "Ix",
				R = "R",
				Rc = "Rc",
				Rx = "Rx",
				Rv = "Rv",
				Rvc = "Rv",
				Rvx = "Rv",
				c = "C",
				cv = "Ex",
				r = "...",
				rm = "M",
				["r?"] = "?",
				["!"] = "!",
				t = "T",
			},
		},
		hl = function(self)
			local mode = self.mode:sub(1, 1)
			return {
				-- bg = mode_colors[mode] or colors.blue,
				fg = themer.accent,
				bold = true,
			}
		end,
		provider = function(self)
			return "%2(" .. self.mode_icons[self.mode:sub(1, 1)] .. "%)" .. " "
		end,
	},
	{
		init = function(self)
			self.mode = vim.fn.mode(1)
		end,
		provider = function()
			return ""
		end,
		hl = function(self)
			local mode = self.mode:sub(1, 1)
			return { fg = mode_colors[mode] or colors.blue }
		end,
	},
}

----------------------------------------------------------------------------------------
--------------------------------------------
--
--      FINALIZE STATUSLINE
--
--------------------------------------------
----------------------------------------------------------------------------------------

local default_statusline = {
	condition = conditions.is_active,
	utils.make_flexible_component(5, WorkDirIcon),
	align,
	utils.make_flexible_component(3, gps_lsp, { provider = "" }),
	align,
	diagnostics,
	align,
	git,
	align,
	LSPActive,
	mode_icon,
}

require("heirline").setup(default_statusline)
