return {

  {
    "quarto-dev/quarto-nvim",
    enabled = false,
    dependencies = {
      { "hrsh7th/nvim-cmp" },
      {
        "jmbuhr/otter.nvim",
        dev = false,
        config = function()
          require("otter.config").setup({})
        end,
      },
    },
    config = function()
      require("quarto").setup({
        closePreviewOnExit = true,
        lspFeatures = {
          enabled = true,
          chunks = "all",
          languages = { "python", "julia", "bash", "lua", "html" },
          diagnostics = {
            enabled = true,
            triggers = { "BufWritePost" },
          },
          completion = {
            enabled = true,
          },
        },
        keymap = {
          hover = "K",
          definition = "gd",
          rename = "<leader>lR",
          references = "gr",
        },
      })
    end,
  },
}
