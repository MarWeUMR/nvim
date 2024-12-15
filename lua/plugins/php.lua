return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      -- opts.servers = vim.tbl_deep_extend("force", opts.servers, {
      --   intelephense = {
      --     root_dir = function(...)
      --       return require("lspconfig.util").root_pattern("composer.json", ".git")(...)
      --     end,
      --     settings = {
      --       intelephense = {
      --         filetypes = { "php", "blade", "php_only" },
      --         files = {
      --           associations = { "*.php", "*.blade.php" }, -- Associating .blade.php files as well
      --           maxSize = 5000000,
      --         },
      --         format = {
      --           enable = true,
      --           braces = "k&r",
      --         },
      --         diagnostics = {
      --           enable = true,
      --         },
      --         editor = {
      --           tabSize = 8,
      --           insertSpaces = true,
      --           detectIndentation = false,
      --         },
      --       },
      --     },
      --   },
      -- })
    end,
  },
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = vim.tbl_deep_extend("force", opts.formatters_by_ft, {
        -- ["javascript"] = { "prettier" },
        -- ["css"] = { "prettier" },
        -- ["html"] = { "prettier" },
      })
      opts.formatters = vim.tbl_deep_extend("force", opts.formatters, {
        -- prettier = {
        --   command = "/Users/marwe/.local/share/nvim/mason/packages/prettier/node_modules/.bin/prettier",
        -- },
        ["php_cs_fixer"] = {
          args = {
            "fix",
            "$FILENAME",
            "--quiet",
            "--no-interaction",
            "--using-cache=no",
            "--rules=@PSR2",
          },
        },
      })
    end,
  },
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      opts.linters = vim.tbl_extend("force", opts.linters, {
        -- ["phpcs"] = {
        --   args = {
        --     "-q",
        --     "--config-set",
        --     "report_width",
        --     "180",
        --     "--standard=psr12",
        --     "--report=json",
        --     "-",
        --   },
        -- },
      })
    end,
  },
}
