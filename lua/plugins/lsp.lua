return {

  -- uncomment and add lsp servers with their config to servers below
  {
    "neovim/nvim-lspconfig",
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- change a keymap
      keys[#keys + 1] = {
        "K",
        "<cmd>Lspsaga hover_doc ++keep<CR>",
        { desc = "Line Diagnostic" },
      }
      -- disable a keymap
      -- keys[#keys + 1] = { "K", false }
      -- add a keymap
      -- keys[#keys + 1] = { "H", "<cmd>echo 'hello'<cr>" }
    end,
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

  {
    "glepnir/lspsaga.nvim",
    event = "LspAttach",
    config = function()
      require("lspsaga").setup({
        symbol_in_winbar = {
          enable = false,
        },
        lightbulb = {
          enable = false,
        },
      })
    end,
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
      --Please make sure you install markdown and markdown_inline parser
      { "nvim-treesitter/nvim-treesitter" },
    },
  },
  {
    "ErichDonGubler/lsp_lines.nvim",
    event = "VeryLazy",
    config = function()
      -- activate plugin, but keep the defaults as standard,
      -- because its just too intrusive in general.
      -- activate with keymap when it's of interest
      require("lsp_lines").setup()
      vim.diagnostic.config({
        virtual_text = { spacing = 4, prefix = "●" },
        virtual_lines = false,
      })
    end,
  },
  -- language specific extension modules
  { import = "plugins.lsp.servers.rust" },
}
