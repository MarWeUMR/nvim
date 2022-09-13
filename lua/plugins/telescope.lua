local M = {}

core.telescope = {}

local function rectangular_border(opts)
    return vim.tbl_deep_extend("force", opts or {}, {
        borderchars = {
            prompt = { "─", "│", " ", "│", "┌", "┐", "│", "│" },
            results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
            preview = { "▔", "▕", "▁", "▏", "🭽", "🭾", "🭿", "🭼" },
        },
    })
end

---@param opts table?
---@return table
function core.telescope.dropdown(opts)
    return require("telescope.themes").get_dropdown(rectangular_border(opts))
end

function core.telescope.ivy(opts)
    return require("telescope.themes").get_ivy(vim.tbl_deep_extend("keep", opts or {}, {
        borderchars = {
            preview = { "▔", "▕", "▁", "▏", "🭽", "🭾", "🭿", "🭼" },
        },
    }))
end

function M.config()
    local H = require("core.custom_highlights")
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local previewers = require("telescope.previewers")
    local layout_actions = require("telescope.actions.layout")
    local icons = core.style.icons
    local P = core.style.palette
    local fmt, fn = string.format, vim.fn

    core.augroup("TelescopePreviews", {
        {
            event = "User",
            pattern = "TelescopePreviewerLoaded",
            command = "setlocal number",
        },
    })

    H.plugin("telescope", {
        theme = {
            ["*"] = {
                { TelescopePromptTitle = { bg = P.grey, fg = { from = "Directory" }, bold = true } },
                { TelescopeResultsTitle = { bg = P.grey, fg = { from = "Normal" }, bold = true } },
                { TelescopePreviewTitle = { bg = P.grey, fg = { from = "Normal" }, bold = true } },
                { TelescopePreviewBorder = { fg = P.grey, bg = { from = "PanelBackground" } } },
                { TelescopePreviewNormal = { link = "PanelBackground" } },
                { TelescopePromptPrefix = { link = "Statement" } },
                { TelescopeBorder = { foreground = P.grey } },
                { TelescopeTitle = { inherit = "Normal", bold = true } },
                {
                    TelescopeSelectionCaret = {
                        fg = { from = "Identifier" },
                        bg = { from = "TelescopeSelection" },
                    },
                },
            },
            ["horizon"] = {
                { TelescopePromptTitle = { bg = P.grey, fg = "fg", bold = true } },
                { TelescopeMatching = { bold = false, foreground = { from = "Variable", attr = "fg" } } },
                { TelescopePreviewBorder = { fg = P.grey, bg = { from = "PanelDarkBackground" } } },
                { TelescopePreviewNormal = { link = "PanelDarkBackground" } },
            },
            ["doom-one"] = {
                { TelescopeMatching = { link = "Title" } },
            },
        },
    })
    local function stopinsert(callback)
        return function(prompt_bufnr)
            vim.cmd.stopinsert()
            vim.schedule(function()
                callback(prompt_bufnr)
            end)
        end
    end

    telescope.setup({
        defaults = {
            set_env = { ["TERM"] = vim.env.TERM },
            borderchars = {
                prompt = { " ", "▕", "▁", "▏", "▏", "▕", "🭿", "🭼" },
                results = { "▔", "▕", "▁", "▏", "🭽", "🭾", "🭿", "🭼" },
                preview = { "▔", "▕", "▁", "▏", "🭽", "🭾", "🭿", "🭼" },
            },
            dynamic_preview_title = true,
            prompt_prefix = icons.misc.telescope .. " ",
            selection_caret = icons.misc.chevron_right .. " ",
            cycle_layout_list = { "flex", "horizontal", "vertical", "bottom_pane", "center" },
            mappings = {
                i = {
                    ["<C-w>"] = actions.send_selected_to_qflist,
                    ["<c-c>"] = function()
                        vim.cmd.stopinsert()
                    end,
                    ["<esc>"] = actions.close,
                    ["<c-s>"] = actions.select_horizontal,
                    ["<c-j>"] = actions.move_selection_next,
                    ["<c-k>"] = actions.move_selection_previous,
                    ["<c-e>"] = layout_actions.toggle_preview,
                    ["<c-l>"] = layout_actions.cycle_layout_next,
                    ["<c-/>"] = actions.which_key,
                    ["<Tab>"] = actions.toggle_selection,
                    ["<CR>"] = stopinsert(actions.select_default),
                },
                n = {
                    ["<C-w>"] = actions.send_selected_to_qflist,
                },
            },
            file_ignore_patterns = {
                "%.jpg",
                "%.jpeg",
                "%.png",
                "%.otf",
                "%.ttf",
                "%.DS_Store",
                "^.git/",
                "^node_modules/",
                "^site-packages/",
            },
            path_display = { "truncate" },
            winblend = 5,
            history = {
                path = vim.fn.stdpath("data") .. "/telescope_history.sqlite3",
            },
            layout_strategy = "flex",
            layout_config = {
                horizontal = {
                    preview_width = 0.55,
                },
                cursor = { -- TODO: I don't think this works but don't know why
                    width = 0.4,
                    height = function(self, _, max_lines)
                        local results = #self.finder.results
                        local PADDING = 4 -- this represents the size of the telescope window
                        local LIMIT = math.floor(max_lines / 2)
                        return (results <= (LIMIT - PADDING) and results + PADDING or LIMIT)
                    end,
                },
            },
        },
        extensions = {
            fzf = {
                override_generic_sorter = true,
                override_file_sorter = true,
            },
            frecency = {
                default_workspace = "LSP",
                show_unindexed = false, -- Show all files or only those that have been indexed
                ignore_patterns = { "*.git/*", "*/tmp/*", "*node_modules/*", "*vendor/*" },
                workspaces = {
                    conf = vim.env.DOTFILES,
                    project = vim.env.PROJECTS_DIR,
                },
            },
        },
        pickers = {
            buffers = core.telescope.dropdown({
                sort_mru = true,
                sort_lastused = true,
                show_all_buffers = true,
                ignore_current_buffer = true,
                previewer = false,
                mappings = {
                    i = { ["<c-x>"] = "delete_buffer" },
                    n = { ["<c-x>"] = "delete_buffer" },
                },
            }),
            oldfiles = core.telescope.dropdown(),
            live_grep = core.telescope.ivy({
                file_ignore_patterns = { ".git/", "%.svg", "%.lock" },
                max_results = 2000,
                on_input_filter_cb = function(prompt)
                    -- AND operator for live_grep like how fzf handles spaces with wildcards in rg
                    return { prompt = prompt:gsub("%s", ".*") }
                end,
            }),
            current_buffer_fuzzy_find = core.telescope.dropdown({
                previewer = false,
                shorten_path = false,
            }),
            colorscheme = {
                enable_preview = true,
            },
            find_files = core.telescope.ivy({
                previewer = previewers.cat.new,
            }),
            git_branches = core.telescope.dropdown(),
            git_bcommits = {
                layout_config = {
                    horizontal = {
                        preview_width = 0.55,
                    },
                },
            },
            git_commits = {
                layout_config = {
                    horizontal = {
                        preview_width = 0.55,
                    },
                },
            },
            reloader = core.telescope.dropdown(),
        },
    })

    --- This is used to activate the projects.nvim integration
    telescope.load_extension("projects")

    --- NOTE: this must be required after setting up telescope
    --- otherwise the result will be cached without the updates
    --- from the setup call
    local builtins = require("telescope.builtin")

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

    local function dotfiles()
        builtins.find_files({
            prompt_title = "dotfiles",
            cwd = vim.g.dotfiles,
        })
    end

    local function project_files(opts)
        if not pcall(builtins.git_files, opts) then
            builtins.find_files(opts)
        end
    end

    local function pickers()
        builtins.builtin({ include_extensions = true })
    end

    local function find_files()
        builtins.find_files()
    end

    local function buffers()
        builtins.buffers()
    end

    local function live_grep()
        builtins.live_grep()
    end

    local function frecency()
        require("telescope").extensions.frecency.frecency(core.telescope.dropdown({
            previewer = false,
        }))
    end

    local function notifications()
        telescope.extensions.notify.notify(core.telescope.dropdown())
    end

    local function luasnips()
        require("telescope").extensions.luasnip.luasnip(core.telescope.dropdown())
    end

    local function find_near_files()
        local cwd = require("telescope.utils").buffer_dir()
        builtins.find_files({
            prompt_title = fmt("Searching %s", fn.fnamemodify(cwd, ":~:.")),
            cwd = cwd,
        })
    end

    local function installed_plugins()
        builtins.find_files({
            prompt_title = "Installed plugins",
            cwd = vim.fn.stdpath("data") .. "/site/pack/packer",
        })
    end

    
    vim.api.nvim_exec_autocmds("User", { pattern = "TelescopeConfigComplete", modeline = false })
end

return M
