return {
  { "nvim-neo-tree/neo-tree.nvim", version = false },
  {
    version = false,
    "echasnovski/mini.ai",
    event = "VeryLazy",
  },

  {
    "echasnovski/mini.surround",
    version = false,
    event = "VeryLazy",
  },

  {
    "echasnovski/mini.move",
    version = false,
    event = "VeryLazy",
    config = function(_, opts)
      require("mini.move").setup(opts)
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    version = false,
    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      -- { "nvim-telescope/telescope-project.nvim" },
      { "debugloop/telescope-undo.nvim" },
    },
    keys = {
      {
        "<leader>fp",
        function()
          require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
        end,
        desc = "Find Plugin File",
      },
      { "<leader>fg", require("lazyvim.util").telescope("live_grep"), desc = "Find in Files (Grep)" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      { "<leader>ff", require("lazyvim.util").telescope("find_files"), desc = "Find Files" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
      { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "commits" },
      { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "status" },
      { "<leader>ha", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
      { "<leader>hc", "<cmd>Telescope commands<cr>", desc = "Commands" },
      { "<leader>hk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
      { "<leader>ho", "<cmd>Telescope vim_options<cr>", desc = "Options" },
      { "<leader>hs", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
      { "<leader>ht", "<cmd>Telescope builtin<cr>", desc = "Telescope" },
      { "<tab><tab>", "<cmd>Telescope harpoon marks<cr>", desc = "Harpoon" },
      { "<leader><space>", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
      { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
      { "<leader>fu", "<cmd>Telescope undo<cr>", desc = "Undo" },
      { "<leader>pc", "<cmd>require('telescope').extensions.project.project{}<cr>", desc = "Create Project" },
      { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
      {
        "<leader>ss",
        require("lazyvim.util").telescope("lsp_document_symbols", {
          symbols = {
            "Class",
            "Function",
            "Method",
            "Constructor",
            "Interface",
            "Module",
            "Struct",
            "Trait",
            "Field",
            "Property",
          },
        }),
        desc = "Goto Symbol",
      },
      {
        "<leader>fP",
        "<CMD>Telescope projects<CR>",
        desc = "Find project",
      },
    },
    -- change some options
    opts = {
      defaults = {
        path_display = { "truncate" },
        winblend = 5,
        dynamic_preview_title = true,
        set_env = { ["TERM"] = vim.env.TERM },
        vimgrep_arguments = {
          "rg",
          "--follow",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--no-ignore",
          "--trim",
        },
        mappings = {
          i = {
            ["<esc>"] = function(...)
              return require("telescope.actions").close(...)
            end,
            ["<c-t>"] = function(...)
              return require("trouble.providers.telescope").open_with_trouble(...)
            end,
            ["<C-i>"] = function()
              require("lazyvim.util").telescope("find_files", { no_ignore = true })()
            end,
            ["<C-h>"] = function()
              require("lazyvim.util").telescope("find_files", { hidden = true })()
            end,
            ["<C-Down>"] = function(...)
              return require("telescope.actions").cycle_history_next(...)
            end,
            ["<C-Up>"] = function(...)
              return require("telescope.actions").cycle_history_prev(...)
            end,
            ["<C-f>"] = function(...)
              return require("telescope.actions").preview_scrolling_up(...)
            end,
            ["<C-b>"] = function(...)
              return require("telescope.actions").preview_scrolling_down(...)
            end,
            ["<C-j>"] = function(...)
              return require("telescope.actions").move_selection_next(...)
            end,
            ["<C-k>"] = function(...)
              return require("telescope.actions").move_selection_previous(...)
            end,
            ["<C-z>"] = function(...)
              return require("telescope.actions").to_fuzzy_refine(...)
            end,
            ["<C-l>"] = function(...)
              return require("telescope.actions.layout").cycle_layout_next(...)
            end,
          },
        },
        layout_strategy = "flex",
        layout_config = {
          flex = { flip_columns = 150 },
        },
        extensions = {
          project = {
            base_dirs = {
              "~/Projects",
            },
          },
          undo = {
            use_delta = true,
            side_by_side = true,
            layout_strategy = "vertical",
            layout_config = {
              preview_height = 0.4,
            },
          },
        },
        pickers = {
          colorscheme = {
            enable_preview = true,
          },
        },
      },
    },
    -- apply the config and additionally load fzf-native

    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      telescope.load_extension("fzf")
      telescope.load_extension("projects")
      telescope.load_extension("undo")
      telescope.load_extension("harpoon")
    end,
  },

  -- toggleterm
  {
    "akinsho/toggleterm.nvim",
    keys = {
      { "<C-t>", "<cmd>ToggleTerm<cr>", desc = "ToggleTerm" },
      { "<C-t>", "<cmd>ToggleTerm<cr>", desc = "ToggleTerm", mode = "t" },
    },
    config = function()
      require("toggleterm").setup({
        direction = "float",
      })
    end,
  },
  {
    "stevearc/aerial.nvim",
    event = "VeryLazy",
    version = false,
    -- cmd = "AerialToggle!",
    keys = { { "<leader>o", "<cmd>AerialToggle!<cr>", desc = "Aerial" } },
    opts = {
      layout = {
        default_direction = "right",
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/playground",
    },
    version = false,
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "bash",
        "help",
        "html",
        "fish",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "rust",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      })

      opts.incremental_selection = {
        enable = true,
        keymaps = {
          -- mappings for incremental selection (visual mappings)
          init_selection = "<CR>", -- maps in normal mode to init the node/scope selection
          node_incremental = "<CR>", -- increment to the upper named parent
          node_decremental = "<BS>", -- decrement to the previous node
        },
      }

      opts.playground = {
        enable = true,
        disable = {},
        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = false, -- Whether the query persists across vim sessions
        keybindings = {
          toggle_query_editor = "o",
          toggle_hl_groups = "i",
          toggle_injected_languages = "t",
          toggle_anonymous_nodes = "a",
          toggle_language_display = "I",
          focus_language = "f",
          unfocus_language = "F",
          update = "R",
          goto_node = "<cr>",
          show_help = "?",
        },
      }
      opts.query_linter = {
        enable = true,
        use_virtual_text = true,
        lint_events = { "BufWrite", "CursorHold" },
      }
    end,
  },
}
