-- Generate a table containing the user defined which-key mappings.
-- The mappings are stored in 'user_maps' for further use below.
-- cheatsheet will be populated using this table.

local keys = require("which-key.keys")

local user_maps = {}
for _, tree in pairs(keys.mappings) do
	tree.tree:walk(function(node)
		if
			-- node.mapping -- only include real mappings
			node.mapping.label -- with a label
			-- and not node.mapping.group -- no groups
			-- and not node.mapping.preset -- no presets
			and node.mapping.label ~= "which_key_ignore" -- no ignored keymaps
		then
			table.insert(user_maps, {
				keys = table.concat(node.mapping.keys.nvim, ""),
				mode = node.mapping.mode,
				label = node.mapping.label,
				buf = node.mapping.buf,
				group = node.mapping.group,
				real_mapping = node.mapping
					and node.mapping.label
					and not node.mapping.group
					and not node.mapping.preset
					and node.mapping.label ~= "which_key_ignore",
			})
		end
	end)
end


local cheatsheet = require("cheatsheet")

-- This loop goes over the table (generated at the top of this file) of all user which-key mappings.
-- It then adds these mappings to the list of cheatsheet entries.
  
local last_grp = ""

for _, data in pairs(user_maps) do

	if data["group"] == true then
		last_grp = data["label"]
	end

	if data["real_mapping"] == true then
		-- print(string.format("group: %s\nlabel: %s\nkeys: %s", last_grp, data["label"], data["keys"]))

		cheatsheet.add_cheat(data["label"], data["keys"], string.format("WK-%s", last_grp))
	end
end




cheatsheet.setup({
	-- Whether to show bundled cheatsheets

	-- For generic cheatsheets like default, unicode, nerd-fonts, etc
	-- bundled_cheatsheets = {
	--     enabled = {},
	--     disabled = {},
	-- },
	bundled_cheatsheets = true,

	-- For plugin specific cheatsheets
	-- bundled_plugin_cheatsheets = {
	--     enabled = {},
	--     disabled = {},
	-- }
	bundled_plugin_cheatsheets = true,

	-- For bundled plugin cheatsheets, do not show a sheet if you
	-- don't have the plugin installed (searches runtimepath for
	-- same directory name)
	include_only_installed_plugins = true,

	-- Key mappings bound inside the telescope window
	telescope_mappings = {
		["<CR>"] = require("cheatsheet.telescope.actions").select_or_fill_commandline,
		["<A-CR>"] = require("cheatsheet.telescope.actions").select_or_execute,
		["<C-Y>"] = require("cheatsheet.telescope.actions").copy_cheat_value,
		["<C-E>"] = require("cheatsheet.telescope.actions").edit_user_cheatsheet,
	},
})


