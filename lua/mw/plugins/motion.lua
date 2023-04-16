return {
  { ---------- This allows to jump between e.g. 'function()' and 'end' with '%'
    "andymass/vim-matchup",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      vim.g.matchup_matchparen_offscreen = {}
      vim.g.matchup_matchparen_deferred = 1
    end,
  },

  {
    "ggandor/leap.nvim",
    keys = {
      { "s", mode = { "n", "x", "o" }, desc = "Leap forward to" },
      { "S", mode = { "n", "x", "o" }, desc = "Leap backward to" },
      { "gs", mode = { "n", "x", "o" }, desc = "Leap from windows" },
    },
    config = function(_, opts)
      local leap = require "leap"
      for k, v in pairs(opts) do
        leap.opts[k] = v
      end
      leap.add_default_mappings(true)
      vim.keymap.del({ "x", "o" }, "x")
      vim.keymap.del({ "x", "o" }, "X")
    end,
  },

  {
    "ggandor/flit.nvim",
    keys = function()
      local ret = {}
      for _, key in ipairs { "f", "F", "t", "T" } do
        ret[#ret + 1] = { key, mode = { "n", "x", "o" }, desc = key }
      end
      return ret
    end,
    opts = { labeled_modes = "nx" },
  },

  {
    "Wansmer/treesj",
    event = "VeryLazy",
    dependencies = { "nvim-treesitter" },
    opts = { use_default_keymaps = false },
    keys = {
      { "gS", "<Cmd>TSJSplit<CR>", desc = "split expression to multiple lines" },
      { "gJ", "<Cmd>TSJJoin<CR>", desc = "join expression to single line" },
    },
  },

  {
    "Wansmer/sibling-swap.nvim",
    event = "VeryLazy",
    keys = { "]w", "[w" },
    dependencies = { "nvim-treesitter" },
    opts = {
      use_default_keymaps = true,
      highlight_node_at_cursor = true,
      keymaps = {
        ["]w"] = "swap_with_left",
        ["[w"] = "swap_with_right",
      },
    },
  },
}
