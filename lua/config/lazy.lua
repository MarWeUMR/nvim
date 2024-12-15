local myScheme = "tokyonight"

if _G.USE_CHAD then
  vim.g.base46_cache = vim.fn.stdpath("data") .. "/base46_cache/"
  myScheme = "nvchad"
end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

local mySpec = {
  "nvim-lua/plenary.nvim",
  _G.USE_CHAD and {
    "nvchad/ui",
    dependencies = {
      "nvchad/volt",
    },
    config = function()
      require("nvchad")
    end,
  } or {},
  _G.USE_CHAD and {
    "nvchad/base46",
    lazy = true,
    build = function()
      require("base46").load_all_highlights()
    end,
  } or {},

  -- add LazyVim and import its plugins
  { "LazyVim/LazyVim", import = "lazyvim.plugins", opts = { colorscheme = myScheme } },
  -- import/override with your plugins
  { import = "plugins" },
  { import = "plugins.ai" },
}

-- merge both specs to one final table
require("lazy").setup({
  spec = mySpec,
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  install = { colorscheme = { myScheme } },
  debug = false,
  -- install = { colorscheme = { "tokyonight", "habamax" } },
  checker = { enabled = true }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

if _G.USE_CHAD then
  for _, v in ipairs(vim.fn.readdir(vim.g.base46_cache)) do
    dofile(vim.g.base46_cache .. v)
  end
end
