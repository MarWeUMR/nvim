local M = {}

function M.bracketed_hydra(key)
  local Hydra = require("hydra")

  local git_ok, gitsigns = pcall(require, "gitsigns")
  if not git_ok then
    return
  end

  local head_config = {
    remap = true,
    mode = { "n" },
    exit = true,
  }

  local diagnostic = require("lspsaga.diagnostic")

  local function goto_diagnostic(filter)
    if filter == "next" then
      diagnostic:goto_next({ severity = vim.lsp.protocol.DiagnosticSeverity.Error })
    elseif filter == "prev" then
      diagnostic:goto_prev({ severity = vim.lsp.protocol.DiagnosticSeverity.Error })
    end
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
          position = "middle-right",
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
          vim.tbl_extend("keep", { desc = "hunk" }, head_config),
        },
        {
          "e",
          function()
            goto_diagnostic(go_forward and "next" or "prev")
          end,
          vim.tbl_extend("keep", { desc = "error" }, head_config),
        },
        {
          "f",
          (go_forward and "]m" or "[m"),
          vim.tbl_extend("keep", { desc = "function" }, head_config),
        },
        {
          "c",
          function()
            require("mini.bracketed").comment(go_forward and "forward" or "backward")
          end,
          vim.tbl_extend("keep", { desc = "comment" }, head_config),
        },
        {
          "d",
          (go_forward and "<cmd>Lspsaga diagnostic_jump_next<cr>" or "<cmd>Lspsaga diagnostic_jump_prev<cr>"),
          vim.tbl_extend("keep", { desc = "diagnostic" }, head_config),
        },
        {
          "w",
          (go_forward and function()
            require("sibling-swap").swap_with_right()
          end or function()
            require("sibling-swap").swap_with_left()
          end),
          vim.tbl_extend("keep", { desc = "swap args" }, head_config),
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
