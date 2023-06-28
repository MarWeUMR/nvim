local M = {}

function M.diffview_hydra()
  local diffview_hydra_hint = [[
  ^
  Diffview
 _L_: change layout     _d_: discard hunk 
 _K_: prev hunk         _a_: accept hunk
 _s_: show hunk         _o_: toggle orientation
 _p_: preview hunk      _w_: toggle width
 _c_: close diffview    _r_: refresh diffview
  ^
  ]]

  local diffview_ok, diffview = pcall(require, "diffview")
  if not diffview_ok then
    return
  end
  local hydra_ok, Hydra = pcall(require, "hydra")
  if not hydra_ok then
    return
  end

  return Hydra({
    name = "+diffview",
    hint = diffview_hydra_hint,
    mode = { "n", "x" },
    body = "<leader>2",
    config = {
      color = "pink",
      hint = { border = "solid", position = "middle-right" },
    },
    heads = {
      { "L", "g<C-x>", { desc = "change layout", remap = true, exit = true, nowait = true, desc = false } },
      { "K", ":DiffviewPrevHunk<CR>", { desc = "previous hunk" } },
      { "s", ":DiffviewShowHunk<CR>", { desc = "show hunk" } },
      { "p", ":DiffviewPreviewHunk<CR>", { desc = "preview hunk" } },
      { "d", ":DiffviewDiscardHunk<CR>", { desc = "discard hunk" } },
      { "a", ":DiffviewAcceptHunk<CR>", { desc = "accept hunk" } },
      { "o", ":DiffviewToggleOrientation<CR>", { desc = "toggle orientation" } },
      { "w", ":DiffviewToggleWidth<CR>", { desc = "toggle width" } },
      { "c", ":DiffviewClose<CR>", { exit = true, desc = "close diffview" } },
      { "r", ":DiffviewRefresh<CR>", { desc = "refresh diffview" } },
      { "q", nil, { exit = true, nowait = true, desc = false } },
      { "<Esc>", nil, { exit = true, nowait = true, desc = false } },
    },
  })
end

return M
