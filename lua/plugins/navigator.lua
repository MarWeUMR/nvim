local status_ok, navigator = pcall(require, "navigator")
if not status_ok then
  return
end


local path = require 'nvim-lsp-installer.path'
local install_root_dir = path.concat {vim.fn.stdpath 'data', 'lsp_servers'}

navigator.setup({

  lsp_installer = true,
  treesitter_analysis = true,
  default_mapping = false,
  keymaps = {
    { key = "<Space>lr", func = "require('navigator.rename').rename()" },
    { key = "<Space>la", func = "require('navigator.codeAction').code_action()" },
    { key = "<Space>lf", func = "formatting()" },
    { key = "<M-h>", func = "hover({ popup_opts = { border = single, max_width = 80 }})" },
    { key = "<Space>ll", func = "require('navigator.codelens').run_action()" },
    { key = "<Space>ld", func = "require('navigator.definition').definition_preview()" },
    { key = "<Space>lR", func = "require('navigator.reference').async_ref()" },
  },

  lsp_signature_help = true,

  lsp = {

    --  pyright = {
    --   cmd = { "/home/arch/.local/share/nvim/lsp_servers/python/node_modules/.bin/pyright-langserver", "--stdio" }
    -- },

    -- jedi_language_server = {
    --   cmd = { "/home/arch/.local/share/nvim/lsp_servers/jedi_language_server/venv/bin/jedi-language-server" }
    -- },

    disable_lsp = { 'denols', 'angularls', 'graphql', 'jedi_language_server', 'pyright', 'rust_analyzer', 'pylsp'},
    code_lens = true,
    code_action = { enable = true, sign = true, sign_priority = 40, virtual_text = true },
    code_lens_action = { enable = true, sign = true, sign_priority = 40, virtual_text = true },

    diagnostic = {
      underline = true,
      virtual_text = true, -- show virtual for diagnostic message
      update_in_insert = false, -- update diagnostic message in insert mode
    },


  },




})
