-- correctly setup lspconfig
return {

  -- extend the lsp tool collection
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "rust-analyzer", "taplo" })
    end,
  },

  -- add rust to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "rust", "toml" })
    end,
  },

  -- setup rust-tools
  {
    "neovim/nvim-lspconfig",
    dependencies = { "simrat39/rust-tools.nvim" },
    opts = {
      -- make sure mason installs the server
      setup = {
        rust_analyzer = function(_, opts)
          require("lazyvim.util").on_attach(function(client, buffer)
            -- client.server_capabilities.semanticTokensProvider = nil
            -- stylua: ignore
            if client.name == "rust_analyzer" then
              vim.keymap.set("n", "K", "<CMD>RustHoverActions<CR>", { buffer = buffer })
              vim.keymap.set("n", "<leader>ct", "<CMD>RustDebuggables<CR>", { buffer = buffer, desc = "Run Test" })
              vim.keymap.set("n", "<leader>dr", "<CMD>RustDebuggables<CR>", { buffer = buffer, desc = "Run" })
            end
          end)
          local rust_tools_opts = vim.tbl_deep_extend("force", opts, {
            -- dap = {
            --   adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
            -- },
            tools = {
              hover_actions = {
                auto_focus = false,
                border = "none",
              },
              inlay_hints = {
                auto = true,
                show_parameter_hints = true,
              },
            },
            server = {
              settings = {
                ["rust-analyzer"] = {
                  cargo = {
                    features = "all",
                  },
                  -- Add clippy lints for Rust.
                  checkOnSave = true,
                  check = {
                    command = "check",
                    features = "all",
                  },
                  procMacro = {
                    enable = true,
                  },
                },
              },
            },
          })
          require("rust-tools").setup(rust_tools_opts)
          return true
        end,
        taplo = function(_, opts)
          local function show_documentation()
            if vim.fn.expand("%:t") == "Cargo.toml" and require("crates").popup_available() then
              require("crates").show_popup()
            else
              vim.lsp.buf.hover()
            end
          end

          require("lazyvim.util").on_attach(function(client, buffer)
            -- stylua: ignore
            if client.name == "taplo" then
              vim.keymap.set("n", "K", show_documentation, { buffer = buffer })
            end
          end)
          return false -- make sure the base implementation calls taplo.setup
        end,
      },
    },
  },
}
