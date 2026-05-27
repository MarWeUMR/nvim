return {
  {
    "linux-cultist/venv-selector.nvim",
    enabled = true,
    branch = "main",
  },
  -- {
  --   -- FIX: needed to make venv-selector work until fzf-lua is supported
  --   "nvim-telescope/telescope.nvim",
  -- },

  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = vim.tbl_deep_extend("force", opts.formatters_by_ft, {
        -- ["nix"] = { "alejandra", "nixfmt", "injected" },
        ["python"] = function(bufnr)
          if require("conform").get_formatter_info("ruff", bufnr).available then
            return { "ruff_format", "ruff_organize_imports", "injected" }
          else
            return { "isort", "black" }
          end
        end,
      })
      -- opts.formatters = vim.tbl_deep_extend("force", opts.formatters, {
      --   injected = {
      --     options = {
      --       ignore_errors = true,
      --       lang_to_ext = {
      --         python = "py",
      --         sql = "sql",
      --       },
      --     },
      --   },
      -- })
    end,
  },
}
