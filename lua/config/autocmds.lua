-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- no comment continuation on new lines
vim.api.nvim_create_autocmd("BufEnter", { command = [[set formatoptions-=cro]] })
