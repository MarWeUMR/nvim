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
}
