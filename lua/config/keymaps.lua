-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- move over a closing element in insert mode
vim.keymap.set("i", "<C-l>", function()
  return require("utils").escapePair()
end, { desc = "Jump out of Closing Element" })

-- buffers
vim.keymap.set("n", "<leader>bb", "<cmd>BufferLinePick<cr>", { desc = "Pick Other Buffer" })
vim.keymap.set("n", "<leader>bk", "<cmd>BufferLinePickClose<cr>", { desc = "Pick Buffer to Kill" })
vim.keymap.set("n", "<S-l>", "<cmd>:BufferLineCycleNext<CR>", { desc = "Next Buffer" })
vim.keymap.set("n", "<S-h>", "<cmd>:BufferLineCyclePrev<CR>", { desc = "Previous Buffer" })

-- center screen on search hits
--vim.keymap.set("n", "n", "nzzzv")
--vim.keymap.set("n", "N", "Nzzzv")

-- paste same stuff over and over
vim.keymap.set("v", "p", '"_dP')
