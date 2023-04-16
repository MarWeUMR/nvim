return {
  "nvim-lua/plenary.nvim",
  "MunifTanjim/nui.nvim",
  "nvim-tree/nvim-web-devicons",

  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup {
        -- timeout = 50, -- the time in which the keys must be hit in ms. Use option timeoutlen by default
        timeout = vim.o.timeoutlen, -- the time in which the keys must be hit in ms. Use option timeoutlen by defaultbetter
      }
    end,
  },

  { import = "mw.plugins.fuzzy.telescope" },
  { import = "mw.plugins.fuzzy.fzf-lua" },
}
