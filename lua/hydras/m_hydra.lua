local M = {}

local function create_hydra(mode)
  local Hydra = require("hydra")

  local hint = [[
 _"_: surround with ""
 _'_: surround with ''
 _´´_: surround with ``
 _(_: surround with ()
 _[_: surround with []
 _{_: surround with {}
 _<_: surround with <>
]]

  -- this adds the appropriate command to the hydra head. It depends on the mode from which it was called.
  local heads = {
    { [["]], mode == "n" and [[gzaiw"]] or [[gza"]], { remap = true, mode = { mode }, exit = true } },
    { [[']], mode == "n" and [[gzaaw']] or [[gza']], { remap = true, mode = { mode }, exit = true } },
    { [[´´]], mode == "n" and [[gzaaw`]] or [[gza`]], { remap = true, mode = { mode }, exit = true } },
    { [[(]], mode == "n" and [[gzaiw)]] or [[gza)]], { remap = true, mode = { mode }, exit = true } },
    { [[[]], mode == "n" and [[gzaiw[]] or [[gza[]], { remap = true, mode = { mode }, exit = true } },
    { [[{]], mode == "n" and [[gzaiw}]] or [[gza}]], { remap = true, mode = { mode }, exit = true } },
    { [[<]], mode == "n" and [[gzaiw>]] or [[gza>]], { remap = true, mode = { mode }, exit = true } },
    { "q", nil, { exit = true, nowait = true, desc = false } },
    { "<Esc>", nil, { exit = true, desc = false } },
  }

  return Hydra({
    name = "Match",
    mode = { mode },
    body = "m",
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

function M.m_hydra()
  -- TODO: add more hydra functionality like find surround/change/delete
  -- also, make sub-hydras depending on the decision to keep the menu small

  local mode = vim.api.nvim_get_mode().mode
  return create_hydra(mode == "n" and "n" or "v")
end

return M
