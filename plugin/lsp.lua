if not mw then
  return
end

local lsp, fs, fn, api, fmt = vim.lsp, vim.fs, vim.fn, vim.api, string.format
local diagnostic = vim.diagnostic
local L, S = vim.lsp.log_levels, vim.diagnostic.severity

local icons = mw.styles.icons.lsp
local border = mw.styles.current.border
local augroup = mw.augroup
local command = mw.command

if vim.env.DEVELOPING then
  vim.lsp.set_log_level(L.DEBUG)
end

-----------------------------------------------------------------------------//
-- Autocommands
-----------------------------------------------------------------------------//

---@enum
local provider = {
  HOVER = "hoverProvider",
  RENAME = "renameProvider",
  CODELENS = "codeLensProvider",
  CODEACTIONS = "codeActionProvider",
  FORMATTING = "documentFormattingProvider",
  REFERENCES = "documentHighlightProvider",
  DEFINITION = "definitionProvider",
}

---@param client lsp.Client
---@param buf integer
local function setup_autocommands(client, buf)
  if client.server_capabilities[provider.FORMATTING] then
    augroup(("LspFormatting%d"):format(buf), {
      event = "BufWritePre",
      buffer = buf,
      desc = "LSP: Format on save",
      command = function(args)
        if not vim.g.formatting_disabled and not vim.b[buf].formatting_disabled then
          local clients = vim.tbl_filter(function(c)
            return c.server_capabilities[provider.FORMATTING]
          end, lsp.get_active_clients { buffer = buf })
          if #clients >= 1 then
            lsp.buf.format { bufnr = args.buf, async = #clients == 1 }
          end
        end
      end,
    })
  end

  if client.server_capabilities[provider.CODELENS] then
    augroup(("LspCodeLens%d"):format(buf), {
      event = { "BufEnter", "InsertLeave", "BufWritePost" },
      desc = "LSP: Code Lens",
      buffer = buf,
      -- call via vimscript so that errors are silenced
      command = "silent! lua vim.lsp.codelens.refresh()",
    })
  end

  if client.server_capabilities[provider.REFERENCES] then
    augroup(("LspReferences%d"):format(buf), {
      event = { "CursorHold", "CursorHoldI" },
      buffer = buf,
      desc = "LSP: References",
      command = function()
        lsp.buf.document_highlight()
      end,
    }, {
      event = "CursorMoved",
      desc = "LSP: References Clear",
      buffer = buf,
      command = function()
        lsp.buf.clear_references()
      end,
    })
  end
end

----------------------------------------------------------------------------------------------------
--  Related Locations
----------------------------------------------------------------------------------------------------
-- This relates to:
-- 1. https://github.com/neovim/neovim/issues/19649#issuecomment-1327287313
-- 2. https://github.com/neovim/neovim/issues/22744#issuecomment-1479366923
-- neovim does not currently correctly report the related locations for diagnostics.
-- TODO: once a PR for this is merged delete this workaround

local function show_related_locations(diag)
  local related_info = diag.relatedInformation
  if not related_info or #related_info == 0 then
    return diag
  end
  for _, info in ipairs(related_info) do
    diag.message = ("%s\n%s(%d:%d)%s"):format(
      diag.message,
      fn.fnamemodify(vim.uri_to_fname(info.location.uri), ":p:."),
      info.location.range.start.line + 1,
      info.location.range.start.character + 1,
      not mw.falsy(info.message) and (": %s"):format(info.message) or ""
    )
  end
  return diag
end

local handler = lsp.handlers["textDocument/publishDiagnostics"]
---@diagnostic disable-next-line: duplicate-set-field
lsp.handlers["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
  result.diagnostics = vim.tbl_map(show_related_locations, result.diagnostics)
  handler(err, result, ctx, config)
end

-----------------------------------------------------------------------------//
-- Mappings
-----------------------------------------------------------------------------//
local function prev_diagnostic(lvl)
  return function()
    diagnostic.goto_prev { float = true, severity = { min = lvl } }
  end
end
local function next_diagnostic(lvl)
  return function()
    diagnostic.goto_next { float = true, severity = { min = lvl } }
  end
end

---Setup mapping when an lsp attaches to a buffer
---@param client lsp.Client
---@param bufnr integer
local function setup_mappings(client, bufnr)
  local mappings = {
    { "n", "]d", prev_diagnostic(), desc = "go to prev diagnostic" },
    { "n", "[d", next_diagnostic(), desc = "go to next diagnostic" },
    { { "n", "x" }, "<leader>la", lsp.buf.code_action, desc = "code action", capability = provider.CODEACTIONS },
    { "n", "<leader>lf", lsp.buf.format, desc = "format buffer", capability = provider.FORMATTING },
    -- stylua: ignore
    { 'n', 'gd', lsp.buf.definition, desc = 'definition', capability = provider.DEFINITION, exclude = { 'typescript', 'typescriptreact' } },
    { "n", "gr", lsp.buf.references, desc = "references", capability = provider.REFERENCES },
    { "n", "K", lsp.buf.hover, desc = "hover", capability = provider.HOVER },
    { "n", "gI", lsp.buf.incoming_calls, desc = "incoming calls" }, -- TODO: what provider is this?
    { "n", "gi", lsp.buf.implementation, desc = "implementation" }, -- TODO: what provider is this?
    { "n", "<leader>gd", lsp.buf.type_definition, desc = "go to type definition", capability = provider.DEFINITION },
    { "n", "<leader>cl", lsp.codelens.run, desc = "run code lens", capability = provider.CODELENS },
    { "n", "<leader>lr", lsp.buf.rename, desc = "rename", capability = provider.RENAME },
  }

  mw.foreach(function(m)
    if
      (not m.exclude or not vim.tbl_contains(m.exclude, vim.bo[bufnr].ft))
      and (not m.capability or client.server_capabilities[m.capability])
    then
      map(m[1], m[2], m[3], { buffer = bufnr, desc = fmt("lsp: %s", m.desc) })
    end
  end, mappings)
end

-----------------------------------------------------------------------------//
-- LSP SETUP/TEARDOWN
-----------------------------------------------------------------------------//

---@alias ClientOverrides {on_attach: fun(client: lsp.Client, bufnr: number), semantic_tokens: fun(bufnr: number, client: lsp.Client, token: table)}

--- A set of custom overrides for specific lsp clients
--- This is a way of adding functionality for specific lsps
--- without putting all this logic in the general on_attach function
---@type {[string]: ClientOverrides}
local client_overrides = {
  tsserver = {
    semantic_tokens = function(bufnr, client, token)
      if token.type == "variable" and token.modifiers["local"] and not token.modifiers.readonly then
        lsp.semantic_tokens.highlight_token(token, bufnr, client.id, "@danger")
      end
    end,
  },

  -- rust_analyzer = {
  --   server = {
  --
  --     on_attach = function(_, bufnr)
  --       vim.keymap.set("n", "<Leader>rr", "<CMD>RustRunnables<CR>", { buffer = bufnr })
  --       vim.keymap.set("n", "<C-k>", "<CMD>RustHoverActions<CR>", { buffer = bufnr })
  --     end,
  --
  --     -- standalone file support
  --     -- setting it to false may improve startup time
  --     standalone = false,
  --
  --     settings = {
  --       -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
  --       ["rust-analyzer"] = {
  --         cargo = {
  --           features = "all",
  --         },
  --         checkOnSave = true,
  --         check = {
  --           command = "check",
  --           features = "all",
  --         },
  --         procMacro = {
  --           enable = true,
  --         },
  --       },
  --     },
  --   },
  -- },
}

---@param client lsp.Client
---@param bufnr number
local function setup_semantic_tokens(client, bufnr)
  local overrides = client_overrides[client.name]
  if not overrides or not overrides.semantic_tokens then
    return
  end
  augroup(fmt("LspSemanticTokens%s", client.name), {
    event = "LspTokenUpdate",
    buffer = bufnr,
    desc = fmt("Configure the semantic tokens for the %s", client.name),
    command = function(args)
      overrides.semantic_tokens(args.buf, client, args.data.token)
    end,
  })
end

-- Add buffer local mappings, autocommands etc for attaching servers
-- this runs for each client because they have different capabilities so each time one
-- attaches it might enable autocommands or mappings that the previous client did not support
---@param client lsp.Client the lsp client
---@param bufnr number
local function on_attach(client, bufnr)
  setup_autocommands(client, bufnr)
  setup_mappings(client, bufnr)
  setup_semantic_tokens(client, bufnr)
end

augroup("LspSetupCommands", {
  event = "LspAttach",
  desc = "setup the language server autocommands",
  command = function(args)
    local client = lsp.get_client_by_id(args.data.client_id)
    if not client then
      return
    end
    on_attach(client, args.buf)
    local overrides = client_overrides[client.name]
    if not overrides or not overrides.on_attach then
      return
    end
    overrides.on_attach(client, args.buf)
  end,
}, {
  event = "DiagnosticChanged",
  desc = "Update the diagnostic locations",
  command = function(args)
    diagnostic.setloclist { open = false }
    if #args.data.diagnostics == 0 then
      vim.cmd "silent! lclose"
    end
  end,
})

---@param on_attach function
function mw.lsp.custom_on_attach(on_attach)
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local buffer = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      on_attach(client, buffer)
    end,
  })
end

-----------------------------------------------------------------------------//
-- Commands
-----------------------------------------------------------------------------//

command("LspFormat", function()
  lsp.buf.format { bufnr = 0, async = false }
end)

-----------------------------------------------------------------------------//
-- Signs
-----------------------------------------------------------------------------//

---@param opts {highlight: string, icon: string}
local function sign(opts)
  fn.sign_define(opts.highlight, {
    text = opts.icon,
    texthl = opts.highlight,
    numhl = opts.highlight .. "Nr" or nil,
    culhl = opts.highlight .. "CursorNr" or nil,
    linehl = opts.highlight .. "Line" or nil,
  })
end

sign { highlight = "DiagnosticSignError", icon = icons.error }
sign { highlight = "DiagnosticSignWarn", icon = icons.warn }
sign { highlight = "DiagnosticSignInfo", icon = icons.info }
sign { highlight = "DiagnosticSignHint", icon = icons.hint }
-----------------------------------------------------------------------------//
-- Handler Overrides
-----------------------------------------------------------------------------//
-- This section overrides the default diagnostic handlers for signs and virtual text so that only
-- the most severe diagnostic is shown per line

--- The custom namespace is so that ALL diagnostics across all namespaces can be aggregated
--- including diagnostics from plugins
local ns = api.nvim_create_namespace "severe-diagnostics"

--- Restricts nvim's diagnostic signs to only the single most severe one per line
--- see `:help vim.diagnostic`
---@param callback fun(namespace: integer, bufnr: integer, diagnostics: table, opts: table)
---@return fun(namespace: integer, bufnr: integer, diagnostics: table, opts: table)
local function max_diagnostic(callback)
  return function(_, bufnr, diagnostics, opts)
    local max_severity_per_line = mw.fold(function(diag_map, d)
      local m = diag_map[d.lnum]
      if not m or d.severity < m.severity then
        diag_map[d.lnum] = d
      end
      return diag_map
    end, diagnostics, {})
    callback(ns, bufnr, vim.tbl_values(max_severity_per_line), opts)
  end
end

local signs_handler = diagnostic.handlers.signs
diagnostic.handlers.signs = vim.tbl_extend("force", signs_handler, {
  show = max_diagnostic(signs_handler.show),
  hide = function(_, bufnr)
    signs_handler.hide(ns, bufnr)
  end,
})
-----------------------------------------------------------------------------//
-- Diagnostic Configuration
-----------------------------------------------------------------------------//
local max_width = math.min(math.floor(vim.o.columns * 0.7), 100)
local max_height = math.min(math.floor(vim.o.lines * 0.3), 30)

diagnostic.config {
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  signs = {
    severity = { min = S.WARN },
  },
  virtual_text = true and {
    severity = { min = S.WARN },
    spacing = 1,
    prefix = "",
    format = function(d)
      local level = diagnostic.severity[d.severity]
      return fmt("%s %s", icons[level:lower()], d.message)
    end,
  },
  float = {
    max_width = max_width,
    max_height = max_height,
    border = border,
    title = { { "  ", "DiagnosticFloatTitleIcon" }, { "Problems  ", "DiagnosticFloatTitle" } },
    focusable = true,
    scope = "cursor",
    source = "if_many",
    prefix = function(diag)
      local level = diagnostic.severity[diag.severity]
      local prefix = fmt("%s ", icons[level:lower()])
      return prefix, "Diagnostic" .. level:gsub("^%l", string.upper)
    end,
  },
}
