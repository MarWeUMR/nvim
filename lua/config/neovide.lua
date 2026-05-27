if not vim.g.neovide then
  return
end

local function map(mode, shortcut, command, desc, opts)
  local options = vim.tbl_extend("force", { noremap = true, silent = true, desc = desc }, opts or {})
  vim.keymap.set(mode, shortcut, command, options)
end

vim.cmd.language("en_US.utf-8")
-- Allow clipboard copy paste in neovim
vim.g.neovide_input_use_logo = 1
map("", "<D-v>", "+p<CR>")
map("!", "<D-v>", "<C-R>+")
map("t", "<D-v>", "<C-R>+")
map("v", "<D-v>", "<C-R>+")

local opt = vim.o
local g = vim.g
--
local alpha = function()
  return string.format("%x", math.floor((255 * vim.g.transparency) or 0.8))
end
--
vim.cmd([[highlight Normal guibg=#212337]])
--
g.neovide_transparency = 0.9
g.transparency = 0.8
-- g.neovide_padding_top = 2
-- g.neovide_padding_bottom = 0
-- g.neovide_padding_left = 2
-- g.neovide_padding_right = 2
-- g.neovide_cursor_vfx_mode = "railgun"
-- g.neovide_background_color = "#212337" -- .. alpha()
-- g.neovide_window_blurred = true
--
-- opt.guifont = "JetBrainsMono Nerd Font:h18"
opt.guifont = "Lilex:h18"
-- opt.linespace = 1

-- vim.opt.guicursor = "" -- block cursor
vim.g.neovide_transparency = 1
vim.g.neovide_hide_mouse_when_typing = true
vim.g.neovide_fullscreen = false
vim.g.neovide_confirm_quit = false
vim.g.neovide_profiler = false
vim.g.neovide_scale_factor = 1.0

local function change_scale_factor(delta)
  vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
end

vim.keymap.set("n", "<C-=>", function()
  change_scale_factor(1.05)
end, { desc = "Neovide: increase font size" })

vim.keymap.set("n", "<C-->", function()
  change_scale_factor(1 / 1.05)
end, { desc = "Neovide: decrease font size" })

local function toggle_fullscreen()
  vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen
end

vim.keymap.set("n", "<C-`>", toggle_fullscreen, { desc = "Neovide: toggle fullscreen" })

local function change_transparency_factor(delta)
  if vim.g.neovide_transparency - delta <= 1 and vim.g.neovide_transparency - delta >= 0 then
    vim.g.neovide_transparency = vim.g.neovide_transparency - delta
  end
end

vim.keymap.set("n", "<A-T>", function()
  change_transparency_factor(-0.1)
end, { desc = "Neovide: decrease transparancy" })

vim.keymap.set("n", "<A-t>", function()
  change_transparency_factor(0.1)
end, { desc = "Neovide: increase transparancy" })

vim.g.neovide_cursor_animation_length = 0.11
vim.g.neovide_cursor_trail_size = 0.8
vim.g.neovide_cursor_animate_in_insert_mode = true
vim.g.neovide_cursor_animate_command_line = false
vim.g.neovide_cursor_unfocused_outline_width = 0.125
vim.g.neovide_cursor_vfx_mode = "pixiedust"
vim.g.neovide_cursor_vfx_opacity = 200.0
vim.g.neovide_cursor_vfx_particle_lifetime = 1.1
vim.g.neovide_cursor_vfx_particle_density = 99.0
vim.g.neovide_cursor_vfx_particle_speed = 7.0

vim.g.neovide_window_blurred = true

vim.g.neovide_padding_top = 5
vim.g.neovide_padding_bottom = 0
vim.g.neovide_padding_right = 2
vim.g.neovide_padding_left = 2
