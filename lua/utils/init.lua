local api = vim.api
local fmt = string.format

local utils = {}
local home = vim.env.HOME

function utils.get_config_path()
	local config = os.getenv("XDG_CONFIG_DIR")
	if not config then
		return home .. "/.config/nvim"
	end
	return config
end

function utils.get_data_path()
	local data = os.getenv("XDG_DATA_DIR")
	if not data then
		return home .. "/.local/share/nvim"
	end
	return data
end

function utils.get_cache_path()
	local cache = os.getenv("XDG_CACHE_DIR")
	if not cache then
		return home .. "/.cache/nvim/"
	end
end

--- Convert a list or map of items into a value by iterating all it's fields and transforming
--- them with a callback
---@generic T : table
---@param callback fun(T, T, key: string | number): T
---@param list T[]
---@param accum T?
---@return T
function utils.fold(callback, list, accum)
	accum = accum or {}
	for k, v in pairs(list) do
		accum = callback(accum, v, k)
		assert(accum ~= nil, "The accumulator must be returned on each iteration")
	end
	return accum
end

--- Validate the keys passed to core.augroup are valid
---@param name string
---@param cmd autocommand
local function validate_autocmd(name, cmd)
	local keys = { "event", "buffer", "pattern", "desc", "command", "group", "once", "nested" }
	local incorrect = utils.fold(function(accum, _, key)
		if not vim.tbl_contains(keys, key) then
			table.insert(accum, key)
		end
		return accum
	end, cmd, {})
	if #incorrect == 0 then
		return
	end
	vim.schedule(function()
		vim.notify("Incorrect keys: " .. table.concat(incorrect, ", "), "error", {
			title = fmt("Autocmd: %s", name),
		})
	end)
end

---Create an autocommand
---returns the group ID so that it can be cleared or manipulated.
---@param name string
---@param commands Autocommand[]
---@return number
function utils.augroup(name, commands)
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

return utils
