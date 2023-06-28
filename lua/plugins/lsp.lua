return {

  -- uncomment and add lsp servers with their config to servers below
  {
    "neovim/nvim-lspconfig",
    init = function()
      -- major performance problem. disable for now
      local ok, wf = pcall(require, "vim.lsp._watchfiles")
      if ok then
        wf._watchfunc = function()
          return function() end
        end
      end

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
      inlay_hints = { enabled = true },
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

  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      vim.list_extend(opts.sources, {
        nls.builtins.formatting.stylua,
        nls.builtins.formatting.shfmt,
        nls.builtins.formatting.fish_indent,
      })
    end,
  },

  -- language specific extension modules
  { import = "plugins.lsp.servers.rust" },
  { import = "plugins.lsp.servers.lua" },
  { import = "plugins.lsp.servers.julia" },
  { import = "plugins.lsp.servers.python" },
}
