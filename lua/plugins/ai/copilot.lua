return {
  {
    "zbirenbaum/copilot.lua",
    opts = function(_, opts)
      table.insert(opts.panel, {
        enabled = true,
        auto_refresh = true,
      })
      table.insert(opts.panel, {
        enabled = true,
        auto_trigger = true,
        accept = false, -- disable built-in keymapping
      })
    end,
  },
}
