local M = {}

local function create_hydra(mode)
  local Hydra = require("hydra")

  local fzf = require("fzf-lua")

  local hint = [[
 _a_: Code Action
 _r_: Rename
 _D_: Diag. Workspace
 _d_: Diag. Document
 _s_: Document symbols
 _S_: Workspace symbols
 _f_: format buf
 _F_: Diag. Float
]]

  -- this adds the appropriate command to the hydra head. It depends on the mode from which it was called.
  local heads = {
    {
      "f",
      function()
        require("lazyvim.plugins.lsp.format").format()
      end,
      { remap = true, mode = { mode }, exit = true },
    },
    { "F", vim.diagnostic.open_float, { remap = true, mode = { mode }, exit = true } },
    { "d", fzf.diagnostics_document, { remap = true, mode = { mode }, exit = true } },
    { "s", fzf.lsp_document_symbols, { remap = true, mode = { mode }, exit = true } },
    { "S", fzf.lsp_workspace_symbols, { remap = true, mode = { mode }, exit = true } },
    { "D", fzf.diagnostics_workspace, { remap = true, mode = { mode }, exit = true } },
    { "r", vim.lsp.buf.rename, { remap = true, mode = { mode }, exit = true } },
    { "a", vim.lsp.buf.code_action, { remap = true, mode = { mode }, exit = true } },
    { "q", nil, { exit = true, nowait = true, desc = false } },
    { "<Esc>", nil, { exit = true, desc = false } },
  }

  return Hydra({
    name = "LSP",
    mode = { mode },
    body = "<leader>L",
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

function M.lsp_hydra()
  return create_hydra("n")
end

return M
