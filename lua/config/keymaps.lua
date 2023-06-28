-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local Util = require("lazyvim.util")

local toggle = Util.toggle

local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

-- TODO:
-- add a toggle to show normal line numbers
map("n", "<leader>ul", function()
  toggle("relativenumber", true)
  toggle("number")
end, { desc = "Toggle Line Numbers" })

-- paste same stuff over and over
vim.keymap.set("v", "p", '"_dP')

-----------------------------------------------------------------------------//
-- HYDRA INVOCATIONS
-----------------------------------------------------------------------------//

if not vim.g.vscode then
  local hy_ok, hy = pcall(require, "hydras")
  if not hy_ok then
    return
  end

  map("n", "g", function()
    hy.hydras.g_hydra():activate()
  end, { desc = "g" })

  map("n", "m", function()
    hy.hydras.m_hydra():activate()
  end, { desc = "m" })

  map("n", "+", function()
    hy.hydras.bracketed_hydra("+"):activate()
  end, { desc = "]" })

  map("n", "ü", function()
    hy.hydras.bracketed_hydra("ü"):activate()
  end, { desc = "[" })

  map("n", "<leader>", function()
    hy.hydras.leader_hydra():activate()
  end, { desc = "leader" })

  map("v", "m", function()
    hy.hydras.m_hydra():activate()
  end, { desc = "m" })
end

-----------------------------------------------------------------------------//
-- TOGGLETERM MAPPINGS
-- this allows to use 1<c-t> or 2<c-t> etc. to open multiple terminals
-----------------------------------------------------------------------------//
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
