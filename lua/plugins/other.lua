return {
  { "kevinhwang91/nvim-bqf", ft = "qf" },
  {
    "nvimtools/hydra.nvim",
    event = "VeryLazy",
  },
  {
    "echasnovski/mini.move",
    opts = {

      mappings = {
        -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
        left = "<M-H>",
        right = "<M-L>",
        down = "<M-J>",
        up = "<M-K>",

        -- Move current line in Normal mode
        line_left = "<M-H>",
        line_right = "<M-L>",
        line_down = "<M-J>",
        line_up = "<M-K>",
      },

      -- Options which control moving behavior
      options = {
        -- Automatically reindent selection during linewise vertical move
        reindent_linewise = true,
      },
    },
  },
  {
    "MeanderingProgrammer/markdown.nvim",
    config = function()
      require("render-markdown").setup({})
    end,
  },
  {
    "cbochs/portal.nvim",
    keys = {
      { "<leader>o", "<cmd>Portal jumplist backward<cr>", desc = "Portal backward" },
      { "<leader>i", "<cmd>Portal jumplist backward<cr>", desc = "Portal forward" },
    },
  },
}
