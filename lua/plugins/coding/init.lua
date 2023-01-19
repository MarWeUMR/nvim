return {
  -- {
  --   "hrsh7th/nvim-minx",
  --   event = "VeryLazy",
  -- },
  -- {
  --   "codota/tabnine-nvim",
  --   event = "VeryLazy",
  --   build = "./dl_binaries.sh",
  --   opts = {
  --     disable_auto_comment = true,
  --     -- accept_keymap = "<Tab>",
  --     -- dismiss_keymap = "<C-]>",
  --     debounce_ms = 300,
  --     suggestion_color = { gui = "#808080", cterm = 244 },
  --     execlude_filetypes = { "TelescopePrompt" },
  --   },
  --   config = function(_, opts)
  --     require("tabnine").setup(opts)
  --   end,
  -- },
  {
    "onsails/lspkind.nvim",
  },
  {
    "hrsh7th/nvim-cmp",
    version = false,
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      -- "lukas-reineke/cmp-rg",
      -- { "tzachar/cmp-tabnine", build = "./install.sh" },
    },
    opts = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      -- require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          sources = cmp.config.sources({ { name = "nvim_lsp_document_symbol" } }, { { name = "buffer" } }),
        },
      })

      -- cmp.setup.cmdline(":", {
      --   sources = cmp.config.sources({
      --     { name = "cmdline", keyword_pattern = [=[[^[:blank:]\!]*]=] },
      --     { name = "path" },
      --     { name = "cmdline_history", priority = 10, max_item_count = 5 },
      --   }),
      -- })

      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      return {
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
          ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
          ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
          ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
          ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
            -- they way you will only jump inside the snippet region
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif require("luasnip").jumpable(-1) then
              require("luasnip").jump(-1)
            else
              vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(fallback(), true, false, true), "n", false)
            end
          end, {
            "i",
            "s",
          }),
        }),
        sources = cmp.config.sources({
          {
            name = "nvim_lsp",
          },
          -- { name = "cmp_tabnine" },
          { name = "buffer" },
          { name = "path" },
          { name = "nvim_lsp_signature_help" },
          -- {
          --   name = "rg",
          --   keyword_length = 4,
          --   max_item_count = 10,
          --   option = { additional_arguments = "--max-depth 8" },
          -- },
          { name = "luasnip" },
        }),
        formatting = {
          deprecated = true,
          fields = { "kind", "abbr", "menu" },
          format = function(entry, vim_item)
            local MAX = math.floor(vim.o.columns * 0.5)
            if #vim_item.abbr >= MAX then
              vim_item.abbr = vim_item.abbr:sub(1, MAX) .. "…"
            end

            local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
            local strings = vim.split(kind.kind, "%s", { trimempty = true })

            kind.kind = " " .. (strings[1] or "") .. " "
            kind.menu = "    (" .. (strings[2] or "") .. ")"

            return kind
          end,
        },
        window = {

          winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
          col_offset = -3,
          side_padding = 0,
        },
        experimental = {
          ghost_text = {
            hl_group = "LspCodeLens",
          },
        },
        preselect = cmp.PreselectMode.Item,
      }
    end,
  },

  -- copilot
  {
    "zbirenbaum/copilot.lua",
    enabled = true,
    event = "VeryLazy",
    config = true,
  },
}
