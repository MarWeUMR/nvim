local o = vim.opt
local g = vim.g
local v = vim.v
local fn = vim.fn
local api = vim.api
local cmd = vim.cmd

local M = {}
_G.StatusColumn = M

function M.get_signs()
  local buf = api.nvim_win_get_buf(g.statusline_winid)
  return vim.tbl_map(function(sign)
    return vim.fn.sign_getdefined(sign.name)[1]
  end, vim.fn.sign_getplaced(buf, { group = "*", lnum = vim.v.lnum })[1].signs)
end

function M.fold_handler()
  local lnum = fn.getmousepos().line

  -- Only lines with a mark should be clickable
  if fn.foldlevel(lnum) <= fn.foldlevel(lnum - 1) then
    return
  end

  local state
  if fn.foldclosed(lnum) == -1 then
    state = "close"
  else
    state = "open"
  end

  cmd.execute("'" .. lnum .. "fold" .. state .. "'")
end

function M.fold_display()
  if v.wrap then
    return ""
  end

  local lnum = v.lnum
  local icon = "  "

  -- Line isn't in folding range
  if fn.foldlevel(lnum) <= 0 then
    return icon
  end

  -- Not the first line of folding range
  if fn.foldlevel(lnum) <= fn.foldlevel(lnum - 1) then
    return icon
  end

  if fn.foldclosed(lnum) == -1 then
    icon = Icons.misc.expanded
  else
    icon = Icons.misc.collapsed
  end

  return icon
end

function M.column()
  local sign, git_sign

  local x = M.get_signs()

  for _, s in ipairs(x) do
    if s.name:find("GitSign") then
      git_sign = s
    else
      sign = s
    end
  end

  -- TODO: make this configurable
  -- 1. spacing before line numbers seems to roomy
  -- 2. only show folds where more lines would be folded
  -- 3. icon size changes when the cursor is in the line (sometimes?)
  local components = {
    git_sign and ("%#" .. git_sign.texthl .. "#" .. git_sign.text:gsub("%s", "") .. "%*") or "%{&nu?(' '):''}",
    sign and ("%#" .. sign.texthl .. "#" .. sign.text:gsub("%s", "") .. "%*") or "%{&nu?(' '):''}",
    [[%=%{&nu?(&rnu&&v:relnum?v:relnum:v:lnum):''}]],
    [[%#StatusColumnBuffer#]], -- Highlight group name
    [[%{&nu?(' '):''}]],
    [[%#FoldColumn#%@v:lua.StatusColumn.fold_handler@%{&nu?(v:lua.StatusColumn.fold_display()):''}]],
    [[%{&nu?(' '):''}]],
    [[%{&nu?(' '):''}]],
  }
  return table.concat(components, "")
end

if vim.v.virtnum then
  o.statuscolumn = [[%!v:lua.StatusColumn.column()]]
end

return M
