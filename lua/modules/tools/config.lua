local config = {}

function config.telescope()
  if not packer_plugins["plenary.nvim"].loaded then
    vim.cmd([[packadd plenary.nvim]])
    vim.cmd([[packadd telescope-fzy-native.nvim]])
  end
  local telescope = require("telescope")
  local actions = require("telescope.actions")

  telescope.setup({
    defaults = {
      layout_config = {
        horizontal = { prompt_position = "top", results_width = 0.6 },
        vertical = { mirror = false },
      },
      sorting_strategy = "ascending",
      file_previewer = require("telescope.previewers").vim_buffer_cat.new,
      grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
      qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
      mappings = {
        i = {
          ["<C-f>"] = actions.preview_scrolling_up,
          ["<C-b>"] = actions.preview_scrolling_down,
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
        },
      },
      multi_icon = "✚",
      prompt_prefix = "❯ ",
      selection_caret = "▶ ",
    },
    extensions = {
      fzy_native = {
        override_generic_sorter = false,
        override_file_sorter = true,
      },
    },
  })
  require("telescope").load_extension("fzy_native")
end

function config.leap()
  -- require("leap").add_default_mappings(true)
  -- vim.api.nvim_set_hl(0, "LeapBackdrop", { link = "Comment" })
  require("leap").opts = {

    max_phase_one_targets = nil,
    highlight_unlabeled_phase_one_targets = false,
    case_sensitive = false,
    equivalence_classes = { " \t\r\n" },
    special_keys = {
      repeat_search = "<enter>",
      next_phase_one_target = "<enter>",
      next_target = { "<enter>", ";" },
      prev_target = { "<tab>", "," },
      next_group = "<space>",
      prev_group = "<tab>",
      multi_accept = "<enter>",
      multi_revert = "<backspace>",
    },
  }
end

function config.flit()
  require("flit").setup({
    keys = { f = "f", F = "F", t = "t", T = "T" },
    -- A string like "nv", "nvo", "o", etc.
    labeled_modes = "v",
    multiline = true,
    -- Like `leap`s similar argument (call-specific overrides).
    -- E.g.: opts = { equivalence_classes = {} }
    opts = {},
  })
end

function config.better_escape()
  require("better_escape").setup()
end

function config.comments()
  require("Comment").setup()
end

function config.gitsigns()
  local gitsigns = require("gitsigns")

  local function on_attach(bufnr)
    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    local gs = package.loaded.gitsigns

    -- Navigation
    map("n", "<Leader>2", function()
      if vim.wo.diff then
        return "]c"
      end
      vim.schedule(gitsigns.next_hunk)
      return "<Ignore>"
    end, { expr = true })

    map("n", "<Leader>1", function()
      if vim.wo.diff then
        return "[c"
      end
      vim.schedule(gitsigns.prev_hunk)
      return "<Ignore>"
    end, { expr = true })

    -- Actions
    map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>")
    map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>")
    map("n", "<leader>hu", gs.undo_stage_hunk)
    map("n", "<leader>hp", gs.preview_hunk)
    map("n", "<leader>hb", function()
      gs.blame_line({ full = true })
    end)
    map("n", "<leader>tb", gs.toggle_current_line_blame)
    map("n", "<leader>hd", gs.diffthis)
    map("n", "<leader>hD", function()
      gs.diffthis("~")
    end)
    map("n", "<leader>td", gs.toggle_deleted)
  end

  gitsigns.setup({
    debug_mode = true,
    max_file_length = 1000000000,
    signs = {
      add = { show_count = false },
      change = { show_count = false },
      delete = { show_count = true },
      topdelete = { show_count = true },
      changedelete = { show_count = true },
    },
    on_attach = on_attach,
    preview_config = {
      border = "rounded",
    },
    current_line_blame = true,
    current_line_blame_formatter_opts = {
      relative_time = true,
    },
    current_line_blame_opts = {
      delay = 50,
    },
    count_chars = {
      "⒈",
      "⒉",
      "⒊",
      "⒋",
      "⒌",
      "⒍",
      "⒎",
      "⒏",
      "⒐",
      "⒑",
      "⒒",
      "⒓",
      "⒔",
      "⒕",
      "⒖",
      "⒗",
      "⒘",
      "⒙",
      "⒚",
      "⒛",
    },
    update_debounce = 50,
    _extmark_signs = true,
    _threaded_diff = true,
    word_diff = false,
  })
end

function config.dap()
  local dap = require("dap")

  dap.configurations.cpp = {
    {
      name = "Launch",
      type = "lldb",
      request = "launch",
      program = function()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
      args = {},
    },
  }

  -- If you want to use this for Rust and C, add something like this:
  dap.configurations.rust = dap.configurations.cpp
end

function config.dap_ui()
  require("dapui").setup()
end

function config.trouble()
  require("trouble").setup({})
end

function config.toggleterm()
  require("toggleterm").setup({
    direction = "float",
    open_mapping = [[<c-\>]],
  })
end

function config.persisted()
  require("persisted").setup()
  require("telescope").load_extension("persisted")
end

function config.project()
  require("project_nvim").setup()
  require("telescope").load_extension("projects")
end

function config.diffview()
  require("diffview").setup({
    default_args = {
      DiffviewFileHistory = { "%" },
    },
    hooks = {
      diff_buf_read = function()
        vim.wo.wrap = false
        vim.wo.list = false
        vim.wo.colorcolumn = ""
      end,
    },
    enhanced_diff_hl = true,
    keymaps = {
      view = { q = "<Cmd>DiffviewClose<CR>" },
      file_panel = { q = "<Cmd>DiffviewClose<CR>" },
      file_history_panel = { q = "<Cmd>DiffviewClose<CR>" },
    },
  })
end

function config.gh()
  require("litee.lib").setup()
  require("litee.gh").setup({
    -- deprecated, around for compatability for now.
    jump_mode = "invoking",
    -- remap the arrow keys to resize any litee.nvim windows.
    map_resize_keys = false,
    -- do not map any keys inside any gh.nvim buffers.
    disable_keymaps = false,
    -- the icon set to use.
    icon_set = "default",
    -- any custom icons to use.
    icon_set_custom = nil,
    -- whether to register the @username and #issue_number omnifunc completion
    -- in buffers which start with .git/
    git_buffer_completion = true,
    -- defines keymaps in gh.nvim buffers.
    keymaps = {
      -- when inside a gh.nvim panel, this key will open a node if it has
      -- any futher functionality. for example, hitting <CR> on a commit node
      -- will open the commit's changed files in a new gh.nvim panel.
      open = "<CR>",
      -- when inside a gh.nvim panel, expand a collapsed node
      expand = "zo",
      -- when inside a gh.nvim panel, collpased and expanded node
      collapse = "zc",
      -- when cursor is over a "#1234" formatted issue or PR, open its details
      -- and comments in a new tab.
      goto_issue = "gd",
      -- show any details about a node, typically, this reveals commit messages
      -- and submitted review bodys.
      details = "d",
      -- inside a convo buffer, submit a comment
      submit_comment = "<C-s>",
      -- inside a convo buffer, when your cursor is ontop of a comment, open
      -- up a set of actions that can be performed.
      actions = "<C-a>",
      -- inside a thread convo buffer, resolve the thread.
      resolve_thread = "<C-r>",
      -- inside a gh.nvim panel, if possible, open the node's web URL in your
      -- browser. useful particularily for digging into external failed CI
      -- checks.
      goto_web = "gx",
    },
  })
end

return config
