local plugin = require("core.pack").register_plugin
local conf = require("modules.tools.config")

plugin({
  "nvim-lua/plenary.nvim",
})

plugin({
  "nvim-telescope/telescope.nvim",
  config = conf.telescope,
  requires = {
    { "nvim-lua/plenary.nvim" },
    { "nvim-telescope/telescope-fzy-native.nvim" },
  },
})

plugin({
  "ggandor/leap.nvim",
  config = conf.leap,
})

plugin({
  "ggandor/flit.nvim",
  config = conf.flit,
})

plugin({
  "max397574/better-escape.nvim",
  config = conf.better_escape,
})

plugin({
  "numToStr/Comment.nvim",
  config = conf.comments,
})

plugin({
  "lewis6991/gitsigns.nvim",
event = "BufRead",
  config = conf.gitsigns,
})

-- dap
plugin({
  "rcarriga/nvim-dap-ui",
  config = conf.dap_ui,
})

plugin({
  "mfussenegger/nvim-dap",
  config = conf.dap,
  requires = {
    { "theHamsta/nvim-dap-virtual-text" },
    { "rcarriga/nvim-dap-ui" },
  },
})

plugin({
  "folke/trouble.nvim",
  requires = "kyazdani42/nvim-web-devicons",
  config = conf.trouble,
})

plugin({"akinsho/toggleterm.nvim", tag = '*', config = conf.toggleterm})
