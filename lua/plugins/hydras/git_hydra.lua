local M = {}
-- local akinsho = require("util.akinsho")

local function populate_quickfix_list(changed_files)
  local qf_list = {}
  for _, file in ipairs(changed_files) do
    table.insert(qf_list, { filename = file, lnum = 1, col = 0, text = "Changed file" })
  end
  vim.fn.setqflist(qf_list)
end

function M.git_hydra()
  local git_hint = [[
^
  Git
 _J_: next hunk     _d_: show deleted
 _K_: prev hunk     _u_: undo last stage
 _s_: stage hunk    _/_: show base file
 _p_: preview hunk  _S_: stage buffer
 _r_: reset hunk    _B_: blame show full
 _H_: Hunks -> QF   _t_: ~1 chngd. files -> QF
 _0_: reset base    _D_: Diffview
 _c_: show changes
^
]]

  local git_ok, gitsigns = pcall(require, "gitsigns")
  if not git_ok then
    return
  end
  local hy_ok, Hydra = pcall(require, "hydra")
  if not hy_ok then
    return
  end

  return Hydra({
    name = "+git",
    hint = git_hint,
    mode = { "n", "x" },
    config = {
      color = "pink",
      invoke_on_body = true,
      hint = {
        position = "middle-right",
      },
      on_key = function()
        vim.wait(50)
      end,
      on_enter = function()
        vim.cmd("mkview")
        vim.cmd("silent! %foldopen!")
        -- vim.bo.modifiable = false
        gitsigns.toggle_signs(true)
        gitsigns.toggle_linehl(true)
        gitsigns.toggle_deleted(true)
      end,
      on_exit = function()
        local cursor_pos = vim.api.nvim_win_get_cursor(0)
        vim.cmd("loadview")
        vim.api.nvim_win_set_cursor(0, cursor_pos)
        vim.cmd("normal zv")
        gitsigns.toggle_signs(true)
        gitsigns.toggle_linehl(false)
        gitsigns.toggle_deleted(false)
      end,
    },
    heads = {
      {
        "J",
        function()
          if vim.wo.diff then
            return "]c"
          end
          vim.schedule(function()
            gitsigns.next_hunk()
            vim.api.nvim_feedkeys("zz", "n", false)
          end)
          return "<Ignore>"
        end,
        { expr = true, desc = "next hunk" },
      },
      {
        "K",
        function()
          if vim.wo.diff then
            return "[c"
          end
          vim.schedule(function()
            gitsigns.prev_hunk()
            vim.api.nvim_feedkeys("zz", "n", false)
          end)
          return "<Ignore>"
        end,
        { expr = true, desc = "prev hunk" },
      },
      {
        "c",
        ":FzfLua git_status<CR>",
        { desc = "show changes" },
      },

      {
        "s",
        ":Gitsigns stage_hunk<CR>",
        { desc = "stage hunk" },
      },
      {
        "D",
        ":DiffviewOpen<CR>",
        { desc = "Diffview Open", exit = true },
      },

      { "u", gitsigns.undo_stage_hunk, { desc = "undo last stage" } },
      {
        "-",
        function()
          vim.schedule(function()
            -- akinsho.update_gitsigns_base()
          end)
        end,
        { desc = "GS base step back" },
      },
      {
        "t",
        function()
          -- local changed_files = akinsho.get_changed_files_latest_commit()
          populate_quickfix_list(changed_files)
        end,
        { desc = "Changes ~1 -> QF", exit = true },
      },
      { "S", gitsigns.stage_buffer, { desc = "stage buffer" } },
      { "p", gitsigns.preview_hunk, { desc = "preview hunk" } },
      { "d", gitsigns.toggle_deleted, { nowait = true, desc = "toggle deleted" } },
      { "r", gitsigns.reset_hunk, { desc = "reset_hunk" } },
      { "0", gitsigns.reset_base, { desc = "reset base" } },
      {
        "H",
        function()
          -- local changed_files = akinsho.get_changed_files()
          populate_quickfix_list(changed_files)
        end,
        { exit = true, desc = "Git Status -> QF" },
      },
      {
        "B",
        function()
          gitsigns.blame_line({ full = true })
        end,
        { desc = "blame show full" },
      },
      { "/", gitsigns.show, { exit = true, desc = "show base file" } },
      { "<Esc>", nil, { exit = true, nowait = true, desc = false } },
      { "q", nil, { exit = true, nowait = true, desc = false } },
    },
  })
end

return M
