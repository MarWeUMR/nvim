return {
  {
    "shortcuts/no-neck-pain.nvim",
    cmd = "NoNeckPain",
    keys = { { "<Leader>nn", "<CMD>NoNeckPain<CR>", desc = "No Neck Pain" } },
    opts = {
      buffers = {
        scratchPad = {
          -- set to `false` to
          -- disable auto-saving
          enabled = true,
          -- set to `nil` to default
          -- to current working directory
          location = "~/notes/",
        },
        bo = {
          filetype = "norg",
        },
        right = {
          enabled = false,
        },
      },
    },
  },
  {
    "max397574/better-escape.nvim",
    config = true,
    event = "VeryLazy",
  },
  { "NvChad/nvim-colorizer.lua", event = "VeryLazy", config = true },
  {
    "nvim-neorg/neorg",
    event = "VeryLazy",
    build = ":Neorg sync-parsers",
    opts = {
      load = {
        ["core.defaults"] = {}, -- Loads default behaviour
        ["core.norg.concealer"] = {}, -- Adds pretty icons to your documents
        ["core.norg.dirman"] = { -- Manages Neorg workspaces
          config = {
            workspaces = {
              notes = "~/notes",
            },
          },
        },
        ["core.norg.completion"] = {
          config = { engine = "nvim-cmp" },
        },
        ["core.integrations.nvim-cmp"] = {},
      },
    },
    dependencies = { { "nvim-lua/plenary.nvim" } },
    config = function(_, opts)
      require("neorg").setup(opts)
    end,
  },
  {
    "ThePrimeagen/harpoon",
    keys = {
      {
        "<Leader>H",
        function()
          require("harpoon.ui").toggle_quick_menu()
        end,
        "Harpoon Add File",
      },

      {
        "<Leader>HH",
        function()
          require("harpoon.mark").add_file()
        end,
        "Harpoon Add File",
      },
      {
        "<tab>1",
        function()
          require("harpoon.ui").nav_file(1)
        end,
        "Harpoon to File 1",
      },
      {
        "<tab>2",
        function()
          require("harpoon.ui").nav_file(2)
        end,
        "Harpoon to File 2",
      },
      {
        "<tab>3",
        function()
          require("harpoon.ui").nav_file(3)
        end,
        "Harpoon to File 3",
      },
    },
  },

  {
    "ahmedkhalf/project.nvim",
    -- can't use 'opts' because module has non standard name 'project_nvim'
    config = function()
      require("project_nvim").setup({
        patterns = {
          ".git",
          "package.json",
          ".terraform",
          "go.mod",
          "requirements.yml",
          "pyrightconfig.json",
          "pyproject.toml",
        },
        -- detection_methods = { "lsp", "pattern" },
        detection_methods = { "pattern" },
      })
    end,
  },

  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    opts = function()
      local dashboard = require("alpha.themes.dashboard")
      local logo = [[
      ██╗      █████╗ ███████╗██╗   ██╗██╗   ██╗██╗███╗   ███╗          Z
      ██║     ██╔══██╗╚══███╔╝╚██╗ ██╔╝██║   ██║██║████╗ ████║      Z    
      ██║     ███████║  ███╔╝  ╚████╔╝ ██║   ██║██║██╔████╔██║   z       
      ██║     ██╔══██║ ███╔╝    ╚██╔╝  ╚██╗ ██╔╝██║██║╚██╔╝██║ z         
      ███████╗██║  ██║███████╗   ██║    ╚████╔╝ ██║██║ ╚═╝ ██║
      ╚══════╝╚═╝  ╚═╝╚══════╝   ╚═╝     ╚═══╝  ╚═╝╚═╝     ╚═╝
      ]]

      dashboard.section.header.val = vim.split(logo, "\n")
      dashboard.section.buttons.val = {
        dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
        dashboard.button("n", " " .. " New file", ":ene <BAR> startinsert <CR>"),
        dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles <CR>"),
        dashboard.button("g", " " .. " Find text", ":Telescope live_grep <CR>"),
        dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
        dashboard.button("s", "勒" .. " Restore Session", [[:lua require("persistence").load() <cr>]]),
        dashboard.button("p", " " .. " Search Projects", ":Telescope projects<CR>"),
        dashboard.button("l", "鈴" .. " Lazy", ":Lazy<CR>"),
        dashboard.button("q", " " .. " Quit", ":qa<CR>"),
      }
      for _, button in ipairs(dashboard.section.buttons.val) do
        button.opts.hl = "AlphaButtons"
        button.opts.hl_shortcut = "AlphaShortcut"
      end
      dashboard.section.footer.opts.hl = "Type"
      dashboard.section.header.opts.hl = "AlphaHeader"
      dashboard.section.buttons.opts.hl = "AlphaButtons"
      dashboard.opts.layout[1].val = 8
      return dashboard
    end,
    config = function(_, dashboard)
      vim.b.miniindentscope_disable = true

      -- close Lazy and re-open when the dashboard is ready
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          pattern = "AlphaReady",
          callback = function()
            require("lazy").show()
          end,
        })
      end

      require("alpha").setup(dashboard.opts)

      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyVimStarted",
        callback = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          dashboard.section.footer.val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
          pcall(vim.cmd.AlphaRedraw)
        end,
      })
    end,
  },
}
