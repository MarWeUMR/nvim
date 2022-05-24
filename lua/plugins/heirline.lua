-- M.separators = {--{{{
--   vertical_bar       = '┃',
--   vertical_bar_thin  = '│',
--   left               = '',
--   right              = '',
--   block              = '█',
--   left_filled        = '',
--   right_filled       = '',
--   slant_left         = '',
--   slant_left_thin    = '',
--   slant_right        = '',
--   slant_right_thin   = '',
--   slant_left_2       = '',
--   slant_left_2_thin  = '',
--   slant_right_2      = '',
--   slant_right_2_thin = '',
--   left_rounded       = '',
--   left_rounded_thin  = '',
--   right_rounded      = '',
--   right_rounded_thin = '',
--   circle             = '●',
--   github_icon        = " ﯙ ",
--   folder_icon        = " ",
-- }

-- TODO
-- local loaded_colorscheme = vim.g.colors_name
--
-- if loaded_colorscheme == "tokyonight" then
--   colors.file_path.bg = colors.probe
-- else
-- end

local clrs = require("tokyonight.colors").setup({}) -- pass in any of the config options as explained above
local utls = require("tokyonight.util")

local utils = require("heirline.utils")
local colors = {
  probe = utils.get_highlight("Substitute").bg,
  red = utils.get_highlight("DiagnosticError").fg,
  identifier = utils.get_highlight("Identifier").fg,
  green = utils.get_highlight("String").fg,
  blue = utils.get_highlight("Function").fg,
  gray = utils.get_highlight("NonText").fg,
  special_fg = utils.get_highlight("Special").fg,
  special_bg = utils.get_highlight("Special").bg,
  purple = utils.get_highlight("Statement").fg,
  cyan = utils.get_highlight("Special").fg,
  orange = clrs.orange,
  wild_fg = utils.get_highlight("WildMenu").fg,
  wild_bg = utils.get_highlight("WildMenu").bg,
  diag = {
    warn = clrs.warning,
    error = clrs.error,
    hint = clrs.hint,
    info = clrs.info,
  },
  cwd_icon = {
    fg = clrs.bg_dark,
    bg = utls.darken(clrs.green, 0.2, clrs.bg_dark),
  },
  cwd_path = {
    fg = clrs.bg_dark,
    bg = utils.get_highlight("String").fg,
  },
  file_icon = {
    fg = clrs.bg_dark,
    bg = utils.get_highlight("Identifier").fg,
  },
}

colors["file_path"] = { fg = clrs.bg_dark, bg = clrs.purple }
colors["file_icon"] = { fg = clrs.bg_dark, bg = utls.darken(clrs.purple, 0.4, clrs.bg_dark) }



local conditions = require("heirline.conditions")
local align = { provider = "%=", hl = { fg = colors.probe } }

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
    hl = { bg = colors.green, fg = clrs.bg_dark },
  },
  {
    -- right margin of cwd path
    provider = function()
      return ""
    end,
    hl = function(self)
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
  {
    provider = function()
      if #require("nvim-gps").get_data() > 0 then
        return "  "
      else
        return ""
      end
    end,
    hl = { fg = colors.orange },
  },
  -- actual content
  {
    provider = require("nvim-gps").get_location,
    hl = function()
      return { fg = colors.orange }
    end,
  },
  -- right enclosing
  {
    provider = function()
      if #require("nvim-gps").get_data() > 0 then
        return " "
      else
        return ""
      end
    end,
    hl = { fg = colors.orange },
  },
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
    hl = { fg = colors.diag.error },
  },
  {
    provider = function(self)
      return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ")
    end,
    hl = { fg = colors.diag.warning },
  },
  {
    provider = function(self)
      return self.info > 0 and (self.info_icon .. self.info .. " ")
    end,
    hl = { fg = colors.diag.info },
  },
  {
    provider = function(self)
      return self.hints > 0 and (self.hint_icon .. self.hints)
    end,
    hl = { fg = colors.diag.hint },
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

  hl = { fg = colors.identifier },

  {
    provider = function(self)
      return "ﯙ  " .. self.status_dict.head .. " "
    end,
  },
  {
    provider = function(self)
      local count = self.status_dict.added or 0
      return count > 0 and ("  " .. count)
    end,
    hl = { fg = colors.green },
  },
  {
    provider = function(self)
      local count = self.status_dict.removed or 0
      return count > 0 and ("  " .. count)
    end,
    hl = { fg = colors.red },
  },
  {
    provider = function(self)
      local count = self.status_dict.changed or 0
      return count > 0 and ("  " .. count)
    end,
    hl = { fg = colors.diag.warn },
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
  { provider = "  ", hl = { fg = colors.identifier, bold = true } },
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
    hl = function(self)
      local mode = self.mode:sub(1, 1)
      return { fg = mode_colors[mode] or colors.blue }
    end,
  },
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
        [""] = "  ",

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
      mode_names = {
        n = "N",
        no = "N?",
        nov = "N?",
        noV = "N?",
        ["no"] = "N?",
        niI = "Ni",
        niR = "Nr",
        niV = "Nv",
        nt = "Nt",
        v = "V",
        vs = "Vs",
        V = "V_",
        Vs = "Vs",
        [""] = "",
        ["s"] = "",
        s = "S",
        S = "S_",
        [""] = "",
        i = "I",
        ic = "Ic",
        ix = "Ix",
        R = "R",
        Rc = "Rc",
        Rx = "Rx",
        Rv = "Rv",
        Rvc = "Rv",
        Rvx = "Rv",
        c = "C",
        cv = "Ex",
        r = "...",
        rm = "M",
        ["r?"] = "?",
        ["!"] = "!",
        t = "T",
      },
    },
    hl = function(self)
      local mode = self.mode:sub(1, 1)
      return {
        -- bg = mode_colors[mode] or colors.blue,
        fg = colors.identifier,
        bold = true,
      }
    end,
    provider = function(self)
      return "%2(" .. self.mode_icons[self.mode:sub(1, 1)] .. "%)" .. " "
    end,
  },
  {
    init = function(self)
      self.mode = vim.fn.mode(1)
    end,
    provider = function()
      return ""
    end,
    hl = function(self)
      local mode = self.mode:sub(1, 1)
      return { fg = mode_colors[mode] or colors.blue }
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



--
-- { TOKYONIGHT COLORS
--   bg = "#24283b",
--   bg_dark = "#1f2335",
--   bg_float = "#1f2335",
--   bg_highlight = "#292e42",
--   bg_popup = "#1f2335",
--   bg_search = "#3d59a1",
--   bg_sidebar = "#1f2335",
--   bg_statusline = "#1f2335",
--   bg_visual = "#364A82",
--   black = "#1D202F",
--   blue = "#7aa2f7",
--   blue0 = "#3d59a1",
--   blue1 = "#2ac3de",
--   blue2 = "#0db9d7",
--   blue5 = "#89ddff",
--   blue6 = "#B4F9F8",
--   blue7 = "#394b70",
--   border = "#1D202F",
--   border_highlight = "#3d59a1",
--   comment = "#565f89",
--   cyan = "#7dcfff",
--   dark3 = "#545c7e",
--   dark5 = "#737aa2",
--   diff = {
--     add = "#283B4D",
--     change = "#272D43",
--     delete = "#3F2D3D",
--     text = "#394b70"
--   },
--   error = "#ff0000",
--   fg = "#c0caf5",
--   fg_dark = "#a9b1d6",
--   fg_gutter = "#3b4261",
--   fg_sidebar = "#a9b1d6",
--   git = {
--     add = "#449dab",
--     change = "#6183bb",
--     conflict = "#bb7a61",
--     delete = "#914c54",
--     ignore = "#545c7e"
--   },
--   gitSigns = {
--     add = "#266d6a",
--     change = "#536c9e",
--     delete = "#b2555b"
--   },
--   green = "#9ece6a",
--   green1 = "#73daca",
--   green2 = "#41a6b5",
--   hint = "#ff9e64",
--   info = "#0db9d7",
--   magenta = "#bb9af7",
--   magenta2 = "#ff007c",
--   none = "NONE",
--   orange = "#ff9e64",
--   purple = "#9d7cd8",
--   red = "#f7768e",
--   red1 = "#db4b4b",
--   teal = "#1abc9c",
--   terminal_black = "#414868",
--   warning = "#e0af68",
--   yellow = "#e0af68"
-- }
