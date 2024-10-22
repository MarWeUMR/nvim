return {
  "yetone/avante.nvim",
  enabled = false,
  event = "VeryLazy",
  lazy = false,
  build = "make",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    "zbirenbaum/copilot.lua", -- for providers='copilot'
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
  },
  keys = {
    { "<leader>Ia", ":AvanteAsk<cr>", mode = { "n", "v" }, desc = "Avante Ask" },
    { "<leader>Ic", ":AvanteChat<cr>", mode = { "n", "v" }, desc = "Avante Chat" },
    { "<leader>Id", ":AvanteToggleDebug<cr>", mode = { "n", "v" }, desc = "Avante Debug" },
    { "<leader>Ie", ":AvanteEdit<cr>", desc = "Avante Edit" },
    { "<leader>Ih", ":AvanteToggleHint<cr>", desc = "Avante Hint" },
    { "<leader>Ir", ":AvanteRefresh<cr>", desc = "Avante Refresh" },
    { "<leader>It", ":AvanteToggle<cr>", desc = "Avante Toggle" },
    { "<leader>Ix", ":AvanteClear<cr>", desc = "Avante Clear" },
  },
  opts = {
    provider = "copilot",
    auto_suggestions_provider = "copilot",
    behaviour = {
      auto_suggestions = false, -- Experimental stage
      auto_set_keymaps = false,
      auto_apply_diff_after_generation = true,
      support_paste_from_clipboard = false,
    },
  },
}
