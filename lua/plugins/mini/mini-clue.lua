local git = require("plugins.mini.clues.git")
local bracketed = require("plugins.mini.clues.bracketed")
local surround = require("plugins.mini.clues.surround")
local diffview = require("plugins.mini.clues.diffview")
local leader = require("plugins.mini.clues.leader")

local function table_concat(t1, t2)
  for i = 1, #t2 do
    t1[#t1 + 1] = t2[i]
  end
  return t1
end

local my_clues = {}
my_clues = table_concat(my_clues, surround.generate_clues())
my_clues = table_concat(my_clues, bracketed.generate_clues())
my_clues = table_concat(my_clues, git.generate_clues())
my_clues = table_concat(my_clues, diffview.generate_clues())
my_clues = table_concat(my_clues, leader.generate_clues())

return {
  {
    "echasnovski/mini.clue",
    version = false,

    config = function()
      local miniclue = require("mini.clue")
      miniclue.setup({
        clues = my_clues,

        triggers = {

          -- surround mode
          { mode = "n", keys = "m" },
          { mode = "x", keys = "m" },

          -- Leader triggers
          { mode = "n", keys = "<Leader>" },
          { mode = "x", keys = "<Leader>" },

          -- Diffview triggers
          { mode = "n", keys = "<Leader>dv" },

          -- 'mini.bracketed'
          { mode = "n", keys = "[" },
          { mode = "n", keys = "]" },
          { mode = "x", keys = "[" },
          { mode = "x", keys = "]" },

          -- Built-in completion
          { mode = "i", keys = "<C-x>" },

          -- `g` key
          { mode = "n", keys = "g" },
          { mode = "x", keys = "g" },

          -- Marks
          { mode = "n", keys = "'" },
          { mode = "n", keys = "`" },
          { mode = "x", keys = "'" },
          { mode = "x", keys = "`" },

          -- Registers
          { mode = "n", keys = '"' },
          { mode = "x", keys = '"' },
          { mode = "i", keys = "<C-r>" },
          { mode = "c", keys = "<C-r>" },

          -- Window commands
          { mode = "n", keys = "<C-w>" },

          -- `z` key
          { mode = "n", keys = "z" },
          { mode = "x", keys = "z" },

          -- git mode
          { mode = "n", keys = "gm" },
        },

        window = { config = { border = "double", width = "auto" }, delay = 100 },
      })
    end,
  },
}
