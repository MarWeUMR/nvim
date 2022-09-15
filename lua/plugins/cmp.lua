return function()
    local cmp = require("cmp")

    -- local copilot = require("copilot_cmp")
    local h = require("core.custom_highlights")
    local api, fn = vim.api, vim.fn
    local fmt = string.format
    local t = core.replace_termcodes
    local border = core.style.current.border
    local lsp_hls = core.style.lsp.highlights
    local ellipsis = core.style.icons.misc.ellipsis

    local luasnip = require("luasnip")

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

    h.plugin("Cmp", kind_hls)

    local function tab(fallback)
        if cmp.visible() then
            cmp.select_next_item()
        elseif luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
        else
            fallback()
        end
    end

    local function shift_tab(fallback)
        if cmp.visible() then
            cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
        else
            fallback()
        end
    end

    local cmp_window = {
        border = border,
        winhighlight = table.concat({
            "Normal:NormalFloat",
            "FloatBorder:FloatBorder",
            "CursorLine:Visual",
            "Search:None",
        }, ","),
    }
    cmp.setup({

        -- cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done()),
        -- sorting = {
        --     priority_weight = 2,
        --     comparators = {
        --         copilot.comparators.prioritize,
        --
        --         -- Below is the default comparitor list and order for nvim-cmp
        --         cmp.config.compare.offset,
        --         -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
        --         cmp.config.compare.exact,
        --         cmp.config.compare.score,
        --         cmp.config.compare.recently_used,
        --         cmp.config.compare.locality,
        --         cmp.config.compare.kind,
        --         cmp.config.compare.sort_text,
        --         cmp.config.compare.length,
        --         cmp.config.compare.order,
        --     },
        -- },
        experimental = { ghost_text = false },
        preselect = cmp.PreselectMode.None,
        window = {
            completion = cmp.config.window.bordered(cmp_window),
            documentation = cmp.config.window.bordered(cmp_window),
        },
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body)
            end,
        },
        mapping = {
            ["<Tab>"] = cmp.mapping(tab, { "i", "s", "c" }),
            ["<C-j>"] = cmp.mapping(tab, { "i", "s", "c" }),
            ["<S-Tab>"] = cmp.mapping(shift_tab, { "i", "s", "c" }),
            ["<C-k>"] = cmp.mapping(shift_tab, { "i", "s", "c" }),
            ["<C-q>"] = cmp.mapping({
                i = cmp.mapping.abort(),
                c = cmp.mapping.close(),
            }),
            ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
            ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
            ["<C-space>"] = cmp.mapping.complete(),
            ["<CR>"] = cmp.mapping.confirm({ select = false }), -- If nothing is selected don't complete
        },
        formatting = {
            deprecated = true,
            fields = { "abbr", "kind", "menu" },
            format = function(entry, vim_item)
                local MAX = math.floor(vim.o.columns * 0.5)
                if #vim_item.abbr >= MAX then
                    vim_item.abbr = vim_item.abbr:sub(1, MAX) .. ellipsis
                end
                vim_item.kind = fmt("%s %s", core.style.current.lsp_icons[vim_item.kind], vim_item.kind)
                vim_item.menu = ({
                    nvim_lsp = "[LSP]",
                    nvim_lua = "[Lua]",
                    emoji = "[E]",
                    path = "[Path]",
                    neorg = "[N]",
                    luasnip = "[SN]",
                    dictionary = "[D]",
                    buffer = "[B]",
                    spell = "[SP]",
                    cmdline = "[Cmd]",
                    cmdline_history = "[Hist]",
                    orgmode = "[Org]",
                    norg = "[Norg]",
                    rg = "[Rg]",
                    git = "[Git]",
                    copilot = "[CoPi]",
                })[entry.source.name]
                return vim_item
            end,
        },
        sources = cmp.config.sources({
            { name = "copilot" },
            { name = "nvim_lsp" },
            { name = "luasnip" },
            { name = "path" },
            -- {
            --     name = "rg",
            --     keyword_length = 4,
            --     max_item_count = 10,
            --     option = { additional_arguments = "--max-depth 8" },
            -- },
        }, {
            -- {
            --     name = "buffer",
            --     options = {
            --         get_bufnrs = function()
            --             return vim.api.nvim_list_bufs()
            --         end,
            --     },
            -- },
            -- { name = "spell" },
        }),
    })
end
