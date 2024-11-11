return {
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
    "nvim-telescope/telescope.nvim",
    -- change some options
    opts = {
      defaults = {
        path_display = { "filename_first" },
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
  -- {
  --   "hrsh7th/nvim-cmp",
  --   dependencies = { "lukas-reineke/cmp-rg" },
  --   opts = function(_, opts)
  --     table.insert(opts.sources, {
  --       {
  --         name = "rg",
  --         -- keyword_length = 3 -- if performance is problematic
  --       },
  --       { name = "supermaven" },
  --     })
  --     opts.window = {
  --       completion = {
  --         border = "rounded",
  --         -- winhighlight = "CursorLine:PmenuSel",
  --         winhighlight = "Normal:Pmenu,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:Pmenu",
  --         scrollbar = false,
  --       },
  --       documentation = {
  --         border = "rounded",
  --         -- winhighlight = ""
  --         winhighlight = "Normal:Pmenu,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:Pmenu",
  --         scrollbar = false,
  --       },
  --     }
  --   end,
  -- },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- optional - Diff integration

      -- Only one of these is needed, not both.
      -- "nvim-telescope/telescope.nvim", -- optional
      "ibhagwan/fzf-lua", -- optional
    },
    config = true,
  },
  {
    "sindrets/diffview.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    keys = {
      {
        "<leader>gdo",
        "<cmd>DiffviewOpen<cr>",
        desc = "Diff view Git Diff Open",
      },

      {
        "<leader>gdc",
        "<cmd>DiffviewClose<cr>",
        desc = "Diff view Git Diff Close",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {

        groovyls = {
          filetypes = { "Jenkinsfile", "groovy" },
          cmd = {
            "java",
            "-jar",
            vim.fn.stdpath("data")
              .. "/mason/packages/groovy-language-server/build/libs/groovy-language-server-all.jar",
          },
        },
      },
    },
  },
  { "folke/lazy.nvim", version = false },
  { "LazyVim/LazyVim", version = false },
}
