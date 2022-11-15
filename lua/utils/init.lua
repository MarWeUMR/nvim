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

local telescope = require("utils.telescope-commands")
utils.telescope = telescope

---create a mapping function factory
---@param mode string
---@param o table
---@return fun(lhs: string, rhs: string|function, opts: table|nil) 'create a mapping'
local function make_mapper(mode, o)
	-- copy the opts table as extends will mutate the opts table passed in otherwise
	local parent_opts = vim.deepcopy(o)
	---Create a mapping
	---@param lhs string
	---@param rhs string|function
	---@param opts table
	return function(lhs, rhs, opts)
		-- If the label is all that was passed in, set the opts automagically
		opts = type(opts) == "string" and { desc = opts } or opts and vim.deepcopy(opts) or {}
		vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("keep", opts, parent_opts))
	end
end

local map_opts = { remap = true, silent = true }
local noremap_opts = { silent = true }

-- A non recursive normal mapping
utils.nnoremap = make_mapper("n", noremap_opts)

---Create an nvim command
---@param name any
---@param rhs string|fun(args: CommandArgs)
---@param opts table?
function utils.command(name, rhs, opts)
	opts = opts or {}
	api.nvim_create_user_command(name, rhs, opts)
end

---Check whether or not the location or quickfix list is open
---@return boolean
function utils.is_vim_list_open()
	for _, win in ipairs(api.nvim_list_wins()) do
		local buf = api.nvim_win_get_buf(win)
		local location_list = vim.fn.getloclist(0, { filewinid = 0 })
		local is_loc_list = location_list.filewinid > 0
		if vim.bo[buf].filetype == "qf" or is_loc_list then
			return true
		end
	end
	return false
end

--- Utility function to toggle the location or the quickfix list
---@param list_type '"quickfix"' | '"location"'
---@return string?
local function toggle_list(list_type)
	local is_location_target = list_type == "location"
	local cmd = is_location_target and { "lclose", "lopen" } or { "cclose", "copen" }
	local is_open = utils.is_vim_list_open()
	if is_open then
		return vim.cmd[cmd[1]]()
	end
	local list = is_location_target and vim.fn.getloclist(0) or vim.fn.getqflist()
	if vim.tbl_isempty(list) then
		local msg_prefix = (is_location_target and "Location" or "QuickFix")
		return vim.notify(msg_prefix .. " List is Empty.", vim.log.levels.WARN)
	end

	local winnr = vim.fn.winnr()
	vim.cmd[cmd[2]]()
	if vim.fn.winnr() ~= winnr then
		vim.cmd.wincmd("p")
	end
end

function utils.toggle_qf_list()
	toggle_list("quickfix")
end

---A terser proxy for `nvim_replace_termcodes`
---@param str string
---@return string
function utils.replace_termcodes(str)
	return api.nvim_replace_termcodes(str, true, true, true)
end

---Determine if a value of any type is empty
---@param item any
---@return boolean?
function utils.empty(item)
	if not item then
		return true
	end
	local item_type = type(item)
	if item_type == "string" then
		return item == ""
	end
	if item_type == "number" then
		return item <= 0
	end
	if item_type == "table" then
		return vim.tbl_isempty(item)
	end
	return item ~= nil
end

return utils
