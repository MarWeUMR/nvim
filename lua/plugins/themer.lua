local status_ok, themer = pcall(require, "themer")
if not status_ok then
	return
end

themer.setup({
colorscheme = "doom_one",
        styles = {
          ["function"] = { style = "italic" },
          functionbuiltin = { style = "italic" },
          variable = { style = "italic" },
          variableBuiltIn = { style = "italic" },
          parameter = { style = "italic" },
        },
})

