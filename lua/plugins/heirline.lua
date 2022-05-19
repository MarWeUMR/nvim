local conditions = require("heirline.conditions")
local utilities = require("heirline.utils")
local utils = require("heirline.utils")
local align = { provider = "%=" }
local space = { provider = " " }
local colors = require("colors").get()

local use_dev_icons = false

local function word_counter()
	local wc = vim.api.nvim_eval("wordcount()")
	if wc["visual_words"] then
		return wc["visual_words"]
	else
		return wc["words"]
	end
end

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

local FileNameBlock = {
	init = function(self)
		self.filename = vim.api.nvim_buf_get_name(0)
		self.mode = vim.fn.mode(1)
	end,
}

local HelpFileName = {
	condition = function()
		return vim.bo.filetype == "help"
	end,
	provider = function()
		local filename = vim.api.nvim_buf_get_name(0)
		return vim.fn.fnamemodify(filename, ":t")
	end,
	hl = { fg = colors.dark_blue },
}

local FileType = {
	provider = function()
		return string.upper(vim.bo.filetype)
	end,
	hl = { fg = utils.get_highlight("Type").fg, italic = true },
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
			return { fg = colors.black, bg = colors.dark_blue }
		end
	end,
	condition = function()
		return vim.tbl_contains(vim.tbl_keys(file_icons), vim.bo.ft)
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
		return { fg = colors.black }
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
			return { fg = colors.black }
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

local FileIconSurroundF = {
	{
		provider = function()
			return ""
		end,
		hl = function(_)
			return { fg = colors.dark_blue, bg = "none" }
		end,
		condition = function()
			return vim.tbl_contains(vim.tbl_keys(file_icons), vim.bo.ft)
		end,
	},
}
local FileIconSurroundB = {
	{
		provider = function()
			return " "
		end,
		hl = function(_)
			return { bg = colors.blue, fg = colors.dark_blue }
		end,
		condition = function()
			return vim.tbl_contains(vim.tbl_keys(file_icons), vim.bo.ft)
		end,
	},
}
local FileNameSurround = {
	{
		provider = function()
			return ""
		end,
		hl = function(_)
			return { fg = colors.blue, bg = "none" }
		end,
		condition = function()
			return not vim.tbl_contains(vim.tbl_keys(file_icons), vim.bo.ft)
		end,
	},
}

RoundFileNameBlock = utils.insert(
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
RoundFileNameBlock = utilities.surround({ "", "" }, colors.blue, RoundFileNameBlock)

RoundFileNameBlock[1]["condition"] = function()
	return not conditions.buffer_matches({
		filetype = { "dashboard" },
	})
end
RoundFileNameBlock[2]["condition"] = function()
	return not conditions.buffer_matches({
		filetype = { "dashboard" },
	})
end
RoundFileNameBlock[3]["condition"] = function()
	return not conditions.buffer_matches({
		filetype = { "dashboard" },
	})
end

local git = {
	condition = conditions.is_git_repo,

	init = function(self)
		self.status_dict = vim.b.gitsigns_status_dict
		self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
	end,

	hl = { fg = colors.orange },

	{
		provider = function(self)
			return " " .. self.status_dict.head .. " "
		end,
	},
	{
		provider = function(self)
			local count = self.status_dict.added or 0
			return count > 0 and ("  " .. count)
		end,
		hl = { fg = colors.green },
	},
	{
		provider = function(self)
			local count = self.status_dict.removed or 0
			return count > 0 and ("  " .. count)
		end,
		hl = { fg = colors.red },
	},
	{
		provider = function(self)
			local count = self.status_dict.changed or 0
			return count > 0 and ("  " .. count)
		end,
		hl = { fg = colors.orange },
	},
}

local RoundWorkDir = {
	{
		provider = function()
			return "  "
		end,
		hl = function(_)
			return { fg = colors.black, bg = colors.dark_green }
		end,
	},
	{
		provider = function()
			return ""
		end,
		hl = { fg = colors.dark_green, bg = colors.vibrant_green },
	},
	{
		provider = function()
			local cwd = vim.fn.getcwd(0)
			cwd = vim.fn.fnamemodify(cwd, ":~")
			cwd = vim.fn.pathshorten(cwd)
			local trail = cwd:sub(-1) == "/" and "" or "/"
			return " " .. cwd .. trail
		end,
		hl = { bg = colors.vibrant_green, fg = colors.black },
	},
}

local round_mode_icon = {
	{
		init = function(self)
			self.mode = vim.fn.mode(1)
		end,
		provider = function()
			return ""
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
				bg = mode_colors[mode] or colors.blue,
				fg = colors.black,
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
			return ""
		end,
		hl = function(self)
			local mode = self.mode:sub(1, 1)
			return { fg = mode_colors[mode] or colors.blue }
		end,
	},
}

local function progress_bar()
	local sbar = { "▁", "▂", "▃", "▄", "▅", "▆", "▇" }
	local curr_line = vim.api.nvim_win_get_cursor(0)[1]
	local lines = vim.api.nvim_buf_line_count(0)
	local i = math.floor(curr_line / lines * (#sbar - 1)) + 1
	return sbar[i]
end

local round_progress = {
	{
		provider = function()
			return ""
		end,
		hl = function(_)
			return { fg = colors.dark_purple, bg = "none" }
		end,
	},
	{
		provider = function()
			return "%3(%P%)"
		end,
		hl = { bg = colors.dark_purple, fg = colors.black },
	},
	{
		provider = function()
			return ""
		end,
		hl = function(_)
			return { fg = colors.dark_purple, bg = colors.purple }
		end,
	},
	{
		provider = function()
			-- return "%3(%P%) " .. progress_bar() .. " "
			return " " .. progress_bar() .. " "
		end,
		hl = function()
			return { bg = colors.purple, fg = colors.black }
		end,
	},
	{
		provider = function()
			return ""
		end,
		hl = function(_)
			return { fg = colors.purple, bg = "none" }
		end,
	},
}

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
		hl = { fg = utils.get_highlight("DiagnosticError").fg },
	},
	{
		provider = function(self)
			return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ")
		end,
		hl = { fg = utils.get_highlight("DiagnosticWarn").fg },
	},
	{
		provider = function(self)
			return self.info > 0 and (self.info_icon .. self.info .. " ")
		end,
		hl = { fg = utils.get_highlight("DiagnosticInfo").fg },
	},
	{
		provider = function(self)
			return self.hints > 0 and (self.hint_icon .. self.hints)
		end,
		hl = { fg = utils.get_highlight("DiagnosticHint").fg },
	},
}

local lsp_progress = {
	condition = function()
		if #vim.lsp.get_active_clients() == 0 then
			return false
		end
		return true
	end,
	hl = { fg = colors.blue },
	provider = function()
		local messages = vim.lsp.util.get_progress_messages()
		if #messages == 0 then
			return ""
		end
		local status = {}
		for _, msg in pairs(messages) do
			table.insert(status, msg.percentage or 0)
		end
		local spinners = {
			"⠋",
			"⠙",
			"⠹",
			"⠸",
			"⠼",
			"⠴",
			"⠦",
			"⠧",
			"⠇",
			"⠏",
		}
		local ms = vim.loop.hrtime() / 1000000
		local frame = math.floor(ms / 120) % #spinners
		return spinners[frame + 1] .. " " .. table.concat(status, " | ")
	end,
}

local coords = {
	{
		provider = function()
			return ""
		end,
		hl = { fg = colors.orange },
	},
	{
		provider = function()
			return "  "
		end,
		hl = { fg = colors.black, bg = colors.orange },
	},
	{
		provider = function()
			return ""
		end,
		hl = { fg = colors.orange, bg = colors.yellow },
	},
	{
		provider = function()
			return "%4(%l%):%2c"
		end,
		hl = function()
			return { fg = colors.black, bg = colors.yellow }
		end,
	},
	{
		provider = function()
			return ""
		end,
		hl = { fg = colors.yellow },
	},
}
local word_count = {
	{
		init = function(self)
			self.mode = vim.fn.mode(1)
		end,
		provider = function()
			return string.rep(" ", 5 - #tostring(word_counter())) .. ""
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
		provider = function()
			return word_counter()
		end,
		hl = function(self)
			local mode = self.mode:sub(1, 1)
			return {
				bg = mode_colors[mode] or colors.blue,
				fg = colors.black,
			}
		end,
		condition = conditions.is_active(),
	},
	{
		init = function(self)
			self.mode = vim.fn.mode(1)
		end,
		provider = function()
			return ""
		end,
		hl = function(self)
			local mode = self.mode:sub(1, 1)
			return { fg = mode_colors[mode] or colors.blue }
		end,
	},
}

RoundWorkDir = utilities.surround({ "", "" }, colors.vibrant_green, RoundWorkDir)

local inactive_statusline = {
	condition = function()
		return not conditions.is_active()
	end,
	RoundWorkDir,
	space,
	RoundFileNameBlock,
	align,
}

local default_statusline = {
	condition = conditions.is_active,
	utils.make_flexible_component(5, RoundWorkDir),
	space,
	RoundFileNameBlock,
	space,
	git,
	-- utils.make_flexible_component(1, option_value),
	space,
	lsp_progress,
	diagnostics,
	space,
	align,
	-- utils.make_flexible_component(2, dyn_help_available),
	-- space,
	utils.make_flexible_component(4, coords),
	space,
	round_mode_icon,
	space,
	round_progress,
	space,
	utils.make_flexible_component(6, word_count),
}

local help_file_line = {
	condition = function()
		return conditions.buffer_matches({
			buftype = { "help", "quickfix" },
		})
	end,
	FileType,
	space,
	align,
	HelpFileName,
	align,
	progress,
}

local startup_nvim_statusline = {
	condition = function()
		return conditions.buffer_matches({
			filetype = { "startup", "TelescopePrompt" },
		})
	end,
	align,
	provider = "",
	align,
}

local round_statuslines = {
	init = utils.pick_child_on_condition,

	startup_nvim_statusline,
	help_file_line,
	inactive_statusline,
	default_statusline,
}

require("heirline").setup(round_statuslines)
