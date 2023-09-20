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
  { import = "plugins.mini.mini-clue" },
}
