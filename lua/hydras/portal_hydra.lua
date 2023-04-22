local M = {}

local function create_hydra(mode)
  local Hydra = require("hydra")

  local hint = [[
 _t_: Grapple toggle
 _p_: Grapple popup tags
]]

  -- this adds the appropriate command to the hydra head. It depends on the mode from which it was called.
  local heads = {
    {
      "t",
      function()
        require("grapple").toggle()
      end,
      { exit = true, desc = "Grapple toggle" },
    },
    {
      "p",
      function()
        require("grapple").popup_tags()
      end,
      { exit = true, desc = "Grapple popup tags" },
    },
    { "q", nil, { exit = true, nowait = true, desc = false } },
    { "<Esc>", nil, { exit = true, desc = false } },
  }

  return Hydra({
    name = "Portal/Grapple",
    mode = { mode },
    hint = hint,
    color = "teal",
    config = {
      hint = {
        border = "solid",
        position = "middle-right",
      },
    },
    heads = heads,
  })
end

function M.portal_hydra()
  return create_hydra("n")
end

return M
