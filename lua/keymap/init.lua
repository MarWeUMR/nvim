require("keymap.config")
local key = require("core.keymaps")
local nmap = key.nmap
local tmap = key.tmap
local silent, noremap = key.silent, key.noremap
local opts = key.new_opts
local cmd = key.cmd
local plug = key.plug

local map = vim.keymap.set
-- local function map(mode, lhs, rhs, opts)
-- 	local options = { noremap = true, silent = true }
-- 	if opts then
-- 		options = vim.tbl_extend("force", options, opts)
-- 	end
-- 	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
-- end

-- usage of plugins
nmap({
	-- packer
	{ "<Leader>pu", cmd("PackerUpdate"), opts(noremap, silent) },
	{ "<Leader>pi", cmd("PackerInstall"), opts(noremap, silent) },
	{ "<Leader>pc", cmd("PackerCompile"), opts(noremap, silent) },

	-- neo-tree
	{ "<Leader>e", cmd("NeoTreeRevealToggle"), opts(noremap, silent) },
	-- leap
	{ "s", plug("(leap-forward)"), opts(noremap, silent) },
	{ "S", plug("(leap-backward)"), opts(noremap, silent) },
	-- Telescope
	{ "<Leader>B", cmd("Telescope buffers"), opts(noremap, silent) },
	{ "<Leader>fg", cmd("Telescope live_grep"), opts(noremap, silent) },
	{ "<Leader>ff", cmd("Telescope find_files"), opts(noremap, silent) },
	{ "<Leader><Leader>", cmd("Telescope current_buffer_fuzzy_find"), opts(noremap, silent) },
	{ "<Leader>gs", cmd("Telescope current_buffer_fuzzy_find"), opts(noremap, silent) },
	-- Lsp Saga
	{ "gh", cmd("Lspsaga lsp_finder"), opts(noremap, silent) },
	{ "<Leader>lr", cmd("Lspsaga rename"), opts(noremap, silent) },
	-- { "<Leader>o", cmd("LSoutlineToggle"), opts(noremap, silent) },
	{ "K", cmd("Lspsaga hover_doc"), opts(noremap, silent) },
	{ "<Leader>la", cmd("Lspsaga code_action"), opts(noremap, silent) },
	{ "<Leader>pd", cmd("Lspsaga peek_definition"), opts(noremap, silent) },
	{ "<Leader>lF", cmd("Lspsaga show_line_diagnostics"), opts(noremap, silent) },
	{ "<Leader>lI", cmd("Lspsaga show_cursor_diagnostics"), opts(noremap, silent) },
	{ "<Leader>9", cmd("Lspsaga diagnostic_jump_next"), opts(noremap, silent) },
	{ "<Leader>8", cmd("Lspsaga diagnostic_jump_prev"), opts(noremap, silent) },
	-- Trouble
	{ "<Leader>xx", cmd("TroubleToggle"), opts(noremap, silent) },
	-- Toggleterm
	{ "<C-t>", cmd("ToggleTerm"), opts(noremap, silent) },
	-- Bufferline
	{ "<S-l>", cmd("BufferLineCycleNext"), opts(noremap, silent) },
	{ "<S-h>", cmd("BufferLineCyclePrev"), opts(noremap, silent) },
	{ "<Leader>bb", cmd("BufferLinePick"), opts(noremap, silent) },
	{ "<Leader>bk", cmd("BufferLinePickClose"), opts(noremap, silent) },
	{ "<Leader>bd", cmd("bdelete"), opts(noremap, silent) },
	-- Tabbing
	{ "<Leader><tab>", cmd("tabnext"), opts(noremap, silent) },
	{ "<Leader>tq", cmd("tabc"), opts(noremap, silent) },
	-- Zen
	{ "<Leader>za", cmd("TZAtaraxis"), opts(noremap, silent) },
	-- Aerial
	{ "<Leader>o", cmd("AerialToggle!"), opts(noremap, silent) },
})

tmap({
	{ "<C-t>", cmd("ToggleTerm"), opts(noremap, silent) },
	{ "<C-t>", cmd("ToggleTerm"), opts(noremap, silent) },
})

map("n", "<Leader>gs", require("utils.telescope-commands").git_status)
map("n", "<Leader>ls", require("telescope.builtin").lsp_document_symbols)
map("n", "<Leader>cc", "<CMD>ToggleTermSendCurrentLine<CR>")
map("v", "<Leader>vv", "<CMD>ToggleTermSendVisualLines<CR>")
