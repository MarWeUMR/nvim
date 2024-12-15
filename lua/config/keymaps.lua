-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

if _G.USE_CHAD then
  vim.keymap.set("n", "<leader>pt", require("nvchad.themes").open, { desc = "Pick New Theme", silent = true })
end
