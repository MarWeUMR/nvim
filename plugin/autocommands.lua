if not mw then
  return
end

local fn, api, v, env, cmd, fmt = vim.fn, vim.api, vim.v, vim.env, vim.cmd, string.format

----------------------------------------------------------------------------------------------------
-- HLSEARCH
----------------------------------------------------------------------------------------------------
-- In order to get hlsearch working the way I like i.e. on when using /,?,N,n,*,#, etc. and off when
-- When I'm not using them, I need to set the following:
-- The mappings below are essentially faked user input this is because in order to automatically turn off
-- the search highlight just changing the value of 'hlsearch' inside a function does not work
-- read `:h nohlsearch`. So to have this workaround I check that the current mouse position is not a search
-- result, if it is we leave highlighting on, otherwise I turn it off on cursor moved by faking my input
-- using the expr mappings below.
--
-- This is based on the implementation discussed here:
-- https://github.com/neovim/neovim/issues/5581

map({ "n", "v", "o", "i", "c" }, "<Plug>(StopHL)", 'execute("nohlsearch")[-1]', { expr = true })

local function stop_hl()
  if v.hlsearch == 0 or api.nvim_get_mode().mode ~= "n" then
    return
  end
  api.nvim_feedkeys(mw.replace_termcodes "<Plug>(StopHL)", "m", false)
end

local function hl_search()
  local col = api.nvim_win_get_cursor(0)[2]
  local curr_line = api.nvim_get_current_line()
  local ok, match = pcall(fn.matchstrpos, curr_line, fn.getreg "/", 0)
  if not ok then
    return
  end
  local _, p_start, p_end = unpack(match)
  -- if the cursor is in a search result, leave highlighting on
  if col < p_start or col > p_end then
    stop_hl()
  end
end

mw.augroup("VimrcIncSearchHighlight", {
  event = { "CursorMoved" },
  command = function()
    hl_search()
  end,
}, {
  event = { "InsertEnter" },
  command = function()
    stop_hl()
  end,
}, {
  event = { "OptionSet" },
  pattern = { "hlsearch" },
  command = function()
    vim.schedule(function()
      cmd.redrawstatus()
    end)
  end,
}, {
  event = "RecordingEnter",
  command = function()
    vim.o.hlsearch = false
  end,
}, {
  event = "RecordingLeave",
  command = function()
    vim.o.hlsearch = true
  end,
})

local smart_close_filetypes = mw.p_table {
  ["qf"] = true,
  ["log"] = true,
  ["help"] = true,
  ["query"] = true,
  ["dbui"] = true,
  ["lspinfo"] = true,
  ["git.*"] = true,
  ["Neogit.*"] = true,
  ["neotest.*"] = true,
  ["fugitive.*"] = true,
  ["copilot.*"] = true,
  ["tsplayground"] = true,
  ["startuptime"] = true,
}

local smart_close_buftypes = mw.p_table {
  ["nofile"] = true,
}

local function smart_close()
  if fn.winnr "$" ~= 1 then
    api.nvim_win_close(0, true)
  end
end

mw.augroup("SmartClose", {
  -- Auto open grep quickfix window
  event = { "QuickFixCmdPost" },
  pattern = { "*grep*" },
  command = "cwindow",
}, {
  -- Close certain filetypes by pressing q.
  event = { "FileType" },
  command = function(args)
    local is_unmapped = fn.hasmapto("q", "n") == 0
    local buf = vim.bo[args.buf]
    local is_eligible = is_unmapped
      or vim.wo.previewwindow
      or smart_close_filetypes[buf.ft]
      or smart_close_buftypes[buf.bt]
    if is_eligible then
      map("n", "q", smart_close, { buffer = args.buf, nowait = true })
    end
  end,
}, {
  -- Close quick fix window if the file containing it was closed
  event = { "BufEnter" },
  command = function()
    if fn.winnr "$" == 1 and vim.bo.buftype == "quickfix" then
      api.nvim_buf_delete(0, { force = true })
    end
  end,
}, {
  -- automatically close corresponding loclist when quitting a window
  event = { "QuitPre" },
  nested = true,
  command = function()
    if vim.bo.filetype ~= "qf" then
      cmd.lclose { mods = { silent = true } }
    end
  end,
})

mw.augroup("ExternalCommands", {
  -- Open images in an image viewer (probably Preview)
  event = { "BufEnter" },
  pattern = { "*.png", "*.jpg", "*.gif" },
  command = function()
    cmd(fmt('silent! "%s | :bw"', vim.g.open_command .. " " .. fn.expand "%"))
  end,
})

mw.augroup("CheckOutsideTime", {
  -- automatically check for changed files outside vim
  event = { "WinEnter", "BufWinEnter", "BufWinLeave", "BufRead", "BufEnter", "FocusGained" },
  command = "silent! checktime",
})

mw.augroup("TextYankHighlight", {
  -- don't execute silently in case of errors
  event = { "TextYankPost" },
  command = function()
    vim.highlight.on_yank {
      timeout = 500,
      on_visual = false,
      higroup = "Visual",
    }
  end,
})

mw.augroup("UpdateVim", {
  event = { "FocusLost" },
  pattern = { "*" },
  command = "silent! wall",
})

mw.augroup("WindowBehaviours", {
  event = { "CmdwinEnter" }, -- map q to close command window on quit
  pattern = { "*" },
  command = "nnoremap <silent><buffer><nowait> q <C-W>c",
}, {
  event = { "BufWinEnter" },
  command = function(args)
    if vim.wo.diff then
      vim.diagnostic.disable(args.buf)
    end
  end,
}, {
  event = { "BufWinLeave" },
  command = function(args)
    if vim.wo.diff then
      vim.diagnostic.enable(args.buf)
    end
  end,
})

local cursorline_exclude = { "alpha", "toggleterm" }

---@param buf number
---@return boolean
local function should_show_cursorline(buf)
  return vim.bo[buf].buftype ~= "terminal"
    and not vim.wo.previewwindow
    and vim.wo.winhighlight == ""
    and vim.bo[buf].filetype ~= ""
    and not vim.tbl_contains(cursorline_exclude, vim.bo[buf].filetype)
end

mw.augroup("Cursorline", {
  event = { "BufEnter" },
  pattern = { "*" },
  command = function(args)
    vim.wo.cursorline = should_show_cursorline(args.buf)
  end,
}, {
  event = { "BufLeave" },
  pattern = { "*" },
  command = function()
    vim.wo.cursorline = false
  end,
})

local save_excluded = {
  "neo-tree",
  "neo-tree-popup",
  "lua.luapad",
  "gitcommit",
  "NeogitCommitMessage",
}
local function can_save()
  return mw.falsy(fn.win_gettype())
    and mw.falsy(vim.bo.buftype)
    and not mw.falsy(vim.bo.filetype)
    and vim.bo.modifiable
    and not vim.tbl_contains(save_excluded, vim.bo.filetype)
end

-- mw.augroup('TerminalAutocommands', {
--   event = { 'TermClose' },
--   command = function(args)
--     --- automatically close a terminal if the job was successful
--     if mw.falsy(v.event.status) and mw.falsy(vim.bo[args.buf].ft) then
--       cmd.bdelete({ fn.expand('<abuf>'), bang = true })
--     end
--   end,
-- })
