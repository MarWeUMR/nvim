local icons = core.style.icons
local highlights = require("core.highlights")

highlights.plugin("NeoTree", {
    theme = {
        ["*"] = {
            { NeoTreeNormal = { link = "PanelBackground" } },
            { NeoTreeNormalNC = { link = "PanelBackground" } },
            { NeoTreeRootName = { underline = true } },
            { NeoTreeCursorLine = { link = "Visual" } },
            { NeoTreeStatusLine = { link = "PanelSt" } },
            { NeoTreeTabActive = { bg = { from = "PanelBackground" }, bold = true } },
            {
                NeoTreeTabInactive = {
                    bg = { from = "PanelDarkBackground", alter = 15 },
                    fg = { from = "Comment" },
                },
            },
            {
                NeoTreeTabSeparatorInactive = {
                    inherit = "NeoTreeTabInactive",
                    fg = { from = "PanelDarkBackground", attr = "bg" },
                },
            },
            {
                NeoTreeTabSeparatorActive = {
                    inherit = "PanelBackground",
                    fg = { from = "Comment" },
                },
            },
        },
        horizon = {
            { NeoTreeDirectoryIcon = { fg = "#C09553" } },
            { NeoTreeWinSeparator = { link = "WinSeparator" } },
            { NeoTreeTabInactive = { bg = { from = "PanelBackground" }, fg = { from = "Comment" } } },
            { NeoTreeTabActive = { link = "VisibleTab" } },
            { NeoTreeTabSeparatorActive = { link = "VisibleTab" } },
            {
                NeoTreeTabSeparatorInactive = {
                    inherit = "NeoTreeTabInactive",
                    fg = { from = "PanelBackground", attr = "bg" },
                },
            },
        },
    },
})

vim.g.neo_tree_remove_legacy_commands = 1

require("neo-tree").setup({
    sources = {
        "filesystem",
        "buffers",
        "git_status",
    },
    source_selector = {
        winbar = true,
        separator_active = " ",
    },
    enable_git_status = true,
    enable_diagnostics = true,
    git_status_async = true,
    event_handlers = {
        {
            event = "neo_tree_buffer_enter",
            handler = function()
                highlights.set("Cursor", { blend = 100 })
            end,
        },
        {
            event = "neo_tree_buffer_leave",
            handler = function()
                highlights.set("Cursor", { blend = 0 })
            end,
        },
    },
    filesystem = {
        hijack_netrw_behavior = "open_current",
        use_libuv_file_watcher = true,
        group_empty_dirs = true,
        follow_current_file = false,
        filtered_items = {
            visible = true,
            hide_dotfiles = false,
            hide_gitignored = true,
            never_show = {
                ".DS_Store",
            },
        },
    },
    default_component_configs = {
        icon = {
            folder_empty = "",
        },
        modified = {
            symbol = icons.misc.circle .. " ",
        },
        git_status = {
            symbols = {
                added = icons.git.add,
                deleted = icons.git.remove,
                modified = icons.git.mod,
                renamed = icons.git.rename,
                untracked = "",
                ignored = "",
                unstaged = "",
                staged = "",
                conflict = "",
            },
        },
    },
    window = {
        mappings = {
            ["o"] = "toggle_node",
            ["/"] = "noop",
            ["g/"] = "fuzzy_finder",
            ["<cr>"] = "open_with_window_picker",
            ["<c-s>"] = "split_with_window_picker",
            ["<c-v>"] = "vsplit_with_window_picker",
        },
    },
})
