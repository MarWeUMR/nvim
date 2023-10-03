-- This module generates a submode for the below keys
-- It allows to use the bracket movement repetitive

local M = {}

local chars = { '"', "'", "`", "(", "[", "{", "<" }

M.generate_clues = function()
  if not chars then
    print("Warning: surround_clues received a nil table!")
    return {}
  end

  local res = {}
  for _, char in ipairs(chars) do
    table.insert(res, { mode = "n", keys = "m" .. char, postkeys = "gzaiw" .. char })
    table.insert(res, { mode = "x", keys = "m" .. char, postkeys = "gza" .. char })
  end

  return res
end

return M
