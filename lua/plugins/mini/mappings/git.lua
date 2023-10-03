-- Generate the keybindings for mini.clues git submode

local map = require("util.akinsho").lazy_map

local M = {}

M.set_keybindings = function()
  map("n", "gmJ", "<CMD>lua require('gitsigns').next_hunk()<CR>zz", { desc = "Next Hunk" })
  map("n", "gmK", "<CMD>lua require('gitsigns').prev_hunk()<CR>zz", { desc = "Previous Hunk" })
  map("n", "gmc", "<CMD>FzfLua git_status<CR>", { desc = "Show Changes" })
  map("n", "gms", "<CMD>Gitsigns stage_hunk<CR>", { desc = "Stage Hunk" })
  map("n", "gmD", "<CMD>DiffviewOpen<CR>", { desc = "Diffview Open" })
  map("n", "gmu", "<CMD>lua require('gitsigns').undo_stage_hunk()<CR>", { desc = "Undo Last Stage" })
  map("n", "gm-", "<CMD>lua require('util.akinsho').update_gitsigns_base()<CR>", { desc = "GS Base Step Back" })
  map(
    "n",
    "gmt",
    "<CMD>lua local akinsho = require('util.akinsho'); local changed_files = akinsho.get_changed_files_latest_commit(); populate_quickfix_list(changed_files)<CR>",
    { desc = "Changes ~1 -> QF" }
  )
  map("n", "gmS", "<CMD>Gitsigns stage_buffer<CR>", { desc = "Stage Buffer" })
  map("n", "gmp", "<CMD>Gitsigns preview_hunk<CR>", { desc = "Preview Hunk" })
  map("n", "gmd", "<CMD>Gitsigns toggle_deleted<CR>", { desc = "Toggle Deleted" })
  map("n", "gmr", "<CMD>Gitsigns reset_hunk<CR>", { desc = "Reset Hunk" })
  map("n", "gm0", "<CMD>Gitsigns reset_base<CR>", { desc = "Reset Base" })
  map(
    "n",
    "gmH",
    "<CMD>lua local akinsho = require('util.akinsho'); local changed_files = akinsho.get_changed_files(); populate_quickfix_list(changed_files)<CR>",
    { desc = "Git Status -> QF" }
  )
  map("n", "gmB", "<CMD>lua require('gitsigns').blame_line({ full = true })<CR>", { desc = "Blame Show Full" })
  map("n", "gm/", "<CMD>Gitsigns show<CR>", { desc = "Show Base File" })
end

return M
