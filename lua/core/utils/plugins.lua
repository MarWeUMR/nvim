local M = {}
local fmt = string.format

---Require a plugin config
---@param name string
---@return any
function M.conf(name)
    return require(fmt("plugins.%s", name))
end

return M
