if not mw then
  return
end

local fn, api, uv, cmd, command, fmt = vim.fn, vim.api, vim.loop, vim.cmd, mw.command, string.format

local recursive_map = function(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.remap = true
  map(mode, lhs, rhs, opts)
end

local nmap = function(...)
  recursive_map("n", ...)
end
local imap = function(...)
  recursive_map("i", ...)
end
local nnoremap = function(...)
  map("n", ...)
end
local xnoremap = function(...)
  map("x", ...)
end
local vnoremap = function(...)
  map("v", ...)
end
local inoremap = function(...)
  map("i", ...)
end
local onoremap = function(...)
  map("o", ...)
end
local cnoremap = function(...)
  map("c", ...)
end
local tnoremap = function(...)
  map("t", ...)
end

-----------------------------------------------------------------------------//
-- Move to window using the <ctrl> hjkl keys
-----------------------------------------------------------------------------//

map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-----------------------------------------------------------------------------//
-- Resize window using <ctrl> arrow keys
-----------------------------------------------------------------------------//
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-----------------------------------------------------------------------------//
-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
-----------------------------------------------------------------------------//
map("n", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("n", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-----------------------------------------------------------------------------//
-- TOGGLE OPTIONS
-----------------------------------------------------------------------------//
-- map("n", "<leader>uf", require("lazyvim.plugins.lsp.format").toggle, { desc = "Toggle format on Save" })
map("n", "<leader>us", function()
  mw.toggle "spell"
end, { desc = "Toggle Spelling" })
map("n", "<leader>uw", function()
  mw.toggle "wrap"
end, { desc = "Toggle Word Wrap" })
map("n", "<leader>ul", function()
  mw.toggle("relativenumber", true)
  mw.toggle "number"
end, { desc = "Toggle Line Numbers" })
-- map("n", "<leader>ud", Util.toggle_diagnostics, { desc = "Toggle Diagnostics" })
local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3
map("n", "<leader>uc", function()
  mw.toggle("conceallevel", false, { 0, conceallevel })
end, { desc = "Toggle Conceal" })

-----------------------------------------------------------------------------//
-- TELESCOPE
-----------------------------------------------------------------------------//

map("n", "<leader>ff", "<cmd> Telescope find_files <CR>", { desc = "find files" })
map("n", "<leader>fb", "<cmd> Telescope file_browser <CR>", { desc = "file browser" })
map(
  "n",
  "<leader>fB",
  "<cmd> Telescope file_browser path=%:p:h select_buffer=true <CR>",
  { desc = "file browser (cwd=buffer)" }
)
map("n", "<leader>fa", "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", { desc = "find all" })
map("n", "<leader>fg", "<cmd> Telescope live_grep <CR>", { desc = "live grep" })
map("n", "<leader>fo", "<cmd> Telescope oldfiles <CR>", { desc = "find oldfiles" })
map("n", "<leader>pt", "<cmd> Telescope terms <CR>", { desc = "pick hidden term" })
map("n", "<leader>th", "<cmd> Telescope themes <CR>", { desc = "nvchad themes" })
