return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "classic",
      layout = { align = "center" },
      show_help = true,
      -- spec = {
      --   {
      --     mode = { "n", "v" },
      --     { "<leader>b", group = "bookmarks" },
      --     { "<leader>c", group = "clear" },
      --     { "<leader>f", group = "file" },
      --     {
      --       "<leader>h",
      --       group = "local",
      --       icon = {
      --         icon = " ",
      --         color = "blue",
      --       },
      --     },
      --     { "<leader>l", group = "list" },
      --     {
      --       "<leader>n",
      --       group = "no",
      --       icon = { icon = " ", color = "red" },
      --     },
      --     { "<leader>p", group = "preview" },
      --     { "<leader>r", group = "remote" },
      --     { "<leader>s", group = "search" },
      --     { "<leader>t", group = "test/toggle" },
      --     { "<leader>v", group = "vcs" },
      --     { "<leader>w", group = "window" },
      --     { "<leader>x", group = "xray" },
      --     { "[", group = "prev" },
      --     { "]", group = "next" },
      --     { "g", group = "goto" },
      --   },
      -- },
      win = {
        border = "solid",
      },
    },
    keys = {
      {
        "<c-w><space>",
        function()
          require("which-key").show({ keys = "<c-w>", loop = true })
        end,
        desc = "Window Hydra Mode (which-key)",
      },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
    end,
  },
}
