-----------------------------------------------------------------------------//
-- Language servers
-----------------------------------------------------------------------------//
---@type lspconfig.options
local servers = {
  jsonls = {},
  bashls = {},
  vimls = {},
  pyright = {},
  yamlls = {
    settings = {
      yaml = {
        customTags = {
          "!reference sequence", -- necessary for gitlab-ci.yaml files
        },
      },
    },
  },
  rust_analyzer = {
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
  lua_ls = {
    settings = {
      Lua = {
        codeLens = { enable = true },
        hint = { enable = true, arrayIndex = "Disable", setType = true, paramName = "Disable" },
        format = { enable = false },
        diagnostics = {
          globals = { "vim", "P", "describe", "it", "before_each", "after_each", "packer_plugins", "pending" },
        },
        completion = { keywordSnippet = "Replace", callSnippet = "Replace" },
        workspace = { checkThirdParty = false },
        telemetry = { enable = false },
      },
    },
  },
}

---Get the configuration for a specific language server
---@param name string?
---@return table<string, any>?
return function(name)
  local config = name and servers[name] or {}
  if not config then
    return
  end

  if type(config) == "function" then
    config = config()
  end

  -- TODO: clean this up
  if name == "rust_analyzer" then
    local rt_ok, rt = pcall(require, "rust-tools")
    if not rt_ok then
      return
    end

    rt.setup {
      server = {
        on_attach = mw.lsp.custom_on_attach(function(client, buffer)
          -- Hover actions
          vim.keymap.set("n", "<C-k>", rt.hover_actions.hover_actions, { buffer = buffer })
          -- Code action groups
          vim.keymap.set("n", "<Leader>lA", rt.code_action_group.code_action_group, { buffer = buffer })
          vim.keymap.set("n", "<Leader>rr", rt.runnables.runnables, { buffer = buffer })
        end),
      },
    }
  end

  -- if config == nil then
  --   return
  -- end

  local ok, cmp_nvim_lsp = mw.pcall(require, "cmp_nvim_lsp")
  if ok then
    config.capabilities = cmp_nvim_lsp.default_capabilities()
  end
  config.capabilities = vim.tbl_deep_extend("keep", config.capabilities or {}, {
    workspace = { didChangeWatchedFiles = { dynamicRegistration = true } },
    textDocument = { foldingRange = { dynamicRegistration = false, lineFoldingOnly = true } },
  })
  return config
end
