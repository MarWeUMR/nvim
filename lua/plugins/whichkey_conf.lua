return function()
    require("core.custom_highlights").plugin("whichkey", {
        theme = {
            ["*"] = {
                { WhichkeyFloat = { link = "NormalFloat" } },
            },
            horizon = {
                { WhichKeySeparator = { link = "Todo" } },
            },
        },
    })

    local wk = require("which-key")

    local builtins = require("telescope.builtin")
    local telescope_themes = require("telescope.themes")
    local setup = {}
    local mappings = {

        --         --------------------
        --       ----  RANDOM STUFF  ----
        --         --------------------

        ["a"] = { "<cmd>Alpha<cr>", "Alpha" },
        ["b"] = {
            builtins.buffers(telescope_themes.get_dropdown({ previewer = true })),
            "Buffers",
        },
        ["e"] = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
        ["o"] = { ":AerialToggle<cr>", "Outline" },
        ["F"] = { "<cmd>Telescope live_grep theme=ivy<cr>", "Find Text" },
        ["P"] = { "<cmd>Telescope projects<cr>", "Projects" },
        ["z"] = { "<cmd>ZenMode<cr>", "Zen-Mode" },

        --         -----------------
        --       ----  TELESCOPE  ----
        --         -----------------

        f = {
            name = "file",
            f = { "<cmd>Telescope find_files<cr>", "Find File" }, -- create a binding with label
            F = { "<cmd>Telescope live_grep theme=ivy<cr>", "Find Text" },
            b = { builtins.current_buffer_fuzzy_find, "current buffer fuzzy find" },
            v = {
                name = "+vim",
                h = { builtins.highlights, "highlights" },
                a = { builtins.autocommands, "autocommands" },
                o = { builtins.vim_options, "options" },
            },
            l = {
                name = "+lsp",
                d = { builtins.diagnostics, "telescope: workspace diagnostics" },
                o = { builtins.lsp_document_symbols, "telescope: document symbols" },
                s = { builtins.lsp_dynamic_workspace_symbols, "telescope: workspace symbols" },
            },
            c = { "<cmd>Telescope colorscheme<cr>", "Colorschemes" },
            r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
            R = { "<cmd>Telescope registers<cr>", "Registers" },
            k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
            C = { "<cmd>Telescope commands<cr>", "Commands" },
        },

        --         -----------
        --       ----  LSP  ----
        --         -----------

        l = {
            name = "LSP",
            a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code action" },
            s = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Signature help" },
            h = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Hover" },
            d = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "Declaration" },
            i = { "<cmd>lua vim.lsp.buf.implementation()<cr>", "Implementation" },
            D = { "<cmd>lua vim.lsp.buf.definition()<cr>", "Definition" },
            R = { "<cmd>lua vim.lsp.buf.references()<cr>", "References" },
            r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
            f = { "<cmd>lua vim.lsp.buf.format()<cr>", "Format" },
            F = { "<cmd>lua vim.diagnostic.open_float()<cr>", "Open float" },
        },

        --         --------------
        --       ----  WINDOW  ----
        --         --------------

        w = {
            name = "Window",
            v = { "<C-W>v", "VSplit" },
            h = { "<C-W>s", "HSplit" },
            q = { "<cmd>:q<CR>", "Quit" },
        },

        --         -----------
        --       ----  GIT  ----
        --         -----------

        g = {
            name = "Git",
            g = { "<cmd>lua __fterm_lazygit()<CR>", "Lazygit" },
            j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
            k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
            l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
            p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
            r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
            R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
            s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
            u = {
                "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
                "Undo Stage Hunk",
            },
            o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
            b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
            c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
            d = { "<cmd>DiffviewOpen<cr>", "Open Diffview" },
            D = { "<cmd>DiffviewClose<cr>", "Close Diffview" },
            h = { "<cmd>DiffviewFileHistory<cr>", "Browse file history" },
            e = { "<cmd>DiffviewToggleFiles<cr>", "Toggle diffview file explorer" },
        },

        --         ----------------------
        --       ----  TROUBLE TOGGLE  ----
        --         ----------------------

        x = {
            x = { "<cmd>TroubleToggle<cr>", "Trouble Toggle" },
            w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Workspace Diagnostics" },
            d = { "<cmd>TroubleToggle document_diagnostics<cr>", "Document Diagnostics" },
            q = { "<cmd>TroubleToggle quickfix<cr>", "Quickfix" },
            l = { "<cmd>TroubleToggle loclist<cr>", "Loc List" },
            r = { "<cmd>TroubleToggle lsp_references<cr>", "LSP References" },
        },
    }
    local opts = {
        prefix = "<leader>",
    }

    wk.setup()
    wk.register(mappings, opts)
end
