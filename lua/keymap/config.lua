-- author: glepnr https://github.com/glepnir
-- date: 2022-07-02
-- License: MIT
-- recommend some vim mode key defines in this file

local keymap = require("core.keymaps")
local nmap, imap, cmap, xmap = keymap.nmap, keymap.imap, keymap.cmap, keymap.xmap
local silent, noremap = keymap.silent, keymap.noremap
local opts = keymap.new_opts
local cmd = keymap.cmd

-- Use space as leader key
vim.g.mapleader = " "

-- leaderkey
nmap({ " ", "", opts(noremap) })
xmap({ " ", "", opts(noremap) })

-- usage example
nmap({
  -- noremal remap
  -- save
  { "<C-s>", cmd("write"), opts(noremap) },
  -- yank
  { "Y", "y$", opts(noremap) },
  -- remove trailing white space
  { "<Leader>t", cmd("TrimTrailingWhitespace"), opts(noremap) },
  -- window jump
  { "<C-h>", "<C-w>h", opts(noremap) },
  { "<C-l>", "<C-w>l", opts(noremap) },
  { "<C-j>", "<C-w>j", opts(noremap) },
  { "<C-k>", "<C-w>k", opts(noremap) },
  -- remove search highlight on esc
  { "<esc>", "<esc><cmd>noh<cr>", opts(noremap) },
  -- movement between methods

  { "<Leader>jf", "]m", opts(noremap) },
  { "<Leader>jF", "[m", opts(noremap) },
  { "<Leader>jc", "]]", opts(noremap) },
  { "<Leader>jC", "[[", opts(noremap) },
})

imap({
  -- insert mode
  { "<C-h>", "<Bs>", opts(noremap) },
  { "<C-e>", "<End>", opts(noremap) },
})

-- commandline remap
cmap({ "<C-b>", "<Left>", opts(noremap) })
