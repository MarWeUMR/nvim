return {
  {
    "nvimtools/hydra.nvim",
    event = "VeryLazy",
    -- config = function()
    --   require("plugins.hydra.hydra_init")
    -- end,
    keys = {
      {
        "<leader>H",
        function()
          local hy = require("plugins.hydras.git_hydra")
          hy.git_hydra():activate()
        end,
        desc = "Git Hydra",
      },
    },
  },
}
