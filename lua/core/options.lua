local opt = vim.opt
local utils = require("utils")
local function list(value, str, sep)
  sep = sep or ","
  str = str or ""
  value = type(value) == "table" and table.concat(value, sep) or value
  return str ~= "" and table.concat({value, str}, sep) or value
end


vim.cmd("colorscheme onedarkpro")

opt.termguicolors = true
opt.hidden = true
opt.magic = true
opt.virtualedit = "block"
opt.clipboard = "unnamedplus"
opt.wildignorecase = true
opt.swapfile = false
-- opt.directory = cache_dir .. 'swap/'
-- opt.undodir = cache_dir .. 'undo/'
-- opt.backupdir = cache_dir .. 'backup/'
-- opt.viewdir = cache_dir .. 'view/'
-- opt.spellfile = cache_dir .. 'spell/en.uft-8.add'

opt.history = 2000
opt.timeout = true
opt.ttimeout = true
opt.timeoutlen = 500
opt.ttimeoutlen = 10
opt.updatetime = 100
opt.redrawtime = 1500
opt.ignorecase = true
opt.smartcase = true
opt.infercase = true

-- use rg in vim grep
if vim.fn.executable("rg") == 1 then
	opt.grepformat = "%f:%l:%c:%m,%f:%l:%m"
	opt.grepprg = "rg --vimgrep --no-heading --smart-case"
end

opt.completeopt = "menu,menuone,noselect"
opt.showmode = false
opt.shortmess = "aoOTIcF"
opt.scrolloff = 5
opt.sidescrolloff = 5
opt.ruler = false
opt.showtabline = 0
opt.winwidth = 30
opt.pumheight = 15
opt.showcmd = false
opt.cmdheight = 0
opt.laststatus = 3
opt.list = true
-- opt.listchars = "tab:»·,nbsp:+,trail:·,extends:→,precedes:←"
opt.listchars = list {
  "tab: ──",
  -- "space:·",
  "nbsp:␣",
  "trail:•",
  --"eol:↵",
  "precedes:«",
  "extends:»"
}
opt.fillchars = list {
  -- "vert:▏",
  "vert:│",
  "diff:╱",
  "foldclose:",
  "foldopen:",
  "fold: ",
  "msgsep:─",
}
opt.pumblend = 10
opt.winblend = 10
opt.undofile = true

opt.smarttab = true
opt.expandtab = true
opt.autoindent = true
opt.tabstop = 2
opt.shiftwidth = 2

-- wrap
opt.linebreak = true
opt.whichwrap = "h,l,<,>,[,],~"
opt.breakindentopt = "shift:2,min:20"
opt.showbreak = "↳  "
opt.foldlevelstart = 99
opt.foldmethod = "marker"

opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"
opt.spelloptions = "camel"

opt.textwidth = 100
opt.colorcolumn = ""
-- opt.conceallevel = 2
-- opt.concealcursor = 'niv'

-- GIT
if vim.fn.has("nvim-0.9") == 1 then
  opt.diffopt = { "filler", "internal", "algorithm:histogram", "indent-heuristic", "linematch:60" }
else
  opt.diffopt = { "filler", "internal", "algorithm:histogram", "indent-heuristic" }
end

-- turn off comment continuation on newlines
utils.augroup("general_settings", {
	{
		event = { "BufWinEnter" },
		pattern = "*",
		command = ":set formatoptions-=cro",
	},
})

if vim.loop.os_uname().sysname == "Darwin" then
	vim.g.clipboard = {
		name = "macOS-clipboard",
		copy = {
			["+"] = "pbcopy",
			["*"] = "pbcopy",
		},
		paste = {
			["+"] = "pbpaste",
			["*"] = "pbpaste",
		},
		cache_enabled = 0,
	}
	vim.g.python_host_prog = "/usr/bin/python"
	vim.g.python3_host_prog = "/usr/local/bin/python3"
end
