return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight-storm",
    },
  },

  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 900,
    opts = {
      style = "storm",
      transparent = false,
      styles = {
        -- Style to be applied to different syntax groups
        -- Value is any valid attr-list value for `:help nvim_set_hl`
        comments = { italic = true },
        keywords = { italic = true },
        functions = { bold = true },
        variables = {},
        -- Background styles. Can be "dark", "transparent" or "normal"
        sidebars = "dark", -- style for sidebars, see below
        floats = "dark", -- style for floating windows
      },
      on_highlights = function(hl, c)
        local prompt = "#2d3149"
        hl.CursorLineNr = { fg = c.orange, bold = true }
        hl.LineNr = { fg = c.orange, bold = true }
        hl.LineNrAbove = { fg = c.fg_gutter }
        hl.LineNrBelow = { fg = c.fg_gutter }
        hl.TelescopeNormal = { bg = c.bg_dark, fg = c.fg_dark }
        hl.TelescopeBorder = { bg = c.bg_dark, fg = c.bg_dark }
        hl.TelescopePromptNormal = { bg = prompt }
        hl.TelescopePromptBorder = { bg = prompt, fg = prompt }
        hl.TelescopePromptTitle = { bg = c.fg_gutter, fg = c.orange }
        hl.TelescopePreviewTitle = { bg = c.bg_dark, fg = c.bg_dark }
        hl.TelescopeResultsTitle = { bg = c.bg_dark, fg = c.bg_dark }
      end,
    },
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
  },
  { "nyoom-engineering/oxocarbon.nvim", lazy = false, priority = 900 },

  {
    "NTBBloodbath/doom-one.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.doom_one_enable_treesitter = true
      vim.g.doom_one_diagnostics_text_color = true
      -- vim.g.doom_one_transparent_background = true
      vim.g.doom_one_italic_comments = true
      vim.g.doom_one_cursor_coloring = true
      vim.g.doom_one_pumblend_enable = true
      vim.g.doom_one_plugin_telescope = true
      vim.g.doom_one_pumblend_transparency = 0
      -- vim.cmd("colorscheme doom-one") ->
    end,
  },

  {
    "olimorris/onedarkpro.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      colors = Colors,
      highlights = require("config.ui.highlights"),
      filetypes = {
        ruby = false,
      },
      styles = {
        comments = "italic",
        methods = "bold",
        functions = "bold",
      },
      options = {
        transparency = false, -- Use a transparent background?
        terminal_colors = true, -- Use the colorscheme's colors for Neovim's :terminal?
        highlight_inactive_windows = true, -- When the window is out of focus, change the normal background?
      },
    },
    config = function(_, opts)
      require("onedarkpro").setup(opts)
      -- vim.cmd.colorscheme("onedark")
    end,
  },
}
