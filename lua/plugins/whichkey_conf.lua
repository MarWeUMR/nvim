local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
    return
end

local setup = {
    plugins = {
        marks = true, -- shows a list of your marks on ' and `
        registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        spelling = {
            enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
            suggestions = 20, -- how many suggestions should be shown in the list?
        },
        -- the presets plugin, adds help for a bunch of default keybindings in Neovim
        -- No actual key bindings are created
        presets = {
            operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
            motions = false, -- adds help for motions
            text_objects = false, -- help for text objects triggered after entering an operator
            windows = true, -- default bindings on <c-w>
            nav = true, -- misc bindings to work with windows
            z = true, -- bindings for folds, spelling and others prefixed with z
            g = true, -- bindings for prefixed with g
        },
    },
    -- add operators that will trigger motion and text object completion
    -- to enable all native operators, set the preset / operators plugin above
    -- operators = { gc = "Comments" },
    key_labels = {
        -- override the label used to display some keys. It doesn't effect WK in any other way.
        -- For example:
        -- ["<space>"] = "SPC",
        -- ["<cr>"] = "RET",
        -- ["<tab>"] = "TAB",
    },
    icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        separator = "➜", -- symbol used between a key and it's label
        group = "+", -- symbol prepended to a group
    },
    popup_mappings = {
        scroll_down = "<c-d>", -- binding to scroll down inside the popup
        scroll_up = "<c-u>", -- binding to scroll up inside the popup
    },
    window = {
        border = "rounded", -- none, single, double, shadow
        position = "bottom", -- bottom, top
        margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
        padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
        winblend = 0,
    },
    layout = {
        height = { min = 4, max = 25 }, -- min and max height of the columns
        width = { min = 20, max = 50 }, -- min and max width of the columns
        spacing = 3, -- spacing between columns
        align = "left", -- align columns left, center or right
    },
    ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
    hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
    show_help = true, -- show help message on the command line when the popup is visible
    triggers = "auto", -- automatically setup triggers
    -- triggers = {"<leader>"} -- or specify a list manually
    triggers_blacklist = {
        -- list of mode / prefixes that should never be hooked by WhichKey
        -- this is mostly relevant for key maps that start with a native binding
        -- most people should not need to change this
        i = { "j", "k" },
        v = { "j", "k" },
    },
}

local opts = {
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
}

local builtins = require("telescope.builtin")

local function pickers()
    builtins.builtin({ include_extensions = true })
end

local function delta_opts(opts, is_buf)
    local previewers = require("telescope.previewers")
    local delta = previewers.new_termopen_previewer({
        get_command = function(entry)
            local args = {
                "git",
                "-c",
                "core.pager=delta",
                "-c",
                "delta.side-by-side=false",
                "diff",
                entry.value .. "^!",
            }
            if is_buf then
                vim.list_extend(args, { "--", entry.current_file })
            end
            return args
        end,
    })
    opts = opts or {}
    opts.previewer = {
        delta,
        previewers.git_commit_message.new(opts),
    }
    return opts
end

local function delta_git_commits(opts)
    builtins.git_commits(delta_opts(opts))
end

local function delta_git_bcommits(opts)
    builtins.git_bcommits(delta_opts(opts, true))
end

local function nvim_config()
    builtins.find_files({
        prompt_title = "~ nvim config ~",
        cwd = vim.fn.stdpath("config"),
        file_ignore_patterns = {
            ".git/.*",
            "dotbot/.*",
            "zsh/plugins/.*",
        },
    })
end

local mappings = {
    ["a"] = { "<cmd>Alpha<cr>", "Alpha" },
    ["b"] = {
        "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
        "Buffers",
    },
    ["e"] = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
    ["o"] = { ":AerialToggle<cr>", "Outline" },
    ["q"] = { "<cmd>q!<CR>", "Quit" },
    ["c"] = { "<cmd>Bdelete!<CR>", "Close Buffer" },
    ["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
    ["f"] = {
        "<cmd>Telescope find_files<cr>",
        "Find files",
    },
    ["F"] = { "<cmd>Telescope live_grep theme=ivy<cr>", "Find Text" },
    ["P"] = { "<cmd>Telescope projects<cr>", "Projects" },
    ["z"] = { "<cmd>ZenMode<cr>", "Zen-Mode" },
    t = {
        name = "Telescope",
        p = { "<cmd>Telescope projects<cr>", "Projects" },
        a = { pickers, "builtins" },
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
        r = { builtins.resume, "resume last picker" },
        ["?"] = { builtins.help_tags, "help" },
        f = { builtins.find_files, "find files" },
        --h = { frecency, "Most (f)recently used files" },
        o = { builtins.buffers, "buffers" },
        s = { builtins.live_grep, "live grep" },
        c = { nvim_config, "nvim config" },
    },
    w = {
        name = "Window",
        v = { "<C-W>v", "VSplit" },
        h = { "<C-W>s", "HSplit" },
        q = { "<cmd>:q<CR>", "Quit" },
    },

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
        d = { "<cmd>DiffviewOpen<cr>", "Open Diffview"},
        D = { "<cmd>DiffviewClose<cr>", "Close Diffview"},
        h = { "<cmd>DiffviewFileHistory<cr>", "Browse file history"},
        e = { "<cmd>DiffviewToggleFiles<cr>", "Toggle diffview file explorer"},
    },
    x = {

        x = { "<cmd>TroubleToggle<cr>", "Trouble Toggle" },
        w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Workspace Diagnostics" },
        d = { "<cmd>TroubleToggle document_diagnostics<cr>", "Document Diagnostics" },
        q = { "<cmd>TroubleToggle quickfix<cr>", "Quickfix" },
        l = { "<cmd>TroubleToggle loclist<cr>", "Loc List" },
        r = { "<cmd>TroubleToggle lsp_references<cr>", "LSP References" },
    },
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
    s = {
        name = "Search",
        b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
        c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
        h = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Search here" },
        M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
        r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
        R = { "<cmd>Telescope registers<cr>", "Registers" },
        k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
        C = { "<cmd>Telescope commands<cr>", "Commands" },
        p = {
            "<cmd>lua require('telescope.builtin.internal').colorscheme({enable_preview = true})<cr>",
            "Colorscheme with Preview",
        },
    },
}

local vopts = {
    mode = "v", -- VISUAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
}
local vmappings = {
    ["/"] = { '<ESC><CMD>lua require("Comment.api").toggle_linewise_op(vim.fn.visualmode())<CR>', "Comment" },
}

which_key.setup(setup)
which_key.register(mappings, opts)
which_key.register(vmappings, vopts)
