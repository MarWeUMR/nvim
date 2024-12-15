return {
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = vim.tbl_deep_extend("force", opts.formatters_by_ft, {
        -- ["nix"] = { "alejandra", "nixfmt", "injected" },
        ["nix"] = { "injected" },
        bash = {
          "shfmt",
          -- "beautysh",
        },
      })

      opts.formatters.injected = vim.tbl_deep_extend("force", opts.formatters.injected, {
        options = {
          ignore_errors = true,
          lang_to_formatters = {
            bash = {
              ["shfmt"] = {
                prepend_args = { "-i", "2", "-ci" },
              },
            },
          },
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers = vim.tbl_deep_extend("force", opts.servers, {
        bashls = {
          filetypes = { "sh", "zsh", "bash" },
        },
      })
    end,
  },
}
