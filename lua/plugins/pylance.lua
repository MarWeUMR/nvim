local pylance_default_config = {
  default_config = {
    filetypes = { "python" },
    cmd = { "pylance", "--stdio" },
    single_file_support = true,
    capabilities = vim.lsp.protocol.make_client_capabilities(),
    settings = {
      editor = { formatOnType = false },
      python = {
        analysis = {
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
          diagnosticMode = "openFilesOnly", --"workspace",
          typeCheckingMode = "basic",
          completeFunctionParens = true,
          autoFormatStrings = true,
          indexing = false,
          inlayHints = {
            variableTypes = true,
            functionReturnTypes = true,
            callArgumentNames = true,
            pytestParameters = true,
          },
        },
      },
    },
  },
}
return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- pyright will be automatically installed with mason and loaded with lspconfig
        pylance = {},
      },
      setup = {
        pylance = function(_, opts)
          require("lspconfig.configs").pylance = pylance_default_config
        end,
      },
    },
  },
}
