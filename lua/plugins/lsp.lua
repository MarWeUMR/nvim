return {

  -- uncomment and add lsp servers with their config to servers below
  {
    "neovim/nvim-lspconfig",
    keys = function()
      return {
        {
          "<Leader>lf",
          function()
            require("lazyvim.plugins.lsp.format").format()
          end,
          { desc = "Format with LSP" },
        },
        {
          "<Leader>la",
          vim.lsp.buf.code_action,
          { desc = "Code Actions" },
        },
        {
          "<Leader>lr",
          vim.lsp.buf.rename,
          { desc = "Rename Symbol" },
        },
        {
          "<Leader>lF",
          vim.diagnostic.open_float,
          { desc = "Line Diagnostic" },
        },
      }
    end,
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {},
    },
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "rust-analyzer",
      },
    },
  },

  -- TODO: not yet working in this config
  -- investigate, what akinsho is doing differently
  -- {
  --   "lvimuser/lsp-inlayhints.nvim",
  --   init = function()
  --     akinsho.augroup("InlayHintsSetup", {
  --       event = "LspAttach",
  --       command = function(args)
  --         local id = vim.tbl_get(args, "data", "client_id") --[[@as lsp.Client]]
  --         if not id then
  --           return
  --         end
  --         local client = vim.lsp.get_client_by_id(id)
  --         require("lsp-inlayhints").on_attach(client, args.buf)
  --       end,
  --     })
  --   end,
  --   opts = {
  --     inlay_hints = {
  --       highlight = "Comment",
  --       labels_separator = " ⏐ ",
  --       parameter_hints = { prefix = "" },
  --       type_hints = { prefix = "=> ", remove_colon_start = true },
  --     },
  --   },
  -- },

  {
    "DNLHC/glance.nvim",
    event = "VeryLazy",
    opts = {
      preview_win_opts = { relativenumber = false },
      theme = { enable = true, mode = "darken" },
    },
  },

  -- language specific extension modules
  { import = "plugins.lsp.servers.rust" },
}
