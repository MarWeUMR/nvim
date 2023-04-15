----------------------------------------------------------------------------------------------------
--  FORMAT STRINGS
----------------------------------------------------------------------------------------------------
-- This is essentially a small library (for me) for working with vim format strings for things
-- like the tabline, statusline, winbar and statuscolumn. Since there are so many things that work
-- this way one small library to create these strings is useful.

local api, L = vim.api, vim.log.levels
local strwidth, fmt, falsy = api.nvim_strwidth, string.format, mw.falsy

---@alias StringComponent {component: string, length: integer, priority: integer}

local M = {}

local CLICK_END = "%X"
local padding = " "

----------------------------------------------------------------------------------------------------
-- COMPONENTS
----------------------------------------------------------------------------------------------------

---@return StringComponent
local function separator()
  return { component = "%=", length = 0, priority = 0 }
end

---@param func_name string
---@param id string
---@return string
local function get_click_start(func_name, id)
  if not id then
    vim.schedule(function()
      local msg = fmt("An ID is needed to enable click handler %s to work", func_name)
      vim.notify_once(msg, L.ERROR, { title = "Statusline" })
    end)
    return ""
  end
  return ("%%%d@%s@"):format(id, func_name)
end

--- Creates a spacer statusline component i.e. for padding
--- or to represent an empty component
--- @param size integer?
--- @param opts table<string, any>?
--- @return ComponentOpts?
function M.spacer(size, opts)
  opts = opts or {}
  local filler = opts.filler or " "
  local priority = opts.priority or 0
  if not size or size < 1 then
    return
  end
  local spacer = string.rep(filler, size)
  return { { { spacer } }, priority = priority, before = "", after = "" }
end

--- truncate with an ellipsis or if surrounded by quotes, replace contents of quotes with ellipsis
--- @param str string
--- @param max_size integer
--- @return string
local function truncate_str(str, max_size)
  if not max_size or strwidth(str) < max_size then
    return str
  end
  local match, count = str:gsub("(['\"]).*%1", "%1…%1")
  return count > 0 and match or str:sub(1, max_size - 1) .. "…"
end

---@alias Chunks {[1]: string | number, [2]: string, max_size: integer?}[]

---@param chunks Chunks
---@return string
local function chunks_to_string(chunks)
  if not chunks or not vim.tbl_islist(chunks) then
    return ""
  end
  local strings = mw.fold(function(acc, item)
    local text, hl = unpack(item)
    if not falsy(text) then
      if type(text) == "number" then
        item = tostring(item)
      end
      if item.max_size then
        text = truncate_str(text, item.max_size)
      end
      table.insert(acc, not falsy(hl) and ("%%#%s#%s%%*"):format(hl, text) or text)
    end
    return acc
  end, chunks)
  return table.concat(strings)
end

--- @class ComponentOpts
--- @field [1] Chunks
--- @field priority number
--- @field click string
--- @field before string
--- @field after string
--- @field id number
--- @field max_size integer
--- @field cond boolean | number | table | string,

--- @param opts ComponentOpts
--- @return StringComponent?
local function component(opts)
  assert(opts, "component options are required")
  if opts.cond ~= nil and falsy(opts.cond) then
    return
  end

  local item = opts[1]
  assert(vim.tbl_islist(item), ("component options are required but got %s instead"):format(vim.inspect(item)))

  if not opts.priority then
    opts.priority = 10
  end
  local before, after = opts.before or "", opts.after or padding

  local item_str = chunks_to_string(item)
  if strwidth(item_str) == 0 then
    return
  end

  local click_start = opts.click and get_click_start(opts.click, tostring(opts.id)) or ""
  local click_end = opts.click and CLICK_END or ""
  local component_str = table.concat { click_start, before, item_str, after, click_end }
  return {
    component = component_str,
    length = api.nvim_eval_statusline(component_str, { maxwidth = 0 }).width,
    priority = opts.priority,
  }
end

----------------------------------------------------------------------------------------------------
-- RENDER
----------------------------------------------------------------------------------------------------
local function sum_lengths(list)
  return mw.fold(function(acc, item)
    return acc + (item.length or 0)
  end, list, 0)
end

local function is_lowest(item, lowest)
  -- if there hasn't been a lowest selected so far, then the item is the lowest
  if not lowest or not lowest.length then
    return true
  end
  -- if the item doesn't have a priority or a length, it is likely a special character so should never be the lowest
  if not item.priority or not item.length then
    return false
  end
  -- if the item has the same priority as the lowest, then if the item has a greater length it should become the lowest
  if item.priority == lowest.priority then
    return item.length > lowest.length
  end
  return item.priority > lowest.priority
end

--- Take the lowest priority items out of the statusline if we don't have
--- space for them.
--- TODO: currently this doesn't account for if an item that has a lower priority
--- could be fit in instead
--- @param statusline table
--- @param space number
--- @param length number
local function prioritize(statusline, space, length)
  length = length or sum_lengths(statusline)
  if length <= space then
    return statusline
  end
  local lowest, index_to_remove
  for idx, c in ipairs(statusline) do
    if is_lowest(c, lowest) then
      lowest, index_to_remove = c, idx
    end
  end
  table.remove(statusline, index_to_remove)
  return prioritize(statusline, space, length - lowest.length)
end

--- @param sections ComponentOpts[][]
--- @param available_space number?
--- @return string
function M.display(sections, available_space)
  local components = mw.fold(function(acc, section, count)
    if #section == 0 then
      table.insert(acc, separator())
      return acc
    end
    mw.foreach(function(args, index)
      if not args then
        return
      end
      local ok, str = mw.pcall(("Error creating component: %s"):format(vim.inspect(args)), component, args)
      if not ok then
        return
      end
      table.insert(acc, str)
      if #section == index and count ~= #sections then
        table.insert(acc, separator())
      end
    end, section)
    return acc
  end, sections)

  local items = available_space and prioritize(components, available_space) or components
  local str = vim.tbl_map(function(item)
    return item.component
  end, items)
  return table.concat(str)
end

---Aggregate pieces of the statusline
---@param tbl StringComponent[]
---@return fun(...:ComponentOpts)
function M.append(tbl)
  return function(...)
    for i = 1, select("#", ...) do
      local item = select(i, ...)
      if item then
        tbl[#tbl + 1] = item
      end
    end
  end
end

return M
