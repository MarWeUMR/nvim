if not mw then
  return
end

-- Imports
local fn, v, api, optl = vim.fn, vim.v, vim.api, vim.opt_local
local separators = mw.styles.icons.separators
local falsy = mw.falsy
local str = require "mw.strings"

-- Constants
local GIT_COL_WIDTH, space = 1, " "
local shade, separator = separators.light_shade_block, separators.left_thin_block -- '│'
local sep_hl = "StatusColSep"

-- Caches
local git_signs_cache = {}
local diagnostics_cache = {}

-- Functions

--- Line numbering
---@param win number
---@param line_count number
---@return string
local function format_line_number(win, line_count)
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

-- get the diagnostc highlight group based on the severity level
local function get_diagnostic_highlight(severity)
  local diagnosticHighlight = {
    error = "DiagnosticError",
    warn = "DiagnosticWarn",
    info = "DiagnosticInfo",
    hint = "DiagnosticHint",
  }

  if severity == 1 then
    return diagnosticHighlight.error
  elseif severity == 2 then
    return diagnosticHighlight.warn
  elseif severity == 3 then
    return diagnosticHighlight.info
  elseif severity == 4 then
    return diagnosticHighlight.hint
  else
    return " "
  end
end

local function get_icon(severity)
  local icons = {
    error = "🔥",
    warn = " ",
    info = " ",
    hint = " ",
  }

  if severity == 1 then
    return icons.error
  elseif severity == 2 then
    return icons.warn
  elseif severity == 3 then
    return icons.info
  elseif severity == 4 then
    return icons.hint
  else
    return " "
  end
end

-- performance tweeks
local timer = nil

-- this is used to delay the update intervall of the diagnostic signs a little bit
local function debounce(func, delay)
  if timer then
    vim.fn.timer_stop(timer)
    timer = nil
  end

  timer = vim.fn.timer_start(delay, function()
    func()
    timer = nil
  end)
end

--- Diagnostics
---@param curbuf integer
---@return StringComponent[] sgns non-git signs
local function update_diagnostics(curbuf)
  if diagnostics_cache[curbuf] then
    return diagnostics_cache[curbuf]
  end

  local sgns = {}
  local lnum = vim.v.lnum - 1

  -- Get the diagnostics for the current buffer and line
  local diagnostics = vim.diagnostic.get(curbuf, { lnum = lnum })

  -- Loop over each diagnostic and add the first one found to the `sgns` table in the desired format
  for _, diagnostic in ipairs(diagnostics) do
    local icon = get_icon(diagnostic.severity)
    -- local icon = icons[diagnostic.severity]
    if icon ~= nil then
      local highlight_group = get_diagnostic_highlight(diagnostic.severity)
      table.insert(sgns, {
        { { icon .. " ", highlight_group } },
        after = "",
        hl = highlight_group,
      })
      break
    end
  end -- Add a space character to `sgns` if no diagnostics were found
  if #sgns == 0 then
    table.insert(sgns, str.spacer(1))
  end

  diagnostics_cache[curbuf] = sgns
  return sgns
end

-- get the diagnostic signs with delay
local function get_diagnostics(curbuf)
  return debounce(function()
    return update_diagnostics(curbuf)
  end, 200)
end

-- Invalidate cache on events
mw.augroup("StatusColCache", {
  event = { "BufWritePost", "BufEnter", "CursorMoved", "TextChanged", "InsertLeave" },
  command = function(args)
    git_signs_cache[args.buf] = nil
  end,
})

--- Git signs
---@param curbuf integer
---@return StringComponent[]
local function get_git_signs(curbuf)
  if git_signs_cache[curbuf] then
    return git_signs_cache[curbuf]
  end

  local lnum = v.lnum - 1
  ---@type {[1]: number, [2]: number, [3]: number, [4]: {sign_text: string, sign_hl_group: string}}
  local g_signs = api.nvim_buf_get_extmarks(curbuf, -1, { lnum, 0 }, { lnum, -1 }, { details = true, type = "sign" })
  local sns = mw.map(function(item)
    return { { { item[4].sign_text:gsub("%s", ""), item[4].sign_hl_group } }, after = "" }
  end, g_signs)
  while #sns < GIT_COL_WIDTH do
    table.insert(sns, str.spacer(1))
  end

  git_signs_cache[curbuf] = sns

  return sns
end

--- Rendering status column
function mw.styles.statuscolumn.render()
  -- define separator colors for gitsigns
  vim.cmd "highlight StatusColSepCurrentLine guifg=#ff55de "

  local curwin = api.nvim_get_current_win()
  local curbuf = api.nvim_win_get_buf(curwin)
  local gitsign = get_git_signs(curbuf)

  local line_count = api.nvim_buf_line_count(curbuf)
  local is_absolute_lnum = v.virtnum >= 0 and falsy(v.relnum)
  local separator_hl = is_absolute_lnum and sep_hl or nil

  local statuscol = {}
  local add = str.append(statuscol)
  local sns = get_diagnostics(curbuf)

  -- first component: diagnostic signs or spacer
  add(unpack(sns)) -- todo: implement diagnostic signs

  -- second component: line numbering
  add { { { format_line_number(curwin, line_count) } } }

  -- third component: git signs, cursorline and separator
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
  -- end third component

  -- forth component: spacer between separator and code
  add(str.spacer(1))

  return str.display { {}, statuscol }
end

vim.o.statuscolumn = "%{%v:lua.mw.styles.statuscolumn.render()%}"

mw.augroup("StatusCol", {
  event = { "BufEnter", "FileType" },
  command = function(args)
    local decor = mw.styles.decorations.get {
      ft = vim.bo[args.buf].ft,
      fname = fn.bufname(args.buf),
      setting = "statuscolumn",
    }
    if decor.ft == false or decor.fname == false then
      optl.statuscolumn = ""
    end
  end,
})
