-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local git = require("plugins.mini.mappings.git")
local diffview = require("plugins.mini.mappings.diffview")
local map = require("util.akinsho").lazy_map

vim.keymap.del("n", "<leader>qq")
vim.keymap.del("n", "<leader>l")

git.set_keybindings()
diffview.set_keybindings()

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

vim.keymap.set("n", "<leader>DV", "<CMD>DiffviewOpen<CR>")

----------------------------------------------------------------------------->>
---- BUFFERLINE MAPPINGS
map("n", "<leader>bb", "<CMD>BufferLinePick<CR>", { desc = "Pick Buffer" })
map("n", "<leader>bl", "<CMD>BufferLineMoveNext<CR>", { desc = "Push Buffer ->" })
map("n", "<leader>bh", "<CMD>BufferLineMovePrev<CR>", { desc = "Push Buffer <-" })
-----------------------------------------------------------------------------<<

----------------------------------------------------------------------------->>
---- FZF MAPPINGS
map("n", "<leader>.", "<CMD>lua require('fzf-lua').builtin()<CR>", { desc = "FZF Builtins" })
map("n", "<leader>,", "<CMD>lua require('fzf-lua').resume()<CR>", { desc = "FZF Resume" })
-----------------------------------------------------------------------------<<

----------------------------------------------------------------------------->>
---- LEADER MAPPINGS
map("n", "<leader>SE", ":wqall<CR>", { desc = "Save & Exit" })
map("n", "<leader>-", ":split<CR>", { desc = "V-Split below" })
map("n", "<leader>|", ":vsplit<CR>", { desc = "H-Split right" })
map("n", "<leader>q", ":cope<CR>", { desc = "Quickfix" })
map("n", "<leader>fg", ":Telescope live_grep<CR>", { desc = "Live Grep" })
map("n", "<leader>ff", ":Telescope find_files<CR>", { desc = "Find Files" })
map("n", "<leader>fr", ":Telescope oldfiles<CR>", { desc = "Recent Files" })
map("n", "<leader>rr", ":RustRunnables<CR>", { desc = "Rust Runnables" })
map("n", "<leader>gg", "<leader>gg", { desc = "LazyGit" })
-----------------------------------------------------------------------------<<

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
