local theme = vim.g.colors_name

local path = "lua/omega/colors/custom/" .. theme .. ".lua"
local files = vim.api.nvim_get_runtime_file(path, true)
local highlights
if #files == 0 then
    highlights = {}
elseif #files == 1 then
    highlights = dofile(files[1])
else
    local nvim_base_pattern = "nvim-base16.lua/lua/colors/custom/"
    local valid_file = false
    for _, file in ipairs(files) do
        if not file:find(nvim_base_pattern) then
            highlights = dofile(file)
            valid_file = true
        end
    end
    if not valid_file then
        -- multiple files but in startup repo shouldn't happen so just use first one
        highlights = dofile(files[1])
    end
end

-- local highlights = require("custom_highlights." .. vim.g.colors_name)

for hl, attr in pairs(highlights) do
    vim.api.nvim_set_hl(0, hl, attr)
end
