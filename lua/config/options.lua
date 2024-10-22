-- ANSIBLE/YAML --------------------------------------------------------------
vim.filetype.add({
  extension = {
    yml = "yaml.ansible",
    http = "http",
  },
})

vim.o.pumblend = 0
vim.o.scrolloff = 8
