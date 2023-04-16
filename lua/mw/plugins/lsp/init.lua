local opt, api, fn, cmd, fmt = vim.opt, vim.api, vim.fn, vim.cmd, string.format
local ui, border, highlight = mw.styles, mw.styles.current.border, mw.highlight

return {
  -----------------------------------------------------------------------------//
  -- LSP,Completion & Debugger {{{1
  -----------------------------------------------------------------------------//
  { "onsails/lspkind.nvim" },
  {
    {
      "williamboman/mason.nvim",
      cmd = "Mason",
      build = ":MasonUpdate",
      opts = { ui = { border = border, height = 0.8 } },
    },
    {
      "williamboman/mason-lspconfig.nvim",
      event = { "BufReadPre", "BufNewFile" },
      dependencies = {
        "mason.nvim",
        {
          "neovim/nvim-lspconfig",
          dependencies = {
            {
              "folke/neodev.nvim",
              ft = "lua",
              opts = { library = { plugins = { "nvim-dap-ui" } } },
            },
            {
              "folke/neoconf.nvim",
              cmd = { "Neoconf" },
              opts = { local_settings = ".nvim.json", global_settings = "nvim.json" },
            },
          },
          config = function()
            highlight.plugin("lspconfig", { { LspInfoBorder = { link = "FloatBorder" } } })
            require("lspconfig.ui.windows").default_options.border = border
          end,
        },
      },
      config = function()
        require("mason-lspconfig").setup { automatic_installation = true }
        require("mason-lspconfig").setup_handlers {
          function(name)
            local config = require "mw.plugins.lsp.servers"(name)
            if config then
              require("lspconfig")[name].setup(config)
            end
          end,
        }
      end,
    },
  },
  {
    "DNLHC/glance.nvim",
    opts = {
      preview_win_opts = { relativenumber = false },
      theme = { enable = true, mode = "darken" },
    },
    keys = {
      { "gD", "<Cmd>Glance definitions<CR>", desc = "lsp: glance definitions" },
      { "gR", "<Cmd>Glance references<CR>", desc = "lsp: glance references" },
      { "gY", "<Cmd>Glance type_definitions<CR>", desc = "lsp: glance type definitions" },
      { "gM", "<Cmd>Glance implementations<CR>", desc = "lsp: glance implementations" },
    },
  },
  {
    "smjonas/inc-rename.nvim",
    opts = { hl_group = "Visual", preview_empty_name = true },
    keys = {
      {
        "<leader>rn",
        function()
          return fmt(":IncRename %s", fn.expand "<cword>")
        end,
        expr = true,
        silent = false,
        desc = "lsp: incremental rename",
      },
    },
  },
  {
    "lvimuser/lsp-inlayhints.nvim",
    init = function()
      mw.augroup("InlayHintsSetup", {
        event = "LspAttach",
        command = function(args)
          local id = vim.tbl_get(args, "data", "client_id") --[[@as lsp.Client]]
          if not id then
            return
          end
          local client = vim.lsp.get_client_by_id(id)
          require("lsp-inlayhints").on_attach(client, args.buf)
        end,
      })
    end,
    opts = {
      inlay_hints = {
        highlight = "Comment",
        labels_separator = " ⏐ ",
        parameter_hints = { prefix = "" },
        type_hints = { prefix = "=> ", remove_colon_start = true },
      },
    },
  },
  {
    "simrat39/rust-tools.nvim",
    dependencies = { "nvim-lspconfig" },

    config = function()
      require("rust-tools").setup {
        tools = {
          -- how to execute terminal commands
          -- options right now: termopen / quickfix
          executor = require("rust-tools/executors").termopen,

          -- automatically call RustReloadWorkspace when writing to a Cargo.toml file.
          reload_workspace_from_cargo_toml = false,

          inlay_hints = {
            auto = true,
            only_current_line = false,
            show_parameter_hints = true,

            -- prefix for parameter hints
            -- default: "<-"
            parameter_hints_prefix = "<- ",

            -- prefix for all the other hints (type, chaining)
            -- default: "=>"
            other_hints_prefix = "=> ",

            -- whether to align to the length of the longest line in the file
            max_len_align = false,

            -- padding from the left if max_len_align is true
            max_len_align_padding = 1,

            -- whether to align to the extreme right or not
            right_align = false,

            -- padding from the right if right_align is true
            right_align_padding = 7,

            -- The color of the hints
            highlight = "Comment",
          },
        },

        -- all the opts to send to nvim-lspconfig
        server = c.default {
          -- standalone file support
          -- setting it to false may improve startup time
          standalone = false,

          settings = {
            -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
            ["rust-analyzer"] = {
              cargo = {
                features = "all",
              },
              checkOnSave = true,
              check = {
                command = "check",
                features = "all",
              },
              procMacro = {
                enable = true,
              },
            },
          },
        },
      }
    end,
  },
  {
    "saecki/crates.nvim",
    version = "*",
    event = "BufRead Cargo.toml",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      popup = { border = border },
      null_ls = { enabled = true },
    },
    config = function(_, opts)
      mw.augroup("CmpSourceCargo", {
        event = "BufRead",
        pattern = "Cargo.toml",
        command = function()
          require("cmp").setup.buffer { sources = { { name = "crates" } } }
        end,
      })
      require("crates").setup(opts)
    end,
  },

  { import = "mw.plugins.lsp.null-ls" },
}
-- }}}
