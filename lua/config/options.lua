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

-- Make the clipboard work with SSH_TTY
local function my_paste(reg)
  return function(lines)
    local content = vim.fn.getreg('"')
    return vim.split(content, "\n")
  end
end

if os.getenv("SSH_TTY") then
  vim.opt.clipboard:append("unnamedplus")
  vim.g.clipboard = {
    name = "OSC 52",
    copy = {
      ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
      ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
    },
    paste = {
      ["+"] = my_paste("+"),
      ["*"] = my_paste("*"),
    },
  }
end
