-- code from https://github.com/NvChad/NvChad
local function highlight(group, guifg, guibg, attr, guisp)
    local arg = {}
    if guifg then
        if vim.tbl_contains({ "none", "NONE", "None" }, guifg) then
            arg["fg"] = ""
        else
            arg["fg"] = guifg
        end
    end
    if guibg then
        if vim.tbl_contains({ "none", "NONE", "None" }, guibg) then
            arg["bg"] = ""
        else
            arg["bg"] = guibg
        end
    end
    if attr then
        if type(attr) == "table" then
            for _, at in ipairs(attr) do
                arg[at] = true
            end
        else
            if not vim.tbl_contains({ "none", "NONE", "None" }, attr) then
                arg[attr] = true
            end
        end
    end
    if guisp then
        arg["sp"] = guisp
        -- table.insert(arg, "guisp=#" .. guisp)
    end

    -- nvim.ex.highlight(parts)
    vim.api.nvim_set_hl(0, group, arg)
end

local cmd = vim.cmd

local colors = require("omega.colors").get(vim.g.colors_name)

local black = colors.black
local black2 = colors.black2
local blue = colors.blue
local darker_black = colors.darker_black
local folder_bg = colors.folder_bg
local green = colors.green
local grey = colors.grey
local grey_fg = colors.grey_fg
local line = colors.line
local light_grey = colors.light_grey
local nord_blue = colors.nord_blue
local one_bg = colors.one_bg
local one_bg2 = colors.one_bg2
local pmenu_bg = colors.pmenu_bg
local purple = colors.purple
local red = colors.red
local white = colors.white
local yellow = colors.yellow
local orange = colors.orange
local tele_bg = colors.telescope_bg or colors.darker_black
local tele_prompt = colors.telescope_prompt or colors.black2

local ui = {
    italic_comments = true,
    -- theme to be used, check available themes with `<leader> + t + h`
    -- theme = "kanagawa",
    -- Enable this only if your terminal has the colorscheme set which nvchad uses
    -- For Ex : if you have onedark set in nvchad, set onedark's bg color on your terminal
    transparency = false,
}

-- Define bg color
-- @param group Group
-- @param color Color
local function bg(group, color, args)
    local arg = {}
    if args then
        vim.tbl_extend("keep", arg, args)
    end
    arg["bg"] = color
    vim.api.nvim_set_hl(0, group, arg)
end

-- Define fg color
-- @param group Group
-- @param color Color
local function fg(group, color, args)
    local arg = {}
    if args then
        arg = args
    end
    arg["fg"] = color
    vim.api.nvim_set_hl(0, group, arg)
end

-- Define bg and fg color
-- @param group Group
-- @param fgcol Fg Color
-- @param bgcol Bg Color
local function fg_bg(group, fgcol, bgcol, args)
    local arg = {}
    if args then
        arg = args
    end
    arg["bg"] = bgcol
    arg["fg"] = fgcol
    vim.api.nvim_set_hl(0, group, arg)
end

-- Comments
if ui.italic_comments then
    fg("Comment", grey_fg, { italic = true })
else
    fg("Comment", grey_fg)
end
bg("TS_Context", grey_fg)

-- Disable cusror line
-- Line number
fg("cursorlinenr", white)

-- same it bg, so it doesn't appear
fg("EndOfBuffer", black)

-- For floating windows
-- bg("NormalFloat", black)
bg("NormalFloat")
fg("IndentBlanklineChar")

fg("DiagnosticWarn", orange)
fg("DiagnosticError", red)
fg("DiagnosticInfo", yellow)
fg("DiagnosticHint", blue)

-- bg("SpellBad", black, { guisp = red })
highlight("SpellBad", nil, nil, "undercurl", red)
-- Pmenu
-- bg("Pmenu", one_bg)
bg("PmenuSbar", one_bg2)
bg("PmenuSel", blue)
-- bg("PmenuThumb", nord_blue)

-- misc
fg("LineNr", grey)
fg("NvimInternalError", red)
fg("VertSplit", one_bg2)
-- fg("CmpBorderedWindow_FloatBorder", one_bg2)
-- fg("CmpBorderedWindow_FloatBorder", grey_fg)
fg("CmpBorder", blue)
bg("PmenuThumb", white)
-- fg("PmenuThumb", nord_blue)
fg("WinSeparator", one_bg2)
fg("CmpDocumentationWindowBorder", one_bg2)

bg("NeorgCodeBlock", darker_black)

if ui.transparency then
    vim.cmd("hi clear CursorLine")
    bg("Normal", "")
    bg("Folded", "")
    fg("Folded", "")
    fg("Comment", grey)
end

-- [[ Plugin Highlights
bg("Folded", "none")

-- Dashboard
fg("DashboardCenter", grey_fg)
fg("DashboardFooter", grey_fg)
fg("DashboardHeader", grey_fg)
fg("DashboardShortcut", grey_fg)

-- Git signs
fg_bg("DiffAdd", nord_blue, "none")
fg_bg("DiffChange", grey_fg, "none")
fg_bg("DiffModified", nord_blue, "none")

-- Indent blankline plugin
fg("IndentBlanklineChar", line)

-- ]]

-- [[ LspDiagnostics

-- Errors
fg("LspDiagnosticsSignError", red)
fg("LspDiagnosticsSignWarning", yellow)
fg("LspDiagnosticsVirtualTextError", red)
fg("LspDiagnosticsVirtualTextWarning", yellow)

-- Info
fg("LspDiagnosticsSignInformation", green)
fg("LspDiagnosticsVirtualTextInformation", green)

-- Hints
fg("LspDiagnosticsSignHint", purple)
fg("LspDiagnosticsVirtualTextHint", purple)

-- ]]

-- NvimTree
fg("NvimTreeEmptyFolderName", blue)
fg("NvimTreeEndOfBuffer", darker_black)
fg("NvimTreeFolderIcon", folder_bg)
fg("NvimTreeFolderName", folder_bg)
fg("NvimTreeGitDirty", red)
fg("NvimTreeIndentMarker", one_bg2)
bg("NvimTreeNormal", darker_black)
fg("NvimTreeOpenedFolderName", blue)
fg("NvimTreeRootFolder", red, { underline = true }) -- enable underline for root folder in nvim tree
fg_bg("NvimTreeStatuslineNc", darker_black, darker_black)
fg("NvimTreeVertSplit", darker_black)
bg("NvimTreeVertSplit", darker_black)
fg_bg("NvimTreeWindowPicker", red, tele_prompt)

-- if require("custom.db").get_ts_layout() == "custom_bottom_no_borders" then
if true then
    fg_bg("TelescopeBorder", tele_bg, tele_bg)
    fg_bg("TelescopePromptBorder", tele_prompt, tele_prompt)
    fg_bg("TelescopePreviewBorder", tele_bg, tele_bg)
    fg_bg("TelescopeResultsBorder", tele_bg, tele_bg)

    fg_bg("TelescopePromptNormal", white, tele_prompt)
    fg_bg("TelescopePromptPrefix", red, tele_prompt)

    bg("TelescopeNormal", tele_bg)
    bg("TelescopePreviewNormal", tele_bg)

    fg_bg("TelescopePreviewTitle", black, green)
    fg_bg("TelescopePromptTitle", black, red)
    fg_bg("TelescopeResultsTitle", black, blue)
    fg_bg("TelescopeSelection", blue, light_grey)
    fg_bg("TelescopeSelectionCaret", blue, light_grey)
    bg("TelescopePreviewLine", light_grey)
elseif require("custom.db").get_ts_layout() == "float_all_borders" then
    fg_bg("TelescopeBorder", light_grey, black)
    fg_bg("TelescopePromptBorder", light_grey, black)
    fg_bg("TelescopePreviewBorder", light_grey, black)
    fg_bg("TelescopeResultsBorder", light_grey, black)

    -- fg_bg("TelescopePromptNormal", white, tele_prompt)
    fg_bg("TelescopePromptNormal", white, "")
    -- fg_bg("TelescopePromptPrefix", red, tele_prompt)
    fg_bg("TelescopePromptPrefix", red, "")

    bg("TelescopeNormal", black)
    bg("TelescopePreviewNormal", black)

    fg_bg("TelescopePreviewTitle", black, green)
    fg_bg("TelescopePromptTitle", black, red)
    fg_bg("TelescopeResultsTitle", black, blue)
    fg_bg("TelescopeSelection", blue, light_grey)
    fg_bg("TelescopeSelectionCaret", blue, light_grey)
    bg("TelescopePreviewLine", light_grey)
end

bg("Search", yellow)
bg("IncSearch", red)

-- Telescope
fg("TelescopeBorder", folder_bg)
-- fg("TelescopePreviewBorder", folder_bg)
-- fg("TelescopePromptBorder", folder_bg)
-- fg("TelescopeResultsBorder", folder_bg)

fg_bg("BufferLineRightCustomAreaText1", colors.blue, colors.light_grey)
fg_bg("BufferLineRightCustomAreaText2", colors.dark_purple, colors.light_grey)
fg("BufferLineRightCustomAreaText3", colors.red)
