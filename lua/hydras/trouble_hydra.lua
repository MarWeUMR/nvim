local M = {}

local function create_hydra(mode)
  local Hydra = require("hydra")

  local hint = [[
 _x_: Document diagnostics
 _X_: Workspace diagnostics
]]

  -- this adds the appropriate command to the hydra head. It depends on the mode from which it was called.
  local heads = {
    { "x", "<cmd>TroubleToggle document_diagnostics<cr>", { remap = true, mode = { mode }, exit = true } },
    { "X", "<cmd>TroubleToggle workspace_diagnostics<cr>", { remap = true, mode = { mode }, exit = true } },
    { "q", nil, { exit = true, nowait = true, desc = false } },
    { "<Esc>", nil, { exit = true, desc = false } },
  }

  return Hydra({
    name = "TroubleToggle",
    mode = { mode },
    hint = hint,
    color = "teal",
    config = {
      hint = {
        border = "solid",
        position = "bottom-right",
      },
    },
    heads = heads,
  })
end

function M.trouble_hydra()
  return create_hydra("n")
end

return M
