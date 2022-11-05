local plugin = require("core.pack").register_plugin
local conf = require("modules.ui.config")

plugin({
  "glepnir/zephyr-nvim",
  -- config = conf.zephyr
})

plugin({
  "folke/tokyonight.nvim",
  config = conf.tokyo,
})

plugin({
  "rebelot/kanagawa.nvim",
  -- config = conf.kanagawa
})

plugin({ "goolord/alpha-nvim", config = conf.alpha })
-- plugin({ "glepnir/dashboard-nvim", config = conf.dashboard })

plugin({
  "glepnir/galaxyline.nvim",
  branch = "main",
  config = conf.galaxyline,
  requires = "kyazdani42/nvim-web-devicons",
})

plugin({
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v2.x",
  config = conf.neo_tree,
  requires = {
    { "nvim-lua/plenary.nvim" },
    { "kyazdani42/nvim-web-devicons" }, -- not strictly required, but recommended
    { "MunifTanjim/nui.nvim" },
  },
})

plugin({ "akinsho/nvim-bufferline.lua", config = conf.nvim_bufferline, requires = "kyazdani42/nvim-web-devicons" })

plugin({ "j-hui/fidget.nvim", config = conf.fidget })

plugin({ "rcarriga/nvim-notify", config = conf.notify })

-- plugin({
--   "folke/noice.nvim",
--   config = conf.noice,
--   event = "VimEnter",
--   requires = {
--     { "MunifTanjim/nui.nvim" },
--     { "rcarriga/nvim-notify" },
--   },
-- })

plugin({ "anuvyklack/hydra.nvim", config = conf.hydra })
plugin({ "Tsuzat/NeoSolarized.nvim", config = conf.neosolarized })
plugin({ "navarasu/onedark.nvim", config = conf.onedark })
plugin({
  "olimorris/onedarkpro.nvim",
  -- config = conf.onedark_pro
})
plugin({ "themercorp/themer.lua", config = conf.themer })
plugin({ "kvrohit/mellow.nvim" })
plugin({ "catppuccin/nvim", as = "catppuccin", config = conf.cat })
