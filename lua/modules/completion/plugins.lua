local plugin = require("core.pack").register_plugin
local conf = require("modules.completion.config")

plugin({
  "neovim/nvim-lspconfig",
  -- used filetype to lazyload lsp
  -- config your language filetype in here
  ft = { "lua", "rust", "ts", "php", "typescript" },
  config = conf.nvim_lsp,
})

plugin({
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  config = conf.nvim_cmp,
  requires = {
    { "hrsh7th/cmp-nvim-lsp", after = "nvim-lspconfig" },
    { "hrsh7th/cmp-path", after = "nvim-cmp" },
    { "hrsh7th/cmp-buffer", after = "nvim-cmp" },
    { "hrsh7th/cmp-cmdline", after = "nvim-cmp" },
    { "saadparwaiz1/cmp_luasnip", after = "LuaSnip" },
  },
})

plugin({ "L3MON4D3/LuaSnip", event = "InsertCharPre", config = conf.lua_snip })

plugin({ "simrat39/rust-tools.nvim" })

plugin({ "jose-elias-alvarez/typescript.nvim" })
plugin({
  "glepnir/lspsaga.nvim",
  after = "nvim-lspconfig",
  config = conf.lspsaga,
})

plugin({
  "jose-elias-alvarez/null-ls.nvim",
  config = conf.null_ls,
})

plugin({ "windwp/nvim-autopairs", event = "InsertEnter", config = conf.auto_pairs })

-- COPILOT
-- plugin({ "github/copilot.vim" })
plugin({ "zbirenbaum/copilot.lua", event = "VimEnter", config = conf.copilot })
plugin({ "zbirenbaum/copilot-cmp", after = { "copilot.lua" }, config = conf.copilot_cmp })
