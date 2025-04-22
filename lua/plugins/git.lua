return {
  {
    "lewis6991/gitsigns.nvim",
    keys = {
      {
        "<leader>gH<ESC>",
        function()
          vim.bo.modifiable = true
          vim.cmd("loadview")
          require("gitsigns").toggle_word_diff(false)
          require("gitsigns").toggle_linehl(false)
          require("gitsigns").toggle_deleted(false)
        end,
        desc = "Reset Hunk",
      },
      {
        "<leader>gHd",
        function()
          require("gitsigns").diffthis()
        end,
        desc = "Show diffs",
      },

      {
        "<leader>gH]",
        function()
          require("gitsigns").nav_hunk("next")
        end,
        desc = "Next Hunk",
      },
      {
        "<leader>gH[",
        function()
          require("gitsigns").nav_hunk("prev")
        end,
        desc = "Prev. Hunk",
      },
      {
        "<leader>gh<space>",
        function()
          vim.cmd("mkview")
          vim.bo.modifiable = false
          require("gitsigns").toggle_word_diff(true)
          require("gitsigns").toggle_linehl(true)
          require("gitsigns").preview_hunk_inline()

          require("which-key").show({ keys = "<Leader>gH", loop = true })
        end,
        desc = "Git Hydra",
      },
    },
  },

  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- optional - Diff integration

      -- Only one of these is needed, not both.
      -- "nvim-telescope/telescope.nvim", -- optional
      "ibhagwan/fzf-lua", -- optional
    },
    config = true,
  },
  {
    "sindrets/diffview.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    opts = function(_, opts)
      opts.enhanced_diff_hl = true
    end,
    keys = {
      {
        "<leader>gdo",
        "<cmd>DiffviewOpen<cr>",
        desc = "Diff view Git Diff Open",
      },

      {
        "<leader>gdc",
        "<cmd>DiffviewClose<cr>",
        desc = "Diff view Git Diff Close",
      },
    },
  },
}
