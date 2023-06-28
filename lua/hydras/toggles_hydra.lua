local M = {}

local function create_hydra(mode)
  local Hydra = require("hydra")
  local as = require("util.akinsho")

  local hint = [[
 _f_: Toggle Format
 _c_: Toggle Conceal
 _l_: Rel. LN
 _w_: Line Wrap
 _d_: diag. Lines
 ]]

  -- this adds the appropriate command to the hydra head. It depends on the mode from which it was called.
  local heads = {
    { "f", "<leader>uf", { remap = true, mode = { mode }, exit = true } },
    { "c", "<leader>uc", { remap = true, mode = { mode }, exit = true } },
    { "l", "<leader>ul", { remap = true, mode = { mode }, exit = true } },
    { "w", "<leader>uw", { remap = true, mode = { mode }, exit = true } },
    {
      "d",
      function()
        as.toggle_diagnostics()
      end,
      { exit = true, nowait = true },
    },
    { "q", nil, { exit = true, nowait = true, desc = false } },
    { "<Esc>", nil, { exit = true, desc = false } },
  }

  return Hydra({
    name = "Toggles",
    mode = { mode },
    hint = hint,
    color = "teal",
    config = {
      invoke_on_body = true,
      hint = {
        border = "solid",
        position = "middle-right",
      },
    },
    heads = heads,
  })
end

function M.toggles_hydra()
  return create_hydra("n")
end

return M
