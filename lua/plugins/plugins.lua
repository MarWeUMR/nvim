-- Install packer
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
end

local packer_group = vim.api.nvim_create_augroup("Packer", { clear = true })
vim.api.nvim_create_autocmd(
  "BufWritePost",
  { command = "source <afile> | PackerCompile", group = packer_group, pattern = "init.lua" }
)

return require("packer").startup(function(use)
  -- packer
  use({ "wbthomason/packer.nvim" })

  ------------------------------------------------------
  -- THEMES
  ------------------------------------------------------

  use({ "themercorp/themer.lua" })

  use({
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({})
    end,
  })

  use({ "NTBBloodbath/doom-one.nvim" })
  use({
    "folke/tokyonight.nvim",
    -- config = function()
    --   vim.g.tokyonight_style = "storm"
    --   vim.g.tokyonight_italic_functions = true
    --   vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }
    --
    --   -- Change the "hint" color to the "orange" color, and make the "error" color bright red
    --   vim.g.tokyonight_colors = { hint = "orange", error = "#ff0000" }
    --
    --   -- Load the colorscheme
    --   -- vim.cmd([[colorscheme tokyonight]])
    -- end,
  })

  -- use({
  --   "marko-cerovac/material.nvim",
  --   config = function()
  --     vim.g.material_style = "palenight"
  --     require("material").setup({
  --       contrast = {
  --         sidebars = true, -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
  --         floating_windows = true, -- Enable contrast for floating windows
  --         line_numbers = false, -- Enable contrast background for line numbers
  --         sign_column = false, -- Enable contrast background for the sign column
  --         cursor_line = true, -- Enable darker background for the cursor line
  --         non_current_windows = false, -- Enable darker background for non-current windows
  --         popup_menu = true, -- Enable lighter background for the popup menu
  --       },
  --
  --       italics = {
  --         comments = true, -- Enable italic comments
  --         keywords = true, -- Enable italic keywords
  --         functions = true, -- Enable italic functions
  --         strings = true, -- Enable italic strings
  --         variables = true, -- Enable italic variables
  --       },
  --
  --       contrast_filetypes = { -- Specify which filetypes get the contrasted (darker) background
  --         "terminal", -- Darker terminal background
  --         "toggleterm", -- Darker terminal background
  --         "packer", -- Darker packer background
  --         "qf", -- Darker qf list background
  --       },
  --
  --       high_visibility = {
  --         lighter = false, -- Enable higher contrast text for lighter style
  --         darker = false, -- Enable higher contrast text for darker style
  --       },
  --
  --       disable = {
  --         colored_cursor = true, -- Disable the colored cursor
  --         borders = false, -- Disable borders between verticaly split windows
  --         background = false, -- Prevent the theme from setting the background (NeoVim then uses your teminal background)
  --         term_colors = false, -- Prevent the theme from setting terminal colors
  --         eob_lines = false, -- Hide the end-of-buffer lines
  --       },
  --
  --       lualine_style = "default", -- Lualine style ( can be 'stealth' or 'default' )
  --
  --       async_loading = true, -- Load parts of the theme asyncronously for faster startup (turned on by default)
  --
  --       custom_highlights = {}, -- Overwrite highlights with your own
  --     })
  --     vim.cmd([[ colorscheme material ]])
  --   end,
  -- })
  use({ "Th3Whit3Wolf/space-nvim" })

  ------------------------------------------------------
  -- REST
  ------------------------------------------------------

  use({ "tyru/capture.vim" })

  use("numToStr/Comment.nvim")
  use("windwp/nvim-autopairs")
  use({ "rebelot/heirline.nvim"})
  use({ "mfussenegger/nvim-dap" })
  use({
    "stevearc/aerial.nvim",
    config = function()
      require("aerial").setup({})
    end,
  })
  use({
    "nvim-telescope/telescope.nvim",
    requires = { { "nvim-lua/plenary.nvim" } },
  })

  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

  use({ "lukas-reineke/indent-blankline.nvim" })
  use({ "Pocco81/TrueZen.nvim" })
  use({
    "folke/zen-mode.nvim",
    config = function()
      require("zen-mode").setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      })
    end,
  })

  use({
    "ggandor/leap.nvim",
    config = function()
      require("leap").setup({})
    end,
  })
  -- use({ "stevearc/dressing.nvim" })

  use("nvim-telescope/telescope-media-files.nvim")
  use("kyazdani42/nvim-web-devicons")
  -- use("nvim-lua/popup.nvim") -- An implementation of the Popup API from vim in Neovim
  use("nvim-lua/plenary.nvim") -- Useful lua functions used ny lots of plugins
  use("kyazdani42/nvim-tree.lua")
  use({ "nvim-pack/nvim-spectre" })

  ------------------------------------------------------
  -- LSP RELATED
  ------------------------------------------------------
  -- use("folke/lsp-colors.nvim")
  use({
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup({
        position = "right",
        width = 100,
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      })
    end,
  })

  use({
    "SmiteshP/nvim-gps",
    requires = "nvim-treesitter/nvim-treesitter",

    config = function()
      require("nvim-gps").setup()
    end,
  })
  use({
    "j-hui/fidget.nvim",
    config = function()
      require("fidget").setup({})
    end,
  })

  use({
    "neovim/nvim-lspconfig",
  })
  -- use("williamboman/nvim-lsp-installer")
  use("jose-elias-alvarez/null-ls.nvim") -- for formatters and linters
  use("ray-x/lsp_signature.nvim")

  -----------------------------
  -- COPILOT

  use({
    "zbirenbaum/copilot.lua",
    event = { "VimEnter" },
    config = function()
      vim.defer_fn(function()
        require("copilot").setup()
      end, 100)
    end,
  })

  use({
    "zbirenbaum/copilot-cmp",
    after = { "copilot.lua", "nvim-cmp" },
  })

  ------------------------------------------------------
  -- COMPLETION
  ------------------------------------------------------

  use({
    "hrsh7th/nvim-cmp",
    branch = "main", --float menu
    requires = { "onsails/lspkind-nvim" },
  })
  use("hrsh7th/cmp-nvim-lsp")
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/cmp-path")
  use("hrsh7th/cmp-cmdline")
  use("saadparwaiz1/cmp_luasnip")
  use("L3MON4D3/LuaSnip")

  ------------------------------------------------------
  -- TREESITTER
  ------------------------------------------------------
  use({ "ray-x/cmp-treesitter" })
  use("JoosepAlviste/nvim-ts-context-commentstring")
  use("windwp/nvim-ts-autotag")

  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  })
  use({
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  })
  use("akinsho/bufferline.nvim")
  use({ "akinsho/toggleterm.nvim", commit = "9563a9fac8e36a6f2545732acac5b2935872db66" })
  use({
    "goolord/alpha-nvim",
    requires = { "kyazdani42/nvim-web-devicons" },
    config = function()
      require("alpha").setup(require("alpha.themes.dashboard").config)
    end,
  })
  use("folke/which-key.nvim")
  use("ahmedkhalf/project.nvim")

  -- use({
  -- 	"nvim-lualine/lualine.nvim",
  -- 	requires = { "kyazdani42/nvim-web-devicons", opt = true },
  -- })

  use({ "simrat39/rust-tools.nvim" })
  use({ "andymass/vim-matchup" })
  use({ "romgrk/nvim-treesitter-context" })
  -- use({ "machakann/vim-sandwich" })
  -- use({
  -- 	"petertriho/nvim-scrollbar",
  -- 	config = function()
  -- 		require("scrollbar").setup()
  -- 	end,
  -- })

  use({
    "lewis6991/satellite.nvim",
    config = function()
      require("satellite").setup()
    end,
  })

  -- COPILOT
  -- use({ "github/copilot.vim" })
  -- use({ "hrsh7th/cmp-copilot" })

  -------

  use({
    "beauwilliams/focus.nvim",
    config = function()
      require("focus").setup()
    end,
  })
  use({
    "sindrets/winshift.nvim",

    config = function()
      require("winshift").setup({
        highlight_moving_win = true, -- Highlight the window being moved
        focused_hl_group = "Visual", -- The highlight group used for the moving window
        moving_win_options = {
          -- These are local options applied to the moving window while it's
          -- being moved. They are unset when you leave Win-Move mode.
          wrap = false,
          cursorline = false,
          cursorcolumn = false,
          colorcolumn = "",
        },
        -- The window picker is used to select a window while swapping windows with
        -- ':WinShift swap'.
        -- A string of chars used as identifiers by the window picker.
        window_picker_chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
        window_picker_ignore = {
          -- This table allows you to indicate to the window picker that a window
          -- should be ignored if its buffer matches any of the following criteria.
          filetype = { -- List of ignored file types
            "NvimTree",
          },
          buftype = { -- List of ignored buftypes
            "terminal",
            "quickfix",
          },
        },
      })
    end,
  })
end)
