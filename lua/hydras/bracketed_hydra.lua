local M = {}

function M.bracketed_hydra(key)
  local Hydra = require("hydra")

  local git_ok, gitsigns = pcall(require, "gitsigns")
  if not git_ok then
    return
  end

  local function create_bracketed_hydra(name, key, hint, go_forward)
    return Hydra({
      name = name,
      mode = { "n" },
      body = key,
      hint = hint,
      color = "teal",
      config = {
        invoke_on_body = true,
        hint = {
          border = "solid",
          position = "bottom-right",
        },
      },
      heads = {
        {
          "h",
          function()
            if vim.wo.diff then
              return go_forward and "]c" or "[c"
            end
            vim.schedule(function()
              (go_forward and gitsigns.next_hunk or gitsigns.prev_hunk)()
            end)
            return "<Ignore>"
          end,
          { remap = true, exit = true },
        },
        {
          "e",
          function()
            vim.diagnostic[(go_forward and "goto_next" or "goto_prev")]({
              severity = vim.lsp.protocol.DiagnosticSeverity.Error,
            })
          end,
          { remap = true, exit = true },
        },
        { "f", (go_forward and "]m" or "[m"), { remap = true, mode = { "n" }, exit = true } },
        {
          "c",
          function()
            require("mini.bracketed").comment(go_forward and "forward" or "backward")
          end,
          { remap = true, mode = { "n" }, exit = true },
        },
        { "d", (go_forward and "[d" or "]d"), { remap = true, mode = { "n" }, exit = true } },
        {
          "w",
          (go_forward and function()
            require("sibling-swap").swap_with_right()
          end or function()
            require("sibling-swap").swap_with_left()
          end),
          { remap = true, mode = { "n" }, exit = true },
        },
        { "q", nil, { exit = true, nowait = true, desc = false } },
        { "<Esc>", nil, { exit = true, desc = false } },
      },
    })
  end

  if key == "+" then
    return create_bracketed_hydra(
      "Bracketed Next",
      "+",
      [[
  go to next:

  _h_: hunk
  _f_: function
  _d_: diagnostic
  _e_: error
  _c_: comment
  --------------
  _w_: swap arg
  ]],
      true
    )
  else
    return create_bracketed_hydra(
      "Bracketed Previous",
      "ü",
      [[
  go to previous:

  _h_: hunk
  _f_: function
  _d_: diagnostic
  _e_: error
  _c_: comment
  --------------
  _w_: swap arg
  ]],
      false
    )
  end
end

return M
