local api, fn = vim.api, vim.fn
local border, highlight = mw.styles.current.border, mw.highlight

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
  {
    "echasnovski/mini.animate",
    event = "VeryLazy",
    opts = function()
      -- don't use animate when scrolling with the mouse
      -- local mouse_scrolled = false
      -- for _, scroll in ipairs { "Up", "Down" } do
      --   local key = "<ScrollWheel" .. scroll .. ">"
      --   vim.keymap.set({ "", "i" }, key, function()
      --     mouse_scrolled = true
      --     return key
      --   end, { expr = true })
      -- end

      local animate = require "mini.animate"
      return {
        resize = {
          timing = animate.gen_timing.linear { duration = 100, unit = "total" },
        },
        scroll = {
          timing = animate.gen_timing.linear { duration = 150, unit = "total" },
          subscroll = animate.gen_subscroll.equal {
            predicate = function(total_scroll)
              if mouse_scrolled then
                mouse_scrolled = false
                return false
              end
              return total_scroll > 1
            end,
          },
        },
      }
    end,
    config = function(_, opts)
      require("mini.animate").setup(opts)
    end,
  },
  {
    "anuvyklack/hydra.nvim",
    event = "VeryLazy",
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
      { "<leader>jb", "<Cmd>Portal jumplist backward<CR>", desc = "jump: backwards" },
      { "<leader>jf", "<Cmd>Portal jumplist forward<CR>", desc = "jump: forwards" },
      { "<leader>jg", "<cmd>Portal grapple backward<cr>", desc = "jump: grapple" },
    },
    config = function()
      require("portal").setup {
        filter = function(c)
          return vim.startswith(api.nvim_buf_get_name(c.buffer), fn.getcwd())
        end,
      }
    end,
  },
  {
    "cbochs/grapple.nvim",
    cmd = { "Grapple", "GrapplePopup" },
    opts = { popup_options = { border = border } },
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
}
