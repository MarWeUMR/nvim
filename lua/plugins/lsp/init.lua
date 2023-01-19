return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "selene",
        "shellcheck",
        "shfmt",
        -- "black",
        "isort",
        -- "flake8",
        -- "rust-analyzer",
        "taplo",
        --"pyright",
        -- "python-lsp-server",
        -- "pylint",
        -- "autopep8",
      },
    },
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    event = "BufReadPre",
    dependencies = { "mason.nvim" },
    opts = function()
      local nls = require("null-ls")
      return {
        sources = {
          -- nls.builtins.formatting.prettierd,
          nls.builtins.formatting.stylua,
          -- nls.builtins.diagnostics.ruff.with({
          --   extra_args = {
          --     "--line-length=120",
          --     "--extend-select=D",
          --   },
          -- }),
          -- nls.builtins.formatting.ruff.with({
          --   extra_args = {
          --     "--line-length=120",
          --   },
          -- }),
          nls.builtins.diagnostics.pylint,
          nls.builtins.formatting.autopep8,
          nls.builtins.diagnostics.pycodestyle,
        },
      }
    end,
  },

  {
    "neovim/nvim-lspconfig",

    keys = function()
      return {
        {
          "<Leader>lf",
          function()
            require("lazyvim.plugins.lsp.format").format()
          end,
          { desc = "Format with LSP" },
        },
        {
          "<Leader>la",
          vim.lsp.buf.code_action,
          { desc = "Code Actions" },
        },
        {
          "<Leader>lr",
          vim.lsp.buf.rename,
          { desc = "Rename Symbol" },
        },
        {
          "<Leader>lF",
          vim.diagnostic.open_float,
          { desc = "Line Diagnostic" },
        },
        {
          "<Leader>8",
          vim.diagnostic.goto_prev,
          { desc = "Previous Diagnostic" },
        },
        {
          "<Leader>9",
          vim.diagnostic.goto_next,
          { desc = "Next Diagnostic" },
        },
      }
    end,
  },

  { import = "plugins.extras.lang.rust" },
}
