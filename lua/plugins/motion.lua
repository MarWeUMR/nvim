local highlight = require("util.highlight_utils").highlight

return {

  {
    "Wansmer/treesj",
    event = "VeryLazy",
    dependencies = { "nvim-treesitter" },
    opts = { use_default_keymaps = false },
    keys = {
      { "gS", "<Cmd>TSJSplit<CR>", desc = "split expression to multiple lines" },
      { "gJ", "<Cmd>TSJJoin<CR>", desc = "join expression to single line" },
    },
  },

  {
    "Wansmer/sibling-swap.nvim",
    event = "VeryLazy",
    keys = { "]w", "[w" },
    dependencies = { "nvim-treesitter" },
    opts = {
      use_default_keymaps = false,
      highlight_node_at_cursor = true,
      keymaps = {
        ["]w"] = "swap_with_left",
        ["[w"] = "swap_with_right",
      },
    },
  },

  {
    "cbochs/portal.nvim",
    version = "*",
    cmd = { "Portal" },
    dependencies = { "cbochs/grapple.nvim" },
    init = function()
      highlight.plugin("portal", {
        { PortalNormal = { link = "Normal" } },
        { PortalBorder = { link = "Label" } },
        { PortalTitle = { link = "Label" } },
      })
    end,
    keys = {
      { "<C-o>", "<Cmd>Portal jumplist backward<CR>", desc = "jump: backwards" },
      { "<C-i>", "<Cmd>Portal jumplist forward<CR>", desc = "jump: forwards" },
      { "<leader>jg", "<cmd>Portal grapple backward<cr>", desc = "jump: grapple" },
    },
    config = function()
      require("portal").setup({
        filter = function(c)
          return vim.startswith(vim.api.nvim_buf_get_name(c.buffer), vim.fn.getcwd())
        end,
      })
    end,
  },

  {
    "cbochs/grapple.nvim",
    cmd = { "Grapple", "GrapplePopup" },
    opts = { popup_options = { border = "double" } },
    keys = {
      {
        "<leader>mt",
        function()
          require("grapple").toggle()
        end,
        desc = "grapple: toggle mark",
      },
      {
        "<leader>mm",
        function()
          require("grapple").popup_tags()
        end,
        desc = "grapple: menu",
      },
    },
  },

  {
    "chrisgrieser/nvim-spider",
    enabled = true,
    vscode = true,
    keys = {
      vim.keymap.set({ "n", "o", "x" }, "w", "<cmd>lua require('spider').motion('w')<CR>", { desc = "Spider-w" }),
      vim.keymap.set({ "n", "o", "x" }, "e", "<cmd>lua require('spider').motion('e')<CR>", { desc = "Spider-e" }),
      vim.keymap.set({ "n", "o", "x" }, "b", "<cmd>lua require('spider').motion('b')<CR>", { desc = "Spider-b" }),
    },
  },
}
