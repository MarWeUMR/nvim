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

--- Opens the current quickfix entry in a new buffer, marks it, and removes it from the quickfix list.
--- This mapping function does the following:
vim.keymap.set("n", "<M-o>", function()
  -- Save window ID of the quickfix window
  local initial_win_id = vim.api.nvim_get_current_win()

  -- Open the current quickfix entry in a new buffer
  require("bqf.qfwin.handler").open(false)

  -- Store the window ID of the newly opened buffer
  local secondary_win_id = vim.api.nvim_get_current_win()

  -- Bring the cursor back to the quickfix window
  vim.api.nvim_set_current_win(initial_win_id)

  -- Mark the opened entry in the quickfix window
  require("bqf.qfwin.handler").signToggle(1)

  -- Create a new quickfix list without the opened entry
  require("bqf.filter.base").run(true)

  -- Now jump back to the opened entry
  vim.api.nvim_set_current_win(secondary_win_id)

  -- Close the quickfix wincmd
  vim.api.nvim_command("cclose")
end, { desc = "open and delete current quickfix entry", buffer = 0 })

-- force quickfix to open beneath all other splits
vim.cmd.wincmd("J")
as.adjust_split_height(3, 10)
