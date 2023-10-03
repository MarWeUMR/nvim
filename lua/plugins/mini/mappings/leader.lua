-- Generate the keybindings for mini.clues git submode

local map = require("util.akinsho").lazy_map

local M = {}

M.set_keybindings = function()
  map("n", "<leader>SE", ":wqall<CR>", { desc = "Save & Exit" })
  map("n", "<leader>q", ":cope<CR>", { desc = "Quickfix" })
  map("n", "<leader>fg", ":Telescope live_grep<CR>", { desc = "Live Grep" })
  map("n", "<leader>ff", ":Telescope find_files<CR>", { desc = "Find Files" })
  map("n", "<leader>fr", ":Telescope oldfiles<CR>", { desc = "Recent Files" })
  map("n", "<leader>rr", ":RustRunnables<CR>", { desc = "Rust Runnables" })

  -- Bufferline
  map("n", "<leader>bb", "<CMD>BufferLinePick<CR>", { desc = "Pick Buffer" })
  map("n", "<leader>bl", "<CMD>BufferLineMoveNext<CR>", { desc = "Push Buffer ->" })
  map("n", "<leader>bh", "<CMD>BufferLineMovePrev<CR>", { desc = "Push Buffer <-" })

  -- FZF
  map("n", "<leader>.", "<CMD>lua require('fzf-lua').builtin()<CR>", { desc = "FZF Builtins" })
  map("n", "<leader>,", "<CMD>lua require('fzf-lua').resume()<CR>", { desc = "FZF Resume" })

  -- Diffview
  map("n", "<leader>DV", "<CMD>DiffviewOpen<CR>", { desc = "Diffview" })
end

return M
