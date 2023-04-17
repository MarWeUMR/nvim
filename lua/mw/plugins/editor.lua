return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    dependencies = { "hrsh7th/nvim-cmp" },
    config = function()
      local autopairs = require "nvim-autopairs"
      local Rule = require "nvim-autopairs.rule"
      local cmp_autopairs = require "nvim-autopairs.completion.cmp"
      require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
      autopairs.setup {
        close_triple_quotes = true,
        check_ts = true,
        fast_wrap = { map = "<c-e>" },
        ts_config = {
          lua = { "string" },
        },
      }
      -- credit: https://github.com/JoosepAlviste
      autopairs.add_rules {
        -- Typing n when the| -> then|end
        Rule("then", "end", "lua"):end_wise(function(opts)
          return string.match(opts.line, "^%s*if") ~= nil
        end),
      }
    end,
  },

  {
    "akinsho/bufferline.nvim",
    version = "v3.*",
    event = "UIEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("bufferline").setup {
        options = {
          mode = "buffers",
          themable = true,
          sort_by = "insert_after_current",
          right_mouse_command = "vert sbuffer %d",
          show_close_icon = false,
          show_buffer_close_icons = true,
          indicator = {
            icon = "▎",
            style = "icon",
          },
          diagnostics_update_in_insert = false,
          hover = { enabled = true, reveal = { "close" } },
          separator_style = "thick", -- "slant", --| "slope" | "thick" | "thin" | { "any", "any" },
          offsets = {
            {
              text = "EXPLORER",
              filetype = "neo-tree",
              highlight = "PanelHeading",
              text_align = "left",
              separator = true,
            },

            {
              text = " DIFF VIEW",
              filetype = "DiffviewFiles",
              highlight = "PanelHeading",
              separator = true,
            },
          },
        },
      }
    end,
    keys = {
      {
        "H",
        "<Cmd>BufferLineCyclePrev<CR>",
        desc = "Prev. Buffer",
      },
      {
        "L",
        "<Cmd>BufferLineCycleNext<CR>",
        desc = "Next Buffer",
      },
      {
        "<leader>BD",
        "<Cmd>BufferLinePickClose<CR>",
        desc = "Buffer Pick Close",
      },
    },
  },

  {
    "stevearc/dressing.nvim", -- Utilises Neovim UI hooks to manage inputs, selects etc
    event = "VeryLazy",
    config = true,
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
    "j-hui/fidget.nvim",
    event = { "LspAttach" },
    opts = {
      text = {
        spinner = {
          "⊚∙∙∙∙",
          "∙⊚∙∙∙",
          "∙∙⊚∙∙",
          "∙∙∙⊚∙",
          "∙∙∙∙⊚",
          "∙∙∙⊚∙",
          "∙∙⊚∙∙",
          "∙⊚∙∙∙",
        },
        done = "",
        commenced = "Started",
        completed = "Completed",
      },
      window = {
        relative = "editor",
        blend = 0,
      },
      fmt = {
        stack_upwards = false,
        fidget = function(fidget_name, spinner)
          return string.format("%s %s", spinner, fidget_name)
        end,
        -- function to format each task line
        task = function(task_name, message, percentage)
          return string.format(
            "%s%s [%s]",
            message,
            percentage and string.format(" (%s%%)", percentage) or "",
            task_name
          )
        end,
      },
    },
  },
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
        "<Leader>o",
        function()
          require("nvim-navbuddy").open()
        end,
        desc = "Open Navbuddy",
      },
    },
  },
}
