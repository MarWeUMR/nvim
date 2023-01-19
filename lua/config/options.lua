-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

if vim.g.neovide then
  vim.opt.guifont = { "Iosevka Term SS08", ":h12" }
  vim.g.neovide_refresh_rate = 120
  vim.g.neovide_refresh_rate_idle = 5
  vim.g.neovide_transparency = 0.9
  vim.g.transparency = 0.9
  vim.g.neovide_floating_blur_amount_x = 2.0
  vim.g.neovide_floating_blur_amount_y = 2.0
  vim.g.neovide_scroll_animation_length = 0.3
  vim.g.neovide_remember_window_size = true
  vim.opt.pumblend = 10
  vim.opt.winblend = 10
  vim.g.neovide_cursor_vfx_mode = "railgun"
  vim.g.neovide_no_idle = true
  vim.g.neovide_cursor_animation_length = 0.03
  vim.g.neovide_cursor_trail_length = 0.05
  vim.g.neovide_cursor_antialiasing = true
  vim.g.neovide_cursor_vfx_opacity = 200.0
  vim.g.neovide_cursor_vfx_particle_lifetime = 1.2
  vim.g.neovide_cursor_vfx_particle_speed = 20.0
  vim.g.neovide_cursor_vfx_particle_density = 5.0
end

vim.opt.fillchars = Icons.fillchars
vim.opt.scrolloff = 6
vim.opt.signcolumn = "yes:1"

-- vim.g.python3_host_prog = "/home/ubuntu/.pyenv/versions/venv3916/bin/python"
