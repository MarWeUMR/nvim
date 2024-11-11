---@class ChadrcConfig
local M = {}

M.base46 = {
  theme = "palenight",
  integrations = { "telescope", "cmp", "trouble" },
}

M.ui = {
  statusline = {
    theme = "default",
    separator_style = "default",
  },
  telescope = { style = "borderless" },
  tabufline = { enabled = false, lazyload = true },
  cmp = {
    lspkind_text = true,
    style = "atom", -- default/flat_light/flat_dark/atom/atom_colored
    format_colors = {
      tailwind = false,
    },
  },
}

M.nvdash = {
  load_on_startup = false,
}

M.term = {
  enable = false,
  winopts = { number = false, relativenumber = false },
  sizes = { vs = 0.5 },
  float = {
    relative = "editor",
    row = 0.3,
    col = 0.25,
    width = 0.5,
    height = 0.4,
    border = "single",
  },
}

M.lsp = { signature = false }

M.cheatsheet = { theme = "simple" }

return M
