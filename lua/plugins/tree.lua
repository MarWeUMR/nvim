return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "habamax",
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "neotree")
      require("neo-tree").setup(opts)
    end,
  },
  {
    "NvChad/nvim-colorizer.lua",
    event = "User FilePost",
    config = function(_, opts)
      require("colorizer").setup(opts)

      -- execute colorizer as soon as possible
      vim.defer_fn(function()
        require("colorizer").attach_to_buffer(0)
      end, 0)
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    -- opts = function()
    --   return require("plugins.configs.treesitter")
    -- end,
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "syntax")
      dofile(vim.g.base46_cache .. "treesitter")
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  {
    "nvim-tree/nvim-web-devicons",
    -- opts = function()
    --   return { override = require("nvchad.icons.devicons") }
    -- end,
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "devicons")
      require("nvim-web-devicons").setup(opts)
    end,
  },
  -- { "lukas-reineke/indent-blankline.nvim", enabled = false },
  -- { "akinsho/bufferline.nvim", enabled = false },
  -- { "folke/trouble.nvim", enabled = false },
  -- { "echasnovski/mini.indentscope", enabled = false },
  -- { "nvim-lualine/lualine.nvim", enabled = false },
  -- { "RRethy/vim-illuminate", enabled = false },
  -- { "lewis6991/gitsigns.nvim", enabled = false },
  -- { "folke/noice.nvim", enabled = false },
  -- { "rcarriga/nvim-notify", enabled = false },
  -- { "folke/tokyonight.nvim", enabled = false },
  -- { "RRethy/vim-illuminate", enabled = false },
  -- { "RRethy/vim-illuminate", enabled = false },
  -- { "folke/tokyonight.nvim", enabled = false },
}
