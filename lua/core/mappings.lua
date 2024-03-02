-- n, v, i, t = mode names

local M = {}

M.general = {}

M.telescope = {
  plugin = true,

  n = {
    -- theme switcher
    ["<leader>th"] = { "<cmd> Telescope themes <CR>", "Nvchad themes" },
  },
}

return M
