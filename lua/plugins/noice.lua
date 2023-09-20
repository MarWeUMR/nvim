--- This file provides overrides for the default lazyvim noice configuration.
--- The configuration modifies the behavior of the `noice.nvim`.
--- Specifically, it adds additional filtering rules to suppress certain notifications.
---
return {
  "folke/noice.nvim", -- Specifies the plugin being configured

  -- Function to set options for the `noice.nvim` plugin
  opts = function(_, opts)
    -- Helper function to initialize the `routes` table if it's not present
    local function setOpts()
      -- If `routes` is not defined in `opts`, initialize it as an empty table
      if opts.routes == nil then
        opts.routes = {}
        return
      end
    end

    -- Call the helper function to ensure `routes` is initialized
    setOpts()

    -- Add custom filtering rules to the `routes` table
    table.insert(opts.routes, {
      -- Skip warnings related to "for_each_child"
      -- Used until deprecated treesitter function is accounted for in rainbow brackets plugin
      filter = {
        event = "notify",
        kind = "warn",
        find = "for_each_child",
      },
      opts = { skip = true },
    })
  end,
}
