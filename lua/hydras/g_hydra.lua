local M = {}

local function create_hydra(mode)
  local Hydra = require("hydra")
  local hy = require("hydras")

  local hint = [[
 _cc_: comment line
 _m_: git mode
 _d_: peek definition
 _D_: go to definition
 _r_: peek references
 _y_: peek type definition
 _i_: peek implementation
 _J_: join expression
 _S_: split expression
]]

  local heads = {
    {
      "m",
      function()
        hy.hydras.git_hydra():activate()
      end,
      { exit = true, nowait = true, remap = true },
    },
    { "cc", "gcc", { remap = true, exit = true, nowait = true, desc = false } },
    { "g", "gg", { exit = true, nowait = true, desc = false } },
    { "d", "<CMD>Glance definitions<CR>", { mode = { "n" }, exit = true } },
    { "D", "gD", { remap = true, mode = { "v" }, exit = true } },
    { "r", "<CMD>Glance references<CR>", { remap = true, mode = { "n" }, exit = true } },
    { "y", "<CMD>Glance type_definitions<CR>", { remap = true, mode = { "n" }, exit = true } },
    { "i", "<CMD>Glance implementations<CR>", { remap = true, mode = { "n" }, exit = true } },
    { "J", "<Cmd>TSJJoin<CR>", { remap = true, mode = { "n" }, exit = true } },
    { "S", "<Cmd>TSJSplit<CR>", { remap = true, mode = { "n" }, exit = true } },
    { "q", nil, { exit = true, nowait = true, desc = false } },
    { "<Esc>", nil, { exit = true, desc = false } },
  }

  return Hydra({
    name = "g",
    mode = { mode },
    body = "g",
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

function M.g_hydra()
  return create_hydra("n")
end

return M
