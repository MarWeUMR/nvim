local config = {}
-- local lsp_config = require('modules.completion.lsp_conf')

function config.nvim_lsp()
  require("modules.completion.lspconfig")
end

function config.null_ls()
  require("modules.completion.null-ls")
end

function config.nvim_cmp()
  local cmp = require("cmp")
  cmp.setup.cmdline(":", {
    sources = {
      { name = "cmdline" },
    },
  })
  cmp.setup.cmdline("/", {
    sources = {
      { name = "buffer" },
    },
  })
  cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = "buffer" },
    },
  })

  local has_words_before = function()
    if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
      return false
    end
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
  end

  local function tab(fallback)
    if cmp.visible() and has_words_before() then
      cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
    elseif require("luasnip").expand_or_locally_jumpable() then
      require("luasnip").expand_or_jump()
    else
      fallback()
    end
  end

  local function shift_tab(fallback)
    if cmp.visible() then
      cmp.select_prev_item()
    elseif require("luasnip").jumpable(-1) then
      require("luasnip").jump(-1)
    else
      fallback()
    end
  end

  cmp.setup({
    preselect = cmp.PreselectMode.Item,
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    formatting = {
      fields = { "abbr", "kind", "menu" },
    },
    -- You can set mappings if you want
    mapping = cmp.mapping.preset.insert({
      ["<C-e>"] = cmp.config.disable,
      ["<CR>"] = cmp.mapping.confirm({ select = true }),
      ["<Tab>"] = cmp.mapping(tab, { "i", "s", "c" }),
      ["<C-j>"] = cmp.mapping(tab, { "i", "s", "c" }),
      ["<S-Tab>"] = cmp.mapping(shift_tab, { "i", "s", "c" }),
      ["<C-k>"] = cmp.mapping(shift_tab, { "i", "s", "c" }),
      ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
      ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
    }),
    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    },
    sources = {
      { name = "copilot" },
      { name = "nvim_lsp" },
      { name = "luasnip" },
      { name = "path" },
      { name = "buffer" },
    },
  })

  cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = "path" },
    }, {
      { name = "cmdline" },
    }),
  })
end

function config.lua_snip()
  local ls = require("luasnip")
  local types = require("luasnip.util.types")
  ls.config.set_config({
    history = true,
    enable_autosnippets = true,
    updateevents = "TextChanged,TextChangedI",
    ext_opts = {
      [types.choiceNode] = {
        active = {
          virt_text = { { "<- choiceNode", "Comment" } },
        },
      },
    },
  })
  require("luasnip.loaders.from_lua").lazy_load({ paths = vim.fn.stdpath("config") .. "/snippets" })
  require("luasnip.loaders.from_vscode").lazy_load()
  require("luasnip.loaders.from_vscode").lazy_load({
    paths = { "./snippets/" },
  })
end

function config.lspsaga()
  local saga = require("lspsaga")
  saga.init_lsp_saga({
    symbol_in_winbar = {
      enable = true,
    },
    code_action_lightbulb = {
      enable = false,
      enable_in_insert = true,
      cache_code_action = true,
      sign = true,
      update_time = 150,
      sign_priority = 20,
      virtual_text = true,
    },
  })
end

function config.auto_pairs()
  require("nvim-autopairs").setup({})
  local status, cmp = pcall(require, "cmp")
  if not status then
    vim.cmd([[packadd nvim-cmp]])
    cmp = require("cmp")
  end
  local cmp_autopairs = require("nvim-autopairs.completion.cmp")
  cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
end

function config.copilot()
  vim.defer_fn(function()
    require("copilot").setup()
  end, 100)
end

function config.copilot_cmp()
  require("copilot_cmp").setup({
    formatters = {
      insert_text = require("copilot_cmp.format").remove_existing,
    },
  })
end

return config
