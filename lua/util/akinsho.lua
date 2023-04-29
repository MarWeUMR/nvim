local M = {}

local fn, api, cmd, fmt = vim.fn, vim.api, vim.cmd, string.format
local l = vim.log.levels
local root_patterns = { ".git", "lua" }

--- Convert a list or map of items into a value by iterating all it's fields and transforming
--- them with a callback
---@generic T, S
---@param callback fun(acc: S, item: T, key: string | number): S
---@param list T[]
---@param accum S?
---@return S
function M.fold(callback, list, accum)
  accum = accum or {}
  for k, v in pairs(list) do
    accum = callback(accum, v, k)
    assert(accum ~= nil, "The accumulator must be returned on each iteration")
  end
  return accum
end

--- Call the given function and use `vim.notify` to notify of any errors
--- this function is a wrapper around `xpcall` which allows having a single
--- error handler for all errors
---@param msg string
---@param func function
---@param ... any
---@return boolean, any
---@overload fun(func: function, ...): boolean, any
function M.pcall(msg, func, ...)
  local args = { ... }
  if type(msg) == "function" then
    local arg = func --[[@as any]]
    args, func, msg = { arg, unpack(args) }, msg, nil
  end
  return xpcall(func, function(err)
    msg = debug.traceback(msg and fmt("%s:\n%s", msg, err) or err)
    vim.schedule(function()
      vim.notify(msg, l.ERROR, { title = "ERROR" })
    end)
  end, unpack(args))
end

---@generic T:table
---@param callback fun(item: T, key: any)
---@param list table<any, T>
function M.foreach(callback, list)
  for k, v in pairs(list) do
    callback(v, k)
  end
end

local autocmd_keys = { "event", "buffer", "pattern", "desc", "command", "group", "once", "nested" }
--- Validate the keys passed to mw.augroup are valid
---@param name string
---@param command Autocommand
local function validate_autocmd(name, command)
  local incorrect = M.fold(function(accum, _, key)
    if not vim.tbl_contains(autocmd_keys, key) then
      table.insert(accum, key)
    end
    return accum
  end, command, {})

  if #incorrect > 0 then
    vim.schedule(function()
      local msg = "Incorrect keys: " .. table.concat(incorrect, ", ")
      vim.notify(msg, "error", { title = fmt("Autocmd: %s", name) })
    end)
  end
end

---Create an autocommand
---returns the group ID so that it can be cleared or manipulated.
---@param name string The name of the autocommand group
---@param ... Autocommand A list of autocommands to create
---@return number
function M.augroup(name, ...)
  local commands = { ... }
  assert(name ~= "User", "The name of an augroup CANNOT be User")
  assert(#commands > 0, fmt("You must specify at least one autocommand for %s", name))
  local id = api.nvim_create_augroup(name, { clear = true })
  for _, autocmd in ipairs(commands) do
    validate_autocmd(name, autocmd)
    local is_callback = type(autocmd.command) == "function"
    api.nvim_create_autocmd(autocmd.event, {
      group = name,
      pattern = autocmd.pattern,
      desc = autocmd.desc,
      callback = is_callback and autocmd.command or nil,
      command = not is_callback and autocmd.command or nil,
      once = autocmd.once,
      nested = autocmd.nested,
      buffer = autocmd.buffer,
    })
  end
  return id
end

--- Require when an exported method is called.
---
--- Creates a new function. Cannot be used to compare functions,
--- set new values, etc. Only useful for waiting to do the require until you actually
--- call the code.
---
--- ```lua
--- -- This is not loaded yet
--- local lazy_mod = lazy.require_on_exported_call('my_module')
--- local lazy_func = lazy_mod.exported_func
---
--- -- ... some time later
--- lazy_func(42)  -- <- Only loads the module now
---
--- ```
---@param require_path string
---@return table<string, fun(...): any>
function M.reqcall(require_path)
  return setmetatable({}, {
    __index = function(_, k)
      return function(...)
        return require(require_path)[k](...)
      end
    end,
  })
end

function M.toggle_diagnostics()
  local diagnostics_on = require("lsp_lines").toggle()
  if diagnostics_on then
    vim.diagnostic.config({
      virtual_lines = true,
      virtual_text = false,
    })
  else
    vim.diagnostic.config({
      virtual_text = { spacing = 4, prefix = "●" },
      virtual_lines = false,
    })
  end
end

--- Autosize horizontal split to match its minimum content
--- https://vim.fandom.com/wiki/Automatically_fitting_a_quickfix_window_height
---@param min_height number
---@param max_height number
function M.adjust_split_height(min_height, max_height)
  api.nvim_win_set_height(0, math.max(math.min(fn.line("$"), max_height), min_height))
end

---------------------------------------------------------------------------------
-- Quickfix and Location List
---------------------------------------------------------------------------------

M.list = { qf = {}, loc = {} }

---@param list_type "loclist" | "quickfix"
---@return boolean
local function is_list_open(list_type)
  return M.find(function(win)
    return not M.falsy(win[list_type])
  end, fn.getwininfo()) ~= nil
end

local silence = { mods = { silent = true, emsg_silent = true } }

---@param callback fun(...)
local function preserve_window(callback, ...)
  local win = api.nvim_get_current_win()
  callback(...)
  if win ~= api.nvim_get_current_win() then
    cmd.wincmd("p")
  end
end

function M.list.qf.toggle()
  if is_list_open("quickfix") then
    cmd.cclose(silence)
  elseif #fn.getqflist() > 0 then
    preserve_window(cmd.copen, silence)
  end
end

function M.list.loc.toggle()
  if is_list_open("loclist") then
    cmd.lclose(silence)
  elseif #fn.getloclist(0) > 0 then
    preserve_window(cmd.lopen, silence)
  end
end

-- @see: https://vi.stackexchange.com/a/21255
-- using range-aware function
function M.list.qf.delete(buf)
  buf = buf or api.nvim_get_current_buf()

  vim.bo.modifiable = true
  local list = fn.getqflist()
  local line = api.nvim_win_get_cursor(0)[1]
  if api.nvim_get_mode().mode:match("[vV]") then
    local first_line = fn.getpos("'<")[2]
    local last_line = fn.getpos("'>")[2]
    list = M.fold(function(accum, item, i)
      if i < first_line or i > last_line then
        accum[#accum + 1] = item
      end
      return accum
    end, list)
  else
    table.remove(list, line)
  end
  -- replace items in the current list, do not make a new copy of it; this also preserves the list title
  fn.setqflist({}, "r", { items = list })
  fn.setpos(".", { buf, line, 1, 0 }) -- restore current line
end

--- Get a list of changed files in the current Git repository.
--
-- This function returns a list of file paths for all changed files in the
-- current Git repository. The list is generated by running the `git diff
-- --name-only` command.
--
-- @return table A list of changed files as strings.
function M.get_changed_files()
  local output = vim.fn.systemlist("git diff --name-only")
  local changed_files = {}

  if vim.v.shell_error == 0 then
    for _, file in ipairs(output) do
      table.insert(changed_files, file)
    end
  end

  return changed_files
end

return M
