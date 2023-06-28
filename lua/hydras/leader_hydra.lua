local M = {}

local function create_hydra(mode)
  local Hydra = require("hydra")
  local hy = require("hydras")

  local as = require("util.akinsho")

  local hint = [[
 _ff_: Find Files
 _gg_: LazyGit
 _fr_: Recent Files
 _fg_: Live Grep
 _bd_: Del. Buffer
 _bl_: Push Buffer Right
 _bh_: Push Buffer Left
 _rr_: RustRunnables
 _e_ : Neotree
 _l_ : LSP
 _T_ : Toggles
 _|_ : H-Split right
 _-_ : V-Split below
 _o_ : Aerial
 _O_ : Navbuddy
 _cp_ : Copilot
 _dv_ : DiffviewHy
 _SE_ : Save & Exit
 _bb_ : Pick Buffer
 _x_ : Trouble
 _P_ : Portal/Grapple
 _q_ : Quickfix
]]

  local heads = {
    {
      "cp",
      function()
        hy.hydras.copilot_hydra():activate()
      end,
      { exit = true, nowait = true },
    },
    {
      "P",
      function()
        hy.hydras.portal_hydra():activate()
      end,
      { exit = true, nowait = true },
    },

    {
      "x",
      function()
        hy.hydras.trouble_hydra():activate()
      end,
      { exit = true, nowait = true },
    },
    { "SE", "<CMD>wqall<CR>", { mode = { "n" }, exit = true } },
    { "-", "<CMD>split<CR>", { mode = { "n" }, exit = true } },
    { "|", "<CMD>vsplit<CR>", { mode = { "n" }, exit = true } },
    { "bd", "<CMD>bd<CR>", { mode = { "n" }, exit = true } },
    { "e", "<CMD>Neotree toggle<CR>", { mode = { "n" }, exit = true } },
    { "o", "<CMD>AerialToggle<CR>", { mode = { "n" }, exit = true } },
    { "O", "<CMD>Navbuddy<CR>", { mode = { "n" }, exit = true } },
    { "bb", "<CMD>BufferLinePick<CR>", { mode = { "n" }, exit = true } },
    { "bl", "<CMD>BufferLineMoveNext<CR>", { mode = { "n" }, exit = true } },
    { "bh", "<CMD>BufferLineMovePrev<CR>", { mode = { "n" }, exit = true } },
    { "q", "<CMD>cope<CR>", { mode = { "n" }, exit = true } },
    {
      "l",
      function()
        hy.hydras.lsp_hydra():activate()
      end,
      { exit = true, nowait = true, remap = true },
    },
    {
      "T",
      function()
        hy.hydras.toggles_hydra():activate()
      end,
      { exit = true, nowait = true, remap = true },
    },
    {
      "dv",
      function()
        hy.hydras.diffview_hydra():activate()
      end,
      { exit = true, nowait = true, remap = true },
    },
    { "fg", "<CMD>Telescope live_grep<CR>", { mode = { "n" }, exit = true } },
    { "ff", "<CMD>Telescope find_files<CR>", { mode = { "n" }, exit = true } },
    { "gg", "<leader>gg", { remap = true, mode = { "n" }, exit = true } },
    { "fr", "<CMD>Telescope oldfiles<CR>", { mode = { "n" }, exit = true } },

    -- TODO:
    -- make this only visible when rust analyzer is attached
    { "rr", "<CMD>RustRunnables<CR>", { mode = { "n" }, exit = true } },
    {
      "fg",
      "<leader>fg",
      { remap = true, mode = { "n" }, exit = true },
    },
    {
      "bd",
      "<leader>bd",
      { remap = true, mode = { "n" }, exit = true },
    },
    -- { "q", nil, { exit = true, nowait = true, desc = false } },
    { "<Esc>", nil, { exit = true, desc = false } },
  }

  return Hydra({
    name = "Leader",
    mode = { mode },
    body = "<leader>",
    color = "teal",
    hint = hint,
    heads = heads,
    config = {
      invoke_on_body = true,
      hint = {
        border = "solid",
        position = "middle-right",
      },
    },
  })
end

function M.leader_hydra()
  return create_hydra("n")
end

return M
