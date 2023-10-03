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
}
