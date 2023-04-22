local M = {}

local function create_hydra(mode)
  local Hydra = require("hydra")

  -- local copi_ok, copi = pcall(require, "copilot.panel")
  -- if not copi_ok then
  --   return
  -- end

  local hint = [[
 _o_: Open Panel
 _n_: Next
 _p_: Prev
 _a_: Accept
]]

  -- this adds the appropriate command to the hydra head. It depends on the mode from which it was called.
  local heads = {
    { "o", "<cmd>Copilot panel open<cr>", { mode = { mode }, exit = true } },
    { "n", "<cmd>Copilot panel jump_next<cr>", { mode = { mode }, exit = true } },
    { "p", "<cmd>Copilot panel jump_prev<cr>", { mode = { mode }, exit = true } },
    { "a", "<cmd>Copilot panel accept<cr>", { mode = { mode }, exit = true } },
    { "q", nil, { exit = true, nowait = true, desc = false } },
    { "<Esc>", nil, { exit = true, desc = false } },
  }

  return Hydra({
    name = "Copilot",
    mode = { mode },
    -- body = "<leader>CPPP",
    hint = hint,
    color = "teal",
    config = {
      on_key = function()
        vim.wait(50)
      end,
      -- invoke_on_body = true,
      hint = {
        border = "solid",
        position = "middle-right",
      },
    },
    heads = heads,
  })
end

function M.copilot_hydra()
  return create_hydra("n")
end

return M
