--- This enables to copy/paste from or into nvim over ssh
--- To copy, you can simply yank using 'y', but to paste you need ctrl + shift + v
return {
	{
		"ojroques/nvim-oscyank",
		config = function()
			local function copy(lines, _)
				require("osc52").copy(table.concat(lines, "\n"))
			end

			local function paste()
				return { vim.fn.split(vim.fn.getreg(""), "\n"), vim.fn.getregtype("") }
			end

			vim.g.clipboard = {
				name = "osc52",
				copy = { ["+"] = copy, ["*"] = copy },
				paste = { ["+"] = paste, ["*"] = paste },
			}
		end,
	},
}
