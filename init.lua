-- bootstrap lazy.nvim, LazyVim and your plugins

_G.USE_CHAD = false

require("config.lazy")
-- require("config.neovide")

if USE_CHAD then
  require("chadrc")
end
