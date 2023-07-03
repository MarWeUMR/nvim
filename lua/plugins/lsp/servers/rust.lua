-- correctly setup lspconfig
return {

  -- setup rust-tools
  {
    "neovim/nvim-lspconfig",
    dependencies = { "simrat39/rust-tools.nvim" },
    opts = {
      -- make sure mason installs the server
      setup = {
        rust_analyzer = function(_, opts)
          local user_rust_tools_opts = require("lazyvim.util").opts("rust-tools.nvim")
          local rust_tools_opts = vim.tbl_deep_extend("force", user_rust_tools_opts, {

            server = vim.tbl_deep_extend("force", opts, {
              settings = {
                ["rust-analyzer"] = {
                  cargo = {
                    allFeatures = true,
                    loadOutDirsFromCheck = true,
                    runBuildScripts = true,
                    extraEnv = { CARGO_PROFILE_RUST_ANALYZER_INHERITS = "dev" },
                    extraArgs = { "--profile", "rust-analyzer" },
                  },
                  -- Add clippy lints for Rust.
                  checkOnSave = true,
                  check = {
                    -- allFeatures = true,
                    command = "check",
                    features = "all",
                  },
                  procMacro = {
                    enable = true,
                    ignored = {
                      ["async-trait"] = { "async_trait" },
                      ["napi-derive"] = { "napi" },
                      ["async-recursion"] = { "async_recursion" },
                    },
                  },
                },
              },
            }),
          })
          require("rust-tools").setup(rust_tools_opts)
          return true
        end,
      },
    },
  },
}
