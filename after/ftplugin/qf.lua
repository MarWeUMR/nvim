local as = require("util.akinsho")

local opt = vim.opt_local

opt.wrap = false
opt.number = false
opt.signcolumn = "yes"
opt.buflisted = false
opt.winfixheight = true

vim.keymap.set("n", "<M-d>", function()
  require("bqf.qfwin.handler").signToggle(1)
  require("bqf.filter.base").run(true)
end, { desc = "delete current quickfix entry", buffer = 0 })
-- vim.keymap.set("v", "d", as.list.qf.delete, { desc = "delete selected quickfix entry", buffer = 0 })
-- vim.keymap.set("n", "H", ":colder<CR>", { buffer = 0 })
-- vim.keymap.set("n", "L", ":cnewer<CR>", { buffer = 0 })
-- force quickfix to open beneath all other splits
vim.cmd.wincmd("J")
as.adjust_split_height(3, 10)
