local config = {}

function config.tokyo()
  require("tokyonight").setup({
    on_highlights = function(hl, c)
      local prompt = "#2d3149"
      hl.TelescopeNormal = {
        bg = c.bg_dark,
        fg = c.fg_dark,
      }
      hl.TelescopeBorder = {
        bg = c.bg_dark,
        fg = c.bg_dark,
      }
      hl.TelescopePromptNormal = {
        bg = prompt,
      }
      hl.TelescopePromptBorder = {
        bg = prompt,
        fg = prompt,
      }
      hl.TelescopePromptTitle = {
        bg = prompt,
        fg = prompt,
      }
      hl.TelescopePreviewTitle = {
        bg = c.bg_dark,
        fg = c.bg_dark,
      }
      hl.TelescopeResultsTitle = {
        bg = c.bg_dark,
        fg = c.bg_dark,
      }
    end,
  })

  vim.cmd("colorscheme tokyonight-storm")
end

function config.cat()
  require("catppuccin").setup({
    flavour = "mocha", -- latte, frappe, macchiato, mocha
    background = { -- :h background
      light = "latte",
      dark = "frappe",
    },
    compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
    transparent_background = false,
    term_colors = false,
    dim_inactive = {
      enabled = false,
      shade = "dark",
      percentage = 0.15,
    },
    styles = {
      comments = { "italic" },
      conditionals = { "italic" },
      loops = {},
      functions = {},
      keywords = {},
      strings = {},
      variables = {},
      numbers = {},
      booleans = {},
      properties = {},
      types = {},
      operators = {},
    },
    color_overrides = {},
    custom_highlights = {},
    integrations = {
      cmp = true,
      gitsigns = true,
      nvimtree = true,
      telescope = true,
      treesitter = true,
      -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
    },
  })
end

function config.kanagawa()
  vim.cmd("colorscheme kanagawa")
end

function config.zephyr()
  vim.cmd("colorscheme zephyr")
end

function config.onedark()
  require("onedark").setup({
    style = "warmer",
  })
end

function config.themer()
  require("themer").setup({})
end

function config.neosolarized()
  local NeoSolarized = require("NeoSolarized")

  -- Default Setting for NeoSolarized

  NeoSolarized.setup({
    style = "dark", -- "dark" or "light"
    transparent = false, -- true/false
    terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
    enable_italics = true, -- Italics for different hightlight groups (eg. Statement, Condition, Comment, Include, etc.)
    styles = {
      -- Style for different style groups
      comments = { italic = true },
      keywords = { italic = true },
      functions = { bold = true },
      variables = {},
      string = { italic = true },
      underline = true, -- true/false; for global underline
      undercurl = true, -- true/false; for global undercurl
    },
  })
end

function config.galaxyline()
  require("modules.ui.eviline")
end

function config.alpha()
  local alpha = require("alpha")
  local dashboard = require("alpha.themes.dashboard")

  local heading = {
    type = "text",
    val = {
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡰⢄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠀⠀⠀⠀⢀⢄⠀⠀⡴⠁⠈⡆⠀⢀⡤⡀⠀⠀⠀⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⠢⣄⠀⠀⡇⠀⡕⠀⢸⠀⢠⠃⠀⢮⠀⠹⠀⠀⣠⢾⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡇⣞⠀⢀⠇⠀⡇⠀⡸⠀⠈⣆⠀⡸⠀⢰⠀⠀⡇⣸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⠘⢶⣯⣊⣄⡨⠟⡡⠁⠐⢌⠫⢅⣢⣑⣵⠶⠁⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣀⠀⠀⠀⠀⠀⣼⣀⠀⢀⠒⠒⠂⠉⠀⠀⠀⠀⠁⠐⠒⠂⡀⠀⣸⣄⠀⠀⠀⠀⠀⣀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⢮⣵⣶⣦⡩⡲⣄⠀⠀⣿⣿⣽⠲⠭⣥⣖⣂⣀⣀⣀⣀⣐⣢⡭⠵⠖⣿⣿⢫⠀⠀⣠⣖⣯⣶⣶⣮⡷⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⢸⡟⢉⣉⠙⣿⣿⣦⠀⣿⣿⣿⣿⣷⣲⠶⠤⠭⣭⡭⠭⠴⠶⣖⣾⣿⣿⡿⢸⢀⣼⣿⡿⠋⣉⠉⢳⠁⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠮⣳⣴⣫⠂⠘⣿⣿⣇⢷⢻⣿⣿⣿⣿⣿⣷⣶⣶⣶⣶⣿⣿⣿⣿⣿⢿⢃⡟⣼⣿⣿⠁⠸⣘⣢⣚⠜⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⠈⢧⢻ ⣿⣿⣟⠻⣿⣿⣿⣿⠛⣩⣿⣿ ⢟⡞⢀⣿⣿⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⣒⣒⣦⣄⣿⣿⣿⢀⡬⣟⣯  ⣿⢷⣼⡟⢿⣿⡿⣿⣿  ⡻⣤⡀⣿⣿⣸⡠⢔⣒⡒⢤⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⠀⠀⠀⠀⠀⠀⠀⢾⣟⣅⠉⢎⣽⣿⣿⡏⡟⣤⣮⣿⣿  ⡏⣿⠀⠀⣿⢡⣷  ⣿⣟⢎⣷⢻⣿⣿⣾⡟⠉⣽⡇⡇⠀⠀⠀⠀⠀⠀⠀⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠀⠀⠀⠀⠀⡴⣫⣭⣭⣍⡲⢄⠀⠀⠀⠀⠈⠻⠋⣠⡮⣻⣿⣿⠃⠳⣏⣼⣿⣿⣿⣿⡇⣿⣴⣴⣿⣾⣿⣿⣿⡿⣄⣩⠏⢸⣿⣿⣿⣧⡀⠛⠞⠁⠀⠀⠀⢀⣤⣺⣭⣭⣭⡝⢦⠀⠀⠀⠀⠀⠀",
      "⠀⠀⠀⠀⠀⢸⢹⡟⠁⠀⠉⢫⡳⣵⣄⠀⠀⢀⠴⢊⣿⣾⣿⣿⣿⠀⠀⠀⠻⣬⣽⣿⣿⣿⣿  ⣿⣿⣿⣿⣯⣵⠏⠀⠀⢸⣿⣿⣿⣿⣿⣗⢤⡀⠀⠀⣠⣿⢟⠟⠉⠀⠈⢻⢸⡆⠀⠀⠀⠀⠀",
      "⠀⠀⠀⠀⠀⠘⢏⢧⣤⡀⠀⠀⣇⢻⣿⣆⢔⢕⣵⠟⣏⣿⣿⣿⠋⣵⠚⠄⣾⣿⣿⣿⡿⠟⣛⣛⣛⣛⠻⣿⣿⣿⣿⣧⢰⠓⣏⠻⣿⣿⣿⢹⠻⣿⣿⢦⣸⣿⡏⡾⠀⠀⢠⣤⠎⡼⠀⠀⠀⠀⠀⠀",
      "⠀⠀⠀⠀⠀⠀⠈⠑⠂⠁⠀⠀⣿⠸⣿⢏⢂⣾⠇⠀⣿⣿⣿⡇⡆⠹⢷⣴⣿⡿⠟⠉⣐⡀⠄⣠⡄⡠⣁⡠⠙⠻⢿⣿⣴⡾⠃⢠⢹⣿⣿⢸⠀⢹⣿⣷⢹⣿⢃⡇⠀⠀⠈⠒⠋⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⡀⣿⢀⣿⣿⡀⠀⢫⣿⣿⣷⣙⠒⠀⠄⠐⠂⣼⠾⣵⠾⠟⣛⣛⠺⢷⣮⠷⣢⠐⠂⠀⠀⠒⣣⣾⣿⡿⡎⠀⢠⣿⣿⡄⣿⣸⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣟⣿⢸⣿⣿⣷⣄⡈⣾⣿⣿⣿⣿⣿⠻⡷⢺⠃⠠⠁⠈⠋⠀⠀⠉⠁⠙⡀⠘⡗⣾⠿⣿⣿⣿⣿⣿⡿⢀⣴⣿⣿⡿⢃⣯⣽⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⣿⡆⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣵⡞⠀⠁⠐⢁⠎⠄⣠⠀⠀⡄⠀⢳⠈⠆⠈⠈⢳⣯⣿⣿⣿⣿⣿⣿⣿⣿⣿⡏⣸⡷⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠻⣌⠛⢿⣿⣿⣿⣿⣿⣿⠿⠋⣠⣢⠂⠀⢂⠌⠀⠃⠀⠀⠘⠀⢢⡑⠀⠰⣵⡀⠻⢿⣿⣿⣿⣿⣿⣿⡿⠋⣰⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠳⣤⣭⢛⣻⠿⣿⣷⣶⢞⡟⡁⢀⢄⠎⠀⠀⠀⠀⠀⡀⠁⠀⠳⢠⠀⢈⢿⢳⣶⣾⣿⠿⣟⣛⣅⡴⠞⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠙⠛⠻⠿⠿⡟⢜⠔⡠⢊⠔⠀⡆⠀⡆⠀⠀⢡⢰⢠⠀⢢⠱⣌⢂⠃⢿⠿⠿⠟⠛⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⢤⣊⡰⠵⢺⠉⠸⠀⢰⢃⠀⠀⠀⠀⠀⠸⢸⠀⠀⡇⡞⡑⠬⢆⣑⢤⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠁⠀⠀⠀⠘⣾⡸⢀⡜⡾⡀⡇⠀⠀⡴⢠⢻⢦⠀⢃⡿⠀⠀⠀⠀⠈⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠳⡎⠀⠱⡡⠐⠀⠠⠃⢢⠋⠀⢧⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⢤⡀⢀⠔⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠱⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    },
    opts = {
      position = "center",
      hl = "AlphaHeading",
    },
  }

  local buttons = {
    type = "group",
    val = {
      { type = "padding", val = 1 },
      dashboard.button("SPC r u", "  Recently used", "<cmd>Telescope oldfiles<CR>"),
      dashboard.button("SPC f f", "  Find file", "<cmd>Telescope find_files<CR>"),
      dashboard.button("SPC f g", "  Live grep"),
      dashboard.button("p", "  Projects", "<cmd>Telescope projects<CR>"),
      dashboard.button("s", "  Sessions", "<cmd>Telescope persisted<CR>"),
    },
    position = "center",
  }

  local conf = {
    layout = {
      { type = "padding", val = 2 },
      heading,
      { type = "padding", val = 1 },
      buttons,
      { type = "padding", val = 1 },
      --loaded,
      { type = "padding", val = 1 },
      -- footing,
      { type = "padding", val = 2 },
    },
    opts = {
      margin = 5,
    },
  }

  alpha.setup(conf)
end

function config.nvim_bufferline()
  require("bufferline").setup({
    options = {
      debug = { logging = true },
      mode = "buffers", -- tabs
      sort_by = "insert_after_current",
      right_mouse_command = "vert sbuffer %d",
      show_buffer_close_icons = true,
      indicator = { style = "underline" },
      diagnostics = "nvim_lsp",
      diagnostics_update_in_insert = false,
      hover = { enabled = true, reveal = { "close" } },
      modified_icon = "✥",
      -- buffer_close_icon = "",
      always_show_bufferline = false,
    },
  })
end

function config.neo_tree()
  if not packer_plugins["plenary.nvim"].loaded then
    vim.cmd([[packadd plenary.nvim]])
  end
  -- vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
  require("neo-tree").setup({
    close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
    popup_border_style = "rounded",
    enable_git_status = true,
    enable_diagnostics = true,
    sort_case_insensitive = false, -- used when sorting files and directories in the tree
    sort_function = nil, -- use a custom function for sorting files and directories in the tree
    default_component_configs = {
      container = {
        enable_character_fade = true,
      },
      indent = {
        indent_size = 2,
        padding = 1, -- extra padding on left hand side
        -- indent guides
        with_markers = true,
        indent_marker = "│",
        last_indent_marker = "└",
        highlight = "NeoTreeIndentMarker",
        -- expander config, needed for nesting files
        with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
        expander_collapsed = "",
        expander_expanded = "",
        expander_highlight = "NeoTreeExpander",
      },
      icon = {
        folder_closed = "",
        folder_open = "",
        folder_empty = "ﰊ",
        -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
        -- then these will never be used.
        default = "*",
        highlight = "NeoTreeFileIcon",
      },
      modified = {
        symbol = "[+]",
        highlight = "NeoTreeModified",
      },
      name = {
        trailing_slash = false,
        use_git_status_colors = true,
        highlight = "NeoTreeFileName",
      },
      git_status = {
        symbols = {
          -- Change type
          added = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
          modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
          deleted = "✖", -- this can only be used in the git_status source
          renamed = "", -- this can only be used in the git_status source
          -- Status type
          untracked = "",
          ignored = "",
          unstaged = "",
          staged = "",
          conflict = "",
        },
      },
    },
    window = {
      position = "left",
      width = 40,
      mapping_options = {
        noremap = true,
        nowait = true,
      },
      mappings = {
        ["<space>"] = {
          "toggle_node",
          nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
        },
        ["<2-LeftMouse>"] = "open",
        ["<cr>"] = "open",
        ["<esc>"] = "revert_preview",
        ["P"] = { "toggle_preview", config = { use_float = true } },
        ["S"] = "open_split",
        ["s"] = "open_vsplit",
        -- ["S"] = "split_with_window_picker",
        -- ["s"] = "vsplit_with_window_picker",
        ["t"] = "open_tabnew",
        -- ["<cr>"] = "open_drop",
        -- ["t"] = "open_tab_drop",
        ["w"] = "open_with_window_picker",
        --["P"] = "toggle_preview", -- enter preview mode, which shows the current node without focusing
        ["C"] = "close_node",
        ["z"] = "close_all_nodes",
        --["Z"] = "expand_all_nodes",
        ["a"] = {
          "add",
          -- some commands may take optional config options, see `:h neo-tree-mappings` for details
          config = {
            show_path = "none", -- "none", "relative", "absolute"
          },
        },
        ["A"] = "add_directory", -- also accepts the optional config.show_path option like "add".
        ["d"] = "delete",
        ["r"] = "rename",
        ["y"] = "copy_to_clipboard",
        ["x"] = "cut_to_clipboard",
        ["p"] = "paste_from_clipboard",
        ["c"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
        -- ["c"] = {
        --  "copy",
        --  config = {
        --    show_path = "none" -- "none", "relative", "absolute"
        --  }
        --}
        ["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
        ["q"] = "close_window",
        ["R"] = "refresh",
        ["?"] = "show_help",
        ["<"] = "prev_source",
        [">"] = "next_source",
      },
    },
    nesting_rules = {},
    filesystem = {
      filtered_items = {
        visible = false, -- when true, they will just be displayed differently than normal items
        hide_dotfiles = true,
        hide_gitignored = true,
        hide_hidden = true, -- only works on Windows for hidden files/directories
        hide_by_name = {
          --"node_modules"
        },
        hide_by_pattern = { -- uses glob style patterns
          --"*.meta",
          --"*/src/*/tsconfig.json",
        },
        always_show = { -- remains visible even if other settings would normally hide it
          --".gitignored",
        },
        never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
          ".DS_Store",
          --"thumbs.db"
        },
        never_show_by_pattern = { -- uses glob style patterns
          --".null-ls_*",
        },
      },
      follow_current_file = true, -- This will find and focus the file in the active buffer every
      -- time the current file is changed while the tree is open.
      group_empty_dirs = false, -- when true, empty folders will be grouped together
      hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
      -- in whatever position is specified in window.position
      -- "open_current",  -- netrw disabled, opening a directory opens within the
      -- window like netrw would, regardless of window.position
      -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
      use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
      -- instead of relying on nvim autocmd events.
      window = {
        mappings = {
          ["<bs>"] = "navigate_up",
          ["."] = "set_root",
          ["H"] = "toggle_hidden",
          ["/"] = "fuzzy_finder",
          ["D"] = "fuzzy_finder_directory",
          ["f"] = "filter_on_submit",
          ["<c-x>"] = "clear_filter",
          ["[g"] = "prev_git_modified",
          ["]g"] = "next_git_modified",
        },
      },
    },
    git_status = {
      window = {
        position = "float",
        mappings = {
          ["A"] = "git_add_all",
          ["gu"] = "git_unstage_file",
          ["ga"] = "git_add_file",
          ["gr"] = "git_revert_file",
          ["gc"] = "git_commit",
          ["gp"] = "git_push",
          ["gg"] = "git_commit_and_push",
        },
      },
    },
  })
end

function config.fidget()
  require("fidget").setup()
end

function config.notify()
  require("notify").setup({})
end

-- function config.noice()
--   require("noice").setup({
--     views = {
--       cmdline_popup = {
--         position = {
--           row = 5,
--           col = "50%",
--         },
--         size = {
--           width = 60,
--           height = "auto",
--         },
--       },
--       popupmenu = {
--         position = {
--           row = 8,
--           col = "50%",
--         },
--         relative = "editor",
--         size = {
--           width = 60,
--           height = 10,
--         },
--         border = {
--           style = "rounded",
--           padding = { 0, 1 },
--         },
--         win_options = {
--           winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
--         },
--       },
--     },
--     routes = {
--       {
--         filter = {
--           event = "msg_show",
--           kind = " ",
--           find = "written",
--         },
--         opts = { skip = true },
--       },
--     },
--     lsp = {
--         progress = {
--           enabled = false,
--           -- Lsp Progress is formatted using the builtins for lsp_progress. See config.format.builtin
--           -- See the section on formatting for more details on how to customize.
--           --- @type NoiceFormat|string
--           format = "lsp_progress",
--           --- @type NoiceFormat|string
--           format_done = "lsp_progress_done",
--           throttle = 1000 / 30, -- frequency to update lsp progress message
--           view = "mini",
--         },
--         hover = {
--           enabled = true,
--           view = nil, -- when nil, use defaults from documentation
--           ---@type NoiceViewOptions
--           opts = {}, -- merged with defaults from documentation
--         },
--         signature = {
--           enabled = true,
--           auto_open = true, -- Automatically show signature help when typing a trigger character from the LSP
--           view = nil, -- when nil, use defaults from documentation
--           ---@type NoiceViewOptions
--           opts = {}, -- merged with defaults from documentation
--         },
--         -- defaults for hover and signature help
--         documentation = {
--           view = "hover",
--           ---@type NoiceViewOptions
--           opts = {
--             lang = "markdown",
--             replace = true,
--             render = "plain",
--             format = { "{message}" },
--             win_options = { concealcursor = "n", conceallevel = 3 },
--           },
--         },
--       },
--   })
-- end

function config.hydra()
  local Hydra = require("hydra")

  local hint_opts = {
    position = "bottom",
    -- border = border,
    type = "window",
  }

  local ok, gitsigns = pcall(require, "gitsigns")
  if ok then
    local hint = [[
 _J_: next hunk   _s_: stage hunk        _d_: show deleted   _b_: blame line
 _K_: prev hunk   _u_: undo stage hunk   _p_: preview hunk   _B_: blame show full 
 ^ ^              _S_: stage buffer      ^ ^                 _/_: show base file
 ^ ^              _h_: file history      _v_: diff view                       ^ ^
 ^
 ^ ^                            _q_: exit
]]

    Hydra({
      name = "Git Mode",
      hint = hint,
      config = {
        color = "pink",
        invoke_on_body = true,
        hint = hint_opts,
        on_enter = function()
          gitsigns.toggle_linehl(true)
          gitsigns.toggle_deleted(true)
        end,
        on_exit = function()
          gitsigns.toggle_linehl(false)
          gitsigns.toggle_deleted(false)
        end,
      },
      mode = { "n", "x" },
      body = "<Leader>g",
      heads = {
        {
          "J",
          function()
            if vim.wo.diff then
              return "]c"
            end
            vim.schedule(function()
              gitsigns.next_hunk()
            end)
            return "<Ignore>"
          end,
          { expr = true },
        },
        {
          "K",
          function()
            if vim.wo.diff then
              return "[c"
            end
            vim.schedule(function()
              gitsigns.prev_hunk()
            end)
            return "<Ignore>"
          end,
          { expr = true },
        },
        { "s", ":Gitsigns stage_hunk<CR>", { silent = true } },
        { "u", gitsigns.undo_stage_hunk },
        { "S", gitsigns.stage_buffer },
        { "p", gitsigns.preview_hunk },
        { "h", ":DiffviewFileHistory %<CR>" },
        { "v", ":DiffviewOpen<CR>" },
        { "d", gitsigns.toggle_deleted, { nowait = true } },
        { "b", gitsigns.blame_line },
        {
          "B",
          function()
            gitsigns.blame_line({ full = true })
          end,
        },
        { "/", gitsigns.show, { exit = true } }, -- show the base of the file
        { "q", nil, { exit = true, nowait = true } },
      },
    })
  end

  local function run(method, args)
    return function()
      local dap = require("dap")
      if dap[method] then
        dap[method](args)
      end
    end
  end

  local dap_hint = [[
                  DAP
  _<CR>_: Dap UI
  _i_: step in
  _n_: step over
  _o_: step out
  _c_: continue
  _b_: toggle breakpoint
  _x_: close
  _K_: hover
^
  _q_: Exit
  ]]

  Hydra({
    name = "DAP",
    hint = dap_hint,
    mode = { "n", "x" },
    body = "<Space>d",
    config = {
      color = "pink",
      invoke_on_body = true,
    },
    heads = {
      { "<CR>", "<CMD>lua require('dapui').toggle()<CR>", { exit = true, nowait = true } },
      { "n", run("step_over"), { silent = true } },
      { "o", run("step_out"), { silent = true } },
      { "x", "<CMD>lua require('dap').close()<CR>" },
      { "b", run("toggle_breakpoint"), { silent = true } },
      { "c", "<CMD>lua require('dap').continue()<CR>" },
      { "i", run("step_into"), { silent = true } },
      { "K", "<CMD>lua require('dap.ui.widgets').hover()<CR>", { exit = true, nowait = true } },
      { "q", "", { exit = true, nowait = true } },
    },
  })
end

function config.onedark_pro()
  require("onedarkpro").setup({
    dark_theme = "onedark", -- The default dark theme
    styles = {
      comments = "italic",
      conditionals = "italic",
      keywords = "italic",
      virtual_text = "italic",
    },
    options = {
      bold = true, -- Use bold styles?
      italic = true, -- Use italic styles?
      underline = true, -- Use underline styles?
      undercurl = true, -- Use undercurl styles?

      cursorline = true, -- Use cursorline highlighting?
      transparency = false, -- Use a transparent background?
      terminal_colors = false, -- Use the theme's colors for Neovim's :terminal?
      window_unfocused_color = true, -- When the window is out of focus, change the normal background?
    },
    highlights = {
      -- Neotree
      NeoTreeRootName = { fg = "${purple}", style = "bold" },
      NeoTreeFileNameOpened = { fg = "${purple}", style = "italic" },
      -- Telescope
      TelescopeBorder = {
        fg = "${telescope_results}",
        bg = "${telescope_results}",
      },
      TelescopePromptBorder = {
        fg = "${telescope_prompt}",
        bg = "${telescope_prompt}",
      },
      TelescopePromptCounter = { fg = "${fg}" },
      TelescopePromptNormal = { fg = "${fg}", bg = "${telescope_prompt}" },
      TelescopePromptPrefix = {
        fg = "${purple}",
        bg = "${telescope_prompt}",
      },
      TelescopePromptTitle = {
        fg = "${telescope_prompt}",
        bg = "${purple}",
      },

      TelescopePreviewTitle = {
        fg = "${telescope_results}",
        bg = "${green}",
      },
      TelescopeResultsTitle = {
        fg = "${telescope_results}",
        bg = "${telescope_results}",
      },

      TelescopeMatching = { fg = "${blue}" },
      TelescopeNormal = { bg = "${telescope_results}" },
      TelescopeSelection = { bg = "${telescope_prompt}" },
    },

    vim.cmd("colorscheme onedarkpro"),
  })
end

function config.ccc()
  local ccc = require("ccc")
  local mapping = ccc.mapping
  ccc.setup({ mappings = mapping })
end

return config
