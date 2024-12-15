return {
  {
    "folke/which-key.nvim",
    enabled = true,
    event = "VeryLazy",
    opts = function(_, opts)
      opts.preset = "modern"
      opts.debug = false
    end,
    -- keys = {
    --   {
    --     "<leader>H",
    --     function()
    --       local git_hk, gitsigns = pcall(require, "gitsigns")
    --
    --       vim.cmd("mkview")
    --       vim.cmd("silent! %foldopen!")
    --       -- vim.bo.modifiable = false
    --       gitsigns.toggle_signs(true)
    --       gitsigns.toggle_linehl(true)
    --       gitsigns.toggle_deleted(true)
    --
    --       -- vim.print("pre")
    --       local wk = require("which-key")
    --       vim.print(vim.inspect(wk.setup))
    --       wk.show({ keys = "]", loop = true })
    --       -- vim.print("post")
    --
    --       local cursor_pos = vim.api.nvim_win_get_cursor(0)
    --       vim.cmd("loadview")
    --       vim.api.nvim_win_set_cursor(0, cursor_pos)
    --       vim.cmd("normal zv")
    --       gitsigns.toggle_signs(true)
    --       gitsigns.toggle_linehl(false)
    --       gitsigns.toggle_deleted(false)
    --     end,
    --     desc = "Z mode (Hydra)",
    --   },
    --   -- {
    --   --   "<leader>z",
    --   --   function()
    --   --     require("which-key").show({ keys = "z", loop = true })
    --   --   end,
    --   --   desc = "Z mode (Hydra)",
    --   -- },
    --   {
    --     "<leader>v<Space>",
    --     function()
    --       require("which-key").show({ keys = "<leader>v", loop = true })
    --     end,
    --     desc = "Toggle Hydra mode",
    --   },
    -- },
  },
}
