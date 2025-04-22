return {
  {
    "akinsho/bufferline.nvim",
    opts = function(_, opts)
      opts.options = vim.tbl_deep_extend("force", opts.options, {
        indicator = {
          style = "underline",
        },
      })
    end,
  },
  { "ibhagwan/smartyank.nvim" },
  { "Glench/Vim-Jinja2-Syntax" },
  { "kevinhwang91/nvim-bqf" },
  {
    "cbochs/portal.nvim",
    keys = {
      {
        "<leader>o",
        "<cmd>Portal jumplist backward<cr>",
        desc = "Portal jumplist backward",
      },
      {
        "<leader>i",
        "<cmd>Portal jumplist forward<cr>",
        desc = "Portal jumplist forward",
      },
    },
  },
  {
    "NoahTheDuke/vim-just",
    ft = { "just" },
  },
  {
    "neovim/nvim-lspconfig",

    opts = function(_, opts)
      -- options for vim.diagnostic.config()
      opts.diagnostics = {
        float = { border = "rounded", source = true },
      }
      require("lspconfig.ui.windows").default_options.border = "rounded"

      return opts
    end,
  },
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.log_level = vim.log.levels.DEBUG
      opts.notify_on_error = true
      opts.lsp_fallback = true
    end,
  },
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy", -- Or `LspAttach`
    priority = 1000, -- needs to be loaded in first
    config = function()
      require("tiny-inline-diagnostic").setup({
        options = {
          show_source = true,
          use_icons_from_diagnostic = false,
          multilines = true,
          multiple_diag_under_cursor = true,
          show_all_diags_on_cursorline = true,
          enable_on_insert = false,
        },
      })
    end,
  },
  {
    "calops/hmts.nvim",
  },

  { "folke/lazy.nvim", version = false },
  { "LazyVim/LazyVim", version = false },
}
