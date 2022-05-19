-- local utils = require("ignis.utils")
local colors = {}


-- if theme given, load given theme if given, otherwise nvchad_theme
colors.init = function(theme)
    local reload = false
    if theme and vim.g.colors_name and theme ~= vim.g.colors_name then
        reload = true
    end
    -- set the global theme, used at various places like theme switcher, highlights
    if not theme then
        if vim.g.forced_theme then
            theme = vim.g.forced_theme
        elseif vim.g.colors_name then
            theme = vim.g.colors_name
        end
    end
    vim.g.colors_name = theme

    local base16 = require("colors.base16")

    -- first load the base16 theme
    base16(base16.themes(theme), true)
    -- base16_custom(base16.themes(theme), true)

    -- unload to force reload
    package.loaded["colors.highlights" or false] = nil
    -- then load the highlights
    package.loaded["colors.highlights"] = nil
    package.loaded["colors.custom"] = nil
    local highlights_raw = vim.split(
        vim.api.nvim_exec("filter BufferLine hi", true),
        "\n"
    )
    local highlight_groups = {}
    for _, raw_hi in ipairs(highlights_raw) do
        table.insert(highlight_groups, string.match(raw_hi, "BufferLine%a+"))
    end
    for _, highlight in ipairs(highlight_groups) do
        vim.cmd([[hi clear ]] .. highlight)
    end
    require("colors.highlights")
    require("colors.custom")
    if reload then
        -- require("plenary.reload").reload_module("omega")
        -- require("plenary.reload").reload_module("bufferline")
        -- require"omega.core.modules".load()
        -- require("omega.core")
    end
    -- require("ignis.modules.ui.bufferline")
    -- require"colorscheme_switcher".new_scheme()
end

local old_theme = nil

function colors.toggle_light()
    if vim.g.colors_name ~= omega.config.light_colorscheme then
        old_theme = vim.g.colors_name
        colors.init(omega.config.light_colorscheme)
        vim.g.toggle_icon = " "
    else
        colors.init(old_theme)
        vim.g.toggle_icon = " "
    end
end

-- returns a table of colors for givem or current theme
colors.get = function(theme)
    if not theme then
        theme = vim.g.colors_name
    end
    local path = "lua/hl_themes/" .. theme .. ".lua"
    local files = vim.api.nvim_get_runtime_file(path, true)
    local color_table
    if #files == 0 then
        error("lua/hl_themes/" .. theme .. ".lua" .. " not found")
    elseif #files == 1 then
        color_table = dofile(files[1])
    else
        local nvim_base_pattern = "nvim-base16.lua/lua/hl_themes"
        local valid_file = false
        for _, file in ipairs(files) do
            if not file:find(nvim_base_pattern) then
                color_table = dofile(file)
                valid_file = true
            end
        end
        if not valid_file then
            -- multiple files but in startup repo shouldn't happen so just use first one
            color_table = dofile(files[1])
        end
    end
    return color_table
end

return colors
