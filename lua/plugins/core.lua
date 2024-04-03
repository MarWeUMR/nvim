return {
  -- better pairs implementation
  { "echasnovski/mini.pairs", enabled = false },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "base-onenord",
    },
  },
}
