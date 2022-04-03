-- For nvim-web-devicons
require'nvim-web-devicons'.get_icons()

-- staline.nvim
-- To Status Bar
require("lfs")

local function dot_git_exists()
  local path = "./.git"
  if (lfs.attributes(path, "mode") == "directory") then
    return true
  end
  return false
end

if dot_git_exists() then
  branch = '-branch'
else
  branch = '-📁'
  --branch = '- '
end

local function get_var(my_var_name)
  return vim.api.nvim_get_var(my_var_name)
end

extension = get_var("extension")

if extension == "cpp" or extension == "hpp" or extension == "h" then
  this_lsp = '-lsp_name'
else
  this_lsp = '-file_size'
end


require('staline').setup{
  sections = {
    left = {
      ' ', 'right_sep_double', '-mode', 'left_sep_double', ' ',
      'right_sep', '-file_name', 'left_sep', ' ',
      'right_sep_double', branch, 'left_sep_double', ' ',
    },
    mid = {'-lsp'},
    right= {
      'right_sep', '-cool_symbol', 'left_sep', ' ',
      'right_sep', '- ', this_lsp, '- ', 'left_sep',
      'right_sep_double', '-line_column', 'left_sep_double', ' ',
    }
  },

  defaults={
    fg = "#f7f7f7",
    cool_symbol = "  ",
    left_separator = "",
    right_separator = "",
    line_column = "%l:%c [%L]",
    true_colors = false,
    line_column = "[%l:%c] 並%p%% ",
    stab_start = "",
    stab_end = ""
    --font_active = "bold"
  },
  mode_colors = {
    n = "#921F81",
    i = "#006A6B",
    ic = "#E4BF7B",
    c = "#2a6099",
    v = "#D71B39"
  }
}
