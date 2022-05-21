local winbar = {}

local themer = require("themer.modules.core.api").get_cp("doom_one")



-- local colors = require("colors").get()
vim.api.nvim_set_hl(0, "WinBarSeparator", { fg = themer.accent})
vim.api.nvim_set_hl(0, "WinBarContent", { fg = themer.accent, bg = themer.orange })

winbar.eval = function()
    if vim.api.nvim_eval_statusline("%f",{})["str"] == "[No Name]" then
        return ""
    end
    return "%#WinBarSeparator#"
        .. " "
        .. "%*"
        .. "%#WinBarContent#"
        .. "%f"
        .. "%*"
        .. "%#WinBarSeparator#"
        .. ""
        .. "%*"
end

return winbar
