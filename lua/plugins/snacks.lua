return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      animation = { enabled = true },
      bigfile = { enabled = true },
      dim = {
        scope = { min_size = 5, max_size = 20 },
      },
      git = { enabled = true, blame_line = { count = 1 } },
      indent = { enabled = true },
      input = { enabled = true, animate = true },
      profiler = { enabled = true },
      -- picker = { enabled = true },
      dashboard = { enabled = true, example = "doom" },
      notifier = {
        enabled = true,
        timeout = 3000,
        style = "compact",
      },
      quickfile = { enabled = true, ft = "markdown" },
      statuscolumn = { enabled = true },
      scope = { enabled = true },
      scroll = { enabled = true },
      words = { enabled = true },
      styles = {
        notification = {
          wo = { wrap = true }, -- Wrap notifications
        },
      },
      terminal = { enabled = true, win = { position = "float" } },
      toggle = { enabled = true },
      zen = { enabled = true, toggles = { dim = false } },
    },
    keys = {
      {
        "<leader>s.",
        function()
          Snacks.picker.smart()
        end,
        desc = "Smart",
      },
      {
        "<leader>sB",
        function()
          Snacks.picker.buffers()
        end,
        desc = "Find open buffers",
      },
    },
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          -- Setup some globals for debugging (lazy-loaded)
          -- _G.dd = function(...)
          --   Snacks.debug.inspect(...)
          -- end
          -- _G.bt = function()
          --   Snacks.debug.backtrace()
          -- end
          -- vim.print = _G.dd -- Override print to use snacks for `:=` command

          -- Create some toggle mappings

          -- Snacks.toggle({
          --   name = "Transparency",
          --   get = function()
          --     return require("nvconfig").base46.transparency
          --   end,
          --   set = function()
          --     require("base46").toggle_transparency()
          --   end,
          -- }):map("<leader>uB")
        end,
      })
    end,
  },
}
