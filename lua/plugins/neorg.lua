return {
  {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    opts = {
      configure_parsers = true,
      load = {
        ["core.defaults"] = {}, -- Loads default behaviour
        ["core.concealer"] = {}, -- Adds pretty icons to your documents
        ["core.completion"] = { config = { engine = "nvim-cmp" } },
        ["core.dirman"] = { -- Manages Neorg workspaces
          config = {
            workspaces = {
              notes = "~/notes",
            },
          },
        },
      },
    },
    dependencies = { { "nvim-lua/plenary.nvim" } },
  },

  {
    "lukas-reineke/headlines.nvim",
    enabled = false,
    ft = { "org", "norg", "markdown", "yaml" },
    config = function()
      -- highlight.plugin("Headlines", {
      --   theme = {
      --     ["*"] = {
      --       { Dash = { bg = "#0B60A1", bold = true } },
      --     },
      --     ["horizon"] = {
      --       { Headline = { bold = true, italic = true, bg = { from = "Normal", alter = 0.2 } } },
      --       { Headline1 = { inherit = "Headline", fg = { from = "Type" } } },
      --     },
      --   },
      -- })
      require("headlines").setup({
        org = { headline_highlights = false },
        norg = { headline_highlights = { "Headline" }, codeblock_highlight = false },
        markdown = { headline_highlights = { "Headline1" } },
      })
    end,
  },
}
