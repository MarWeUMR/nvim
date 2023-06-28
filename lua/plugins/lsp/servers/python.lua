-- correctly setup lspconfig
return {

  -- extend the lsp tool collection
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "pyright",
        "black",
        "ruff",
        "ruff-lsp",
        "isort",
        "python-lsp-server",
      })
    end,
  },

  -- add python to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "python" })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ruff_lsp = {},
        pyright = {
          settings = {
            python = {
              disableOrganizeImports = true,
              analysis = {
                indexing = true,
                typeCheckingMode = "basic",
                diagnosticMode = "openFilesOnly",
                autoImportCompletions = false,
                autoSearchPaths = false,
              },
            },
          },
        },
        pylsp = {
          settings = {
            pylsp = {
              plugins = {
                jedi_definition = {
                  enabled = true,
                  follow_imports = true,
                  follow_builtin_imports = true,
                  follow_builtin_definitions = true,
                },
                jedi_rename = { enabled = true },
                jedi_completion = {
                  enabled = true,
                  include_params = true,
                  cache_labels_for = {
                    "pandas",
                    "numpy",
                    "pydantic",
                    "fastapi",
                    "flask",
                    "sqlalchemy",
                    "dagster",
                  },
                },
                jedi_hover = { enabled = true },
                pylsp_mypy = {
                  enabled = true,
                  live_mode = false,
                  dmypy = false,
                  report_progress = false,
                  -- args = {
                  --   "--sqlite-cache", -- Use an SQLite database to store the cache.
                  --   "--cache-fine-grained", -- Include fine-grained dependency information in the cache for the mypy daemon.
                  -- },
                },
                -- Disabled ones:
                flake8 = { enabled = false },
                mccabe = { enabled = false },
                preload = { enabled = false },
                pycodestyle = { enabled = false },
                pyflakes = { enabled = false },
                pylint = { enabled = false },
                rope = { enabled = true },
                rope_completion = { enabled = true },
                rope_rename = { enabled = false },
                yapf = { enabled = false },
                -- still unsure:
                -- jedi_completion = { enabled = false }, -- done better by pyright ?
                -- Formatting is taken care of by null-ls
                ["pylsp_black"] = { enabled = false },
                ["pyls_isort"] = { enabled = false },
                autopep8 = { enabled = false },
              },
            },
          },
        },
      },
      setup = {
        pylsp = function()
          require("lazyvim.util").on_attach(function(client, _)
            if client.name == "pyslp" then
              client.server_capabilities.documentFormattingProvider = false
              client.server_capabilities.documentRangeFormattingProvider = false
            end
          end)
        end,
        pyright = function()
          require("lazyvim.util").on_attach(function(client, _)
            if client.name == "pyright" then
              client.server_capabilities.renameProvider = false -- rope is ok
              client.server_capabilities.hoverProvider = false -- pylsp includes also docstrings
              client.server_capabilities.signatureHelpProvider = false -- pyright typing of signature is weird
              client.server_capabilities.definitionProvider = false -- pyright does not follow imports correctly
              client.server_capabilities.referencesProvider = false -- pylsp does it
              client.server_capabilities.completionProvider = {
                resolveProvider = true,
                triggerCharacters = { "." },
              }
            end
          end)
        end,
      },
    },
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      vim.list_extend(opts.sources, {
        nls.builtins.diagnostics.ruff,

        nls.builtins.formatting.black.with({
          args = {
            "--fast",
            "--quiet",
            "--stdin-filename",
            "$FILENAME",
            "-",
          },
        }),
        nls.builtins.formatting.isort,
      })
    end,
  },
}
