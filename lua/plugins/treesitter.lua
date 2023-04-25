local highlight = require("util.highlight_utils").highlight

return {
  {
    "nvim-treesitter/nvim-treesitter-context",
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
    dependencies = { "HiPhish/nvim-ts-rainbow2" },
    opts = {
      rainbow = {
        enable = true,
        disable = false,
        query = {
          "rainbow-parens",
          tsx = function()
            return nil
          end,
          javascript = function()
            return nil
          end,
        },
      },
    },
  },
}
