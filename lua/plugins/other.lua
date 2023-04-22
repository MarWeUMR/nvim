local highlight = require("util.highlight_utils").highlight

return {
  "onsails/lspkind-nvim",
  {
    "SmiteshP/nvim-navbuddy",
    event = "VeryLazy",
    dependencies = {
      "neovim/nvim-lspconfig",
      "SmiteshP/nvim-navic",
      "MunifTanjim/nui.nvim",
    },
    opts = { lsp = { auto_attach = true } },
    keys = {
      {
        "<Leader>O",
        function()
          require("nvim-navbuddy").open()
        end,
        desc = "Open Navbuddy",
      },
    },
  },

  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup({
        -- timeout = 50, -- the time in which the keys must be hit in ms. Use option timeoutlen by default
        -- timeout = vim.o.timeoutlen, -- the time in which the keys must be hit in ms. Use option timeoutlen by defaultbetter
      })
    end,
  },
  {
    "anuvyklack/hydra.nvim",
    event = "VeryLazy",
  },
  {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup({

        plugins = {
          marks = true, -- shows a list of your marks on ' and `
          registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
          -- the presets plugin, adds help for a bunch of default keybindings in Neovim
          -- No actual key bindings are created
          spelling = {
            enabled = false, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
            suggestions = 20, -- how many suggestions should be shown in the list?
          },
          presets = {
            operators = false, -- adds help for operators like d, y, ...
            motions = false, -- adds help for motions
            text_objects = false, -- help for text objects triggered after entering an operator
            windows = true, -- default bindings on <c-w>
            nav = true, -- misc bindings to work with windows
            z = false, -- bindings for folds, spelling and others prefixed with z
            g = false, -- bindings for prefixed with g
          },
        },
        -- add operators that will trigger motion and text object completion
        -- to enable all native operators, set the preset / operators plugin above
        -- operators = { gc = "Comments" },
        key_labels = {
          -- override the label used to display some keys. It doesn't effect WK in any other way.
          -- For example:
          -- ["<space>"] = "SPC",
          -- ["<cr>"] = "RET",
          -- ["<tab>"] = "TAB",
        },
        motions = {
          count = true,
        },
        icons = {
          breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
          separator = "➜", -- symbol used between a key and it's label
          group = "+", -- symbol prepended to a group
        },
        popup_mappings = {
          scroll_down = "<c-d>", -- binding to scroll down inside the popup
          scroll_up = "<c-u>", -- binding to scroll up inside the popup
        },
        window = {
          border = "double", -- none, single, double, shadow
          position = "bottom", -- bottom, top
          margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]. When between 0 and 1, will be treated as a percentage of the screen size.
          padding = { 1, 2, 1, 2 }, -- extra window padding [top, right, bottom, left]
          winblend = 0, -- value between 0-100 0 for fully opaque and 100 for fully transparent
          zindex = 1000, -- positive value to position WhichKey above other floating windows.
        },
        layout = {
          height = { min = 4, max = 25 }, -- min and max height of the columns
          width = { min = 20, max = 50 }, -- min and max width of the columns
          spacing = 3, -- spacing between columns
          align = "left", -- align columns left, center or right
        },
        ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
        hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "^:", "^ ", "^call ", "^lua " }, -- hide mapping boilerplate
        show_help = true, -- show a help message in the command line for using WhichKey
        show_keys = true, -- show the currently pressed key and its label as a message in the command line
        triggers = "auto", -- automatically setup triggers
        -- triggers = {"<leader>"} -- or specifiy a list manually
        -- list of triggers, where WhichKey should not wait for timeoutlen and show immediately
        triggers_nowait = {
          -- marks
          "`",
          "'",
          "g`",
          "g'",
          -- registers
          '"',
          "<c-r>",
          -- spelling
          "z=",
        },
        triggers_blacklist = {
          -- list of mode / prefixes that should never be hooked by WhichKey
          -- this is mostly relevant for keymaps that start with a native binding
          n = { "g" },
          i = { "j", "k" },
          v = { "j", "k" },
        },
        -- disable the WhichKey popup for certain buf types and file types.
        -- Disabled by default for Telescope
        disable = {
          buftypes = {},
          filetypes = {},
        },
      })
    end,
  },

  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
    keys = { { "<leader>u", "<Cmd>UndotreeToggle<CR>", desc = "undotree: toggle" } },
    config = function()
      vim.g.undotree_TreeNodeShape = "◦" -- Alternative: '◉'
      vim.g.undotree_SetFocusWhenToggle = 1
    end,
  },

  {
    "stevearc/aerial.nvim",
    event = "VeryLazy",
    version = false,
    config = true,
    keys = {
      {
        "<leader>o",
        function()
          require("aerial").toggle()
        end,
        desc = "aerial: toggle",
      },
    },
  },

  {
    "b0o/incline.nvim",
    event = "BufReadPre",
    config = function()
      local colors = require("tokyonight.colors").setup()
      require("incline").setup({
        highlight = {
          groups = {
            InclineNormal = { guibg = "#FC56B1", guifg = colors.black },
            InclineNormalNC = { guifg = "#FC56B1", guibg = colors.black },
          },
        },
        window = { margin = { vertical = 0, horizontal = 1 } },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          local icon, color = require("nvim-web-devicons").get_icon_color(filename)
          return { { icon, guifg = color }, { " " }, { filename } }
        end,
      })
    end,
  },

  {
    "akinsho/toggleterm.nvim",
    version = "*",
    cmd = "ToggleTerm",
    opts = {
      direction = "float",
      float_opts = {
        border = "double",
        height = function()
          return math.floor(0.9 * vim.fn.winheight("%"))
        end,
        -- width = function()
        --   return math.floor(0.9 * vim.fn.winwidth("%"))
        -- end,
        -- highlights = {
        --   background = "ToggleTerm",
        --   border = "ToggleTermBorder",
        -- },
      },
      -- direction = "horizontal",
      -- size = 8,
      -- shade_terminals = true,
      shading_factor = 3, -- Match our background
      hide_numbers = true,
      close_on_exit = true,
      start_in_insert = true,
    },
    keys = {
      { "<C-t>", "<cmd>ToggleTerm<cr>", desc = "ToggleTerm" },
      { "<C-t>", "<cmd>ToggleTerm<cr>", desc = "ToggleTerm", mode = "t" },
    },
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    dependencies = { "hrsh7th/nvim-cmp" },
    config = function()
      local autopairs = require("nvim-autopairs")
      local Rule = require("nvim-autopairs.rule")
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
      autopairs.setup({
        close_triple_quotes = true,
        check_ts = true,
        fast_wrap = { map = "<c-e>" },
        ts_config = {
          lua = { "string" },
        },
      })
      -- credit: https://github.com/JoosepAlviste
      autopairs.add_rules({
        -- Typing n when the| -> then|end
        Rule("then", "end", "lua"):end_wise(function(opts)
          return string.match(opts.line, "^%s*if") ~= nil
        end),
      })
    end,
  },
}
