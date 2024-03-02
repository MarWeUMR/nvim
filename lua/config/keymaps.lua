-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local Util = require("lazyvim.util")
local Map = Util.safe_keymap_set

-- paste same stuff over and over
vim.keymap.set("v", "p", '"_dP')

-- ===========================================================================//
-- HYDRA INVOCATIONS
-- ===========================================================================//

if not vim.g.vscode then
  local hy_ok, hy = pcall(require, "hydras")
  if not hy_ok then
    return
  end
  Map("n", "<leader>GH", function()
    hy.hydras.git_hydra():activate()
  end, { desc = "leader" })
end
