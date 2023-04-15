local highlight, ui, t = mw.highlight, mw.styles, mw.replace_termcodes
local api, fn = vim.api, vim.fn
local border = ui.current.border

return {
  -- { "f3fora/cmp-spell", ft = { "gitcommit", "NeogitCommitMessage", "markdown", "norg", "org" } },
  { "rcarriga/cmp-dap" },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-path" },
      { "hrsh7th/cmp-buffer" },
      -- { "hrsh7th/cmp-emoji" },
      { "hrsh7th/cmp-cmdline" },
      { "dmitmel/cmp-cmdline-history" },
      { "hrsh7th/cmp-nvim-lsp-document-symbol" },
      { "saadparwaiz1/cmp_luasnip" },
      { "lukas-reineke/cmp-rg" },
      { "petertriho/cmp-git", opts = { filetypes = { "gitcommit" } } },
      { "abecodes/tabout.nvim", opts = { ignore_beginning = false, completion = false } },
    },
    config = function()
      local cmp = require "cmp"
      local luasnip = require "luasnip"
      local lspkind = require "lspkind"
      local ellipsis = ui.icons.misc.ellipsis
      local MIN_MENU_WIDTH, MAX_MENU_WIDTH = 25, math.min(50, math.floor(vim.o.columns * 0.5))

      highlight.plugin("Cmp", {
        { CmpItemAbbrMatch = { bold = true } },
        { CmpItemAbbrMatchFuzzy = { inherit = "CmpItemAbbrMatch", bold = false, italic = true } },
        { CmpItemAbbrDeprecated = { strikethrough = true, inherit = "Comment" } },
        { CmpItemMenu = { inherit = "Comment", italic = false } },
      })

      local function shift_tab(fallback)
        if not cmp.visible() then
          return fallback()
        end
        if luasnip.jumpable(-1) then
          luasnip.jump(-1)
        end
      end

      local function tab(fallback) -- make TAB behave like Android Studio
        if not cmp.visible() then
          return fallback()
        end
        if not cmp.get_selected_entry() then
          return cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
        end
        if luasnip.expand_or_jumpable() then
          return luasnip.expand_or_jump()
        end
        cmp.confirm()
      end

      local function copilot()
        api.nvim_feedkeys(fn["copilot#Accept"](t "<Tab>"), "n", true)
      end

      local window_opts = {
        border = border,
        winhighlight = "FloatBorder:FloatBorder",
      }

      cmp.setup {
        window = {
          documentation = cmp.config.window.bordered(window_opts),
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert {
          ["<C-]>"] = cmp.mapping(copilot),
          ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i" }),
          ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i" }),
          ["<C-space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm { select = false },
          ["<S-TAB>"] = cmp.mapping(shift_tab, { "i", "s", "c" }),
          ["<TAB>"] = cmp.mapping(tab, { "i", "s", "c" }),
        },
        formatting = {
          deprecated = true,
          fields = { "kind", "abbr", "menu" },
          format = lspkind.cmp_format {
            mode = "symbol",
            maxwidth = MAX_MENU_WIDTH,
            ellipsis_char = ellipsis,
            before = function(_, vim_item)
              local label, length = vim_item.abbr, api.nvim_strwidth(vim_item.abbr)
              if length < MIN_MENU_WIDTH then
                vim_item.abbr = label .. string.rep(" ", MIN_MENU_WIDTH - length)
              end
              return vim_item
            end,
            menu = {
              nvim_lsp = "[LSP]",
              nvim_lua = "[LUA]",
              cmdline = "[CMD]",
              cmdline_history = "[HIST]",
              emoji = "[EMOJI]",
              path = "[PATH]",
              neorg = "[NEORG]",
              luasnip = "[SNIP]",
              dictionary = "[DIC]",
              buffer = "[BUF]",
              spell = "[SPELL]",
              orgmode = "[ORG]",
              norg = "[NORG]",
              rg = "[RG]",
              git = "[GIT]",
            },
          },
        },
        sources = {
          { name = "nvim_lsp", group_index = 1 },
          { name = "luasnip", group_index = 1 },
          { name = "path", group_index = 1 },
          {
            name = "rg",
            keyword_length = 4,
            max_item_count = 10,
            option = { additional_arguments = "--max-depth 8" },
            group_index = 1,
          },
          {
            name = "buffer",
            options = {
              get_bufnrs = function()
                return vim.api.nvim_list_bufs()
              end,
            },
            group_index = 2,
          },
          { name = "spell", group_index = 2 },
        },
      }

      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          sources = cmp.config.sources({ { name = "nvim_lsp_document_symbol" } }, { { name = "buffer" } }),
        },
      })

      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources {
          { name = "cmdline", keyword_pattern = [=[[^[:blank:]\!]*]=] },
          { name = "path" },
          { name = "cmdline_history", priority = 10, max_item_count = 5 },
        },
      })

      cmp.setup.filetype({ "dap-repl", "dapui_watches" }, { sources = { { name = "dap" } } })
    end,
  },
  {
    -- snippet plugin
    "L3MON4D3/LuaSnip",
    dependencies = "rafamadriz/friendly-snippets",
    opts = { history = true, updateevents = "TextChanged,TextChangedI" },
    config = function(_, opts)
      require("luasnip").config.set_config(opts)

      -- vscode format
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_vscode").lazy_load { paths = vim.g.vscode_snippets_path or "" }

      -- snipmate format
      require("luasnip.loaders.from_snipmate").load()
      require("luasnip.loaders.from_snipmate").lazy_load { paths = vim.g.snipmate_snippets_path or "" }

      -- lua format
      require("luasnip.loaders.from_lua").load()
      require("luasnip.loaders.from_lua").lazy_load { paths = vim.g.lua_snippets_path or "" }

      vim.api.nvim_create_autocmd("InsertLeave", {
        callback = function()
          if
            require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
            and not require("luasnip").session.jump_active
          then
            require("luasnip").unlink_current()
          end
        end,
      })
    end,
  },
}
