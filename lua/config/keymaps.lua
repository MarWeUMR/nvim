-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local git = require("plugins.mini.mappings.git")
local diffview = require("plugins.mini.mappings.diffview")
local leader = require("plugins.mini.mappings.leader")

local map = require("util.akinsho").lazy_map

vim.keymap.del("n", "<leader>qq")
vim.keymap.del("n", "<leader>l")

git.set_keybindings()
diffview.set_keybindings()
leader.set_keybindings()

local Util = require("lazyvim.util")

local toggle = Util.toggle

-- TODO:
-- add a toggle to show normal line numbers
map("n", "<leader>ul", function()
  toggle("relativenumber", true)
  toggle("number")
end, { desc = "Toggle Line Numbers" })

-- paste same stuff over and over
vim.keymap.set("v", "p", '"_dP')

----------------------------------------------------------------------------->>
---- TOGGLETERM MAPPINGS
---- this allows to use 1<c-t> or 2<c-t> etc. to open multiple terminals
vim.api.nvim_exec(
  [[
  augroup ToggleTermMappings
    autocmd!
    autocmd TermEnter term://*toggleterm#* tnoremap <silent><c-t> <Cmd>exe v:count1 . "ToggleTerm"<CR>
    autocmd TermEnter term://*toggleterm#* nnoremap <silent><c-t> <Cmd>exe v:count1 . "ToggleTerm"<CR>
    autocmd TermEnter term://*toggleterm#* inoremap <silent><c-t> <Esc><Cmd>exe v:count1 . "ToggleTerm"<CR>
  augroup END
]],
  false
)
-----------------------------------------------------------------------------<<
