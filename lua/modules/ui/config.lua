local config = {}

function config.tokyo()
  vim.cmd("colorscheme tokyonight-storm")
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
  -- Set colorscheme to NeoSolarized
  --   vim.cmd([[
  --    try
  --         colorscheme NeoSolarized
  --     catch /^Vim\%((\a\+)\)\=:E18o
  --         colorscheme default
  --         set background=dark
  --     endtry
  -- ]] )
end

function config.galaxyline()
  require("modules.ui.eviline")
end

function config.dashboard()
  -- we need to ensure, that treesitter's vim lang is loaded
  -- otherwise, commands like :PackerSync dont work on the dashboard
  -- seems to be related to notify/noice
  if not packer_plugins["nvim-treesitter"].loaded then
    vim.cmd([[packadd nvim-treesitter]])
  end

  local home = os.getenv("HOME")
  local db = require("dashboard")
  db.session_directory = home .. "/.cache/nvim/session"
  db.preview_file_height = 12
  db.preview_file_width = 80
  db.custom_center = {
    {
      icon = "  ",
      desc = "Find File                               ",
      action = "Telescope find_files find_command=rg,--hidden,--files",
      shortcut = "SPC f f",
    },
    {
      icon = "  ",
      desc = "Recently opened files                  ",
      action = "Telescope oldfiles",
      shortcut = "SPC f h",
    },
    {
      icon = "  ",
      desc = "Live grep                              ",
      action = "Telescope live_grep",
      shortcut = "SPC f w",
    },
    {
      icon = "  ",
      desc = "Update Plugins                          ",
      shortcut = "SPC p u",
      action = "PackerUpdate",
    },
  }
end

function config.nvim_bufferline()
  require("bufferline").setup({
    options = {
      modified_icon = "✥",
      buffer_close_icon = "",
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

return config
