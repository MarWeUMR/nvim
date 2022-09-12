-----------------------------------------------------------
-- GENERAL NEOVIM SETTINGS AND CONFIGURATION
-----------------------------------------------------------

-- Default options are not included
-- See: https://neovim.io/doc/user/vim_diff.html
-- [2] Defaults - *nvim-defaults*

local g = vim.g -- Global variables
local opt = vim.opt -- Set options (global/buffer/windows-scoped)
local o = vim.o 
local cmd = vim.cmd

-----------------------------------------------------------
-- GENERAL {{{1
-----------------------------------------------------------
opt.mouse = "a" -- Enable mouse support
opt.clipboard = "unnamedplus" -- Copy/paste to system clipboard
opt.swapfile = false -- Don't use swapfile
opt.completeopt = "menuone,noinsert,noselect" -- Autocomplete options

-- }}}

-----------------------------------------------------------
-- NEOVIM UI {{{1
-----------------------------------------------------------



opt.number = true -- Show line number
opt.relativenumber = true -- Show line number
opt.showmatch = true -- Highlight matching parenthesis
opt.foldmethod = "marker" -- Enable folding (default 'foldmarker')
-- opt.colorcolumn = '80'      -- Line lenght marker at 80 columns
opt.splitright = true -- Vertical split to the right
opt.splitbelow = true -- Horizontal split to the bottom
opt.ignorecase = true -- Ignore case letters when search
opt.smartcase = true -- Ignore lowercase for the whole pattern
opt.linebreak = true -- Wrap on word boundary
opt.termguicolors = true -- Enable 24-bit RGB colors
opt.background="dark"
opt.laststatus = 3 -- Set global statusline

-- }}}

-----------------------------------------------------------
-- TIMINGS {{{1
-----------------------------------------------------------
o.updatetime = 300
o.timeout = true
o.timeoutlen = 500
o.ttimeoutlen = 10

-- }}}

-----------------------------------------------------------
-- TABS, INDENT {{{1
-----------------------------------------------------------
opt.expandtab = true -- Use spaces instead of tabs
opt.shiftwidth = 4 -- Shift 4 spaces when tab
opt.tabstop = 4 -- 1 tab == 4 spaces
opt.smartindent = true -- Autoindent new lines

-- }}}

-----------------------------------------------------------------------------//
-- FOLDS {{{1
-----------------------------------------------------------------------------//
o.foldlevelstart = 2
if not core.plugin_installed('nvim-ufo') then
  o.foldexpr = 'nvim_treesitter#foldexpr()'
  o.foldmethod = 'expr'
end

-- }}}

-----------------------------------------------------------
-- MEMORY, CPU {{{1
-----------------------------------------------------------
opt.hidden = true -- Enable background buffers
opt.history = 100 -- Remember N lines in history
opt.lazyredraw = true -- Faster scrolling
opt.synmaxcol = 240 -- Max column for syntax highlight

-- }}}

-----------------------------------------------------------------------------//
-- DIFF {{{1
-----------------------------------------------------------------------------//
-- Use in vertical diff mode, blank lines to keep sides aligned, Ignore whitespace changes
opt.diffopt = opt.diffopt
  + {
    'vertical',
    'iwhite',
    'hiddenoff',
    'foldcolumn:0',
    'context:4',
    'algorithm:histogram',
    'indent-heuristic',
  }

-- }}}

-----------------------------------------------------------
-- STARTUP {{{1
-----------------------------------------------------------
-- Disable nvim intro
opt.shortmess:append("sI")

-- }}}

-----------------------------------------------------------------------------//
-- WILD AND FILE GLOBBING STUFF IN COMMAND MODE {{{1
-----------------------------------------------------------------------------//
o.wildcharm = ('\t'):byte()
o.wildmode = 'longest:full,full' -- Shows a menu bar as opposed to an enormous list
o.wildignorecase = true -- Ignore case when completing file names and directories
-- Binary
opt.wildignore = {
  '*.aux',
  '*.out',
  '*.toc',
  '*.o',
  '*.obj',
  '*.dll',
  '*.jar',
  '*.pyc',
  '*.rbc',
  '*.class',
  '*.gif',
  '*.ico',
  '*.jpg',
  '*.jpeg',
  '*.png',
  '*.avi',
  '*.wav',
  -- Temp/System
  '*.*~',
  '*~ ',
  '*.swp',
  '.lock',
  '.DS_Store',
  'tags.lock',
}
o.wildoptions = 'pum'
o.pumblend = 3 -- Make popup window translucent

-- }}}

-----------------------------------------------------------
-- DISABLE BUILTIN PLUGINS {{{1
-----------------------------------------------------------
local disabled_built_ins = {
    "2html_plugin",
    "getscript",
    "getscriptPlugin",
    "gzip",
    "logipat",
    "netrw",
    "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
    "matchit",
    "tar",
    "tarPlugin",
    "rrhelper",
    "spellfile_plugin",
    "vimball",
    "vimballPlugin",
    "zip",
    "zipPlugin",
    "tutor",
    "rplugin",
    "synmenu",
    "optwin",
    "compiler",
    "bugreport",
    "ftplugin",
}

for _, plugin in pairs(disabled_built_ins) do
    g["loaded_" .. plugin] = 1
end

-- }}}
