-- Generate clues for git related plugins with mini.clue

local M = {}

-- Generate the clues. Adding 'gm' to the clues table makes that key repeatable.
M.generate_clues = function()
  local git_ok, gitsigns = pcall(require, "gitsigns")
  if not git_ok then
    print("Warning: Required module `gitsigns` for git clues is not available!")
    return {}
  end

  local clues = {
    { "J", "Next Hunk", "gm" },
    { "K", "Previous Hunk", "gm" },
    { "c", "Show Changes" },
    { "s", "Stage Hunk", "gm" },
    { "D", "Diffview Open" },
    { "u", "Undo Last Stage", "gm" },
    { "-", "GS Base Step Back", "gm" },
    { "t", "Changes ~1 -> QF" },
    { "S", "Stage Buffer" },
    { "p", "Preview Hunk", "gm" },
    { "d", "Toggle Deleted", "gm" },
    { "r", "Reset Hunk", "gm" },
    { "0", "Reset Base" },
    { "H", "Git Status -> QF" },
    { "B", "Blame Show Full" },
    { "/", "Show Base File" },
  }

  local formatted_clues = {}
  for _, clue in ipairs(clues) do
    table.insert(formatted_clues, { mode = "n", keys = "gm" .. clue[1], desc = clue[2], postkeys = clue[3] })
  end

  return formatted_clues
end

return M
