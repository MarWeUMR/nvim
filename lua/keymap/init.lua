-- TODO: ctrl + jk for Telescope
require("keymap.config")
local key = require("core.keymaps")
local nmap = key.nmap
local silent, noremap = key.silent, key.noremap
local opts = key.new_opts
local cmd = key.cmd
local plug = key.plug

local function map(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- usage of plugins
nmap({
	-- packer
	{ "<Leader>pu", cmd("PackerUpdate"), opts(noremap, silent) },
	{ "<Leader>pi", cmd("PackerInstall"), opts(noremap, silent) },
	{ "<Leader>pc", cmd("PackerCompile"), opts(noremap, silent) },
	-- dashboard
	{ "<Leader>n", cmd("DashboardNewFile"), opts(noremap, silent) },
	{ "<Leader>ss", cmd("SessionSave"), opts(noremap, silent) },
	{ "<Leader>sl", cmd("SessionLoad"), opts(noremap, silent) },
	-- neo-tree
	{ "<Leader>e", cmd("NeoTreeRevealToggle"), opts(noremap, silent) },
	-- leap
	{ "s", plug("(leap-forward)"), opts(noremap, silent) },
	{ "S", plug("(leap-backward)"), opts(noremap, silent) },
	-- Telescope
	{ "<Leader>b", cmd("Telescope buffers"), opts(noremap, silent) },
	{ "<Leader>fg", cmd("Telescope live_grep"), opts(noremap, silent) },
	{ "<Leader>ff", cmd("Telescope find_files"), opts(noremap, silent) },
	-- Lsp Saga
	{ "gh", cmd("Lspsaga lsp_finder"), opts(noremap, silent) },
	{ "<Leader>lr", cmd("Lspsaga rename"), opts(noremap, silent) },
	{ "<Leader>o", cmd("LSoutlineToggle"), opts(noremap, silent) },
	{ "K", cmd("Lspsaga hover_doc"), opts(noremap, silent) },
	{ "<Leader>la", cmd("Lspsaga code_action"), opts(noremap, silent) },
	{ "<Leader>pd", cmd("Lspsaga peek_definition"), opts(noremap, silent) },
	{ "<Leader>lF", cmd("Lspsaga show_line_diagnostics"), opts(noremap, silent) },
	{ "<Leader>9", cmd("Lspsaga diagnostic_jump_next"), opts(noremap, silent) },
	{ "<Leader>8", cmd("Lspsaga diagnostic_jump_prev"), opts(noremap, silent) },
	-- { "<Leader>du", cmd("dapui toggle"), opts(noremap, silent) },
})

-- DAP
map("n", "<Leader>du", "<CMD>lua require('dapui').toggle()<CR>" )
