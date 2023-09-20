local highlight = require("util.highlight_utils").highlight

return {
  {
    "nvim-treesitter/nvim-treesitter-context",
    enabled = false,
    event = "BufReadPre",
    init = function()
      highlight.plugin("treesitter-context", {
        { ContextBorder = { link = "WinSeparator" } },
        { TreesitterContextLineNumber = { link = "LineNrAbove" } },
        {
          TreesitterContext = {
            link = "Normal",
          },
        },
      })
    end,
    opts = {
      multiline_threshold = 4,
      separator = { "─", "ContextBorder" }, -- alternatives: ▁ ─ ▄
      mode = "cursor",
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = { { "HiPhish/rainbow-delimiters.nvim" } },
    opts = {
      rainbow = {
        enable = true,
        query = {
          "rainbow-parens",
        },
      },
    },
  },
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = "VeryLazy",
    config = function()
      local rainbow_delimiters = require("rainbow-delimiters")

      vim.g.rainbow_delimiters = {
        strategy = {
          [""] = rainbow_delimiters.strategy["global"],
        },
        query = {
          [""] = "rainbow-delimiters",
        },
      }
    end,
  },
}
