local Util = require("lazyvim.util")

return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- add a keymap to browse plugin files
      { "<leader>fg", Util.telescope("live_grep", { cwd = false }), desc = "Grep (cwd)" },
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "find files" },
    },
    opts = {
      defaults = {
        mappings = {
          i = {
            ["<C-j>"] = function(...)
              return require("telescope.actions").move_selection_next(...)
            end,
            ["<C-k>"] = function(...)
              return require("telescope.actions").move_selection_previous(...)
            end,
            ["<C-z>"] = function(...)
              return require("telescope.actions").to_fuzzy_refine(...)
            end,
            ["<C-l>"] = function(...)
              return require("telescope.actions.layout").cycle_layout_next(...)
            end,
          },
        },
      },
    },
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    event = "VeryLazy",
    config = function()
      require("telescope").load_extension("file_browser")
    end,
  },
}
