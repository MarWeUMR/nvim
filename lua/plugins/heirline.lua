local utls = require("tokyonight.util")
local utils = require("heirline.utils")
local conditions = require("heirline.conditions")

local get_theme_color_table = function(theme_name)
  local clr_table = require("themer.modules.core.api").get_cp(theme_name)

  -- configure common colors among different themes
  local colors = {
    default_bg = clr_table.bg.base,
    accent = clr_table.accent,
    string = clr_table.syntax.string,
    directory = clr_table.directory,
    diag = {
      warn = clr_table.diagnostic.warn,
      error = clr_table.diagnostic.error,
      hint = clr_table.diagnostic.hint,
      info = clr_table.diagnostic.info,
    },
    diff = {
      add = clr_table.diff.add,
      change = clr_table.diff.change,
      remove = clr_table.diff.remove,
      text = clr_table.diff.text,
    },
    cwd_path = {
      fg = clr_table.bg.selected,
      bg = clr_table.syntax.string,
    },
    cwd_icon = {
      fg = clr_table.bg.selected,
      bg = utls.darken(clr_table.syntax.string, 0.4, clr_table.bg.selected),
    },
    file_path = {
      fg = clr_table.bg.selected,
      bg = clr_table.syntax.conditional,
    },
    file_icon = {
      fg = clr_table.bg.selected,
      bg = utls.darken(clr_table.syntax.conditional, 0.4, clr_table.bg.selected),
    },
  }

  -- IF NECESSARY, ADD YOUR OWN COLORS HERE
  -- if theme_name == "doom_one" then
  -- colors["something to add"] = { fg = clr_table.bg.selected, bg = clr_table.syntax.string }
  -- return colors
  -- elseif theme_name == "tokyonight" then
  -- colors["something else to add"] = { fg = clr_table.bg.selected, bg = clr_table.syntax.string }
  -- return colors
  -- end

  return colors
end

-- GET THE NAME OF THE CURRENTLY LOADED THEME...
local theme_name = vim.api.nvim_get_var("colors_name")
-- ... AND LOAD THE COLOR TABLE ACCORDINGLY
local colors = get_theme_color_table(theme_name)

local align = { provider = "%=", hl = { fg = colors.default_bg } }

local file_icons = {
  typescript = " ",
  tex = "ﭨ ",
  ts = " ",
  python = " ",
  py = " ",
  java = " ",
  html = " ",
  css = " ",
  scss = " ",
  javascript = " ",
  js = " ",
  javascriptreact = " ",
  markdown = " ",
  md = " ",
  sh = " ",
  zsh = " ",
  vim = " ",
  rust = " ",
  rs = " ",
  cpp = " ",
  c = " ",
  go = " ",
  lua = " ",
  conf = " ",
  haskel = " ",
  hs = " ",
  ruby = " ",
  norg = " ",
  txt = " ",
}

local mode_colors = {
  n = vim.g.terminal_color_1,
  i = vim.g.terminal_color_2,
  v = vim.g.terminal_color_5,
  V = vim.g.terminal_color_5,
  ["^V"] = colors.blue,
  c = colors.blue,
  s = vim.g.terminal_color_3,
  S = vim.g.terminal_color_3,
  ["^S"] = colors.yellow,
  R = colors.purple,
  r = vim.g.terminal_color_4,
  ["!"] = vim.g.terminal_color_1,
  t = vim.g.terminal_color_1,
}

----------------------------------------------------------------------------------------
--------------------------------------------
--
--      FILE PATH
--
--------------------------------------------
----------------------------------------------------------------------------------------

local FileIconSurroundF = {
  {
    provider = function()
      return ""
    end,
    hl = function(_)
      return { fg = colors.blue, bg = "none" }
    end,
    condition = function()
      return vim.tbl_contains(vim.tbl_keys(file_icons), vim.bo.ft)
    end,
  },
}

local FileIconSurroundB = {
  {
    provider = function()
      return " "
    end,
    hl = function(_)
      return { bg = colors.file_path.bg, fg = colors.file_icon.bg }
    end,
    condition = function()
      return vim.tbl_contains(vim.tbl_keys(file_icons), vim.bo.ft)
    end,
  },
}

local FileIcon = {
  init = function(self)
    self.mode = vim.fn.mode(1)
    local filename = self.filename
    local extension = vim.fn.fnamemodify(filename, ":e")
    self.icon = file_icons[extension] or ""
  end,
  provider = function(self)
    return self.icon and (" " .. self.icon .. " ")
  end,
  hl = function()
    return { fg = colors.file_icon.fg, bg = colors.file_icon.bg }
  end,
  condition = function()
    return vim.tbl_contains(vim.tbl_keys(file_icons), vim.bo.ft)
  end,
}

local FileNameBlock = {
  init = function(self)
    self.filename = vim.api.nvim_buf_get_name(0)
    self.mode = vim.fn.mode(1)
  end,
}

local FileName = {
  provider = function(self)
    local filename = vim.fn.pathshorten(vim.fn.fnamemodify(self.filename, ":."))
    if filename == "" then
      return ""
    end
    return filename .. " "
  end,
  hl = function()
    return { fg = colors.file_path.fg, bg = colors.file_path.bg }
  end,
}

local FileFlags = {
  {
    provider = function()
      if vim.bo.modified then
        return " "
      end
    end,
    hl = function()
      return { fg = colors.file_icon.fg }
    end,
  },
  {
    provider = function()
      if not vim.bo.modifiable or vim.bo.readonly then
        return ""
      end
    end,
    hl = function(self)
      local mode = self.mode:sub(1, 1)
      return { fg = mode_colors[mode] or colors.blue }
    end,
  },
}

local FileNameSurround = {
  {
    provider = function()
      return ""
    end,
    hl = function(_)
      return { fg = colors.file_path.bg, bg = colors.file_path.bg }
    end,
    condition = function()
      return not vim.tbl_contains(vim.tbl_keys(file_icons), vim.bo.ft)
    end,
  },
}

FileNameBlock = utils.insert(
  FileNameBlock,
  FileIconSurroundF,
  FileIcon,
  FileIconSurroundB,
  FileNameSurround,
  FileName,
  unpack(FileFlags),
  {
    provider = "%<",
  }
)
FileNameBlock = utils.surround({ "", "" }, colors.file_path.bg, FileNameBlock)

FileNameBlock[1]["condition"] = function()
  return not conditions.buffer_matches({
    filetype = { "dashboard" },
  })
end
FileNameBlock[2]["condition"] = function()
  return not conditions.buffer_matches({
    filetype = { "dashboard" },
  })
end
FileNameBlock[3]["condition"] = function()
  return not conditions.buffer_matches({
    filetype = { "dashboard" },
  })
end

----------------------------------------------------------------------------------------
--------------------------------------------
--
--      CURRENT WORKDIR
--
--------------------------------------------
----------------------------------------------------------------------------------------

local WorkDirIcon = {
  {
    provider = function()
      return "   "
    end,
    hl = function(_)
      return { fg = colors.cwd_icon.fg, bg = colors.cwd_icon.bg }
    end,
  },
  {
    provider = function()
      return ""
    end,
    hl = { fg = colors.cwd_icon.bg, bg = colors.cwd_path.bg },
  },
  {
    provider = function()
      local cwd = vim.fn.getcwd(0)
      cwd = vim.fn.fnamemodify(cwd, ":~")
      cwd = vim.fn.pathshorten(cwd)
      local trail = cwd:sub(-1) == "/" and "" or "/"
      return " " .. cwd .. trail
    end,
    hl = { bg = colors.cwd_path.bg, fg = colors.cwd_path.fg },
  },
  {
    -- right margin of cwd path
    provider = function()
      return ""
    end,
    hl = function()
      if conditions.buffer_matches({
        filetype = { "startup", "Telescope", "NvimTree", "toggleterm" },
      })
      then
        return { bg = colors.cwd_path.bg, fg = colors.file_path.bg }
      else
        return { fg = colors.file_icon.bg, bg = colors.cwd_path.bg }
      end
    end,
  },
  {
    FileNameBlock,
  },
}

----------------------------------------------------------------------------------------
--------------------------------------------
--
--      GPS INDICATOR
--
--------------------------------------------
----------------------------------------------------------------------------------------

local gps_lsp = {
  condition = require("nvim-gps").is_available,
  -- left enclosing
  -- actual content
  {
    provider = require("nvim-gps").get_location,
    hl = function()
      return { fg = colors.directory }
    end,
  },
  -- right enclosing
}

----------------------------------------------------------------------------------------
--------------------------------------------
--
--      DIAGNOSTICS
--
--------------------------------------------
----------------------------------------------------------------------------------------

local diagnostics = {

  condition = conditions.has_diagnostics,

  static = {
    error_icon = " ",
    warn_icon = " ",
    info_icon = " ",
    hint_icon = " ",
  },

  init = function(self)
    self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
    self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
  end,

  {
    provider = function(self)
      return self.errors > 0 and (self.error_icon .. self.errors .. " ")
    end,
    hl = { fg = colors.diag.error, bg = colors.default_bg },
  },
  {
    provider = function(self)
      return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ")
    end,
    hl = { fg = colors.diag.warning, bg = colors.default_bg },
  },
  {
    provider = function(self)
      return self.info > 0 and (self.info_icon .. self.info .. " ")
    end,
    hl = { fg = colors.diag.info, bg = colors.default_bg },
  },
  {
    provider = function(self)
      return self.hints > 0 and (self.hint_icon .. self.hints)
    end,
    hl = { fg = colors.diag.hint, bg = colors.default_bg },
  },
}

----------------------------------------------------------------------------------------
--------------------------------------------
--
--      GIT
--
--------------------------------------------
----------------------------------------------------------------------------------------

local git = {
  condition = conditions.is_git_repo,

  init = function(self)
    self.status_dict = vim.b.gitsigns_status_dict
    self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
  end,

  hl = { fg = colors.diff.text, bg = colors.default_bg },

  {
    provider = function(self)
      return "ﯙ    " .. self.status_dict.head .. " "
    end,
  },
  {
    provider = function(self)
      local count = self.status_dict.added or 0
      return count > 0 and ("  " .. count)
    end,
    hl = { fg = colors.diff.add },
  },
  {
    provider = function(self)
      local count = self.status_dict.removed or 0
      return count > 0 and ("  " .. count)
    end,
    hl = { fg = colors.diff.remove },
  },
  {
    provider = function(self)
      local count = self.status_dict.changed or 0
      return count > 0 and ("  " .. count)
    end,
    hl = { fg = colors.diff.change },
  },
}

----------------------------------------------------------------------------------------
--------------------------------------------
--
--      LSP ACTIVE INDICATOR
--
--------------------------------------------
----------------------------------------------------------------------------------------

local LSPActive = {
  condition = conditions.lsp_attached,
  { provider = "  ", hl = { fg = colors.accent, bold = true } },
}

----------------------------------------------------------------------------------------
--------------------------------------------
--
--      MODE INDICATOR
--
--------------------------------------------
----------------------------------------------------------------------------------------

local mode_icon = {

  {
    init = function(self)
      self.mode = vim.fn.mode(1)
    end,

    static = {
      mode_icons = {
        ["n"] = "  ",
        ["i"] = "  ",
        ["s"] = "  ",
        ["S"] = "  ",

        ["v"] = "  ",
        ["V"] = "  ",
        [""] = "  ",
        ["r"] = " ﯒ ",
        ["r?"] = "  ",
        ["c"] = "  ",
        ["t"] = "  ",
        ["!"] = "  ",
        ["R"] = "  ",
      },
    },
    hl = function()
      return {
        -- bg = mode_colors[mode] or colors.blue,
        fg = colors.accent,
        bold = true,
      }
    end,
    provider = function(self)
      return "%2(" .. self.mode_icons[self.mode:sub(1, 1)] .. "%)" .. " "
    end,
  },
}

----------------------------------------------------------------------------------------
--------------------------------------------
--
--      FINALIZE STATUSLINE
--
--------------------------------------------
----------------------------------------------------------------------------------------

local default_statusline = {
  condition = conditions.is_active,
  utils.make_flexible_component(1, WorkDirIcon),
  align,
  utils.make_flexible_component(5, gps_lsp, { provider = "" }),
  align,
  diagnostics,
  align,
  git,
  align,
  LSPActive,
  mode_icon,
}

require("heirline").setup(default_statusline)

-- ICONS
--[[
│
┃


█













●
ﯙ

]]
--
