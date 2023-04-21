-- bootstrap lazy.nvim, LazyVim and your plugins

require("config.lazy")

require("util.akinsho").pcall("theme failed to load because", vim.cmd.colorscheme, "tokyonight")
