return {

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
