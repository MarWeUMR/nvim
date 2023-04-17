local g, fn, opt, loop, env, cmd = vim.g, vim.fn, vim.opt, vim.loop, vim.env, vim.cmd
local data = fn.stdpath "data"

----------------------------------------------------------------------------------------------------
-- Leader bindings
----------------------------------------------------------------------------------------------------
g.mapleader = " " -- Remap leader key
g.maplocalleader = " " -- Local leader is <Space>

----------------------------------------------------------------------------------------------------
-- Global namespace
----------------------------------------------------------------------------------------------------

local namespace = {
  styles = {
    winbar = { enable = true },
    statuscolumn = { enable = true },
  },
  lsp = {},
}

-- This table is a globally accessible store to facilitating accessing
-- helper functions and variables throughout my config
_G.mw = mw or namespace
_G.map = vim.keymap.set
_G.P = vim.print

----------------------------------------------------------------------------------------------------
-- Settings
----------------------------------------------------------------------------------------------------
-- Order matters here as globals needs to be instantiated first etc.
require "mw.utils"
require "mw.ui.highlights"
require "mw.ui.styles"
require "mw.config.options"

-------------------------------------------------------------------------------//
-- INITIALIZE LAZY
-------------------------------------------------------------------------------//
local lazypath = data .. "/lazy/lazy.nvim"
if not loop.fs_stat(lazypath) then
  fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  }
  vim.notify "Installed lazy.nvim"
end
opt.runtimepath:prepend(lazypath)

-----------------------------------------------------------------------------
require("lazy").setup("mw.plugins", {
  ui = { border = mw.styles.border.rectangle },
  defaults = { lazy = true },
  change_detection = { notify = false },
  checker = {
    enabled = true,
    concurrency = 30,
    notify = false,
    frequency = 3600, -- check for updates every hour
  },
  performance = {
    rtp = {
      paths = { data .. "/site" },
      disabled_plugins = { "netrw", "netrwPlugin" },
    },
  },
})

mw.pcall("theme failed to load because", cmd.colorscheme, "tokyonight-storm")
