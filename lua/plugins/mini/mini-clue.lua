local function table_concat(t1, t2)
  for i = 1, #t2 do
    t1[#t1 + 1] = t2[i]
  end
  return t1
end

local function surround_clues(chars)
  if not chars then
    print("Warning: surround_clues received a nil table!")
    return {}
  end

  local res = {}
  for _, char in ipairs(chars) do
    table.insert(res, { mode = "n", keys = "m" .. char, postkeys = "gzaiw" .. char })
    table.insert(res, { mode = "x", keys = "m" .. char, postkeys = "gza" .. char })
  end

  return res
end

local function bracketed_clues(chars)
  local result = {}
  for _, char in ipairs(chars) do
    table.insert(result, { mode = "n", keys = "]" .. char, postkeys = "]" })
    table.insert(result, { mode = "n", keys = "[" .. char, postkeys = "[" })
  end

  table.insert(result, { mode = "n", keys = "]<LEADER>", postkeys = "<Esc>[" })
  table.insert(result, { mode = "n", keys = "[<LEADER>", postkeys = "<Esc>]" })

  return result
end

local function leader_clues(bindings)
  local result = {}
  for _, binding in ipairs(bindings) do
    table.insert(result, { mode = "n", keys = "<leader>" .. binding[1], desc = binding[2] })
  end
  return result
end

local my_leader_clues = {
  { "f", "+Find" },
  { "b", "+Buffer" },
  -- ... (rest of your leader clues)
}

local my_clues = {}
my_clues = table_concat(my_clues, leader_clues(my_leader_clues))
my_clues = table_concat(my_clues, surround_clues({ '"', "'", "`", "(", "[", "{", "<" }))
my_clues = table_concat(my_clues, bracketed_clues({ "b", "d", "e", "h", "x" }))

return {
  {
    "echasnovski/mini.clue",
    version = false,

    config = function()
      local miniclue = require("mini.clue")
      miniclue.setup({

        clues = my_clues,

        -- clues = {
        --
        --   -- LEADER
        --   { mode = "n", keys = "<leader>cp", desc = "Copilot" },
        --   { mode = "n", keys = "<leader>P", desc = "Portal/Grapple" },
        --   { mode = "n", keys = "<leader>x", desc = "Trouble" },
        --   { mode = "n", keys = "<leader>SE", desc = "Save & Exit" },
        --   { mode = "n", keys = "<leader>-", desc = "V-Split below" },
        --   { mode = "n", keys = "<leader>|", desc = "H-Split right" },
        --   { mode = "n", keys = "<leader>bd", desc = "Del. Buffer" },
        --   { mode = "n", keys = "<leader>e", desc = "Neotree" },
        --   { mode = "n", keys = "<leader>o", desc = "Aerial" },
        --   { mode = "n", keys = "<leader>O", desc = "Navbuddy" },
        --   { mode = "n", keys = "<leader>bb", desc = "Pick Buffer" },
        --   { mode = "n", keys = "<leader>bl", desc = "Push Buffer Right" },
        --   { mode = "n", keys = "<leader>bh", desc = "Push Buffer Left" },
        --   { mode = "n", keys = "<leader>q", desc = "Quickfix" },
        --   { mode = "n", keys = "<leader>l", desc = "LSP+" },
        --   { mode = "n", keys = "<leader>T", desc = "Toggles+" },
        --   { mode = "n", keys = "<leader>dv", desc = "DiffviewHy" },
        --   { mode = "n", keys = "<leader>fg", desc = "Live Grep" },
        --   { mode = "n", keys = "<leader>ff", desc = "Find Files" },
        --   { mode = "n", keys = "<leader>gg", desc = "LazyGit" },
        --   { mode = "n", keys = "<leader>fr", desc = "Recent Files" },
        --   { mode = "n", keys = "<leader>rr", desc = "RustRunnables" },
        --   { mode = "n", keys = "<leader>,", desc = "FZF Resume" },
        -- },

        triggers = {
          { mode = "n", keys = "m" },
          { mode = "x", keys = "m" },
          -- Leader triggers
          { mode = "n", keys = "<Leader>" },
          { mode = "x", keys = "<Leader>" },

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
        },

        window = { config = { border = "double" }, delay = 100 },
      })
    end,
  },
}
