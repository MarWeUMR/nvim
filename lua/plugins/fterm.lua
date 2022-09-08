local status_ok, fterm = pcall(require, "FTerm")
if not status_ok then
  return
end

fterm.setup({
  border = "single",
  dimensions = {
    height = 0.9,
    width = 0.9,
  },
})

local lazygit = fterm:new({
  ft = "fterm_lazygit", -- You can also override the default filetype, if you want
  cmd = "lazygit",
  border = "double",
  dimensions = {
    height = 0.9,
    width = 0.9,
  },
})

-- Use this to toggle lazygit in a floating terminal
function _G.__fterm_lazygit()
  lazygit:toggle()
end
