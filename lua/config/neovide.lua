local opt = vim.o
local g = vim.g

local alpha = function()
  return string.format("%x", math.floor((255 * vim.g.transparency) or 0.8))
end

vim.cmd([[highlight Normal guibg=#212337]])

g.neovide_transparency = 0.8
g.transparency = 0.8
g.neovide_padding_top = 2
g.neovide_padding_bottom = 0
g.neovide_padding_left = 2
g.neovide_padding_right = 2
g.neovide_cursor_vfx_mode = "railgun"
g.neovide_background_color = "#212337" -- .. alpha()
g.neovide_window_blurred = true

-- opt.guifont = "MonoLisaCustom Nerd Font:h11.25"
opt.linespace = 1
