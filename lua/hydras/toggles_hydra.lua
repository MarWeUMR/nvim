local M = {}

local function create_hydra(mode)
  local Hydra = require("hydra")

  local hint = [[
 _f_: Toggle Format
]]

  -- this adds the appropriate command to the hydra head. It depends on the mode from which it was called.
  local heads = {
    { "f", "<leader>uf", { remap = true, mode = { mode }, exit = true } },
    { "q", nil, { exit = true, nowait = true, desc = false } },
    { "<Esc>", nil, { exit = true, desc = false } },
  }

  return Hydra({
    name = "Toggles",
    mode = { mode },
    body = "<leader>u",
    hint = hint,
    color = "teal",
    config = {
      invoke_on_body = true,
      hint = {
        border = "solid",
        position = "bottom-right",
      },
    },
    heads = heads,
  })
end

function M.toggles_hydra()
  return create_hydra("n")
end

return M
