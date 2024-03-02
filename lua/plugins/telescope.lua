return {
  {
    "nvim-telescope/telescope.nvim",
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "telescope")
      local telescope = require("telescope")
      local extensions_list = { "themes" }
      telescope.setup(opts)

      for _, ext in ipairs(extensions_list) do
        telescope.load_extension(ext)
      end
    end,
    keys = {
      {
        "<leader>Q",
        "<cmd> copen<cr>",
        desc = "Open QF",
      },
    },
  },
}
