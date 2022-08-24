local fn = vim.fn
local api = vim.api
local fmt = string.format
local map = vim.keymap.set

----------------------------------------------------------------------------------------------------
-- HLSEARCH
----------------------------------------------------------------------------------------------------
--[[
In order to get hlsearch working the way I like i.e. on when using /,?,N,n,*,#, etc. and off when
When I'm not using them, I need to set the following:
The mappings below are essentially faked user input this is because in order to automatically turn off
the search highlight just changing the value of 'hlsearch' inside a function does not work
read `:h nohlsearch`. So to have this work I check that the current mouse position is not a search
result, if it is we leave highlighting on, otherwise I turn it off on cursor moved by faking my input
using the expr mappings below.

This is based on the implementation discussed here:
https://github.com/neovim/neovim/issues/5581
--]]

map({ 'n', 'v', 'o', 'i', 'c' }, '<Plug>(StopHL)', 'execute("nohlsearch")[-1]', { expr = true })

local function stop_hl()
  if vim.v.hlsearch == 0 or api.nvim_get_mode().mode ~= 'n' then return end
  api.nvim_feedkeys(core.replace_termcodes('<Plug>(StopHL)'), 'm', false)
end

local function hl_search()
  local col = api.nvim_win_get_cursor(0)[2]
  local curr_line = api.nvim_get_current_line()
  local ok, match = pcall(fn.matchstrpos, curr_line, fn.getreg('/'), 0)
  if not ok then return end
  local _, p_start, p_end = unpack(match)
  -- if the cursor is in a search result, leave highlighting on
  if col < p_start or col > p_end then stop_hl() end
end

core.augroup('VimrcIncSearchHighlight', {
  {
    event = { 'CursorMoved' },
    command = function() hl_search() end,
  },
  {
    event = { 'InsertEnter' },
    command = function() stop_hl() end,
  },
  {
    event = { 'OptionSet' },
    pattern = { 'hlsearch' },
    command = function()
      vim.schedule(function() vim.cmd.redrawstatus() end)
    end,
  },
  {
    event = 'RecordingEnter',
    command = function() vim.opt.hlsearch = false end,
  },
  {
    event = 'RecordingLeave',
    command = function() vim.opt.hlsearch = true end,
  },
})

local smart_close_filetypes = {
  'help',
  'git-status',
  'git-log',
  'gitcommit',
  'dbui',
  'fugitive',
  'fugitiveblame',
  'LuaTree',
  'log',
  'tsplayground',
  'qf',
  'startuptime',
  'lspinfo',
  'neotest-summary',
}

local smart_close_buftypes = {} -- Don't include no file buffers as diff buffers are nofile

local function smart_close()
  if fn.winnr('$') ~= 1 then api.nvim_win_close(0, true) end
end

core.augroup('SmartClose', {
  {
    -- Auto open grep quickfix window
    event = { 'QuickFixCmdPost' },
    pattern = { '*grep*' },
    command = 'cwindow',
  },
  {
    -- Close certain filetypes by pressing q.
    event = { 'FileType' },
    pattern = '*',
    command = function()
      local is_unmapped = fn.hasmapto('q', 'n') == 0

      local is_eligible = is_unmapped
        or vim.wo.previewwindow
        or vim.tbl_contains(smart_close_buftypes, vim.bo.buftype)
        or vim.tbl_contains(smart_close_filetypes, vim.bo.filetype)

      if is_eligible then core.nnoremap('q', smart_close, { buffer = 0, nowait = true }) end
    end,
  },
  {
    -- Close quick fix window if the file containing it was closed
    event = { 'BufEnter' },
    pattern = '*',
    command = function()
      if fn.winnr('$') == 1 and vim.bo.buftype == 'quickfix' then
        api.nvim_buf_delete(0, { force = true })
      end
    end,
  },
  {
    -- automatically close corresponding loclist when quitting a window
    event = { 'QuitPre' },
    pattern = '*',
    nested = true,
    command = function()
      if vim.bo.filetype ~= 'qf' then vim.cmd.lclose({ mods = { silent = true } }) end
    end,
  },
})

core.augroup('ExternalCommands', {
  {
    -- Open images in an image viewer (probably Preview)
    event = { 'BufEnter' },
    pattern = { '*.png', '*.jpg', '*.gif' },
    command = function() vim.cmd(fmt('silent! "%s | :bw"', vim.g.open_command .. ' ' .. fn.expand('%'))) end,
  },
})

core.augroup('CheckOutsideTime', {
  {
    -- automatically check for changed files outside vim
    event = { 'WinEnter', 'BufWinEnter', 'BufWinLeave', 'BufRead', 'BufEnter', 'FocusGained' },
    pattern = '*',
    command = 'silent! checktime',
  },
})

--- automatically clear commandline messages after a few seconds delay
--- source: http://unix.stackexchange.com/a/613645
---@return function
local function clear_commandline()
  --- Track the timer object and stop any previous timers before setting
  --- a new one so that each change waits for 10secs and that 10secs is
  --- deferred each time
  local timer
  return function()
    if timer then timer:stop() end
    timer = vim.defer_fn(function()
      if fn.mode() == 'n' then vim.cmd.echon("''") end
    end, 10000)
  end
end

core.augroup('ClearCommandMessages', {
  {
    event = { 'CmdlineLeave', 'CmdlineChanged' },
    pattern = { ':' },
    command = clear_commandline(),
  },
})

if vim.env.TMUX ~= nil then
  core.augroup('External', {
    {
      event = { 'BufEnter' },
      pattern = '*',
      command = function() vim.o.titlestring = require('core.external').title_string() end,
    },
    {
      event = { 'VimLeavePre' },
      pattern = '*',
      command = function() require('core.external').tmux.set_statusline(true) end,
    },
    {
      event = { 'ColorScheme', 'FocusGained' },
      pattern = '*',
      command = function()
        -- NOTE: there is a race condition here as the colors
        -- for kitty to re-use need to be set AFTER the rest of the colorscheme
        -- overrides
        vim.defer_fn(function() require('core.external').tmux.set_statusline() end, 1)
      end,
    },
  })
end

core.augroup('TextYankHighlight', {
  {
    -- don't execute silently in case of errors
    event = { 'TextYankPost' },
    pattern = '*',
    command = function()
      vim.highlight.on_yank({
        timeout = 500,
        on_visual = false,
        higroup = 'Visual',
      })
    end,
  },
})

local column_exclude = { 'gitcommit' }
local column_block_list = {
  'NeogitCommitSelectView',
  'DiffviewFileHistory',
  'log',
  'norg',
  'startify',
  'vimwiki',
  'vim-plug',
  'alpha',
  'dap-repl',
  'help',
  'fugitive',
  'mail',
  'org',
  'orgagenda',
  'NeogitStatus',
  'norg',
}

---Set or unset the color column depending on the filetype of the buffer and its eligibility
local function check_color_column()
  for _, win in ipairs(api.nvim_list_wins()) do
    local buffer = vim.bo[api.nvim_win_get_buf(win)]
    local window = vim.wo[win]
    local is_current = win == api.nvim_get_current_win()
    if core.empty(fn.win_gettype()) and not vim.tbl_contains(column_exclude, buffer.filetype) then
      local too_small = api.nvim_win_get_width(win) <= buffer.textwidth + 1
      -- TODO: This should do a pattern match against a string rather than direct comparison
      local is_excluded = vim.tbl_contains(column_block_list, buffer.filetype)
      if is_excluded or too_small then
        window.colorcolumn = ''
      elseif core.empty(window.colorcolumn) and is_current then
        window.colorcolumn = '+1'
      end
    end
  end
end

core.augroup('CustomColorColumn', {
  {
    -- Update the cursor column to match current window size
    event = { 'BufEnter', 'WinNew', 'WinClosed', 'FileType', 'VimResized' },
    command = check_color_column,
  },
})
-- core.augroup('UpdateVim', {
--   {
--     -- TODO: not clear what effect this has in the post vimscript world
--     -- it correctly sources $MYVIMRC but all the other files that it
--     -- requires will need to be resourced or reloaded themselves
--     event = 'BufWritePost',
--     pattern = { '$DOTFILES/**/nvim/plugin/*.{lua,vim}', fn.expand('$MYVIMRC') },
--     nested = true,
--     command = function(args)
--       local path = api.nvim_buf_get_name(args.buf)
--       vim.cmd.source(path)
--       local ok, msg = pcall(vim.cmd, 'source $MYVIMRC | redraw | silent doautocmd ColorScheme')
--       if not ok then vim.notify(msg, 'error', { title = 'Sourcing init.lua' }) end
--       local m = ok and fmt('sourced %s and %s', path, fn.fnamemodify(vim.env.MYVIMRC, ':t')) or msg
--       if m then vim.notify(m) end
--     end,
--   },
--   {
--     event = { 'FocusLost' },
--     pattern = { '*' },
--     command = 'silent! wall',
--   },
--   -- Make windows equal size when vim resizes
--   {
--     event = { 'VimResized' },
--     pattern = { '*' },
--     command = 'wincmd =',
--   },
-- })

core.augroup('WindowBehaviours', {
  {
    -- map q to close command window on quit
    event = { 'CmdwinEnter' },
    pattern = { '*' },
    command = 'nnoremap <silent><buffer><nowait> q <C-W>c',
  },
  -- Automatically jump into the quickfix window on open
  {
    event = { 'QuickFixCmdPost' },
    pattern = { '[^l]*' },
    nested = true,
    command = 'cwindow',
  },
  {
    event = { 'QuickFixCmdPost' },
    pattern = { 'l*' },
    nested = true,
    command = 'lwindow',
  },
  {
    event = { 'BufWinEnter' },
    command = function(args)
      if vim.wo.diff then vim.diagnostic.disable(args.buf) end
    end,
  },
  {
    event = { 'BufWinLeave' },
    command = function(args)
      if vim.wo.diff then vim.diagnostic.enable(args.buf) end
    end,
  },
})

local cursorline_exclude = { 'alpha', 'toggleterm' }

---@param buf number
---@return boolean
local function should_show_cursorline(buf)
  return vim.bo[buf].buftype ~= 'terminal'
    and not vim.wo.previewwindow
    and vim.wo.winhighlight == ''
    and vim.bo[buf].filetype ~= ''
    and not vim.tbl_contains(cursorline_exclude, vim.bo[buf].filetype)
end

core.augroup('Cursorline', {
  {
    event = { 'BufEnter' },
    pattern = { '*' },
    command = function(args) vim.wo.cursorline = should_show_cursorline(args.buf) end,
  },
  {
    event = { 'BufLeave' },
    pattern = { '*' },
    command = function() vim.wo.cursorline = false end,
  },
})

local save_excluded = {
  'neo-tree',
  'neo-tree-popup',
  'lua.luapad',
  'gitcommit',
  'NeogitCommitMessage',
}
local function can_save()
  return core.empty(fn.win_gettype())
    and core.empty(vim.bo.buftype)
    and not core.empty(vim.bo.filetype)
    and vim.bo.modifiable
    and not vim.tbl_contains(save_excluded, vim.bo.filetype)
end

core.augroup('Utilities', {
  {
    -- @source: https://vim.fandom.com/wiki/Use_gf_to_open_a_file_via_its_URL
    event = { 'BufReadCmd' },
    pattern = { 'file:///*' },
    nested = true,
    command = function(args)
      vim.cmd.bdelete({ bang = true })
      vim.cmd.edit(vim.uri_to_fname(args.file))
    end,
  },
  {
    event = { 'FileType' },
    pattern = { 'gitcommit', 'gitrebase' },
    command = 'set bufhidden=delete',
  },
  -- { -- TODO: should this be done in ftplugin files
  --   event = { 'FileType' },
  --   pattern = { 'lua', 'vim', 'dart', 'python', 'javascript', 'typescript', 'rust' },
  --   -- FIXME: spellsitter is slow in large files
  --   command = function(args) vim.opt_local.spell = vim.api.nvim_buf_line_count(args.buf) < 8000 end,
  -- },
  {
    event = { 'BufWritePre', 'FileWritePre' },
    pattern = { '*' },
    command = "silent! call mkdir(expand('<afile>:p:h'), 'p')",
  },
  {
    event = { 'BufLeave' },
    pattern = { '*' },
    command = function()
      if can_save() then vim.cmd.update({ mods = { silent = true } }) end
    end,
  },
  {
    event = { 'BufWritePost' },
    pattern = { '*' },
    nested = true,
    command = function()
      if core.empty(vim.bo.filetype) or fn.exists('b:ftdetect') == 1 then
        vim.cmd([[
            unlet! b:ftdetect
            filetype detect
            echom 'Filetype set to ' . &ft
          ]])
      end
    end,
  },
})

core.augroup('TerminalAutocommands', {
  {
    event = { 'TermClose' },
    pattern = '*',
    command = function()
      --- automatically close a terminal if the job was successful
      if not vim.v.event.status == 0 then vim.cmd.bdelete({ fn.expand('<abuf>'), bang = true }) end
    end,
  },
})
