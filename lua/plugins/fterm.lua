local status_ok, fterm = pcall(require, "FTerm")
if not status_ok then
  return
end

fterm.setup({
  border = "double",
  dimensions = {
    height = 0.9,
    width = 0.9,
  },
})

local gitui = fterm:new({
  ft = "fterm_gitui", -- You can also override the default filetype, if you want
  cmd = "gitui",
  border = "double",
  dimensions = {
    height = 0.9,
    width = 0.9,
  },
})

-- Use this to toggle lazygit in a floating terminal
function _G.__fterm_gitui()
  gitui:toggle()
end
