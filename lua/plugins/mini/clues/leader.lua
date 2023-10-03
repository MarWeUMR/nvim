-- Generate clues for git related plugins with mini.clue

local M = {}

-- Generate the clues. Adding 'gm' to the clues table makes that key repeatable.
M.generate_clues = function()
  local clues = {
    { "SE", "Save & Exit" },
    { "q", "Quickfix" },
    { "fg", "Live Grep" },
    { "ff", "Find Files" },
    { "fr", "Recent Files" },
    { "rr", "Rust Runnables" },

    -- Bufferline
    { "bb", "Pick Buffer" },
    { "bl", "Push Buffer ->" },
    { "bh", "Push Buffer <-" },

    -- FZF
    { ".", "FZF Builtins" },
    { ",", "FZF Resume" },

    -- Diffview
    { "DV", "Diffview" },
  }

  local formatted_clues = {}
  for _, clue in ipairs(clues) do
    table.insert(formatted_clues, { mode = "n", keys = "gm" .. clue[1], desc = clue[2], postkeys = clue[3] })
  end

  table.insert(formatted_clues, { mode = "n", keys = "<leader>f", desc = "+Find" })
  table.insert(formatted_clues, { mode = "n", keys = "<leader>b", desc = "+Buffer" })
  table.insert(formatted_clues, { mode = "n", keys = "<leader>u", desc = "+Toggles" })
  table.insert(formatted_clues, { mode = "n", keys = "<leader>l", desc = "+LSP" })
  table.insert(formatted_clues, { mode = "n", keys = "<leader>x", desc = "+Trouble" })

  return formatted_clues
end

return M
