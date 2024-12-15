-- ANSIBLE/YAML --------------------------------------------------------------
vim.filetype.add({
  extension = {
    yml = "yaml.ansible",
    http = "http",
  },
})

vim.diagnostic.config({
  -- add the source of the diagnostic to the displayed message
  -- float = {
  --   source = "always",
  -- },

  -- for tiny inline diagnostics
  virtual_text = false,
})

vim.o.pumblend = 0
vim.o.scrolloff = 8

-- vim.o.spelllang = "en_us,de_de"
vim.o.spelllang = ""

vim.g.ai_cmp = false
-- vim.g.lazyvim_php_lsp = "intelephense"
