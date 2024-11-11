return {
  {
    "folke/snacks.nvim",
    opts = {
      words = { enabled = true },
      styles = {
        notification = {
          wo = { wrap = true }, -- Wrap notifications
        },
      },
      statuscolumn = {
        enabled = true,
        folds = {
          open = false, -- show open fold icons
          git_hl = true, -- use Git Signs hl for fold icons
        },
      },
    },
  },
}
