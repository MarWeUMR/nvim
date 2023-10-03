local map = require("util.akinsho").lazy_map

local M = {}

M.set_keybindings = function()
  map("n", "<leader>dvL", "<CMD>lua require('diffview.actions').cycle_layout()<CR>", { desc = "Cycle Layout" })
  map(
    "n",
    "<leader>dvO",
    "<CMD>lua require('diffview.actions').conflict_choose('ours')<CR>",
    { desc = "choose OURS (target branch)" }
  )
  map(
    "n",
    "<leader>dvT",
    "<CMD>lua require('diffview.actions').conflict_theirs('theirs')<CR>",
    { desc = "choose THEIRS (merging branch)" }
  )

  map("n", "<leader>dvB", "<CMD>lua require('diffview.actions').conflict_choose('base')<CR>", { desc = "choose BASE" })
  map("n", "<leader>dvA", "<CMD>lua require('diffview.actions').conflict_choose('all')<CR>", { desc = "choose ALL" })
  map(
    "n",
    "<leader>dvD",
    "<CMD>lua require('diffview.actions').conflict_choose('none')<CR>",
    { desc = "delete conflict region" }
  )

  map("n", "<leader>dvb", "<CMD>lua require('diffview.actions').toggle_files()<CR>", { desc = "toggle files panel" })
  map("n", "<leader>dve", "<CMD>lua require('diffview.actions').focus_files()<CR>", { desc = "focus files panel" })
  map("n", "<leader>dvx", "<CMD>lua require('diffview.actions').next_conflict()<CR>", { desc = "next conflict" })
  map("n", "<leader>dvX", "<CMD>lua require('diffview.actions').prev_conflict()<CR>", { desc = "previous conflict" })
end

return M
