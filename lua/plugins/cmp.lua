local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
    return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
    return
end

local lspKind_status_ok, lspkind = pcall(require, "lspkind")
if not lspKind_status_ok then
    return
end

local h = require("core.custom_highlights")

local api, fn = vim.api, vim.fn
local fmt = string.format
local border = core.style.current.border
local lsp_hls = core.style.lsp.highlights
local ellipsis = core.style.icons.misc.ellipsis

-- copilot adjustments
local has_words_before = function()
    if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
        return false
    end
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
end

lspkind.init()

local kind_hls = core.fold(
    function(accum, value, key)
        accum[#accum + 1] = { ["CmpItemKind" .. key] = { foreground = { from = value } } }
        return accum
    end,
    lsp_hls,
    {
        { CmpItemAbbr = { foreground = "fg", background = "NONE", italic = false, bold = false } },
        { CmpItemAbbrMatch = { foreground = { from = "Keyword" } } },
        { CmpItemAbbrDeprecated = { strikethrough = true, inherit = "Comment" } },
        { CmpItemAbbrMatchFuzzy = { italic = true, foreground = { from = "Keyword" } } },
        -- Make the source information less prominent
        {
            CmpItemMenu = {
                fg = { from = "Pmenu", attr = "bg", alter = 30 },
                italic = true,
                bold = false,
            },
        },
    }
)

require("luasnip/loaders/from_vscode").lazy_load()

h.plugin("Cmp", kind_hls)

local cmp_window = {
    border = border,
    winhighlight = table.concat({
      'Normal:NormalFloat',
      'FloatBorder:FloatBorder',
      'CursorLine:Visual',
      'Search:None',
    }, ','),
  }
local check_backspace = function()
    local col = vim.fn.col(".") - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

--   פּ ﯟ   some other good icons
local kind_icons = {
    Text = "",
    Method = "m",
    Function = "",
    Constructor = "",
    Field = "",
    Variable = "",
    Class = "",
    Interface = "",
    Module = "",
    Property = "",
    Unit = "",
    Value = "",
    Enum = "",
    Keyword = "",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "",
    Event = "",
    Operator = "",
    TypeParameter = "",
    Copilot = "",
}
-- find more here: https://www.nerdfonts.com/cheat-sheet

cmp.setup({

    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body) -- For `luasnip` users.
        end,
    },
    mapping = {
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
        ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ["<C-e>"] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        -- Accept currently selected item. If none selected, `select` first item.
        -- Set `select` to `false` to only confirm explicitly selected items.
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expandable() then
                luasnip.expand()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif check_backspace() then
                fallback()
            else
                fallback()
            end
        end, {
            "i",
            "s",
        }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, {
            "i",
            "s",
        }),
    },
    formatting = {

        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
            -- Kind icons
            vim_item.kind = string.format("%s ", kind_icons[vim_item.kind])
            vim_item.menu = ({
                copilot = "",
                nvim_lsp = "",
                buffer = "",
                path = "數",
                treesitter = "",
            })[entry.source.name]
            return vim_item
        end,
    },
    sources = {
        { name = "copilot" },
        { name = "nvim_lsp" },
        { name = "treesitter" },
        { name = "path" },
        { name = "buffer" },
        { name = "nvim_lua" },
        { name = "nvim_lsp_signature_help", priority = 10 },
    },
    confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
    },

    view = {
        entries = "custom", -- can be "custom", "wildmenu" or "native"
    },
    experimental = {
        ghost_text = true,
    },
    window = {
      completion = cmp.config.window.bordered(cmp_window),
      documentation = cmp.config.window.bordered(cmp_window),
        -- documentation = {
        --     border = border,
        --     winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
        --     scrollbar = "▏",
        -- },
        -- completion = {
        --     border = border,
        --     scrollbar = "▏",
        --     autocomplete = {
        --         require("cmp.types").cmp.TriggerEvent.InsertEnter,
        --         require("cmp.types").cmp.TriggerEvent.TextChanged,
        --     },
        -- },
    },
    style = {
        winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
    },
    sorting = {
        comparators = {
            cmp.config.compare.recently_used,
            cmp.config.compare.offset,
            cmp.config.compare.score,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
        },
    },
    preselect = cmp.PreselectMode.Item,
})
