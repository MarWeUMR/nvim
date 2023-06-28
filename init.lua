-- bootstrap lazy.nvim, LazyVim and your plugins

require("config.lazy")

if not vim.g.vscode then
  require("util.akinsho").pcall("theme failed to load because", vim.cmd.colorscheme, "tokyonight")
end
