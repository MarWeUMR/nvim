local M = {}

function M.diffview_hydra()
  local diffview_hydra_hint = [[
  ^
  Diffview
            _L_: change layout
 _b_: toggle files       _e_: focus files
 
 _<TAB>_: next entry     _<S-TAB>_: prev entry
 _x_: next conflict      _X_: prev. conflict
 
 _O_: choose OURS        _T_: choose THEIRS
 _B_: choose BASE        _A_: choose ALL

            _D_: delete CONFLICTS
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

  local diffview_actions_ok, actions = pcall(require, "diffview.actions")

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
      { "<TAB>", actions.select_next_entry, { desc = "next entry" } },
      { "<S-TAB>", actions.select_prev_entry, { desc = "prev entry" } },
      { "L", actions.cycle_layout, { desc = "change layout" } },
      { "O", actions.conflict_choose("ours"), { desc = "choose OURS (target branch)" } },
      { "T", actions.conflict_choose("theirs"), { desc = "choose THEIRS (merging branch)" } },
      { "B", actions.conflict_choose("base"), { desc = "choose BASE" } },
      { "A", actions.conflict_choose("all"), { desc = "choose ALL" } },
      { "D", actions.conflict_choose("none"), { desc = "delete conflict region" } },
      { "b", actions.toggle_files, { desc = "toggle files panel" } },
      { "e", actions.focus_files, { desc = "focus files panel" } },
      { "x", actions.next_conflict, { desc = "next conflict" } },
      { "X", actions.prev_conflict, { desc = "prev. conflict" } },
      { "q", nil, { exit = true, nowait = true, desc = false } },
      { "<Esc>", nil, { exit = true, nowait = true, desc = false } },
    },
  })
end

return M
