--disable_distribution_plugins
vim.g.loaded_gzip = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_netrwFileHandlers = 1

local pack = require("core.pack")

pack.ensure_plugins()
require("core.options")
pack.load_compile()
require("keymap")

if vim.g.neovide then
  vim.cmd([[
    let g:neovide_refresh_rate=60
    let g:neovide_remember_window_size = v:true
    set guifont=CaskaydiaCove\ Nerd\ Font:h14
  ]])
end
-- require("internal.event")
