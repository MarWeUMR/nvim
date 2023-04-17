local highlight = mw.highlight
local icons = mw.styles.icons

local plugins = {

  {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree",
    version = false,
    keys = {
      {
        "<leader>fe",
        function()
          require("neo-tree.command").execute { toggle = true, dir = mw.get_root() }
        end,
        desc = "Explorer NeoTree (root dir)",
      },
      {
        "<leader>fE",
        function()
          require("neo-tree.command").execute { toggle = true, dir = vim.loop.cwd() }
        end,
        desc = "Explorer NeoTree (cwd)",
      },
      { "<leader>e", "<leader>fe", desc = "Explorer NeoTree (root dir)", remap = true },
      -- this key is used to force open the cwd of the currently opened buffer. E.g. useful for notes
      { "<leader>E", "<cmd>Neotree toggle reveal_force_cwd<cr>", desc = "Explorer NeoTree (cwd)", remap = true },
    },
    config = function()
      highlight.plugin("NeoTree", {
        -- stylua: ignore
        theme = {
          ['*'] = {
            { NeoTreeNormal = { link = 'PanelBackground' } },
            { NeoTreeNormalNC = { link = 'PanelBackground' } },
            { NeoTreeRootName = { underline = true } },
            { NeoTreeCursorLine = { link = 'Visual' } },
            { NeoTreeStatusLine = { link = 'PanelSt' } },
            { NeoTreeTabActive = { bg = { from = 'PanelBackground' }, bold = true } },
            { NeoTreeTabInactive = { bg = { from = 'PanelDarkBackground', alter = 0.15 }, fg = { from = 'Comment' } } },
            { NeoTreeTabSeparatorInactive = { inherit = 'NeoTreeTabInactive', fg = { from = 'PanelDarkBackground', attr = 'bg' } } },
            { NeoTreeTabSeparatorActive = { inherit = 'PanelBackground', fg = { from = 'Comment' } } },
          },
        },
      })

      vim.g.neo_tree_remove_legacy_commands = 1

      require("neo-tree").setup {
        sources = { "filesystem", "buffers", "git_status" },
        source_selector = { winbar = true, separator_active = " " },
        enable_git_status = true,
        git_status_async = true,
        event_handlers = {
          {
            event = "neo_tree_buffer_enter",
            handler = function()
              highlight.set("Cursor", { blend = 100 })
            end,
          },
          {
            event = "neo_tree_buffer_leave",
            handler = function()
              highlight.set("Cursor", { blend = 0 })
            end,
          },
          {
            event = "neo_tree_window_after_close",
            handler = function()
              highlight.set("Cursor", { blend = 0 })
            end,
          },
        },
        filesystem = {
          hijack_netrw_behavior = "open_current",
          use_libuv_file_watcher = true,
          group_empty_dirs = true,
          follow_current_file = true,
          filtered_items = {
            visible = true,
            hide_dotfiles = false,
            hide_gitignored = true,
            never_show = { ".DS_Store" },
          },
          window = {
            mappings = {
              ["/"] = "noop",
              ["g/"] = "fuzzy_finder",
            },
          },
        },
        default_component_configs = {
          icon = {
            folder_empty = icons.documents.open_folder,
          },
          diagnostics = {
            highlights = {
              hint = "DiagnosticHint",
              info = "DiagnosticInfo",
              warn = "DiagnosticWarn",
              error = "DiagnosticError",
            },
          },
          modified = {
            symbol = icons.misc.circle .. " ",
          },
          git_status = {
            symbols = {
              added = icons.git.add,
              deleted = icons.git.remove,
              modified = icons.git.mod,
              renamed = icons.git.rename,
              untracked = "",
              ignored = "",
              unstaged = "",
              staged = "",
              conflict = "",
            },
          },
        },
      }
    end,
  },

  {
    "nvim-telescope/telescope-file-browser.nvim",
    event = "VeryLazy",
    config = function()
      require("telescope").load_extension "file_browser"
    end,
  },
}

return plugins
