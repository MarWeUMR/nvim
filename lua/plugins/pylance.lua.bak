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
          diagnosticMode = "workspace", --"openFilesOnly",
          typeCheckingMode = "basic",
          autoImportCompletions = true,
          completeFunctionParens = true,
          autoFormatStrings = true,
          indexing = false,
          inlayHints = {
            variableTypes = true,
            functionReturnTypes = true,
            callArgumentNames = true,
            pytestParameters = true,
          },
          diagnosticSeverityOverrides = {
            reportUnusedImport = "information",
            reportUnusedFunction = "information",
            reportUnusedVariable = "information",
            -- reportGeneralTypeIssues = "none",
            -- reportOptionalMemberAccess = "none",
            -- reportOptionalSubscript = "none",
            -- reportPrivateImportUsage = "none",
          },
        },
      },
    },
    handlers = {
      ["workspace/executeCommand"] = function(_, result)
        if result and result.label == "Extract Method" then
          vim.ui.input({ prompt = "New name: ", default = result.data.newSymbolName }, function(input)
            if input and #input > 0 then
              vim.lsp.buf.rename(input)
            end
          end)
        end
      end,
    },
    commands = {
      PylanceExtractMethod = {
        function()
          local arguments =
            { vim.uri_from_bufnr(0):gsub("file://", ""), require("vim.lsp.util").make_given_range_params().range }
          vim.lsp.buf.execute_command({ command = "pylance.extractMethod", arguments = arguments })
        end,
        description = "Extract Method",
        range = 2,
      },
      PylanceExtractVariable = {
        function()
          local arguments =
            { vim.uri_from_bufnr(0):gsub("file://", ""), require("vim.lsp.util").make_given_range_params().range }
          vim.lsp.buf.execute_command({ command = "pylance.extractVariable", arguments = arguments })
        end,
        description = "Extract Variable",
        range = 2,
      },
    },
    root_dir = function(...)
      local util = require("lspconfig.util")
      return util.find_git_ancestor(...)
        or util.root_pattern(unpack({
          "pyproject.toml",
          "setup.py",
          "setup.cfg",
          "requirements.txt",
          "Pipfile",
          "pyrightconfig.json",
        }))(...)
    end,
    before_init = function(_, c)
      c.settings.python.pythonPath = vim.fn.exepath("python")
    end,
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
        pyright = { enabled = false },
      },
      setup = {
        pylance = function(_, opts)
          require("lspconfig.configs").pylance = pylance_default_config
        end,
      },
    },
  },
}

-- pylance = {
--           on_attach = function(client, bufnr)
--             if is_available "venv-selector.nvim" then
--               set_mappings({
--                 n = {
--                   ["<Leader>lv"] = {
--                     "<cmd>VenvSelect<CR>",
--                     desc = "Select VirtualEnv",
--                   },
--                   ["<Leader>lV"] = {
--                     function()
--                       require("astrocore").notify(
--                         "Current Env:" .. require("venv-selector").get_active_venv(),
--                         vim.log.levels.INFO
--                       )
--                     end,
--                     desc = "Show Current VirtualEnv",
--                   },
--                 },
--               }, { buffer = bufnr })
--             end
--           end,
--           filetypes = { "python" },
--           root_dir = function(...)
--             local util = require "lspconfig.util"
--             return util.find_git_ancestor(...)
--               or util.root_pattern(unpack {
--                 "pyproject.toml",
--                 "setup.py",
--                 "setup.cfg",
--                 "requirements.txt",
--                 "Pipfile",
--                 "pyrightconfig.json",
--               })(...)
--           end,
--           cmd = { "pylance", "--stdio" },
--           single_file_support = true,
--           before_init = function(_, c) c.settings.python.pythonPath = vim.fn.exepath "python" end,
--           settings = {
--             python = {
--               analysis = {
--                 autoSearchPaths = true,
--                 useLibraryCodeForTypes = true,
--                 diagnosticMode = "workspace",
--                 typeCheckingMode = "basic",
--                 autoImportCompletions = true,
--                 completeFunctionParens = true,
--                 indexing = true,
--                 inlayHints = false,
--                 stubPath = vim.fn.stdpath "data" .. "/lazy/python-type-stubs/stubs",
--                 extraPaths = {
--                   vim.fn.stdpath "data" .. "/lazy/python-type-stubs/stubs",
--                   vim.fn.stdpath "data" .. "/lazy/pandas-stubs/pandas-stubs",
--                 },
--                 diagnosticSeverityOverrides = {
--                   reportUnusedImport = "information",
--                   reportUnusedFunction = "information",
--                   reportUnusedVariable = "information",
--                   reportGeneralTypeIssues = "none",
--                   reportOptionalMemberAccess = "none",
--                   reportOptionalSubscript = "none",
--                   reportPrivateImportUsage = "none",
--                 },
--               },
--             },
--           },
--           handlers = {
--             ["workspace/executeCommand"] = function(_, result)
--               if result and result.label == "Extract Method" then
--                 vim.ui.input({ prompt = "New name: ", default = result.data.newSymbolName }, function(input)
--                   if input and #input > 0 then vim.lsp.buf.rename(input) end
--                 end)
--               end
--             end,
--           },
--           commands = {
--             PylanceExtractMethod = {
--               function()
--                 local arguments =
--                   { vim.uri_from_bufnr(0):gsub("file://", ""), require("vim.lsp.util").make_given_range_params().range }
--                 vim.lsp.buf.execute_command { command = "pylance.extractMethod", arguments = arguments }
--               end,
--               description = "Extract Method",
--               range = 2,
--             },
--             PylanceExtractVariable = {
--               function()
--                 local arguments =
--                   { vim.uri_from_bufnr(0):gsub("file://", ""), require("vim.lsp.util").make_given_range_params().range }
--                 vim.lsp.buf.execute_command { command = "pylance.extractVariable", arguments = arguments }
--               end,
--               description = "Extract Variable",
--               range = 2,
--             },
--           },
--           docs = {
--             description = "https://github.com/microsoft/pylance-release\n\n`pylance`, Fast, feature-rich language support for Python",
--           },
--         },
--       },
--     },
