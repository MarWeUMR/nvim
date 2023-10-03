-- This module generates a submode for the below keys
-- It allows to use the bracket movement repetitive

local M = {}

local keys = { "b", "d", "e", "h", "x" }

M.generate_clues = function()
  local result = {}
  for _, char in ipairs(keys) do
    table.insert(result, { mode = "n", keys = "]" .. char, postkeys = "]" })
    table.insert(result, { mode = "n", keys = "[" .. char, postkeys = "[" })
  end

  -- Special key to invert the direction of the bracket movement.
  table.insert(result, { mode = "n", keys = "]<LEADER>", postkeys = "<Esc>[", desc = "invert direction" })
  table.insert(result, { mode = "n", keys = "[<LEADER>", postkeys = "<Esc>]", desc = "invert direction" })

  return result
end

return M
