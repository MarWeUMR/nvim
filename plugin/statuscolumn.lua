if not mw then
  return
end

local fn, v, api, optl = vim.fn, vim.v, vim.api, vim.opt_local
local ui, separators, falsy = mw.styles, mw.styles.icons.separators, mw.falsy
local str = require "mw.strings"

local SIGN_COL_WIDTH, GIT_COL_WIDTH, space = 2, 1, " "
local shade, separator = separators.light_shade_block, separators.left_thin_block -- '│'
local sep_hl = "StatusColSep"

---@param win number
---@param line_count number
---@return string
local function nr(win, line_count)
  local col_width = api.nvim_strwidth(tostring(line_count))
  local padding = string.rep(space, col_width - 1)
  if v.virtnum < 0 then
    return padding .. shade
  end -- virtual line
  if v.virtnum > 0 then
    return padding .. space
  end -- wrapped line
  local num = vim.wo[win].relativenumber and not falsy(v.relnum) and v.relnum or v.lnum
  if line_count >= 1000 then
    col_width = col_width + 1
  end
  local lnum = fn.substitute(num, "\\d\\zs\\ze\\%(\\d\\d\\d\\)\\+$", ",", "g")
  local num_width = col_width - api.nvim_strwidth(lnum)
  return string.rep(space, num_width) .. lnum
end

---@param curbuf integer
---@return StringComponent[] sgns non-git signs
local function signplaced_signs(curbuf)
  local sgns = vim.tbl_map(function(sign)
    local s = fn.sign_getdefined(sign.name)[1]
    local text = s.text:gsub("%s", "")
    if #text < 4 then
      return { { { text, s.texthl } }, before = " " }
    else
      return { { { text, s.texthl } }, after = "" }
    end
  end, fn.sign_getplaced(curbuf, { group = "*", lnum = v.lnum })[1].signs)

  while #sgns < SIGN_COL_WIDTH do
    table.insert(sgns, str.spacer(1))
  end
  return sgns
end

---@param curbuf integer
---@return StringComponent[]
local function extmark_signs(curbuf)
  local lnum = v.lnum - 1
  ---@type {[1]: number, [2]: number, [3]: number, [4]: {sign_text: string, sign_hl_group: string}}
  local g_signs = api.nvim_buf_get_extmarks(curbuf, -1, { lnum, 0 }, { lnum, -1 }, { details = true, type = "sign" })
  local sns = mw.map(function(item)
    return { { { item[4].sign_text:gsub("%s", ""), item[4].sign_hl_group } }, after = "" }
  end, g_signs)
  while #sns < GIT_COL_WIDTH do
    table.insert(sns, str.spacer(1))
  end
  return sns
end

function ui.statuscolumn.render()
  local curwin = api.nvim_get_current_win()
  local curbuf = api.nvim_win_get_buf(curwin)
  local gitsign, sns = extmark_signs(curbuf), signplaced_signs(curbuf)

  local line_count = api.nvim_buf_line_count(curbuf)
  local is_absolute_lnum = v.virtnum >= 0 and falsy(v.relnum)
  local separator_hl = is_absolute_lnum and sep_hl or nil

  -----------------------------------------------------------------------------//
  -- INITIALIZE STATUSCOLUMN
  -----------------------------------------------------------------------------//
  local statuscol = {}
  local add = str.append(statuscol)

  -----------------------------------------------------------------------------//
  -- FIRST COMPONENT
  -----------------------------------------------------------------------------//
  add(unpack(sns))

  -----------------------------------------------------------------------------//
  -- SECOND COMPONENT
  -----------------------------------------------------------------------------//
  add { { { nr(curwin, line_count) } } }

  -----------------------------------------------------------------------------//
  -- THIRD COMPONENT: GIT SIGNS, CURSORLINE AND SEPARATOR
  -----------------------------------------------------------------------------//
  local is_current_line = v.lnum == fn.line "."

  -- iterate over the gitsigns and decide, based on what gitsign would be shown in the given line,
  -- how the separator should be colored
  if gitsign then
    for _, g in ipairs(gitsign) do
      local git_hl = g[1][1][2]
      if git_hl then
        if git_hl:match "GitSignsAdd" then
          separator_hl = "GitSignsAdd"
        elseif git_hl:match "GitSignsDelete" then
          separator_hl = "GitSignsDelete"
        elseif git_hl:match "GitSignsChange" then
          separator_hl = "GitSignsChange"
        end
      end
    end
  end

  if is_current_line then
    separator_hl = "StatusColSepCurrentLine"
  end

  add { { { separator, separator_hl } }, after = "" }

  -----------------------------------------------------------------------------//
  -- FORTH COMPONENT: SPACER BETWEEN SEPARATOR AND CODE
  -----------------------------------------------------------------------------//
  add(str.spacer(1))

  return str.display { {}, statuscol }
end

vim.o.statuscolumn = "%{%v:lua.mw.styles.statuscolumn.render()%}"

mw.augroup("StatusCol", {
  event = { "BufEnter", "FileType" },
  command = function(args)
    local decor = ui.decorations.get {
      ft = vim.bo[args.buf].ft,
      fname = fn.bufname(args.buf),
      setting = "statuscolumn",
    }
    if decor.ft == false or decor.fname == false then
      optl.statuscolumn = ""
    end
  end,
})
