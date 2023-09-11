local as = require("util.akinsho")

return {
  ---------------- MOVE ----------------
  {
    -- provides ]/[ + xyz movements
    -- E.g.: ]c moves to the next comment, or ]h to the next git hunk
    -- mainly used with hydra to help with bindings
    "echasnovski/mini.bracketed",
    event = "VeryLazy",
    config = function()
      require("mini.bracketed").setup()
    end,
  },

  {
    -- provides 'alt+j/k' bindings to move lines up/down
    -- with 'V' selection, you can (de)indent visual selections using 'alt+h/l'
    "echasnovski/mini.move",
    event = "VeryLazy",
    config = function()
      require("mini.move").setup()
    end,
  },

  {
    "echasnovski/mini.pairs",
    enabled = false,
  },
  {
    "echasnovski/mini.clue",
    version = false,

    config = function()
      local miniclue = require("mini.clue")
      miniclue.setup({

        clues = {
          -- EC.leader_group_clues,
          miniclue.gen_clues.builtin_completion(),
          miniclue.gen_clues.g(),
          miniclue.gen_clues.marks(),
          miniclue.gen_clues.registers(),
          miniclue.gen_clues.windows({ submode_resize = true }),
          miniclue.gen_clues.z(),
          { mode = "n", keys = "<leader>f", desc = "+Find" },
          { mode = "n", keys = "<leader>b", desc = "+Buffer" },
          { mode = "n", keys = "]b", postkeys = "]" },
          { mode = "n", keys = "[b", postkeys = "[" },
          { mode = "n", keys = "]d", postkeys = "]" },
          { mode = "n", keys = "[d", postkeys = "[" },
          { mode = "n", keys = "]e", postkeys = "]" },
          { mode = "n", keys = "[e", postkeys = "[" },
          { mode = "n", keys = "]h", postkeys = "]" },
          { mode = "n", keys = "[h", postkeys = "[" },
          { mode = "n", keys = "]x", postkeys = "]" },
          { mode = "n", keys = "[x", postkeys = "[" },
          { mode = "n", keys = 'm"', postkeys = 'gzaiw"', desc = 'Add "' },
          { mode = "x", keys = 'm"', postkeys = 'gza"' },
          { mode = "n", keys = "m'", postkeys = "gzaiw'" },
          { mode = "x", keys = "m'", postkeys = "gza'" },
          { mode = "n", keys = "m´´", postkeys = "gzaiw`" },
          { mode = "x", keys = "m´´", postkeys = "gza`" },
          { mode = "n", keys = "m(", postkeys = "gzaiw)" },
          { mode = "x", keys = "m(", postkeys = "gza)" },
          { mode = "n", keys = "m[", postkeys = "gzaiw]" },
          { mode = "x", keys = "m[", postkeys = "gza]" },
          { mode = "n", keys = "m{", postkeys = "gzaiw}" },
          { mode = "x", keys = "m{", postkeys = "gza}" },
          { mode = "n", keys = "m<", postkeys = "gzaiw>" },
          { mode = "x", keys = "m<", postkeys = "gza>" },
        },

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

  {
    "echasnovski/mini.files",
    keys = {
      {
        "<leader>r",
        function()
          require("mini.files").open()
        end,
        desc = "Explorer",
      },
    },
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesBufferCreate",
        callback = function(args)
          vim.keymap.set("n", "<ESC>", function()
            require("mini.files").close()
          end, { buffer = args.buf_id })
        end,
      })
    end,
    opts = {},
  },
}
