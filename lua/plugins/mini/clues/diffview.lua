local M = {}

M.generate_clues = function()
  local diffview_ok, actions = pcall(require, "diffview.actions")
  if not diffview_ok then
    print("Warning: Required module `diffview` for diffview clues is not available!")
    return {}
  end

  local clues = {

    { "L", "change layout", "<leader>dv" },
    { "O", "Choose OURS (target branch)", "<leader>dv" },
    { "T", "Choose THEIRS (merging branch)", "<leader>dv" },
    { "B", "Choose BASE", "<leader>dv" },
    { "A", "Choose ALL", "<leader>dv" },
    { "D", "Delete Conflict Region", "<leader>dv" },
    { "b", "Toggle Files Panel", "<leader>dv" },
    { "e", "Focus Files Panel", "<leader>dv" },
    { "x", "Next Conflict", "<leader>dv" },
    { "X", "Previous Conflict", "<leader>dv" },
    { "<tab>", "next entry", "<leader>dv" },
    { "<S-tab>", "prev entry", "<leader>dv" },
  }

  local formatted_clues = {}
  for _, clue in ipairs(clues) do
    table.insert(formatted_clues, { mode = "n", keys = "<leader>dv" .. clue[1], desc = clue[2], postkeys = clue[3] })
  end

  return formatted_clues
end

return M
